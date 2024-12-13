# Helper function to transform dates
import holidays
import pandas as pd
import yfinance as yf
import json
import joblib

from datetime import datetime, timedelta
from earnings import load_historical_earnings_to_dataframe, load_upcoming_earnings_to_dataframe

# Define your country (e.g., US)
us_holidays = holidays.US()

def is_holiday(date):
    return int(date in us_holidays)

def transform_date(date):
    date = pd.to_datetime(date)
    return {
        'year': date.year,
        'month': date.month,
        'day': date.day,
        'weekday': date.weekday(),  # 0=Monday, 6=Sunday
        'is_day_before_a_holiday': is_holiday(date - pd.Timedelta(days=1)),
        'is_day_after_a_holiday': is_holiday(date + pd.Timedelta(days=1))
    }
    
def get_dynamic_features(symbol, today):
    # Load historical earnings data
    historical_df = load_historical_earnings_to_dataframe(symbol)
    if historical_df.empty:
        print(f"No historical earnings data available for {symbol}.")
        return None

    # Load upcoming earnings data
    upcoming_df = load_upcoming_earnings_to_dataframe(symbol)
    if upcoming_df.empty:
        print(f"No upcoming earnings data available for {symbol}.")
        return None

    for column in historical_df.columns:
      if column in ['reportedEPS', 'estimatedEPS', 'surprise', 'surprisePercentage']:
        # Convert to numeric, treating "None" or invalid values as NaN
        historical_df[column] = pd.to_numeric(historical_df[column], errors='coerce')
        # Forward-fill NaN values
        historical_df[column] = historical_df[column].fillna(method='ffill')

        
    # print(historical_df.info())

    # Parse reported EPS, estimated EPS, and surprise data from the most recent earnings report
    recent_earnings = historical_df.iloc[-1]  # Assuming data is sorted by date
    reported_eps = float(recent_earnings['reportedEPS'])
    estimated_eps = float(recent_earnings['estimatedEPS'])
    surprise = float(recent_earnings['surprise'])
    surprise_percentage = float(recent_earnings['surprisePercentage'])
    
    # print(f"{recent_earnings=}")
    # print(f"{reported_eps=}")
    # print(f"{estimated_eps=}")
    # print(f"{surprise=}")
    # print(f"{surprise_percentage=}")

    # Calculate days_after_previous_earning
    reported_date = pd.to_datetime(recent_earnings['reportedDate'])
    days_after_previous_earning = (today - reported_date).days

    # Parse next earnings date and calculate days_to_next_earning
    next_earnings_date = pd.to_datetime(upcoming_df.iloc[0]['Earnings Date Start'])
    days_to_next_earning = (next_earnings_date - today).days

    # Return the calculated features
    return {
        "reportedEPS": reported_eps,
        "estimatedEPS": estimated_eps,
        "surprise": surprise,
        "surprisePercentage": surprise_percentage,
        "days_after_previous_earning": days_after_previous_earning,
        "days_to_next_earning": days_to_next_earning
    }

def get_encoded_ticker(symbol):
  # Load the ticker mapping from the JSON file
  with open("ticker_mapping.json", "r") as file:
      ticker_mapping = json.load(file)

  return ticker_mapping.get(symbol)
   
def get_input_data_for_predictor(symbol, date):
    
  # Fetch historical data for NVDA
  end_date = datetime.now().date()
  start_date = end_date - timedelta(days=30)  # Ensure enough historical data for moving averages

  data = yf.download(symbol, start=start_date, end=end_date)
  data.reset_index(inplace=True)
  data['Date'] = pd.to_datetime(data['Date'])
  data.rename(columns={'Adj Close': 'Adj_Close'}, inplace=True)

  # Get today's date and transform it using transform_date
  date_features = transform_date(date)
  features = get_dynamic_features(symbol, date)
  ticket_encoded = get_encoded_ticker(symbol)

  # Generate the feature dictionary
  data = {
      "Close": data.iloc[-1]["Close"],
      "High": data.iloc[-1]["High"],
      "Low": data.iloc[-1]["Low"],
      "Open": data.iloc[-1]["Open"],
      "Volume": data.iloc[-1]["Volume"],
      "Ticker_Encoded": ticket_encoded,  # Assuming NVDA was encoded as 8 during training
      "year": date_features["year"],
      "month": date_features["month"],
      "day": date_features["day"],
      "weekday": date_features["weekday"],
      "is_day_before_a_holiday": date_features["is_day_before_a_holiday"],
      "is_day_after_a_holiday": date_features["is_day_after_a_holiday"],
      "reportedEPS": features["reportedEPS"],     # Example value, replace with actual data
      "estimatedEPS": features["estimatedEPS"],   # Example value, replace with actual data
      "surprise": features["surprise"],           # Example value, replace with actual data
      "surprisePercentage": features["surprisePercentage"],   # Example value, replace with actual data
      "days_after_previous_earning": features["days_after_previous_earning"],  # Calculate from actual earnings date
      "days_to_next_earning": features["days_to_next_earning"],                # Calculate from actual earnings date
      "ma_5": data["Adj_Close"].rolling(window=5).mean().iloc[-1],
      "volatility_5": data["Adj_Close"].rolling(window=5).std().iloc[-1],
      "ma_10": data["Adj_Close"].rolling(window=10).mean().iloc[-1],
      "volatility_10": data["Adj_Close"].rolling(window=10).std().iloc[-1],
      "ma_20": data["Adj_Close"].rolling(window=20).mean().iloc[-1] if len(data) >= 20 else 0,
      "volatility_20": data["Adj_Close"].rolling(window=20).std().iloc[-1] if len(data) >= 20 else 0,
      "pct_change": (data.iloc[-1]["Close"] - data.iloc[-2]["Close"]) / data.iloc[-2]["Close"] * 100,
      "high_low_spread": data.iloc[-1]["High"] - data.iloc[-1]["Low"]
  }

  return data

def predict(symbol, date):
  # Most recent data for the stock:
  data = yf.download(symbol)  
  data.reset_index(inplace=True)

  # Prepare today's features by extracting scalar values explicitly
  result = { 
      "most_recent_data": {
        "date": data["Date"].iloc[-1],  # Extract the date scalar
        "close": data["Close"].iloc[-1][symbol],  # Extract the close price scalar
        "adj_close": data["Adj Close"].iloc[-1][symbol]  # Extract the adjusted close price scalar]
      }
  }

  # Display result in a structured and readable format
  print(f"Stock Symbol: {symbol}")
  print(f"Date: {result['most_recent_data']['date']}")
  print(f"Close Price: ${result['most_recent_data']['close']:.2f}")
  print(f"Adjusted Close Price: ${result['most_recent_data']['adj_close']:.2f}")

  # Load the pre-trained scaler and models
  scaler = joblib.load("scaler.pkl")  # Only used if models require scaled input
  model_rf = joblib.load("random_forest_model.pkl")
  model_lr = joblib.load("linear_regression_model.pkl")  # Linear Regression model

  # Fetch and prepare input data
  input_data = get_input_data_for_predictor(symbol, date=date)

  # Convert to DataFrame for consistency
  input_data_df = pd.DataFrame([input_data])

  # Align feature columns with training data
  # Replace 'X_train.columns' with the actual column order used during training
  input_data_df = input_data_df[input_data_df.columns]

  # Transform the data using the scaler for models that require scaling
  input_data_scaled = scaler.transform(input_data_df)

  # Make predictions
  predicted_adj_close_rf = model_rf.predict(input_data_df)  # Random Forest (no scaling)
  predicted_adj_close_lr = model_lr.predict(input_data_scaled)  # Linear Regression (requires scaling)

  # Print predictions
  print(f"Predicted Adjusted Close for {symbol} on {date.date()} (Random Forest): {predicted_adj_close_rf[0]}")
  print(f"Predicted Adjusted Close for {symbol} on {date.date()} (Linear Regression): {predicted_adj_close_lr[0]}")
  result["ramdom_forest"] = predicted_adj_close_rf[0]
  result["linear_regression"] = predicted_adj_close_lr[0]
  result["date"] = date.date()
  
  return result
 
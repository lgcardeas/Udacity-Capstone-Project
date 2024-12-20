import os
import json
import requests
import pandas as pd
from datetime import datetime
import yfinance as yf

# Constants
# API_KEY = '5ZK4FENWU14Q148B'
API_KEY = 'SCWWYD4A104AYXGK' # PREMIUN

BASE_URL = 'https://www.alphavantage.co/query'
SAVE_HISTORICAL_EARNINGS_DIR = './historical_earnings_data'
SAVE_UPCOMING_EARNINGS_DIR = './upcoming_earnings_data'

# Ensure directories exist
os.makedirs(SAVE_HISTORICAL_EARNINGS_DIR, exist_ok=True)
os.makedirs(SAVE_UPCOMING_EARNINGS_DIR, exist_ok=True)

# -------------------------------------
# Historical Earnings Functions
# -------------------------------------

def fetch_historical_earnings(symbol):
    """
    Fetch historical earnings using Alpha Vantage API.
    :param symbol: Stock ticker symbol
    :return: JSON response with earnings data or None
    """
    url = f"{BASE_URL}?function=EARNINGS&symbol={symbol}&apikey={API_KEY}"
    print(f"LEGC: Fetching historical earnings for {symbol} from Alpha Vantage...")
    response = requests.get(url)
    if response.status_code == 200:
        print(f"LEGC: Successfully fetched data for {symbol}.")
        return response.json()  # Returns full JSON response
    else:
        print(f"LEGC: Error fetching historical earnings for {symbol}: {response.status_code}")
        return None

def build_historical_earnings(symbol):
    """
    Fetch and save historical earnings data for a symbol.
    :param symbol: Stock ticker symbol
    """
    print(f"LEGC: Building historical earnings for {symbol}...")
    earnings_data = fetch_historical_earnings(symbol)
    if earnings_data:
        file_path = os.path.join(SAVE_HISTORICAL_EARNINGS_DIR, f"{symbol}.json")
        with open(file_path, 'w') as file:
            json.dump(earnings_data, file, indent=4)
        print(f"LEGC: Historical earnings data saved for {symbol} at {file_path}.")
    else:
        print(f"LEGC: Failed to fetch historical earnings for {symbol}.")

def load_historical_earnings_to_dataframe(symbol):
    """
    Load historical earnings data for a single ticker into a pandas DataFrame.
    Fetch the data if the file is missing.
    :param symbol: Stock ticker symbol
    :return: pandas DataFrame of earnings data
    """
    
    file_path = os.path.join(SAVE_HISTORICAL_EARNINGS_DIR, f"{symbol}.json")

    # Fetch and save if not already present
    if not os.path.exists(file_path):
        print(f"LEGC: No local historical data found for {symbol}. Fetching from API...")
        build_historical_earnings(symbol)

    # Load the JSON file
    with open(file_path, 'r') as file:
        earnings_data = json.load(file)

    # Parse data into DataFrame
    if 'quarterlyEarnings' in earnings_data:
        df = pd.DataFrame(earnings_data['quarterlyEarnings'])
        df['symbol'] = symbol  # Add symbol column for identification
        print(f"LEGC: Loaded historical earnings data for {symbol} into DataFrame.")
        return df
    else:
        print(f"LEGC: No quarterly earnings data found for {symbol}.")
        return pd.DataFrame()

def load_all_historical_earnings_to_dataframe(symbols=[]):
    """
    Load all historical earnings data for multiple tickers into a single DataFrame.
    Fetch data for missing tickers if necessary.
    :param symbols: List of stock ticker symbols
    :return: pandas DataFrame of combined historical earnings data
    """
    all_data = []

    # Ensure the directory exists
    if not os.path.exists(SAVE_HISTORICAL_EARNINGS_DIR):
        os.makedirs(SAVE_HISTORICAL_EARNINGS_DIR, exist_ok=True)

    # If the directory is empty, fetch data for provided symbols
    if len(os.listdir(SAVE_HISTORICAL_EARNINGS_DIR)) == 0 and len(symbols) > 0:
        print("LEGC: No local historical data found. Fetching data for provided symbols...")
        for symbol in symbols:
            build_historical_earnings(symbol)

    # Iterate through JSON files in the directory
    for filename in os.listdir(SAVE_HISTORICAL_EARNINGS_DIR):
        if filename.endswith(".json"):
            symbol = filename.split(".")[0]
            print(f"LEGC: Loading historical data for {symbol}...")
            file_path = os.path.join(SAVE_HISTORICAL_EARNINGS_DIR, filename)

            with open(file_path, 'r') as file:
                earnings_data = json.load(file)

            if 'quarterlyEarnings' in earnings_data:
                df = pd.DataFrame(earnings_data['quarterlyEarnings'])
                df['symbol'] = symbol  # Add the symbol column
                all_data.append(df)

    # Combine all data into a single DataFrame
    if all_data:
        combined_df = pd.concat(all_data, ignore_index=True)
        print("LEGC: Combined historical earnings data into a single DataFrame.")
        return combined_df
    else:
        print("LEGC: No historical earnings data found in the directory.")
        return pd.DataFrame()  # Return an empty DataFrame if no data
# -------------------------------------
# Future Earnings Functions
# -------------------------------------
def fetch_upcoming_earnings(symbol):
    """
    Fetch upcoming earnings using yfinance.
    :param symbol: Stock ticker symbol
    :return: Dict with upcoming earnings data or None
    """
    print(f"LEGC: Fetching upcoming earnings for {symbol}...")
    try:
        ticker = yf.Ticker(symbol)
        calendar = ticker.calendar
        print(f"LEGC: Calendar data for {symbol}: {calendar}")

        earnings_date = calendar.get('Earnings Date', None)

        # Debugging type
        print(f"LEGC: Type of earnings_date: {type(earnings_date)} | Value: {earnings_date}")

        # Ensure earnings_date is processed as a list
        if earnings_date:
            if type(earnings_date) == list:
                earnings_date_start = earnings_date[0].strftime('%Y-%m-%d') if len(earnings_date) > 0 else None
                earnings_date_end = earnings_date[-1].strftime('%Y-%m-%d') if len(earnings_date) > 1 else earnings_date_start
            else:
                earnings_date_start = str(earnings_date)
                earnings_date_end = earnings_date_start
        else:
            earnings_date_start = earnings_date_end = None

        result = {
            "Earnings Date Start": earnings_date_start,
            "Earnings Date End": earnings_date_end,
            "Earnings High": calendar.get('Earnings High', None),
            "Earnings Low": calendar.get('Earnings Low', None),
            "Earnings Average": calendar.get('Earnings Average', None),
            "Revenue High": calendar.get('Revenue High', None),
            "Revenue Low": calendar.get('Revenue Low', None),
            "Revenue Average": calendar.get('Revenue Average', None),
        }

        print(f"LEGC: Fetched upcoming earnings for {symbol}: {result}")
        return result

    except Exception as e:
        print(f"LEGC: Error fetching upcoming earnings for {symbol}: {e}")
        return None

def build_upcoming_earnings(symbol):
    """
    Fetch and save upcoming earnings data for a symbol.
    :param symbol: Stock ticker symbol
    """
    print(f"LEGC: Building upcoming earnings data for {symbol}...")
    earnings_data = fetch_upcoming_earnings(symbol)
    if earnings_data:
        file_path = os.path.join(SAVE_UPCOMING_EARNINGS_DIR, f"{symbol}.json")
        with open(file_path, 'w') as file:
            json.dump(earnings_data, file, indent=4)
        print(f"LEGC: Upcoming earnings data saved for {symbol}: {file_path}")
    else:
        print(f"LEGC: Failed to fetch upcoming earnings for {symbol}.")

def load_upcoming_earnings_to_dataframe(symbol):
    """
    Load upcoming earnings data for a single ticker into a pandas DataFrame.
    Fetch the data if the file is missing.
    :param symbol: Stock ticker symbol
    :return: pandas DataFrame of upcoming earnings data
    """
    file_path = os.path.join(SAVE_UPCOMING_EARNINGS_DIR, f"{symbol}.json")

    # Fetch and save if not already present
    if not os.path.exists(file_path):
        build_upcoming_earnings(symbol)

    # Load the JSON file
    with open(file_path, 'r') as file:
        earnings_data = json.load(file)

    # Parse data into DataFrame
    if earnings_data:
        df = pd.DataFrame([earnings_data])  # Wrap in a list for a single row
        df['symbol'] = symbol  # Add symbol column for identification
        print(f"LEGC: Loaded upcoming earnings data for {symbol} into DataFrame.")
        return df
    else:
        print(f"LEGC: No upcoming earnings data found for {symbol}.")
        return pd.DataFrame()

def load_all_upcoming_earnings_to_dataframe(symbols=[]):
    """
    Load all upcoming earnings data for multiple tickers into a single DataFrame.
    Fetch data for missing tickers.
    :param symbols: List of stock ticker symbols
    :return: pandas DataFrame of combined upcoming earnings data
    """
    all_data = []

    # Fetch data for missing symbols if the directory is empty
    if not os.listdir(SAVE_UPCOMING_EARNINGS_DIR) and len(symbols) > 0:
        print("LEGC: No local upcoming earnings data found. Fetching for all provided symbols...")
        for symbol in symbols:
            build_upcoming_earnings(symbol)

    # Load data from JSON files
    for filename in os.listdir(SAVE_UPCOMING_EARNINGS_DIR):
        if filename.endswith(".json"):
            symbol = filename.split(".")[0]
            print(f"LEGC: Loading upcoming data for {symbol} from {filename}...")
            file_path = os.path.join(SAVE_UPCOMING_EARNINGS_DIR, filename)
            with open(file_path, 'r') as file:
                earnings_data = json.load(file)
            if earnings_data:
                df = pd.DataFrame([earnings_data])
                df['symbol'] = symbol
                all_data.append(df)

    # Combine all data into a single DataFrame
    if all_data:
        combined_df = pd.concat(all_data, ignore_index=True)
        print(f"LEGC: Combined upcoming earnings data loaded. Shape: {combined_df.shape}")
        return combined_df
    else:
        print("LEGC: No upcoming earnings data found.")
        return pd.DataFrame()
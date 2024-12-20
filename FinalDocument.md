# Project Overview
The goal of this project is to predict the Adjusted Close Price of stocks for the current day and build a baseline for future predictions using machine learning models. Stock price prediction is a critical area in finance, enabling investors to make informed decisions, reduce risk, and maximize returns. This project leverages historical stock market data, including features like Open, High, Low, Close, Volume, and Adjusted Close Price, to train predictive models.

The project is implemented using Python and includes:
  - Data collection from Yahoo Finance using the yfinance library.
  - Data preprocessing and feature engineering to enhance model performance.
  - Training machine learning models such as Linear Regression and Random Forest.
  - Deployment of prediction functionality via an API.

## Problem Statement
Stock price prediction is a challenging task due to the volatile nature of the market and the multitude of factors influencing price movements. The objective of this project is to develop a model that can predict the Adjusted Close Price of stocks for a specific date.

Key Challenges
  - Integrating Multiple Data Sources: 
    - Challenge: Historical earnings data was not readily available through yfinance. To address this gap, Alpha Vantage was integrated to fetch historical earnings, requiring API keys and handling data compatibility issues.
    - Solution: Combined data from Alpha Vantage for historical earnings and yfinance for stock price data, ensuring consistency through data preprocessing and feature engineering.
  - Feature Engineering:
    - Challenge: Incorporating meaningful features to improve model predictions. Features like moving averages (5-day, 10-day, 20-day), price volatility, and percent change were critical to capture stock behavior.
    - Solution: Developed multiple derived features to enhance model performance:
    - Moving averages (e.g., ma_5, ma_10, ma_20).
    - Volatility and percentage change.
    - Temporal features such as the number of days to and after earnings reports.
	- Deployment Infrastructure:
    - Challenge: Instead of relying on managed solutions like SageMaker or AWS Lambda, a custom deployment pipeline was built using AWS ECS. This required creating the infrastructure from scratch and automating deployment steps.
	  - Solution:
    - Designed an ECS-based deployment pipeline with detailed scripts for creating roles, VPCs, subnets, security groups, and load balancers.
  	- Developed a Flask-based API to serve predictions and models, allowing lightweight and cost-effective deployment.
  - Data Visualization:
    - Challenge: Identifying patterns and trends in stock price data to inform modeling decisions.
    - Solution: Conducted extensive data visualization:
    - Plotted actual vs. predicted prices for Linear Regression and Random Forest models.
    - Compared Close and Adjusted Close prices for insights into stock behavior.
    - Explored distribution and trends of key features.
  - Model Scalability and Flexibility:
    - Challenge: Building a solution that accommodates multiple stock tickers without significant rework.
    - Solution: Encoded tickers into numerical representations and utilized a modular design to support adding new stocks seamlessly.

The solution provides actionable predictions for investment decision-making and lays the groundwork for integrating advanced methods like LSTMs for time series forecasting.

## Metrics
To evaluate the performance of the models, the following metrics are used:
  - Mean Absolute Error (MAE):
    - Measures the average magnitude of the errors between predicted and actual values.
    - Provides an intuitive understanding of prediction error in dollar terms.
  - Root Mean Squared Error (RMSE):
    - Emphasizes larger errors by squaring them before averaging.
    - Useful for identifying large deviations in predictions, which can be critical in financial applications.
  - R-squared (Coefficient of Determination):
    - Indicates the proportion of the variance in stock prices that is predictable from the model.
    - A higher R-squared value suggests a better fit of the model to the data.

Justification
  - MAE is chosen for its simplicity and interpretability, directly reflecting the average error magnitude.
  - RMSE highlights larger errors, which are crucial to minimize in financial predictions.
  - R-squared assesses how well the model captures variability in the data, providing insight into overall model performance.

These metrics collectively provide a comprehensive evaluation of the models, ensuring they are reliable and effective for stock price prediction.

Compare results:
| **Metric**         | **Linear Regression** | **Random Forest**   |
|---------------------|-----------------------|---------------------|
| **Validation MAE**  | 1.48                  | **0.877**           |
| **Validation MSE**  | 3.63                  | **1.4973**          |
| **Validation R²**   | 0.99976               | **0.99991**         |

Key Takeaways
1.	Lower MAE and MSE:
Random Forest has substantially reduced the mean absolute and mean squared errors, indicating better prediction accuracy.
2.	Higher R² Score: The higher R² score indicates that the Random Forest model is explaining more variability in the data.
3.	Handling Complexity: Random Forest captures non-linear relationships and interactions between features better than Linear Regression, which assumes linear relationships.

## Proposed Improvements for Future Work
Although the current implementation successfully predicts the Adjusted Close Price for the current day, it establishes a foundation for future improvements:
  - Long-Term Prediction:
    - Incorporate lagged features and time-series models like LSTMs to predict future prices beyond the current day.
  - Enhanced Deployment:
    - Add authentication and monitoring for the API to enhance security and track usage metrics.
    - Automate model updates through CI/CD pipelines integrated with ECS.
  - Advanced Modeling Techniques:
    - Experiment with ensemble methods and hyperparameter optimization to further improve prediction accuracy.
    - Leverage deep learning models to capture complex stock price patterns.
  - User-Friendly API:
  	- Extend the API to handle bulk predictions for multiple dates and tickers.
  	- Add endpoints for fetching feature importance and model explainability metrics.

## Data Exploration
  - Dataset Description:
    - The dataset consists of historical stock price data, including features like Open, High, Low, Volume, Close, and Adjusted Close.
    - Additional data sources include:
    - Earnings data fetched from Alpha Vantage, providing features like reportedEPS, estimatedEPS, and surprisePercentage.
    - Temporal features derived from date values, such as day of the week and proximity to holidays.
    - Abnormalities addressed:
    - Missing values were identified in earnings and stock data. These were handled by forward-filling or replacing with averages where appropriate.
    - Variance in feature scales (e.g., price vs. volume) required normalization for Linear Regression.
  - Statistics and Characteristics:
    - Features such as moving averages (ma_5, ma_10, ma_20) and volatility were created to capture stock trends and fluctuations.
    - Summary statistics were generated to understand feature distributions and ensure data quality (e.g., absence of null values after preprocessing).
  - Sampling of the Data:
    - Examples of the processed dataset show the inclusion of calculated features, ticker encodings, and aligned earnings data.

### Exploratory Visualization
  - Visualization of Stock Trends:
    - Line plots were created to compare Close and Adjusted Close prices for individual stocks, highlighting the impact of dividends and stock splits.
    - Moving averages and volatility plots were used to illustrate trends and fluctuations over time for selected stocks.
  - Feature Distributions:
    - Histograms were generated for features like Adjusted Close, showing a normal distribution with some outliers.
  - Prediction Results:
    - Visualizations comparing actual vs. predicted stock prices were created for both Linear Regression and Random Forest models.
    - These plots demonstrated the effectiveness of the models in capturing trends over time.

## Algorithms and Techniques
  - Feature Engineering:
    - Ticker encoding was implemented to handle multiple stocks efficiently.
    - Temporal features (e.g., days to earnings, days after earnings) were included to capture event-driven patterns.
    - Moving averages and volatility provided insight into historical trends.
  - Model Selection:
    - Linear Regression was chosen as a baseline due to its simplicity and interpretability. It serves as a benchmark for evaluating advanced models.
    - Random Forest was selected for its ability to handle non-linear relationships and interactions between features.
    - Both models were evaluated on the same dataset for a fair comparison.
  - Scaling:
    - Features were scaled using StandardScaler for Linear Regression to ensure uniform contribution of variables.
    - Random Forest did not require scaling due to its tree-based nature.
  - Handling Missing Data:
    - Missing values in features like reportedEPS were addressed by forward-filling or imputing averages.

### Benchmark
  - Benchmark Model:
    - A **Moving Average** model was initially proposed as the benchmark. However, based on model performance, Linear Regression was used as the benchmark for direct comparison with Random Forest.
  - Defined Metrics:
    - Mean Absolute Error (MAE): Measures average prediction error in dollar terms.
    - Mean Squared Error (MSE): Penalizes larger errors more heavily.
    - R-squared (R²): Indicates how much variance is explained by the model.
  - Performance Comparison:
	  - Linear Regression achieved:
	  - Validation MAE: 1.48
	  - Validation MSE: 3.63
	  - Validation R²: 0.9997
	  - Random Forest outperformed Linear Regression with:
	  - Validation MAE: 0.877
	  - Validation MSE: 1.4973
	  - Validation R²: 0.99991
  - Discussion:
	  - The substantial reduction in MAE and MSE by Random Forest demonstrates its ability to capture complex patterns in stock price movements.
	  - The benchmark comparison validates that Random Forest provides a more robust solution.


## API Documentation
  [API Readme.md](./FlaskApp/Readme.md)


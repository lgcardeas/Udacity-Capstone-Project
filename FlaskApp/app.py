import logging
import os
from flask import Flask, jsonify, request
import joblib
import utils
import pandas as pd

#
# Centralized logger configuration
def setup_logger():
    logger = logging.getLogger("flask-app")
    if not logger.handlers:  # Prevent duplicate handlers
        logger.setLevel(logging.DEBUG)
        
        # Stream handler for console
        console_handler = logging.StreamHandler()
        console_handler.setFormatter(
            logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
        )
        logger.addHandler(console_handler)
        
        # Optional: File handler for logs
        file_handler = logging.FileHandler("app.log")
        file_handler.setFormatter(
            logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
        )
        logger.addHandler(file_handler)

    return logger

app = Flask(__name__)
logger = setup_logger()

@app.route('/')
def home():
    app.logger.info("Home endpoint was hit.")
    return jsonify({"message": "Flask app is running!"})

@app.route('/predict/<symbol>', methods=['GET'])
def predict(symbol):
    app.logger.info("Predict endpoint was hit.")
    
    if symbol is None:
        app.logger.error("No symbol provided.")
        return jsonify({"error": "No symbol provided"}), 400
    
    # Init models if not already loaded (the daily version)
    # utils.download_models_from_s3()
    
    today = pd.Timestamp("today").normalize()
    response = utils.predict(symbol, today)

    if response is None:
        app.logger.error("Model failed to load.")
        return jsonify({"error": "Model not found"}), 500

    today = pd.Timestamp("today").normalize() 
    
    return jsonify(response)

@app.route('/update_models', methods=['PATCH'])
def update_models():
    app.logger.info("Update models endpoint was hit.")
    res = utils.download_models_from_s3(forced=True)
    if res is None:
        app.logger.error("Model update failed.")
        return jsonify({"error": "Model update failed"}), 500
    
    return jsonify({"message": "Models updated successfully!"})

def load_random_forest_model():
    app.logger.info("Loading Random Forest model...")
    try:
        return joblib.load(f"./random_forest_model.pkl")
    except Exception as e:
        app.logger.error(f"Error loading model: {e}")
        return None

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
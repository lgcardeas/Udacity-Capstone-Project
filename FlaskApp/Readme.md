## Readme

### resources required, unless you manually copy the following files into the container, or in this dir, you will need to set this S3 Bucket
```
# utils.py
BUCKET = "capstone-stock-predictable-project"
MODELS = {
    "random_forest_model.pkl": "random_forest_model.pkl",
    "linear_regression_model.pkl": "linear_regression_model.pkl",
    "scaler.pkl": "scaler.pkl",
    "ticker_mapping.json": "ticker_mapping.json"
}
```

### How to run it:
```
docker-compose up
```

### API Endpoints:
```
# Just a healthcheck
- GET /

# predict the current Ajd Close
- GET /predict/<<TICKER>>

# Download the models from S3 afther a training
- /update_models
```

### Deployment
- the deployment scripts can be found in the deploy folder:
```
FlaskApp/deploy
├── create_resources.out # output saved when created the Infrastructure
├── create_resources.sh  # create Infrastructure
└── re-build.sh          # rebuild the images and update the ecs tasks 
``` 
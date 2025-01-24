This repository contains my solution for the Playground Series Season 4, Episode 7 Kaggle competition. The challenge involved building a binary classification model to predict customer interest in purchasing additional insurance products.

## Objective
To develop a machine learning model that predicts whether a customer is likely to cross-sell additional insurance products based on their profile and historical data.

## Models Used
- XGBoost
  - Baseline model with hyperparameter tuning.
    
- LightGBM
  - Final model, achieving a higher AUC-ROC score.

## Performance
- Best AUC-ROC Score: 0.87705

- Leaderboard Rank: 895 / 2234

## Key Features
- **Exploratory Data Analysis:** Analyzed key customer attributes and their correlation with cross-selling interest.

- **Feature Engineering:** Applied one-hot encoding and label encoding for categorical variables.

- **Model Optimization:** Hyperparameter tuning using RandomSearchCV and early stopping for both models.

- **Evaluation:** Measured model performance using AUC-ROC and ensured generalization by testing on unseen data.

## Future Enhancements
- Combine predictions from multiple models (XGBoost, LightGBM, and CatBoost) using stacking for improved performance.

- Deploy the final model as a REST API for real-time predictions and integration into business workflows.

- Leverage SHAP to provide clear, actionable insights into model predictions.

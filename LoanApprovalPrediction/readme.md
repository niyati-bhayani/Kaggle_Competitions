# Loan Approval Prediction
This repository contains the complete code, submission files, and tracking documentation for the Kaggle hackathon Playground Series Season 4, Episode 10. The project focuses on predicting loan approval outcomes using advanced machine learning techniques.

## Rank and Performance
- Leaderboard Rank: 1276 / 3858

- Highest AUC-ROC Score:
   - Validation: 0.9592
   - Public Leaderboard: 0.95673

## Features
- **Model Tracking:** All model versions, techniques, and results are logged in the tracker for transparency and analysis.
  
- **Models:** Includes models like XGBoost, LightGBM, CatBoost, and Random Forest.

- **Hyperparameter Optimization:** Fine-tuned models using RandomSearchCV and GridSearchCV for enhanced performance.

- **Balanced Target Classes:** Addressed class imbalance using techniques like scale_pos_weight and class weights.

- **Ensembling Strategies:** Combined predictions from top-performing models to boost leaderboard scores.

## Future Improvements
- Experiment with deep learning architectures like TabNet.

- Implement additional feature engineering for categorical interactions.

- Incorporate SHAP for interpretability and feature importance analysis.

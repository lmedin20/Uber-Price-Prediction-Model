# Uber Price Prediction Model

## Overview
Developed a multiple linear regression model in SAS to predict Uber ride prices using a real-world dataset.  
This project focuses on data preprocessing, statistical modeling, assumption validation, and model performance evaluation.

## Problem
Accurately predicting ride prices is critical for pricing transparency and decision-making.  
The goal of this project was to build a model that can estimate Uber trip prices based on factors such as distance, duration, and external conditions.

## Tools & Technologies
- SAS (PROC REG, PROC UNIVARIATE)
- Excel (initial data exploration)
- Statistical Modeling (Linear Regression)

## Data
The dataset includes:
- Trip Distance (km)
- Trip Duration (minutes)
- Base Fare, Per KM Rate, Per Minute Rate
- Passenger Count
- Time of Day, Day of Week
- Traffic Conditions, Weather

Categorical variables were converted into dummy variables for regression modeling.

## Approach

### 1. Data Preparation
- Identified quantitative vs categorical variables
- Created dummy variables for categorical features
- Selected reference categories (e.g., Morning, Weekday, Clear weather)

### 2. Exploratory Data Analysis
- Analyzed distributions using histograms
- Evaluated correlations between variables
- Identified strong predictors (e.g., distance, duration)

### 3. Initial Model
- Built full regression model with all variables
- Evaluated:
  - P-values (significance)
  - R² and Adjusted R²
  - Overall model significance (F-test)

### 4. Model Diagnostics
- Checked for multicollinearity (VIF, Tolerance)
- Identified and removed outliers using:
  - Studentized Residuals
  - Cook’s Distance
- Tested regression assumptions:
  - Linearity
  - Independence
  - Constant variance
  - Normality

### 5. Feature Engineering
- Applied transformations (log, square root) to improve model fit
- Resolved violations in variance and independence assumptions

### 6. Model Selection
- Compared Forward Selection vs Backward Selection
- Selected final model based on:
  - Statistical significance
  - Simplicity
  - Performance

### 7. Model Validation
- Split data into training (75%) and testing (25%)
- Evaluated performance using:
  - RMSE
  - MAE
  - R² and Adjusted R²
- Confirmed no overfitting using cross-validation metrics

## Results
- Final model explains ~82% of variance in trip prices  
- RMSE ≈ 0.82 (test set) → low prediction error  
- MAE ≈ 0.51 → predictions are close to actual values  
- Strong predictors include:
  - Trip Distance
  - Trip Duration
  - Rate-based variables  

## Example Prediction
- Predicted trip price: ~$75.69  
- Prediction interval: $60.84 – $92.16  

## Key Takeaways
- Feature transformations significantly improved model reliability  
- Removing outliers improved predictive performance  
- Simpler models (with fewer variables) can outperform complex ones  
- Regression models can effectively capture real-world pricing behavior  

## Files
- `uber_model.sas` → SAS code for modeling and analysis  
- `Uber.csv` → dataset used  
- `report.pdf` → full detailed report  

## Future Improvements
- Incorporate more real-world features (e.g., surge pricing, location data)  
- Test non-linear or machine learning models  
- Expand dataset for improved generalization  

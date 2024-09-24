# Soccer Points Prediction

## Project Overview

This project aims to predict a soccer team's position in a league season using match statistics such as expected goals (xG), home and away goals, and other key metrics. The objective is to compare the effectiveness of various machine learning models—including Linear Regression, Random Forest, and XGBoost—in predicting team points. Additionally, we explore a model based on expected goals, leveraging the Law of Averages to simulate match outcomes. The final goal is to enhance soccer analytics and provide deeper insights into team performance.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Technologies Used](#technologies-used)
3. [Data Sources](#data-sources)
4. [Usage](#usage)
5. [Modeling Approach](#modeling-approach)
6. [Results](#results)
7. [Future Enhancements](#future-enhancements)

## Technologies Used

- R (for data scraping)
- Scikit-learn (machine learning models)
- XGBoost (gradient boosting)
- RandomForest (for tree-based model)
- Pandas and NumPy (data manipulation)
- Matplotlib and Seaborn (visualization)
- Jupyter Notebook

## Data Sources

We gathered soccer statistics data using R, covering match statistics from the 2019, 2022, and 2023 seasons. The 2019 and 2022 data were used for model training, and the 2023 data was used for predictions. The dataset includes relevant match data such as goals, assists, tackles, saves, and expected goals (xG), categorized into attacking, defending, and goalkeeping metrics.

### Variables Considered

**Attacking:**
- Short/Medium/Long Pass Completion %
- Goals + Assists per 90 minutes
- Attendance Per Game
- Penalty Kick Attempt %

**Defending:**
- Tackles (Defensive, Midfield, Attacking thirds)
- Dribblers Tackled %
- Interceptions, Clearances

**Goalkeeping:**
- Save Percentage (SP)
- Clean Sheet Percentage (CSP)
- Penalty Kicks Attempted & Saved


## Usage

1. Preprocess the data (cleaning, feature engineering) using the scripts provided.
2. Train the models (Linear Regression, Random Forest, XGBoost) on historical data.
3. Evaluate the models on test data to predict team points and standings for the 2023 season.
4. Analyze prediction intervals to understand model confidence.

## Modeling Approach

### Expected Goals (xG) Model and the Law of Averages
The Expected Goals (xG) model is a widely-used metric in soccer analytics that estimates the probability of a goal being scored based on the quality and location of shots taken. This model uses historical shot data from both teams to simulate match outcomes.

![Picture1](https://github.com/user-attachments/assets/93b04b65-3d10-499a-93d1-e3ae77c092ac)

#### How it Works:
- **xG Calculation:**  
   For each team, xG values are calculated based on historical shot and goal data. These values are combined with shot data from both teams in a match to estimate the likelihood of goals.
   
- **Law of Averages:**  
   The model employs the Law of Averages, which states that over a large number of trials (in this case, shots), the average outcome will converge toward the expected value. By running multiple simulations of matches based on xG and shot probabilities, we predict how teams would perform if expected goals were the only available metric.

#### Key Highlights:
- The Expected Goals model predicts match outcomes based purely on statistical probabilities, making it useful for estimating team performance in scenarios where detailed match stats are limited.
- **Performance:**  
   While the xG model provided interesting insights, it was less accurate in predicting final standings, with an RMSE of 12.05 and fewer correct position guesses. This reinforces the idea that xG alone, while useful, is not a comprehensive measure for predicting match outcomes.

### Linear Regression
Linear regression is a statistical approach that models the relationship between independent variables (match statistics) and the dependent variable (points). In this project, we used match data to predict points for each team based on metrics like goals, assists, and defending performance.

- **Performance:**  
   Linear Regression performed reasonably well, with a root mean squared error (RMSE) of 9.05, correctly predicting the position of 6 teams.

### Random Forest
Random Forest is an ensemble learning method that builds multiple decision trees and merges them to create a more accurate and stable prediction. This model was well-suited for predicting soccer points, as it handles non-linear relationships in the data effectively.

- **Performance:**  
   The Random Forest model outperformed Linear Regression, with an RMSE of 8.3. It accurately predicted points for 19 out of 20 teams within its confidence intervals.

### XGBoost
XGBoost is a powerful gradient boosting algorithm that focuses on optimizing model performance by reducing prediction error in an iterative fashion. In this project, XGBoost was particularly useful due to its ability to handle complex relationships between soccer statistics.

- **Performance:**  
   XGBoost achieved an RMSE of 9.25 and predicted points for 19 out of 20 teams within prediction intervals, demonstrating its robustness.



#### Example:
If Team A has an xG of 1.5 and Team B has an xG of 1.0, the model predicts that Team A is more likely to win, assuming no other factors come into play. Over many simulations, Team A would win more often than Team B, reflecting the higher probability of scoring based on xG values.

## Results

**Model Highlights:**
- **Expected Goals:
-![Table using expected goals](https://github.com/user-attachments/assets/949c168a-2394-4bcc-bfe7-122a15ad5ec4)
- ** Positions guessed correctly: 2; Mean points difference: 12.05
- **Linear Regression:
-![table using linear regression](https://github.com/user-attachments/assets/c9873b73-b568-4b28-8bfd-d25ccd42e8c3)
- ** Positions guessed correctly: 6; Mean points difference: 7.4
- **Random Forest:
- ![Table using Random Forest](https://github.com/user-attachments/assets/9a7bde81-0128-4405-b57e-323213dd0129)
- ** Positions guessed correctly: 5; Mean points difference: 7.3
- **XGBoost:
-![Table using xgboost](https://github.com/user-attachments/assets/ca32bcd9-eaff-4ecf-86ac-f6d109a07c6b)
- ** Positions guessed correctly: 5; Mean points difference: 6.9


## Future Enhancements

- **Incorporate real-time data:** Integrate live data from ongoing matches to make real-time predictions.
- **Feature expansion:** Include additional features like weather conditions, injuries, or referee statistics.
- **Deploy the model:** Create a web app using Flask or Streamlit to allow users to interact with the predictions and compare team performances.



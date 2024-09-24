# Load the required library
library(xgboost)
library(tidyr)
# Assuming 'data' contains your dataset with features and points earned

# Split data into training and testing sets
set.seed(123) # for reproducibility
data <- read.csv("final_set.csv")
data <- data[-1]
df <- data[-1]
for (col in names(df)) {  # Exclude the "Squad" column
  df[[col]] <- as.numeric(df[[col]])
}
train_data <- df[1:40,]
test_data <- df[41:60,]

# Convert data to matrix format required by xgboost
X_train <- as.matrix(train_data[, -which(names(train_data) == "Pts")]) # Features
y_train <- train_data$Pts # Target variable

X_test <- as.matrix(test_data[, -which(names(test_data) == "Pts")]) # Features
y_test <- test_data$Pts # Target variable


# Train xgboost model
xgb_data <- xgb.DMatrix(data = X_train, label = y_train)
xgb_model <- xgboost(data = xgb_data, nrounds = 100, objective = "reg:squarederror")


prediction <- predict(xgb_model, newdata = X_test)

# Extract the subset of test data containing squads 41 to 60
test <- data[41:60,]
combined_df <- cbind(test$Squad, prediction)
combined_df <- as.data.frame(combined_df)
colnames(combined_df) <- c("Squad", "Predicted_Points")
combined_df$Predicted_Points <- as.numeric(combined_df$Predicted_Points)

str(combined_df)
combined_df <- combined_df[order(-combined_df$Predicted_Points), ]
rownames(combined_df) <- NULL
print(combined_df)
write.csv(combined_df, "Prediction from xgboost.csv")
# Evaluate the model (e.g., calculate RMSE)
rmse <- sqrt(mean((prediction - y_test)^2))
print(paste("Root Mean Squared Error (RMSE):", rmse))

# Step 1: Calculate predictions for the test set
predictions <- predict(xgb_model, newdata = X_test)

# Step 2: Calculate residuals and standard deviation of residuals
residuals <- y_test - predictions
residual_sd <- sd(residuals)

# Step 3: Calculate prediction intervals
alpha <- 0.05  # Significance level
n <- length(predictions)  # Number of observations
t_value <- qt(1 - alpha / 2, df = n - 1)  # t-value for the given significance level
se <- sqrt(residual_sd^2 + (residual_sd^2 / n))  # Standard error of the predictions

# Calculate lower and upper bounds of the prediction intervals
lower_bound <- predictions - t_value * se
upper_bound <- predictions + t_value * se

# Step 4: Combine squads and their predicted points in a dataframe
prediction_intervals_df <- data.frame(
  Squad = test$Squad,
  Predicted_Points = round(predictions),
  Lower_Bound = lower_bound,
  Upper_Bound = upper_bound,
  Actual_Points = y_test
)

# Step 5: Filter the dataframe to include only squads within the prediction intervals
filtered_df_xg <- prediction_intervals_df[prediction_intervals_df$Actual_Points >= prediction_intervals_df$Lower_Bound & 
                                         prediction_intervals_df$Actual_Points <= prediction_intervals_df$Upper_Bound, ]
View(filtered_df_xg)
# Print or use the filtered dataframe
nrow(filtered_df_xg)


library(randomForest)

# Read the data
data <- read.csv("final_set.csv")

# Remove the index column
data <- data[-1]

# Convert selected columns to numeric
for (i in c(2:5, 7:ncol(data))) {  
  data[[i]] <- as.numeric(data[[i]])
}

# Split data into training and testing sets
train <- data[1:40, ]
test <- data[41:60, ]
test_data <- test[-6]
# Train the random forest model
rf <- randomForest(Pts ~ . - Squad, train)
summary(rf$forest)
print(rf)
predictions <- predict(rf, newdata = test_data)
# Calculate Mean Squared Error (MSE)
mse <- sqrt(mean((predictions - test$Pts)^2))
cat("Mean Squared Error (MSE):", mse, "\n")

# Convert the names of the predictions to match the row names of the test data
names(predictions) <- rownames(test_data)

# Extract the actual labels from the test data
actual_labels <- test$Pts  # Assuming 'Actual_Labels' contains the actual class labels (0 or 1)


# Get predictions for the test set
test_predictions <- predict(rf, newdata = test)

# Calculate residuals
residuals <- test$Pts - test_predictions

# Calculate standard deviation of residuals
residual_sd <- sd(residuals)

# Calculate prediction intervals
alpha <- 0.05  # Significance level
n <- nrow(test)  # Number of observations
t_value <- qt(1 - alpha / 2, df = n - 1)  # t-value for the given significance level
se <- sqrt(residual_sd^2 + (residual_sd^2 / n))  # Standard error of the predictions

# Calculate lower and upper bounds of the prediction intervals
lower_bound <- test_predictions - t_value * se
upper_bound <- test_predictions + t_value * se

# Create a dataframe with predictions, prediction intervals, and actual values
prediction_intervals_df <- data.frame(
  Squad = test$Squad,
  Predicted_Pts = test_predictions,
  Lower_Bound = lower_bound,
  Upper_Bound = upper_bound,
  Actual_Pts = test$Pts
)

# Print or view the dataframe
print(prediction_intervals_df)
# Filter the dataframe to include only squads with actual points between lower and upper bounds
filtered_df <- prediction_intervals_df[prediction_intervals_df$Actual_Pts >= prediction_intervals_df$Lower_Bound & 
                                         prediction_intervals_df$Actual_Pts <= prediction_intervals_df$Upper_Bound,c("Squad", "Actual_Pts", "Lower_Bound", "Upper_Bound") ]
View(filtered_df)
# Print or use the filtered dataframe
nrow(filtered_df)




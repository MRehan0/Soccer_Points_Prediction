data <- read.csv("final_set.csv")

data <- data[, -1]  # Assuming the index column is the first column
# Convert all columns except Squad to numeric or integer
cols_to_convert <- setdiff(names(data), "Squad")

# Loop through each column (excluding "Squad") and convert to numeric or integer
for (col in cols_to_convert) {
  # Check if the column can be converted to numeric
  if (all(is.na(as.numeric(data[[col]])))) {
    # If not numeric, convert to integer if possible
    data[[col]] <- as.integer(data[[col]])
  } else {
    # Otherwise, convert to numeric
    data[[col]] <- as.numeric(data[[col]])
  }
}

str(data)
train_data <- data[1:40,]
test <- data[41:60,]
test_data <- test[-6]
train <- train_data[-1]


model <- lm(Pts ~ . , data = train)
summary(model)
prediction <- predict(model, newdata = test_data)




# Step 1: Calculate predictions and residuals

predictions_df <- data.frame(Squad = test$Squad, Predicted_Pts = round(prediction))
predictions_df <- predictions_df[order(-predictions_df$Predicted_Pts), ]
# Remove row names from the dataframe
rownames(predictions_df) <- NULL


residuals <- test$Pts - prediction

# Calculate mean squared error (MSE)
mse <- mean(residuals^2)

# Calculate degrees of freedom for residuals (df)
n <- length(residuals)
p <- length(coef(model)) - 1  # Number of predictors (excluding intercept)
df <- n - p - 1  # Degrees of freedom for residuals

# Ensure df is at least 1 to avoid division by zero
df <- max(df, 1)

# Calculate standard error of predictions (se)
se <- sqrt(mse / df)

# Specify the significance level (alpha) for prediction intervals
alpha <- 0.05

# Calculate t-value for the specified significance level and degrees of freedom
t_value <- qt(1 - alpha / 2, df = df)

# Calculate lower and upper bounds for prediction intervals
lower_bound <- prediction - t_value * se
upper_bound <- prediction + t_value * se

# Create dataframe with squad names, predicted points, and prediction intervals
predictions_df <- data.frame(
  Squad = test_data$Squad,
  Predicted_Pts = prediction,
  Lower_Bound = lower_bound,
  Upper_Bound = upper_bound
)


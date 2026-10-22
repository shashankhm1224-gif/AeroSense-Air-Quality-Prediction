# ==========================================================
# Machine Learning for AQI Prediction
# ==========================================================

library(dplyr)
library(ggplot2)

# Train a multiple linear regression model to predict AQI.
train_aqi_model <- function(df) {
  if (is.null(df) || nrow(df) < 20) {
    stop("Insufficient data for model training.")
  }

  features <- c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity")

  # Keep only numeric predictor columns.
  model_data <- df[, c(features, "AQI")]
  model_data <- model_data[complete.cases(model_data), ]

  if (nrow(model_data) < 20) {
    stop("Not enough complete rows for training.")
  }

  set.seed(123)
  train_index <- sample(seq_len(nrow(model_data)), size = floor(0.8 * nrow(model_data)))
  train_data <- model_data[train_index, ]
  test_data <- model_data[-train_index, ]

  formula_str <- as.formula("AQI ~ PM2.5 + PM10 + NO2 + SO2 + CO + O3 + Temperature + Humidity")
  model <- lm(formula_str, data = train_data)

  predictions <- predict(model, newdata = test_data)
  actual <- test_data$AQI
  error <- actual - predictions

  mae <- mean(abs(error))
  rmse <- sqrt(mean(error^2))
  r_squared <- summary(model)$r.squared

  prediction_df <- data.frame(
    Actual_AQI = actual,
    Predicted_AQI = predictions,
    Error = error,
    stringsAsFactors = FALSE
  )

  output_dir <- "output/results"
  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
  write.csv(prediction_df, file = file.path(output_dir, "aqi_predictions.csv"), row.names = FALSE)

  model_summary <- data.frame(
    Metric = c("Model name", "Training rows", "Testing rows", "MAE", "RMSE", "R-squared"),
    Value = c(
      "Multiple Linear Regression",
      nrow(train_data),
      nrow(test_data),
      round(mae, 4),
      round(rmse, 4),
      round(r_squared, 4)
    ),
    stringsAsFactors = FALSE
  )

  writeLines(
    c(
      "Model name: Multiple Linear Regression",
      paste("Training rows:", nrow(train_data)),
      paste("Testing rows:", nrow(test_data)),
      paste("MAE:", round(mae, 4)),
      paste("RMSE:", round(rmse, 4)),
      paste("R-squared:", round(r_squared, 4))
    ),
    con = file.path(output_dir, "model_results.txt")
  )

  # Actual vs predicted graph.
  plot_data <- data.frame(Actual = actual, Predicted = predictions)
  p <- ggplot(plot_data, aes(x = Actual, y = Predicted)) +
    geom_point(color = "darkgreen", alpha = 0.7) +
    geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
    labs(title = "Actual AQI vs Predicted AQI",
         x = "Actual AQI",
         y = "Predicted AQI") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5))

  ggsave("output/plots/actual_vs_predicted.png", plot = p, width = 8, height = 6, dpi = 150)

  list(
    model = model,
    train_data = train_data,
    test_data = test_data,
    predictions = predictions,
    actual = actual,
    error = error,
    mae = mae,
    rmse = rmse,
    r_squared = r_squared,
    model_summary = model_summary,
    prediction_df = prediction_df
  )
}

# End of file

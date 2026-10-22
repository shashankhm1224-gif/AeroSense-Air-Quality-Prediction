# ==========================================================
# Exploratory Data Analysis and AQI Analysis
# ==========================================================

library(dplyr)

# Create a summary table of descriptive statistics.
calculate_descriptive_stats <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  selected_vars <- c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity", "AQI")
  stats_table <- lapply(selected_vars, function(var) {
    x <- df[[var]]
    data.frame(
      Variable = var,
      Mean = mean(x, na.rm = TRUE),
      Median = median(x, na.rm = TRUE),
      Minimum = min(x, na.rm = TRUE),
      Maximum = max(x, na.rm = TRUE),
      SD = sd(x, na.rm = TRUE),
      stringsAsFactors = FALSE
    )
  })

  summary_table <- do.call(rbind, stats_table)

  list(
    summary_table = summary_table,
    selected_vars = selected_vars
  )
}

# AQI classification based on defined thresholds.
assign_aqi_category <- function(aqi_value) {
  if (is.na(aqi_value)) {
    return("Unknown")
  }

  if (aqi_value <= 50) {
    return("Good")
  } else if (aqi_value <= 100) {
    return("Moderate")
  } else if (aqi_value <= 200) {
    return("Poor")
  } else if (aqi_value <= 300) {
    return("Very Poor")
  } else {
    return("Severe")
  }
}

# Perform AQI analysis and identify city and date extremes.
perform_aqi_analysis <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  city_avg_aqi <- df %>%
    group_by(City) %>%
    summarise(avg_aqi = mean(AQI, na.rm = TRUE), .groups = "drop")

  highest_aqi_city <- city_avg_aqi$City[which.max(city_avg_aqi$avg_aqi)]
  lowest_aqi_city <- city_avg_aqi$City[which.min(city_avg_aqi$avg_aqi)]

  max_aqi_date <- df$Date[which.max(df$AQI)]
  avg_aqi <- mean(df$AQI, na.rm = TRUE)
  max_aqi <- max(df$AQI, na.rm = TRUE)
  min_aqi <- min(df$AQI, na.rm = TRUE)

  df$AQI_Category <- sapply(df$AQI, assign_aqi_category)

  summary <- data.frame(
    Metric = c("Average AQI", "Maximum AQI", "Minimum AQI",
              "City with highest average AQI", "City with lowest average AQI",
              "Date with highest AQI"),
    Value = c(
      round(avg_aqi, 2),
      round(max_aqi, 2),
      round(min_aqi, 2),
      highest_aqi_city,
      lowest_aqi_city,
      as.character(max_aqi_date)
    ),
    stringsAsFactors = FALSE
  )

  list(
    summary = summary,
    highest_aqi_city = highest_aqi_city,
    lowest_aqi_city = lowest_aqi_city,
    max_aqi_date = max_aqi_date,
    avg_aqi = avg_aqi,
    max_aqi = max_aqi,
    min_aqi = min_aqi,
    city_avg_aqi = city_avg_aqi,
    transformed_data = df
  )
}

# Correlation analysis between AQI and pollutant variables.
compute_correlation_analysis <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  selected_vars <- c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity")

  correlation_values <- sapply(selected_vars, function(var) {
    cor(df[[var]], df$AQI, use = "complete.obs")
  })

  correlation_df <- data.frame(
    Variable = selected_vars,
    Correlation_with_AQI = as.numeric(correlation_values),
    stringsAsFactors = FALSE
  )

  correlation_df <- correlation_df[order(abs(correlation_df$Correlation_with_AQI), decreasing = TRUE), ]
  top_factor <- correlation_df$Variable[1]
  top_value <- correlation_df$Correlation_with_AQI[1]

  # Save correlation results to CSV.
  output_dir <- "output/results"
  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
  write.csv(correlation_df, file = file.path(output_dir, "correlation_matrix.csv"), row.names = FALSE)

  correlation_matrix <- cor(df[, c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity", "AQI")], use = "complete.obs")

  list(
    correlation_matrix = correlation_matrix,
    correlation_df = correlation_df,
    strongest_factor_name = top_factor,
    strongest_factor_value = top_value,
    strongest_factor = paste(top_factor, "=", round(top_value, 4))
  )
}

# End of file

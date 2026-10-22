# ==========================================================
# Data Cleaning and Preprocessing
# ==========================================================

# Load the raw CSV file into a data frame.
load_air_quality_data <- function(file_path = "air_quality_data.csv") {
  if (!file.exists(file_path)) {
    message("CSV file not found: ", file_path)
    return(NULL)
  }

  data <- read.csv(file_path, stringsAsFactors = FALSE)

  if (nrow(data) == 0) {
    message("The dataset is empty.")
    return(NULL)
  }

  if (!all(c("Date", "City", "PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity", "AQI") %in% colnames(data))) {
    message("Required columns are missing from the dataset.")
    return(NULL)
  }

  data
}

# Show shape and a summary of the dataset.
dataset_summary <- function(df) {
  if (is.null(df)) {
    return(list(rows = 0, cols = 0, columns = character()))
  }

  list(
    rows = nrow(df),
    cols = ncol(df),
    columns = colnames(df)
  )
}

# Check missing values before and after cleaning.
check_missing_values <- function(df) {
  if (is.null(df)) {
    return(0)
  }

  sum(is.na(df))
}

# Convert date column and numeric variables into proper types.
convert_data_types <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  numeric_columns <- c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity", "AQI")

  for (col in numeric_columns) {
    if (col %in% colnames(df)) {
      df[[col]] <- suppressWarnings(as.numeric(df[[col]]))
    }
  }

  if ("Date" %in% colnames(df)) {
    df$Date <- as.Date(df$Date, tryFormats = c("%Y-%m-%d", "%d-%m-%Y", "%m/%d/%Y", "%Y/%m/%d"))
    invalid_date_index <- is.na(df$Date)
    if (sum(invalid_date_index) > 0) {
      message("Found invalid date values. Removing rows with invalid dates.")
      df <- df[!invalid_date_index, , drop = FALSE]
    }
  }

  df
}

# Fill missing numeric values using median imputation.
handle_missing_values <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  numeric_columns <- c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity", "AQI")

  for (col in numeric_columns) {
    if (col %in% colnames(df)) {
      col_median <- median(df[[col]], na.rm = TRUE)
      if (is.na(col_median)) {
        next
      }
      df[[col]][is.na(df[[col]])] <- col_median
    }
  }

  df
}

# Remove duplicate rows.
remove_duplicate_rows <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  df[!duplicated(df), , drop = FALSE]
}

# Validate AQI range.
validate_aqi <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  if (!"AQI" %in% colnames(df)) {
    message("AQI column not found.")
    return(df)
  }

  invalid_aqi_index <- which(df$AQI < 0 | df$AQI > 500 | is.na(df$AQI))
  if (length(invalid_aqi_index) > 0) {
    df$AQI[invalid_aqi_index] <- NA
  }

  df
}

# Main function to clean the dataset.
clean_air_quality_data <- function(df) {
  if (is.null(df)) {
    return(NULL)
  }

  original_rows <- nrow(df)
  original_missing <- check_missing_values(df)

  # Convert date and numeric columns
  df <- convert_data_types(df)

  # Remove duplicate rows
  duplicate_count <- sum(duplicated(df))
  df <- remove_duplicate_rows(df)

  # Validate AQI values and handle invalid entries
  df <- validate_aqi(df)

  # Handle missing values using median imputation
  df <- handle_missing_values(df)

  # Remove rows with invalid dates or remaining missing values
  df <- df[complete.cases(df), , drop = FALSE]

  final_rows <- nrow(df)
  final_missing <- check_missing_values(df)

  cat("\n=== Data Cleaning Summary ===\n")
  cat("Original rows:", original_rows, "\n")
  cat("Missing values found:", original_missing, "\n")
  cat("Duplicates removed:", duplicate_count, "\n")
  cat("Final rows:", final_rows, "\n")
  cat("Missing values after cleaning:", final_missing, "\n")
  cat("============================\n")

  if (nrow(df) == 0) {
    message("No valid rows remain after cleaning.")
    return(NULL)
  }

  df
}

# End of file

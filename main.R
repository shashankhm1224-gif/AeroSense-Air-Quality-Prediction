# ==========================================================
# AIR QUALITY ANALYSIS & PREDICTION
# Main entry point for the R mini project
# ==========================================================

required_packages <- c("ggplot2", "dplyr", "tidyr", "readr", "lubridate")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing_packages) > 0) {
  cat("\nMissing required R packages:", paste(missing_packages, collapse = ", "), "\n")
  cat("Install them using:\n")
  for (pkg in required_packages) {
    cat("install.packages(\"", pkg, "\")\n", sep = "")
  }
  quit(status = 1)
}

library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)

source("R/data_cleaning.R")
source("R/analysis.R")
source("R/visualization.R")
source("R/prediction.R")
source("R/interpretation.R")

# ==========================================================
# Utility functions
# ==========================================================

create_output_directories <- function() {
  dir.create("output/plots", showWarnings = FALSE, recursive = TRUE)
  dir.create("output/results", showWarnings = FALSE, recursive = TRUE)
  dir.create("report", showWarnings = FALSE, recursive = TRUE)
}

print_project_header <- function() {
  cat("\n===========================================\n")
  cat("AIR QUALITY ANALYSIS & PREDICTION\n")
  cat("===========================================\n")
}

show_menu <- function() {
  cat("\n===========================================\n")
  cat("AIR QUALITY ANALYSIS & PREDICTION\n")
  cat("===========================================\n")
  cat("1. Dataset Summary\n")
  cat("2. Descriptive Statistics\n")
  cat("3. AQI Analysis\n")
  cat("4. Correlation Analysis\n")
  cat("5. Generate Visualizations\n")
  cat("6. Train AQI Prediction Model\n")
  cat("7. View Model Performance\n")
  cat("8. Run Complete Analysis\n")
  cat("9. Exit\n")
  cat("Enter your choice: ")
}

run_complete_analysis <- function() {
  create_output_directories()

  cat("\nLoading dataset...\n")
  raw_data <- load_air_quality_data("air_quality_data.csv")
  if (is.null(raw_data)) {
    cat("Dataset could not be loaded. Please check the CSV file.\n")
    return(invisible(NULL))
  }

  cleaned_data <- clean_air_quality_data(raw_data)
  if (is.null(cleaned_data) || nrow(cleaned_data) == 0) {
    cat("No valid rows remain after cleaning.\n")
    return(invisible(NULL))
  }

  cat("\nDataset information:\n")
  print(dataset_summary(cleaned_data))

  descriptive <- calculate_descriptive_stats(cleaned_data)
  print(descriptive$summary_table)

  aqi_analysis <- perform_aqi_analysis(cleaned_data)
  print(aqi_analysis$summary)

  corr_result <- compute_correlation_analysis(cleaned_data)
  print(corr_result$strongest_factor)

  generate_visualizations(cleaned_data)

  model_result <- train_aqi_model(cleaned_data)
  print(model_result$model_summary)

  cat("\nImportant findings:\n")
  cat("- Average AQI:", round(mean(cleaned_data$AQI, na.rm = TRUE), 2), "\n")
  cat("- Highest AQI city:", aqi_analysis$highest_aqi_city, "\n")
  cat("- Lowest AQI city:", aqi_analysis$lowest_aqi_city, "\n")
  cat("- Strongest AQI factor:", corr_result$strongest_factor_name, "\n")

  cat("\n===========================================\n")
  cat("PROJECT RESULTS\n")
  cat("Total Records :", nrow(cleaned_data), "\n")
  cat("Average AQI :", round(mean(cleaned_data$AQI, na.rm = TRUE), 2), "\n")
  cat("Maximum AQI :", round(max(cleaned_data$AQI, na.rm = TRUE), 2), "\n")
  cat("Minimum AQI :", round(min(cleaned_data$AQI, na.rm = TRUE), 2), "\n")
  cat("Highest AQI City :", aqi_analysis$highest_aqi_city, "\n")
  cat("Lowest AQI City :", aqi_analysis$lowest_aqi_city, "\n")
  cat("Strongest AQI Factor: ", corr_result$strongest_factor_name, "\n")
  cat("Model: Multiple Linear Regression\n")
  cat("MAE :", round(model_result$mae, 2), "\n")
  cat("RMSE :", round(model_result$rmse, 2), "\n")
  cat("R-Squared :", round(model_result$r_squared, 4), "\n")
  cat("All graphs saved in: output/plots/\n")
  cat("All results saved in: output/results/\n")
  cat("===========================================\n\n")


  cat("Project completed successfully.\n")
  invisible(cleaned_data)
}

run_menu_session <- function() {
  create_output_directories()

  while (TRUE) {
    show_menu()
    choice <- readline()

    if (length(choice) == 0 || is.na(choice)) {
      cat("\nNo input detected. Please enter a valid option.\n")
      next
    }

    choice <- trimws(choice)

    if (!grepl("^[0-9]+$", choice)) {
      cat("\nInvalid input. Please choose a number from 1 to 9.\n")
      next
    }

    choice_num <- as.integer(choice)

    if (choice_num == 9) {
      cat("\nExiting program. Thank you.\n")
      break
    }

    if (choice_num == 1) {
      dataset <- load_air_quality_data("air_quality_data.csv")
      if (is.null(dataset)) {
        cat("\nUnable to load dataset.\n")
      } else {
        cleaned <- clean_air_quality_data(dataset)
        print(dataset_summary(cleaned))
      }
    } else if (choice_num == 2) {
      dataset <- load_air_quality_data("air_quality_data.csv")
      if (is.null(dataset)) {
        cat("\nUnable to load dataset.\n")
      } else {
        cleaned <- clean_air_quality_data(dataset)
        result <- calculate_descriptive_stats(cleaned)
        print(result$summary_table)
      }
    } else if (choice_num == 3) {
      dataset <- load_air_quality_data("air_quality_data.csv")
      if (is.null(dataset)) {
        cat("\nUnable to load dataset.\n")
      } else {
        cleaned <- clean_air_quality_data(dataset)
        result <- perform_aqi_analysis(cleaned)
        print(result$summary)
      }
    } else if (choice_num == 4) {
      dataset <- load_air_quality_data("air_quality_data.csv")
      if (is.null(dataset)) {
        cat("\nUnable to load dataset.\n")
      } else {
        cleaned <- clean_air_quality_data(dataset)
        result <- compute_correlation_analysis(cleaned)
        print(result$correlation_matrix)
        cat("\nStrongest AQI factor:", result$strongest_factor_name, "\n")
      }
    } else if (choice_num == 5) {
      dataset <- load_air_quality_data("air_quality_data.csv")
      if (is.null(dataset)) {
        cat("\nUnable to load dataset.\n")
      } else {
        cleaned <- clean_air_quality_data(dataset)
        generate_visualizations(cleaned)
        cat("\nAll visualizations generated in output/plots/.\n")
      }
    } else if (choice_num == 6) {
      dataset <- load_air_quality_data("air_quality_data.csv")
      if (is.null(dataset)) {
        cat("\nUnable to load dataset.\n")
      } else {
        cleaned <- clean_air_quality_data(dataset)
        result <- train_aqi_model(cleaned)
        print(result$model_summary)
      }
    } else if (choice_num == 7) {
      dataset <- load_air_quality_data("air_quality_data.csv")
      if (is.null(dataset)) {
        cat("\nUnable to load dataset.\n")
      } else {
        cleaned <- clean_air_quality_data(dataset)
        result <- train_aqi_model(cleaned)
        print(result$model_summary)
      }
    } else if (choice_num == 8) {
      run_complete_analysis()
    } else {
      cat("\nInvalid choice. Please try again.\n")
    }

    cat("\nPress Enter to continue...")
    invisible(readline())
  }
}

print_project_header()

if (interactive()) {
  run_menu_session()
} else {install.packages(c("ggplot2", "dplyr", "tidyr", "readr", "lubridate"))
  run_complete_analysis()
}

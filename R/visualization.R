# ==========================================================
# Visualization functions using ggplot2
# ==========================================================

library(ggplot2)
library(dplyr)

# AQI trend over time.
plot_aqi_trend <- function(df, output_path = "output/plots/aqi_trend.png") {
  ggplot(df, aes(x = Date, y = AQI)) +
    geom_line(color = "firebrick", linewidth = 0.8) +
    geom_point(color = "darkred", size = 1.2) +
    labs(title = "AQI Trend Over Time", x = "Date", y = "AQI") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5))
  ggsave(output_path, width = 10, height = 6, dpi = 150)
}

# Average AQI by city.
plot_city_aqi <- function(df, output_path = "output/plots/city_aqi.png") {
  city_summary <- df %>%
    group_by(City) %>%
    summarise(Average_AQI = mean(AQI, na.rm = TRUE), .groups = "drop")

  ggplot(city_summary, aes(x = reorder(City, Average_AQI), y = Average_AQI, fill = City)) +
    geom_col() +
    coord_flip() +
    labs(title = "Average AQI by City", x = "City", y = "Average AQI") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5), legend.position = "none")
  ggsave(output_path, width = 9, height = 6, dpi = 150)
}

# PM2.5 vs AQI scatter plot.
plot_pm25_vs_aqi <- function(df, output_path = "output/plots/pm25_vs_aqi.png") {
  ggplot(df, aes(x = `PM2.5`, y = AQI)) +
    geom_point(color = "steelblue", alpha = 0.7) +
    geom_smooth(method = "lm", se = FALSE, color = "darkblue") +
    labs(title = "PM2.5 vs AQI", x = "PM2.5 (µg/m³)", y = "AQI") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5))
  ggsave(output_path, width = 8, height = 6, dpi = 150)
}

# PM10 vs AQI scatter plot.
plot_pm10_vs_aqi <- function(df, output_path = "output/plots/pm10_vs_aqi.png") {
  ggplot(df, aes(x = `PM10`, y = AQI)) +
    geom_point(color = "darkgreen", alpha = 0.7) +
    geom_smooth(method = "lm", se = FALSE, color = "darkorange") +
    labs(title = "PM10 vs AQI", x = "PM10 (µg/m³)", y = "AQI") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5))
  ggsave(output_path, width = 8, height = 6, dpi = 150)
}

# AQI category distribution.
plot_aqi_category_distribution <- function(df, output_path = "output/plots/aqi_categories.png") {
  df$AQI_Category <- sapply(df$AQI, function(x) {
    if (is.na(x)) return("Unknown")
    if (x <= 50) return("Good")
    else if (x <= 100) return("Moderate")
    else if (x <= 200) return("Poor")
    else if (x <= 300) return("Very Poor")
    else return("Severe")
  })

  category_order <- c("Good", "Moderate", "Poor", "Very Poor", "Severe")
  df$AQI_Category <- factor(df$AQI_Category, levels = category_order)

  ggplot(df, aes(x = AQI_Category, fill = AQI_Category)) +
    geom_bar() +
    labs(title = "AQI Category Distribution", x = "AQI Category", y = "Count") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5), legend.position = "none")
  ggsave(output_path, width = 8, height = 6, dpi = 150)
}

# Monthly average AQI.
plot_monthly_aqi <- function(df, output_path = "output/plots/monthly_aqi.png") {
  df$Month <- format(df$Date, "%Y-%m")
  monthly_summary <- df %>%
    group_by(Month) %>%
    summarise(Average_AQI = mean(AQI, na.rm = TRUE), .groups = "drop")

  ggplot(monthly_summary, aes(x = Month, y = Average_AQI, group = 1)) +
    geom_line(color = "purple", linewidth = 1.1) +
    geom_point(color = "darkorchid", size = 2) +
    labs(title = "Monthly Average AQI", x = "Month", y = "Average AQI") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1))
  ggsave(output_path, width = 10, height = 6, dpi = 150)
}

# Correlation heatmap.
plot_correlation_heatmap <- function(df, output_path = "output/plots/correlation_heatmap.png") {
  corr_data <- df[, c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity", "AQI")]
  correlation_matrix <- cor(corr_data, use = "complete.obs")

  melted_corr <- as.data.frame(as.table(correlation_matrix))
  names(melted_corr) <- c("Var1", "Var2", "value")

  ggplot(melted_corr, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
    labs(title = "Correlation Heatmap", x = "", y = "", fill = "Correlation") +
    theme_minimal(base_size = 11) +
    theme(plot.title = element_text(face = "bold", hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1))
  ggsave(output_path, width = 10, height = 8, dpi = 150)
}

# Generate all required plots.
generate_visualizations <- function(df) {
  dir.create("output/plots", showWarnings = FALSE, recursive = TRUE)

  plot_aqi_trend(df, "output/plots/aqi_trend.png")
  plot_city_aqi(df, "output/plots/city_aqi.png")
  plot_pm25_vs_aqi(df, "output/plots/pm25_vs_aqi.png")
  plot_pm10_vs_aqi(df, "output/plots/pm10_vs_aqi.png")
  plot_aqi_category_distribution(df, "output/plots/aqi_categories.png")
  plot_monthly_aqi(df, "output/plots/monthly_aqi.png")
  plot_correlation_heatmap(df, "output/plots/correlation_heatmap.png")

  cat("\nAll visualizations saved to output/plots/\n")
}

# End of file

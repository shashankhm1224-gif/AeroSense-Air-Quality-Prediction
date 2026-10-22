# ==========================================================
# AQI Interpretation Helper
# ==========================================================

# Category based on a simple AQI threshold scheme.
get_aqi_category <- function(aqi_value) {
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

# Returns educational interpretation for AQI categories.
interpret_aqi <- function(aqi_value) {
  category <- get_aqi_category(aqi_value)

  interpretation <- switch(category,
    "Good" = "Air quality is generally satisfactory.",
    "Moderate" = "Air quality is acceptable, but some pollutants may affect sensitive people.",
    "Poor" = "Air quality may affect health-sensitive groups.",
    "Very Poor" = "Prolonged exposure may be harmful and outdoor activities may be uncomfortable.",
    "Severe" = "Air quality indicates a serious pollution level and should be treated seriously.",
    "Unknown" = "AQI value is unavailable or invalid."
  )

  list(
    category = category,
    interpretation = interpretation
  )
}

# End of file

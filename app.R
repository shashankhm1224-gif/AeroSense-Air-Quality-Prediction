# ============================================================
# AeroSense - Air Quality Intelligence & Prediction Platform
# Shiny dashboard built from the approved Stitch design direction.
# ============================================================

required_packages <- c("shiny", "bslib", "plotly", "DT", "dplyr", "readr", "shinyjs")
missing <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing) > 0) {
  stop(paste0(
    "Missing packages: ", paste(missing, collapse = ", "),
    ". Run install_packages.R first."
  ))
}

library(shiny)
library(bslib)
library(plotly)
library(DT)
library(dplyr)
library(readr)
library(shinyjs)

# Reuse the project's existing cleaning and analysis logic.
source("R/data_cleaning.R")
source("R/analysis.R")

raw_data <- read_air_quality_data <- readr::read_csv("air_quality_data.csv", show_col_types = FALSE)
data <- clean_air_quality_data(raw_data)
data$AQI_Category <- sapply(data$AQI, assign_aqi_category)

features <- c("PM2.5", "PM10", "NO2", "SO2", "CO", "O3", "Temperature", "Humidity")

set.seed(123)
model_data <- data[, c(features, "AQI")]
model_data <- model_data[complete.cases(model_data), ]
train_index <- sample(seq_len(nrow(model_data)), size = floor(0.8 * nrow(model_data)))
train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]
model <- lm(AQI ~ PM2.5 + PM10 + NO2 + SO2 + CO + O3 + Temperature + Humidity, data = train_data)
predictions <- predict(model, newdata = test_data)
actual <- test_data$AQI
errors <- actual - predictions
mae <- mean(abs(errors))
rmse <- sqrt(mean(errors^2))
r_squared <- summary(model)$r.squared
prediction_df <- data.frame(Actual = actual, Predicted = predictions, Residual = errors)

avg_aqi <- mean(data$AQI)
max_aqi <- max(data$AQI)
min_aqi <- min(data$AQI)
city_avg <- data %>% group_by(City) %>% summarise(AQI = mean(AQI), .groups = "drop") %>% arrange(desc(AQI))
highest_city <- city_avg$City[1]
lowest_city <- city_avg$City[nrow(city_avg)]
cor_matrix <- cor(data[, c(features, "AQI")], use = "complete.obs")
cor_aqi <- sort(cor_matrix[, "AQI"][-ncol(cor_matrix)], decreasing = TRUE)
strongest_factor <- names(cor_aqi)[1]
strongest_corr <- unname(cor_aqi[1])

fmt <- function(x, digits = 2) formatC(x, format = "f", digits = digits)
category_color <- function(category) {
  switch(category,
    "Good" = "#22C55E",
    "Moderate" = "#84CC16",
    "Poor" = "#F59E0B",
    "Very Poor" = "#F97316",
    "Severe" = "#EF4444",
    "#10B981"
  )
}

kpi_card <- function(label, value, sub = "", accent = "primary", badge = "") {
  div(class = "kpi-card",
    div(class = "kpi-top", span(label), if (badge != "") span(class = paste0("badge badge-", accent), badge)),
    div(class = paste0("kpi-value text-", accent), value),
    if (sub != "") div(class = "kpi-sub", sub)
  )
}

panel_box <- function(title, subtitle = NULL, ..., class = "") {
  div(class = paste("panel-box", class),
    div(class = "panel-header",
      div(h3(title), if (!is.null(subtitle)) div(class = "panel-subtitle", subtitle)),
      span(class = "panel-dot")
    ),
    ...
  )
}

sidebar_ui <- function() {
  div(class = "app-sidebar",
    div(class = "brand-block",
      div(class = "brand-mark", "A"),
      div(span(class = "brand-name", "AeroSense"), span(class = "brand-sub", "AIR QUALITY INTELLIGENCE"))
    ),
    div(class = "system-status", span(class = "live-dot"), "SYSTEM ONLINE"),
    div(class = "nav-caption", "ANALYTICS"),
    actionButton("nav_overview", "Overview", class = "nav-btn active"),
    actionButton("nav_city", "City Intelligence", class = "nav-btn"),
    actionButton("nav_pollution", "Pollution Analytics", class = "nav-btn"),
    actionButton("nav_prediction", "AQI Prediction", class = "nav-btn"),
    actionButton("nav_data", "Data Explorer", class = "nav-btn"),
    actionButton("nav_model", "Model Performance", class = "nav-btn"),
    actionButton("nav_insights", "Insights", class = "nav-btn"),
    div(class = "sidebar-bottom",
      div(class = "nav-caption", "PROJECT"),
      actionButton("nav_about", "About Project", class = "nav-btn"),
      div(class = "sidebar-foot", "ACADEMIC DATASET • NOT REAL-TIME")
    )
  )
}

ui <- fluidPage(
  theme = bs_theme(version = 5, bootswatch = "darkly", primary = "#10B981", bg = "#0F172A", fg = "#E2E8F0"),
  tags$head(
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
    tags$link(rel = "preconnect", href = "https://fonts.googleapis.com"),
    tags$link(rel = "preconnect", href = "https://fonts.gstatic.com", crossorigin = "anonymous"),
    tags$link(href = "https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;600&family=Inter:wght@400;500;600;700&display=swap", rel = "stylesheet"),
    tags$link(rel = "stylesheet", href = "styles.css")
  ),
  useShinyjs(),
  div(class = "app-shell",
    sidebar_ui(),
    div(class = "main-shell",
      div(class = "topbar",
        div(div(class = "eyebrow", "ENVIRONMENTAL INTELLIGENCE / DATA SCIENCE"), h1(textOutput("page_title"))),
        div(class = "topbar-right", span(class = "dataset-chip", "75 OBSERVATIONS"), span(class = "dataset-chip", "5 CITIES"))
      ),
      div(class = "page-container", uiOutput("page_content"))
    )
  )
)

server <- function(input, output, session) {
  current_page <- reactiveVal("Overview")

  observeEvent(input$nav_overview, current_page("Overview"))
  observeEvent(input$nav_city, current_page("City Intelligence"))
  observeEvent(input$nav_pollution, current_page("Pollution Analytics"))
  observeEvent(input$nav_prediction, current_page("AQI Prediction"))
  observeEvent(input$nav_data, current_page("Data Explorer"))
  observeEvent(input$nav_model, current_page("Model Performance"))
  observeEvent(input$nav_insights, current_page("Insights"))
  observeEvent(input$nav_about, current_page("About Project"))

  output$page_title <- renderText(current_page())

  observe({
    buttons <- c("overview", "city", "pollution", "prediction", "data", "model", "insights", "about")
    selected <- tolower(gsub(" ", "", current_page()))
    if (selected == "cityintelligence") selected <- "city"
    if (selected == "pollutionanalytics") selected <- "pollution"
    if (selected == "aqiprediction") selected <- "prediction"
    if (selected == "dataexplorer") selected <- "data"
    if (selected == "modelperformance") selected <- "model"
    for (b in buttons) {
      shinyjs::toggleClass(selector = paste0("#nav_", b), class = "active", condition = b == selected)
    }
  })

  output$page_content <- renderUI({
    page <- current_page()
    if (page == "Overview") {
      tagList(
        div(class = "kpi-grid",
          kpi_card("AVERAGE AQI", fmt(avg_aqi), "75-record aggregate", "tertiary", "POOR"),
          kpi_card("MAXIMUM AQI", fmt(max_aqi), "Peak observed reading", "error", "VERY POOR"),
          kpi_card("MINIMUM AQI", fmt(min_aqi), paste(lowest_city, "Eco-Zone"), "secondary", "LOWEST"),
          kpi_card("RISK EPICENTER", highest_city, paste0("μ = ", fmt(city_avg$AQI[1]), " AQI"), "error", "CRITICAL"),
          kpi_card("PRIMARY DRIVER", strongest_factor, paste0("Pearson r = +", fmt(strongest_corr, 3)), "primary", "ML VECTOR"),
          kpi_card("MLR FIT (R²)", paste0(fmt(r_squared * 100, 2), "%"), paste0("RMSE: ", fmt(rmse), " | MAE: ", fmt(mae)), "secondary", "HIGH CERTAINTY")
        ),
        div(class = "analytics-grid",
          panel_box("Aggregate AQI", "IND-AQI STANDARD",
            div(class = "gauge-wrap",
              plotlyOutput("overview_gauge", height = "300px")
            ),
            div(class = "aqi-scale",
              span(class = "good", "GOOD 0–50"), span(class = "moderate", "MOD 51–100"), span(class = "poor", "POOR 101–200"), span(class = "verypoor", "V.POOR 201–300"), span(class = "severe", "SEVERE 301+")
            ),
            div(class = "advisory", strong("Health Advisory"), p(paste0("The dataset-wide mean AQI is ", fmt(avg_aqi), " (", assign_aqi_category(avg_aqi), "). ",
              if (avg_aqi > 100) "Sensitive groups should consider limiting prolonged outdoor exertion." else "Check local conditions before making outdoor activity decisions.")))
          , class = "gauge-panel"),
          panel_box("Air Quality Trend", "DAILY OBSERVATIONS",
            plotlyOutput("overview_trend", height = "390px")
          )
        ),
        div(class = "two-col-grid",
          panel_box("City Risk Ranking", "AVERAGE AQI BY CITY", plotlyOutput("city_bar", height = "310px")),
          panel_box("Pollutant Overview", "DATASET MEANS", plotlyOutput("pollutant_bar", height = "310px"))
        )
      )
    } else if (page == "City Intelligence") {
      tagList(
        div(class = "section-intro", h2("City Intelligence"), p("Compare air-quality risk across all monitored cities.")),
        div(class = "two-col-grid", panel_box("City Risk Ranking", plotlyOutput("city_bar", height = "420px")), panel_box("City Statistics", DTOutput("city_table"))),
        panel_box("City AQI Trend", "SELECT A CITY", selectInput("city_filter", NULL, choices = sort(unique(data$City)), selected = highest_city, width = "240px"), plotlyOutput("city_trend", height = "390px"))
      )
    } else if (page == "Pollution Analytics") {
      tagList(
        div(class = "section-intro", h2("Pollution Analytics"), p("Explore pollutant relationships, averages and correlation with AQI.")),
        div(class = "two-col-grid", panel_box("Correlation Heatmap", "PEARSON CORRELATION", plotlyOutput("heatmap", height = "460px")), panel_box("Pollutant Mean Levels", plotlyOutput("pollutant_bar", height = "460px"))),
        panel_box("AQI Drivers", "CORRELATION WITH AQI", DTOutput("correlation_table"))
      )
    } else if (page == "AQI Prediction") {
      tagList(
        div(class = "section-intro", h2("AQI Prediction Engine"), p("Enter pollutant and weather conditions to estimate AQI using Multiple Linear Regression.")),
        div(class = "prediction-layout",
          div(class = "prediction-form panel-box",
            h3("Inference Inputs"),
            div(class = "input-grid",
              numericInput("pm25", "PM2.5", 120, min = 0), numericInput("pm10", "PM10", 175, min = 0),
              numericInput("no2", "NO2", 80, min = 0), numericInput("so2", "SO2", 40, min = 0),
              numericInput("co", "CO", 1.2, min = 0), numericInput("o3", "O3", 45, min = 0),
              numericInput("temperature", "Temperature °C", 20, min = -50), numericInput("humidity", "Humidity %", 50, min = 0, max = 100)
            ),
            actionButton("predict", "RUN AQI PREDICTION", class = "predict-btn")
          ),
          div(class = "prediction-result panel-box", uiOutput("prediction_result"), plotlyOutput("prediction_gauge", height = "330px"))
        ),
        panel_box("Model Specification", "CURRENT ENGINE", DTOutput("model_spec"))
      )
    } else if (page == "Data Explorer") {
      tagList(
        div(class = "section-intro", h2("Data Explorer"), p("Browse the cleaned academic dataset used by the dashboard.")),
        panel_box("Air Quality Dataset", paste(nrow(data), "rows ×", ncol(data), "variables"), DTOutput("data_table"))
      )
    } else if (page == "Model Performance") {
      tagList(
        div(class = "kpi-grid model-kpis", kpi_card("MAE", fmt(mae), "Mean absolute error", "primary"), kpi_card("RMSE", fmt(rmse), "Root mean squared error", "tertiary"), kpi_card("R²", fmt(r_squared, 4), "Training fit", "secondary"), kpi_card("TEST ROWS", nrow(test_data), "20% holdout", "primary")),
        div(class = "two-col-grid", panel_box("Actual vs Predicted", "TEST SET", plotlyOutput("actual_predicted", height = "390px")), panel_box("Residual Diagnostics", "ACTUAL − PREDICTED", plotlyOutput("residual_plot", height = "390px"))),
        panel_box("Model Summary", "MULTIPLE LINEAR REGRESSION", DTOutput("model_table"))
      )
    } else if (page == "Insights") {
      tagList(
        div(class = "section-intro", h2("Analytical Insights"), p("Key findings automatically derived from the current dataset.")),
        div(class = "insight-grid",
          div(class = "insight-card", span("01"), h3("Highest Risk City"), strong(highest_city), p(paste0("Average AQI of ", fmt(city_avg$AQI[1]), "."))),
          div(class = "insight-card", span("02"), h3("Lowest Risk City"), strong(lowest_city), p(paste0("Average AQI of ", fmt(city_avg$AQI[nrow(city_avg)]), "."))),
          div(class = "insight-card", span("03"), h3("Dominant AQI Factor"), strong(strongest_factor), p(paste0("Pearson correlation = ", fmt(strongest_corr, 3), "."))),
          div(class = "insight-card", span("04"), h3("Model Reliability"), strong(paste0(fmt(r_squared * 100, 2), "% R²")), p("R² is calculated on the training split; review the held-out MAE and RMSE before judging generalisation. Results are based on a small academic dataset."))
        )
      )
    } else {
      tagList(
        div(class = "section-intro", h2("About AeroSense"), p("A polished R/Shiny implementation of the approved Stitch dashboard design.")),
        panel_box("Project Overview",
          div(class = "about-copy",
            p(strong("AeroSense"), " is an academic air-quality analysis and prediction platform built around a 75-record dataset covering Delhi, Mumbai, Pune, Chandigarh and Bengaluru."),
            p("The platform combines data cleaning, exploratory analysis, correlation analysis and Multiple Linear Regression into one interactive dashboard."),
            p(strong("Important:"), " the dataset is academic/sample data and the dashboard is not a real-time pollution monitoring system."),
            div(class = "tech-tags", span("R"), span("Shiny"), span("Plotly"), span("dplyr"), span("Multiple Linear Regression"), span("Data Visualization"))
          )
        )
      )
    }
  })

  output$overview_gauge <- renderPlotly({
    plot_ly(type = "indicator", mode = "gauge+number", value = avg_aqi,
      number = list(font = list(size = 46, color = "#E2E8F0"), suffix = " AQI"),
      gauge = list(axis = list(range = list(0, 500), tickcolor = "#64748B"),
        bar = list(color = category_color(assign_aqi_category(avg_aqi))),
        bgcolor = "#0F172A", borderwidth = 1, bordercolor = "#334155",
        steps = list(
          list(range = c(0, 50), color = "#16351F"), list(range = c(50, 100), color = "#263D18"),
          list(range = c(100, 200), color = "#3B2D0A"), list(range = c(200, 300), color = "#3C2110"), list(range = c(300, 500), color = "#3A151A")
        )
      )) %>% layout(paper_bgcolor = "rgba(0,0,0,0)", font = list(color = "#E2E8F0"), margin = list(l = 20, r = 20, t = 20, b = 20))
  })

  output$overview_trend <- renderPlotly({
    p <- plot_ly(data, x = ~Date, y = ~AQI, type = "scatter", mode = "lines+markers", line = list(color = "#10B981", width = 2), marker = list(size = 5, color = "#10B981"))
    p %>% layout(xaxis = list(title = "", gridcolor = "#334155"), yaxis = list(title = "AQI", gridcolor = "#334155"), shapes = list(list(type = "line", x0 = min(data$Date), x1 = max(data$Date), y0 = 100, y1 = 100, line = list(color = "#10B981", dash = "dash"))), paper_bgcolor = "rgba(0,0,0,0)", plot_bgcolor = "rgba(0,0,0,0)", font = list(color = "#CBD5E1"), margin = list(l = 45, r = 15, t = 10, b = 40))
  })

  output$city_bar <- renderPlotly({
    plot_ly(city_avg, x = ~AQI, y = ~reorder(City, AQI), type = "bar", orientation = "h", marker = list(color = "#10B981")) %>% layout(xaxis = list(title = "Average AQI", gridcolor = "#334155"), yaxis = list(title = ""), paper_bgcolor = "rgba(0,0,0,0)", plot_bgcolor = "rgba(0,0,0,0)", font = list(color = "#CBD5E1"), margin = list(l = 85, r = 20, t = 10, b = 40))
  })

  output$pollutant_bar <- renderPlotly({
    means <- colMeans(data[, features])
    dd <- data.frame(Pollutant = names(means), Mean = as.numeric(means))
    plot_ly(dd, x = ~Pollutant, y = ~Mean, type = "bar", marker = list(color = "#10B981")) %>% layout(xaxis = list(title = "", tickangle = -35), yaxis = list(title = "Mean level", gridcolor = "#334155"), paper_bgcolor = "rgba(0,0,0,0)", plot_bgcolor = "rgba(0,0,0,0)", font = list(color = "#CBD5E1"), margin = list(l = 45, r = 15, t = 10, b = 70))
  })

  output$city_table <- renderDT({
    datatable(transform(city_avg, Average_AQI = round(AQI, 2), AQI = NULL), rownames = FALSE, options = list(pageLength = 5, dom = "t"), class = "compact stripe")
  })

  output$city_trend <- renderPlotly({
    req(input$city_filter)
    dd <- data %>% filter(City == input$city_filter)
    plot_ly(dd, x = ~Date, y = ~AQI, type = "scatter", mode = "lines+markers", line = list(color = "#10B981", width = 2)) %>% layout(xaxis = list(title = "", gridcolor = "#334155"), yaxis = list(title = "AQI", gridcolor = "#334155"), paper_bgcolor = "rgba(0,0,0,0)", plot_bgcolor = "rgba(0,0,0,0)", font = list(color = "#CBD5E1"))
  })

  output$heatmap <- renderPlotly({
    m <- cor_matrix
    plot_ly(x = colnames(m), y = colnames(m), z = m, type = "heatmap", colors = c("#EF4444", "#0F172A", "#10B981"), zmin = -1, zmax = 1) %>% layout(paper_bgcolor = "rgba(0,0,0,0)", plot_bgcolor = "rgba(0,0,0,0)", font = list(color = "#CBD5E1"), margin = list(l = 90, r = 20, t = 20, b = 90))
  })

  output$correlation_table <- renderDT({
    corr <- data.frame(Factor = names(cor_aqi), Correlation_with_AQI = round(as.numeric(cor_aqi), 4))
    datatable(corr, rownames = FALSE, options = list(pageLength = 8, dom = "t"), class = "compact stripe")
  })

  output$data_table <- renderDT({
    datatable(data, rownames = FALSE, filter = "top", options = list(pageLength = 10, scrollX = TRUE), class = "compact stripe")
  })

  prediction_value <- reactiveVal(NULL)
  observeEvent(input$predict, {
    new_data <- data.frame(
      PM2.5 = input$pm25, PM10 = input$pm10, NO2 = input$no2, SO2 = input$so2,
      CO = input$co, O3 = input$o3, Temperature = input$temperature, Humidity = input$humidity
    )
    prediction_value(round(as.numeric(predict(model, newdata = new_data)), 2))
  })

  output$prediction_result <- renderUI({
    value <- prediction_value()
    if (is.null(value)) {
      return(div(class = "prediction-placeholder", h3("Ready for inference"), p("Enter environmental conditions and run the prediction engine.")))
    }
    catg <- assign_aqi_category(value)
    div(class = "prediction-readout", span("PREDICTED AQI"), strong(fmt(value)), div(class = "prediction-category", style = paste0("color:", category_color(catg)), catg), p("Estimated from the fitted model; academic dataset, not an official AQI reading."))
  })

  output$prediction_gauge <- renderPlotly({
    value <- prediction_value()
    if (is.null(value)) value <- avg_aqi
    catg <- assign_aqi_category(value)
    plot_ly(type = "indicator", mode = "gauge+number", value = value, number = list(font = list(size = 42, color = "#E2E8F0")), gauge = list(axis = list(range = list(0, 500)), bar = list(color = category_color(catg)), bgcolor = "#0F172A", bordercolor = "#334155")) %>% layout(paper_bgcolor = "rgba(0,0,0,0)", margin = list(l = 25, r = 25, t = 10, b = 10))
  })

  output$model_spec <- renderDT({
    datatable(data.frame(Feature = features, Role = rep("Predictor", length(features))), rownames = FALSE, options = list(dom = "t", pageLength = 8))
  })

  output$model_table <- renderDT({
    datatable(data.frame(Metric = c("Model", "Training rows", "Testing rows", "MAE", "RMSE", "R-squared"), Value = c("Multiple Linear Regression", nrow(train_data), nrow(test_data), fmt(mae, 4), fmt(rmse, 4), fmt(r_squared, 4))), rownames = FALSE, options = list(dom = "t"))
  })

  output$actual_predicted <- renderPlotly({
    plot_ly(prediction_df, x = ~Actual, y = ~Predicted, type = "scatter", mode = "markers", marker = list(color = "#10B981", size = 9)) %>% add_lines(x = ~Actual, y = ~Actual, line = list(color = "#F59E0B", dash = "dash"), name = "Ideal") %>% layout(xaxis = list(title = "Actual AQI", gridcolor = "#334155"), yaxis = list(title = "Predicted AQI", gridcolor = "#334155"), paper_bgcolor = "rgba(0,0,0,0)", plot_bgcolor = "rgba(0,0,0,0)", font = list(color = "#CBD5E1"))
  })

  output$residual_plot <- renderPlotly({
    plot_ly(prediction_df, x = ~Predicted, y = ~Residual, type = "scatter", mode = "markers", marker = list(color = "#10B981", size = 9)) %>% add_lines(x = ~Predicted, y = 0, line = list(color = "#EF4444", dash = "dash"), name = "Zero") %>% layout(xaxis = list(title = "Predicted AQI", gridcolor = "#334155"), yaxis = list(title = "Residual", gridcolor = "#334155"), paper_bgcolor = "rgba(0,0,0,0)", plot_bgcolor = "rgba(0,0,0,0)", font = list(color = "#CBD5E1"))
  })
}

shinyApp(ui, server)

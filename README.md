# Air Quality Analysis & Prediction

## 1. Project Title
Air Quality Analysis & Prediction

## 2. Introduction
This project is an academic mini project for MCA Data Science students. It demonstrates a complete data science workflow in R, from loading raw data to cleaning, analysis, visualization, and machine learning. The objective is to understand how different pollutants and environmental variables affect Air Quality Index (AQI) and to build a simple prediction model.

## 3. Problem Statement
Air pollution is a serious concern in many cities. The project analyzes air-quality data and identifies major factors influencing AQI. It also builds a regression model to predict AQI based on pollutant concentration and weather conditions.

## 4. Objectives
- Load and inspect air-quality CSV data
- Clean missing values and invalid entries
- Perform descriptive statistics and AQI analysis
- Study correlations between AQI and pollutant variables
- Generate meaningful visualizations
- Build a Multiple Linear Regression model
- Evaluate prediction accuracy using MAE, RMSE, and R-squared
- Save results and plots

## 5. Features
- Local sample dataset with realistic values
- Data cleaning and missing value handling
- AQI category classification
- Correlation matrix analysis
- ggplot2 visualizations
- Multiple linear regression prediction
- Console-based menu interface
- Exported results and plots

## 6. Dataset Description
The project uses a sample local dataset named `air_quality_data.csv`. It includes:

- Date
- City
- PM2.5
- PM10
- NO2
- SO2
- CO
- O3
- Temperature
- Humidity
- AQI

The dataset contains several months of realistic values across multiple Indian cities such as Delhi, Mumbai, Pune, Chandigarh, and Bengaluru. It includes a small number of missing values intentionally to demonstrate cleaning steps.

## 7. Technologies Used
- R programming language
- RStudio / VS Code with R installed
- Base R functions
- ggplot2 for visualization
- dplyr for data transformation
- tidyr for reshaping and cleaning
- readr for reading CSV files
- lubridate for date handling

## 8. R Packages Used
- ggplot2
- dplyr
- tidyr
- readr
- lubridate

## 9. Project Structure

Air_Quality_Analysis_Prediction/
├── main.R
├── air_quality_data.csv
├── README.md
├── requirements.txt
├── R/
│   ├── data_cleaning.R
│   ├── analysis.R
│   ├── visualization.R
│   ├── prediction.R
│   └── interpretation.R
├── output/
│   ├── plots/
│   └── results/
└── report/
    └── project_summary.txt

## 10. Data Cleaning
The cleaning process includes:
- Reading the CSV file
- Checking dimensions and columns
- Identifying missing values
- Converting date strings to Date format
- Converting numeric columns correctly
- Handling missing values using median imputation
- Removing duplicate entries
- Validating AQI values before analysis

## 11. Exploratory Data Analysis
The analysis includes:
- Mean, median, minimum, maximum, and standard deviation
- Average AQI by city
- Highest and lowest AQI days
- AQI category classification
- City-wise AQI comparisons

## 12. Visualization
The project creates visualizations such as:
- AQI trend over time
- Average AQI by city
- PM2.5 vs AQI scatter plot
- PM10 vs AQI scatter plot
- AQI category distribution
- Monthly average AQI
- Correlation heatmap

All plots are saved in the `output/plots` folder.

## 13. Machine Learning
The project uses a supervised regression approach to predict AQI. The input variables are pollutant concentrations and environmental variables such as PM2.5, PM10, NO2, SO2, CO, O3, Temperature, and Humidity.

## 14. Multiple Linear Regression
The primary model is Multiple Linear Regression using the `lm()` function in R.

- Data is split into training and testing sets
- Model is trained on 80% of the data
- Predictions are generated for the 20% test set
- Performance is evaluated using MAE, RMSE, and R-squared

## 15. Model Evaluation
Model quality is assessed using:
- Mean Absolute Error (MAE)
- Root Mean Square Error (RMSE)
- R-squared

These metrics are displayed in the console and saved to the results folder.

## 16. How to Install
Open R or RStudio and install the required packages:

install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("readr")
install.packages("lubridate")

## 17. How to Run
1. Open the project folder in RStudio or VS Code with R installed.
2. Set the working directory to the project root.
3. Run the main script:

source("main.R")

4. Use the menu to explore dataset summary, descriptive analysis, correlations, plots, and model results.

## 18. Expected Output
When the project runs successfully, it creates:
- plots in `output/plots/`
- results in `output/results/`
- project summary in `report/project_summary.txt`

## 19. Limitations
- The dataset is sample data for academic demonstration.
- It is not a real-time monitoring dataset.
- The predictive model is simple and suitable for learning, not industrial deployment.

## 20. Future Scope
- Add more cities and years of data
- Compare different machine learning models
- Build a Shiny dashboard for interactive analysis
- Add time-series forecasting for AQI

## 21. Viva Topics
Students can explain:
- Data frame creation and data cleaning
- Missing value handling using median imputation
- Correlation analysis and interpretation
- ggplot2 visualizations
- Train/test split
- Linear regression model
- Prediction and evaluation metrics
- Real-world significance of AQI monitoring

## 22. Notes
This project is intended for educational use and is easy to explain during viva, while also covering the major workflow of a data science project in R.

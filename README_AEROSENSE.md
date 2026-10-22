# AeroSense — Air Quality Intelligence & Prediction Platform

This project upgrades the original `Air_Quality_Analysis_Prediction` R mini-project with an interactive R/Shiny dashboard based on the approved Stitch design direction.

## Visual system

The dashboard uses the selected Soft Dashboard Minimalist palette:
- Primary / shell: `#0F172A` (Dark Navy)
- Secondary / text and subtle contrast: `#E2E8F0` (Light Steel / Ice Blue)
- Accent / healthy status and focus: `#10B981` (Emerald Green)

Responsive styling is provided in `www/styles.css`. Existing Stitch references, the CSV dataset, R analysis scripts, reports, plots and model-result files are retained.

## What was added

- Premium dark Environmental Intelligence UI
- Overview dashboard with KPI cards and AQI gauge
- City Intelligence page
- Pollution Analytics + correlation heatmap
- AQI Prediction Engine using Multiple Linear Regression
- Model Performance page with MAE, RMSE, R², actual-vs-predicted and residual diagnostics
- Data Explorer with filtering
- Automatically generated insights
- Stitch reference screens/code preserved under `stitch_reference/`

## Dataset

The existing `air_quality_data.csv` is preserved. It contains 75 academic/sample observations across Delhi, Mumbai, Pune, Chandigarh and Bengaluru.

## Run in VS Code / PowerShell

Open the **inner** `Air_Quality_Analysis_Prediction` folder in VS Code (the folder containing `app.R` and `air_quality_data.csv`).

From that folder in PowerShell:

```powershell
& "C:\Program Files\R\R-4.6.1\bin\Rscript.exe" install_packages.R
& "C:\Program Files\R\R-4.6.1\bin\Rscript.exe" -e "shiny::runApp('.')"
```

Then open the local address shown by R, normally `http://127.0.0.1:XXXX`.

If the browser was already open before changing CSS, refresh with **Ctrl + F5**. To stop the local server, return to the PowerShell terminal and press **Ctrl + C**.

## Important

This is academic/sample data. AeroSense is not a real-time pollution monitoring system and should not be presented as one.

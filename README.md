**Modeling and Forecasting Volatility of DS30 Index Using Time Series Models**
This repository contains the data and Stata do-files used for the internship report titled "Modeling and Forecasting Volatility of DS30 Index Using Time Series Models."

**Overview**
This report models the monthly volatility of the DS30 index (Dhaka Stock Exchange 30 index) using time series analysis. The analysis spans from January 2013 to June 2024. Various ARMA-ARCH, ARMA-GARCH, ARMA-EGARCH, and TGARCH models are estimated and compared to identify the most accurate model for estimating the volatility of Bangladesh's primary blue-chip index. The findings are valuable for analysts, portfolio managers, and retail investors seeking to understand and forecast DS30 index volatility.

**Repository Contents**
.dta files: These files contain the raw and processed data for the DS30 index.

.do files: These Stata do-files contain the commands used for data cleaning, transformation, model estimation, and forecasting.

**Methodology**
The methodology involves:

Data Collection: Daily closing prices for the DS30 index from January 2014 to June 2024 were collected and averaged to monthly frequency.

Unit Root Test: Augmented Dickey-Fuller (ADF) test was performed to check for stationarity.

Box-Jenkins Method for ARIMA Model Selection: ARIMA models were estimated, and model selection was based on Autocorrelation Function (ACF), Partial Autocorrelation (PACF), Portmanteau Q Test, Akaike Information Criterion (AIC), and Bayesian Information Criterion (BIC).

Lagrange Multiplier Test for ARCH effects: This test was conducted to detect heteroskedasticity in the residuals.

Model Estimation and Selection: A range of volatility models (ARCH, GARCH, EGARCH, TGARCH, and their ARMA-integrated versions) were estimated. The EGARCH(3,1) model was identified as the most efficient.

Forecast: Future volatility of the DS30 index is forecasted based on the selected model.

**Key Findings**
The EGARCH(3,1) model most accurately estimates the volatility of the DS30 index over the sample period.

ARMA integrated volatility models generally showed lower AIC/BIC scores, indicating better fit.

The forecasted volatility for the next six months suggests a less volatile period, making DS30 stocks potentially stable assets for investors.

**How to Use**
To replicate the analysis or run the models:

-Download the .dta data files and .do Stata script files from this repository.

-Open the .do files in Stata 17 (or a compatible version).

-Execute the commands in the .do files sequentially.

**Contact**
Shadman Saquib Rahman
Department of Economics, University of Dhaka
Intern, Financial Stability Department, Bangladesh Bank

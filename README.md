# RDU Air Quality 2018–2020

**Author:** Lanbu Xi  
**Date:** 2026-11-22

## Overview

This project cleans and summarizes daily CO, PM2.5, and ozone measurements from the course-provided RDU air quality files. The 2018 and 2019 files cover the full year; the 2020 file ends in April.

## Files

- `data/AQ_2018.csv`, `data/AQ_2019.csv`, `data/AQ_2020.csv`: original data
- `process_air_quality.R`: function that cleans one yearly file and calculates daily means
- `Xi_Lanbu_Project2.Rmd`: report source with tables and plots
- `Xi_Lanbu_Project2.docx`: knitted Word report

## How to reproduce the report

1. Open `biostats721-project2.Rproj` in RStudio.
2. Install the R packages `rmarkdown`, `knitr`, `dplyr`, `tidyr`, and `ggplot2` if needed.
3. Open `Xi_Lanbu_Project2.Rmd` and click **Knit** to create the Word report.

The report uses paths relative to the project folder, so the `data` folder and `process_air_quality.R` must remain in this project.
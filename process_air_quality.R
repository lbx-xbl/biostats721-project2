# Process one year of RDU air quality measurements.
# file_path: path to a yearly CSV file.
# ozone_unit: desired O3 unit, "ppm" (default) or "ppb".
# Returns: one row per date with daily mean pollutant concentrations.
process_air_quality <- function(file_path, ozone_unit = "ppm") {
  ozone_unit <- match.arg(ozone_unit, c("ppm", "ppb"))
  
  dat <- read.csv(file_path, check.names = FALSE)
  
  # Remove exact duplicate records before calculating daily averages.
  dat <- unique(dat)
  
  names(dat)[c(1, 2, 4, 6)] <- c(
    "date", "co_ppm", "pm25_ug_m3", "o3"
  )
  dat <- dat[, c("date", "co_ppm", "pm25_ug_m3", "o3")]
  dat$date <- as.Date(dat$date, format = "%m/%d/%Y")
  
  # Correct negative measurements before calculating daily averages.
  for (pollutant in c("co_ppm", "pm25_ug_m3", "o3")) {
    dat[[pollutant]][which(dat[[pollutant]] < 0)] <- 0
  }
  
  # Average multiple measurements from the same day.
  # Keep NA when every measurement for that day is missing.
  dat <- aggregate(
    dat[c("co_ppm", "pm25_ug_m3", "o3")],
    by = list(date = dat$date),
    FUN = function(x) {
      if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)
    }
  )
  
  if (ozone_unit == "ppb") {
    dat$o3 <- dat$o3 * 1000
  }
  names(dat)[names(dat) == "o3"] <- paste0("o3_", ozone_unit)
  
  dat
}
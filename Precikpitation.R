urls <- c(
    "https://odp.met.hu/climate/observations_hungary/daily_rain/historical/HABP_1RD_67203_20020101_20251231_hist.zip",
    "https://odp.met.hu/climate/observations_hungary/daily_rain/historical/HABP_1RD_66523_20210101_20251231_hist.zip"
)

for (url in urls) {

  zipfile <- tempfile(fileext = ".zip")

  download.file(url, zipfile, mode = "wb")

  csvfile <- unzip(zipfile, list = TRUE)$Name

  unzip(zipfile, exdir = tempdir())

  adat <- read.csv(file.path(tempdir(), csvfile))
  
  # itt dolgozhatsz az adat objektummal
  print(head(adat))
}

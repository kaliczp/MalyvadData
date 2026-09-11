urls <- c(
    P67203 = "https://odp.met.hu/climate/observations_hungary/daily_rain/historical/HABP_1RD_67203_20020101_20251231_hist.zip",
    P66523 = "https://odp.met.hu/climate/observations_hungary/daily_rain/historical/HABP_1RD_66523_20210101_20251231_hist.zip"
)
## 67207
## 67113
## 67522

for (urlnr in 1:length(urls)) {

  zipfilename <- paste0(names(urls)[urlnr], ".zip")

  download.file(urls[urlnr], zipfilename, mode = "wb")

} 

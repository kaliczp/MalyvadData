urls <- c(
    P67203 = "https://odp.met.hu/climate/observations_hungary/daily_rain/historical/HABP_1RD_67203_20020101_20251231_hist.zip",
    P66523 = "https://odp.met.hu/climate/observations_hungary/daily_rain/historical/HABP_1RD_66523_20210101_20251231_hist.zip",
    P67207 = "https://odp.met.hu/climate/observations_hungary/daily/historical/HABP_1D_67207_20120901_20251231_hist.zip",
    P67113 = "https://odp.met.hu/climate/observations_hungary/daily/historical/HABP_1D_67113_20120901_20251231_hist.zip",
    P66613 = "https://odp.met.hu/climate/observations_hungary/daily/historical/HABP_1D_66613_20120901_20251231_hist.zip",
    P66522 = "https://odp.met.hu/climate/observations_hungary/daily/historical/HABP_1D_66522_20191213_20251231_hist.zip"
)

for (urlnr in 1:length(urls)) {
  ## Zipfile név gyártás
  zipfilename <- paste0(names(urls)[urlnr], ".zip")
  ## Letöltés
  download.file(urls[urlnr], zipfilename, mode = "wb")
} 

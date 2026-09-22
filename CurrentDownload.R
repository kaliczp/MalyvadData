urls <- c(
    P67203akt = "https://odp.met.hu/climate/observations_hungary/daily_rain/recent/HABP_1RD_67203_akt.zip",
    P66523akt = "https://odp.met.hu/climate/observations_hungary/daily_rain/recent/HABP_1RD_66523_akt.zip",
    P67207akt = "https://odp.met.hu/climate/observations_hungary/daily/recent/HABP_1D_67207_akt.zip",
    P67113akt = "https://odp.met.hu/climate/observations_hungary/daily/recent/HABP_1D_67113_akt.zip",
    P66613akt = "https://odp.met.hu/climate/observations_hungary/daily/recent/HABP_1D_66613_akt.zip",
    P66522akt = "https://odp.met.hu/climate/observations_hungary/daily/recent/HABP_1D_66522_akt.zip"
)

for (urlnr in 1:length(urls)) {
  ## Zipfile név gyártás
  zipfilename <- paste0(names(urls)[urlnr], ".zip")
  ## Letöltés
  download.file(urls[urlnr], zipfilename, mode = "wb")
} 

MStation <- "Szeged"
MStationNum <- 58116

zipfilenames <- c(HistCsap = paste0("r_h_", MStation, "_18702025.csv.zip"),
                  HistTemp = paste0("t_h_", MStation, "_18702025.csv.zip"),
                  Akt = paste0("HABP_1D_", MStationNum, "_akt.zip")
                  )

## Common URLs
HistURL <- "https://odp.met.hu/climate/homogenized_data/station_data_series/"
HistURLMid <- c(Prec = "from_1870/precipitation_sum/", Temp <- "from_1870/precipitation_sum/")
AktURL <- "https://odp.met.hu/climate/observations_hungary/daily/recent/"

urls <- paste0(HistCsap = paste0(HistURL, HistURLMid["Prec"], zipfilenames["HistCsap"])
urls <- c(urls, paste0(HistCsap = paste0(HistURL, HistURLMid["Prec"], zipfilenames["HistCsap"]))
urls <- c(urls, Akt = "https://odp.met.hu/climate/observations_hungary/daily_rain/recent/HABP_1RD_13713_akt.zip")
zipfilename <- paste0(names(urls)[urlnr], ".zip")
## If not downloaded
if(!any(dir(patt="zip") == zipfilenames["HistCsap"])) {
    download.file(urls["HistCsap"], zipfilename, mode = "wb")
}
if(!any(dir(patt="zip") == "58116")) {
    download.file(urls["Akt"], zipfilename, mode = "wb")
}

csvfile <- unzip(zipfilename, list = TRUE)$Name
unzip(zipfilename, exdir = tempdir())
adat <- read.table(file.path(tempdir(), csvfile), sep = ";", head = TRUE)
csvfile <- unzip(zipfilename, list = TRUE)$Name
unzip(zipfilename, exdir = tempdir())
adat_akt <- read.table(file.path(tempdir(), csvfile), sep = ";", head = TRUE)
finalobjectname <- paste0("P", adat[1, "StationNumber"], ".xts")
assign(finalobjectname, xts(c(adat$r,adat_akt$r) ,as.Date(as.character(c(adat$Time,adat_akt$Time)), format = "%Y%m%d")))
annual_hydro <- HydYearUntilNow(P.xts, "10-31")
barplot(zoo(annual_hydro$V1, annual_hydro[,"HY"]), main = "Sopron", col = "lightblue", xaxs = "i")

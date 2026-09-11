library(xts)
zipfiles <- dir(patt="zip")

for (zipfile in zipfiles) {
    ## Fájl név kinyerése
    csvfile <- unzip(zipfile, list = TRUE)$Name
    ## Kicsomagolás átmeneti könyvtárba
    unzip(zipfile, exdir = tempdir())
    ## Adatsor kibontása
    adat <- read.table(file.path(tempdir(), csvfile), sep = ";", head = TRUE)
    ## Végső objektumnév legyártása a zipfájl nevéből
    finalobjectname <- paste0("P", adat[1, "StationNumber"], ".xts")
    ## Idősor
    assign(finalobjectname, xts(adat$r ,as.Date(as.character(adat$Time), format = "%Y%m%d")))
}

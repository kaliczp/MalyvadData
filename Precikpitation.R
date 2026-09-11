zipfiles <- dir(patt="zip")

for (zipfile in zipfiles) {

  csvfile <- unzip(zipfile, list = TRUE)$Name

  unzip(zipfile, exdir = tempdir())

  adat <- read.csv(file.path(tempdir(), csvfile))
  
  # itt dolgozhatsz az adat objektummal
  print(head(adat))
}

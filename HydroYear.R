### Hidrológiai évre
## Év kinyerése
hydro_year <- as.numeric(format(index(AllPrec.xts), "%Y"))
## Plusz egy november–decemberre
hydro_year[format(index(AllPrec.xts), "%m") == "11" |
           format(index(AllPrec.xts), "%m") == "12"] <-
  hydro_year[format(index(AllPrec.xts), "%m") == "11" |
             format(index(AllPrec.xts), "%m") == "12"] + 1

annual_hydro <- aggregate.data.frame(
  x = AllPrec.xts,
  list(HY = hydro_year),
  sum,
  na.rm = TRUE
)

### Hidrológiai évre adott időig
HydYearUntilNow <- function(x, untilday = format(Sys.Date(), "%m-%d")) {
    MonthDay <- format(index(x), "%m-%d")
    x_noSepOct <- x[MonthDay <= untilday | MonthDay >= "11-01"]
### A hidrológiai évek lehatárolása
    ## Az untilday-ig csonkolt idősor indexe
    hydro_year <- as.numeric(format(index(x_noSepOct), "%Y"))
    ## Plusz egy év az előző év november–decemberre
hydro_year[format(index(x_noSepOct), "%m") == "11" |
           format(index(x_noSepOct), "%m") == "12"] <-
  hydro_year[format(index(x_noSepOct), "%m") == "11" |
             format(index(x_noSepOct), "%m") == "12"] + 1
    ## A hidrológiai évre aggregált adatsor
    aggregate.data.frame(
        x = x_noSepOct,
        list(HY = hydro_year),
        sum,
        na.rm = TRUE
    )
}

## Aug 31-ig a haviakkal
annual_hydro <- HydYearUntilNow(AllPrec.xts, "08-31")
## Máig a folyamatosakkal
annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/",c("P66522.xts", "P67113.xts", "P67207.xts")])

pdf(width = 14)
for(actCol in colnames(annual_hydro[-1])) {
    Actual <- annual_hydro[,actCol]
    barplot(zoo(Actual, annual_hydro[,"HY"]), main = sub(".xts", "", actCol), col = "lightblue")
    axis(2, as.numeric(tail(Actual,1)), tck = 1, lab = "")
}
dev.off()

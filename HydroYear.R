### Összeg hidrológiai évre beállítható időig
HydYearUntilNow <- function(x, untilday = format(Sys.Date(), "%m-%d")) {
    MonthDay <- format(index(x), "%m-%d")
    if(untilday == "10-31" | untilday == NULL) {
        x_noRest = x
    } else {
        x_noRest <- x[MonthDay <= untilday | MonthDay >= "11-01"]
    }
### A hidrológiai évek lehatárolása
    ## Az untilday-ig csonkolt idősor indexe, év kinyerése
    hydro_year <- as.numeric(format(index(x_noRest), "%Y"))
    ## Plusz egy év az előző év november–decemberre
    hydro_year[format(index(x_noRest), "%m") == "11" |
               format(index(x_noRest), "%m") == "12"] <-
        hydro_year[format(index(x_noRest), "%m") == "11" |
                   format(index(x_noRest), "%m") == "12"] + 1
    ## A hidrológiai évre aggregált adatsor
    aggregate.data.frame(
        x = x_noRest,
        list(HY = hydro_year),
        sum,
        na.rm = TRUE
    )
}

### Hidrológiai évre
## Teljes hidrológiai évre
annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/",c("P66522.xts", "P67113.xts", "P67207.xts")], "10-31")
## Aug 31-ig a haviakkal
annual_hydro <- HydYearUntilNow(AllPrec.xts, "08-31")
## Máig a folyamatosakkal
annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/",c("P66522.xts", "P67113.xts", "P67207.xts")])

## Egy adatsor ábrázolása
pdf(width = 14)
for(actCol in colnames(annual_hydro[-1])) {
    Actual <- annual_hydro[,actCol]
    barplot(zoo(Actual, annual_hydro[,"HY"]), main = sub(".xts", "", actCol), col = "lightblue")
    axis(2, as.numeric(tail(Actual,1)), tck = 1, lab = "")
}
dev.off()

## Két adatsor egymáson ábrázolása
pdf(width = 14)
annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/",c("P66522.xts", "P67113.xts", "P67207.xts")])
winterseason_hydro <- HydYearUntilNow(AllPrec.xts["2014/",c("P66522.xts", "P67113.xts", "P67207.xts")], "04-30")
for(actCol in colnames(annual_hydro[-1])) {
    Actual <- annual_hydro[,actCol]
    barplot(zoo(Actual, annual_hydro[,"HY"]),
            main = sub(".xts", "", actCol), col = "orange")
    barplot(zoo(winterseason_hydro[,actCol], winterseason_hydro[,"HY"]),
            main = "", col = "lightblue",
            xlab = "", ylab = "", axes = FALSE,
            add = TRUE)
    axis(2, as.numeric(tail(Actual,1)), tck = 1, lab = "")
}
dev.off()

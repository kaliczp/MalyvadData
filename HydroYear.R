### Összeg hidrológiai évre beállítható időig
HydYearUntilNow <- function(x, untilday = format(Sys.Date(), "%m-%d")) {
    MonthDay <- format(index(x), "%m-%d")
    if(any(untilday == "10-31", is.null(untilday))) {
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
annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/",c("P66522.xts", "P67113.xts", "P67207.xts")], untilday = "10-31")
## Aug 31-ig a haviakkal
annual_hydro <- HydYearUntilNow(AllPrec.xts, "08-31")
## Máig a folyamatosakkal
annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/",c("P66522.xts", "P67113.xts", "P67207.xts")])

## A leghosszabb Gyulavári
annual_hydro <- HydYearUntilNow(AllPrec.xts[,"Gyulavári"], NULL)


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
if(names(AllPrec.xts)[1] == "P66522.xts") {
annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/2026-10-31",c("P66522.xts", "P67113.xts", "P67207.xts","P66613.xts")], "10-31")
winterseason_hydro <- HydYearUntilNow(AllPrec.xts["2014/2026-10-31",c("P66522.xts", "P67113.xts", "P67207.xts", "P66613.xts")], "04-30")
} else {
    annual_hydro <- HydYearUntilNow(AllPrec.xts["2014/2026-10-31",c("Békéscsaba repülőtér", "Sarkad Malomfok", "Elek", "Gyula Máriafalva")], "10-31")
    winterseason_hydro <- HydYearUntilNow(AllPrec.xts["2014/2026-10-31",c("Békéscsaba repülőtér", "Sarkad Malomfok", "Elek", "Gyula Máriafalva")], "04-30")
}
for(actCol in colnames(annual_hydro[-1])) {
    Actual <- annual_hydro[,actCol]
    barplot(zoo(Actual, annual_hydro[,"HY"]),
            main = sub(".xts", "", actCol), col = "orange")
    barplot(zoo(winterseason_hydro[,actCol], winterseason_hydro[,"HY"]),
            main = "", col = "lightblue",
            xlab = "", ylab = "", axes = FALSE,
            add = TRUE)
    axis(2, as.numeric(tail(Actual,1)), tck = 1, lab = "")
    legend("topright", legend = c("Téli félév", "Nyári félév"), fill = c("lightblue", "orange"))
}
dev.off()

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

### Hidrológiai évre augusztusig
MonthDay <- format(index(AllPrec.xts), "%m-%d")
x_noSepOct <- AllPrec.xts[MonthDay <= "08-31" | MonthDay >= "11-01"]

hydro_year <- as.numeric(format(index(x_noSepOct), "%Y"))
## Plusz egy november–decemberre
hydro_year[format(index(x_noSepOct), "%m") == "11" |
           format(index(x_noSepOct), "%m") == "12"] <-
  hydro_year[format(index(x_noSepOct), "%m") == "11" |
             format(index(x_noSepOct), "%m") == "12"] + 1

annual_hydro <- aggregate.data.frame(
  x = x_noSepOct,
  list(HY = hydro_year),
  sum,
  na.rm = TRUE
)

pdf(width = 14)
for(actCol in colnames(annual_hydro[-1])) {
    Actual <- annual_hydro[,actCol]
    barplot(zoo(Actual, annual_hydro[,"HY"]), main = sub(".xts", "", actCol), col = "lightblue")
    axis(2, as.numeric(tail(Actual,1)), tck = 1, lab = "")
}
dev.off()

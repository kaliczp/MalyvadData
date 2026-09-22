PrecipObjectsAkt <- ls(patt = "P[0-9]")
PrecipObjects <- data.frame(
    StationData = c("P66522.xts", "P66523.xts", "P66613.xts", "P67113.xts", "P67203.xts", "P67207.xts"
                    ),
    StationName = c("Békéscsaba repülőtér", "Békéscsaba VI. kerület", "Sarkad Malomfok", "Elek", "Gyulavári", "Gyula Máriafalva")
)

pdf(width = 14)
par(xaxs = "i", yaxs = "i", las = 1, lend = 1, mar = c(3.1,4.1,4.1,4.1))
for(PrecipObject in PrecipObjects$StationData) {
    actual.xts <- get(PrecipObject)
    actualStation <- PrecipObjects[PrecipObjects$StationData == PrecipObject,
                                   "StationName"]
    if(any(names(actual.xts) == "t")) {
        plot.zoo(actual.xts[, "t"], main = "", col = "#ef8a62",
                 xlab = "", ylab = "", yaxt = "n", xaxt = "n",
                 ylim = c(-15,125)
                 )
        axis(4, at = c(-10,0,10,20,30))
        mtext("Hőmérséklet [°C]", side = 4, line = 3, at = 10, las = 0)
        par(new = TRUE)
        plot.zoo(actual.xts[, "rau"], type = "h", main = actualStation, col = "#67a9cf",
                 xlab = "", ylab = "Csapadék [mm/nap]", yaxt = "n",
                 ylim = c(140,0)
                 )
        axis(2, at = c(0,20,40,60))
    } else {
        plot.zoo(actual.xts, type = "h", main = actualStation,
                 xlab = "", ylab = "Csapadék [mm/nap]",
                 ylim = c(120,0)
                 )
    }
    DateInterval <- paste(c(index(actual.xts)[1], tail(index(actual.xts),1)), collapse = " - ")
    mtext(DateInterval, line = 1, at = as.Date("2026-09-01"), adj = 1)
    ## Napi húsz max
    MaxHelye <- order(as.numeric(actual.xts), decreasing = TRUE, na.last = NA)[1:20]
    ## Az öt max kiválogatása
    Top20 <- data.frame(
        time = index(actual.xts)[MaxHelye],
        value = as.numeric(actual.xts)[MaxHelye]
    )
    text(Top20$time, Top20$value, labels = Top20$value, adj = 1)
    ## Kis ábra éves összegek
    par(fig = c(0.5, 0.92, 0.35, 0.6), new = TRUE, mar = c(3.1, 4.1,0,0))
    if(any(names(actual.xts) == "t")) {
        PrecipYearly <- apply.yearly(actual.xts$r, sum)
    } else {
        PrecipYearly <- apply.yearly(actual.xts, sum)
    }
    Years <- as.numeric(format(index(PrecipYearly), "%Y"))
    barplot(zoo(coredata(PrecipYearly), Years) , col = "lightblue",
            ylim = c(0, 1000),
            ylab = "[mm/év]", xlab = "")
    par(fig = c(0, 1, 0, 1), mar = c(3.1,4.1,4.1,4.1))
}
dev.off()

PrecipObjectsAkt <- ls(patt = "P[0-9]")
PrecipObjects <- data.frame(
    StationData = c("P66522.xts", "P66523.xts", "P66613.xts", "P67113.xts", "P67203.xts", "P67207.xts"
                    ),
    StationName = c("Békéscsaba repülőtér", "Békéscsaba VI. kerület", "Sarkad Malomfok", "Elek", "Gyulavári", "Gyula Máriafalva")
)


pdf(width = 14)
par(xaxs = "i", yaxs = "i", las = 1, lend = 1)
for(PrecipObject in PrecipObjects$StationData) {
    actual.xts <- get(PrecipObject)
    actualStation <- PrecipObjects[PrecipObjects$StationData == PrecipObject,
                                   "StationName"]
    plot.zoo(actual.xts, type = "h", main = actualStation,
             xlab = "", ylab = "Csapadék [mm/nap]",
             ylim = c(0,100)
             )
    ## Napi húsz max
    MaxHelye <- order(as.numeric(actual.xts), decreasing = TRUE, na.last = NA)[1:20]
    ## Az öt max kiválogatása
    Top20 <- data.frame(
        time = index(actual.xts)[MaxHelye],
        value = as.numeric(actual.xts)[MaxHelye]
    )
    text(Top20$time, Top20$value, labels = Top20$value, adj = 1)
    ## Kis ábra éves összegek
    par(fig = c(0.5, 0.95, 0.65, 0.87), new = TRUE, mar = c(3.1, 4.1,0,0))
    PrecipYearly <- apply.yearly(actual.xts, sum)
    Years <- as.numeric(format(index(PrecipYearly), "%Y"))
    barplot(zoo(coredata(PrecipYearly), Years) , col = "lightblue",
            ylim = c(0, 1000),
            ylab = "[mm/év]", xlab = "")
    par(fig = c(0, 1, 0, 1), mar = c(5.1, 4.1, 4.1, 2.1))
}
dev.off()

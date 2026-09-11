PrecipObjects <- ls(patt = "P*xts")

pdf(width = 14)
par(xaxs = "i", yaxs = "i", las = 1, lend = 1)
for(PrecipObject in PrecipObjects) {
    actual.xts <- get(PrecipObject)
    plot.zoo(actual.xts, type = "h", main = sub(".xts", "", PrecipObject),
             xlab = "", ylab = "Csap. [mm]",
             ylim = c(0,100)
             )
    par(fig = c(0.5, 0.95, 0.65, 0.87), new = TRUE, mar = c(3.1, 2.1,0,0))
    PrecipYearly <- apply.yearly(actual.xts, sum)
    Years <- as.numeric(format(index(PrecipYearly), "%Y"))
    barplot(zoo(coredata(PrecipYearly), Years) , col = "lightblue",
            ylim = c(0, 1000),
            ylab = "", xlab = "")
    par(fig = c(0, 1, 0, 1), mar = c(5.1, 4.1, 4.1, 2.1))
}
dev.off()

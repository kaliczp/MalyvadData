PrecipObjects <- ls(patt = "P*xts")

pdf(width = 14)
par(xaxs = "i")
for(PrecipObject in PrecipObjects) {
    plot.zoo(get(PrecipObject), type = "h", main = PrecipObject,
             xlab = "", ylab = "Csap. [mm]"
             )
}
dev.off()

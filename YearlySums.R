## Augusztusig tartó összegek
x_aug <- AllPrec.xts[format(index(AllPrec.xts), "%m-%d") <= "08-31"]
AnnualAug <- apply.yearly(x_aug, colSums, na.rm = TRUE)

pdf(width = 14)
Years <- as.numeric(format(index(AnnualAug), "%Y"))
for(actCol in colnames(AnnualAug)) {
    ActualCore <- coredata(AnnualAug[,actCol])
    barplot(zoo(ActualCore, Years), main = sub(".xts", "", actCol), col = "lightblue")
    axis(2, as.numeric(tail(ActualCore,1)), tck = 1, lab = "")
}
dev.off()

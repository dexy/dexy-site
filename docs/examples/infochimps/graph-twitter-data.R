### @export "import-csv"
data <- read.table("dexy--twitter-data.csv", header=TRUE, sep=",")
names(data)

### @export "pairs"
pdf("dexy--pairs.pdf", width=7, height=7)
cols <- c("fo_trstrank", "at_trstrank", "follow_rate", "interesting", "feedness", "enthusiasm", "followers")
pairs(subset(data, select=cols), pch=19, col=terrain.colors(10))
dev.off()


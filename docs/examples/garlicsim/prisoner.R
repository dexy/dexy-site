### @export "read-csv"
data = read.csv("dexy--sim-output.csv", sep=",")

### @export "table"
strategy.counts <- table(list(strategy=data$strategy, step=data$step))
last.period = subset(data, data$step==max(data$step))
max_points_in_last_period = max(last.period$points)

### @export "barplot"
pdf(file="dexy--strategy-counts.pdf", width=6, height=4)
barplot(
    strategy.counts,
    legend.text = TRUE,
    border=NA,
    args.legend = pairlist(bty='n'),
    col=terrain.colors(3)
)
dev.off()

### @export "hist"
pdf(file="dexy--hist.pdf", width=6, height=4)
hist(last.period$points, main="",
        ylab="Number of Agents",
        xlab="Final Score",
        col="purple"
)
dev.off()

### @export "remove-large-objects"
rm(data)
rm(strategy.counts)
rm(last.period)


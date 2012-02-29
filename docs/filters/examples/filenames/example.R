### @export "rjson"
library(rjson)

### @export "graphing-function"
make.graph <- function(i) {
    # Open a PNG file
    filename <- sprintf("graph-%03d.png", i)
    png(filename, height=240)

    plot(runif(10), main=paste("Graph", i))

    # Close png file
    dev.off()
    return(filename)
}

### @export "do-graphs"
filenames <- sapply(c(1:20), make.graph)

### @export "save-info"
filename_info = list(filenames=filenames, dir=getwd())
new_filenames <- file("dexy--new-filenames.json", "w")
writeLines(toJSON(filename_info), new_filenames)
close(new_filenames)


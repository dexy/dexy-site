### @export "libraries"
library(seewave)
library(tuneR)

### @export "code1"
wave1 <- sine(10, bit=16)
wave1

pdf("dexy--oscillo1.pdf", width=4, height=3)
oscillo(wave1)
dev.off()

### @export "code2"
wave2 <- readWave("dexy--pitch.wav")
wave2

pdf("dexy--oscillo2.pdf", width=4, height=3)
oscillo(wave2)
dev.off()

rm(list = ls())
library(StatsChitran)
library(ImageMetrologyAnalysis)

#Load file and plot the fft
load(file = 'tens.rda')
plot2D.arr(arr = tens)

#Zoom into right location for good FFT
#tens1 <- plot2D.zoom(arr = tens, center = c(3,4), Del_X = 3.5, Del_Y = 3.5)
tens1 <- plot2D.win.sig(tens = tens, center = c(3,4), k = 10, Xspan = 3.5, Yspan = 3.5)
f_tens <- fft_2D(tens = tens1, pl='amp')
f_tens <- f_tens[[1]] #Load the amplitude spectra

#Take out the zero zero spot
f_tens <- mask.arr.box(tens = f_tens, box.vec = c(-1,-1,1,1))
#zoom into the image
f_tens <- plot2D.zoom(arr = f_tens, center = c(0,0), Del_X = 80, Del_Y = 80)

#Mark the boxes you want for the SiC spots
plot2D.arr(arr = f_tens)
v1 <- c(-14, -28.5, -2, -16.5, 3.5, 15, 15.5, 27)
v2 <- c(-29,-9,-17, 3)
v2 <- c(v2, 18, -5, 30,7)
#v2 <- NULL
v3 <- NULL
b.mat <- matrix(data = c(v1, v2, v3), ncol = 4, byrow = T)
dmp <- plot2D.boxes(img.tens = f_tens, box.mat = b.mat, box.thick = 0.01, box_intens = 0.05)

#Mark the boxes for the (0,0) spot
v0 <- c(-6, -6, 6, 6)
z.mat <- matrix(data = v0, ncol = 4)
dmp1 <- plot2D.boxes(img.tens = dmp, box.mat = z.mat, box.thick = 0.01, box_intens = 0.05)

#Start the mapping for the FFT over the SiC spots
map.tens <- fft_2D_map(img.tens = tens, DelX = 1.0, DelY = 1.0, k1st = b.mat, k0 = v0)

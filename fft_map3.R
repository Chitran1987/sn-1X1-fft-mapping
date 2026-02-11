rm(list = ls())

library(StatsChitran)
library(ImageMetrologyAnalysis)

load(file = 'tens_3.rda')

#Plot new file
plot2D.arr(arr = tens_3)
tens_3.zoom <- plot2D.win.sig(tens = tens_3, center = c(17.5, 6.25), Xspan = 4, Yspan = 4, k=10)

#fft
f_tens3 <- fft_2D(tens = tens_3.zoom, pl = 'amp')
f_tens3 <- f_tens3[[1]] #Amplitude spectra
f_tens3 <- plot2D.zoom(arr = f_tens3, center = c(0,0), Del_X = 80, Del_Y = 80) #Zoom
dmp <- mask.arr.box(tens = f_tens3, box.vec = c(-5,-5,5,5))

#Draw boxes around SiC spot
v1 <- c(-14, 16.2, -4, 26.2, 4.5, -26.5 , 14.5, -16.5)
v2 <- c(-15, -27, -5, -17, 5.5, 16, 15.5, 26)
v3 <- c(15, -5, 25, 5, -24, -4, -14, 6)
b.mat <- matrix(data = c(v1, v2, v3), ncol = 4, byrow = T)
dmp1 <- plot2D.boxes(img.tens = dmp, box.mat = b.mat, box.thick = 0.01, box_intens = 0.3)

#Draw boxes for the normalization of the spot intensities
v0 <- c(-35, -35, 35, 35)
dmp2 <- plot2D.boxes(img.tens = dmp1, box.mat = matrix(data = v0, ncol = 4, byrow = T), box.thick = 0.01, box_intens = 0.3)


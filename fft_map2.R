rm(list = ls())

library(StatsChitran)
library(ImageMetrologyAnalysis)

load(file = 'tens_2.rda')
plot2D.arr(arr = tens_2)

#Zoom into this using the sigmoid window
tens_2.zoom <- plot2D.win.sig(tens = tens_2, center = c(1.5, 2.75), Xspan = 2, Yspan = 1.5, k = 10) #perfect shot
f_tens2 <- fft_2D(tens = tens_2.zoom, pl = 'amp')
f_tens2 <- f_tens2[[1]] #The amplitude spectra tensor

#Zoom into the image
f_tens2 <- plot2D.zoom(arr = f_tens2, center = c(0,0), Del_X = 80, Del_Y = 80)
#Remove the central spot
dmp <- mask.arr.box(tens = f_tens2, box.vec = c(-5,-5, 5, 5))

#Draw boxes around the 1st order SiC spots
plot2D.arr(arr = dmp)
v1 <- c(5, -24, 15, -14, -15, 14, -5, 24)
v2 <- c(-20, -21.5, -10, -11.5, 10, 11.0, 20, 21.0)
v3 <- c(-29, -2.5, -19, 7.5, 19, -7.5, 29, 2.5)
b.mat <- matrix(data = c(v1, v2, v3), ncol = 4, byrow = T)
dmp1 <- plot2D.boxes(img.tens = dmp, box.mat = b.mat, box.thick = 0.001, box_intens = 0.075)

#Draw boxes around the (0,0) spot
dmp2 <- plot2D.boxes(img.tens = dmp1, box.mat = matrix(data = c(-35,-35, 35, 35), ncol = 4, byrow = T), box.thick = 0.001, box_intens = 0.075)

#Check how does this scale in areas where there is no SiC
plot2D.arr(arr = tens_2)
tens_2.zoom1 <- plot2D.win.sig(tens = tens_2, center = c(4,5), Xspan = 2, Yspan = 2, k=10)
f_tens2.1 <- fft_2D(tens = tens_2.zoom1, pl = 'amp')
f_tens2.1 <- f_tens2.1[[1]] #The amplitude tensor
#Zoom into the image
f_tens2.1 <- plot2D.zoom(arr = f_tens2.1, center = c(0,0), Del_X = 80, Del_Y = 80)
#Remove the central spot
dmp.1 <- mask.arr.box(tens = f_tens2.1, box.vec = c(-5,-5, 5, 5))
#Draw boxes around the 1st order SiC spots
plot2D.arr(arr = dmp.1)
v1 <- c(5, -24, 15, -14, -15, 14, -5, 24)
v2 <- c(-20, -21.5, -10, -11.5, 10, 11.0, 20, 21.0)
v3 <- c(-29, -2.5, -19, 7.5, 19, -7.5, 29, 2.5)
b.mat <- matrix(data = c(v1, v2, v3), ncol = 4, byrow = T)
dmp1 <- plot2D.boxes(img.tens = dmp.1, box.mat = b.mat, box.thick = 0.001, box_intens = 0.075)

#Create the map
map.tens2 <- fft_2D_map(img.tens = tens_2, DelX = 1.0, DelY = 1.0, k1st = b.mat, k0 = c(-35, -35, 35, 35))
save(map.tens2, file = 'map.tens2.rda')

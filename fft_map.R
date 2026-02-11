rm(list = ls())
library(StatsChitran)
library(ImageMetrologyAnalysis)

#Load file and plot the fft
load(file = 'tens.rda')
f_tens <- fft_2D(tens = tens, pl='amp')
f_tens <- f_tens[[1]] #Load the amplitude spectra

#Take out the zero zero spot
f_tens <- mask.arr.box(tens = f_tens, box.vec = c(-1,-1,1,1))

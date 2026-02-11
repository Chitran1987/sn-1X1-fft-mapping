rm(list=ls())

library(StatsChitran)
library(ImageMetrologyAnalysis)

#1st Image
tens <- img_2_arr(source.png = 'm1_m_750mV_25pA_Z TraceDown Thu Feb 10 22.53.28 2022 [17-33]  STM_Spectroscopy STM.png', x.lim = c(0, 7.165), y.lim = c(0, 7.165))
save(tens, file = 'tens.rda')

#2nd Image
tens_2 <- img_2_arr(source.png = 'm1_Z TraceUp Thu Oct 26 16.54.59 2023 [25-1]  STM_Spectroscopy STM.png', x.lim = c(0, 6.817), y.lim = c(0, 6.817))
save(tens_2, file = 'tens_2.rda')

#3rd Image
tens_3 <- img_2_arr(source.png = 'm1_tensor Fri Aug 18 15.34.36 2023 [13-2]  STM_Spectroscopy STM_cut.png', x.lim = c(0, 19.077), y.lim = c(0, 11.543))
save(tens_3, file = 'tens_3.rda')

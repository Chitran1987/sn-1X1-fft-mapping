rm(list=ls())

library(StatsChitran)
library(ImageMetrologyAnalysis)

tens <- img_2_arr(source.png = 'm1_m_750mV_25pA_Z TraceDown Thu Feb 10 22.53.28 2022 [17-33]  STM_Spectroscopy STM.png', x.lim = c(0, 7.165), y.lim = c(0, 7.165))
save(tens, file = 'tens.rda')

rm(list = ls())
library(StatsChitran)
library(ImageMetrologyAnalysis)

a1.1 <- read.table(file = 'a1_prof1.txt', header = F, sep = '\t')
a1.2 <- read.table(file = 'a1_prof2.txt', header = F, sep = '\t')
a2.1 <- read.table(file = 'a2_prof1.txt', header = F, sep = '\t')
a2.2 <- read.table(file = 'a2_prof2.txt', header = F, sep = '\t')
b1.1 <- read.table(file = 'b1_prof1.txt', header = F, sep = '\t')
b1.2 <- read.table(file = 'b1_prof2.txt', header = F, sep = '\t')
b2.1 <- read.table(file = 'b2_prof1.txt', header = F, sep = '\t')
b2.2 <- read.table(file = 'b2_prof2.txt', header = F, sep = '\t')


#first center the graphs
#a1
plot(a1.1$V1, a1.1$V2, type = 'b')
abline(v= 30.35, col = 'red')
a1.1$V1 <- a1.1$V1 - 30.35
plot(a1.1$V1, a1.1$V2, type = 'b')

plot(a1.2$V1, a1.2$V2, type = 'b')
abline(v = 36.4, col='red')
a1.2$V1 <- a1.2$V1 - 36.4
plot(a1.2$V1, a1.2$V2, type = 'b')

#a2
plot(a2.1$V1, a2.1$V2, type = 'b')
abline(v=36, col='red')
a2.1$V1 <- a2.1$V1 - 36
plot(a2.1$V1, a2.1$V2, type = 'b')

plot(a2.2$V1, a2.2$V2, type = 'b')
abline(v=36, col='red')
a2.2$V1 <- a2.2$V1 - 36
plot(a2.2$V1, a2.2$V2, type = 'b')

#b1
plot(b1.1$V1, b1.1$V2, type = 'b')
abline(v = 30.4, col='red')
b1.1$V1 <- b1.1$V1 - 30.4
plot(b1.1$V1, b1.1$V2, type = 'b')

plot(b1.2$V1, b1.2$V2, type = 'b')
abline(v=28.75, col = 'red')
b1.2$V1 <- b1.2$V1 - 28.75
plot(b1.2$V1, b1.2$V2, type = 'b')

#b2
plot(b2.1$V1, b2.1$V2, type = 'b')
abline(v = 29.25, col='red')
b2.1$V1 <- b2.1$V1 - 29.25
plot(b2.1$V1, b2.1$V2, type = 'b')

plot(b2.2$V1, b2.2$V2, type = 'b')
abline(v = 27.5, col='red')
b2.2$V1 <- b2.2$V1 - 27.5
plot(b2.2$V1, b2.2$V2, type = 'b')


#center
cent <- c(30.35, 36.4, 36, 36, 30.4, 28.75, 29.25, 27.5)

#Save it in a list
L1 <- vector(mode = 'list', length = 4)
L1[[1]] <- list(a1.1 = a1.1, a1.2 = a1.2)
L1[[2]] <- list(a2.1 = a2.1, a2.2 = a2.2)
L1[[3]] <- list(b1.1 = b1.1, b1.2 = b1.2)
L1[[4]] <- list(b2.1 = b2.1, b2.2 = b2.2)
names(L1) <- c('a1', 'a2', 'b1', 'b2')


#Now interpolate and normalize the data within that list
X <- seq(-30, 30, by=0.01)
for (i in 1:4) {
  for (j in 1:2) {
    df <- L1[[i]][[j]]
    dmp <- spline(df$V1, df$V2, xout = X)
    df <- data.frame(X = dmp[[1]], Y = dmp[[2]])
    df$Y <- nrm(df$Y)
    L1[[i]][[j]] <- df
  }

}

#Save this list in a .rda file
save(L1, file = 'centered_interpolated_data.rda')

#check the dataframes
df <- L1[[3]][[2]]
plot(df$X, df$Y, type = 'l')
abline(v=c(-27, 27), col='red')

#Now snip between +/-27 k vector values
for (i in 1:4) {
  for (j in 1:2) {
    df <- L1[[i]][[j]]
    df <- df[df$X >= -27 & df$X <= 27,]
    df$Y <- nrm(df$Y)
    L1[[i]][[j]] <- df
  }
}

#Save this list in a .rda file
save(L1, file = 'centered_interpolated_sized_data.rda')

#average the data
L2 <- vector(mode = 'list', length = 4)
for (i in 1:4) {
  df1 <- L1[[i]][[1]]
  df2 <- L1[[i]][[2]]
  df.avg <- data.frame(X  = df1$X, Y = (df1$Y + df2$Y)/2)
  df.avg$Y <- nrm(df.avg$Y)
  L2[[i]] <- df.avg
}

df <- L2[[1]]
plot(df$X, df$Y)
save(L2, file = 'final_list.rda')



stack.plot(gr.data = L2, stack.len = 4, lwd.mat = matrix(data = rep(1,4), ncol = 1))

#Save plot as svg file
svg("lineprof.svg", width = 29, height = 37)
stack.plot(gr.data = L2, stack.len = 4, lwd.mat = matrix(data = rep(1,4), ncol = 1))
dev.off()

#install.packages("ggplot2movies")
library(ggplot2movies)
dim(movies)
head(movies)
#class(movies$rating)
str(movies)
options(scipen=10)
data <- movies[,-(7:17)]
round(srednie <- apply(data[,-1], 2, mean, na.rm=T), 2)
#mean(data$budget, na.rm=T)
apply(data[,-1], 2, median, na.rm=T)
round(odchylenie <- apply(data[,-1], 2, sd, na.rm=T), 2)
odchylenie/srednie*100 # wspolczynniki zmiennosci (CV)

library(e1071)
apply(data[,-1], 2, skewness, na.rm=T)
apply(data[,-1], 2, kurtosis, na.rm=T)

hist(data$rating)
hist(data$votes, br=50)
hist(data$votes[data$votes<100], br=50)
hist(log10(data$votes))
boxplot(data$rating)
boxplot(data$length)
boxplot(data$length[data$length<500])

(sumy <- apply(data[,7:13], 2, sum))
barplot(sumy)

tapply(data$rating, data$Comedy, mean)
tapply(data$rating, data$year, mean) -> oceny
names(table(data$year))
plot(names(table(data$year)), oceny)

gatunek <- numeric(7)
for(i in 1:7) gatunek[i] <- tapply(data$rating, data[,6+i], mean)[2]
names(gatunek) <- colnames(data[,7:13])
barplot(gatunek)

cv <- function(x) sd(x, na.rm=T)/mean(x, na.rm=T)*100
gatunek2 <- numeric(7)
for(i in 1:7) gatunek2[i] <- tapply(data$rating, data[,6+i], cv)[2]
names(gatunek2) <- colnames(data[,7:13])
barplot(gatunek2)

gatunek3 <- numeric(7)
for(i in 1:7) gatunek3[i] <- tapply(data$length, data[,6+i], median)[2]
names(gatunek3) <- colnames(data[,7:13])
barplot(gatunek3)

gatunek4 <- numeric(7)
for(i in 1:7) gatunek4[i] <- tapply(data$budget/1e6, data[,6+i], median, na.rm=T)[2]
names(gatunek4) <- colnames(data[,7:13])
barplot(gatunek4)

ind <- data$length<300
#plot(data$length[ind], data$budget[ind])
plot(data$length[ind], log10(data$budget[ind]), xlab="Length", main="Zaleznosc", 
     pch="*", col="blue")




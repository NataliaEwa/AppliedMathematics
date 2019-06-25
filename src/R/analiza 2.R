install.packages("ggplot2movies") #instalujemy pakiet ggplot2movies
library(ggplot2movies) #biblioteka ggplot2movies
?movies #baza danych movies
dim(movies)->rozmiar #rozmiar 
head(movies)->przyklad #pierwsze pięć pozycjli 
View(przyklad)
class(movies$rating) #typ danych rating (oceny)
str(movies)->typy #typy zmiennych 
View(typy)
options(scipen=10)

#tworzymy nową bazę, której elenemtami będą:
#rok produkcji, dłudość filmu, budżet, ocena widzów, liczba głosów, gatunek
data <- movies[,-(7:17)] 
View(data)

#liczymy średnie wartości danych w data
srednie <- apply(data[,-1], 2, mean, na.rm=T) 
round(srednie, 2) #zaokrąglamy średnie do drugiego miejsca po przecinku

#mean(data$budget, na.rm=T) 

#liczymy medianę wartości danych w data
mediana<-apply(data[,-1], 2, median, na.rm=T) 

#liczymy ochylenie standardowe wartości danych w data
apply(data[,-1], 2, sd, na.rm=T)->odchylenie
round(odchylenie, 2)

# wspolczynniki zmiennosci (CV)
odchylenie/srednie*100->CV
CV

#####
nazwa <- numeric(12)
names(nazwa) <- colnames(data[,2:13])
for(i in 1:7) nazwa[i] <- tapply(data$rating, data[,1+i], na.rm=T)[2]
barplot(nazwa)
hist(nazwa)


library(e1071)
apply(data[,-1], 2, skewness, na.rm=T) #skośność
apply(data[,-1], 2, kurtosis, na.rm=T) #kurtoza

summary(data[2:6]) #

#print(by(year, rating, summary))
#boxplot(year~votes, data, col="lightgrey")

# hist(data$rating) #histogram ocen, jak widać najczęstsza ocena to 6
hist(data$votes, br=50) #histogram liczby głosów, 
#dużo filmów miało małą liczbę głosów, przez co histogram jest nieczytelny
hist(data$votes[data$votes<100], br=50) #histogram liczby głosów, 
#brane były pod uwagę jedynie filny, które uzyskały poniżej 100 głosów
hist(log10(data$votes)) #bardziej czytelny histogram (zlogarytmowaliśmy liczbę głosów)

boxplot(data$rating) #wykres pudełkowy ocen, widać, że bardzo mało filmów soatało ocenionych 
#poniżej 2, są to wartości odstające
boxplot(data$length) #widzimy, że jest kilka filmów bardzo długich (powyżej 500 minut)
#co uniemożliwia odczytanie innych danych z wykresu
boxplot(data$length[data$length<500]) #bardziej czytelny wykres (brane pod uwagę są tylko filmy poniżej 500 minut)

#liczba filmów danego gatunku
(sumy <- apply(data[,7:13], 2, sum))
barplot(sumy)

#średnia ocen w zależności od roku produkcji
tapply(data$rating, data$year, mean) -> oceny
names(table(data$year))
plot(names(table(data$year)), oceny)

tapply(data$rating, data$Comedy, mean)

#średnia ocen w zależności od gatunku
gatunek <- numeric(7)
for(i in 1:7) gatunek[i] <- tapply(data$rating, data[,6+i], mean)[2]
names(gatunek) <- colnames(data[,7:13])
barplot(gatunek)

#średnia ocen w zależności od gatunku w procentach
cv <- function(x) sd(x, na.rm=T)/mean(x, na.rm=T)*100
gatunek2 <- numeric(7)
for(i in 1:7) gatunek2[i] <- tapply(data$rating, data[,6+i], cv)[2]
names(gatunek2) <- colnames(data[,7:13])
barplot(gatunek2)

#średnia długości filmu w zależności od gatunku w minutach
gatunek3 <- numeric(7)
for(i in 1:7) gatunek3[i] <- tapply(data$length, data[,6+i], median)[2]
names(gatunek3) <- colnames(data[,7:13])
barplot(gatunek3)

#średni budżet w zależności od gatunku w procentach
gatunek4 <- numeric(7)
for(i in 1:7) gatunek4[i] <- tapply(data$budget/1e6, data[,6+i], median, na.rm=T)[2]
names(gatunek4) <- colnames(data[,7:13])
barplot(gatunek4)

#wykres zależności budżetu od długości filmu
ind <- data$length<300
#plot(data$length[ind], data$budget[ind])
plot(data$length[ind], log10(data$budget[ind]), xlab="Length", main="Zaleznosc", pch="*", col="blue")
plot(data$length[ind], log10(data$budget[ind]), pch=20, col=rainbow(100))

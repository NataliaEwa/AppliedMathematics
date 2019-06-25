library(ggplot2movies)
library(car)
data(movies)
attach(movies)

View(movies) # przegląd wszystkich danych
View(ls(movies)) # lista zmiennnych 

# zmniejszamy ilość porównywanych danych, ponieważ dla tak dużej ilości porównywanych danych 
# (58788) hipoteza zerowa będzie niemalże na 100% pewna. Dla możliwości wyciągnięcia wniosków
# zmniejszamty liczbę porównywanych filmów do 500 (co i tak jest dużą liczbą)
length(movies$year)
filmy <- movies
movies <- movies[1:5000,]
View(filmy)

# przedział ufności
przedzial<-function(X, conf.level=0.95, var=NULL)
{
  n<-length(X)
  alpha<-1-conf.level
  if(is.null(var)){
    L<-mean(X)-sd(X)*qt(1-alpha/2, df=n-1)/sqrt(n)
    P<-mean(X)+sd(X)*qt(1-alpha/2, df=n-1)/sqrt(n)
  }
  else{
    L<-mean(X)-sqrt(var)*qnorm(1-alpha/2, df=n-1)/sqrt(n) 
    L<-mean(X)+sqrt(var)*qnorm(1-alpha/2, df=n-1)/sqrt(n) 
  }
  wynik<-c(L,P)
  return(wynik)
}

# SCHEMAT

hist() # histogram
przedzial() # przedział
mean() # średnia
var() # wariancja
sd() # odchylenie
length() # liczba danych porównywanych

range(movies$year) # najstarszy i najnowszy film w bazie
range(movies$length) # najkrótszy i najdłuższy film w bazie

table(movies$year) # ilość filmów wyprogukowanych w poszczególnym roku

przedzial(movies$rating, conf.level = 0.95) # przedział średniej wszystkich ocen
przedzial(movies$rating[movies$Comedy==1], conf.level = 0.95) # przedział średnich ocen komedii
przedzial(movies$rating[movies$year>2000], conf.level = 0.95) # przedział średnich ocen filmów powyżej 2000 roku
przedzial(movies$rating[movies$length<180], conf.level = 0.95) # przedział średnich ocen filmów o długości po niżej 3 godzin

hist(movies$rating) # histogram ocen wszystkich filmów
hist(movies$rating[movies$Comedy==1]) # histogram ocen filmów, które są komediami

par(mfrow=c(3,1))
hist(movies$rating[movies$year>2000]) # histogram ocen filmów wypodorukowanych po 2000 roku
a=movies$year>1970
hist(movies$rating[a<2000]) # histogram ocen wyprodukowanybch w latach 1970-2000
hist(movies$rating[movies$year<1970]) # histogram ocen filmów wypodorukowanych do 1970 roku
par(mfrow=c(1,1))

b=movies$length>90
hist(movies$rating[movies$length<180]) # histogram ocen filmów trwających 90 do 180 minut

# test normalności
# im bardziej linia jest prosta, tym bardziej rozkład danych zbliżony jest do rozkładu normalnego
qqnorm(movies$year) # bez sensu, średni rok? ;p
qqnorm(movies$rating)
qqnorm(movies$rating[movies$Comedy==1])
qqnorm(movies$rating[movies$year])
# test na normalność Shapiro-Wilka
shapiro.test(movies$year)
shapiro.test(movies$rating)
shapiro.test(movies$rating[movies$Comedy==1])
shapiro.test(movies$rating[movies$year])

#
x=filmy$year[1:100]
hist(x, breaks=40, probability=T)
lines(x, dnorm(x,mean(x), sd(x)))

# test t.studenta
t.test(movies$year,mu=length(movies$year)-1)
t.test(movies$rating,mu=length(movies$rating)-1)
t.test(movies$rating[movies$Comedy==1],mu=length(movies$rating[movies$Comedy==1])-1)
t.test(movies$rating[movies$year],mu=length(movies$rating[movies$year])-1)

# jeśli dane nie mają rozkładu zbliżonego do rozkładu normalnego używamy testu Wilcoxona
# test ten można również używać dla rokładu normalnego, jednak jest to mniej pewny test, 
# a co za tym idzie jest większa szansa na przyjęcie błędnej hipotezy zerowej
RY=movies$rating[movies$year]
wilcox.test(RY,mu=length(RY)-1)

# test "z" dla sigma = 3 i alfa = 0.05
ci = qnorm(1-0.05/2)
s = 3/sqrt(length(RY))
mean(RY) + c(-s*ci,s*ci)

# testy dla dwóch prób
d1=movies$rating[movies$Comedy==1] # oceny komedii
d2=movies$rating[movies$Drama==1] # oceny dramatów
var.test(d1,d2) # czy jest jednorodność wariancji?
# jeśli nie ma różnic wariancji przeprowadzamy test t.Studenta
t.test(d1,d2)
# jeśli wariancje są różne przeprowadzamy test Wilcoxona
wilcox.test(d1,d2)

# test dla większej ilości prób (nie poleca się)
d3=movies$rating[movies$Documentary==1] # oceny filmów dokumentarnych
d4=movies$rating[movies$Action==1] # oceny filmów akcji
D1=d1[1:2000]
D2=d2[1:2000]
D3=d3[1:2000]
D4=d4[1:2000]
danex = data.frame(wyniki=c(D1, D2, D3, D4),metoda=rep(1:4,each=8))
View(danex)
bartlett.test(wyniki ~ metoda,danex) # czy jest niejednorodność?
kruskal.test(wyniki~metoda,danex) # jeśli jest, Kruskar-Wallis
anova(aov(wyniki~metoda,danex)) # jeśli nie, Anova

# test Chi-kwadrat dla proporcji
video=movies[1:500,] # 500 filmów
table(video$Drama==1) # wśród 500 filmów 181 to dramaty
# Czy można powiedzieć, że 40% wszystkich filmów to dramaty? 
prop.test(181,500,p=0.40)

# porównanie wyników kilku grup
video2=movies[1100:1349,] # 250 filmów
video3=movies[5000:5089,] # 90 filmów
table(video2$Drama==1) # wśród 250 filmów 105 to dramaty
table(video3$Drama==1) # wśród 90 filmów 34 to dramaty
# czy wyniki pochodziły z tej samej ankiety?
prop.test(c(181,105,24),c(500,250,90))
# test bez poprawki Yates'a
prop.test(c(181,105,24),c(500,250,90), correct=FALSE)
# prop 1 = 0.3620000
# prop 2 = 0.4200000 
# prop 3 = 0.2666667 
# 0.4200000 - 0.2666667 = 0.1533333 > 0.05, można z tego wnioskować, 
# że wyniki pochodziły z różnych ankiet 
# (mimo, że w maszym przypadku wyniki pochodziły z tej samej ankiety)

# rysunki, nieużyteczne dla moich danych 
vid=video[1:30,]
x=vid$rating
y=vid$votes<1000
fit=lm(x~y)
summary(fit)
plot(x,y);abline(fit) # wykres przedstawiający naszą krzywą oraz prostą regresji. 
# Funkcja abline dodaje do wykresu linię prostą o zadanych parametrach, w tym przypadku po- branych z obiektu fit.
plot(ellipse(fit),type="l") # wykres „elipsy ufności” estymatorów regresji.
plot(x,fit$residuals);abline(h=0) #wykres reszt regresji z dodaną linią prostą wzdłuż osi x.
qqnorm(fit$residuals) # wykres kwantylowy-normalny reszt regresji
par(mfrow=c(2,2));plot(fit);par(mfrow=c(1,1)) # zwykła funkcja plot z argumentem będącym
#rezultatem funkcji lm generuje 4 wykresy dotyczące tej regresji.

# ile filmów zostało wyprodukowanych w poszczególnych latach?
lata <- c(movies$year)
range(lata)
lata2 <- cut(lata, c(1890, 1900, 1910, 1920, 1930, 1940, 1950, 1960, 1970, 1980, 1990, 2000, 2010))
tab <- table(lata2)
dim(tab) <- c(1,12)
tab2 <-  c("(1890-1900]", "(1900-1910]", "(1910-1920]", "(1920-1930]", "(1930-1940]", "(1940-1950]", "(1950-1960]", "(1960-1970]", "(1970-1980]", "(1980-1990]", "(1990-2000]", "(2000-2010]")
tablica <- array(c(tab2,tab),dim=c(12,2))

# dla porównywania dwóch danych podać osobne przedziały ufności dla każdej
# zrobić cor.test -> zależnośc liniowa

zad 1
m0, n, X, s=sd(X), sr=mean(X), alfa=1-conf.level
T <- (sr-m0)/(s.sqrt(n))
1) dla H0: m=a, H1: m≠a
kwantyl=t_(1-alfa/2, n-1)
C=(-inf, -kwantyl)u(kwantyl, t) jeśli T nie należy co C, przyjmujemy H0
P=(sr-s*kwantyl/sqrt(n), sr+s*kwantyl/sqrt(n))
2) dla H0: m=a, H1: m<a
kwantyl=t_(1-alfa, n-1)
C=(-inf, kwantyl)
P=(-inf, sr+s*kwantyl/sqrt(n))

zad 2
n, X, var(X), alfa=1-conf.level, 
kw1=qchisq(1-alfa/2, df=n-1)
kw2=qchisq(alfa/2, df=n-1)
L=(n-1)*var/kw1
P=(n-1)*var/kw2

### Przedzia³ ufnosci dla znanego \sigma^2 z rozk³adem normalnym

pomiary<-c()
srednia<- 135
sigma<- 16
  poziom_ufnosci<-0.99
  alpha<- 1-poziom_ufnosci
n<-105
Z<-qnorm(1-alpha/2)
# Teraz wyznaczamy lewy i prawy przedzia³ ufnoci
L<-srednia - (sigma*Z)/sqrt(n)
P<-srednia + (sigma*Z)/sqrt(n)
Odp <- (L P)

### Przedzia³ ufnosci dla nieznanego \sigma^2 z rozk³adem normalnym

pomiary<-c()
srednia<- mean(pomiary)
wartoæ_oczekiwana<-sd(pomiary) # lub odchylenie standarodwe
# jeli nie ma w poleceniu odch. stand. lub ani pomiary to na pewno bedzi wariancja
# S <- sqrt(wariancji)
poziom_ufnoci<-
  alpha<- 1-poziom_ufnoci
n<-length(pomiary)
t<-qt(1-alpha/2, n-1)
# Teraz wyznaczamy lewy i prawy przedzia³ ufnoci
L<-srednia - (wartoæ_oczekiwana*t)/sqrt(n)
P<-srednia + (wartoæ_oczekiwana*t)/sqrt(n)
Odp <- (L, P)


### X% przedzia³ ufnoci
#Dane: potrzebujemy wariancji oraz X% poziom ufnoci
pomiary <- c()
n <- length(pomiary)
poziom_ufnoci <- 
  alpha <- 1 - poziom_ufnoci
wariancja <- var(pomiary)
#Tu korzystamy z chi kwadrat
kwantyl_L <- qchisq(1-alpha/2, df=n-1)
kwantyl_P <- qchisq(alpha/2, df=n-1)

L <- (n-1)*wariancja/kwantyl_L
P <- (n-1)*wariancja/kwantyl_P
T <- c(L,P)
T


### Hipotezy
#Za³u¿my, ¿e hipoteza H0 : m=20
## gdy hipoteza alternatywna ró¿ni siê od m (m=/=20)
test1 <- t.test(proba, alternative = "two.sided", mu=m, conf.level = 1-alpha)

## gdy hipoteza alternatywna jest mniejsza od m (m<20)
test2 <- t.test(proba, alternative = "less", mu=m, conf.level = 1-alpha)


#Dane do zadania 3
przedzial<-function(X, conf.level=0.95, var=NULL ){
  n<-length(X)
  a<-1-conf.level #alpha
  if(is.null(var) == TRUE){
    L<-mean(X)-sd(X)*qt(1-a/2,df=n-1)/sqrt(n)
    P<-mean(X)+sd(X)*qt(1-a/2,df=n-1)/sqrt(n)
  }
  else{
    L<-mean(X)-sqrt(var/n)*qnorm(1-a/2)
    P<-mean(X)+sqrt(var/n)*qnorm(1-a/2)
  }
  return(c(L,P))
}





##Dla rozk³adu jednostajnego
pusrj <- function(M,n,poz.ufn,theta){
  sr<-theta/2
  warian<-theta^2/12
  emp.pokrycie1<-0   #ze znan¹ wariancj¹
  emp.pokrycie2<-0   #z nieznan¹ wariancj¹
  szer1<-0
  szer2<-0
  
  for(i in 1:M){
    X<-rnorm(n, mean=sr, sd=sqrt(warian))
    puf1<-przedzial(X,conf.level=poz.ufn,var=warian)
    puf2<-przedzial(X,conf.level=poz.ufn)
    if(puf1[1]<sr & puf1[2]>sr){
      emp.pokrycie1<-emp.pokrycie1+1
    }
    if(puf2[1]<sr & puf2[2]>sr){
      emp.pokrycie2<-emp.pokrycie2+1
    }
    szer1<-szer1+(puf1[2]-puf1[1])
    szer2<-szer2+(puf2[2]-puf2[1])
  }
  szer1<-szer1/M
  szer2<-szer2/M
  emp.pokrycie1<-emp.pokrycie1/M
  emp.pokrycie2<-emp.pokrycie2/M
  return(c(szer1, szer2, emp.pokrycie1, emp.pokrycie2))}



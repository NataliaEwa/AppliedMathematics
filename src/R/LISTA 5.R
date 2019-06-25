# NAUKA DO KOLOKWIUM II

# LISTA 5

# zad 1
library(TeachingDemos)
# a
par(mfrow=c(2,2))
ci.examp(mean.sim=100, sd=10, n=25, reps=50, conf.level=0.95, method='z' )
ci.examp(mean.sim=100, sd=10, n=25, reps=500, conf.level=0.95, method='z' )
ci.examp(mean.sim=100, sd=10, n=25, reps=50, conf.level=0.995, method='z' )
ci.examp(mean.sim=100, sd=10, n=250, reps=50, conf.level=0.95, method='z' )
# 'z' - rozkład normalny, 't'- rozkład t.studenta
par(mfrow=c(1,2))
ci.examp(mean.sim=100, sd=10, n=25, reps=50, conf.level=0.95, method='t' )
ci.examp(mean.sim=100, sd=10, n=25, reps=50, conf.level=0.95, method='z' )
par(mfrow=c(1,1))

# zad 2
# a
# przedział ufności dla znanej sigmy: 
# [s.sr-z_(1-alfa/2)*sigma/sqrt(n) , s.sr+z_(1-alfa/2)*sigma/sqrt(n)]
# dla nieznanej sigmy: 
# [s.sr-t_(1-alfa/2, n-1)*s/sqrt(n) , s.sr+t_(1-alfa/2,n-1)*s/sqrt(n)]
przedział <- function(X, conf.level=0.95, var=NULL )
{
  n <- length(X);
  alpha <- 1-conf.level
  if(is.null(var))
  {
    L <- mean(X)-sd(X)*qt(1-alpha/2, df=n-1)/sqrt(n)
    P <- mean(X)-sd(X)*qt(1-alpha/2, df=n-1)/sqrt(n)
  }
  else
  {
    L <- mean(X)-sqrt(var)*qnorm(1-alpha/2)/sqrt(n)
    P <- mean(X)-sqrt(var)*qnorm(1-alpha/2)/sqrt(n)
  }  
  wynik <- c(L,P)
  return(wynik)
}
# b 
library(MASS)
data(Cars93)
attach(Cars93)
przedzial(Cars93$Price, conf.level=0.90) # [17.84537 21.17398]
przedzial(Cars93$Price, conf.level=0.95) # [17.52034 21.49901]
przedzial(Cars93$Price, conf.level=0.99) # [16.87504 22.14431]
# wnioski: przedział ufności maleje wraz ze wzrostem poziomu ufności

# zad 3
czas <- c(435,533,393,458,525,481,324,437,348,503,383,395,416,553,500,488)
p.ufnosci <- 0.99
sigma <- 70
alpha <- 1-p.ufnosci
n <- length(czas)
qnorm(1-alpha/2) # 2.575829
mean(czas) # 448.25
L <- mean(czas)-qnorm(1-alpha/2)*sigma/sqrt(n)
P <- mean(czas)+qnorm(1-alpha/2)*sigma/sqrt(n)
mean(czas) # średni czas snu = 448.25 minuty
m <- c(L,P) # przedział ufności w minutach: [403.173 493.327]

# zad 4
MPa <- c(383,284,339,340,305,386,378,335,344,346)
p.ufn1 <- 0.90
p.ufn2 <- 0.95
alpha1 <- 1-p.ufn1
alpha2 <- 1-p.ufn2
n <- length(MPa)
sd(MPa) # 32.80921
qt(1-alpha1/2, n-1) # 1.75305
mean(MPa) # 344
L1 <- mean(MPa)-qt(1-alpha1/2, n-1)*sd(MPa)/sqrt(n)
P1 <- mean(MPa)+qt(1-alpha1/2, n-1)*sd(MPa)/sqrt(n)
L2 <- mean(MPa)-qt(1-alpha2/2, n-1)*sd(MPa)/sqrt(n)
P2 <- mean(MPa)+qt(1-alpha2/2, n-1)*sd(MPa)/sqrt(n)
T1 <- c(L1, P1) # [324.9811 363.0189]
T2 <- c(L2, P2) # [320.5297 367.4703]
roznica <- c(L2-L1, P2-P1) 
# [-4.451413  4.451413]  -> na poziomie ufno±ci = 0.90 przedział ufności 
# jest o 4.451413 większy niż na poziomie ufności = 0.95

# zad 5
# X_n ~ N(m, sigma^2)
x_sr <- 3000
s <- 20
n <- 16
p.ufn <- 0.95
alfa <- 1-p.ufn # 0.05
kwantyl <- qt(1-alfa/2, n-1) # 2.13145
L <- x_sr-kwantyl*s/sqrt(n)
P <- x_sr+kwantyl*s/sqrt(n)
T=c(L,P) # [2989.343 3010.657] 

# zad 6
n <- 200
x_sr <- 280
s <- 160
p.ufn <- 0.95
alfa <- 1-p.ufn # 0.05
kwantyl <- qt(1-alfa/2, n-1) # 2.13145
L <- x_sr-kwantyl*s/sqrt(n)
P <- x_sr+kwantyl*s/sqrt(n)
T=c(L,P) # [257.6899 302.3101]

# zad 7
n <- 10
x_sr <- 20.2
var <- 0.96
s <- sqrt(var)
p.ufn <- 0.90
alfa <- 1-p.ufn
# przedział ufności dla współczynnika ufności = 0.90
kwantyl <- qt(1-alfa/2, n-1) # 2.13145
L <- x_sr-kwantyl*s/sqrt(n)
P <- x_sr+kwantyl*s/sqrt(n)
T=c(L,P) # [19.63203 20.76797]
# 90% przedział ufności: 
curve(dchisq(x, df=n-1), from=0, to=40)
kw1 <- qchisq(1-alfa/2, df=n-1)
kw2 <- qchisq(alfa/2, df=n-1)
L <- (n-1)*var/kw1 # 16.91898
P <- (n-1)*var/kw2 # 3.325113
T <- c(L,P) # [0.5106692 2.5984081]

# zad 8
X <- c(102, 105, 102, 100, 108, 97, 96, 98, 100, 101)
n <- 10
p.uf <- 0.95
alfa <- 1-p.uf
var <- var(X)
# 95% przedział ufności:
curve(dchisq(x, df=n-1), from=0, to=40)
kw1 <- qchisq(1-alfa/2, df=n-1)
kw2 <- qchisq(alfa/2, df=n-1)
L <- (n-1)*var/kw1 # 19.02277
P <- (n-1)*var/kw2 # 2.700389
T <- c(L,P) # [0.4541926 3.1995384]

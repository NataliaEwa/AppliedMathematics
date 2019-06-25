# NAUKA DO KOLOKWIUM II

# LISTA 6

# zad 1
analiza <- function(poziom.ufnosci=0.95, srednia=0, wariancja=1, dlugosc.proby=1000)
{
  p.ufn <- poziom.ufnosci
  m <- srednia
  war <- wariancja
  alfa <- 1-p.ufn
  nn <- dlugosc.proby
  epp1 <- 0 # empiryczne prawodopodobieństwo pokrycia
  epp2 <- 0
  s1 <- 0 #szerokość skonstruowanego przedziału
  s2 <- 0
  for(i in 1:n)
  {
    X <- rnorm(n, mean=m, sd=war)
    # znana wariancja
    L1 <- mean(X)-sqrt(war)*qnorm(1-alfa/2)/sqrt(nn)
    P1 <- mean(X)+sqrt(war)*qnorm(1-alfa/2)/sqrt(nn)
    p.uf1 <- c(L1, P1)
    # nieznana wariancja
    L2 <- mean(X)-sd(X)*qt(1-alpha/2, df=n-1)/sqrt(n)
    P2 <- mean(X)+sd(X)*qt(1-alpha/2, df=n-1)/sqrt(n)
    p.uf2 <- c(L2, P2)
    if(p.uf1[1]<=m&m<=p.uf1[2]) 
    {
      epp1<-epp1+1
    }
    if(p.uf2[1]<=m&m<=p.uf2[2]) 
    {
      epp2<-epp2+1  
    }
    s1 <- s1+(p.uf1[2]-p.uf1[1])
    s2 <- s2+(p.uf2[2]-p.uf2[1])
    a <- epp1/nn
    b <- epp2/nn
    c <- s1/nn
    d <- s2/nn
  }
  wynik <- c(p.uf1, p.uf2, s1, s2, a, b, c, d)
  return(wynik)
}

# zad 2
# H0: m=3.2, H1: m<3.2
# T=(x.sr - m0)/(s/sqrt(n))
# C={t: t<=t_(1-alfa, n-1)}
mleko <- c(3.26, 3.12, 3.24, 3.16, 3.08, 3.14, 3.13, 3.11, 3.09, 3.14)
m0 <- 3.2
alfa <- 0.05
n <- 10
x.sr <- mean(mleko) # 3.147
s <- sd(mleko) # 0.05945119
T <- (x.sr - m0)/(s/sqrt(n)) # -2.819131
kwantyl <- qt(1-alfa, n-1) # 1.833113
# C=(1.84, inf), T nie należy do C, więc przyjmujemy H0
# przedział ufności: 
P <- x.sr+kwantyl*s/sqrt(n) # (- inf, 3.181463]
# sprawdzenie: 
t.test(mleko,alternative="less",  mu=3.2) # p-value = 0.01004 < 0.05 = alfa => przyjmujemy H0,
# p. ufności: (-Inf 3.181463]

# zad 3
n <- 6
czas <- c(19, 18, 22, 20, 16, 25)
m <- 21.5
alfa <- 0.01
s <- sd(czas) # 3.162278
x_sr <- mean(czas) # 20
# T= (x.sr - m)/(s/sqrt(n))
T <- (x_sr - m)/(s/sqrt(n)) # -1.161895

# a) H0: m=21.5, H1: m≠21.5
# C={t: t należy do (-inf, -t_(1-alfa/2, n-1))u(inf, t_(1-alfa/2, n-1))}
kwantyl <- qt(1-alfa/2, n-1) # 4.032143
# T nie należy do C=(-inf, -4.03)u(4.03, inf), więc przyjmujemy H0
# przedział ufności: 
przedzial(czas, conf.level=0.99) # [14.79453 25.20547]
#sprawdzenie:
t.test(czas, conf.level=0.99, mu=21.5) # p-value = 0.2977 > 0.01 => przyjmujemy H0, 
# p. ufności: [14.79453 25.20547]

# b) H0: m=21.5, H1: m<21.5
# C={t: t należy do (-inf, -t_(1-alfa/2, n-1))u(inf, t_(1-alfa/2, n-1))}
kwantyl2 <- qt(1-alfa, n-1) # 3.36493
# T nie nalezy do C=(-inf, -3.36493) => przyjmujemy H0
# przedział: 
P=x_sr+kwantyl2*s/sqrt(n) # [-inf, 24.34411]
# sprawdzenie:
t.test(czas, conf.level=0.99, alternative="less", mu=21.5) # p-value = 0.1489 > 0.01 => przyjmujemy H0, 
# p. ufności:[-Inf 24.34411]

# zad 4
k1 <- c(24.3, 20.8, 23.7, 21.3, 17.4)
k2 <- c(18.2, 16.9, 20.2, 16.7)
alfa=0.05
sr1 <- mean(k1) # 21.5
sr2 <- mean(k2) #18.0 
s1 <- sd(k1) # 2.739526
s2 <- sd(k2) # 1.610383 
n1 <- length(k1) # 5
n2 <- length(k2) # 4
# na kolejnych zajeciach będziemy robili symulację

# a) H0: m1=m2, H1: m1≠m2 (H0 inaczej: m1-m2=0)
# b) H0: m1=m2, H1: m1>m2 (H0 inaczej: m1-m2=0)

# test t studentadla 2 .... wikipedia
se <- sqrt((((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2))*(1/n1+1/n2))
T <- (s1 - s2)/se # 0.7243453

# a)
# C={t: t należy do (-inf, -t_(1-alfa/2, n1+2n-2))u(t_(1-alfa/2, n1+n2-2), inf)}
kw <- qt(1-alfa/2, n1+n2-2) # C
L2 <- (x1-x2)-se*kw
P2 <- (x1-x2)+se*kw
c(L2,P2) # (-inf, -0.1860844) u (7.1860844, inf) T należy co C, więc przyjmujemy H0

L1 <- sr1-s1*kw/sqrt(n1)
P1 <- sr1+s1*kw/sqrt(n1)
P2 <- sr2+s2*kw/sqrt(n2)
L2 <- sr2-s2*kw/sqrt(n3)
p.uf1 <- c(L1, P1) # [17.2126 25.7874]
p.uf2 <- c(L2, P2) # [16.12150 20.81775]

# b)
# C={t: t należy do (t_(1-alfa, n1+2n-2), inf)}
kw <- qt(1-alfa, n1+n2-2) # C
L2 <- (x1-x2)+se*kw
c(L2, 0) # (6.453356, inf), T nie należy do C, więc odrzucamy H0

L1 <- sr1-s1*kw/sqrt(n) # [18.30436, inf]
L2 <- sr2-s2*kw/sqrt(n) # [16.1215, inf]

# sprawdzenie:
# a)
leveneTest(c(k1,k2), c(rep(1,5),rep(2,4)))
t.test(x=k1, y=k2, mu=0, var.equal=TRUE)  # [-0.1860844  7.1860844]
# p-value = 0.05961 > 0.05 = alfa => przyjmujemy H0
# b
t.test(x=k1, y=k2, mu=0, var.equal=TRUE, alternative = "greater")  # [ 0.5466442 Inf]
# p-value = 0.02981 < 0.05 = alfa => odrzucamy H0

# zad 5 
library(car)
k1 <- Salaries$salary[Salaries$sex=='Female']
k2 <- Salaries$salary[Salaries$sex=='Male']
leveneTest(c(k1,k2), c(rep(1,length(k1)),rep(2,length(k2)))) # zatem przyjmujemy zgodność wariancji
# 2a
# H0: sr.k1=sr.k2,  H1: sr.k1<sr.k2
# 2b
# H0: sr.k1=sr.k2,  H1: sr.k1~=sr.k2

var(k1)
var(k2)

alfa=0.05
sr1 <- mean(k1) # 101002.4
sr2 <- mean(k2) # 115090.4
s1 <- sd(k1) # 25952.13
s2 <- sd(k2) # 30436.93
n1 <- length(k1) # 39
n2 <- length(k2) # 358
se <- sqrt((((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2))*(1/n1+1/n2)) # 5064.579
T <- (x1 - x2)/se # -2.781674

# b)
# C={t: t należy do (-inf, -t_(1-alfa/2, n1+2n-2))u(t_(1-alfa/2, n1+n2-2), inf)}
kw <- qt(1-alfa/2, n1+n2-2) # C
L2 <- (s1-s2)-se*kw
P2 <- (s1-s2)+se*kw
c(L2,P2) # (- inf, -14441.701) u (5472.101, inf) T należy, więc przyjmujemy H0

L1 <- sr1-s1*kw/sqrt(n1)
P1 <- sr1+s1*kw/sqrt(n1)
c(L1, P1) # [92832.42 109172.40] - kobiety
P2 <- sr2+s2*kw/sqrt(n2)
L2 <- sr2-s2*kw/sqrt(n2)
c(L2, P2) # [111927.8 118253.0] - mężczyźni

# Znana wariancja, więc: 
kw <- qnorm(1-alfa/2) # C
L <- sr1-sqrt(var(k1))*kw/sqrt(n1)
P <- sr1+sqrt(var(k1))*kw/sqrt(n1)
c(L,P) # [92857.45 109147.37]
LL <- sr2-sqrt(var(k2))*kw/sqrt(n2)
PP <- sr2+sqrt(var(k2))*kw/sqrt(n2)
c(LL,PP)  # [111937.5 118243.3]

# a)
# C={t: t należy do (-inf, t_(1-alfa, n1+2n-2))}
kw <- qt(1-alfa, n1+n2-2) # C
L2 <- (s1-s2)+se*kw
c(0,L2) # (-inf, -12834.88) lub (-inf, 3865.275) T nie należy do C, więc odrzucamy H0

L1 <- sr1-s1*kw/sqrt(n1) # [-inf, 94150.88]
L2 <- sr2-s2*kw/sqrt(n2) # [-inf, 112438.2]

# znana wariancja
kw <- qnorm(1-alfa) # C
A <- sr1+sqrt(var(k1))*kw/sqrt(n1) # [-inf, 107837.9]
B <- sr2+sqrt(var(k2))*kw/sqrt(n2) # [-inf, 117736.4]
# czy
A <- sr1-sqrt(var(k1))*kw/sqrt(n1) # [-inf, 94150.88]
B <- sr2-sqrt(var(k2))*kw/sqrt(n2) # [-inf, 112438.2]
# ?

# spr 
# a
t.test(x=k1, y=k2, mu=0, var.equal=TRUE, alternative = "less") # p-value = 0.002834 < 0.05 więc odrzucamy H0
# b
t.test(x=k1, y=k2, mu=0, var.equal=TRUE) # p-value = 0.005667 < 0.05 więc przyjmujemy H0

# zad 6
A <- c(220, 185, 270, 285, 200, 295, 255, 190, 225, 230)
B <- c(190, 175, 215, 260, 215, 195, 260, 150, 155, 175)
# H0: A=B, H1: A>B
alfa <- 0.05
n <- length(A)
X <- 0
Y <- 0
for (i in 1:n){
  X <- X+A[i]-B[i]
}
D <- 1/n * X # 42
for (i in 1:n){
  Y <- Y+(A[i]-B[i]-D)^2
} 
SD <- sqrt(1/(n-1)*Y) # 42.62889
T=D/(SD/sqrt(n)) # 3.115626

# C={t: t należy do (-inf, t_(1-alfa, n1+2n-2))}
kw <- qt(1-alfa, n-1) # C
s1 <- mean(A) # 235.5
s2 <- mean(B) # 199
L2 <- (s1-s2)+SD*kw
# (114.6436, inf) T nie należy do C, więc odrzucamy H0


# spr
t.test(x=A, y=B, mu=0, var.equal=TRUE, paired=TRUE, alternative = 'greater') 
# t = 3.2863, df = 9, p-value = 0.004717 < 0.05 więc odrzucamy H0


# 09.05

# l.5

library(TeachingDemos)
run.ci.examp(reps=100, seed=123, method='z', n=25)
ci.examp(mean.sim=100, sd=10, n=25, reps=100, conf.level=0.95, method='z' )
# X11()

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

library(MASS)
data(Cars93)
attach(Cars93)
przedzial(Cars93$Price, conf.level=0.95)
View(Cars93)

# 16.05

hist(Price, prob=T)
sr<-mean(Price)
sigma<-sd(Price)
curve(dnorm(x, mean=sr, sd=sigma), col='red', add=T)
qqnorm(Price)
qqline(Price)
X<-rnorm(30)
qqnorm(X)
qqline(X)

# zad.5
kwantyl<-qt(0.95, df=15)
L<-3000-kwantyl*20/4
P<-3000+kwantyl*20/4
c(L,P)
# zad.6 - analogicznie do zad.5

# zad.7
n<-10
s2<-0.96
alfa<-0.1
curve(dchisq(x, df=9), from=0, to=30)
kw1<-qchisq(0.95, df=9)
kw2<-qchisq(0.05, df=9)
L<-(n-1)*s2/kw1
P<-(n-1)*s2/kw2
c(L,P)

# zad.8
pomiar<-c(102,105,102,100,108,97,96,98,100,101)
kw1<-qchisq(0.975, df=9)
kw2<-qchisq(0.025, df=9)
s2<-var(pomiar)
L<-(n-1)*s2/kw1
P<-(n-1)*s2/kw2 
c(L,P)

# zad.1 l.6
srednia<-0
wariancja<-1
ile.powt<-1000
Conf.level<-0.95
empir.pokjrycie1<-0
empir.pokjrycie2<-0
szerokosc1<-0
szerokosc2<-0
for(i in 1:ile.powt)
{
  X<-rnorm(n, mean=srednia, sd=wariancja)
  p.uf1<-przedzial(X, conf.level=Conf.level, var=wariancja)
  p.uf2<-przedzial(X, conf.level=Conf.level, var=NULL)
  if(p.uf1[1]<=srednia&srednia<=p.uf1[2]) empir.pokjrycie1<-empir.pokjrycie1+1
  if(p.uf2[1]<=srednia&srednia<=p.uf2[2]) empir.pokjrycie2<-empir.pokjrycie2+1
  szerokosc1<-szerokosc1+(p.uf1[2]-p.uf1[1])
  szerokosc2<-szerokosc2+(p.uf2[2]-p.uf2[1])
  empir.pokrycie1/ile.powt
  empir.pokrycie2/ile.powt
  szerokosc1/ile.powt
  szerokosc2/ile.powt
}
var(wariancja)

# zad.2 l.6

pomiar<-c(3.26, 3.12, 3.24, 3.16, 3.08, 3.14, 3.13, 3.11, 3.09, 3.14)
shapiro.test(pomiar) # czy rozkład jest normalny? p=0.09533, zatem tak
t.test(pomiar, mu=0.2) # czy średnia zawartość tłuszczu to 3.2?
# p-value < 2.2e-16, zatem nie odrzucamy hipotezy zerowej
# przedział ufności: 3.104471 3.189529, średnia to 3.147, zatem naukowcy mają rację
ci<-qnorm(0.95/2)
sr<-mean(pomiar)
s1<-3.2/sqrt(length(pomiar))
s2<-sr/sqrt(length(pomiar))
od1<-mean(pomiar) + c(-s1*ci,s1*ci)
od2<-mean(pomiar) + c(-s2*ci,s2*ci)
od1
od2
?t.test
t.test(pomiar)
# średnia: 3,14, przedział ufoności: [3.104471 3.189529], p.value<2.2e-16, 
# zatem nie możemy odrzucić hipotezy zerowej
kw1<-qchisq(0.995, df=9)
kw2<-qchisq(0.005, df=9)
s2<-var(pomiar)
L<-(n-1)*s2/kw1
P<-(n-1)*s2/kw2 
c(L,P) # 0.00134849 0.01833500
mean(pomiar)+c(-L, P)

#
pomiar<-c(3.26, 3.12, 3.24, 3.16, 3.08, 3.14, 3.13, 3.11, 3.09, 3.14) 
#H0: m=3.2, H1: m<3.2
# T=(x.sr - m0)/(S/sqrt(n))
# C={t: t<=t_(1-alfa, n-1)}
m<-3.2
alfa<-0.05
1-alfa #=0.95
shapiro.test(pomiar) # sprawdzamy, czy pomiar ma rozkład normalny
sr<-mean(pomiar) # średnia pomiaru = 3.147
SD<-sd(pomiar) # odchylenie standardowe = 0.05945119
S<-SD/sqrt(length(pomiar))
T=(sr-m)/(SD/sqrt(length(pomiar))) # wyznaczamy wartość statystyki testowej = -2.82
qt(1-alfa, 9) # 1.833113
# T należy do C -> odrzucamy H0
test.mleko<-t.test(x=pomiar, alternative="less", mu=3.2, conf.level=0.95)
test.mleko # p.value < alfa =>  odrzucamy H0, p.value>alfa =>  przyjmujemy H0
# p.value = 0.01004 < 0.05 = alfa => odrzucamy H0
przedzial(pomiar, conf.level=0.95) # [3.104471 3.189529]
# w tym przypadku [-inf 3.189529]

# weryfikacja hipotezy statystyki:
# 1. zbiór krytyczny (C) + wartość statystyki testowej
# 2. przedział ufności dla nieznanego parametru na poziomie ufności 1-alfa
# 3. p.value


#  zad.3 l.6
pomiar<-c(19, 18, 22, 20, 16, 25)
# 1) H0: m+21.5, H1=!21.5
# 2) H0: m+21.5, H1<21.5

# 1)
m<-21.5
alfa<-0.01
shapiro.test(pomiar) # sprawdzamy, czy pomiar ma rozkład normalny
sr<-mean(pomiar) # średnia pomiaru = 20
SD<-sd(pomiar) # odchylenie standardowe = 3.162278
S<-SD/sqrt(length(pomiar))
T=(sr-m)/S # wyznaczamy wartość statystyki testowej = -1.161895
qt(1-alfa/2, length(pomiar)-1) # 4.03 => C=(-inf, -4.03)u(4.03, inf), 
# T nie nalezy do C => przyjmujemy H0
test.bateria<-t.test(x=pomiar, alternative="two.sided", mu=21.5, conf.level=0.99)
test.bateria # p-value = 0.2977 > 0.01 => przyjmujemy H0
# przedzial(pomiar, conf.level=0.95)

# zad.4 l.6
# X1, X2, ... , Xn1 ~ N(m1, sigma)
# Y1, Y2, ... , Yn2 ~ N(m2, sigma)
# H0: m1=m2 <=> H0: SIGMA/m1-m2=0
# H1: m1=!m2 (a) v H1: m1<m2 (b) v H1: m1>m2
# T = (X.sr - Y.sr)/Sp sqrt(1/n1+1/n2) ~ t_(n1+n2-2)
# Sp^2 = [(n1-1)S1^2+(n2-1)S2^2]/(n1+n2-2)
# (a) C=(-inf, -t_(1-alfa/2, n-1)) u (t_(1-alfa/2, n-1), inf)
kop1<-c(24.3, 20.8, 23.7, 21.3, 17.4) 
kop2<-c(18.2, 16.9, 20.2, 16.7)
alfa<-0.05
# l. stopni swobody: n1+n2-2

t.test(x=kop1, y=kop2, conf.level=0.95, mu=0, var.equal=TRUE) 
# p-value = 0.05961 > 0.05 = alfa => przyjmujemy
# H0: m1-m2 = 0 , 
# 0 należy do [-0.1860844  7.1860844] => przyjmujemy

# zad.6 l.6

# (X1, Y1), (X2, Y2), ... , (Xn, Yn)
# H0: mA=mB, H1: mA>mB

przed<-c()
po<-c()
alfa<-0.05
t.test(x=przed, y=po, paired=TRUE, alternative = "greater", conf.level-0.95)
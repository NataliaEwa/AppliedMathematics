# Natalia £askarzewska 
# 221688
# gr D

########################################################
# ZAD 1
X<-c(1.14, 1.06, 1.13, 1.17)
alfa<-0.05

# a) H0: m=1.05, H1: m>1.05
t.test(X, alternative="greater", conf.level=0.95, mu=1.05)
# t = 3.2225, df = 3, p-value = 0.02425
# przedzia³ ufnoœci: [1.070228      Inf]
# œrednia: 1.125
# p-value = 0.02425 < 0.05 = alfa, zatem przyjmujemy H0


# b) H0: m=1.05, H1: m=!1.05 
t.test(X, conf.level=0.95, mu=1.05)
# t = 3.2225, df = 3, p-value = 0.04849
# pprzedzia³ ufnoœci: [ 1.050933 1.199067]
# œrednia: 1.125 
# p-value = 0.04849 < 0.05 = alfa, zatem przyjmujemy H0

#######################################################
ZAD 2
x.sr<-20.8
s<-2.9
n<-5
war<-s^2
# a) 
alfa<-0.01
kw1<-qchisq(1-alfa/2, n-1)
kw2<-qchisq(alfa/2, n-1)
L<-(n-1)*war/kw1
P<-(n-1)*war/kw2
a<-c(L,P) # [2.263756 162.520640]
# b)
alfa<-0.05
kw1<-qchisq(1-alfa/2, n-1)
kw2<-qchisq(alfa/2, n-1)
L<-(n-1)*war/kw1
P<-(n-1)*war/kw2
b<-c(L,P) # [3.018858 69.444078]
# Dla wiêkszego poziomu ufnoœci przedzia³ ufnoœci jest wiêkszy 

#####################################################
# ZAD 3

przedzial<-function(X, conf.level=0.95, var=NULL ){
  n<-length(X)
  alfa<-1-conf.level 
  if(is.null(var) == TRUE){
    L<-mean(X)-sd(X)*qt(1-alfa/2,df=n-1)/sqrt(n)
    P<-mean(X)+sd(X)*qt(1-alfa/2,df=n-1)/sqrt(n)
  }
  else{
    L<-mean(X)-sqrt(var/n)*qnorm(1-a/2)
    P<-mean(X)+sqrt(var/n)*qnorm(1-a/2)
  }
  return(c(L,P))
}

A <- function(M=5, n=5, lambda=1)
{
  sr<-1/lambda
  war<-1/lambda^2
  X<-0
  for (i in 1:M)
 {
  X<-X+rexp(lambda) # ?????
 }
wariancja<-1/n*mean(X)
  return(wariancja)
}
# wariancja dla lambda = 1, 
# dla n = 5: 
# dla n = 10: 
# dla n = 20: 
# dla n = 30:
# wniosek: 

# wariancja dla lambda = 5, 
# dla n = 5: 
# dla n = 10: 
# dla n = 20: 
# dla n = 30: 
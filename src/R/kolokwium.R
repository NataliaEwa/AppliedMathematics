# zad 1
m0 <- 30000
n <- 4
auto <- c(29000, 30000, 27000, 31000)
alfa <- 0.05
x.sr <- mean(auto)
s <- sd(auto)
T <- (x.sr-m0)/(s/sqrt(n)) # -0.8783101
# a) H0: m = 30000, H1: m ≠ 30000
# b) H0: m = 30000, H1: m < 30000

# a)
# C=(-inf, -t_(1-alfa/2, n-1))u(t_(1-alfa/2, n-1), inf)
kwantyl <- qt(1-alfa/2, n-1) # 3.182446
L <- x.sr - s*kwantyl/sqrt(n)
P <- x.sr + s*kwantyl/sqrt(n)
# C=(-inf, -3.182446)u(3.182446, inf), T nie nalezy do C, więc przyjmujemy H0
#sprawdzenie:
t.test(auto, mu=3000) # p-value = 7.563e-05 < 0.05 = alfa => przyjmujemy H0

# b)
# C=(-inf, t_(1-alfa, n-1)
kwantyl <- qt(1-alfa, n-1) # 2.353363 
# C=(-inf, 2.353), T należy do C, więc odrzucamy H0
P <- x.sr + s*kwantyl/sqrt(n)
# Przedział ufności: (-inf, 31259.57)
# sprawdzenie:
t.test(auto, alternative="less", mu=30000) # p-value = 0.05961 > 0.05 = alfa, więc odrzucamy H0

# zad 2
n <- 9
pomiar <- c(85, 95, 93, 100, 114, 99, 89, 106, 100)
var(pomiar)
cla <- 0.90
clb <- 0.95
alfa1 <- 1 - cla
alfa2 <- 1 - clb
p.sr <- mean(pomiar)
kw1 <- qchisq(1-alfa1/2, df=n-1)
kw1a <- qchisq(alfa1/2, df=n-1)
kw2 <- qchisq(1-alfa2/2, df=n-1)
kw2a <- qchisq(alfa2/2, df=n-1)
s <- sd(pomiar)
L1 <- (n-1)*var(pomiar)/kw1
P1 <- (n-1)*var(pomiar)/kw1a
L2 <- (n-1)*var(pomiar)/kw2
P2 <- (n-1)*var(pomiar)/kw2a
c(L1, P1)
c(L2, P2)


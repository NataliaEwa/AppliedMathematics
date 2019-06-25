## METODA NIEPARAMETRYCZNA

# rm(list=ls())

# Parametry:
alpha <- 1.25;  # p. kształtu
beta  <- 0.95;  # p. skośności
sigma <- 2.0;   # p. skali
mu    <- 0.0;   # p. przesunięcia

pars <- c(alpha, beta, sigma, mu) # wektor parametrów

x    <- seq(from=-5, to=100, by=0.1) # generujemy sekwencję od -5 dp 100 z krokiem 0.1

pdf  <- stable_pdf(x, pars, parametrization=0, tol=1e-12) # gęstość
cdf  <- stable_cdf(x, pars, parametrization=0, tol=1e-12) # dystrybuanta


p  <- seq(from=0.01, to=0.99, by=0.01) # wektor prawdopodobieństwa
q  <- stable_q(p, pars, parametrization=0, tol=1e-12) # kwantyle

N   <- 100; # N
rnd <- stable_rnd(N, pars) # generujemuy N liczb losowych

pars_est_M <- stable_fit_init(rnd) # oszacowanie parametrów na podstawie N obserwacji losowych

alpha_1 <- seq(from=1, to=N, by=1)
beta_1 <- seq(from=1, to=N, by=1)
sigma_1 <- seq(from=1, to=N, by=1)
mu_1 <- seq(from=1, to=N, by=1)
j=1

for (i in 1:N){
  rnd <- stable_rnd(N, pars)
  est <- stable_fit_init(pars) # oszacowanie parametrów metodą McCulloch'a
  alpha_1[j] <- est_M[1] 
  beta_1[j] <- est_M[2]
  sigma_1[j] <- est_M[3]
  mu_1[j] <- est_M[4]
  j=j+1
  }


  

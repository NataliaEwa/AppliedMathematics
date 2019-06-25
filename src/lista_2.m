clear all

% 1. W modelu regresji Yi = beta_0 + beta_1 * xi + error_i, i = 1, 2, ..., n
% gdzie error_i, i = 1, 2, ..., n sa niezaleznymi zmiennymi losowymi N(0, sigma) 
% wyznacz wariancje estymatorów B0^ oraz B1^.

beta_1 = 2;
beta_0 = 3;
N=100;
sigma = pi;
mu = 0;
x = 1:N;

y =  beta_1*x + beta_0 + normrnd(mu, sigma, 1, length(x));
b1 = sum(x.* (y-mean(y)))/sum((x-mean(x)).^2);
b0 = mean(y) - b1 * mean(x);
zad_1_var_b1 = sigma^2 / sum((x-mean(x)).^2)
zad_1_var_b0 = sigma^2 * ((1/N) + mean(x)/sum((x-mean(x)).^2))

% 2. Rozpatrzymy model regresji dany nastepujacym wzorem:
% Yi = beta_1*xi + error_i, i = 1, 2, ..., n,
% gdzie error_i i = 1, 2, ..., n sa niezaleznymi b?edami o rozk?adzie N(0, sigma).
% a) Wyznacz postac estymatora b1 wspó?czynnika kierunkowego metoda najmniejszych kwadratów.
% b) Sprawdz czy wyznaczony estymator jest estymatorem nieobciazonym parametru B1.
% c) Wyznacz wariancje estymatora.
% d) Policz cov(mean(y), b1).

zad_2_beta_1 = 2
N=100;
sigma = pi;
mu = 0;
x = 1:N;
y =  beta_1*x + normrnd(mu, sigma, 1, length(x));
zad_2_b1 = sum(x.* (y-mean(y)))/sum((x-mean(x)).^2)
zad_2_var_b1 = var(b1)
zadr_2_cov_y_b1 = cov(mean(y), b1)

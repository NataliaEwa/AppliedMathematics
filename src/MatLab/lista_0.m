clear all
hold on
data = load('dane1.csv');
data2 = importdata('dane2.csv');

% 1. Dla danych dostepnych na stronie oblicz srednia, 
% wariancje, skosnosc, kurtoze, mediane i kwartyle oraz narysuj boxplot

zad_1_mean_value = mean(data)
zad_1_var_value = var(data)
zad_1_skewness_value = skewness(data)
zad_1_kurtosis_value = kurtosis(data)
zad_1_median_value = median(data)
zad_1_q1 = quantile(data, 0.25)
zad_1_q2 = quantile(data, 0.5)
zad_1_q3 = quantile(data, 0.75)
boxplot(data);
title('zad1')

% 2. Napisz w Matlabie funkcje tworzaca unormowany histogram. 
% Dla danych dostepnych na stronie porownaj otrzymany histogram
% z gestoscia rozkladu normalnego o wyestymowanych parametrach.

figure
n = length(data);
[a, b] = hist(data, 10);
m = b(2) - b(1);
bar(b, a / (m * n));
hold on;
min(data)
max(data)

plot(linspace(min(data), max(data)), normpdf(linspace(min(data), max(data)), mean(data), sqrt(var(data))));
title('zad2')

% 3. Napisz w Matlabie funkcje tworzaca dystrybuante empiryczna. 
% Dla danych dostepnych na stronie porównaj otrzymana dystrybuante 
% z dystrybuanta rozkladu normalnego o wyestymowanych parametrach.

figure
[c, d] = ksdensity(data);
F = [];
for i = 1 : length(d)
    ecdf = 0;
    for k = 1 : length(data)
        if(data(k) <= d(i))
            ecdf = ecdf + 1;
        end
    end
    F(i) = ecdf;
end
F = F / n;
plot(d, F);
hold on 
plot(d, normcdf(d, mean(data), sqrt(var(data))), 'r--');
title('zad3')

% 4. Dla dwuwymiarowych danych dostepnych na 
% stronie narysuj wykres rozrzutu, oblicz srednie i macierz kowariancji.

figure
scatter(data2(:, 1), data2(:, 2));
title('zad4')
zad_4_mean_value_1 = mean(data2(:, 1))
zad_4_mean_value_2 = mean(data2(:, 2))
zad_4_covariance = cov(data2(:, 1), data2(:, 2))

% 5. Wygeneruj probke o dlugosci 1000 z rozkladu normalnego N(2,2). 
% Przeprowadz test zgodnosci rozkladu Kolmogorowa-Smirnowa dla rozkladu N(2,2), 
% odczytaj p-value. Porownaj wyniki z testem dla rozkladu normalnego 
% z wyestymowanymi parametrami. 

X = normrnd(2, 2, 1, 1000);
test_cdf = [X' cdf('normal', X, 2, 2)'];
[h, p] = kstest(X, 'CDF', test_cdf);
zad_5_p_norm = p
test_dane = [X' cdf('normal', X, mean(data), sqrt(var(data)))'];
[h, p] = kstest(X, 'CDF', test_dane);
zad_5_p_est = p

% 6. Wygeneruj probke o dlugosci 10 z rozkladu U([-0.5,0.5]). 
% Przeprowadz test zgodnosci rozkladu Kolmogorowa-Smirnowa dla rozk?adu N(0,1), 
% odczytaj p-value. Powtorz eksperyment dla probki o dlugosci 100.

X = 0.5 * rand(1, 10);
test_cdf = [X' cdf('normal', X, 0, 1)'];
[h, p] = kstest(X, 'CDF', test_cdf);
zad_6_p_10 = p
X = 0.5 * rand(1, 100);
test_cdf = [X' cdf('normal', X, 0, 1)'];
[h, p] = kstest(X, 'CDF', test_cdf);
zad_6_p_100 = p






clear all;


% 1. W modelu regresji 
% Yi = beta_0 + beta_1 * xi + error_i, i = 1, 2, ..., n
% gdzie error_i, i = 1, 2, ..., n s? niezale?nymi zmiennymi losowymi N(0, sigma), 
% za pomoc? metodyMonteCarlo sprawd? rozk?ad estymatorów b0 oraz b1 i porównaj 
% go z rozk?adem teoretycznym przy ustalonej wielko?ci sigma.

beta_0 = 1;
beta_1 = 2;
mu = 0;
sigma = 1;
N = 100;

x = linspace(1,N);

b0s = [];
b1s = [];
for i=1:1000
    y = beta_0 + beta_1 * x + normrnd(mu, sigma, 1, N);
    b1 = sum(x.* (y-mean(y)))/sum((x-mean(x)).^2);
    b1s = [b1s b1];
    b0 = mean(y) - b1 * mean(x);
    b0s = [b0s b0];
end

[a, b] = ecdf(b0s);
plot(b,a)
new_sigma_b0 = sigma * ((1/N) + mean(x)^2 / sum((x-mean(x)).^2))
new_mu_b0 = beta_0
hold on
plot(sort(b), normcdf(sort(b), beta_0, sqrt(new_sigma_b0)), 'r-')


figure
[a, b] = ecdf(b1s);
plot(b,a)
new_sigma_b1 = sigma / sum((x-mean(x)).^2)
new_mu_b1 = beta_1
hold on
plot(sort(b), normcdf(sort(b), beta_1, sqrt(new_sigma_b1)), 'r-')

% 2. Wykorzystujac ta sama metode co w poprzednim zadaniu, sprawdz 
% rozklady studentyzowanych estymatorow b0 oraz b1 i porownaj je z 
% rozkladami teoretycznymi.
figure

beta_0 = 1;
beta_1 = 2;
mu = 0;
sigma = 1;
N = 100;

x = linspace(1,N);

b0s = [];
se_b0s = [];
b1s = [];
se_b1s = [];
for i=1:1000
    y = beta_0 + beta_1 * x + normrnd(mu, sigma, 1, N);
    b1 = sum(x.* (y-mean(y)))/sum((x-mean(x)).^2);
    b1s = [b1s b1]; 
    b0 = mean(y) - b1 * mean(x);
    b0s = [b0s b0];
    se_b1 = sqrt((sqrt((1/(N-2)) * sum((y - (b0 + b1 * x)).^2))) / sum((x-mean(x)).^2));
    se_b1s = [se_b1s se_b1];
    se_b0 = se_b1 * sqrt(sum(x.^2) / N);
    se_b0s = [se_b0s se_b0];
end

[a, b] = ecdf((b1s - beta_1) ./ se_b1s);
plot(b,a)
hold on
plot(sort(b), tcdf(sort(b), N-2), 'r-')

figure
[a, b] = ecdf((b0s - beta_0) ./ se_b0s);
plot(b,a)
hold on
plot(sort(b), tcdf(sort(b), N-2), 'r-')


% 3. Skonstruuj przedzialy ufnosci dla parametrów beta_0 i beta_1 z równania 
% z zad. 1 na danym poziomie ufnosci alpha. Nastepnie za pomoca metody 
% Monte Carlo, sprawdz jakie jest prawdopodobienstwo, ze teoretyczne 
% wartosci parametrow naleza do wyznaczonych przedzialow ufnosci.
% Wyniki wykonaj dla roznych dlugosci prob oraz w dwoch przypadkach, 
% kiedy sigma jest znana i nieznana.

N = 100;
M = 1000;

beta_0 = 1;
beta_1 = 2;
mu = 0;
sigma = 1;
alpha = 0.05

b0_sigma_znane = 0; 
b0_sigma_nieznane = 0;
b1_sigma_znane = 0;
b1_sigma_nieznane = 0;

x = 1:N;
for i=1:M
    y = beta_0 + beta_1 * x + normrnd(mu, sigma, 1, N);
    b1 = sum(x.* (y-mean(y)))/sum((x-mean(x)).^2);
    b1s = [b1s b1]; 
    b0 = mean(y) - b1 * mean(x);
    b0s = [b0s b0];
    se_b1 = sqrt((sqrt((1/(N-2)) * sum((y - (b0 + b1 * x)).^2))) / sum((x-mean(x)).^2));
    se_b1s = [se_b1s se_b1];
    se_b0 = se_b1 * sqrt(sum(x.^2) / N);
    se_b0s = [se_b0s se_b0];
    b0_sigma_znane_tail = norminv(1-(alpha/2)) * sigma * sqrt(((1/N) + (mean(x)^2)/sum((x-mean(x)).^2)));
    if (b0 - b0_sigma_znane_tail < beta_0) && (beta_0 < b0 + b0_sigma_znane_tail)
        b0_sigma_znane = b0_sigma_znane + 1;
    end
    b0_sigma_nieznane_tail = tinv(1 - alpha/2, N-2) * se_b0;
    if (b0 - b0_sigma_nieznane_tail < beta_0) && (beta_0 < b0 + b0_sigma_nieznane_tail)
        b0_sigma_nieznane = b0_sigma_nieznane + 1;
    end
    b1_sigma_znane_tail = norminv(1 - (alpha/2)) * sigma * (1 / sqrt(sum((x-mean(x)).^2)));
    if (b1 - b1_sigma_znane_tail < beta_1) && (beta_1 < b1 + b1_sigma_znane_tail)
        b1_sigma_znane = b1_sigma_znane + 1;
    end
    b1_sigma_nieznane_tail = tinv(1 - (alpha/2), N-2) * se_b1;
    if (b1 - b1_sigma_nieznane_tail < beta_1) && (beta_1 < b1 + b1_sigma_nieznane_tail)
        b1_sigma_nieznane = b1_sigma_nieznane + 1;
    end
end

b0_sigma_znane = b0_sigma_znane/M
b0_sigma_nieznane = b0_sigma_nieznane/M
b1_sigma_znane = b1_sigma_znane/M
b1_sigma_nieznane = b1_sigma_nieznane/M


% 4. Dla danych z zadania 5/lista 1 skonstruuj prosta regresji na podstawie 
% 990 najmniejszych obserwacji. Skonstruuj przedzial ufnosci dla prognozy 
% w modelu regresji dla ostatnich 10 najwiekszych obserwacji i porównaj 
% z danymi. Zadanie wykonaj przy zalozeniu, ze sigma jest znana i nieznana.

data = load('dane_zad4.m');
data = sortrows(data);
data_990 = data(1:990,:);
x_990 = data_990(:, 1);
x = data(:, 1);
y_990 = data_990(:, 2);
y = data(:, 2);
b1 = sum(x_990.* (y_990-mean(y_990)))/sum((x_990-mean(x_990)).^2); 
b0 = mean(y_990) - b1 * mean(x_990);
sigma_znane = 0;
sigma_nieznane = 0;

for i=991:1000
    y_est = b0 + b1 * x(i);
    se = sqrt(((1/(length(x_990)-2)) * sum((y_990 - (b0 + b1 * x_990)).^2)) * (1 + (1/length(x_990)) + ((x(i) - mean(x_990)).^2)/sum((x_990-mean(x_990)).^2)));
    sigma_nieznane_tail = tinv(1 - (alpha/2), length(x_990)-2) * se;
    if (y_est - sigma_nieznane_tail < y(i)) && (y(i) < y_est + sigma_nieznane_tail)
        sigma_nieznane = sigma_nieznane + 1;
    end
end

sigma_nieznane = sigma_nieznane/10




% 5. Wysymuluj dwuwymiarowy wektor (x, Y ) opisany równaniem (1).
% Wyznacz przedzia?y ufno?ci dla warto?ci ?redniej zmiennej Y (x0) 
% dla x0 = x dla ró?nych wielko?ci n przy za?o?eniu, ?e ? 
% jest wielko?ci? znan?.














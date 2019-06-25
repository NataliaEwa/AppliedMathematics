clear all
hold on

% 1. Dla danych ze strony www narysuj wykres rozproszenia, traktujac 
% pierwsza kolumne jak zmienna objasniajaca, a druga jako zmienna 
% objasniana. Znajdz przyblizona zaleznosc funkcyjna pomiedzy danymi 
% wykorzystujac toolbox cftool.

data_1 = load('dane_zad1.m');
x1 = data_1(:, 1);
y1 = data_1(:, 2);
scatter(x1, y1)

hold on
minsquares = @(a) sum((y1 - a(1).*exp(a(2).*x1)).^2);
a = fminsearch( minsquares,[1,1]);
a(1)
a(2)
plot(sort(x1), a(1).*exp(a(2).*sort(x1)), 'r')
title('zad1')

% 2. Dane ze strony www wyg?adz wykorzystujac prosta srednia ruchoma o
% podstawie 11, podstawie 25 oraz podstawie (2p+1) dla wybranej wielkosci 
% p. Wykonaj odpowiednie wykresy.

figure
data_2 = load('dane_zad2.m');
x2 = data_2;
results = [];
for i=6:(length(x2) - 5)
    results = [results mean(x2(i-5:i+5))];
end
subplot(3,1,1)
plot(results)

results = [];
for i=13:(length(x2) - 12)
    results = [results mean(x2(i-12:i+12))];
end
subplot(3,1,2)
plot(results)

p=401;
results = [];
half = floor(p/2);
for i=(half + 1):(length(x2) - half)
    results = [results mean(x2(i-half:i+half))];
end
subplot(3,1,3)
plot(results)
title('zad2')

% 3. Na postawie danych z zadania 2 (zmienna objasniajaca) i danych z 
% zadania 3 (zmienna objasniana) wyznacz prosta regresji na podstawie 
% metody najmniejszych kwadratów. Wykonaj to samo zadanie dla zmiennej 
% objasniajacej, która zosta?a wyg?adzona za pomoca znanych metod. 
% Wykonaj odpowiednie wykresy.
figure
data_3 = load('dane_zad3.m');
x3 = x2;
y3 = data_3;
subplot(2, 1, 1)
scatter(x3, y3);
hold on;
b1 = sum(x3 .* (y3 - mean(y3))) / sum((x3 - mean(x3)) .^ 2);
b0 = mean(y3) - b1 * mean(x3);
plot(x3, b0 + b1 * x3, 'r')

p=401;
rows = sortrows([x3, y3]);
x3b = rows(:, 1);
y3b = rows(:, 2);
p=11;
results = [];
half = floor(p / 2);
for i=(half + 1):(length(x3b) - half)
    results = [results mean(y3b(i - half : i + half))];
end
y3b = results;
x3b = x3b((half + 1):(end - half))';
subplot(2, 1, 2)
scatter(x3b, y3b);
hold on;
b1 = sum(x3b .* (y3b - mean(y3b))) / sum((x3b - mean(x3b)) .^ 2);
b0 = mean(y3b) - b1 * mean(x3b);
plot(x3b, b0 + b1 * x3b, 'r')

% 4. Dla danych ze strony www wyznacz prosta regresji traktujac pierwsza 
% kolumne jako zmienna objasniajaca, a druga jako zmienna objasniana. 
% Wspó?czynniki prostej regresji wyznacz wykorzystujac metode najmniejszych 
% kwadratów. Nastepnie wyznacz residua. Zaproponuj swoja metode wyznaczania 
% obserwacji odstajacych. Usun je, a nastepnie jeszcze raz wyznacz prosta
% regresji.

figure
data_4 = load('dane_zad4.m');
data_4 = sortrows(data_4);
x4 = data_4(:, 1);
y4 = data_4(:, 2);
subplot(2,1,1)
scatter(x4, y4);
hold on;

b1 = sum(x4 .* (y4 - mean(y4))) / sum((x4 - mean(x4)) .^ 2);
b0 = mean(y4) - b1 * mean(x4);
plot(x4, b0 + b1 * x4, 'r')
residuum = y4 - (b0 + b1*x4);
res_90 = sort(abs(residuum));
res_90 = res_90(floor(0.9 * length(residuum)));
new_x4 = [];
new_y4 = [];
for i=1:length(residuum)
    if abs(residuum(i)) < res_90
        new_x4 = [new_x4 x4(i)];
        new_y4 = [new_y4 y4(i)];
    end
end
subplot(2,1,2)
scatter(new_x4, new_y4);
hold on
b1_new = sum(new_x4 .* (new_y4 - mean(new_y4))) / sum((new_x4 - mean(new_x4)) .^ 2);
b0_new = mean(new_y4) - b1_new * mean(new_x4);
plot(new_x4, b0_new + b1_new * new_x4, 'g')

% 5. Dla danych z zadania 4 wyznacz jeszcze raz prosta regresji 
% wykorzystujac jedynie 990 obserwacji. Nastepnie dokonaj predykcji dla 
% obserwacji 991,...,1000 na podstawie zaproponowanej prostej. 
% Wyznacz b?edy predykcji.

figure
data_5 = load('dane_zad4.m');
data_5 = sortrows(data_5);
x5 = data_5(:, 1);
x5_990 = x5(1:990);
y5 = data_5(:, 2);
y5_990 = y5(1:990);
b1 = sum(x5_990 .* (y5_990 - mean(y5_990))) / sum((x5_990 - mean(x5_990)) .^ 2);
b0 = mean(y5_990) - b1 * mean(x5_990);
y_pred = b0 + b1 * x5(991:end);
errors = y5(991:end) - y_pred;
subplot(2,1,1)
scatter(x5(991:end), y5(991:end))
hold on
plot(x5(991:end), y_pred, 'r')
subplot(2,1,2)
plot(x5(991:end), abs(errors), 'ro')

% 6. Dla danych ze strony www zaproponuj funkcje zaleznosci dla danych, 
% nastepnie dokonaj ich transformacji i wykorzystujac regresje liniowa 
% znajdz prosta opisujaca przetransformowane dane.

% zgadujemy zaleznosc wykladnicza
% szukamy takiej funkcji, ze lny = b1xi + b0
figure
data_6 = load('dane_zad6.m');
data_6 = sortrows(data_6);
x6 = data_6(:,1);
y6 = data_6(:,2);
subplot(3,1,1)
scatter(x6, y6);
hold on;
y6_trans = log(abs(y6));
subplot(3,1,2)
plot(x6, log(abs(y6)), 'r.');
b1 = sum(x6 .* (y6_trans - mean(y6_trans))) / sum((x6 - mean(x6)) .^ 2);
b0 = mean(y6_trans) - b1 * mean(x6);
subplot(3,1,3)
scatter(x6, y6_trans);
hold on
plot(x6, b0 + b1 * x6, 'r')






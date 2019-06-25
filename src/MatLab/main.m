close all; clear; clc;
format long;

disp('ZADANIE 5');

% blad absolutny
blad = 0.0005;

% przedzial calkowania
a = 0;
b = 1;

% funkcja podcalkowa
f = inline('exp(x)');

% dokladna wartosc calki
I = exp(b) - exp(a);

% maksymalna liczba podprzedzialow
mmax = 10000;

disp('METODA TRAPEZOW');
for m = 1 : mmax
  S = trapezow(f,a,b,m);
  bladAbsolutny = abs(S - I);
  if bladAbsolutny <= blad
    disp('minimalna liczba podprzedzialow');
    disp(m);
    disp('blad absolutny');
    disp(bladAbsolutny);
    disp('blad teoretyczny');
    bladTeoretyczny = abs((b - a) ^ 3 / (12 * m ^ 2) * f(1));
    disp(bladTeoretyczny);
    disp('wartosc bezwzgledna z roznicy miedzy bledem teoretycznym a absolutnym');
    disp(abs(bladTeoretyczny - bladAbsolutny));
    break;
  end
end


disp('METODA SIMPSONA');
for m = 1 : mmax
  S = simpsona(f,a,b,m);
  bladAbsolutny = abs(S - I);
  if bladAbsolutny <= blad
    disp('minimalna liczba podprzedzialow');
    disp(m);
    disp('blad absolutny');
    disp(bladAbsolutny);
    disp('blad teoretyczny');
    bladTeoretyczny = abs((b - a) ^ 5 / (90 * m ^ 4) * f(1));
    disp(bladTeoretyczny);
    disp('wartosc bezwzgledna z roznicy miedzy bledem teoretycznym a absolutnym');
    disp(abs(bladTeoretyczny - bladAbsolutny));
    break;
  end
end


disp('ZADANIE 11');

m = [10 25 50 100 150 200];
n = length(m);


disp('metoda trapezow');
blad = zeros(1,n);
for i = 1 : n
  disp('m =');
  disp(m(i));
  S = trapezow(f, a, b, m(i));
  disp('blad =');
  blad(i) = abs(S - I);
  disp(blad(i));
end

figure;
semilogy(m,blad);
xlabel('liczba podprzedzialow');
ylabel('blad absolutny');
title('metoda trapezow');



disp('metoda Simpsona');
blad = zeros(1,n);
for i = 1 : n
  disp('m =');
  disp(m(i));
  S = simpsona(f, a, b, m(i));
  disp('blad =');
  blad(i) = abs(S - I);
  disp(blad(i));
end

figure;
semilogy(m,blad);
xlabel('liczba podprzedzialow');
ylabel('blad absolutny');
title('metoda Simpsona');



disp('metoda prostokatow');
blad = zeros(1,n);
for i = 1 : n
  disp('m =');
  disp(m(i));
  S = prostokatow(f, a, b, m(i));
  disp('blad =');
  blad(i) = abs(S - I);
  disp(blad(i));
end

figure;
semilogy(m,blad);
xlabel('liczba podprzedzialow');
ylabel('blad absolutny');
title('metoda prostokatow');
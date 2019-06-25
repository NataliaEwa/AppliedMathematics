function result = splain(xi,yi)

% sprawdzenie danych wejciowych (dlugosci wektorow)
if length(xi) ~= length(yi) 
  error('Wektor xi oraz yi nie sa tej samej d³ugoci'); 
end

% wyznaczanie dlugosc wektora
n = length(xi); 
di=yi;


% wektor h - odleglosc przesuniec miedzy poszczegolnymi punktami
h = zeros(n-1,1); 
for j = 1:n-1
  h(j) = xi(j+1) - xi(j); 
end

%  macierz A o wymiarach nxn
A = zeros(n);

% warunki brzegowe dla splajnow: 
A(1,1) = 1; 
A(n,n) = 1;

% 3 przekatne do macierzy A
for i = 2:n-1 
  A(i,i-1) = h(i-1); 
  A(i,i) = 2*(h(i-1)+h(i)); 
  A(i,i+1) = h(i); 
end

% wektor  b: 
b = zeros(n,1);
for i = 2:n-1 
  b(i) = (3/h(i))*(di(i+1)-di(i)) - (3/h(i-1))*(di(i)-di(i-1));     
end

% wektor bi: 
bi = A\b;

% wspolrzedne wektora ai
ai = zeros(n-1,1); 
for i = 1:n-1 
  ai(i) = (1/(3*h(i))) * (bi(i+1)-bi(i)); 
end

% wspolrzedne wektora ci
ci = zeros(n-1,1); 
for i = 1:n-1 
  ci(i) = (1/h(i))*(di(i+1)-di(i)) - (1/3*h(i))*(2*bi(i)+bi(i+1)); 
end

% obliczenia 
resolution = 1000;
result=[];

for i = 1:n-1 
  f = @(x) (ai(i).*(x-xi(i)).^3) + (bi(i).*(x-xi(i)).^2) + (ci(i).*(x-xi(i)))+ di(i);
  xf = linspace(xi(i),xi(i+1),resolution);

  % wynik
  result=[result f(xf)]; 
end
end 

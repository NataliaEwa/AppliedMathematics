clear all;
clc;

n = input('Ilo�� element�w w sumie: ');
mi = input('Warto�� oczekiwana rozk�adu normalnego: ');
sigma = input('Odchylenie standardowe rozk�adu normalnego: ');

[X, Y] = meshgrid(linspace(0, 1, 30), linspace(0, 1, 30));

Z = zeros(size(X));

for i = 1 : n
    A = mi + sigma * randn;
    s = mi + sigma * randn;
    
    x0 = rand;
    y0 = rand;
    
    Z = Z + A * exp(-((X - x0) .^ 2 + (Y - y0) .^ 2) / s);
end;

surf(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('g(x, y)');

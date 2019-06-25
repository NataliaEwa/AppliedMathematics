N = 100;
a = 1103515245;
c = 12345;
m = 2^31;
okres = 0;
X0 = 5;
X1 = 5;
X2 = 0;
X = [X1];
while (X2 ~= X0)
    X2 = mod(a * X1 + c , m);
    X = [X X2];
    X1 = X2;
    okres =okres +1;
end
figure
% [y,x] = ecdf(X);
% plot(x,y, 'r-')
% Z = unifcdf(linspace(1,100, 100), 0, 100);
% hold on
% plot(Z)
% figure

[y,x] = ksdensity(X);
plot(x,y,'r-')
Z = unifpdf(linspace(1,100, 100), 0, 100);
hold on
plot(Z)


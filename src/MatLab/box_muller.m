
figure
u1 = unifrnd(0,1,1,10);
u2 = unifrnd(0,1,1,10);
X = (-2*log(u1)).^(1/2) .* cos(2*pi*u2);
[y,x] = ksdensity(X);
plot(x,y, 'r--')
hold on
plot(x, normpdf(x))
figure
u1 = unifrnd(0,1,1,100);
u2 = unifrnd(0,1,1,100);
X = (-2*log(u1)).^(1/2) .* cos(2*pi*u2);
[y,x] = ksdensity(X);
plot(x,y, 'r--')
hold on
plot(x, normpdf(x))
figure
u1 = unifrnd(0,1,1,1000);
u2 = unifrnd(0,1,1,1000);
X = (-2*log(u1)).^(1/2) .* cos(2*pi*u2);
[y,x] = ksdensity(X);
plot(x,y, 'r--')
hold on
plot(x, normpdf(x))
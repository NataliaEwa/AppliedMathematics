ys = [];
x = linspace(0,10)
y = gamcdf(x,2,3);
zera = x>5;
y = y.*zera;
y = y.*(exp(15)/16);
plot(x,y)

%hold on
%u = (9 *  exp(15) * (1/16))*(x.* exp(-3*x));
%u = u.*zera
%plot (x,u)

%plot(x,y)


hold on
B = cumsum([0, normrnd(0,1,1,10^3).*(0.01)^(1/2)])
length(B)
length(linspace(0,10,1001))
plot(linspace(0,10,1001), B, 'm')
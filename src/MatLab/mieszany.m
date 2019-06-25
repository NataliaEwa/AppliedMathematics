clear all;
T=20;

for i=1:10
lambda = binornd(1, 1);
t = 0;
I = 0;
S = [];
while t<=T
    I = I +1;
    S = [S t];
    u = rand();
    t
    t = t - (1/lambda)*log(u);
end

stairs([0 S T], [0:I+1], 'Linewidth', 1)
hold on
end
x = linspace(0,T,1000);
plot(x, x, 'r', 'Linewidth', 2)
hold on
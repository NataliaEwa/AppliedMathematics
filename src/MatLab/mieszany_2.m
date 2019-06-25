clear all;
T=10;

for i=1:10
lambda = normrnd(5,3);
n=poissrnd(lambda*T);
if (n~=0 && isnan(n)==0) 
u = unifrnd(0,T,1,n);
S = sort(u);
stairs([S T], 0:length(S))
hold on
end
end
x = linspace(0,T,1000);
plot(x, 5 * x, 'r', 'Linewidth', 2)
hold on
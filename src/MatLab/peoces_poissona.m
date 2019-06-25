clear all;
%algorytm 1
lambda = 2;
colors = ['g', 'r', 'b', 'y', 'm']
for i=1:5
I = 0;
t=0;
T=10;
S = [];
lambda = i;
while 1
    rand_ = unifrnd(0,1);
    t = t-1/lambda * log(rand_);
    if t>T
        break;
    end
    I = I+1;
    S = [S t];
end
hold on;
s = [0 S];
stairs(s, [0:length(s)-1], colors(i),'LineWidth',1);
%hold on;
end
legend('lambda = 1', 'lambda = 2', 'lambda = 3', 'lambda = 4', 'lambda = 5')
%plot(s, lambda*s, 'k')


%algorytm 2
T=10;
lambda = 2;
n = poissrnd(lambda*T);
while n==0
    n = poissrnd(lambda*T);
end
data = unifrnd(0,T,1,n);
S = sort(data);
%stairs([0 S], [0:n],'LineWidth',1);
t = [0:T];
w_0 = t*lambda;

hold on;

%plot(t,w_0,'LineWidth',1);
clear all;
%jednorodny z lambda = 2
lambda = 2;
I = 0;
t=0;
T=10;
N_t = [];
while 1
    rand_ = unifrnd(0,1);
    t = t-1/lambda * log(rand_);
    if t>T
        break;
    end
    I = I+1;
    N_t = [N_t t];
end

u = 0;
c = linspace(0, T, 10000);
N = length(N_t);
X = exprnd(1, 1, N);
R = zeros(1, 10000);
for i=1:length(c)
    R(i) = u + c(i);
    for j=1:length(N_t);
        if c(i)>N_t(j)
            R(i) = R(i) - X(j);
        end
    end
end
plot(c, R)

%lambda(t) = 0.05 *t^2
clear all
T=10;

x = linspace(0,T);
x =  (0.05) *(x.^2);
lambda = max(x)
t=0;
I=0;
while t<=T
    u1 = unifrnd(0,1);
    t = t - (1/lambda)*log(u1);
    if t>T
        break
    end
    u2 = unifrnd(0,1);
    if (u2<=(0.05 * (t^2))/lambda)
        I = I+1;
        S(I) = t;
    end
end

stairs(S, 0:I-1)



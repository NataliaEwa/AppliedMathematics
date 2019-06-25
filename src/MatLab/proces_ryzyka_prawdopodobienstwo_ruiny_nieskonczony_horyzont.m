clear all;
N=1000;
teta=0.3;
Z=0;
F=zeros(1,20);
for u=1:20
    Z=0;
    for i=1:N
        K=geornd(teta/(1+teta));
        X=exprnd(1,1,K);
        if sum(X)>u
            Z=Z+1;
        end
        F(u)=Z/N;
    end
end
plot(F,'b*')
hold on
u = [0:20];
psi = (1/1.3) * exp(((-0.3/1.3) * u));
plot(u,psi, 'ro')
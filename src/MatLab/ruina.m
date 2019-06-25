N=1000;
T=10;
beta=1;
lam=1.001;
n=0;
ksi=zeros(1,10);
for j=1:N
S=[];
I=0;
t=0;
while t<=T
I=I+1;
S(I)=t;
u=rand();
t=t-1/lam*log(u);
end
X=exprnd(1/beta,1,sum(S<T));
u=0;
t=[0:0.01:T];
c=1*t;
R=[];
for i=1:length(t)
ile=sum(S<t(i))-1;
R(i)=u+c(i)-sum(X(1:ile));
if R(i)<0
czas=ceil(t(i));
ksi(czas:end)=ksi(czas:end)+1;
break;
end
end
end
ksi=ksi/N;
plot(ksi,'*')
hold off
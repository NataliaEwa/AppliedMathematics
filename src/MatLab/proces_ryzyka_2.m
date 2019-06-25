clear all
prawdopodobienstwo_ruiny_poisson_jednorodny = 0;
for j=1:1000
    I=0;
    t=0;
    T=10;
    S=[];
    lam=1.001;
    while t<=T
        U=unifrnd(0,1);
        t=t-(1/lam)*log(U);
        S=[S t];
        I=I+1;
    end
    u=0;
    t=linspace(0,T,10000);
    N=length(S);%iloœæ skoków
    X=exprnd(1,1,N);
    R=zeros(1,10000);
    c=1*t;
    for i=1:length(t)
        R(i)=u+c(i);
        for j=1:length(S)
            if t(i)>S(j)
                R(i)=R(i)-X(j);
            end
        end
    end
    if min(R)<0
       prawdopodobienstwo_ruiny_poisson_jednorodny = prawdopodobienstwo_ruiny_poisson_jednorodny + 1;
    end
end
prawdopodobienstwo_ruiny_poisson_jednorodny = prawdopodobienstwo_ruiny_poisson_jednorodny/1000

clear all
T=10;
prawdopodobienstwo_ruiny_poisson_niejednorodny = 0;
for j=1:1000
n=-1;
while n<=0
    n = poissrnd( -cos(T) + 2*T);
end

m = -cos(T) + 2*T;
v = [];
for i=1:n
    u1 = unifrnd(0,T);
    u2 = unifrnd(0, 1);
    %lambda = 2 + 1/(u1+1)
    %calka = 2*T + 1* log(1+T)
    while u2>((sin(u1) + 2)/(-cos(T) + 2*T))*m/T;
        u1 = unifrnd(0,T);
        u2 = unifrnd(0, 1);
    end
    v = [v, u1];
end
S = sort(v);



u=0;
t=linspace(0,T,10000);
N=length(S);%iloœæ skoków
X=exprnd(1,1,N);
R=zeros(1,10000);
c=1*t;
for i=1:length(t)
    R(i)=u+c(i);
    for j=1:length(S)
        if t(i)>S(j)
            R(i)=R(i)-X(j);
        end
    end
end
 if min(R)<0
       prawdopodobienstwo_ruiny_poisson_niejednorodny = prawdopodobienstwo_ruiny_poisson_niejednorodny + 1;
    end
end
prawdopodobienstwo_ruiny_poisson_niejednorodny = prawdopodobienstwo_ruiny_poisson_niejednorodny/1000



clear all
T=10;

prawdopodobienstwo_ruiny_poisson_mieszany = 0;
for j=1:1000

lambda = abs(normrnd(1, 0.5));
t = 0;
I = 0;
S = [];
while t<=T
    I = I +1;
    S = [S t];
    u = rand();
    t = t - (1/lambda)*log(u);
end

u=0;
t=linspace(0,T,10000);
N=length(S);%iloœæ skoków
X=exprnd(1,1,N);
R=zeros(1,10000);
c=1*t;
for i=1:length(t)
    R(i)=u+c(i);
    for j=1:length(S)
        if t(i)>S(j)
            R(i)=R(i)-X(j);
        end
    end
end
if min(R)<0
       prawdopodobienstwo_ruiny_poisson_mieszany = prawdopodobienstwo_ruiny_poisson_mieszany + 1;
    end
end
prawdopodobienstwo_ruiny_poisson_mieszany = prawdopodobienstwo_ruiny_poisson_mieszany/1000


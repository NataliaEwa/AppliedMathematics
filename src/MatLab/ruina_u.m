N=1000;
T=10;
beta=1;
lam=1.001;
n=0;
ilosc_prob = 1000;
wyniki = [];
for us=0:10
    ruiny = 0;
    for j=1:ilosc_prob
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
        u=2*us;
        t=linspace(0,T,10000);
        N=length(S);
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
            ruiny = ruiny + 1;
        end
    end
    prawdopodobienstwo_ruiny = ruiny/ilosc_prob;
    wyniki = [wyniki prawdopodobienstwo_ruiny]
end
plot(2*[0:10], wyniki, 'r*')
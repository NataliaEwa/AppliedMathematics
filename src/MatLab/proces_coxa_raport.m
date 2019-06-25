 clear all;
%generowanie N_{2}(t) - jednorodnego pr. Poissona z \lambda=3
I=0;
t=0;
T=10;
lambda=3;
i=1;
S=[];

while t<=T
    U=rand;
    t=t-1/lambda*log(U);
    I=I+1;
    S(i)=t;
    i=i+1;
end

%teraz mamy wektor momentow skokow S
%musimy z niego zrobic wektor wartosci N_{2} na przedziale [0,T]

argumentyN2 = linspace(S(1),T,1000*T);
wartosciN2 = zeros(1,length(argumentyN2));

for i=1:length(S)
    wartosciN2 = wartosciN2 + (argumentyN2>=S(i));
end
wartosciN2=wartosciN2-1;
%teraz mamy wektor z wartosciami N2 

lambda=max(wartosciN2);

t=0;
I=0;
S=[];

while t<=T
    U1=rand;
    t=t-1/lambda *log(U1);
    if t>10
        break;
    end
    I=I+1;
    S(I)=t;
end

indeks_x=1;
N=[];
for k=1:length(S)
    wartosc_skoku=wartosciN2(indeks_x);
    while argumentyN2(indeks_x)<=wartosciN2(k)
        indeks_x=indeks_x+1;
        N=[N wartosc_skoku];
    end
end
N=[N wartosciN2(indeks_x:end)];
hold on;
plot(argumentyN2,N,'LineWidth',1);
plot(argumentyN2, 3*argumentyN2,'r--');
xlabel('t');
ylabel('N(t)')

box on;


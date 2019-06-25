function zad14_1 %metoda z wyk�adu - plik Zad14_1.pdf

xs=[-1 -0.5 0 0.5 1]; %wsp�rz�dne punkt�w dla podpunktu a)
ys=[1.194 0.430 0.103 0.322 1.034];

%xs=[-0.00001 0 0.00001]; %wsp�rz�dne punkt�w dla podpunktu b)
%ys=[0.3 0.6 0.7]; 

n=length(xs);

plot(xs,ys,'r*')
hold on
wspolczynnik_a=(sum(ys.*exp(xs)).*sum(exp(-2.*xs))-n.*sum(ys.*exp(-xs)))./(sum(exp(2.*xs)).*sum(exp(-2.*xs))-n^2); %rozwi�zane w pliku Zad14.pdf
wspolczynnik_b=(sum(exp(2.*xs)).*sum(ys.*exp(-xs))-n.*sum(ys.*exp(xs)))./(sum(exp(2.*xs)).*sum(exp(-2.*xs))-n^2);

x=-2:0.1:2; %�eby nie by�o kanciastego wykresy, rysujemy gesto��
f=wspolczynnik_a*exp(x)+wspolczynnik_b*exp(-x);

plot(x,f)

end
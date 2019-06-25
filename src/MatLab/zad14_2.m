function zad14_2 %inna metoda - plik Zad14_2.pdf

xs=[-1 -0.5 0 0.5 1]; %wspó³rzêdne punktów dla podpunktu a)
ys=[1.194 0.430 0.103 0.322 1.034];

%xs=[-0.00001 0 0.00001]; %wspó³rzêdne punktów dla podpunktu b)
%ys=[0.3 0.6 0.7]; 

n=length(xs);
x=-2:0.1:2;

aa=[sum(exp(2*xs)) n; n sum(exp(-2*xs))];
bb=[sum(ys.*exp(xs)); sum(ys.*exp(-xs))];
xx=aa\bb;

a=xx(1);
b=xx(2);
f=a*exp(x)+b*exp(-x)

plot(xs,ys,'r*')
hold on
plot(x,f)

end
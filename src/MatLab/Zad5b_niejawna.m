function Zad5b_niejawna(h)

c1=-1/2;
c2=-1/4; %przyk³adowe sta³e dla 1 trajektorii
t=[0:0.01:5];
x=c1*exp(t);
y=c2*exp(-t); %rozwi¹zanie analityczne x i y
plot(x,y,'g')
xlabel('x(t)')
ylabel('y(t)')
hold on

c1=1/2; %przyk³adowe sta³e dla 2 trajektorii
c2=-1/4; 
x=c1*exp(t);
y=c2*exp(-t); %rozwi¹zanie analityczne x i y
plot(x,y,'g')

c1=-1/2; %przyk³adowe sta³e dla 3 trajektorii
c2=1/4;
x=c1*exp(t);
y=c2*exp(-t); %rozwi¹zanie analityczne x i y
plot(x,y,'g')

c1=1/2; %przyk³adowe sta³e dla 4 trajektorii
c2=1/4;
x=c1*exp(t);
y=c2*exp(-t); %rozwi¹zanie analityczne x i y
plot(x,y,'g')
title('Trajektorie rozwi¹zañ analitycznych')
 
%trajektorie dla przybli¿onych rozwiazañ
figure(2)
 t=[0:h:5];
 X2(1)=-c1;
Y2(1)=-c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wzór na kolejny wyraz ci¹gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wzór na kolejny wyraz ci¹gu y_n
    
end
plot(X2,Y2,'r.')
 
X2(1)=-c1;
Y2(1)=c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wzór na kolejny wyraz ci¹gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wzór na kolejny wyraz ci¹gu y_n
    
end
plot(X2,Y2,'r.')

X2(1)=c1;
Y2(1)=-c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wzór na kolejny wyraz ci¹gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wzór na kolejny wyraz ci¹gu y_n
    
end
plot(X2,Y2,'r.')

X2(1)=c1;
Y2(1)=c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wzór na kolejny wyraz ci¹gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wzór na kolejny wyraz ci¹gu y_n
    
end
plot(X2,Y2,'r.')
xlabel('x(t)')
ylabel('y(t)')
title('Trajektorie rozwi¹zañ przybli¿onych')

%porównanie rozwi¹zania analitycznego z rozwi¹zaniem znalezionym metod¹ niejawn¹ eulera dla jednej trajektorii
figure(3)
plot(x,y,'g')
xlabel('x(t)')
ylabel('y(t)')
hold on

t=[0:h:5];
X2(1)=c1;
Y2(1)=c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wzór na kolejny wyraz ci¹gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wzór na kolejny wyraz ci¹gu y_n
    
end
plot(X2,Y2,'ro')
legend('rozwiazanie analityczne','metoda niejawna Eulera')
xlim([min(x) max(x)])

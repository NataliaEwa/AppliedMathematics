function Zad5a_jawna(h)

c1=-2;
c2=-4; %przyk�adowe sta�e dla 1 trajektorii
t=[0:0.01:5];
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g') 
xlabel('x(t)')
ylabel('y(t)')
hold on

c1=2; %przyk�adowe sta�e dla 2 trajektorii
c2=-4;
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g')

c1=-2; %przyk�adowe sta�e dla 3 trajektorii
c2=4;
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g')

c1=2; %przyk�adowe sta�e dla 4 trajektorii
c2=4;
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g')
title('Trajektorie rozwiaza� analitycznych')
 
%trajektorie dla przybli�onych rozwi�za�
 figure(2)
 t=[0:h:5];
 X2(1)=-c1;
Y2(1)=-c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wz�r na kolejny wyraz ci�gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wz�r na kolejny wyraz ci�gu y_n
    
end
plot(X2,Y2,'r.')
 
X2(1)=-c1;
Y2(1)=c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wz�r na kolejny wyraz ci�gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wz�r na kolejny wyraz ci�gu y_n
    
end
plot(X2,Y2,'r.')

X2(1)=c1;
Y2(1)=-c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wz�r na kolejny wyraz ci�gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wz�r na kolejny wyraz ci�gu y_n
    
end
plot(X2,Y2,'r.')

X2(1)=c1;
Y2(1)=c2; %miejsca zerowe
hold on
for i=1:length(t)-1
    X2(i+1)=X2(i)/(1-h); %wz�r na kolejny wyraz ci�gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wz�r na kolejny wyraz ci�gu y_n
   
end

plot(X2,Y2,'r.')
title('Trajektorie rozwiaza� przybli�onych')

%por�wnanie rozwi�zania analitycznego z rozwi�zaniem znalezionym metod� jawn� eulera dla jednej trajektorii
figure(3)
plot(x,y,'g')
xlabel('x(t)')
ylabel('y(t)')
hold on

%metoda eulera jawna
t=[0:h:5];
X1(1)=c1; %miejsca zerowe
Y1(1)=c2;
for i=1:length(t)-1
    X1(i+1)=X1(i)*(1+h);
    Y1(i+1)=Y1(i)*(1-h);
end
plot(X1,Y1,'ro')
legend('rozwi�zanie analityczne','metoda jawna Eulera')
xlim([min(x) max(x)])
end
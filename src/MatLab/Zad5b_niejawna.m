function Zad5b_niejawna(h)

c1=-1/2;
c2=-1/4; %przyk�adowe sta�e dla 1 trajektorii
t=[0:0.01:5];
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g')
xlabel('x(t)')
ylabel('y(t)')
hold on

c1=1/2; %przyk�adowe sta�e dla 2 trajektorii
c2=-1/4; 
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g')

c1=-1/2; %przyk�adowe sta�e dla 3 trajektorii
c2=1/4;
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g')

c1=1/2; %przyk�adowe sta�e dla 4 trajektorii
c2=1/4;
x=c1*exp(t);
y=c2*exp(-t); %rozwi�zanie analityczne x i y
plot(x,y,'g')
title('Trajektorie rozwi�za� analitycznych')
 
%trajektorie dla przybli�onych rozwiaza�
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
xlabel('x(t)')
ylabel('y(t)')
title('Trajektorie rozwi�za� przybli�onych')

%por�wnanie rozwi�zania analitycznego z rozwi�zaniem znalezionym metod� niejawn� eulera dla jednej trajektorii
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
    X2(i+1)=X2(i)/(1-h); %wz�r na kolejny wyraz ci�gu x_n
    Y2(i+1)=Y2(i)/(1+h); %wz�r na kolejny wyraz ci�gu y_n
    
end
plot(X2,Y2,'ro')
legend('rozwiazanie analityczne','metoda niejawna Eulera')
xlim([min(x) max(x)])

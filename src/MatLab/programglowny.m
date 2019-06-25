clear
clc

a=0;
b=3;
 %warunek brzegowy y(a)
 y02=a;
 tmax=1;
 h=0.01;
 
for c=-10:0.1:10 % Metoda wstrzeliwania
  %warunek brzegowy y'(a)
  y01=c;
  [t2,y2] = eulermod(tmax,y01,y02,h);
  if (abs(y2(2,length(y2))-1)<0.1)
    poprawnec=c;
    break
  end

end

disp('Ustalona wartosc warunku dy/dt=1 dla b=1:')
disp(poprawnec)

y01=poprawnec;
[t2,y2] = eulermod(tmax,y01,y02,h);

xx=0:h:tmax;
yd=xx-sin(pi.*xx);

y2=y2+1;
figure(1)
plot(y2(2,:),t2,'ro')
hold on
plot(yd,xx,'b*')
xlabel('x [m]')
ylabel('y [m]')
title('Zmodyfikowana metoda Eulera')
legend('rozwiazanie przyblizone','rozwiazanie dokladne')
grid on

disp('Blad metody: ')
disp(sum((y2(2,:)-yd(1:length(yd)-1)).^2))

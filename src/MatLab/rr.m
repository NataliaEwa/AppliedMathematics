
clear all
hold off
figure(1)
tspan = [0 700]; % przedzia³, dla którego szukamy rozwišzañ 
 y0 = [6.4; 0.92]; %warunki poczštkowe 
 [T, Y]=ode45(@f,tspan,y0); % metoda ode45
 hold on
 plot(T,Y(:,1),'b', T,Y(:,2), 'r')
 data = load('dane.csv');
 powiat = data(:,1)./100000;
 miasto = data(:,2)./100000;
 plot(powiat, 'r*');
 plot(miasto, 'b*')
 xlim([0, 100])
 grid on


 legend('Miasto','Powiat')
 
 hold off
 
 figure(2)
 hold on
 plot(T,Y(:,1),'b', T,Y(:,2), 'r')
 data = load('dane.csv');
 powiat = data(:,1)./100000;
 miasto = data(:,2)./100000;
 plot(powiat, 'r*');
 plot(miasto, 'b*')
 xlim([0, 400])
 grid on
 
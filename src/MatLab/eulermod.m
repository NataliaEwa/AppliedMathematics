function [t2,y2] = eulermod(tmax, y01,y02,h)
n = floor(tmax/h); % Metoda Rungego Kutty 2 rzedu
y2=zeros(2,n);
t2=zeros(1,n);
y2(1,1)=y01;
y2(2,1)=y02;
for i = 1:n-1 
    y2(:,i+1) = y2(:,i) + h*(rownania(t2(i)+h/2,y2(:,i))+rownania(t2(i),y2(:,i))*h/2);
    t2(i+1)=t2(i)+h;
end
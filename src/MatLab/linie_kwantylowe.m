clear all;
B=[];
ilosc_trajektorii=1000;
T=10;
h=T/ilosc_trajektorii;

for i=1:ilosc_trajektorii
    B=[B; cumsum([normrnd(0,1,1,ilosc_trajektorii).*h^(1/2)])];
end
t=linspace(0,T,ilosc_trajektorii);
q1=[];
q2=[];

for i=1:1000
    q1=[q1 quantile(B(:,i),0.50)];
    q2=[q2 quantile(B(:,i),0.60)];
end


kwantyl1 = t.^(1/2) * norminv(0.5);
kwantyl2 = t.^(1/2) * norminv(0.6);
hold on
plot(t,kwantyl1, 'b--', 'LineWidth', 2)
%plot(t,kwantyl2, 'r--', 'LineWidth', 2)
%plot(t(1,:),q2,'r');
plot(t(1,:), q1,'b');
plot(t,B(1,:),'g');
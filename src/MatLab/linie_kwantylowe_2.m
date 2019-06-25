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

B1 = [];
for i=1:ilosc_trajektorii
    B_temp = B(i,:);
    B_temp(end) = [];
    B1 = [B1; B(i,:) - [0, B_temp]];
end

for i=1:ilosc_trajektorii
    q1=[q1 quantile(B1(:,i),0.10)];
    q2=[q2 quantile(B1(:,i),0.90)];
end

hold on
plot(t(1,:), B1(1,:));
plot(t(1,:),q2,'r');
plot(t(1,:), q1,'g');

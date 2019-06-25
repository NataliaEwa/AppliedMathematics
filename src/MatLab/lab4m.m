function metoda_biegunowa
n=10000
i=1;

while i<n
    V1=unifrnd(-1,1);
    V2=unifrnd(-1,1);
    rkw= V1^2 + V2^2;
    if rkw<=1
        x(i)=sqrt(-2*log(rkw)/rkw)*V1;
        y(i)=sqrt(-2*log(rkw)/rkw)*V2;
        i=i+1;
    end
end

figure(1)
subplot(2,2,1)
plot(x,y,'x');
axis equal;
title('Realizacje X i Y');
suptitle('4');

subplot(2,2,2);
[Y t]=hist(x,100);
hold on;
z=normpdf(t,0,1);
plot(t,z,'r','LineWidth',6);
bar(t,Y/(n*(t(2)-t(1))));
title('Histogram generacji X porównany z faktyczn¹ gêstoœci¹ rozk³adu normalnego');

subplot(2,2,3);
[X t]=hist(y,100);
hold on;
z=normpdf(t,0,1);
plot(t,z,'r','LineWidth',6);
bar(t,X/(n*(t(2)-t(1))));
title('Histogram generacji Y porównany z faktyczn¹ gêstoœci¹ rozk³adu normalnego');

subplot(2,2,4);
hold on;
r=x.^2 + y.^2;
[R t]=hist(r,100);
bar(t,R/(n*(t(2)-t(1))));
z=exppdf(t,2); %z parametrem lambda=1/2 bo liczymy wartosic oczekiwane EX^2 i EY^2 i patrzymy na ER
plot(t,z,'r','LineWidth',6);
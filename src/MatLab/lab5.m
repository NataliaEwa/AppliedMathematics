x = [];
for (i=1:10000)
    r = rand();
    if (r<0.2)
        x = [x normrnd(-5,1)];
    else
        x = [x normrnd(8,1)];
    end
end
[a b] = ksdensity(x);
%plot(b, a)
c  =normpdf(b,-5,1)*0.2;
d  =normpdf(b,8,1)*0.8;
%plot(b,a,b,c,b,d)


lambda=1;
trajektorie = [];
for (i=1:1000)
    I =0;
    t=0;
    S = [];
    while (t <= 5)
        u = unifrnd(0,1);
        t = t - (1/lambda) * log(u);
        I = I+1;
        S(I) = t;
    end
    trajektorie = [trajektorie I-1];
end
x = 1:length(trajektorie);

[a b] = ecdf(trajektorie);
pois = poisscdf(b,5);
%plot(b,a,b,pois)



%druga metoda poissona T=100, lambda=5

n = poissrnd(100*5);

q = 100.*rand(1,n);
q = sort(q);
[a b] = ksdensity(diff(q));
%plot(b,a)
%figure
%plot(b, exppdf(b,1/5))



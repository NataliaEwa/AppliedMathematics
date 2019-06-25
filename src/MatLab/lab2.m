clear all;

%metoda akceptacji-odrzucenia dyskretnej
n = 10000;
y = [];
c=1.6;
q_y = 0.25;
count = [0 0 0 0]
p_xs = [0.15 0.15 0.3 0.4];
while (length(y)<n)
    y_test = ceil(rand()*4);
    py = p_xs(y_test);
    if (rand()<=py)
        y = [y y_test ];
    end
end
%plot ([1,2,3,4], [0.15, 0.15, 0.3, 0.4], 'o');
%hold on;
%plot([1,2,3,4], [sum(y==1)/n, sum(y==2)/n, sum(y==3)/n, sum(y==4)/n], 'ro');



%metoda odwracania dystrybuanty dyskretna

y = [];
for k=1:n
    los = rand();
    y = [(2*los + 1/4)^(1/2) - 1/2 y];
end

x =0:1/n:1;
[f, xx] = ecdf(y);
%plot(x,(1/2)*(x.^2 + x));
%hold on;
%plot(xx,f, 'r--');


%metoda akceptacji-odrzucenia ciagla

alfa = 0.5;
c = 2^(alfa) * exp(1-alfa) * (1-alfa)^(1-alfa);
ys = [];
n=10000;
koniec = [];
my =[];
for k=1:n
    y = exprnd(1);
    u = rand();
    if (u * c)<=(2^(alfa)   *   exp(-y) *  y ^ (alfa-1)  )
        ys = [y ys];
    end
end

%hold on
figure
[a,b] = ksdensity(ys);
plot(b,a, 'r')
hold on;
teo = 2^(alfa) * exp(-2*b) .* b.^(alfa-1);
plot(b, teo, 'k')


alfa = 1;
c = 2^(alfa) * exp(1-alfa) * (1-alfa)^(1-alfa);
ys = [];
n=10000;
koniec = [];
my =[];
for k=1:n
    y = exprnd(1);
    u = rand();
    if (u * c)<=(2^(alfa)   *   exp(-y) *  y ^ (alfa-1)  )
        ys = [y ys];
    end
end

%hold on
figure
[a,b] = ksdensity(ys);
plot(b,a, 'g')
hold on;
teo = 2^(alfa) * exp(-2*b) .* b.^(alfa-1);
plot(b, teo, 'k')


alfa = 5;
c = 2^(alfa) * exp(1-alfa) * (1-alfa)^(1-alfa);
ys = [];
n=10000;
koniec = [];
my =[];
for k=1:n
    y = exprnd(1);
    u = rand();
    if (u * c)<=(2^(alfa)   *   exp(-y) *  y ^ (alfa-1)  )
        ys = [y ys];
    end
end

figure
[a,b] = ksdensity(ys);
plot(b,a, 'b')
hold on
teo = 2^(alfa) * exp(-2*b) .* b.^(alfa-1);
plot(b, teo, 'k')

alfa = 50;
c = 2^(alfa) * exp(1-alfa) * (1-alfa)^(1-alfa);
ys = [];
n=10000;
koniec = [];
my =[];
for k=1:n
    y = exprnd(1);
    u = rand();
    if (u * c)<=(2^(alfa)   *   exp(-y) *  y ^ (alfa-1)  )
        ys = [y ys];
    end
end

%hold on
figure
[a,b] = ksdensity(ys);
plot(b,a, 'y')
hold on;
teo = 2^(alfa) * exp(-2*b) .* b.^(alfa-1);
plot(b, teo, 'k')



















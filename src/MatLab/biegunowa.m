
figure
n=10
wyniki = []
while length(wyniki)<n
     u1 = unifrnd(-1,1);
    u2 = unifrnd(-1,1);
    if ((u1^2 + u2^2)<=1)
        wyniki = [wyniki u1 * (-2* log(u1^2 + u2^2)/(u1^2 + u2^2))^(1/2)]
    end
end
[y,x] = ksdensity(wyniki);
plot(x,y, 'r--')
hold on
plot(x, normpdf(x))
figure
n=100
wyniki = []
while length(wyniki)<n
    u1 = unifrnd(-1,1);
    u2 = unifrnd(-1,1);
    if ((u1^2 + u2^2)<=1)
        wyniki = [wyniki u1 * (-2* log(u1^2 + u2^2)/(u1^2 + u2^2))^(1/2)]
    end
end
[y,x] = ksdensity(wyniki);
plot(x,y, 'r--')
hold on
plot(x, normpdf(x))
figure
n=1000
wyniki = []
while length(wyniki)<n
    u1 = unifrnd(-1,1);
    u2 = unifrnd(-1,1);
    if ((u1^2 + u2^2)<=1)
        wyniki = [wyniki u1 * (-2* log(u1^2 + u2^2)/(u1^2 + u2^2))^(1/2)]
    end
end
[y,x] = ksdensity(wyniki);
plot(x,y, 'r--')
hold on
plot(x, normpdf(x))
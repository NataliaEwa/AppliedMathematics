clear all
lambda = 2;
p0 = exp(-lambda);
N=100;
p = [p0];
for i=1:N-1
    px = (p(i) * lambda/(i));
    p = [p px];
end
p = cumsum(p)
X = [];
for z=1:N
    los = rand()
    for i=1:length(p)
        if los<=p(i)
               X = [X i-1];
               break
        end
    end
end
[y,x] = ecdf(X);
k = ksdensity(X)
plot(k)
hold on
t = [1:100]
z = poisspdf(t, lambda)
plot(z, 'r--')
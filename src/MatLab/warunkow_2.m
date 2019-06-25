hold off
alpha = 1;
n=1000;
x=[];
c=2^alpha * exp(1-alpha) *(1-alpha)^(1-alpha);
while length(x)<n
    length(x);
    u=rand();
    y=exprnd(1);
    if (   (2^alpha)*exp(-y)*y^(alpha-1) >= u*c)
           x=[x y];
    end
end
    [a b]=ecdf(x);
    plot(b,a, 'r')
    hold on
    alpha = 2;
n=1000;
x=[];
c=2^alpha * exp(1-alpha) *(1-alpha)^(1-alpha);
while length(x)<n
    length(x);
    u=rand();
    y=exprnd(1);
    if (   (2^alpha)*exp(-y)*y^(alpha-1) >= u*c)
           x=[x y];
    end
end
    [a b]=ecdf(x);
    plot(b,a, 'g')
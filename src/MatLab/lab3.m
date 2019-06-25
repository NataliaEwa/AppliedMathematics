%rozklad Erlanga
n = 120;
lambda = 1;
y = [];
while (length(y)<n)
    y_new = rand(1,10);
    y_new = -1/lambda * log(y_new);
    y_new = sum(y_new);
    y = [y y_new];
end

%[f, x] = ksdensity(y);
%gestosc = lambda * exp(x*(-lambda)) .* (lambda*x).^ 9 / factorial(9);
%hold on;
%plot (x,f)
%plot(x, gestosc, 'r')


%metoda przyjmowania-odrzucania dla dowolnych rozk³adów

%dana dystrubuanta f(x) = (2/pi)*x^(1/2) *exp(-x)
% g(x) = 2/3 * e^(2/3 * x)
    n=1000;
    x=[];
    c=45 * exp(10) / 32;
    while length(x)<n
        length(x)
       u=rand();
       y=exprnd(1/2);
       while (y<5)
           y=exprnd(1/2);
       end
       if (   ((9*exp(15)/32)*y*exp (-y))     >= u*c)
           x=[x y];
       end
    end
    [a b]=ksdensity(x);
    plot(b,a, 'r')
    teoretyczna = (9/16)* exp(15) * b .* exp(-3*b);
    hold on
    plot(b, teoretyczna)
    
    % 


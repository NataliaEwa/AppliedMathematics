function y = metoda_1(lambda, n)
    X =  unifrnd(0.01,0.99,1,n);
    y = (-log(X)./lambda).^2;
end
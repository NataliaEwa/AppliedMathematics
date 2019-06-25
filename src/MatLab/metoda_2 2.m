function y = metoda_2(lambda, n)
    x = 2;
    T = [];
    for i=1:n
        U =  [unifrnd(0,1,1,1)];
        X = [-log(unifrnd(0,1,1,1))/(lambda*x)];
        while (U(end) > 1 + exp(sum(X)))
            U = [U, unifrnd(0,1,1,1)];
            X = [X, -log(unifrnd(0,1,1,1))/(lambda*x)];
        end
        T = [T, sum(X)];
    end
    
    y = T;
end
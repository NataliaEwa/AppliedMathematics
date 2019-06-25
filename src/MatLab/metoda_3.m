function y = metoda_3(lambda, n)
    epsilon = 0.00001;
    T = [];
    for i=1:n
        U =  unifrnd(0,1,1,1);
        X = -log(U) / lambda;
        L = 0;
        R = 1;
        while ((1 + sqrt(R) - exp(-R)) <= X)
            L = R;
            R = 10 * R;
        end
        while R - L >= epsilon
            C = (L + R) / 2;
            if ((1 + sqrt(C) - exp(-C)) < X)
                L = C;
            else
                R = C;
            end
        end
        T = [T C];
    end
    y = T;
end
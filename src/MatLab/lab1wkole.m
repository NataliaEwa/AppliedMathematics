function y=lab1wkole(n)
    w_kole = 0;
    for k=0:n
        x = 2* rand() -1;
        y = 2* rand() -1;
        if (x^2 + y^2 <=1)
            w_kole = w_kole +1;
        end
    end
    y=w_kole/n;
end
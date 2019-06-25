n=8
    y =[];
    for k=0:n
        los = rand();
        if (los<0.11)
            y = [y 5];
        elseif (los<0.2)
            y = [y 6];
        elseif (los<0.31)
            y = [y 7];
        elseif (los<0.4)
            y = [y 8];
        elseif (los<0.51)
            y = [y 9];
        elseif (los<0.6)
            y = [y 10];
        elseif (los<0.71)
            y = [y 11];
        elseif (los<0.8)
            y = [y 12];
        elseif (los<0.91)
            y = [y 13];
        elseif (los<=1)
            y = [y 14];
        end
    end
    hist(y);

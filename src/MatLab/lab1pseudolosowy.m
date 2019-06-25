function y=lab1pseudolosowy(n)
    y=[];
    for k=0:n
        los = rand();
        if (los<0.5)
            y = [y 3];
        elseif (los<0.8)
            y = [y 1];
        else
            y = [y 2];
        end
    end
    hist(y);
end
function y=plyinterpolate(x, c, n, wezly)
    [rzad, kolumna] = size(x)
    y = [];
    
    for i=1:rzad
        for j=1:kolumna
            qs = [];
            for k=0:n
                qs(k+1) = q(k, x(i,j), wezly);
            end
            y(i,j) = sum(c.*qs);
        end
    end
end
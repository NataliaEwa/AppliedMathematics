function [x, y] = polynomial_interpolate(x, wartosci, n, wezly)
    n = n+1;
    A = [];
    for i=1:length(wezly)
        for j=1:n
            A(i,j) = sum(wezly.^(i+j-2));
        end
    end
    B = [];
    for i=1:length(wezly)
        B(i) = sum((wartosci) .* (wezly.^(i-1)));
    end
    X = A\(B');
    y = [];
    for i=1:length(x)
        temp = sum((x(i).^[0:length(X)-1]).* X');
        y = [y temp];
    end
end
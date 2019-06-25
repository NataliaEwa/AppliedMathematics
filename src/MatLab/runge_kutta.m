function [t, w] = runge_kutta(f, w0, a, b, N)
    % szerokoœæ kroku
    h = (b - a) / N;
    % dziedzina
    t = a:h:b;
    % liczba równañ
    m = size(f);
    m = m(2);
    % zagadnienia pocz¹tkowe
    w = [w0];
    % macierz pomocniczych k 
    k = [];
    
    % co jeden krok
    for i=1:N
        % wylicz pomocnicze k
        for j=1:m
            k(1, j) = h * f{j}(w(i, :));
        end
        for j=1:m
            k(2, j) = h * f{j}(w(i, :) + 0.5 * k(1, :));
        end
        for j=1:m
            k(3, j) = h * f{j}(w(i, :) + 0.5 * k(2, :));
        end
        for j=1:m
            k(4, j) = h * f{j}(w(i, :) + 0.5 * k(3, :));
        end
        % i na ich podstawie wylicz przybli¿on¹ wartoœæ w punkcie a + ih
        for j=1:m
            w(i+1, j) = w(i, j) + (k(1, j) + 2 * k(2, j) + 2 * k(3, j) + k(4, j))/6;
        end
    end
end
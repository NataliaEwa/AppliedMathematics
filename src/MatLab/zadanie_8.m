clear all;
% liczba kroków
N = 100;
% przy³adowe przedzia³y do sprawdzenia
a = [0, 5, 10];
b = [10, 30, 25];
% przyk³adowe wartoœci poczt¹kowe do sprawdzenia
w0 = [1, 0; 5, 1; -1, 10];
% zdefiniowane funkcje
f1 = @(v) -v(2) + v(1) * (1 - sqrt(v(1)^2 + v(2)^2));
f2 = @(v) v(1) + v(2) * (1 - sqrt(v(1)^2 + v(2)^2));
f = {f1, f2};

% rysunki rozwi¹zañ dla przyk³adowych wartoœci
for i=1:length(a)
    a_i = a(i);
    b_i = b(i);
    w_i = w0(i, :);
    [t, w] = runge_kutta(f, w_i, a_i, b_i, N); 
    figure(i)
    hold on 
    subplot(2,2,1)
    plot(t, w(:, 1))
    title('x(t)')
    grid on
    subplot(2,2,3)
    plot(t, w(:, 2))
    title('y(t)')
    grid on
    subplot(2,2,[2,4])
    scatter(w(:, 1), w(:, 2), 'r.')
    title('x^2(t) + y^2(t)')
    grid on
end



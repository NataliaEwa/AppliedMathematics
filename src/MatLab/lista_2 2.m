clear all
% lista 2 zad 7
% a)
as = [0, pi, (-3/2) * pi, (3/2) * pi];
xs = [];
figure(1)
for i=1:length(as)
    xs = [as(i)];
    while cos(xs(end)) ~= xs(end)
        xs = [xs cos(xs(end))];
    end
    subplot(length(as), 1, i)
    plot(xs, 'b.-')
    title(['x_0 = ', num2str(as(i)), ',  x_{k+1} = cos(x_k), dlugosc ciagu numerycznego: ', num2str(length(xs)), ', ciag dazy do: ', num2str(xs(end))])
    grid on;
end

% b)
figure(2)
as = [0.5, 1, 10];
xs = [];
f = @(x) x - (1 + (x^2) * atan(x));

for i=1:length(as)
    xs = [as(i)];
    for k=0:9
        xs = [xs f(xs(end))];
    end
    subplot(length(as), 1, i)
    plot(xs, 'b.-')
    title(['x_0 = ', num2str(as(i)), ',  x_{k+1} = x_k - (1 + x_k^2 * atan(x_k)), dlugosc ciagu numerycznego: ', num2str(length(xs)), ', ciag dazy do: ', num2str(xs(end))])
    grid on;
end

% lista 2 zadanie 9
x0s = [0.2 * pi, 1.2, 0]; 
x1s = [0.4 * pi, 1.4, 1];
for i = 1 : 3
    if i == 1
        f = @(x) sin(x/2) - 1;
        function_text = 'sin(x/2) - 1';
        axis_values = [0 4 -0.7 0.05];
    end
    if i == 2
        f = @(x) exp(x) - tan(x);
        function_text = 'exp(x) - tan(x)';
        axis_values = [1.1 1.7 -2 2];
    end
    if i == 3
        f = @(x) x.^3 - 12* x.^2 + 3*x + 1;
        function_text = 'x^3 - 12* x^2 + 3*x + 1';
        axis_values = [-0.5 1.5 -10 10];
    end
    figure(i+2)
    x0 = x0s(i);
    x1 = x1s(i);
    subplot(2,1,1)
    hold on
    plot(linspace(axis_values(1), axis_values(2)), f(linspace(axis_values(1), axis_values(2))))
    axis(axis_values)
    roots = [];
    while abs(f(x0)) > eps()
        roots = [roots x0];
        plot([x0, x1], [f(x0), f(x1)], 'r.-')
        x2 = x1 - (f(x1) * (x1 - x0))/(f(x1) - f(x0));
        x0 = x1;
        x1 = x2;
    end
    grid on
    title(['Funkcja ', function_text, ' i poszczegolne sieczne. Znalezione miejsce zerowe: ', num2str(x2)])
    subplot(2,1,2)
    real_roots = roots(end) * ones(1, length(roots));
    err =abs(real_roots - roots);
    r=polyfit(log(err(1:end-3)), log(err(2:end-2)),1);
    plot(log(err(1:end-2)), log(err(2:end-1)), 'r.')
    hold on
    x1 = log(err);
    y1 = polyval(r,x1);
    plot(x1, y1, 'b-')
    title(['Bledy w skali logarytmcznej. Wspolczynnik kierunkowy (jednoczesnie rzad zbieznosci): ', num2str(r(1))])
    grid on
end
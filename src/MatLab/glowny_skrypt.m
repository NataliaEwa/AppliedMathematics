lambdy = [0.7, 1, 1.3];
n = 1000;


for i=1:length(lambdy)
    lambda = lambdy(i)
    % metoda 1 (Generowanie przez funkcje odwrotna), s^(-1)(x) = x^2
    % gestosc teoretyczna: f(x) = lambda * (1/(2*sqrt(x))) * exp(-lambda*sqrt(x))
    metoda = 1
    tic;
    probki = metoda_1(lambdy(i), n);
    toc
    [~, x] = ksdensity(probka);
    dziedzina = linspace(0, max(x));
    teoretyczna = lambdy(i) * (1 ./ (2 .* sqrt(dziedzina))) .* exp(-lambdy(i) .* sqrt(dziedzina));
    figure
    grid on
    hold on
    box on
    [a, b] = hist(probka, 30);
    m = b(2) - b(1);
    bar(b, a / (m * n));
    plot(dziedzina, teoretyczna, 'r--', 'LineWidth', 2)
    title(['Generowanie przez funkcje odrotna, ', '\lambda = ', num2str(lambdy(i))])
    h = legend('histogram unormowany', 'gestosc teoretyczna $f(x) = \frac{\lambda}{2} x^{-\frac{1}{2}} e^{-\lambda x^{\frac{1}{2}}}$');
    set(h,'Interpreter','latex')
    legend('show')
    xlabel('x')
    ylabel('y')
    
    % metoda 2 (Generowanie przez funkcje intensywosci awarii), x = 2
    % gestosc teoretyczna: f(x) = lambda * (1 + exp(-x)) * exp(-lambda*(1+x-exp(-x)))
    metoda = 2
    tic;
    probka = metoda_2(lambdy(i), n);
    toc
    [~, x] = ksdensity(probka);
    dziedzina = linspace(0, max(x));
    teoretyczna = lambdy(i) .* (1 + exp(-dziedzina)) .* exp(-lambdy(i) * (1 + dziedzina - exp(-dziedzina)));
    figure
    grid on
    hold on
    box on
    [a, b] = hist(probka, 30);
    m = b(2) - b(1);
    bar(b, a / (m * n));
    plot(dziedzina, teoretyczna, 'r--', 'LineWidth', 2)
    title(['Generowanie przez funkcje intensywosci awarii, ', '\lambda = ', num2str(lambdy(i))])
    h = legend('histogram unormowany', 'gestosc teoretyczna $f(x) = \lambda (1 + e^{-x}) e^{-\lambda (1 + x - e^{-x}}$');
    set(h,'Interpreter','latex')
    legend('show')
    xlabel('x')
    ylabel('y')
    
    
    % metoda 3 (Generowanie przez rozwiazywanie rownan), x = 2
    % gestosc teoretyczna: f(x) = lambda * (1 + exp(-x)) * exp(-lambda*(1+x-exp(-x)))
    metoda = 3
    tic;
    probka = metoda_3(lambdy(i), n);
    toc
    [y, x] = ksdensity(probka);
    dziedzina = linspace(0, max(x));
    teoretyczna = lambdy(i) .* ((1 ./ (2 .* sqrt(dziedzina))) + exp(-dziedzina)) .* exp(-lambdy(i) * (1 + sqrt(dziedzina) - exp(-dziedzina)));
    figure
    grid on
    hold on
    box on
    [a, b] = hist(probka, 30);
    m = b(2) - b(1);
    bar(b, a / (m * n));
    plot(dziedzina, teoretyczna, 'r--', 'LineWidth', 2)
    title(['Generowanie przez rozwiazywanie rownan, ', '\lambda = ', num2str(lambdy(i))])
    h = legend('histogram unormowany', 'gestosc teoretyczna $f(x) = \lambda (\frac{1}{2} x^{-\frac{1}{2}} + e^{-x}) e^{-\lambda (1 + x^{\frac{1}{2}} - e^{-x})}$');
    set(h,'Interpreter','latex')
    legend('show')
    xlabel('x')
    ylabel('y')
    
end


lambda = 1;
t_1 = [];
t_2 = [];
t_3 = [];
x = [];
for i=1:100
    n = 10 * i;
    x = [x n];
    tic;
    metoda_1(lambda, n);
    t = toc;
    t_1 = [t_1 t];
    tic;
    metoda_2(lambda, n);
    t = toc;
    t_2 = [t_2 t];
    tic;
    metoda_3(lambda, n);
    t = toc;
    t_3 = [t_3 t];
end
figure
grid on
hold on
box on
plot(x, t_1, 'r', 'LineWidth', 2)
plot(x, t_2, 'g', 'LineWidth', 2)
plot(x, t_3, 'b', 'LineWidth', 2)
title(['Porownanie szybkosci metod symulacji w zaleznosci od dlugosci proby, ', '\lambda = 1'])
h = legend('Generowanie przez funkcje odrotna', 'Generowanie przez funkcje intensywosci awarii', 'Generowanie przez rozwiazywanie rownan');
set(h,'Interpreter','latex')
legend('show')
xlabel('dlugosc generowanej probki')
ylabel('czas [s]')





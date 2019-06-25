% zadanie 6 (poprawione)
figure(1)
n = 6;
a = 2;
b = 1;
% a)
t = linspace(0, 2*pi);
plot(a * cos(t), b * sin(t), 'k', 'LineWidth', 2)
hold on
% b)
wezly =  (2 * pi / n) * [0:n];
wartosci_p = a * cos(wezly);
wartosco_q = b * sin(wezly);
C_p = c(wezly,wartosci_p,n);
C_q = c(wezly,wartosco_q,n);

x = linspace(min(wezly), max(wezly));
[rzad, kolumna] = size(x);

y1 = [];    
    for i=1:rzad
        for j=1:kolumna
            qs = [];
            for k=0:n
                qs(k+1) = q(k, x(i,j), wezly);
            end
            y1(i,j) = sum(C_p.*qs);
        end
    end
P_x = y1;

y2 = [];
 for i=1:rzad
        for j=1:kolumna
            qs = [];
            for k=0:n
                qs(k+1) = q(k, x(i,j), wezly);
            end
            y2(i,j) = sum(C_q.*qs);
        end
    end
Q_x = y2;


plot(P_x, Q_x, 'r--','LineWidth', 2)
xlim([min(P_x) * 1.1, max(P_x) * 1.1])
ylim([min(Q_x) * 1.1, max(Q_x) * 1.1])
grid on

figure(2)
plot(wezly, wartosci_p, 'k.', wezly, wartosco_q, 'k.', x, P_x, 'r--', x, Q_x, 'g--')
grid on
clear all

% definiujemy wezly
wezly = [0, pi/6, pi/4, pi/3, pi/2];
% i ich wartosci
wartosci = sin(wezly);


%a) n = 2
figure(1)
hold off
% wyliczammy napisana funkcja interpolacje srdeniokwadratowa
[x, y] = polynomial_interpolate(wezly, wartosci, 0, pi/2, 2);
% i dla porwnania polyfitem
y1 = polyval(polyfit(wezly,wartosci,2),x);
% i rysujemy porownania
subplot(2,1,1)
hold on
grid on
plot(x, sin(x))
plot(wezly, wartosci, 'k*')
plot(x,y, 'r--')
legend('sin(x)', 'wezly', 'interpolacja sredniokwadratowa')
subplot(2,1,2)
hold on
grid on
plot(x, sin(x))
plot(wezly, wartosci, 'k*')
plot(x, y1, 'g--')
legend('sin(x)', 'wezly', 'polyfit')


% b) n = 4
figure(2)
hold off
% wyliczammy napisana funkcja interpolacje srdeniokwadratowa
[x, y] = polynomial_interpolate(wezly, wartosci, 0, pi/2, 4);
% i dla porwnania polyfitem
y1 = polyval(polyfit(wezly,wartosci,4),x);
% i rysujemy porownania
subplot(2,1,1)
hold on
grid on
plot(x, sin(x))
plot(wezly, wartosci, 'k*')
plot(x,y, 'r--')
legend('sin(x)', 'wezly', 'interpolacja sredniokwadratowa')
subplot(2,1,2)
hold on
grid on
plot(x, sin(x))
plot(wezly, wartosci, 'k*')
plot(x, y1, 'g--')
legend('sin(x)', 'wezly', 'polyfit')

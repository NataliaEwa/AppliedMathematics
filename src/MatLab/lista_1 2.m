hold on;
clear all;
format LONG e;

% lista 1 zad 1
% a)
i = 1;
while 1 + 2^(-i) ~= 1 
    i = i + 1;
end
eps = 2^(-(i-1));
mantysa_length = i-1;
fprintf('epsilon dla x=1: %5.20f; dlugosc matysy: %5.1f\n', eps, mantysa_length);
% b)
for i=0:5
    a = 2^i;
    while a + 2^(-i) ~= a 
        i = i + 1;
    end
    eps = 2^(-(i-1));
    fprintf('a = %5.1f; %1.20f\n', a, eps);
end


% lista 1 zad 2
x = linspace(0.999, 1.001);

subplot(3,1,1)
plot(x, (x - 1).^8)

y_2 = zeros(1, length(x));
for k=0:8
    y_2 = y_2 + (prod(1:8)/(prod(1:k)*prod(1:(8-k))) * ((-1)^k)  * x.^(8-k));
end

subplot(3,1,2)
plot(x, y_2)

w1 = zeros(1, length(x));
for k=0:4
    w1 = w1 + (prod(1:8)/(prod(1:(2*k))*prod(1:(8-(2*k)))) * x.^(8- (2*k)));
end

w2 = zeros(1, length(x));
for k=0:3
    w2 = w2 + (prod(1:8)/(prod(1:(2*k + 1))*prod(1:(8-(2*k + 1)))) * x.^(8- (2*k + 1)));
end

subplot(3,1,3)
plot(x, w1-w2)


% lista 1 zad 3
% korzystamy z sumy: e^a =  suma od k=0 do inf (a^k/k!)
e_matlab = exp(-20)
e_suma=0;
for k=0:100
    e_suma=e_suma+(-20)^k/prod(1:k);
end
e_suma
e_suma_2 = 0;
for k=0:100
    e_suma_2 = e_suma_2 + ((20)^k / prod(1:k));
end
e_suma_2 = 1/e_suma_2;
e_suma_2

% lista 1 zad 4
%a) 5x_[]


%lista 1 zad 5
for i=1:15
    f1 = sqrt(10^i) * (sqrt((10^i) + 1) - sqrt(10^i));
    f2 = sqrt(10^i) / (sqrt((10^i) + 1) + sqrt(10^i));
    fprintf('f1(x)=%5.20f; f2(x)=%5.20f\n', f1, f2)
end
fprintf('\n\n')
for i=1:15
    x = (1-(1/(10^i)))* pi;
    f1 = (1 - cos(x)) / (x^2);
    f2 = (sin(x))^2 / (x^2 * (1 + cos(x)));
    fprintf('f1(x)=%5.20f; f2(x)=%5.20f\n', f1, f2)
end
fprintf('\n\n')
for i=1:15
    x = 1/(10^i);
    f1 = (1 - cos(x)) / (x^2);
    f2 = (sin(x))^2 / (x^2 * (1 + cos(x)));
    fprintf('f1(x)=%5.20f; f2(x)=%5.20f\n', f1, f2)
end
fprintf('\n\n')
% zad 5.
forward = [];
i_n_forward = exp(-1) * (exp(1) - 1); 
for i=1:30
    forward = [forward i_n_forward];
    i_n_forward = 1 - (i * i_n_forward); 
end
forward = [forward i_n_forward];
forward'
backward = [];
i_n_backward = 0; 
for i=30:-1:0
    backward = [backward i_n_backward];
    i_n_backward = (1 - i_n_backward)/(i+1); 
end
backward = [backward i_n_backward];
backward'
exp(-1) * (exp(1) - 1)


% lista 1 zad 6
points_x = [];
points_y_1 = [];
points_y_2 = [];
x = 1;
fs_1 = [];
fs_2 = [];
for i=0:15
    h = 2^(-i);
    points_x = [points_x -log(h)]; 
    fs_1 = [fs_1 (exp(x+h) - exp(x))/h];
    points_y_1 = [points_y_1 -log(abs(exp(x) - (exp(x+h) - exp(x))/h))];
    fs_2 = [fs_2 (exp(x+h) - exp(x-h))/(2*h)];
    points_y_2 = [points_y_2 -log(abs(exp(x) - (exp(x+h) - exp(x-h))/(2*h)))];
end

subplot(2,1,1)
plot([0:15], fs_1, 'ro', [0:15], fs_2, 'g.')
subplot(2,1,2)
plot([0:15], abs(exp(x) - fs_1), 'ro', [0:15], abs(exp(1) - fs_2), 'g.')
figure
subplot(2,1,1)
length(points_x)
length(points_y_1)
plot(points_x, points_y_1, 'k.')
subplot(2,1,2)
plot(points_x, points_y_2, 'k.')
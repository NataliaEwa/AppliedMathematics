clear all
data_file = 'data.csv';
fid = fopen(data_file);
title_line = fgetl(fid);
labels = strsplit(title_line,';');
fclose(fid);
data = readtable(data_file, 'Delimiter', ';', 'ReadVariableNames',false, 'HeaderLines', 1);
dates_labels = data(:,1);
dates_labels = table2array(dates_labels);
dates_labels = dates_labels(1:floor(length(dates_labels)/5):length(dates_labels));
data = table2array(data(:, 2:end));
mleko = data(:,1);
mleko_label = labels(1,2);
ser = data(:,2);
ser_label = labels(1,3);
inflacja = cumprod(data(:,3)/100);


% figure
% plot(ser, 'k-', 'LineWidth', 2)
% set(gca,'XTick', linspace(1, length(ser), 5))
% set(gca,'XTickLabel', dates_labels)
% title(ser_label)
% xlabel('data')
% ylabel('cena')
% grid on
% box on
% figure
% plot(mleko, 'k-', 'LineWidth', 2)
% set(gca,'XTick', linspace(1, length(mleko), 5))
% set(gca,'XTickLabel', dates_labels)
% title(mleko_label)
% xlabel('data')
% ylabel('cena')
% grid on
% box on
% corr(ser, mleko)
% figure
% scatter(mleko, ser, 'r.')
% xlabel(mleko_label)
% ylabel(ser_label)
% grid on
% box on
% title('Zaleznosc cen produktow')

dane_sort = sortrows([mleko ser]);
x = dane_sort(:, 1);
y = dane_sort(:, 2);
x_test = x(1:50);
y_test = y(1:50);
b1 = sum(x_test.* (y_test - mean(y_test))) / sum((x_test - mean(x_test)) .^ 2);
b0 = mean(y_test) - b1 * mean(x_test);
% figure
% scatter(x_test, y_test, 'r.')
% hold on
% plot(sort(x_test), b1 * sort(x_test) + b0, 'k-', 'LineWidth', 2)
% xlabel(mleko_label)
% ylabel(ser_label)
% grid on
% box on
% title('Dopasowanie prostej regresji')

x_rest = x(51:end);
y_rest = y(51:end);
% figure
% hold on
% scatter(x_test, y_test, 'r.')
% scatter(x_rest, y_rest, 'go')
% plot(sort(x), b1 * sort(x) + b0, 'k-', 'LineWidth', 2)
% xlabel(mleko_label)
% ylabel(ser_label)
% grid on
% box on
% title('Dopasowanie prostej regresji i prognoza przyszlych wartosci na jej podstawie')

alpha = 0.05;
x_k = -5:0.01:5;
y_k = tpdf(x_k, length(x) -2);
one = -tinv(1 - (alpha/2), length(x) -2);
two = tinv(1 - (alpha/2), length(x) -2);
part_one_x = [];
part_one_y = [];
part_two_x = [];
part_two_y = [];
middle_x = [];
middle_y = [];
for i=1:length(y_k)
    if x_k(i)<=one
        part_one_x = [part_one_x x_k(i)];
        part_one_y = [part_one_y y_k(i)];
    end
    if x_k(i)>=two
        part_two_x = [part_two_x x_k(i)];
        part_two_y = [part_two_y y_k(i)];
    end
    if (x_k(i)>=one && x_k(i)<=two)
        middle_x = [middle_x x_k(i)];
        middle_y = [middle_y y_k(i)];
    end
end
middle_x = [part_one_x(end) middle_x part_two_x(1)];
middle_y = [part_one_y(end) middle_y part_two_y(1)];
% figure
% hold on
% grid on
% box on
% plot(middle_x, middle_y);
% area(part_one_x, part_one_y);
% area(part_two_x, part_two_y);
% title('Obszar krytyczny dla obu parametrów')
% xlabel('x')
% ylabel('f_x(x)')
% legend('f_x(x) - gestosc rozkladu t_{n-2}', 'obszar krytyczny (-\infty, -t_{1 - \alpha/2, n-2}) \cup (t_{1 - \alpha/2, n-2}, \infty)')

b1_new = sum(x.* (y - mean(y))) / sum((x - mean(x)) .^ 2)
b0_new = mean(y) - b1_new * mean(x)
se_b1 = sqrt((sqrt((1/(length(x)-2)) * sum((y - (b0_new + b1_new * x)).^2))) / sum((x-mean(x)).^2));
se_b0 = se_b1 * sqrt(sum(x.^2) / length(x));
t1 = (b1 - 3.8)/se_b1
t0 = (b0 - 1.6)/se_b0
p_1 = 2 * min(tpdf(t1, length(x) - 2), 1 - tpdf(t1, length(x) - 2))
p_0 = 2 * min(tpdf(t0, length(x) - 2), 1 - tpdf(t0, length(x) - 2))

alpha = 0.05;
sigma_nieznane = 0;
for i=1:length(x_rest)
    y_est = b0 + b1 * x_rest(i);
    se = sqrt(((1/(length(x_test)-2)) * sum((y_test - (b0 + b1 * x_test)).^2)) * (1 + (1/length(x_test)) + ((x_rest(i) - mean(x_test)).^2)/sum((x_test-mean(x_test)).^2)));
    sigma_nieznane_tail = tinv(1 - (alpha/2), length(x_test)-2) * se;
    if (y_est - sigma_nieznane_tail < y_rest(i)) && (y_rest(i) < y_est + sigma_nieznane_tail)
        sigma_nieznane = sigma_nieznane + 1;
    end
end
sigma_nieznane = sigma_nieznane/length(x_rest)

x_next = linspace(x(end), x(end) + (x(end) - x(end-5)), 5);
y_next = b0 + b1 * x_next;
% figure
% hold on
% scatter(x, y, 'b.')
% scatter(x_next, y_next, 'r.')
% xlabel(mleko_label)
% ylabel(ser_label)
% grid on
% box on
% title('Prognoza przyszlych wartosci na podstawie prostej regresji bez uwzglednienia bledow standardowych')

sigma = sqrt(((1/(length(x_test)-2)) * sum((y_test - (b0 + b1 * x_test)).^2)));
x_next = linspace(x(end), x(end) + (x(end) - x(end-5)), 5);
y_next = b0 + b1 * x_next + normrnd(0, sigma, 1, length(x_next));
% figure
% hold on
% scatter(x, y, 'b.')
% scatter(x_next, y_next, 'r.')
% xlabel(mleko_label)
% ylabel(ser_label)
% grid on
% box on
% title('Prognoza przyszlych wartosci na podstawie prostej regresji zakladajc bledy standardowe z rozkladem normalnym')

residua = y - b1_new * x - b0_new;
% figure
% grid on
% box on
% hold on
% plot(x, residua, 'b*')
% title('Wykres resiuum')
% xlabel(mleko_label)
% ylabel('roznica miedzy wartoscia rzeczywista a estymowana')

[res_y, res_x] = ecdf(residua);
% figure
% grid on
% box on
% hold on
% plot(res_x, res_y, 'k*')
% plot(res_x, normcdf(res_x, 0, sigma), 'r--', 'LineWidth', 2)
% xlabel('x')
% ylabel('F_x(x)')
% legend('empiryczna dystrybuanta residuum', 'dystrybuanta rozkladu normalnego N(0, s)')
% title('Porownanie rozkladu residuum z rozkladem normalnym')


[res_y, res_x] = ksdensity(residua);
% figure
% grid on
% box on
% hold on
% plot(res_x, res_y, 'k*')
% plot(res_x, normpdf(res_x, 0, sigma), 'r--', 'LineWidth', 2)
% xlabel('x')
% ylabel('f_x(x)')
% legend('gestosc residuum za pomoce ksdensity', 'gestosc rozkladu normalnego N(0, s)')
% title('Porownanie rozkladu residuum z rozkladem normalnym')

kstest2(normrnd(0, sigma, 1, length(residua)), residua)

b1s = [];
b0s = [];
x = 1:100;
for i=1:100
    y = b0_new + b1_new * x + normrnd(0, sigma, 1, 100);
    b1 = sum(x.* (y-mean(y)))/sum((x-mean(x)).^2);
    b1s = [b1s b1]; 
    b0 = mean(y) - b1 * mean(x);
    b0s = [b0s b0];
end


[b0_y, b0_x] = ecdf(b0s)
[b1_y, b1_x] = ecdf(b1s)
figure
grid on
box on
hold on
plot(b0_x, b0_y, 'k*')
plot(b0_x, normcdf(b0_x, b0_new, sigma * sqrt((mean(x)^2 / sum((x - mean(x)).^2)))), 'r--', 'LineWidth', 2)
xlabel('x')
ylabel('y')
title('Porownanie dystrybuanty empirycznej estymatorow b_0 z dystrybuanta rozkladu normalego')


figure
grid on
box on
hold on
plot(b1_x, b1_y, 'k*')
plot(b1_x, normcdf(b1_x, b1_new, sigma * sqrt(1 / sum((x - mean(x)).^2))), 'r--', 'LineWidth', 2)
xlabel('x')
ylabel('y')
title('Porownanie dystrybuanty empirycznej estymatorow b_1 z dystrybuanta rozkladu normalego')


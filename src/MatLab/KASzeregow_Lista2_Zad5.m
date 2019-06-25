clear all
data_file = 'mleko.csv';
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

dane_sort = sortrows([mleko ser]);
D= dane_sort;
X= D(1:70, 1); % Wszystkie wiersze; pierwsza kolumna
Y= D(1:70, 2); % Wszystkie wiersze; druga kolumna

[b, bint, r]= regress(Y, [ones(size(X)), X]);
ypred= b(1) +b(2).*D(71:82, 1); % Predykcja dla x(991:1000);

n=70;
figure;
plot(X,Y, '.');
% axis([0,8,0,35]);
hold on;
plot([min(X),max(X)], [b(1)+b(2).*min(X), b(1)+b(2).*max(X)])
plot(D(71:82, 1), ypred, 'o')

Mx= mean(X);
sigma1= std(r);
a= sigma1*sqrt(1+ 1./n+ (D(71:82, 1)-Mx).^2/ sum((X-Mx).^2)  );

GranicaG=  (b(1)+b(2).*D(71:82, 1)) +a*2; % Granica górna
GranicaD=  (b(1)+b(2).*D(71:82, 1)) -a*2; % Granica dolna
plot(D(71:82,1), GranicaG );
plot(D(71:82,1), GranicaD );

% Test
B= [2, 3, 1; 1, 2, 3];
BB= B';
sortrows(BB);


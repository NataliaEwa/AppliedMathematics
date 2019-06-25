
% Dane wejsciowe: 
% A
xi=[-4 -3.4 -2 0];
yi=[1.1 0 3 8];

xi1=[0 0.9 2 2.5];
yi1=[8 3 0 0.8];

xi2=[-2 0.9];
yi2=[3 3];

% przecinek
xi3=[3 3.2 3.1];
yi3=[-1 -0.5 0.1];

% B
xi4=[4 7 9 8.8 8];
yi4=[1 0 1.8 3.8 4.5];


xi5=[6 8 8.6 7 3.9];
yi5=[4.2 4.5 6.4 8 7];

xi6=[5 5.3 5];
yi6=[1 4 7];

% przecinek
xi7=[9.3 9.5 9.4];
yi7=[-1 -0.5 0.1];

%C
xi8=[17 14.8 11.4 11.6 14.7 16.8 16.6];
yi8=[1.5 0 2 6 8 7.2 6];

hold on;

krzywe(xi, yi)
krzywe(xi1, yi1)
krzywe(xi2, yi2)
krzywe(xi3, yi3)
krzywe(xi4, yi4)
krzywe(xi5, yi5)
krzywe(xi6, yi6)
krzywe(xi7, yi7)
krzywe(xi8, yi8)

function poly_coeffs=Zad4(limits,n)

% n=4;
h=2/n;

x_limits=[limits(1), limits(2)]; % zakres x
wezly=x_limits(1):h:x_limits(2); % wêz³y
f_x=1./(2+wezly.^2); % wartoœci w wez³ach

mat1=vander(wezly); % macierz Vandermonde'a

poly_coeffs=mat1\f_x'; % wspó³czynniki wielomianu poprzez dzielenie

% plotowanie
% mieliœmy dane wêz³y

x=limits(1):0.1:limits(2);
wartosci_wielomianu=polyval(poly_coeffs,x);

figure;

plot(wezly,f_x,'o'); hold on; plot(x,wartosci_wielomianu,'r');


%% wersja dla zer z wiel. czebyszewa
wezly2=cos((2*[1:n]-1)/(2*n)*pi);
wezly2_sort=sort(wezly2);

f_x2=1./(2+wezly2_sort.^2); % wartosci w wêz³ach
mat2=vander(wezly2_sort); % macierz Vandermonde'a

poly_coeffs2=mat2\f_x2'; % wspó³czynniki wielomianu poprzez dzielenie

x=limits(1):0.1:limits(2);
wartosci_wielomianu2=polyval(poly_coeffs2,x);

figure;

plot(wezly2_sort,f_x2,'o'); hold on; plot(x,wartosci_wielomianu2,'r');
title('Wielomiany Czebyszewa');

end
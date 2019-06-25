% definicja funkcji
f=@(x)(exp((x.^2) .* ((1-x).^2)));

% liczba podzialow
n = 100;
% dolna granica calkowania
a = 0;
% gorna granica calkowania
b = 1;

% calki nie da sie policzyc analitycznie, wyliczmy ja wiec metoda Simpsona
% wbudowana w matlabie
y1 = integral(f, a, b);

% i metoda trapezow
h = (b - a) / n;
x = [a + h : h : b - h];
y = f(x);
y =((f(a) + f(b)) / 2 + sum(y)) * h;

blad_numeryczny = abs(y-y1)

% korzystajac z metodu Eulera-Maclaurina blad mo¿na zapisac jako:

przyblizony_blad_metoda_maclaurina_eulera = h^4/720 * (24 * log(exp(1)))
% a rz¹d metody to 4
h_4 = h^4
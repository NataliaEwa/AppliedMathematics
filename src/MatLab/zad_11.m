k = 30;
m = 2*k;
a = 0;
b = 1;

% Metoda prostokątów
h = (b-a) / m;
%s = (exp(a)+exp(b)) / 2;
for i = 1:m
    s = s + exp(a + i*h);
end
s = s*h;
%printf("Metoda prostoatow z podzialem odcinka na d czesci: 5.10f \n",m,s);
err = abs(s-(exp(1)-1));
%printf("Blad metody: 0.10f\n\n",err);
% Metoda trapezow
h = (b-a) / m;
s = (exp(a)+exp(b)) / 2;
for i = 2:m-1
    s = s + exp(a + i*h);
end
s = s*h;
%printf("Metoda trapezow z podzialem odcinka na d czesci: 5.10f \n",m,s);
err = abs(s-(exp(1)-1));
%printf("Blad metody: 0.10f\n\n",err);
% Metoda parabol/Simpsona
h = (b-a) / m;
s = exp(a) + exp(b);
for i = 2:2:m-1
    s = s + 2*exp(a + i*h);
end
for i = 1:2:m
    s = s + 4*exp(a + i*h);
end
s = s * h / 3;
%printf("Metoda parabol z podzialem odcinka na d czesci: 5.10f \n",m,s);
err = abs(s-(exp(1)-1));
%printf("Blad metody: 0.10f\n\n",err);
a = 0;
b = 1;
I = exp(1)-1;
M = exp(1);
%printf('Metoda Trapezow');
for k = 2:1:1000
  m = 2*k;
  % Metoda trapezow
  h = (b-a) / m;
  s = (exp(a)+exp(b)) / 2;
  for i = 2:1:m-1
      s = s + exp(a + i*h);
  end
  s = s*h;
  abs_err = abs(s - I)/I;
  if (abs_err <= 5e-4)
    %printf('Minimalna liczba podzialow: d\n', k);
    %printf('Blad absolutny: 2.10f\n', abs_err);
    err_t = h^3 * (b-a) * M * m / 12;
    err_t = err_t / I;
    %printf('Blad absolutny teoretyczny: 2.10f\n\n', err_t);
    break;
  end
end

%printf('Metoda Simpsona');
for k = 3:1:10
  m = 2*k;
  h = (b-a) / m;
  s = exp(a) + exp(b);
  for i = 2:2:m-1
      s = s + 2*exp(a + i*h);
  end
  for i = 1:2:m
      s = s + 4*exp(a + i*h);
  end
  s = s * h / 3;
  v(k) = s;
  abs_err = abs(s - I)/I;
  
  if (abs_err <= 5e-4)
    %printf('Minimalna liczba podzilw: %d\n',k);
    %printf('Blad absolutny: %2.10f\n', abs_err);
    err_t = h^4*(b-a) * M / 180 ;
    err_t = err_t / I;
    %printf('Blad absolutny teoretyczny: %2.10f\n\n', err_t);
    
    break;
  end
  
end


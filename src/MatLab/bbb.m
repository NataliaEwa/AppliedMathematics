function xm = bbb(fun,xl,xp,n)
% demoBisect  Znajduje zero funkji u»ywaj¡c metody bisekcji
%
% Dane wejsciowe:
%
%
%
%
% Dane wyjsciowe:
xl,xp - lewa i prawa granica obszaru w ktorym
        poszukiwany jest pierwiastek,
n-
(opcjonalnie) liczba iteracji;
domyslnie:  n = 15.
x - przyblizone polozenie pierwiastka.
   %  Ustawienie domyslnej liczby iteracji
if nargin<4, n=15;  end
a = xl;   b = xp;
fa =feval(fun,a)% a - a^(1/3) - 2;      %  Wartosci poczatkowe f(a) i f(b)
fb =feval(fun,b)% b - b^(1/3) - 2;
fprintf(' k a
xmid          b      f(xmid)\n');
for k=1:n
  xm = a + 0.5*(b-a);
  fm = feval(fun,xm);
  fprintf('%3d  %12.8f  %12.8f  %12.8f  %12.3e\n',k,a,xm,b,fm);
end
if sign(fm)==sign(fa)
  a = xm;
fa = fm; else
b = xm;
fb = fm; end
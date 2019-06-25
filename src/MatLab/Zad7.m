function Zad7 %rozbi³am to zadanie na 2 pliki, aby unikn¹æ niepotrzebnego zamieszania w kodzie
a=0;
b=pi;

m=10;
h = (b - a)/m;
wynik=calka(h,a,b);
wynik2=calka(h/2,a,b);

wynik2=(1/3)*(4*wynik2-wynik);
disp('wartosc calki1')
disp(wynik)
disp('wartosc calki2')
disp(wynik2)
disp('blad1')
disp(abs(2-wynik))
disp('blad2')
disp(abs(2-wynik2))
end
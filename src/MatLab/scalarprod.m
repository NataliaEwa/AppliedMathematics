function [ iloczyn_skalarny ] = scalarprod( vec_x, vec_y )
%SCALARPROD Wynikiem dzialania jest iloczyn skalarny podanych wektorow
%   Funkcja pobiera 2 wektory.
%   Sprawdza czy argumenty sa wektorami. 
%   Sprawdza dlugosc argumentow.
%   Jesli sa to wektory tej samej dlugosci, zwraca ich iloczyn skalarny.
%   Jesli jest inaczej - podaje stosowny komunikat i zwraca -1.

    %sprawdzenie czy podano wektor
    czy_vec_x = isvector(vec_x);
    czy_vec_y = isvector(vec_y);

    %dlugosc wektorow
    dlugosc_vec_x = length(vec_x);
    dlugosc_vec_y = length(vec_y);

    %jesli oba sa wektorami o rownej dlugosci
    if (czy_vec_x && czy_vec_y) && (dlugosc_vec_x == dlugosc_vec_y)
        disp('Iloczyn skalarny wynosi: ');
        %obliczenie skalarnego iloczynu
        iloczyn_skalarny = dot(vec_x, vec_y);
        
        %zakonczenie dzialania funkcji
        return
        
    elseif (~czy_vec_x)
        disp('x nie jest wektorem');
        
    elseif (~czy_vec_y)
        disp('y nie jest wektorem');
        
    elseif (dlugosc_vec_x ~= dlugosc_vec_y)
        disp('Argumenty maja rozne dlugosci!');
        
    else
        disp('Blad.');
    end

    %zwraca wartosc -1 w razie bledu (nie dojdzie tu, jesli wszystko ok)
    disp('Nie wykonano obliczen. Zwrocona wartosc: -1');
    iloczyn_skalarny = -1;
   

end


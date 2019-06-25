function [ zwracam ] = fibonacci( n )
%FIBONACCI Podaje pierwsze n wyrazow ciagu Fibonacciego
%   dla zadanego n ? N zwraca pierwsze n wyrazów ci?gu
%   Fibbonaciego. Funkcja u?ywa funkcji fib1 oraz fib2, a u?ytkownik
%   ma kontrol?, która z funkcji ma by? u?ywana

  

    prompt = 'Ktora funkcje uzyc? \n 1 - fib1 \n 2 - fib2 \n';
    ktora = input(prompt);

    if ktora == 1
        %fib1
        for i = 1:n
            zwracam(i) = fib1(i);
        end
        
    elseif ktora == 2
        %fib2
        for i = 1:n
            zwracam(i) = fib2(i);
        end
        
    else
        %blad
        disp('Podano zla wartosc. Koniec programu.')
        zwracam = [];
        return
    end


end


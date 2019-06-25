function [ zwracam ] = fib1( n )
%FIB1 Zwraca n-ty wyraz ciagu Fibonacciego korzystajac ze wzoru Bineta
%   wzor Bineta:
%   (phi^n - (-phi)^(-n))/sqrt(5)
%   gdzie
%   phi = (sqrt(5) + 1) / 2
%   argumentem funkcji musi byc liczba naturalna

    %sprawdzenie czy n jest naturalne
    if (n == round(n)) && (n > 0)
        %jest
        disp('n to liczba naturalna');
    else
        %nie jest, koniec i zwrot pustej macierzy
        disp('Jako argument prosze podac liczbe naturalna!');
        zwracam = [];
        return
    end
    
    %ze wzoru
    phi = (sqrt(5) + 1) / 2;
    zwracam = (phi^n - (-phi)^(-n))/sqrt(5);


end


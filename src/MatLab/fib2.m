function [ zwracam ] = fib2( n )
%FIB2 Zwraca n-ty wyraz ciagu Fibonacciego (rekurencyjna metoda)
%   argumentem funkcji musi byc liczba naturalna wieksza od 0

    %sprawdzenie czy n jest naturalne
    if (n == round(n)) && (n > 0)
        %jest
        %disp('n to liczba naturalna');
    else
        %nie jest, koniec i zwrot pustej macierzy
        disp('Jako argument prosze podac liczbe naturalna!');
        zwracam = [];
        return
    end
    
    
    
    %tablica n zer
    ciag_fib = zeros(n,1);
    
    %ze wzoru
    ciag_fib(1) = 1;
    ciag_fib(2) = 1;
    
    for i = 3:n
       ciag_fib(i) = ciag_fib(i-1) + ciag_fib(i-2);
    end

    zwracam = ciag_fib(n);

end


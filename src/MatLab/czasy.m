function [] = czasy( n )
%CZASY Porownuje czas obliczenia pierwszych n wyrazow ciagu Fibonacciego
%   Niczego nie zwraca. Wypisuje czasy.
%   uzycie:
%   czasy(1000)

  %sprawdzenie czy n jest naturalne
    if (n == round(n)) && (n > 0)
        %jest
    else
        %nie jest, koniec i zwrot pustej macierzy
        disp('Jako argument prosze podac liczbe naturalna!');
        
        return
    end

    
    %pocz?tek mierzenia czasu
    tic;
    
    %fib1
    for i = 1:n
        element = fib1(i);
        %odkomentowanie == wyswietlanie kazdego elementu ciagu
        %disp(element);
    end

    czas1 = toc;
    disp('fib1:')
    disp(czas1)
    
    
    
    
    %drugie mierzenie czasu
    tic;
    
    %fib2
    for i = 1:n
        element = fib2(i);
        %odkomentowanie == wyswietlanie kazdego elementu ciagu
        %disp(element);
    end
      
    czas2 = toc;
    disp('fib2:')
    disp(czas2)


end


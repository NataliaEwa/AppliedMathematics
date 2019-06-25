function [ przyblizona_wartosc, blad_bezwzgledny ] = przybliz( )
%PRZYBLIZ Funkcja zwraca sume pierwszych n elementow szeregu Maclaurina
%   !  Funkcja nie posiada zaimplementowanych petli... !
%   1. Wybierana jest funkcja do przyblizenia: exp(x) lub sin(x)
%   2. Pobrana zostaje wartosc parametru x (np.: 0.1)
%   3. Pobrana zostaje zadana liczba elementow szeregu
%   4. Obliczone zostaje przyblizenie szeregiem Maclaurina
%   5. Wyswietlone zostaje przyblizenie i roznica od wartosci oczekiwanej

    %ustawienie wiekszej ilosci miejsc po przecinku
    format long
    
    %wybor przyblizanej funkcji
    prompt = 'Ktora funkcje przyblizyc? \n 1 - exp(x) \n 2 - sin(x) \n';
    ktora = input(prompt);

    %sprawdzenie czy podano dobra liczbe, jako opcje
    if ktora == 1
        disp('Wybrano exp(x)')
        
    elseif ktora == 2
        disp('Wybrano sin(x)')
        
    else
        %blad
        disp('Nie ma takiej opcji. Koniec programu.')
        przyblizona_wartosc = 0;
        blad_bezwzgledny = 0;
        return
    end

    %wybor parametru x
    prompt = 'Prosze podac wartosc parametru x: \n';
    x = input(prompt);
    
    %wczytanie n
    prompt = 'Prosze podac liczbe elementow szeregu n: \n';
    n = input(prompt);

    %tablica od 0 do n
    m = 0 : n;
    %disp(m)
    
    
    %w tej zmiennej bedzie dokladna wartosc funkcji exp(x) lub sin(x)
    obliczone_przez_matlaba = 0;

    %obliczenia
    if ktora == 1
        %obliczenia exp(x)
        obliczone_przez_matlaba = exp(x);
        disp('Dokladna wartosc exp(x):')
        disp(obliczone_przez_matlaba)
        
        %przyblizona wartosc szeregiem Maclaurina
        d = [1:1:(n+1)];
        
        
        % sekwencja, ze wzoru
        sekwencja = x.^m ./(factorial(m));
        
        % suma -> oszacowanie Maclaurina
        przyblizona_wartosc = sum(sekwencja);
        disp('Oszacowanie:');
        disp(przyblizona_wartosc);
        
        %roznica pomiedzy wartoscia oczekiwana, a policzona
        blad_bezwzgledny = abs(przyblizona_wartosc - obliczone_przez_matlaba);
        disp('Roznica w obliczeniach:');
        disp(blad_bezwzgledny);
        
        
    elseif ktora == 2
        %obliczenia sin(x)
        obliczone_przez_matlaba = sin(x);
        disp('Dokladna wartosc sin(x):')
        disp(obliczone_przez_matlaba)
        
        %przyblizona wartosc szeregiem Maclaurina
        
        
        % kolejne pochodne sinusa
        %d = [0 1 0 -1];
        d = ones(1, (n+1));
        [kolumny,wiersze] = meshgrid(1:size(d,1),1:size(d,2));
        %disp(wiersze)
        
        d(mod(wiersze,4)==1) = 0;
        d(mod(wiersze,4)==2) = 1;
        d(mod(wiersze,4)==3) = 0;
        d(mod(wiersze,4)==0) = -1;
        %disp('d:')
        %disp(d)
        
        % sekwencja, ze wzoru
        sekwencja = d .* x.^m ./(factorial(m));
        
        % suma -> oszacowanie Maclaurina
        przyblizona_wartosc = sum(sekwencja);
        disp('Oszacowanie:');
        disp(przyblizona_wartosc);
        
        %roznica pomiedzy wartoscia oczekiwana, a policzona
        blad_bezwzgledny = abs(przyblizona_wartosc - obliczone_przez_matlaba);
        disp('Roznica w obliczeniach:');
        disp(blad_bezwzgledny);
        
    end %koniec if










end


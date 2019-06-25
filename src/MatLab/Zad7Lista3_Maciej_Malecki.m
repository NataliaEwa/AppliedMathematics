% Maciej Ma�ecki
% Nr indeksu - 221695
% Kierunek - Matematyka stosowana
% Gr czwartowa godz 13:15 - 14:45
% Lista 3, Zadanie 7
% 
% Polecenie:
% Zad. 7. Wygladzanie konturu krzywej przy pomocy splajn�w 3 stopnia.
% Punkty P1(?1, ?1), P2(0, ?1), P3(1, ?1), P4(1, 0), P5(1, 1), P6(0, 1),
% P7(?1, 1), P8(?1, 0), P9(?1, ?1) le�� na obwodzie kwadratu 
% [?1, 1] �[?1, 1]. Niech t_k = k b�d� w�z�ami interpolacji, a (x_k, y_k)
% wsp�rz�dnymi punkt�w P_k dla k = 1, 2, . . . , 9.
% Wyznaczy� splajn interpolacyjny S(t) stopnia 3 dla (t_k, x_k), 
% k = 1, 2 . . . , 9 i taki sam splajn interpolacyjny Q(t) 
% dla punkt�w (t_k, y_k), k = 1, 2, . . . , 9. Sporz�dzi� wykres krzywej 
% (S(t), Q(t)), t \in [1, 9] i na tym samym rysunku umie�ci� punkty Pk.
% 
% 
% Dane wej�ciowe: 
xi=[-1 0 1 1 1 0 -1 -1 -1];
yi=[-1 -1 -1 0 1 1 1 0 -1];
tk=[1:9]; %w�z�y interpolacji

% Generowanie splainu interpolacujnego 3 stopnia dla danych S=(tk,xi) oraz
% Q=(tk,yi).
S=splain(tk,xi);
Q=splain(tk,yi);

% Rysowanie:
% -wykresu krzywej (S(t),Q(t)), dla t \in [1: 9]
hold on;
title('Splain Interpolacyjny 3 stopnia dla P(xi,yi)');
xlabel('xi');
ylabel('yi');
plot(S,Q,'k')
% -punkt�w Pk na czerwono
plot(xi,yi,'or');
% -bezpo�redniego po��czenia mi�dzy punktami na niebiesko
plot(xi,yi,'b');






% Maciej Ma³ecki
% Nr indeksu - 221695
% Kierunek - Matematyka stosowana
% Gr czwartowa godz 13:15 - 14:45
% Lista 3, Zadanie 7
% 
% Polecenie:
% Zad. 7. Wygladzanie konturu krzywej przy pomocy splajnów 3 stopnia.
% Punkty P1(?1, ?1), P2(0, ?1), P3(1, ?1), P4(1, 0), P5(1, 1), P6(0, 1),
% P7(?1, 1), P8(?1, 0), P9(?1, ?1) le¿¹ na obwodzie kwadratu 
% [?1, 1] ×[?1, 1]. Niech t_k = k bêd¹ wêz³ami interpolacji, a (x_k, y_k)
% wspó³rzêdnymi punktów P_k dla k = 1, 2, . . . , 9.
% Wyznaczyæ splajn interpolacyjny S(t) stopnia 3 dla (t_k, x_k), 
% k = 1, 2 . . . , 9 i taki sam splajn interpolacyjny Q(t) 
% dla punktów (t_k, y_k), k = 1, 2, . . . , 9. Sporz¹dziæ wykres krzywej 
% (S(t), Q(t)), t \in [1, 9] i na tym samym rysunku umieœciæ punkty Pk.
% 
% 
% Dane wejœciowe: 
xi=[-1 0 1 1 1 0 -1 -1 -1];
yi=[-1 -1 -1 0 1 1 1 0 -1];
tk=[1:9]; %wêz³y interpolacji

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
% -punktów Pk na czerwono
plot(xi,yi,'or');
% -bezpoœredniego po³¹czenia miêdzy punktami na niebiesko
plot(xi,yi,'b');






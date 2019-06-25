function krzywe(xi,yi)

% wyznaczanie dlugosci t
n=length(xi);
tk=[1:n];

% generowanie splainu interpolacujnego 3 stopnia dla danych
% S=(tk,xi) oraz Q=(tk,yi)
S=splain(tk,xi);
Q=splain(tk,yi);

% rysowanie wykresu krzywej (S(t),Q(t))
plot(S,Q, 'Color','b','Linewidth',2 )
plot(xi,yi,'or','Linewidth',2, 'MarkerSize',7);
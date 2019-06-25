function [s] = element_napr(lambda, mi, t)
i=1;
j=1;
czas = 0.0; % zmienna bie¿±cego czasu
stan= 0; % inicjalizacja stanu pocz±tkowego (element sprawny)
czasy_awarii=[];
czasy_napraw=[];
while czas < t
    if stan < 3
    s= stan; % stan aktualny
    czas1 = czas + exprnd(mi); % losowanie chwili zakoñczenia naprawy
    czas = czas + exprnd(lambda); % losowanie chwili uszkodzenia
        if czas<czas1
        stan = stan + 1; % zmiana stanu na 1 (element uszkodzony)
        czasy_awarii(i)=czas;
        i=i+1;
        else
            if stan>0
            stan = stan - 1;
            else
                stan=0;
            end
        czas=czas1;
        czasy_napraw(j)=czas;
        j=j+1;
        end
  plot(czas,stan,'pm') 
   title('Zmiany stanwów systemu','FontSize',25)
    xlabel('czas');
    ylabel('stany');
    hold on  
    else
    s=('System zawiód³');
    czas=t;    
    
    end
end
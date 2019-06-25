clear all
lata=[1999 2000 2001	2002	2003	2004	2005	2006	2007	2008	2009	2010	2011	2012	2013	2014];
powiat=[26970	28578	29007	30847	32300	35902	38945	43007	45095	52320	55182	58923	64103	67469	72590	77818];
miasto=[175980	187909	208970	220600	229987	239870	267990	277020	280456	292030	303761	314061	331292	341172	352848	365058];
powiatLudzie=[94233	94925	95492	96786	98032	99511	100866	103548	106080	108386	111069	118593	121651	124509	127896	130968];
miastoLudzie=[643522 640614	640804	639150	637548	636268	635932	634630	632930	632162	632146	630691	631235	631188	632067	634487];

predkosc=[55 53.5 51.5];
%max liczba ludzi w powiecie ->  2.849 * 10^5
%miejsce zerowe(przy takiej iloœci ludzi bêdzie zerowa prêdkoœæ) -> 2.2658 * 10^5
%przy takiej liczbie aut bêdzie zerowa prêdkoœæ --> 2.3023*10^5

%- - - - - - - - - - - - - - - - - -
%wykres zale¿noœci prêdkoœci od liczby ludzi w powiecie
%figure
x=[1.24*10^5:0.1:2.849*10^5];
% plot(powiatLudzie(14:16),predkosc,'k.','MarkerSize',15)
ludzieApredkosc=@(x)-0.0005402*x+122.4;
% grid on
% hold on
% plot(x,ludzieApredkosc(x),'LineWidth',1.4)
% xlabel('Liczba ludnoœci')
% ylabel('Œrednia prêdkoœæ [km/h]')
% title('Œrednia prêdkoœæ na wjazdach do Wroc³awia w latach 2012-2015')
% xlim([1.24*10^5 2.849*10^5])
%ylim([51.5 55.5])

%- - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%wykres zale¿noœci prêdkoœci od liczby aut
%figure
%x=[6.6*10^4:0.1:7.8*10^4];
x=[6.6*10^4:0.1:282540];
 plot(powiat(end-2:end),predkosc,'k.','MarkerSize',15)
 autaApredkosc=@(x)-0.0003384*x+77.91;
 hold on
 plot(x,autaApredkosc(x),'LineWidth',1.4)
grid on
title('Prognozowana œrednia prêkoœæ w zale¿noœci od iloœci aut w powiecie')
xlabel('Liczba samochodów')
ylabel('Prêdkoœæ')
legend('Dane','Prosta regresji')
ylim([0 60])
%- - - - - - -- - - - - - - - - - - - - - - - - - - - - 

%wykres zale¿noœci iloœci aut od liczby ludzi
%figure
% ludzieAsamochody=@(x)1.331*x-96660;
% %x=[0.9*10^5:0.1:1.4*10^5];
% x=[0.9*10^5:0.1:2.849*10^5];
% plot(powiatLudzie,powiat,'k.','MarkerSize',15)
% hold on
% grid on
% plot(x,ludzieAsamochody(x),'LineWidth',1.4)
% plot(2.849*10^5,ludzieAsamochody(2.849*10^5),'m*')
% legend('Dane','Prosta regresji','(2.859,2.8254)*10^5')
% xlabel('Liczba ludnoœci')
% ylabel('Liczba aut')
% title('Predykacja liczby samochodów w zale¿noœci od przewidywanej liczby ludnoœci w powiecie')
% xlim([0.8*10^5 3*10^5])

%maxIloscAut=ludzieAsamochody(x(end))
%maxPredkosc=autaApredkosc(maxIloscAut)









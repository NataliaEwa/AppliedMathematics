hold on
B=[];
ilosc_trajektorii=1000;
T=10000;
h=T/ilosc_trajektorii;
t=linspace(0,T,ilosc_trajektorii);
for i=1:10
    B=cumsum([normrnd(0,1,1,ilosc_trajektorii).*h^(1/2)]);
    plot(t, B)
end
log1 = sqrt(2*t.*log(abs(log(t))));
log2 = -sqrt(2*t.*log(abs(log(t))));




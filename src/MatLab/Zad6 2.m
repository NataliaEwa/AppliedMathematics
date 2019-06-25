function Zad6

n=4
syms x;
f= @(x) cos(x);

w=[0 pi/4 pi/2 pi/8 3*pi/8];
wartosci=f(w);

l=1;
for i=0:n
    for j=0:n
         if (i~=j)
            l=l*(x-w(j+1))/(w(i+1)-w(j+1));
        else
            l=l*1;
        end
    end
    L(i+1)=l;
    l=1;
end
L2=sum(L.*wartosci); 

figure(1)
ezplot(L2,[0 pi/2]); %wielomian interopolacyjny na niebiesko
hold on
t=0:0.01:pi/2;
plot(t,f(t),'r:','LineWidth',2) % wlasciwa funckja w matlabie

figure(2)
F=cos(x);
ezplot(abs(F-L2),[0 pi/2])
c=@(x) abs((1/120)*(w(1)-x)*(w(2)-x)*(w(3)-x)*(w(4)-x)*(w(5)-x));
title('B³¹d teoretyczny')%blad teoretyczny
hold on 
ezplot(c,[0 pi/2])

end


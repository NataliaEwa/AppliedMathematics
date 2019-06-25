a=-3;
b=3;
xs=linspace(a,b,1000);
y=abs(xs);
ys=0;

for n=10:5:25
    
    x=[];
    x(1)=-3;
    h=(b-a)/n;
    for i=1:n
        x(i+1)=x(1)+i*h;
    end
    N=length(x);
    L=ones(N,length(xs));

    for i=1:N
        for j=1:N
            if (i~=j)
                L(i,:)=L(i,:).*(xs-x(j))/(x(i)-x(j));
            end
        end
    end
    ys=0;
    for i=1:N
        ys=ys+abs(x(i))*L(i,:);
    end
    figure
    plot(xs,y,'LineWidth',2)
    hold on;
    plot(xs,ys,'r')
    str=sprintf('Ilosc wezlow = %d', n);
    title(str);
    ylim([0 3])
end
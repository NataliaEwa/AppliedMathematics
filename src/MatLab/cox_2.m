clear all
t=0;
i=0;
poisson_skoki=[];
while(t<10)
    t=t-log(unifrnd(0,1));
    if(t>=10)
        break 
    end
    i=i+1;
    poisson_skoki=[poisson_skoki t];
end
%figure
%
%stairs(poisson_skoki, 0:i-1);
%title('poisson skoki')

t=0;
j=0;
s=[];
i-1
while(t<i-1)
    t=t-log(unifrnd(0,1));
    if(t>=i-1)
        break
    end
    j=j+1;
    s=[s t];
end
%stairs(s, 0:i-1);


x=s(1):0.001:i-1;
poisson_ciagly=zeros(1,length(x));
value=0;
for i=1:length(s)
    poisson_ciagly=poisson_ciagly+(x>=s(i));
end
poisson_ciagly=poisson_ciagly-1;
%figure
%plot(x,poisson_ciagly,'r')
%title('poisson ciagly')


x_val=1;
N=[];
for k=1:length(poisson_skoki)
    skok = poisson_skoki(k);
    indeks = x_val;
    start_value=poisson_ciagly(x_val);
    while  x(x_val)<=k
        x_val=x_val+1;
        N=[N start_value];
        if x_val>=length(x)
            break;
        end
    end
end
N=[N poisson_ciagly(x_val:end)];
length(x);
length(N);
%figure
plot(x,N)
title('z³o¿enie')
hold on

t = linspace(0,10,1000);
plot(t, t, 'k')
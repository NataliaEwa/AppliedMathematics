hold off
clear all

t=0;
I=0;
T = 5;
lambda = T^2;
S = [];
t1 = linspace(0,T,1000);
plot(t1,(1/3)*t1.^3, 'b', 'LineWidth', 2)
hold on
plot(t1, t1.^2, 'g')

for i=1:10
    t=0;
I=0;
T = 5;
lambda = T^2;
S = [];
while 1
    u1 = rand();
    t = t - (1/lambda) * log(u1);
    if t>T
        break
    end
    u2 = rand();
    if (u2<=(t^2/lambda))
        I = I+1;
        S(I) = t;
    end
end
stairs([0 S], 0:I, 'r')
hold on
end

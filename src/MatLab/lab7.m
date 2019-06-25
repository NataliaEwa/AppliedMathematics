%proces poissona metoda 2
clear all;
I = 0;
t = 0;
T = 10;
n = 10;
lambda = 1/(t^2);

for i=1:100
I = 0;
t = 0;
T = 10;
n = 10;
while t<=T
      U1 = rand();
      (-t + sqrt(t^2 - log(1-U1)))
        t = t + (-t + sqrt(t^2 - log(1-U1)));
        I = I+1;
        S(I) = t;
    end
stairs([ 0 S],0:I, 'r');
hold on
end
t = linspace(0,T,1000)
plot(t, t.^2, 'b--')
hold on
plot(t, 2*t, 'g--')




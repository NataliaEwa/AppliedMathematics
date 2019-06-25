%proces poissona metoda 3
T = 20;
x = linspace(0,T,1000);
plot(x, 2 + 1./(x+1), 'g');
hold on
plot(x, 2*x + log(x+1), 'b', 'LineWidth', 2);
hold on

for j=1:10
n = poissrnd(2*T + 1*log(1+T));
if n>0
    m = 3*T/(2*T + 1*log(T+1));
    v = [];
    for i=1:n
        u1 = unifrnd(0,T);
        u2 = unifrnd(0, 1);
        %lambda = 2 + 1/(u1+1)
        %calka = 2*T + 1* log(1+T)
        while u2>((2 + 1/(u1+1))/(2*T +1* log(1+T)))*m/T;
            u1 = unifrnd(0,T);
            u2 = unifrnd(0, 1);
        end
        v = [v, u1];
    end
    S = sort(v);
    stairs(S, 0:length(S)-1, 'r');
    hold on;
end
end
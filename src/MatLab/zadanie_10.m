clear all;
a = 0;
b = 1;
y_0 = 0;
y_1 = 0;

q = @(x) x.^2 + 1;
r = @(x) -(pi^2 + x.^2 + 1) .* sin(pi * x);

Ns = [10, 100, 1000];

% a) metoda Gaussa
for i=1:length(Ns)
    N = Ns(i);
    h = (b-a)/(N+1);
    t = a:h:b;
    A_q = q(t(2:end-1)) * h^2 + 2;
    A = diag(A_q, 0) - diag(ones(N-1, 1), -1) - diag(ones(N-1, 1), 1);
    B = -h^2 * r(t(2:end-1));

    w = A\B';
    w=[y_0;w;y_1];

    figure(i)
    subplot(2,1,1)
    plot(t, w', 'r.')
    hold on 
    plot(t, sin(pi * t))
    title(['metoda Gaussa n=', num2str(N)])
    subplot(2,1,2)
    plot(t, abs(sin(pi * t) - w'))
    hold on
    plot(t, ones(1, length(t)) .* (((h^2) * (pi^4)) / 12), 'r')
    title('Bledy')
end


% b) metoda przeganiania (Thomasa)
for i=1:length(Ns)
    N = Ns(i);
    h = (b-a)/(N+1);
    t = a:h:b;
    A_q = q(t(2:end-1)) * h^2 + 2;
    A = diag(A_q, 0) - diag(ones(N-1, 1), -1) - diag(ones(N-1, 1), 1);
    B = -h^2 * r(t(2:end-1));
    
    beta = [1/A_q(1)];
    lambda = [B(1)/A_q(1)];
    for j=2:length(A_q)
        beta(j) = 1/(A_q(j) - beta(j-1));
        lambda(j) = (B(j) + lambda(j-1))/(A_q(j) - beta(j-1));
    end
    
    w = [lambda(end)];
    for j=1:length(A_q) -1
        new_w = beta(end-j) * w(1) + lambda(end-j);
        w = [new_w w];
    end
    
    w = [y_0 w y_1];

    figure(i + length(Ns))
    subplot(2,1,1)
    plot(t, w, 'r.')
    hold on 
    plot(t, sin(pi * t))
    title(['Metoda przeganiania n=', num2str(N)])
    subplot(2,1,2)
    plot(t, abs(sin(pi * t) - w))
    hold on
    plot(t, ones(1, length(t)) .* (((h^2) * (pi^4)) / 12), 'r')
    title('Bledy')
end

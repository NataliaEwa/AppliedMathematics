hold on
B=[];
T=10;
n=1000; % grid points
H = 0.5; %Hurst parameter
r=nan(n+1,1); 
t=linspace(0,T,n+1);
r(1) = 1;
for k=1:n
r(k+1) = 0.5*((k+1)^(2*H) - 2*k^(2*H) + (k-1)^(2*H));
end
r=[r; r(end-1:-1:2)]; % first rwo of circulant matrix
lambda=real(fft(r))/(2*n); % eigenvalues
for m=1:n
    W=fft(sqrt(lambda).*complex(randn(2*n,1),randn(2*n,1)));
    W = (n/T)^(-H)*cumsum(real(W(1:n+1))); % rescale
    W=W';
    B=[B; W];
    if m<6
        
        plot(t,W)
        hold on
    end
end
xlabel('t','FontSize',16) 
ylabel('W(t)','FontSize',16,'Rotation',0)
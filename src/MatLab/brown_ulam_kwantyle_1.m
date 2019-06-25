values = [0.7];
q1s = [0.1]
colors = ['c','b','m'];
ilosc = 1;
for z=1:length(q1s)
    figure
    for i=1:length(values)
        H = values(i);
        B=[];
        T=10;
        n=1000; % grid points
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
            length(W);
            length([0, W(:,end-1)]);
            temp = W;
            temp(end)=[];
            W = W - [0, temp];
            if m<2
                plot(t,W, 'g')
            end
            B=[B; W];
            ilosc = ilosc + 1;
        end

        q1=[];
        q2=[];
        for u=1:ilosc
            q1=[q1 quantile(B(:,u),q1s(z))];
            q2=[q2 quantile(B(:,u),1 - q1s(z))];
        end

        %hold on
        length(t);
        length(q1);
        colors
        plot(t,q1,colors(i))
        plot(t,q2,colors(i+2))
    end
end
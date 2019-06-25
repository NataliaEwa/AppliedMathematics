function C_p=c(wezly,wartosci_p,n)
    A = zeros(n+1,n+1);
    for i=1:(n+1)
        for j=1:i
            A(i,j) = q(j-1, wezly(i), wezly);
        end
    end
    C_p = (inv(A)*transpose(wartosci_p))';
end
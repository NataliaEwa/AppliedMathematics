function y=q(k, x, wezly)
    if k == 0
        y = 1;
    else
        y = prod(repmat(x(i,j), 1, k) - wezly(1:k));
    end
end
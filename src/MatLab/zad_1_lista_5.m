% y' = y, y(0) = 1, t in [0,2]
% a)
hs = [0.5, 0.2, 0.05, 0.01];
for i=1:length(hs)
    h = hs(i);
    y = [1];
    
    for j=2:ceil(2/h) + 1
        y(j) = y(j-1) + h * y(j-1);
    end
    figure(i)
    length([0:h:2])
    length(y)
    plot([0:h:2], y)
    hold on
    plot([0:h:2], exp([0:h:2]), 'r--')
    rzad = max(abs(y - exp([0:h:2])))
end
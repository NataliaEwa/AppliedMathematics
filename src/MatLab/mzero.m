function x0 = bb(a,b) 
    x = linspace(a,b,100); 
    y = zeros(1,100); 
    for i=1:100 
        y(i) = f1(x(i)); 
    end 
    x0 = 0/0; 
    for i=1:10 
        if(f1(a)/f1(b) > 0) 
            disp('ERROR'); 
            break; 
        end 
        x0 = a + (b-a)/2; 
        if(f1(a)/f1(x0) < 0) 
            b = x0; 
        else 
            a = x0; 
        end 
    end 
    figure; 
    hold on; 
    plot(x, y) 
    plot(x0, f1(x0), 'o') 
    grid 
end
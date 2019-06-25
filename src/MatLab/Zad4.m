function Zad4
% funkcja: 2*x^4+24*x^3+61*x^2-16*x+1=0
% pochodna: 8*x^3+72*x^2+122*x-16=0
% x(n+1)=x(n)-(2x^4+23x^3+62x^2-16x+1)/(8x^3+69x^2+124x-16)

x=0.2;                                        
nmax=100;                                      
eps=1;                                        
xvals=x;                                      
n=0;                                         

while eps>=1e-6                    
    y=x-(2*x^4+24*x^3+61*x^2-16*x+1)/(8*x^3+72*x^2+122*x-16);
    xvals=[xvals;y];                         
    eps=abs(y-x);                            
    x=y;n=n+1;                              
end                                         

xvals
x

end
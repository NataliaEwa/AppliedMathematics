function dxdy=rownania(x,y)
dxdy=[-(-sin(pi.*x).*pi^2+(x+2).*(x-sin(x*pi))-(x+2).*y(2));y(1)];
end
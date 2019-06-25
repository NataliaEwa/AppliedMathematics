function y=calka(h,a,b)

m=(b-a)/h;
y = (sin(a) + sin(b))/2;

for i = 1 : m-1
y = y + sin(a+i*h);
end

y = h*y;
end
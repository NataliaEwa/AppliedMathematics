a = 10; 
x(1) = a;
for k = 1:100
   x(k+1) = x(k)-(1+(x(k))^2)*atan(x(k))
   hold on
   %plot(x(k),x(k+1),'.')
end
plot(x,'*')
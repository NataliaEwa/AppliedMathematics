t=0;
x=1;
y=0;
dt=0.01;
for i=1:1:1000
t=t+dt;
x=x+dt.*y;
y=y+dt.*(-2.*y./t-x.*x.*x);
#plot(x,y)
printf("%f %f %f\n",t,x,y)
endfor
#A<-{-1,0,1};
b<-1;
c<-1;
n<-1;
r=1;
s=-1;
V=dnorm(1);
X=dnorm(V,1);
if (V==0){
  #R(V, d) = 
    c*(1-pnorm(n^(1/2)*(r-V))) + b*(1-pnorm(n^(1/2)*(s-V)))
}
if (V>0){
 # R(V,d) = 
    b*(1-pnorm(n^(1/2)*s)) + b*(1-pnorm(n^(1/2)*r))
}
if (V<0){
 # R(V, d) = 
  c*(pnorm(n^(1/2)*(r-V))) + b*(pnorm(n^(1/2)*(s-V)))
}
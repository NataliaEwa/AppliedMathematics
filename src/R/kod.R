# zad 4
N <- 100000
m <- double(N)
system.time({
  for(i in 1:N){
    x <- rnorm(25, m=3000, s=1e3)
    m[i] <- mean(x)
  }
  sum(m>2800)/N})

system.time({
  x <- rnorm(25*N, m=3000, s=1e3)
  X <- matrix(x, ncol=25)
  m <- apply(X, 1, mean)
  sum(m>2800)/N})

# teoria:
1-pnorm(-1)


# zad 5
N <- 10000 
n <- c(1,2,5,10,30,100)
m <- matrix(0,N,length(n))
par(mfrow=c(3,2))
for(i in seq_along(n)){ # 1:length(n)
  x <- rexp(n[i]*N)
  X <- matrix(x, ncol=n[i])
  m[,i] <- apply(X, 1, mean)
  hist(m[,i])
}

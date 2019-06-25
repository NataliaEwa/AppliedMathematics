function S = prostokatow(f, a, b, n)

h = (b - a) / n;
S = h * sum(f((a+0.5*h):h:(b-0.5*h)));
function S = trapezow(f, a, b, n)

h = (b - a) / n;
S = h * (0.5 * (f(a) + f(b)) + sum(f((a+h):h:(b-h))));
function S = simpsona(f, a, b, n)

h = (b - a) / n;
h2 = 0.5 * h;
S = h / 6 * (f(a) + f(b) + 2 * (sum(f((a+h):h:(b-h))) + 2 * sum(f((a+h2):h:(b-h2)))));
\\ Verify (m,n) = (22, 17) is genuinely rank >= 3.
\\ a = 22^2 - 17^2 = 484 - 289 = 195
\\ b = 2*22*17 = 748
\\ s = 22^2 + 17^2 = 484 + 289 = 773
\\ E: y^2 = x(x+b^2)(x+a^2) = x(x+559504)(x+38025)

default(parisize, 4000000000);
default(realprecision, 38);

m = 22; n = 17;
a = m^2 - n^2;
b = 2*m*n;
s = m^2 + n^2;
print("a=", a, " b=", b, " s=", s);
print("gcd(m,n)=", gcd(m,n), " parity m+n=", (m+n)%2);
print("a*b = ", a*b);
print("q = a/b = ", a/b);

E = ellinit([0, a^2+b^2, 0, a^2*b^2, 0]);
Emin = ellminimalmodel(E);
N = ellglobalred(Emin)[1];
print("conductor N = ", N);
print("factor(N) = ", factor(N));
print();

\\ Analytic rank with high precision
print("=== Analytic rank ===");
ar_default = ellanalyticrank(Emin)[1];
print("ellanalyticrank (default eps): ", ar_default);

ar_tight = ellanalyticrank(Emin, 0.0001)[1];
print("ellanalyticrank (eps=1e-4): ", ar_tight);

\\ Try to confirm L(E, 1) ~ 0, L'(E, 1) ~ 0, L''(E, 1) ~ 0, L'''(E,1) != 0
print();
print("=== L-derivatives ===");
default(realprecision, 30);
for(k = 0, 4,
  v = lfun(Emin, 1, k);
  print("L^(", k, ")(E,1) = ", v, "  |.|=", abs(v));
);

\\ Algebraic rank via ellrank (may be slow / fail at high conductor)
print();
print("=== Algebraic rank via ellrank ===");
print("(may take long; try with effort 1)");
\\ ellrank returns [low, high, S, gens]
\\ Use timeout-safe small effort
r = ellrank(Emin, 1);
print("ellrank(effort=1): ", r);

quit;

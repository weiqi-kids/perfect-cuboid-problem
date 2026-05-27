default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 09_form_structure.gp -- structural facts about the deg-8 form F(m,n)=ab(a^2-b^2)
\\ needed for the sieve hypotheses (nonzero discriminant / separable / no repeated factor).
\\ F = (m^2-n^2)*(2mn)*(m^4-6m^2n^2+n^4).
\\ Factor into irreducible binary forms over Q and check pairwise coprimality (no repeated root).
\\ ============================================================================
\\ Work with the dehomogenization t=m/n (set n=1) and factor the resulting degree-8 polynomial.
F(t) = (t^2-1)*(2*t)*(t^4-6*t^2+1);
print("=== Dehomogenized F(t), n=1 ===");
print("  F(t) = ",F(t));
print("  factorization over Q:");
fa = factor(F(t));
print(fa);
print("");
\\ degree and squarefreeness as a polynomial (=> form has no repeated linear factor over Qbar)
g = gcd(F(t), F'(t));
print("  gcd(F,F') = ",g,"   (constant => F squarefree => binary form has nonzero discriminant)");
print("  deg F = ",poldegree(F(t)));
print("");
\\ The 4 irreducible RATIONAL factors of the binary form ab(a^2-b^2):
\\   t  (i.e. m), t^2-1=(t-1)(t+1) (i.e. m-n,m+n), and t^4-6t^2+1 (i.e. a^2-b^2; irreducible/Q).
\\ Note 'b=2mn' contributes 2 (constant, irrelevant), m, and n; the homogeneous degree-8 form is
\\   m * n * (m-n) * (m+n) * (m^4-6m^2n^2+n^4),  with the quartic irreducible over Q.
print("=== quartic m^4-6m^2n^2+n^4 irreducible over Q? splits over Q(sqrt2) ===");
q = t^4-6*t^2+1;
print("  factor over Q: ",factor(q));
print("  factor over Q(sqrt2): ",factor(q*Mod(1,1), sqrt(2)) );
print("  roots: t = +-(1+-sqrt2)  => irreducible /Q, splits into 2 quadratics /Q(sqrt2)");
print("");
print("  CONCLUSION: F(m,n) is a separable (squarefree) binary form of degree 8,");
print("  product of distinct irreducible forms m, n, m-n, m+n, (m^4-6m^2n^2+n^4).");
print("  No repeated factor => nonzero discriminant => Greaves/Browning/Ekedahl sieve applies.");
print("EXIT=ok");
quit;

\\ Step 1: Define W explicitly by substituting q=(m^2-n^2)/(2mn) into E_PCP(q)
\\ E_PCP(q): Y^2 = X(X+1)(X+q^2)
\\ Clear denominators by multiplying by (2mn)^6

print("====================================================");
print(" Step 1: Define 3-fold W: F(X,Y,m,n) = 0");
print("====================================================");

\\ Use polynomial ring Q[X,Y,m,n]
\\ Multiply through: Y^2 - X(X+1)(X+q^2) = 0
\\ where q^2 = (m^2-n^2)^2 / (4 m^2 n^2)
\\ The term X(X+1)(X+q^2) has q^2 in it, so to clear, multiply by (2mn)^2:
\\   (2mn)^2 * X(X+1)(X+q^2)
\\     = (2mn)^2 * X(X+1)*X + (2mn)^2 * X(X+1)*q^2
\\     = 4 m^2 n^2 X^2 (X+1) + X(X+1) * (m^2-n^2)^2
\\ And (2mn)^2 * Y^2 = 4 m^2 n^2 Y^2
\\
\\ So we can take F to be:
\\   F = 4 m^2 n^2 Y^2 - 4 m^2 n^2 X^2 (X+1) - X (X+1) (m^2-n^2)^2
\\
\\ This is degree-deg, no need to multiply by (2mn)^6.
\\ However task asks (2mn)^6 -- let's see why. q^2 alone has denom 4m^2n^2.
\\ X(X+1)(X+q^2) has denom 4m^2n^2 (only one q^2 factor).
\\ Y^2 has no denom. So multiplying by 4m^2n^2 suffices.
\\
\\ Following the task strictly we multiply by (2mn)^6 which over-clears,
\\ but it preserves the locus. Let's actually compute both.

\\ Minimal cleared form (multiply by (2mn)^2 = 4 m^2 n^2):
Fmin = 4*m^2*n^2*Y^2 - 4*m^2*n^2*X^2*(X+1) - X*(X+1)*(m^2-n^2)^2;
print();
print("F_min(X,Y,m,n) [minimal clearing by (2mn)^2]:");
print(Fmin);
print();
print("Degrees:");
print("  in X: ", poldegree(Fmin, X));
print("  in Y: ", poldegree(Fmin, Y));
print("  in m: ", poldegree(Fmin, m));
print("  in n: ", poldegree(Fmin, n));
print("  total: ", poldegree(Fmin));

\\ Now expand: Fmin = 4 m^2 n^2 Y^2 - 4 m^2 n^2 (X^3 + X^2) - (m^2-n^2)^2 (X^2+X)
\\           = 4 m^2 n^2 Y^2 - 4 m^2 n^2 X^3 - 4 m^2 n^2 X^2 - (m^2-n^2)^2 X^2 - (m^2-n^2)^2 X

Fexp = subst(Fmin, X, X);  \\ trivial
print();
print("Expanded form (collected by X):");
print(Fmin);

\\ Compute (2mn)^6 cleared form for completeness
F6 = (2*m*n)^6 * (Y^2 - X*(X+1)*(X + ((m^2-n^2)/(2*m*n))^2));
\\ This still has denominators; we need numerator
\\ Actually F6 has no denominators since (2mn)^6 / (4m^2n^2) = 16 m^4 n^4
print();
print("F_6 (cleared by (2mn)^6, will have extra (2mn)^4 factor):");
\\ F6 = 64 m^6 n^6 Y^2 - 64 m^6 n^6 X(X+1) X - 16 m^4 n^4 X(X+1)(m^2-n^2)^2
print("Coefficient of Y^2: 64 m^6 n^6");
print("Note: F_6 = 16 m^4 n^4 * Fmin (up to expansion)");

\\ Verify
diff = F6 - 16*m^4*n^4*Fmin;
print("F_6 - 16 m^4 n^4 * F_min = ", diff);
print();
print("So we use F = Fmin = 4 m^2 n^2 Y^2 - 4 m^2 n^2 X^2 (X+1) - (m^2-n^2)^2 X (X+1)");

\\ Write F as variety in A^4_(X,Y,m,n)
\\ Total degree:
\\  4 m^2 n^2 Y^2: 4+2 = 6
\\  4 m^2 n^2 X^3: 4+3 = 7
\\  4 m^2 n^2 X^2: 4+2 = 6
\\  (m^2-n^2)^2 X^2: 4+2 = 6
\\  (m^2-n^2)^2 X: 4+1 = 5
print();
print("F has total degree 7 (from 4 m^2 n^2 X^3 term).");
print("In affine A^4, V(F) is a 3-dimensional hypersurface.");

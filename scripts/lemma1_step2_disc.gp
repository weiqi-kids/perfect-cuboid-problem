\\ G1(qZ) = 0  =>  q^4 (Z^4 - 4Z^3 - 2Z^2 - 4Z + 1) - 4 Z^2 q^3 (q^2 + 1) = 0
\\ Divide by q^3 (q != 0 since q = 0 excluded):
\\ q (Z^4 - 4Z^3 - 2Z^2 - 4Z + 1) - 4 Z^2 (q^2 + 1) = 0
\\ -4 Z^2 q^2 + q (Z^4 - 4Z^3 - 2Z^2 - 4Z + 1) - 4 Z^2 = 0
\\ Multiply by -1:
\\ 4 Z^2 q^2 - q (Z^4 - 4Z^3 - 2Z^2 - 4Z + 1) + 4 Z^2 = 0
\\
\\ Quadratic in q. Discriminant must be a square:
\\ Delta(Z) = (Z^4 - 4Z^3 - 2Z^2 - 4Z + 1)^2 - 64 Z^4

R = Z^4 - 4*Z^3 - 2*Z^2 - 4*Z + 1;
Delta = R^2 - 64*Z^4;
print("Delta(Z) = ", Delta);
print("");
print("factor over Q[Z]:");
print(factor(Delta));

\\ Alternative: think of it as: for rational X = qZ with G1=0, we need q rational, which
\\ requires Delta(Z) to be a rational square.
\\
\\ So: rational solution (q, X=qZ) of G1 = 0 <=> Z in Q with Delta(Z) in Q^2.

\\ Let's also do same for G2 (sign of q flips):
\\ G2 has q -> -q symmetry vs G1: G2(X, q) = G1(-X, -q)? Let me check.
G1q = X^4 - 4*q*X^3 - (4*q^3 + 2*q^2 + 4*q)*X^2 - 4*q^3*X + q^4;
G2q = X^4 + 4*q*X^3 + (4*q^3 - 2*q^2 + 4*q)*X^2 + 4*q^3*X + q^4;
print("");
print("G1(X, -q) = ", subst(G1q, q, -q));
print("G2(X,  q) = ", G2q);
\\ G1(X, -q) and G2(X, q): related?
print("G1(X, -q) - G2(X, q) = ", subst(G1q, q, -q) - G2q);

\\ G1(X, -q) = X^4 + 4*q*X^3 + (4q^3 - 2q^2 + 4q)X^2 + 4q^3 X + q^4
\\           = G2(X, q). So G2(X, q) = G1(X, -q).

quit;

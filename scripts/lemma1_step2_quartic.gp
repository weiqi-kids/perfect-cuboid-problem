\\ Lemma 1, Step 2 (Maximality of torsion): derive the quartic G1(X, q) characterizing
\\ rational 8-torsion candidates on E_PCP(q): Y^2 = X(X+1)(X+q^2).
\\
\\ A rational point P of order 8 has 2P = order-4 point, so X(2P) in {+q, -q}.
\\ By the duplication formula on Y^2 = X^3 + a2 X^2 + a4 X + a6 (a2 = 1+q^2, a4 = q^2, a6 = 0):
\\   X(2P) = (3X^2 + 2 a2 X + a4)^2 / (4 Y^2) - a2 - 2X
\\
\\ Setting X(2P) = q produces:
\\   G1(X, q) := X^4 - 4q X^3 - (4q^3 + 2q^2 + 4q) X^2 - 4q^3 X + q^4 = 0
\\ Setting X(2P) = -q produces G2(X, q) = G1(X, -q) = 0.

a2 = 1 + q^2; a4 = q^2;
fX  = X^3 + a2*X^2 + a4*X;            \\ = X(X+1)(X+q^2) since a6 = 0
fpX = 3*X^2 + 2*a2*X + a4;             \\ derivative
\\ X(2P) - q = 0  <=>  (fpX^2 - (a2 + 2X + q) * 4 * fX) = 0
G1 = fpX^2 - 4*fX*(a2 + 2*X + q);
G2 = fpX^2 - 4*fX*(a2 + 2*X - q);
print("G1(X, q) = ", G1);
print("G2(X, q) = ", G2);
print("G2(X, q) - G1(X, -q) = ", G2 - subst(G1, q, -q), " (should be 0)");
print("");
print("factor(G1) over Q[q, X]: ", factor(G1));
print("factor(G2) over Q[q, X]: ", factor(G2));
print("");
print("Both irreducible in Q[q, X] => irreducible in Q(q)[X] by Gauss.");
quit;

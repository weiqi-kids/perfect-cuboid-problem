/* Step 7: Use the 2-descent class [19, 1, 19] to derive global constraints.
 *
 * Selmer class for the rank-1 generator G:  (d1, d2, d3) = (19, 1, 19).
 * (From selmer_63_38.txt; per HERON-FACE-SELMER §3 cross-pair, d1=19 is "generator A" — the MW-supported class.)
 *
 * G = (x, y) with:
 *    x + X1 X2 = 19 u^2
 *    x + X1 X3 = 1 v^2 = v^2
 *    x + X2 X3 = 19 w^2
 * for some u, v, w ∈ Q.
 *
 * Hence (x + X1 X2) - (x + X1 X3) = X1(X2 - X3) = 19 u^2 - v^2.
 *       (x + X2 X3) - (x + X1 X3) = X3(X2 - X1) = 19 w^2 - v^2.
 *       (x + X1 X2) - (x + X2 X3) = X2(X1 - X3) = 19 u^2 - 19 w^2 = 19(u^2 - w^2).
 *
 * So we need rational solutions to:
 *   19 u^2 - v^2 = X1 (X2 - X3)
 *   19 w^2 - v^2 = X3 (X2 - X1)
 *   u^2 - w^2 = X2 (X1 - X3) / 19    (which must be an integer if u, w integers — check 19 | X2(X1-X3))
 */

m = 63; n = 38;
a = m^2 - n^2;   X2 = a^2;
b = 2*m*n;       X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;

c12 = X1 * (X2 - X3);   \\ for 19 u^2 - v^2 = c12
c32 = X3 * (X2 - X1);   \\ for 19 w^2 - v^2 = c32
c13 = X2 * (X1 - X3);   \\ for 19 u^2 - 19 w^2 = c13   i.e. u^2 - w^2 = c13/19
print("c12 = X1(X2-X3) = ", c12, "   factor: ", factor(abs(c12)));
print("c32 = X3(X2-X1) = ", c32, "   factor: ", factor(abs(c32)));
print("c13 = X2(X1-X3) = ", c13, "   factor: ", factor(abs(c13)));
print("c13 / 19 = ", c13/19, "  (must be integer for valid 19-descent)");
print("c13 mod 19 = ", c13 % 19);

\\ Check the conic 19 u^2 - v^2 = c12 has rational point (local solvability).
\\ Equivalently:  c12 = 19 u^2 - v^2 = N_{Q(sqrt 19)/Q}(... )  is a norm from Q(sqrt(19)).
\\ By Hasse, soluble iff (19, c12)_p = 1 for all p (Hilbert symbol).
print();
print("=== Local solvability of 19 u^2 - v^2 = c12 ===");
print("c12 = X1(X2-X3) factor: ", factor(abs(c12)));
print("c12 < 0?  ", c12 < 0);
\\ 19 u^2 - v^2 = c12 represents c12 by the form Q1 = 19 X^2 - Y^2.
\\ Disc(Q1) = -4*19*(-1)*... uniform: c12 must be in image of N from Q(sqrt 19).
\\ Use Hilbert symbol: c12 = 19 u^2 - v^2 ⟺  N_{Q(sqrt 19)/Q}(u sqrt 19 + v) = -c12  (since N(a + b sqrt 19) = a^2 - 19 b^2,  so we want a^2 - 19 b^2 = -c12  i.e. -c12 should be a norm from Q(sqrt 19)).
\\ Or equivalently, (19, -c12)_p = 1 for all p.

primes_check = [2, 3, 5, 7, 19, 31, 71, 73, 101, 103, 5413];
for(k=1, length(primes_check),
  p = primes_check[k];
  h = hilbert(19, -c12, p);
  print("p = ", p, "   (19, -c12)_p = ", h);
);
hinf = hilbert(19, -c12, -1);    \\ -1 for infinite place in PARI? Actually use 0 or omit
print("(19, -c12) at infty = ", hilbert(19, -c12, 0));

\\ Now solve via qfsolve:
print();
print("=== qfsolve on 19 u^2 - v^2 - c12 t^2 = 0 ===");
\\ The matrix is diag(19, -1, -c12).
M = matdiagonal([19, -1, -c12]);
sol = qfsolve(M);
print("qfsolve M = ", sol);

\\ If sol returns a vector [u, v, t]:
if(type(sol) == "t_COL",
  uu = sol[1]; vv = sol[2]; tt = sol[3];
  print("  19*", uu, "^2 - ", vv, "^2 - ", c12, "*", tt, "^2 = ", 19*uu^2 - vv^2 - c12*tt^2);
);

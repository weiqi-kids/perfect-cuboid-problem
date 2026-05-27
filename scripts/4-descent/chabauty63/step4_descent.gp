/* Step 4: Rank-1 generator search via 2-descent.
 *
 * E_Hm Weierstrass model:  y^2 = (x + X1 X2)(x + X1 X3)(x + X2 X3)
 * with 2-torsion x-coordinates  -X1 X2, -X1 X3, -X2 X3.
 *
 * 2-descent: a point P = (x, y) ∈ E(Q) maps to  (x + X1 X2,  x + X1 X3,  x + X2 X3)
 * mod squares.  The triple from selmer_63_38.txt that's MW-supported (Heron-form cross-pair) is one of:
 *    [19, 1, 19]    or  [19, 505, 9595]    or ...   (these are the Heron-form cross-pair triples)
 *
 * Concretely: search for x ∈ Q such that
 *    x + X1 X2 = 19 * (rational square)
 *    x + X1 X3 = 1  * (rational square)        (i.e. itself a square)
 *    x + X2 X3 = 19 * (rational square)
 *
 * Parameterize  x + X1 X3 = u^2  so  x = u^2 - X1 X3.
 * Then  x + X1 X2 = u^2 - X1 X3 + X1 X2 = u^2 - X1(X3 - X2)  must be 19 * v^2
 * and  x + X2 X3 = u^2 - X1 X3 + X2 X3 = u^2 - X3(X1 - X2)  must be 19 * w^2.
 *
 * X3 - X2 = b^2 - a^2 = -P*Q (negative since a<b? actually 4788^2 > 2525^2 yes)
 * Let's compute.
 */

m = 63; n = 38;
a = m^2 - n^2;   X2 = a^2;
b = 2*m*n;       X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;
print("X1 = dab^2 = ", X1);
print("X2 = a^2 = ", X2);
print("X3 = b^2 = ", X3);
print("X1*X2 = ", X1*X2);
print("X1*X3 = ", X1*X3);
print("X2*X3 = ", X2*X3);

\\ The 2-descent images of the three rational 2-torsion points themselves:
\\   T1 = (-X1 X2, 0): images in (Q*/Q*^2)^3 are (1, X1(X2-X3), X2(X3-X1) ) up to a sign convention.
\\   For brevity skip; we want non-torsion points.

\\ Direct search: look for small rational points by trying small denominators.
\\ x = N/D, search |N|, |D| <= some bound.

\\ Use ellinit to test points:
E = ellinit([0, X1*X2 + X1*X3 + X2*X3, 0, X1*X2*X3*(X1+X2+X3), (X1*X2*X3)^2]);
print("E disc primes = ", factor(abs(E.disc))[,1]);

\\ Use ellsearch or a manual loop. ellsearch is allowed (point search, not ellrank/ellheegner).
\\ Try heights up to 1e6 first.
print("=== ellsearch up to height 10^4 ===");
pts4 = ellratpoints(E, 10^4);
print("num points found: ", length(pts4));
for(k=1, min(20, length(pts4)), print(pts4[k]));
print();
print("=== ellsearch up to height 10^6 ===");
pts6 = ellratpoints(E, 10^6);
print("num points found: ", length(pts6));
for(k=1, min(20, length(pts6)), print(pts6[k]));

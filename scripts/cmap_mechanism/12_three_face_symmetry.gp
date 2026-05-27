/* Verify the SYMMETRY between q and c.
   Given (1, q, c) Euler brick, the curve E_PCP(q) has a special point at this c-value;
   by symmetry, E_PCP(c) should have a special point at this q-value.

   Test: for each c-map output (q -> c), construct the predicted preimage on E_PCP(c):
   find (X, Y) on E_PCP(c): Y^2 = X(X+1)(X+c^2) such that 2c*Y/(c^2-X^2) = q.

   This gives a quadratic in X:  Y^2 (1) -- let me work it out:
     2c Y / (c^2 - X^2) = q  =>  2c Y = q(c^2 - X^2)  =>  Y = q(c^2-X^2)/(2c).
     Then Y^2 = X(X+1)(X+c^2).
     q^2 (c^2-X^2)^2 / (4 c^2) = X(X+1)(X+c^2)
     q^2 (c^2-X^2)^2 = 4 c^2 X (X+1)(X+c^2)

   This is a quartic in X. Find its rational roots given (q, c) Pythagorean Euler brick.
*/
default(parisize, 800000000);

\\ For each c-map pair (q, c, P_E), find the corresponding point on E_PCP(c).
print("=== Cross-curve symmetry: c-map (q -> c) implies a point on E_PCP(c) with c-value q ===");
print("");

{
\\ (q, c, x_on_EPCP_q, y_on_EPCP_q)
data = [
  [20/21, 48/55, -45/49, 10/343],
  [11/60, 39/80, ?, ?],  \\ to fill later
  [7/24, 20/99, ?, ?]
];
}

\\ Manually compute for q=20/21:
q = 20/21;
E_q = ellinit([0, 1+q^2, 0, q^2, 0]);
E_qmin = ellminimalmodel(E_q, &vq);
G_q_min = [-125/4, 395/8];
G_q = ellchangepointinv(G_q_min, vq);
print("q=", q, " G on E_PCP(q): ", G_q);
c_val = 2*q*G_q[2]/(q^2 - G_q[1]^2);
print("c=", c_val);

\\ Build E_PCP(c) and search for a point with c-value q on it.
\\ Approach: parametrize by Y = q(c^2 - X^2)/(2c), then solve quartic in X.
c = c_val;
E_c = ellinit([0, 1+c^2, 0, c^2, 0]);
\\ The equation: q^2 (c^2 - X^2)^2 = 4 c^2 X (X+1)(X+c^2).
\\ Expand: q^2 (X^4 - 2c^2 X^2 + c^4) = 4 c^2 (X^3 + (1+c^2) X^2 + c^2 X).
\\ q^2 X^4 - 2 q^2 c^2 X^2 + q^2 c^4 - 4 c^2 X^3 - 4 c^2 (1+c^2) X^2 - 4 c^4 X = 0.
\\ Coefficient of X^4: q^2
\\ Coefficient of X^3: -4 c^2
\\ Coefficient of X^2: -2 q^2 c^2 - 4 c^2 - 4 c^4 = -2c^2 (q^2 + 2 + 2c^2)
\\ Coefficient of X^1: -4 c^4
\\ Coefficient of X^0: q^2 c^4

p = q^2 * 'X^4 - 4*c^2*'X^3 - 2*c^2*(q^2 + 2 + 2*c^2)*'X^2 - 4*c^4*'X + q^2*c^4;
print("Polynomial in X: ", p);
print("\nRational roots:");
\\ Use polrootsrat or polroots over Q
my_roots = polrootspadic(p, 2, 40);  \\ p-adic roots, then check Q
\\ Or just factor over Q:
print("\nFactorization over Q:");
print(factor(p));

\\ Try direct rational roots:
{
print("\nTesting candidate rational roots:");
my(found_pts = []);
\\ Rational roots: a/b with a | q^2 c^4, b | q^2.
\\ This is a 4th-degree polynomial; rational roots are bounded by Cauchy bound.
\\ Try small denominators and integer numerators up to some bound.
\\ More systematic: factor the numerator polynomial and check for linear factors over Q.
my(f = factor(p));
print("  ", f);
for(i=1, matsize(f)[1],
  my(g = f[i, 1]);
  if (poldegree(g) == 1,
    my(r = -polcoef(g, 0)/polcoef(g, 1));
    print("  root: X=", r);
    \\ Check on E_PCP(c)
    my(Y_pred = q*(c^2 - r^2)/(2*c));
    my(Y2 = r*(r+1)*(r+c^2));
    print("    Y_pred=", Y_pred, "  Y^2_pred=", Y_pred^2, "  Y2=", Y2, "  match? ", Y_pred^2 == Y2);
    if (Y_pred^2 == Y2,
      print("    => (X, Y) = (", r, ", ", Y_pred, ") is on E_PCP(", c, ")");
      \\ Compute c-value at this point
      if (r != c && r != -c,
        my(c_recovered = 2*c*Y_pred/(c^2 - r^2));
        print("       2cY/(c^2-X^2) = ", c_recovered, "  (should be q=", q, ")");
      );
    );
  );
);
}

\\ Now: in the canonical form, c = 48/55, so E_PCP(48/55) has a known generator.
\\ Its c-image at THAT generator is -20/21 (= -q).
\\ But the SAME Euler brick (1, q, c) could be encoded differently.
\\ The "preimage" found above should match the rank-1 generator of E_PCP(48/55).

print("\n=== Compare with known generator of E_PCP(48/55) ===");
E_c_min = ellminimalmodel(E_c, &vc);
G_c_min = [-282, 1956];
G_c = ellchangepointinv(G_c_min, vc);
print("Known generator of E_PCP(48/55) on its minimal model: ", G_c_min);
print("Pulled back to E_PCP(48/55): ", G_c);
print("c-value at this point: 2cY/(c^2-X^2) = ", 2*c*G_c[2]/(c^2 - G_c[1]^2));

\\ Now: a point on E_PCP(q) with c-value c, gives an Euler brick (1, q, c).
\\ A point on E_PCP(c) with c-value q, gives an Euler brick (1, c, q).
\\ Both encode the SAME geometric Euler brick (up to labeling).
\\ So they are RELATED via the "swap" symmetry of the K3.

print("\n=== Generic symbolic check: closure under (q, x) <-> (c, X) involution ===");
print("");
print("For a generic rational (x, y) on E_PCP(q) (with y^2 = x(x+1)(x+q^2)):");
print("  c = 2qy/(q^2-x^2)");
print("  sqrt(1+c^2) = (x^2+2q^2 x + q^2)/(q^2-x^2)        [identity 1]");
print("  sqrt(q^2+c^2) = q(x^2 + 2x + q^2)/(q^2-x^2)       [identity 2]");
print("");
print("The Euler brick (1, q, c) has 3 rational face diagonals:");
print("  d = sqrt(1+q^2)    (constant in x)");
print("  e = sqrt(q^2+c^2)  (formula above)");
print("  f = sqrt(1+c^2)    (formula above)");

\\ Now reverse: from (1, c, q) we should get a point on E_PCP(c) with the c-value = q.
\\ The relation:  if X is the "x" parameter on E_PCP(c), then 2cY/(c^2-X^2) = q.
\\ So Y = q(c^2-X^2)/(2c).
\\ Then we need Y^2 = X(X+1)(X+c^2), i.e., q^2(c^2-X^2)^2/(4c^2) = X(X+1)(X+c^2).
\\
\\ Among the roots of this quartic, ONE is the X-coordinate corresponding to (x, y) on E_PCP(q).
\\
\\ Symbolic relation: the involution that exchanges the two curves is a birational map.
\\ Let's express X in terms of x, q, y.

print("\n=== Symbolic involution: birational map E_PCP(q) <-> E_PCP(c) ===");
print("");
print("Given (x, y) on E_PCP(q), compute c = 2qy/(q^2-x^2).");
print("Then on E_PCP(c) the corresponding X satisfies (canonically) one of 4 roots of the quartic above.");
print("");
print("Symbolic insight: the Euler brick (1, q, c) is encoded by");
print("  a = 1, b = q, c = c  (edges)");
print("with rational face diagonals d, e, f as above.");
print("");
print("By symmetry of the brick: swap b <-> c. Then we want (1, c, q) as a brick.");
print("  i.e., E_PCP(c) at a parameter X with 2cY/(c^2-X^2) = q.");
print("");
print("Symbolic: with c = 2qy/(q^2-x^2), back-substitute into the quartic and look");
print("for a polynomial identity.");

quit;

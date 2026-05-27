/* 14_x_intersection.gp
 *
 * The PCP closure question becomes:
 *
 *   Pi_x(E_PCP(q)(Q)) ∩ Pi_x(E_PCP(q)^(-1)(Q)) ⊆ {0, -1, -q^2, q, -q, ∞}
 *
 * where Pi_x : E(Q) → P^1(Q) is the x-coordinate map.
 *
 * Both curves have full 2-torsion and the SAME 2-torsion x-coordinates (0, -1, -q^2)!
 * (Both are y^2 = x(x+1)(x+q^2) up to sign of y; the twist by -1 changes only the y.)
 *
 * Wait — that's a problem. Let me check.
 * E_PCP(q): y^2 = x(x+1)(x+q^2). 2-torsion x: 0, -1, -q^2.
 * E_twist (twist by -1): integer model [0, -(m^2+n^2), 0, m^2*n^2, 0].
 * In the original q-variable: y^2 = x^3 - (1+q^2) x^2 + q^2 x = x(x^2 - (1+q^2)x + q^2)
 *   = x(x-1)(x-q^2). 2-torsion x: 0, 1, q^2.
 *
 * Ah so the twist by -1 of [0, (1+q^2), 0, q^2, 0] gives [0, -(1+q^2), 0, q^2, 0]
 *   = E': y^2 = x(x-1)(x-q^2).
 *
 * So 2-torsion x-coords:
 *   E_PCP:  {0, -1, -q^2}
 *   E_twist: {0, 1, q^2}
 * They share only x = 0.
 *
 * Pi_x intersection cases:
 * (a) Both give x = 0: this is the degenerate 2-torsion / base point.
 * (b) Both give the same rational x ≠ 0: this is a hypothetical PCP candidate.
 */
default(parisize, 1000000000);

print("=== Test: does E_PCP(q) and E_PCP(q)^(-1) ever share a non-trivial x? ===");
print();
print("If P ∈ E_PCP(q)(Q) with x_P = a, and there exists Q ∈ E_twist(Q) with x_Q = a, then:");
print("  y_P^2 = a(a+1)(a+q^2)  and  y_Q^2 = a(a-1)(a-q^2)");
print("  Product: y_P^2 y_Q^2 = a^2 (a^2-1)(a^2-q^4)");
print("  So a^2(a^2-1)(a^2-q^4) is a square. Setting u = a^2:");
print("  u (u-1)(u - q^4) is a square -- this is the GROSS / curve E*: v^2 = u(u-1)(u-q^4).");
print();
print("So PCP exists at fiber q ⟺ E*(q): v^2 = u(u-1)(u-q^4) has a rational point with u > 0, u ≠ 0, 1, q^4.");
print("");
print("E*(q): y^2 = x(x-1)(x-q^4) — another elliptic curve in the family!");
print("This is the 'product' / 'gluing' Kummer-like curve.");
print();

/* Test: compute rank of E*(q) for several q */
print("=== Ranks of E*(q): y^2 = x(x-1)(x-q^4) at various Pythagorean fibers ===");
print("| n | m | q^4 | rank E*(q) |");

{
test_qs = [[3,4], [5,12], [8,15], [7,24], [20,21], [11,60], [9,40], [12,35], [195,748]];
for(i=1, #test_qs,
  n = test_qs[i][1];
  m = test_qs[i][2];
  q4_num = n^4;
  q4_den = m^4;
  /* E_star: y^2 = x(x-1)(x-q^4). Integer model with X = m^4 x: */
  /* y^2 = (X/m^4)(X/m^4 - 1)(X/m^4 - n^4/m^4)
   *     = (1/m^12) X (X - m^4)(X - n^4)
   * (Y = m^6 y): Y^2 = X (X - m^4)(X - n^4)
   * = X^3 - (m^4+n^4) X^2 + m^4 n^4 X
   */
  Estar = ellinit([0, -(m^4+n^4), 0, m^4*n^4, 0]);
  rs = ellrank(Estar);
  print("| ", n, " | ", m, " | ", n^4, "/", m^4, " | [", rs[1], ",", rs[2], "] | gens=", if(#rs>=4, rs[4], "?"));
);
}

print();
print("=== This new curve E*(q): y^2 = x(x-1)(x-q^4) is the 'fusion curve'. ===");
print("It captures EXACTLY the PCP intersection.");

print();
print("=== Geometric interpretation ===");
print("E_PCP(q):    y_1^2 = x(x+1)(x+q^2)");
print("E_twist(q):  y_2^2 = x(x-1)(x-q^2)  -- via twist by -1, X -> -X, Y -> i Y");
print();
print("Actually let me re-derive E_twist x-coords. Twist by d=-1 of [0,a2,0,a4,0]:");
print("  E^(d): X^3 + a2 d X^2 + a4 d^2 X");
print("  For E_PCP: [0, 1+q^2, 0, q^2, 0] in the (x, y) world.");
print("  Twist by -1: [0, -(1+q^2), 0, q^2, 0] => y^2 = X^3 - (1+q^2)X^2 + q^2 X = X(X-1)(X-q^2).");
print("  Yes, 2-torsion at X = 0, 1, q^2.");
print();
print("So if P_1 = (a, y_1) ∈ E_PCP(Q) and P_2 = (a, y_2) ∈ E_twist(Q) with SAME x = a:");
print("  y_1^2 y_2^2 = a^2 (a^2 - 1)(a^2 - q^2)^2  ... wait no.");
print("  Let me recompute. y_1^2 = a(a+1)(a+q^2),  y_2^2 = a(a-1)(a-q^2)");
print("  Product = a^2 (a+1)(a-1)(a+q^2)(a-q^2) = a^2(a^2-1)(a^2-q^4) ✓");
print();
print("So: (y_1 y_2 / a)^2 = (a^2-1)(a^2-q^4). Set u = a^2:");
print("  E_fusion: v^2 = (u-1)(u-q^4) -- this is a CONIC! Not elliptic.");
print();
print("Hmm so my derivation gave u(u-1)(u-q^4) but that's because we kept the a^2 factor.");
print("Actually (y_1 y_2)^2 = a^2 (a^2-1)(a^2-q^4), so (y_1 y_2 / a)^2 = (a^2-1)(a^2-q^4)");
print("which is a conic in (u, v) where u = a^2 and v = y_1 y_2 / a.");
print();
print("=== Conic v^2 = (u-1)(u-q^4) ===");
print("Genus 0! Just need to test solvability.");
print("Rational points iff ?");
print("(u-1)(u-q^4) ≥ 0 in R: u ≥ q^4 or u ≤ 1 (for q^4 ≤ 1 if q < 1, but q is rational != bound).");
print();
print("Locally:");
print("At u = 0: -q^4 should be a square — only if q = 0. No.");
print("At u = ∞: -1 -- needs to be a square locally. Always works over R if we go to large u.");
print();
print("Universal rational points: (u, v) = (1, 0) and (u, v) = (q^4, 0).");
print("Standard parametrization: line v = t(u-1) gives t^2(u-1)^2 = (u-1)(u-q^4)");
print("  => t^2 (u-1) = u - q^4 (assuming u != 1)");
print("  => u(t^2 - 1) = t^2 - q^4");
print("  => u = (t^2 - q^4)/(t^2 - 1)");
print("And v = t(u-1) = t * ((t^2-q^4)/(t^2-1) - 1) = t * (1 - q^4)/(t^2 - 1) = t(1-q^4)/(t^2-1)");
print();

print("=== So u = a^2 is parametrized by t. For PCP, a must be rational ===");
print("u = a^2 = (t^2-q^4)/(t^2-1).  For u to be a perfect square in Q, we need");
print("(t^2-q^4)(t^2-1) to be a square (multiplying numerator and denominator by (t^2-1)).");
print();
print("(t^2-1)(t^2-q^4) = t^4 - (1+q^4)t^2 + q^4");
print("Setting w = t and looking for s = sqrt((w^2-1)(w^2-q^4)):");
print("  s^2 = (w^2-1)(w^2-q^4) — another genus-1 curve!");
print();

/* This is the same E*-like curve. Compute */
print("=== New curve: s^2 = (t^2-1)(t^2-q^4) ===");
print();
print("In (t, s)-plane: this is genus 1 since RHS is degree 4 squarefree.");
print("Jacobian = ?");

{
qs = [[3,4], [5,12], [20,21], [11,60]];
for(j=1, #qs,
  n = qs[j][1]; m = qs[j][2]; q0 = n/m;
  Q4_int = n^4 * m^0;  /* not used */
  /* The quartic (t^2-1)(t^2 - q^4) in t. Setting q = n/m and clearing:
     m^4 (t^2-1)(t^2 - n^4/m^4) = m^4(t^2-1)t^2 - n^4(t^2-1)
     Hmm let's just specialize. */
  /* Quartic poly in t: */
  qpol = (t^2 - 1)*(t^2 - q0^4);
  Ej = ellinit(ellfromeqn(s^2 - qpol));
  Ej_min = ellminimalmodel(Ej);
  print("q = ", n, "/", m, ": Jacobian = ", Ej_min[1..5], " cond=", ellglobalred(Ej_min)[1]);
  print("  ellrank: ", ellrank(Ej_min));
);
}

quit;

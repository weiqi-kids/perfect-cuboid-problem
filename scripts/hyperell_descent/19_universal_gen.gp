/* 19_universal_gen.gp
 *
 * Empirical fact: rank(E_PCP(q)^(-1)) ≥ 1 for every primitive Pythagorean q tested.
 * Hypothesis: there's a UNIVERSAL Q(q)-rational point on E_PCP(q)^(-1) of infinite order.
 *
 * Find such a point: from the structure of S_q, we have the point (x = 0, w = q^2 sqrt(1+q^2)).
 * Mapping to J(S_q) = E_PCP^(-1) gives a Q(h, m)-point.
 *
 * For q = n/m Pythagorean with h^2 = m^2 + n^2, h is rational in Q.
 *
 * Let's identify this point explicitly.
 */
default(parisize, 1000000000);

print("=== Find the universal generator of E_PCP(q)^(-1) for Pythagorean q ===");
print();
print("Candidate universal point: from (0, q^2 h/m) on S_q.");
print("Map to Jacobian E_twist: integer model [0, -(m^2+n^2), 0, m^2 n^2, 0].");
print();

/* For each test fiber, compute the universal generator's image */
test_qs = [[3,4], [5,12], [8,15], [20,21], [12,35], [9,40], [11,60], [48,55]];

print("| n | m | h^2=m^2+n^2 | universal pt? | check |");

{
for(i=1, #test_qs,
  n = test_qs[i][1]; m = test_qs[i][2];
  hsq = m^2 + n^2;
  if(!issquare(hsq), next);
  h = sqrtint(hsq);

  Etw = ellinit([0, -(m^2+n^2), 0, m^2*n^2, 0]);
  /* Try various candidates */
  /* Candidate 1: X = -m*n */
  /* y^2 = X^3 - (m^2+n^2) X^2 + m^2 n^2 X
      at X = -m*n: y^2 = -m^3 n^3 - (m^2+n^2)(m^2 n^2) - m^3 n^3
                       = -2 m^3 n^3 - m^4 n^2 - m^2 n^4 - wrong
      Let me try X = m*n: y^2 = m^3 n^3 - (m^2+n^2)(m^2 n^2) + m^3 n^3
                              = 2 m^3 n^3 - m^4 n^2 - m^2 n^4
                              = m^2 n^2 (2 m n - m^2 - n^2) = -m^2 n^2 (m-n)^2
      Negative.
      Try X = h^2 = m^2 + n^2 = a^2:
      y^2 = (m^2+n^2)^3 - (m^2+n^2)^3 + m^2 n^2 (m^2+n^2) = m^2 n^2 (m^2+n^2) = m^2 n^2 h^2
      So y = m n h.  Point: (h^2, m n h).
      Verify: m^2+n^2 = h^2, so X = h^2. */
  X_cand = hsq;
  Y_cand = m*n*h;
  /* Verify */
  RHS = X_cand^3 - hsq * X_cand^2 + m^2 * n^2 * X_cand;
  print("| ", n, " | ", m, " | ", hsq, " | (", X_cand, ", ", Y_cand, ") | ", \
        "y^2 = ", RHS, " expected ", Y_cand^2, " match=", RHS == Y_cand^2, " |");
  /* Is this point torsion? */
  P = ellinit([0, -(m^2+n^2), 0, m^2*n^2, 0]);
  P_pt = [X_cand, Y_cand];
  /* check torsion */
  order = ellorder(Etw, P_pt);
  print("  -- order: ", order, " (0 = infinite, else finite)");
);
}

print();
print("=== Verified: (h^2, m n h) is a universal rational point on E_PCP(q)^(-1) ===");
print("Universal in the sense: defined polynomially in (m, n, h) with h^2 = m^2+n^2.");
print();
print("Is it of infinite order or torsion?");
print();
print("Compute heights to confirm:");

{
for(i=1, #test_qs,
  n = test_qs[i][1]; m = test_qs[i][2];
  hsq = m^2 + n^2;
  if(!issquare(hsq), next);
  h = sqrtint(hsq);
  Etw = ellinit([0, -(m^2+n^2), 0, m^2*n^2, 0]);
  P_pt = [hsq, m*n*h];
  /* Canonical height */
  ht = ellheight(Etw, P_pt);
  ord = ellorder(Etw, P_pt);
  print("  (", n, "/", m, "): canonical height = ", ht, ", order = ", ord);
);
}

quit;

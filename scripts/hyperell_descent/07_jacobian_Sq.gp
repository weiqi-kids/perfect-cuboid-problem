/* 07_jacobian_Sq.gp
 *
 * For fixed Pythagorean q, S_q: y^2 = F(x, q) = (x^2+q^2) * G(x,q)
 * is a genus-1 curve (degree-4 squarefree polynomial in x).
 * Compute its Jacobian elliptic curve and compare with E_PCP(q).
 */
default(parisize, 1000000000);

A = x^2 + q^2;
G = (1+q^2)*x^2 + 4*q^2*x + q^2*(1+q^2);
F = A * G;

/* Test list of Pythagorean q's (rank-jump fibers from the catalog) */
test_qs = [[3,4], [4,3], [5,12], [20,21], [11,60], [48,55], [39,80], [17,144], [7,24], [195,748]];

print("=== Jacobian elliptic curves J(S_q) for various Pythagorean q ===");
print();
{
for(i=1, #test_qs,
  q0 = test_qs[i][1] / test_qs[i][2];
  print("--- q = ", test_qs[i][1], "/", test_qs[i][2], " ---");

  /* F as polynomial in x */
  Fq = subst(F, q, q0);
  /* Clear denominator */
  d = denominator(content(Fq));
  Fq_int = d^2 * Fq;  /* So that y' = d * y still gives integer coeffs */
  print("  F(x, q): degree 4, leading coef ", polcoef(Fq, 4, x));

  /* Compute Jacobian via ellfromeqn */
  /* Actually we need w^2 = quartic in x. Use ellfromeqn for genus-1 cover */
  /* ellfromeqn handles y^2 - quartic_in_x */
  E = ellfromeqn(y^2 - Fq);
  Em = ellinit(E);
  Em_min = ellminimalmodel(Em);

  /* Get [a1,a2,a3,a4,a6] of minimal model */
  ainv = ellminimalmodel(Em)[1..5];
  print("  Minimal model: ", ainv);
  print("  Conductor: ", ellglobalred(Em_min)[1]);
  print("  Torsion: ", elltors(Em_min)[1], " of structure ", elltors(Em_min)[2]);

  /* Compare with E_PCP(q): y^2 = x(x+1)(x+q^2) */
  /* In short Weierstrass: y^2 = x^3 + (1+q^2) x^2 + q^2 x */
  m = test_qs[i][2];
  n = test_qs[i][1];
  /* E_PCP minimal model with integer coefs after q = n/m */
  /* y^2 = x^3 + (1+n^2/m^2) x^2 + (n^2/m^2) x
   * Multiply through by m^4: (m^2 y)^2 = m^4 x^3 ... rescale x' = m^2 x, y' = m^3 y:
   * y'^2 = x'^3 + (m^2+n^2) x'^2 + m^2 n^2 x'
   */
  Epcp = ellinit([0, m^2+n^2, 0, m^2*n^2, 0]);
  Epcp_min = ellminimalmodel(Epcp);
  print("  E_PCP minimal: ", Epcp_min[1..5]);
  print("  E_PCP conductor: ", ellglobalred(Epcp_min)[1]);

  /* j-invariants */
  print("  j(J(S_q)) = ", Em[13]);
  print("  j(E_PCP)  = ", Epcp[13]);
  print("  Equal?    ", Em[13] == Epcp[13]);
  print();
);
}

quit;

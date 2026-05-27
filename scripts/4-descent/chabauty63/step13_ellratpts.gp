/* Step 13: ellratpoints on quartic z3^2 = Q(s)/d3 for each cross-paired class. */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

classes = [[15549, -5183, -3], [15549, -2617415, -1515], [295431, -5183, -57], [295431, -2617415, -28785], [9579, 3193, 3], [9579, 1612465, 1515], [182001, 3193, 57], [182001, 1612465, 28785]];

for(kk = 1, length(classes),
  c = classes[kk];
  d1 = c[1]; d2 = c[2]; d3 = c[3];
  print();
  print("=== class ", kk, " = ", c, " ===");
  M = matdiagonal([d1, -d2, -C12]);
  P0 = qfsolve(M);
  z10 = P0[1]; z20 = P0[2]; t0 = P0[3];

  L_coef = [2*(-d2*z20 - C12*t0), 2*d1*z10];
  M_coef = [-d2 - C12, 0, d1];
  Z1_coef = [z10*M_coef[1], -L_coef[1], z10*M_coef[3] - L_coef[2]];
  T_coef  = [t0*M_coef[1] - L_coef[1], -L_coef[2], t0*M_coef[3]];

  P1 = Pol([Z1_coef[3], Z1_coef[2], Z1_coef[1]], s);
  P2 = Pol([T_coef[3],  T_coef[2],  T_coef[1] ], s);
  Q_s = d1*P1^2 - C13*P2^2;
  print("  Q(s) = ", Q_s);
  print("  deg = ", poldegree(Q_s), "  lc = ", polcoeff(Q_s, poldegree(Q_s)));

  \\ The cover y^2 = Q(s)/d3.
  Qd = Q_s/d3;
  \\ Force integer coefficients by clearing denominators if any.
  cont = content(Q_s);
  print("  content Q(s) = ", factor(cont));

  \\ Build polynomial coefficient vector (for ellratpoints input).
  poly_vec = Vec(Qd);
  print("  poly coeffs (s^4, s^3, ..., 1) = ");
  print("    ", poly_vec);

  \\ ellratpoints expects a polynomial in some variable. But ellratpoints needs an elliptic curve.
  \\ Use hyperellratpoints: defined in PARI for y^2 = f(x) with deg f <= 6.
  \\ Actually, in PARI/GP, the function is `hyperellratpoints(P, h)`.

  print("  searching hyperellratpoints up to height 1000 ...");
  pts = hyperellratpoints(Qd, 1000);
  print("  pts = ", pts);
);
}

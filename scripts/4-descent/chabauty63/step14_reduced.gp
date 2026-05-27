/* Step 14: Reduce each cover quartic via hyperellred and search.
 * Use qfparam for clean parametrization. */
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

  \\ Conic Q1: d1 z1^2 - d2 z2^2 - C12 t^2 = 0.
  M1 = matdiagonal([d1, -d2, -C12]);
  P0 = qfsolve(M1);

  \\ Get the clean parametrization via qfparam.
  PARAM = qfparam(M1, P0);
  \\ PARAM is a 3x3 matrix of coefficients; row i gives z_i = PARAM[i,1]*u^2 + PARAM[i,2]*u*v + PARAM[i,3]*v^2.
  print("  qfparam = ", PARAM);

  \\ Build polynomials in single variable u (set v=1).
  Z1u = PARAM[1,1]*u^2 + PARAM[1,2]*u + PARAM[1,3];
  Z2u = PARAM[2,1]*u^2 + PARAM[2,2]*u + PARAM[2,3];
  Tu  = PARAM[3,1]*u^2 + PARAM[3,2]*u + PARAM[3,3];

  \\ Check: d1 Z1u^2 - d2 Z2u^2 - C12 Tu^2 should be identically zero.
  chk = d1*Z1u^2 - d2*Z2u^2 - C12*Tu^2;
  print("  conic check (should be 0): ", chk);

  \\ Now compute Q(u) = d1 Z1u^2 - C13 Tu^2. We want Q(u)/d3 = square.
  Q_u = d1*Z1u^2 - C13*Tu^2;
  print("  Q(u) degree = ", poldegree(Q_u));

  \\ y^2 = Q_u/d3. Use rational scaling: y^2 * d3 = Q_u, but cleaner: define f = Q_u/d3 if integer.
  \\ If d3 < 0 we need to handle sign — i.e., search for u with Q(u)*d3 < 0 and -Q(u)/(-d3) = square.
  \\ Just write y^2 = Q_u/d3 directly; PARI lets this be rational.
  f_u = Q_u/d3;
  \\ Force common denominator clearing
  cf = content(f_u);
  print("  content f_u = ", factor(abs(cf)));
  print();

  \\ Use hyperellred to find a small model.
  print("  trying hyperellred ...");
  \\ hyperellred requires polynomial; if f has rational coeffs, multiply by sq.
  fclean = f_u;
  \\ Need integral squarefree polynomial. Multiply by denominator squared if non-integer.
  den_fclean = denominator(fclean);
  print("  denom = ", den_fclean);
  if(den_fclean != 1,
    fclean = fclean * den_fclean^2;
    print("  after clearing: deg = ", poldegree(fclean));
  );
  \\ Squarefree part
  fsqf = fclean/gcd(fclean, deriv(fclean));
  \\ Actually fclean's squarefree part might collapse degree.
  \\ Just use fclean directly with hyperellred.

  Cred = hyperellred(fclean);
  print("  reduced output = ");
  print("    ", Cred);
  \\ hyperellred returns [P, Q] with model y^2 + Q y = P.
  if(type(Cred) == "t_VEC",
    Pred = Cred[1]; Qred = Cred[2];
    print("  reduced P = ", Pred);
    print("  reduced Q = ", Qred);
    print("  hyperellratpoints on reduced, h=10000 ...");
    pts_red = hyperellratpoints([Pred, Qred], 10000);
  ,
    pts_red = hyperellratpoints(Cred, 10000);
  );
  print("  reduced pts = ", pts_red);

  if(length(pts_red) > 0,
    print("  *** HIT in class ", kk, "! ***");
    break;
  );
);
}

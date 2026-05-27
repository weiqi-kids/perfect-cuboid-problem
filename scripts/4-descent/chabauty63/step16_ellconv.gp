/* Step 16: For each reduced quartic, convert to Weierstrass via ellfromeqn(y^2 - Pred(u))
 * and use ellratpoints on the elliptic curve directly (the standard way). */
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
  M1 = matdiagonal([d1, -d2, -C12]);
  P0 = qfsolve(M1);
  PARAM = qfparam(M1, P0);
  Z1u = PARAM[1,1]*u^2 + PARAM[1,2]*u + PARAM[1,3];
  Z2u = PARAM[2,1]*u^2 + PARAM[2,2]*u + PARAM[2,3];
  Tu  = PARAM[3,1]*u^2 + PARAM[3,2]*u + PARAM[3,3];
  Q_u = d1*Z1u^2 - C13*Tu^2;
  f_u = Q_u/d3;
  Cred = hyperellred(f_u);
  Pred = Cred[1];

  \\ Convert y^2 = Pred(u) to elliptic curve via ellfromeqn.
  eqn = y^2 - Pred;
  Ecov = 0;
  ee = 0;
  trap_msg = "";
  iferr(
    ee = ellfromeqn(eqn);
    Ecov = ellinit(ee);
  , E,
    trap_msg = "ellfromeqn/init failed: ";
  );
  print();
  print("=== class ", kk, " = ", classes[kk], " ===");
  if(trap_msg != "",
    print("  ", trap_msg);
    next;
  );
  print("  Weierstrass = ", ee);
  print("  cond bad primes = ", factor(abs(Ecov.disc))[,1]);
  print("  torsion = ", elltors(Ecov)[1]);

  print("  ellratpoints up to height 10^5 ...");
  pts = ellratpoints(Ecov, 100000);
  print("  pts = ", pts);
  if(length(pts) > 1,
    print("  *** rational points found, checking non-torsion ...");
    for(j=1, length(pts),
      P = pts[j];
      if(P != [0],
        ord = ellorder(Ecov, P);
        print("    P = ", P, "  order = ", ord);
      );
    );
  );
);
}

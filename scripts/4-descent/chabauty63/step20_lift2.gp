/* Step 20: Lift hits correctly. */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

A4_d = e1*e2 + e1*e3 + e2*e3;
A6_d = -e1*e2*e3;
E_Hm = ellinit([0,0,0,A4_d,A6_d]);
print("E_Hm tors order = ", elltors(E_Hm)[1]);
print("E_Hm tors gens = ", elltors(E_Hm)[3]);

classes_hit = [[16549319, -16549319, -1], [3258398654, -1237211519, -26866], [10529681554, 3998112169, 26866]];

for(kk=1, length(classes_hit),
  c = classes_hit[kk];
  d1 = c[1]; d2 = c[2]; d3 = c[3];
  print();
  print("====== class ", c, " ======");

  M1 = matdiagonal([d1, -d2, -C12]);
  P0 = qfsolve(M1);
  PARAM = qfparam(M1, P0);
  Z1u = PARAM[1,1]*u^2 + PARAM[1,2]*u + PARAM[1,3];
  Tu  = PARAM[3,1]*u^2 + PARAM[3,2]*u + PARAM[3,3];
  Q_u = d1*Z1u^2 - C13*Tu^2;
  f_u = Q_u/d3;

  CHV = 0;
  Cred = hyperellred(f_u, &CHV);
  Pred = Cred[1];
  print("  CHV = ", CHV);
  \\ CHV = [c0, [a,b;cc,dd], const?] format.
  scale = CHV[1];
  Mob = CHV[2];
  aa = Mob[1,1]; bb = Mob[1,2]; cc = Mob[2,1]; dd = Mob[2,2];

  \\ The substitution from u_orig to u_new should be such that:
  \\   Pred(u_new) = scaling * f_u(u_orig) (up to a square multiplier from y -> y * (cu+d)^2 / det).
  \\ Standard for hyperellred: u_orig = (aa*u_new + bb)/(cc*u_new + dd).
  \\ Let's verify by checking the identity:
  uu = u;
  u_orig_test = (aa*uu + bb)/(cc*uu + dd);
  f_at = subst(f_u, u, u_orig_test);
  \\ f_at = f_u((aa u + bb)/(cc u + dd)). Multiply by (cc u + dd)^4 to clear denoms:
  rhs = f_at * (cc*uu + dd)^4;
  print("  f_u sub vs Pred / (?) — checking ratio");
  \\ Just test numerically with u=0:
  pred0 = subst(Pred, u, 0);
  forig0 = subst(f_u, u, bb/dd);   \\ at u_new=0, u_orig = bb/dd
  if(dd != 0,
    if(forig0 != 0,
      ratio = pred0 / forig0;
      print("  ratio Pred(0)/f_u(bb/dd) = ", ratio, "  (should be ratio^?)");
    );
  );

  pts = hyperellratpoints(Pred, 10000);
  print("  ", length(pts), " hits");

  forstep(j=1, length(pts), 2,
    P = pts[j];
    uu_r = P[1]; yy_r = P[2];

    \\ u_orig = (aa*uu_r + bb)/(cc*uu_r + dd) (assuming standard Mobius)
    den_orig = cc*uu_r + dd;
    if(den_orig == 0,
      print("    P_red=", P, "  -> u_orig at infinity, skipping");
      next;
    );
    u_orig = (aa*uu_r + bb)/den_orig;

    z1v = subst(Z1u, u, u_orig);
    tv  = subst(Tu,  u, u_orig);
    if(tv == 0,
      \\ Point at infinity on E_Hm cover.
      print("    P_red=", P, "  -> t=0 (infinity?)");
      next;
    );
    x_val = d1*z1v^2/tv^2 + e1;
    rhs = (x_val - e1)*(x_val - e2)*(x_val - e3);
    \\ Check rhs is a (rational) square.
    if(rhs == 0,
      print("    P_red=", P, "  -> 2-torsion at x=", x_val);
      next;
    );
    \\ For rational sq: numerator * denominator must be a perfect square.
    num_r = numerator(rhs); den_r = denominator(rhs);
    if(!issquare(num_r * den_r),
      print("    P_red=", P, "  -> RHS NOT square: ", rhs);
      next;
    );
    y_val = sqrtint(num_r * den_r) / den_r;
    if(y_val^2 != rhs, y_val = -y_val);
    if(y_val^2 != rhs,
      \\ try -sqrt
      y_val = sqrtint(num_r * den_r);
      if(y_val^2 != num_r * den_r, print("  sqrt issue"); next);
      y_val = y_val / den_r;
    );

    PE = [x_val, y_val];
    ioc = ellisoncurve(E_Hm, PE);
    print("    P_red=", P, "  ->  x = ", x_val, ",  y = ", y_val, "  oncurve=", ioc);
    if(ioc,
      ord = ellorder(E_Hm, PE);
      print("      ellorder = ", ord);
      if(ord == 0,
        h = ellheight(E_Hm, PE);
        print("      *** NON-TORSION ***  canonical height = ", h);
      );
    );
  );
);
}

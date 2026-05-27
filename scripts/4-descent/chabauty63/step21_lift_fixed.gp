/* Step 21: Fixed lift — E_Hm with proper Weierstrass coeffs (not depressed). */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

S1 = e1+e2+e3;
S2 = e1*e2 + e1*e3 + e2*e3;
S3 = e1*e2*e3;
\\ y^2 = (x-e1)(x-e2)(x-e3) = x^3 - S1 x^2 + S2 x - S3
\\ Weierstrass: [a1,a2,a3,a4,a6] = [0, -S1, 0, S2, -S3]
E_Hm = ellinit([0, -S1, 0, S2, -S3]);
print("E_Hm tors order = ", elltors(E_Hm)[1]);
print("E_Hm tors structure = ", elltors(E_Hm)[2]);
print("E_Hm tors gens = ", elltors(E_Hm)[3]);

classes_hit = [[16549319, -16549319, -1], [3258398654, -1237211519, -26866], [10529681554, 3998112169, 26866]];

found_pts = [];
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
  Mob = CHV[2];
  aa = Mob[1,1]; bb = Mob[1,2]; cc = Mob[2,1]; dd = Mob[2,2];

  pts = hyperellratpoints(Pred, 10000);
  print("  ", length(pts), " hits in reduced model");

  forstep(j=1, length(pts), 2,
    P = pts[j];
    uu_r = P[1];

    den_orig = cc*uu_r + dd;
    if(den_orig == 0,
      print("    P_red=", P, " -> u_orig at infinity, lift via point at infinity");
      next;
    );
    u_orig = (aa*uu_r + bb)/den_orig;

    z1v = subst(Z1u, u, u_orig);
    tv  = subst(Tu,  u, u_orig);
    if(tv == 0,
      print("    P_red=", P, " -> tv=0");
      next;
    );
    x_val = d1*z1v^2/tv^2 + e1;
    rhs = (x_val - e1)*(x_val - e2)*(x_val - e3);
    if(rhs == 0,
      print("    P_red=", P, " -> 2-torsion at x = ", x_val);
      next;
    );
    num_r = numerator(rhs); den_r = denominator(rhs);
    if(!issquare(num_r * den_r),
      print("    P_red=", P, " -> RHS not square: ", rhs);
      next;
    );
    y_val = sqrtint(num_r * den_r) / den_r;

    PE = [x_val, y_val];
    ioc = ellisoncurve(E_Hm, PE);
    print("    P_red=", P, " -> [x, y] = [", x_val, ", ", y_val, "] oncurve=", ioc);
    if(ioc,
      ord = ellorder(E_Hm, PE);
      print("      ellorder = ", ord);
      if(ord == 0,
        h = ellheight(E_Hm, PE);
        print("      *** NON-TORSION ***  canonical height = ", h);
        found_pts = concat(found_pts, [[c, PE, h]]);
      );
    );
  );
);

print();
print("=== SUMMARY ===");
print("non-torsion points found: ", length(found_pts));
for(j=1, length(found_pts),
  print("  class ", found_pts[j][1]);
  print("  P = ", found_pts[j][2]);
  print("  h = ", found_pts[j][3]);
);
}

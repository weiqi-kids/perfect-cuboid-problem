/* Step 19: lift hits back to E_Hm and check non-torsion.
 * For each hit (u, y) in reduced poly Pred, we need to:
 *   1. Apply inverse change of variable from hyperellred to get (u0, y0) in original f_u.
 *   2. Use u0 in qfparam to get [z1, z2, t] on conic.
 *   3. Recover x = (d1 z1^2)/(t^2) + e1.
 *   4. y = sqrt((x-e1)(x-e2)(x-e3)).
 *   5. Check ellisoncurve and ellorder.
 */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

A4_d = e1*e2 + e1*e3 + e2*e3;
A6_d = -e1*e2*e3;
E_Hm = ellinit([0,0,0,A4_d,A6_d]);
print("E_Hm tors = ", elltors(E_Hm)[1], "  conductor = ", ellglobalred(E_Hm)[1]);

\\ Need the hyperellred change of variable. hyperellred has &M argument.
classes_hit = [[16549319, -16549319, -1], [3258398654, -1237211519, -26866], [10529681554, 3998112169, 26866]];
\\ Hits:
\\ class 12 [16549319,-16549319,-1]: (u,y) values include [0, 22924944], [1, 12751250], [-63/38, 861072975/19], [-38/63, ...]
\\ class 23 hits: [0,23718840], [3/2, ...], etc.
\\ class 27 hits: [1, 14563500], etc.

\\ Use a generic point lift. For each class, recompute Pred via hyperellred(&M)
\\ where M is the change of variable matrix.

for(kk=1, length(classes_hit),
  c = classes_hit[kk];
  d1 = c[1]; d2 = c[2]; d3 = c[3];
  print();
  print("=== class ", c, " ===");

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
  print("  Pred = ", Pred);
  print("  CHV = ", CHV);

  \\ Re-search for hits.
  pts = hyperellratpoints(Pred, 10000);
  print("  hits: ", length(pts), " points");

  \\ For each hit, lift.
  for(j=1, length(pts),
    P = pts[j];
    uu_r = P[1]; yy_r = P[2];
    \\ Apply inverse CHV: typically CHV is a 2x2 matrix [a,b;c,d] acting as u_orig = (a*u_r + b)/(c*u_r + d), scaling y by (cu+d)^2/det.
    \\ Hmm — PARI doc: hyperellred(C, {&m}); m is set to the change of variable. Check structure.
    print("    P_red = ", P);

    \\ Brute force: try u_orig = various combos, evaluate f_u(u_orig), check if = yy^2.
    \\ Easier path: just try u_orig in some range manually by scanning all rationals up to denom 10
    \\ with f_u(u_orig) being a square — but we already searched and found nothing!
    \\ So the only correct path is the CHV transformation.
    \\ CHV format in PARI: [M, c] where new poly = c * old_poly(M*[u;1]) (some convention)

    \\ Let's just look at the structure of CHV:
    \\ Document says: m is set to the matrix such that the change of variables is x = m[1,1]*x + m[1,2]/(m[2,1]*x+m[2,2])
    \\ or similar.

    \\ Try: CHV applied as Mobius transformation. If CHV = [a, b; c, d] (2x2), then u_orig = (a*uu_r + b)/(c*uu_r + d).
    if(matsize(CHV) == [2,2],
      a = CHV[1,1]; b = CHV[1,2]; cc = CHV[2,1]; dd = CHV[2,2];
      if(cc*uu_r + dd != 0,
        u_orig = (a*uu_r + b)/(cc*uu_r + dd);
        print("    u_orig = ", u_orig);

        \\ Evaluate Z1, T at u_orig.
        z1v = subst(Z1u, u, u_orig);
        tv  = subst(Tu,  u, u_orig);
        if(tv != 0,
          x_val = d1*z1v^2/tv^2 + e1;
          \\ y^2 = (x - e1)(x - e2)(x - e3) on E_Hm depressed.
          rhs = (x_val - e1)*(x_val - e2)*(x_val - e3);
          if(issquare(rhs),
            y_val = sqrtint(numerator(rhs)) / denominator(rhs)^(1/2);  \\ may fail for non-perfect
            y_val_safe = 0;
            iferr(y_val_safe = sqrt(rhs * 1.0), E, );
            \\ Better way: use exact sqrt via factorization.
            yv2 = numerator(rhs)*denominator(rhs);
            if(issquare(yv2),
              y_exact = sqrtint(yv2) / denominator(rhs);
              P_E = [x_val, y_exact];
              ioc = ellisoncurve(E_Hm, P_E);
              print("    x = ", x_val);
              print("    y = ", y_exact);
              print("    ellisoncurve = ", ioc);
              if(ioc,
                ord = ellorder(E_Hm, P_E);
                print("    ellorder = ", ord);
                if(ord == 0,
                  print("    *** NON-TORSION POINT ***");
                  h = ellheight(E_Hm, P_E);
                  print("    canonical height = ", h);
                );
              );
            ,
              print("    y^2*denom not perfect square: ", rhs);
            );
          ,
            print("    (x-e1)(x-e2)(x-e3) NOT a square at x = ", x_val);
          );
        );
      );
    );
  );
);
}

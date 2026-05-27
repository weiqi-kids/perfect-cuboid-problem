/* Step 22: Push remaining 28 classes (excluding torsion-image hits 12, 23, 27) to h=10^5. */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

S1 = e1+e2+e3;
S2 = e1*e2 + e1*e3 + e2*e3;
S3 = e1*e2*e3;
E_Hm = ellinit([0, -S1, 0, S2, -S3]);

classes = [
[1, 505, 505],
[19, 1, 19],
[19, 505, 9595],
[15549, -5183, -3],
[15549, -2617415, -1515],
[295431, -5183, -57],
[295431, -2617415, -28785],
[9579, 3193, 3],
[9579, 1612465, 1515],
[182001, 3193, 57],
[182001, 1612465, 28785],
[16549319, -16549319, -1],
[16549319, -8357406095, -505],
[314437061, -16549319, -19],
[314437061, -8357406095, -9595],
[500388546, 59570065, 210],
[500388546, 1203315313, 4242],
[9507382374, 59570065, 3990],
[9507382374, 1203315313, 80598],
[171494666, -61248095, -70],
[171494666, -1237211519, -1414],
[3258398654, -61248095, -1330],
[3258398654, -1237211519, -26866],
[554193766, 197926345, 70],
[554193766, 3998112169, 1414],
[10529681554, 197926345, 1330],
[10529681554, 3998112169, 26866],
[1709414574, -203501735, -210],
[1709414574, -4110735047, -4242],
[32478876906, -203501735, -3990],
[32478876906, -4110735047, -80598]
];

H_search = 100000;
for(kk = 1, length(classes),
  c = classes[kk];
  d1 = c[1]; d2 = c[2]; d3 = c[3];
  M1 = matdiagonal([d1, -d2, -C12]);
  P0 = qfsolve(M1);
  if(type(P0) != "t_COL",
    next;
  );
  PARAM = qfparam(M1, P0);
  Z1u = PARAM[1,1]*u^2 + PARAM[1,2]*u + PARAM[1,3];
  Tu  = PARAM[3,1]*u^2 + PARAM[3,2]*u + PARAM[3,3];
  Q_u = d1*Z1u^2 - C13*Tu^2;
  f_u = Q_u/d3;
  CHV = 0;
  Cred = hyperellred(f_u, &CHV);
  Pred = Cred[1];
  pts = hyperellratpoints(Pred, H_search);
  if(length(pts) > 0,
    \\ Lift first point and check order
    Mob = CHV[2];
    aa = Mob[1,1]; bb = Mob[1,2]; cc = Mob[2,1]; dd = Mob[2,2];
    P = pts[1];
    uu_r = P[1];
    den_orig = cc*uu_r + dd;
    if(den_orig != 0,
      u_orig = (aa*uu_r + bb)/den_orig;
      z1v = subst(Z1u, u, u_orig);
      tv  = subst(Tu,  u, u_orig);
      if(tv != 0,
        x_val = d1*z1v^2/tv^2 + e1;
        rhs = (x_val - e1)*(x_val - e2)*(x_val - e3);
        nontors = "?";
        if(rhs == 0,
          nontors = "2-tors";
        ,
          if(issquare(numerator(rhs)*denominator(rhs)),
            y_val = sqrtint(numerator(rhs)*denominator(rhs))/denominator(rhs);
            PE = [x_val, y_val];
            if(ellisoncurve(E_Hm, PE),
              ord = ellorder(E_Hm, PE);
              if(ord == 0,
                nontors = "**NONTORS!**";
              ,
                nontors = Str("tors-order-", ord);
              );
            );
          );
        );
        print("class ", kk, " ", c, " #hits=", length(pts), "  first lift -> ", nontors, "  P=", [x_val, y_val]);
      );
    );
  );
);
print("done");
}

/* Step 17: hyperellratpoints on reduced quartics up to h=10^6.
 * If point found, lift back through PARAM to get (x, y) on E_Hm. */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

A4_d = e1*e2 + e1*e3 + e2*e3;
A6_d = -e1*e2*e3;
E_Hm = ellinit([0,0,0,A4_d,A6_d]);

classes = [[15549, -5183, -3], [15549, -2617415, -1515], [295431, -5183, -57], [295431, -2617415, -28785], [9579, 3193, 3], [9579, 1612465, 1515], [182001, 3193, 57], [182001, 1612465, 28785]];

H_search = 1000000;

found_any = 0;
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
  Cred = hyperellred(f_u, &M);
  Pred = Cred[1];

  print();
  print("=== class ", kk, " = ", classes[kk], " ===");
  print("  reduced poly = ", Pred);
  t1 = getwalltime();
  pts = hyperellratpoints(Pred, H_search);
  t2 = getwalltime();
  print("  search h=", H_search, " in ", (t2-t1)/1000.0, "s — pts = ", pts);
  if(length(pts) > 0,
    found_any = 1;
    print("  *** HIT in class ", kk, "! ***");
    for(j=1, length(pts),
      uu_yy = pts[j];
      uu = uu_yy[1]; yy = uu_yy[2];
      print("    (u, y) = (", uu, ", ", yy, ")");
      \\ Need to back through hyperellred change of variable, then qfparam.
      \\ Skip lift for now — just record point.
    );
  );
);
print();
print("found_any = ", found_any);
}

/* Step 15: Deeper search on the reduced quartics — h up to 10^6. */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

classes = [[15549, -5183, -3], [15549, -2617415, -1515], [295431, -5183, -57], [295431, -2617415, -28785], [9579, 3193, 3], [9579, 1612465, 1515], [182001, 3193, 57], [182001, 1612465, 28785]];

reduced_polys = vector(length(classes));
param_data = vector(length(classes));

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
  reduced_polys[kk] = Cred;
  param_data[kk] = [PARAM, d1, d2, d3];
);

for(kk = 1, length(classes),
  print();
  print("=== class ", kk, " = ", classes[kk], " ===");
  Pred = reduced_polys[kk][1];
  print("  reduced poly = ", Pred);
  print("  searching h = 100000 ...");
  pts = hyperellratpoints(Pred, 100000);
  print("  pts = ", pts);
);
}

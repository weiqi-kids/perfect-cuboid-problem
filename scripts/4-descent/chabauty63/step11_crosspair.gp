/* Step 11: 2-descent on cross-paired Selmer classes for (63, 38). */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;

A4_d = e1*e2 + e1*e3 + e2*e3;
A6_d = -e1*e2*e3;
E_Hm = ellinit([0, 0, 0, A4_d, A6_d]);
print("E_Hm torsion = ", elltors(E_Hm)[1]);

print("e2 - e1 = ", e2 - e1, "  factor: ", factor(e2-e1));
print("e3 - e1 = ", e3 - e1, "  factor: ", factor(e3-e1));
print("e3 - e2 = ", e3 - e2, "  factor: ", factor(e3-e2));
print();

classes = [[15549, -5183, -3], [15549, -2617415, -1515], [295431, -5183, -57], [295431, -2617415, -28785], [9579, 3193, 3], [9579, 1612465, 1515], [182001, 3193, 57], [182001, 1612465, 28785]];

for(k=1, length(classes),
  c = classes[k];
  pp = c[1]*c[2]*c[3];
  print("class ", k, " = ", c, "  prod = ", pp, "  issquare = ", issquare(pp));
);

print();
print("=== qfsolve on conic d1*z1^2 - d2*z2^2 - (e2-e1)*t^2 = 0 ===");
C12 = e2 - e1;
for(k=1, length(classes),
  c = classes[k];
  d1 = c[1]; d2 = c[2]; d3 = c[3];
  M = matdiagonal([d1, -d2, -C12]);
  print();
  print("class ", k, " = ", c);
  sol = qfsolve(M);
  print("  qfsolve = ", sol);
  if(type(sol) == "t_COL",
    z1 = sol[1]; z2 = sol[2]; tt = sol[3];
    check = d1*z1^2 - d2*z2^2 - C12*tt^2;
    print("  verify = ", check);
    if(tt != 0,
      x_val = d1*z1^2/tt^2 + e1;
      print("  recovered x = ", x_val);
      val3 = (x_val - e3)/d3;
      print("  (x - e3)/d3 = ", val3, "  issquare = ", issquare(val3));
    , print("  t = 0, degenerate"));
  );
);
}

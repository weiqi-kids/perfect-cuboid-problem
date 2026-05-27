/* Step 8: 2-descent on the cross-paired Selmer classes for (63, 38).
 *
 * E_Hm:  y^2 = (x - e1)(x - e2)(x - e3)  with depressed
 *   e1 = -336819173555216, e2 = 148085289707295, e3 = 188733883847920.
 *
 * For each Selmer triple (d1, d2, d3) the 2-cover D is:
 *   d1 z1^2 = x - e1
 *   d2 z2^2 = x - e2
 *   d3 z3^2 = x - e3
 * with d1*d2*d3 a square mod (Q*)^2.
 *
 * Two-conic intersection: eliminate x.
 *   d1 z1^2 - d2 z2^2 = e2 - e1
 *   d1 z1^2 - d3 z3^2 = e3 - e1
 *
 * Use qfsolve on the first conic; parametrize; substitute into the second.
 */
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;

A4_d = e1*e2 + e1*e3 + e2*e3;
A6_d = -e1*e2*e3;
E_Hm = ellinit([0,0,0,A4_d,A6_d]);

\\ The candidate Selmer classes (cross-pair structural choices).
\\ d_i are taken mod squares; need d1*d2*d3 ≡ □.
\\ Verify each triple from selmer_63_38.txt:
classes = [
  [15549, -5183, -3],
  [15549, -2617415, -1515],
  [9579, 3193, 3],
  [9579, 1612465, 1515]
];

\\ Verify each is in the Selmer group: d1*d2*d3 = square.
for(k=1, length(classes),
  c = classes[k];
  prod = c[1]*c[2]*c[3];
  print("class ", k, " = ", c, "  d1*d2*d3 = ", prod, "  issquare = ", issquare(prod));
);

\\ For each class, solve conic d1*z1^2 - d2*z2^2 - (e2 - e1)*t^2 = 0 via qfsolve.
print();
print("=== qfsolve on each conic ===");
for(k=1, length(classes),
  c = classes[k];
  d1 = c[1]; d2 = c[2]; d3 = c[3];
  C12 = e2 - e1;   \\ d1 z1^2 - d2 z2^2 = C12 * t^2 (homogeneous)
  M = matdiagonal([d1, -d2, -C12]);
  print();
  print("class ", k, " = ", c);
  print("  M = diag(", d1, ", ", -d2, ", ", -C12, ")");
  sol = qfsolve(M);
  print("  qfsolve = ", sol);
  if(type(sol) == "t_COL",
    z1 = sol[1]; z2 = sol[2]; tt = sol[3];
    check = d1*z1^2 - d2*z2^2 - C12*tt^2;
    print("  verify: ", check);
  );
);

\\ Step 5: Compute ranks of the 5 elliptic factors of V_{q_0} for various q_0

\\ For q_0 = m/n with 1 + q_0^2 = (k/n)^2, i.e., n^2 + m^2 = k^2 (Pythag triple)

minimal_E(coef) = {
  my(E);
  E = ellinit(coef);
  return(ellminimalmodel(E));
};

\\ Compute the 5 elliptic factors for a given q_0
compute_factors(q0) = {
  my(A_ef, c2, c1, c0, f_quart, E_Hm_coef, res);
  A_ef = 1 + q0^2;
  res = vector(5);
  res[1] = minimal_E([0, -2*A_ef, 0, (1-q0^2)^2, 0]);
  res[2] = minimal_E([0, -2*(1+2*q0^2), 0, 1, 0]);
  res[3] = minimal_E([0, -2*(2+q0^2), 0, q0^4, 0]);
  c2 = 3 + 2*q0^2;
  c1 = 1 + 3*q0^2 + q0^4;
  c0 = q0^2 + q0^4;
  res[4] = minimal_E([0, c2, 0, c1, c0]);
  f_quart = X * (X + q0^2) * (X + 1) * (X + 1 + q0^2);
  E_Hm_coef = ellfromeqn(y^2 - f_quart);
  res[5] = minimal_E(ellinit(E_Hm_coef));
  return(res);
};

show_factor(E, label) = {
  my(r, T);
  print();
  print(label, ":");
  print("  Coefficients [a1,a2,a3,a4,a6]: ", [E.a1, E.a2, E.a3, E.a4, E.a6]);
  print("  Conductor: ", ellglobalred(E)[1]);
  print("  j-invariant: ", E.j);
  r = ellrank(E);
  print("  Rank: lower=", r[1], " upper=", r[2], " #generators_found=", #r[3]);
  T = elltors(E);
  print("  Torsion order: ", T[1], " structure: ", T[2]);
};

run_fiber(q0, descr) = {
  my(fact, labels);
  print("===================================================");
  print("FIBER q_0 = ", q0, " (", descr, ")");
  print("===================================================");
  fact = compute_factors(q0);
  labels = ["E_ef", "E_eg", "E_fg", "E_H+", "E_H-"];
  for(i = 1, 5, show_factor(fact[i], labels[i]));
};

run_fiber(4/3, "Pythag (3,4,5); 1+q_0^2 = 25/9");
print("\n\n");
run_fiber(12/5, "Pythag (5,12,13)");

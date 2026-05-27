\\ GAP3-C task 1: Verify the 5 known rank-3 fibers
default(parisize, 500000000);
print("=== GAP3-C: verify 5 known rank-3 fibers ===");
known_fibers = [[22,17], [35,22], [37,26], [40,29], [40,33]];
results = [];

work(m, n) = {
  my(a, b, d, q, E, emodel, Em, change, rk, dim_sel2, gens_minimal, gens_E, P, PE, x_P, y_P, den, c_val, F3, is_sq);
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, error("not primitive"));
  a = m^2 - n^2;
  b = 2*m*n;
  d = m^2 + n^2;
  q = a/b;
  print("\n--- (m,n) = (", m, ",", n, "), q = ", q, " = ", a, "/", b);
  print("  Pythagorean: a^2+b^2 = d^2? ", a^2+b^2 == d^2);
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E, &change);
  print("  conductor = ", ellglobalred(Em)[1]);
  print("  change [u,r,s,t] = ", change);
  print("  computing ellrank...");
  rk = ellrank(Em, 10);
  print("  ellrank result: lo=", rk[1], " up=", rk[2], " unprovenH=", rk[3], " #gens=", length(rk[4]));
  dim_sel2 = rk[2] + 2;
  print("  dim Sel_2 (upper bound) = ", dim_sel2);
  gens_minimal = rk[4];
  for(i=1, length(gens_minimal), my(Pl=gens_minimal[i]); if(!ellisoncurve(Em, Pl), error("Generator not on Emin!")); print("    gen[", i, "] on Emin = ", Pl));
  gens_E = [];
  for(i=1, length(gens_minimal), my(Pl=gens_minimal[i], PEl); PEl = ellchangepointinv(Pl, change); if(!ellisoncurve(E, PEl), error("inverse map failed")); gens_E = concat(gens_E, [PEl]));
  print("  generators on E: ", gens_E);
  print("  Face-3 chain:");
  for(i=1, length(gens_E), my(Pl=gens_E[i], x_Pl, y_Pl, denl, c_v, F3v, is_sqv); x_Pl = Pl[1]; y_Pl = Pl[2]; denl = q^2 - x_Pl^2; if(denl == 0, print("    gen[", i, "]: q^2 - x^2 = 0; skip"), c_v = 2*q*y_Pl/denl; F3v = c_v^2 + 1 + q^2; is_sqv = issquare(F3v); print("    gen[", i, "]: x=", x_Pl, " y=", y_Pl); print("       c = ", c_v); print("       F3 = ", F3v); print("       F3 square? ", is_sqv, if(is_sqv, "  ***FLAG POTENTIAL PCP***", ""))));
  results = concat(results, [[m, n, rk[1], rk[2], dim_sel2]]);
};

for(k=1, length(known_fibers), work(known_fibers[k][1], known_fibers[k][2]));

print("\n=== Summary ===");
print("(m,n) | rank_lo | rank_up | dim_Sel_2");
for(k=1, length(results), my(r=results[k]); print(r[1], "/", r[2], " | ", r[3], " | ", r[4], " | ", r[5]));
quit;

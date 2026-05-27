\\ Heegner-point search for generators on E_PCP for each BEYOND-QC fiber.
\\ For each (m,n) compute the integer model y^2 = x(x+u^2)(x+v^2) and call
\\ ellheegner. If that fails, try ellrank with effort 5.

default(parisize, 12000000000);
default(realprecision, 50);

make_E_PCP(mm, nn) = {
  my(uu, vv);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  return(ellinit([0, uu^2 + vv^2, 0, uu^2 * vv^2, 0]));
};

try_heegner(mm, nn) = {
  my(E, P, h, uu, vv);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  E = make_E_PCP(mm, nn);
  print("\n=========================================");
  print("Heegner search for (m,n)=(", mm, ",", nn, ")");
  print("  conductor = ", ellglobalred(E)[1]);
  print("  u = ", uu, ", v = ", vv);
  print("  Calling ellheegner ...");
  iferr(P = ellheegner(E); \
        print("    Heegner returned: ", P); \
        print("    onCurve = ", ellisoncurve(E, P)); \
        print("    order   = ", ellorder(E, P)); \
        if(ellorder(E, P) == 0, h = ellheight(E, P); print("    h_can = ", h)), \
        E1, print("    ellheegner failed: ", E1));
};

try_rank_effort(mm, nn) = {
  my(E, R);
  E = make_E_PCP(mm, nn);
  print("\n--- ellrank effort 5 for (", mm, ",", nn, ") ---");
  iferr(R = ellrank(E, 5); \
        print("  rank bounds: [", R[1], ", ", R[2], "]"); \
        print("  #gens found = ", #R[3]); \
        for(i = 1, #R[3], \
          print("    G_", i, " = ", R[3][i]); \
          print("      h = ", ellheight(E, R[3][i]))), \
        E1, print("  ellrank failed: ", E1));
};

print("=== Heegner / ellrank search on the 5 BEYOND-QC fibers ===");

try_heegner(61, 38);
try_heegner(63, 38);
try_heegner(73, 24);
try_heegner(88, 35);
try_heegner(99, 28);

print("\n=== ellrank effort 5 (fallback) ===");

try_rank_effort(61, 38);
try_rank_effort(63, 38);
try_rank_effort(73, 24);
try_rank_effort(88, 35);
try_rank_effort(99, 28);

print("\n=== DONE ===");
quit;

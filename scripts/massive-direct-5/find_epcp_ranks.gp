\\ Find rank and generators of E_PCP(q) for each BEYOND-QC fiber
\\ E_PCP(q): Y^2 = X(X+1)(X+q^2)
\\ Integer model: Y^2 = X(X+u^2)(X+v^2), u=2mn, v=m^2-n^2

default(parisize, 8000000000);
default(realprecision, 38);

process_fiber(mm, nn) =
{
  local(uu, vv, E0, EE, r, P, h, j);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  E0 = ellinit([0, uu^2+vv^2, 0, uu^2*vv^2, 0]);
  EE = ellminimalmodel(E0);
  print("--- (m,n) = (", mm, ",", nn, ") ---");
  print("  q = ", vv, "/", uu);
  print("  Integer model y^2 = x(x+", uu^2, ")(x+", vv^2, ")");
  print("  Minimal model [a1,a2,a3,a4,a6] = ", [EE.a1, EE.a2, EE.a3, EE.a4, EE.a6]);
  print("  Conductor: ", ellglobalred(EE)[1]);
  print("  Torsion: ", elltors(EE)[1]);
  r = ellrank(EE, 4);
  print("  rank in [", r[1], ", ", r[2], "]");
  print("  #generators found: ", #r[3]);
  for(j=1, #r[3], P = r[3][j]; h = ellheight(EE, P); print("    gen[", j, "] height=", h, " P=", P));
  print("");
  return([mm, nn, EE, r]);
}

print("=== E_PCP(q) rank + generators for 5 BEYOND-QC fibers ===");
print("");

process_fiber(61, 38);
process_fiber(63, 38);
process_fiber(73, 24);
process_fiber(88, 35);
process_fiber(99, 28);

print("=== DONE ===");
quit;

\\ Find generators of E_PCP(q) with more effort

default(parisize, 12000000000);
default(realprecision, 38);

process_fiber(mm, nn, eff) =
{
  local(uu, vv, E0, EE, r, P, h, j);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  E0 = ellinit([0, uu^2+vv^2, 0, uu^2*vv^2, 0]);
  EE = ellminimalmodel(E0);
  print("--- (m,n) = (", mm, ",", nn, ") effort=", eff, " ---");
  r = ellrank(EE, eff);
  print("  rank in [", r[1], ", ", r[2], "], #gens=", #r[3]);
  for(j=1, #r[3], P = r[3][j]; h = ellheight(EE, P); print("    gen[", j, "] h=", h, " P=", P));
  print("");
  return(r);
}

print("=== Effort 5 search ===");
process_fiber(61, 38, 5);
process_fiber(63, 38, 5);
process_fiber(73, 24, 5);
process_fiber(88, 35, 5);
process_fiber(99, 28, 5);

print("=== DONE ===");
quit;

\\ Try ellrank with effort 6, and bigger direct search

default(parisize, 14000000000);
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
  for(j=1, #r[3], P = r[3][j]; h = ellheight(EE, P); print("    gen[", j, "] h=", h));
  print("");
  return(r);
}

print("=== Effort 6 search ===");
process_fiber(61, 38, 6);

print("=== DONE ===");
quit;

\\ Check rank of each isogenous curve in the 2-isogeny class. Rank is isogeny invariant,
\\ but ellrank may resolve easier on a different model with smaller torsion / coefficients.

default(parisize, 1500000000);

m = 217; n = 24;
q = (m^2 - n^2) / (2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E, &change);

iso = ellisomat(Em, 0, 1);
print("Number of isogenous curves: ", #iso[1]);
print("Degrees: ", iso[2][1,]);
print("");

for(i=1, #iso[1],
   my(Ei, T, gr);
   Ei = ellinit(iso[1][i]);
   T = elltors(Ei);
   gr = ellglobalred(Ei);
   print("--- Curve E_", i, " ---");
   print("  coefficients: ", iso[1][i]);
   print("  torsion: order=", T[1], " struct=", T[2]);
   print("  conductor: ", gr[1]);
   print("  log10 |disc|: ", log(abs(Ei.disc))/log(10.0));
   print("  Δ-factor 2-adic val: ", valuation(Ei.disc, 2));
   print("");
);

\\ Now try ellrank on each isogenous curve at low effort to see if any resolves the gap
print("=== Quick ellrank survey on each isogenous curve (effort=3) ===");
for(i=1, #iso[1],
   my(Ei, t0, rk);
   Ei = ellinit(iso[1][i]);
   t0 = getwalltime();
   rk = ellrank(Ei, 3);
   print("E_", i, ": rank=[", rk[1], ",", rk[2], "] unprov=", rk[3], " #gens=", #rk[4], " time=", (getwalltime()-t0)/1000.0, "s");
);

quit;

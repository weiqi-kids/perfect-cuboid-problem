default(parisize, 1500000000);

q = 46513/10416;
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Emin = ellminimalmodel(E);
print("=== E_PCP(46513/10416) ===");
print("E minimal model = ", Emin[:5]);
print("Conductor = ", ellglobalred(Emin)[1]);

\\ Test 1: isogeny class — try ellrank on each isogenous curve
print();
print("=== Isogeny class ===");
iso = ellisomat(Emin, 0, 1);
print("Number of isogenous curves: ", length(iso[1]));
print("Isogeny degree matrix: ", iso[3]);

{
for(i=1, length(iso[1]),
  my(Ei, gri, Ndisc);
  Ei = ellinit(iso[1][i]);
  gri = ellglobalred(Ei);
  Ndisc = abs(Ei.disc);
  print();
  print("--- E_", i, " ---");
  print("  coeffs = ", iso[1][i]);
  print("  N = ", gri[1]);
  print("  log10 |Delta| = ", log(Ndisc*1.0)/log(10));
  print("  torsion = ", elltors(Ei)[1]);
);
}

\\ Test 2: try ellrank on smallest-conductor isogenous curve (likely easiest)
print();
print("=== ellrank survey on isogenous curves (effort=4) ===");
{
for(i=1, length(iso[1]),
  my(Ei, rk);
  Ei = ellinit(iso[1][i]);
  print("E_", i, ":");
  rk = ellrank(Ei, 4);
  print("  ellrank=[", rk[1], ",", rk[2], "] generators_found=", length(rk[4]));
);
}

quit;

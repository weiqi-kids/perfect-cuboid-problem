\\ Push the 3 GAP_2_4 cases at higher effort + isogeny class
default(parisize, 1200000000);

CANDS = [[487, 158], [1021, 540], [1037, 958]];

{
for(k=1, length(CANDS),
  my(p = CANDS[k], m = p[1], n = p[2]);
  print();
  print("=== (", m, ",", n, ") ===");
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E));

  my(t0 = getwalltime());
  my(rk8 = ellrank(Emin, 8));
  print("  effort 8: [", rk8[1], ",", rk8[2], "] gens=", length(rk8[4]), " t=", (getwalltime()-t0)/1000.0, "s");

  if(rk8[1] == rk8[2],
    print("  RESOLVED at rank ", rk8[1]);
    next;
  );

  \\ Walk isogeny class
  print("  Walking isogeny class...");
  my(iso = ellisomat(Emin, 0, 1));
  print("  # of isogenous curves: ", length(iso[1]));
  for(j=2, length(iso[1]),
    my(Ej = ellinit(iso[1][j]));
    my(rj = ellrank(Ej, 6));
    print("    iso[", j, "]: [", rj[1], ",", rj[2], "]");
    if(rj[1] == rj[2],
      print("  RESOLVED via iso[", j, "] at rank ", rj[1]);
      break;
    );
  );

  \\ If still ambiguous, push effort 10
  if(rk8[1] < rk8[2],
    t0 = getwalltime();
    my(rk10 = ellrank(Emin, 10));
    print("  effort 10: [", rk10[1], ",", rk10[2], "] gens=", length(rk10[4]), " t=", (getwalltime()-t0)/1000.0, "s");
  );
);
}
quit;

\\ Resolve remaining GAP_2_4 cases via isogeny class walk + effort 10
default(parisize, 1200000000);

\\ Already resolved: (487, 158) → rank 2
\\ Pending: (1021, 540), (1037, 958), (1082, 865), (1096, 59), (662, 409)
CANDS = [[1021, 540], [1037, 958], [1082, 865], [1096, 59], [662, 409]];

{
for(k=1, length(CANDS),
  my(p = CANDS[k], m = p[1], n = p[2]);
  print();
  print("=== (", m, ",", n, ") ===");
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E));
  print("Root number: ", ellrootno(Emin));

  my(iso = ellisomat(Emin, 0, 1));
  print("# isogenous: ", length(iso[1]));

  my(resolved = 0);
  for(j=1, length(iso[1]),
    my(Ej = ellinit(iso[1][j]));
    my(t0 = getwalltime());
    my(rj = ellrank(Ej, 8));
    my(t = (getwalltime()-t0)/1000.0);
    print("  iso[", j, "]: [", rj[1], ",", rj[2], "] gens=", length(rj[4]), " t=", t, "s");
    if(rj[1] == rj[2],
      print("  RESOLVED: rank = ", rj[1]);
      resolved = 1;
      break;
    );
  );
  if(!resolved,
    print("  Still undetermined after iso walk at effort 8");
    my(rk12 = ellrank(Emin, 12));
    print("  effort 12: [", rk12[1], ",", rk12[2], "] gens=", length(rk12[4]));
  );
);
}
quit;

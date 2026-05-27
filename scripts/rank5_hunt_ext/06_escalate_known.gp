\\ Escalate verified rank-4 candidates from current survivor lists
\\ Each: run ellrank at effort 6 and 10, compute Face-3 for all generators
default(parisize, 1200000000);

\\ Known rank-4 candidates so far (de-duplicated)
HITS = [[421, 344], [454, 131], [488, 293], [1012, 223], [1012, 301], [1017, 512], [1021, 328]];

OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/escalate_known.txt";
FLAGFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/rank5_flagged_ext.txt";
F3FILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/face3_results.txt";

write(OUTFILE, "# m n e6_lo e6_up gens e10_lo e10_up det_H verdict logN omegaN");
write(FLAGFILE, "# m n final_lo final_up verdict (rank5 candidates)");
write(F3FILE, "# m n gen_i F3 issquare");

n_rk4 = 0; n_rk5 = 0; n_amb = 0; total_F3_sq = 0;

{
for(k=1, length(HITS),
  my(p = HITS[k], m = p[1], n = p[2]);
  print();
  print("=== (", m, ",", n, ") ===");
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(chv = 0);
  my(Emin = ellminimalmodel(E, &chv));
  my(N = ellglobalred(Emin)[1]);
  my(omegaN = omega(N));
  my(logN = log(N*1.0)/log(10));
  print("  log10(N)=", logN, " omega(N)=", omegaN);

  my(t0 = getwalltime());
  my(rk6 = ellrank(Emin, 6));
  my(t6 = (getwalltime()-t0)/1000.0);
  print("  effort 6: [", rk6[1], ",", rk6[2], "] gens=", length(rk6[4]), " t=", t6, "s");

  my(rk_use = rk6);
  my(t10 = 0);
  if(rk6[1] < rk6[2] || rk6[2] >= 5,
    t0 = getwalltime();
    my(rk10 = ellrank(Emin, 10));
    t10 = (getwalltime()-t0)/1000.0;
    print("  effort 10: [", rk10[1], ",", rk10[2], "] gens=", length(rk10[4]), " t=", t10, "s");
    rk_use = rk10;
  );

  my(lo = rk_use[1], up = rk_use[2], gens = rk_use[4]);
  my(num_g = length(gens));

  my(det_H = 0);
  if(num_g >= 2,
    my(H = matrix(num_g, num_g, i, j, ellheight(Emin, gens[i], gens[j])));
    det_H = matdet(H);
    print("  H matrix:");
    for(i=1, num_g, print("    ", H[i,]));
    print("  det H = ", det_H);
  );

  my(verdict);
  if(lo == up,
    verdict = Str("RANK", lo, "_PROVEN");
    if(lo == 4, n_rk4 = n_rk4 + 1);
    if(lo == 5, n_rk5 = n_rk5 + 1; write(FLAGFILE, m, " ", n, " ", lo, " ", up, " ", verdict));
  ,
    if(up >= 5, verdict = Str("GAP_", lo, "_", up, "_AMBIG5"); n_amb = n_amb + 1,
                verdict = Str("GAP_", lo, "_", up));
  );
  write(OUTFILE, m, " ", n, " ", rk6[1], " ", rk6[2], " ", num_g, " ", lo, " ", up, " ", det_H, " ", verdict, " ", logN, " ", omegaN);
  print("  VERDICT: ", verdict);

  \\ Face-3 chain on each generator: pull back to E_PCP, compute F3
  if(lo >= 4,
    print("  --- Face-3 check ---");
    for(i=1, num_g,
      my(P = gens[i]);
      my(PE = ellchangepointinv(P, chv));
      if(!ellisoncurve(E, PE),
        print("    G", i, ": pullback failed!");
        next);
      my(x = PE[1], y = PE[2]);
      my(c = 2*q*y/(q^2 - x^2));
      my(F3 = c^2 + 1 + q^2);
      my(sq = issquare(F3));
      write(F3FILE, m, " ", n, " ", i, " ", F3, " ", sq);
      print("    G", i, " on E_PCP: x=", x);
      print("      F3=", F3);
      print("      issquare(F3) = ", sq);
      if(sq, total_F3_sq = total_F3_sq + 1; print("      *** PCP CANDIDATE FROM (", m, ",", n, ") G", i, " ***"));
    );
  );
);
}

print();
print("=== SUMMARY ===");
print("Rank-4 proven: ", n_rk4);
print("Rank-5 proven: ", n_rk5);
print("Ambig5: ", n_amb);
print("Total F3 squares: ", total_F3_sq, " / generators tested");
quit;

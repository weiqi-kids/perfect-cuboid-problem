\\ Rank-5 hunt — Stage 2: escalate promising candidates
\\ Run ellrank(E, 6) on each survivor. If lo >= 5 -> RANK5 candidate.
\\ Also try Q-isogenous curves (cf. 217-24 trick).
default(parisize, 1500000000);

INFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/main_hunt_survivors.txt";
OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/escalated.txt";
FLAGFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/rank5_flagged.txt";

load(fname) = {
  my(L = List(), s = readstr(fname));
  for(i=1, #s,
    my(line = s[i]);
    if(#line == 0, next);
    my(v = Vecsmall(line));
    if(#v > 0 && v[1] == 35, next);
    my(parts = strsplit(line, " "));
    if(#parts < 2, next);
    listput(L, [eval(parts[1]), eval(parts[2])]);
  );
  return(L);
};

write(OUTFILE, "# m n lo_e6 up_e6 gens_e6 isog_lo isog_up isog_gens isog_idx t_total verdict");
write(FLAGFILE, "# m n lo up gens VERDICT");

\\ Try ellrank(E, effort=6) directly; if gap remains, walk the isogeny class.
escalate(m, n) = {
  my(q, E, Emin, t0, rk6, t_e6, iso, best_lo, best_up, best_gens, best_idx, verdict);
  q = (m^2 - n^2)/(2*m*n);
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);

  t0 = getwalltime();
  rk6 = ellrank(Emin, 6);
  t_e6 = (getwalltime() - t0)/1000.0;
  best_lo = rk6[1]; best_up = rk6[2]; best_gens = #rk6[4]; best_idx = 0;

  \\ If still ambiguous and upper >= 5, walk isogeny class
  if((best_lo < best_up) && (best_up >= 5),
    iso = ellisomat(Emin, 0, 1);
    for(k=2, #iso[1],
      my(Ek = ellinit(iso[1][k]), rkk);
      rkk = ellrank(Ek, 6);
      if((rkk[1] > best_lo) || (rkk[1] == rkk[2] && best_lo < best_up),
        best_lo = rkk[1]; best_up = rkk[2]; best_gens = #rkk[4]; best_idx = k;
        \\ If we've certified the rank, stop
        if(best_lo == best_up, break);
      );
    );
  );

  \\ Verdict logic
  if(best_lo == best_up,
    verdict = Str("RANK", best_lo, "_PROVEN")
  ,
    if(best_up >= 5,
      verdict = Str("GAP_", best_lo, "_", best_up, "_AMBIG5")
    ,
      verdict = Str("GAP_", best_lo, "_", best_up)
    )
  );

  return([best_lo, best_up, best_gens, best_idx, t_e6, verdict]);
};

S = load(INFILE);
print("Loaded ", #S, " promising candidates");

global_t0 = getwalltime();
n_rank5 = 0; n_ambig5 = 0; n_rank4 = 0; n_lower = 0;

{
for(k=1, #S,
  my(p = S[k], m = p[1], n = p[2], r);
  r = escalate(m, n);
  my(lo = r[1], up = r[2], gens = r[3], idx = r[4], t6 = r[5], v = r[6]);
  write(OUTFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", idx, " ", t6, " ", v);
  print("(", m, ",", n, "): ", v, " lo=", lo, " up=", up, " gens=", gens, " isog_idx=", idx, " t=", t6, "s");
  if(lo >= 5,
    n_rank5 = n_rank5 + 1;
    write(FLAGFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", v);
    print("  *** RANK5 FLAG ***");
    ,
    if(up >= 5 && lo < 5,
      n_ambig5 = n_ambig5 + 1;
      write(FLAGFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", v);
      ,
      if(lo == 4 && up == 4, n_rank4 = n_rank4 + 1, n_lower = n_lower + 1);
    );
  );
  if(k % 10 == 0,
    print("  --- progress: ", k, "/", #S, " elapsed=", (getwalltime()-global_t0)/1000.0, "s ---");
  );
);
}

print();
print("=== ESCALATION SUMMARY ===");
print("Total promising: ", #S);
print("Rank-5 proven: ", n_rank5);
print("Ambig5 (gap with upper>=5): ", n_ambig5);
print("Rank-4 proven: ", n_rank4);
print("Lower (rank <= 3 confirmed): ", n_lower);
print("Total time: ", (getwalltime() - global_t0)/1000.0, "s");
quit;

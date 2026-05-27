\\ Escalate all ambiguous cases: up >= 4 with gap, or up >= 5
\\ Read from current hunt files (both gapfill and ext)
default(parisize, 1200000000);

INFILES = ["/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/gapfill_hunt.txt", "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/ext_hunt.txt"];
OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/escalate_amb.txt";
FLAGFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/rank5_flagged_ext.txt";

\\ Load (m, n, lo, up) for entries with (up - lo >= 2) OR up >= 5
load_amb(fname) = {
  my(L = List(), s = readstr(fname));
  for(i=1, length(s),
    my(line = s[i]);
    if(length(line) == 0, next);
    my(v = Vecsmall(line));
    if(length(v) > 0 && v[1] == 35, next);
    my(parts = strsplit(line, " "));
    if(length(parts) < 4, next);
    my(m = eval(parts[1]), n = eval(parts[2]), lo = eval(parts[3]), up = eval(parts[4]));
    \\ Escalate: up - lo >= 2 (ambig) AND up >= 3 (i.e. could be rank 3+)
    \\ OR lo >= 3 (rank 3+ already, may need escalation to push up=lo)
    if((up - lo >= 2 && up >= 3) || lo >= 4 || up >= 5,
      listput(L, [m, n, lo, up]);
    );
  );
  return(L);
};

write(OUTFILE, "# m n lo_orig up_orig lo_e6 up_e6 gens iso_lo iso_up t verdict");

\\ Dedupe (since hunt files have duplicates)
seen = Map();
all_cands = List();
{
for(fi=1, length(INFILES),
  my(S = load_amb(INFILES[fi]));
  for(k=1, length(S),
    my(p = S[k], m = p[1], n = p[2]);
    my(key = Str(m, "_", n));
    if(mapisdefined(seen, key), next);
    mapput(seen, key, 1);
    listput(all_cands, S[k]);
  );
);
}

print("Total unique ambiguous candidates: ", length(all_cands));

n_rk5 = 0; n_rk4 = 0; n_rk3 = 0; n_rk2 = 0; n_amb = 0; global_t0 = getwalltime();

{
for(k=1, length(all_cands),
  my(p = all_cands[k], m = p[1], n = p[2], lo_orig = p[3], up_orig = p[4]);
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E));
  my(t0 = getwalltime());
  my(rk6 = ellrank(Emin, 6));
  my(t = (getwalltime()-t0)/1000.0);
  my(lo = rk6[1], up = rk6[2], gens = length(rk6[4]));
  my(iso_idx = 0, iso_lo = lo, iso_up = up);
  if(lo < up && up >= 4,
    \\ Walk isogeny class
    my(iso = ellisomat(Emin, 0, 1));
    for(j=2, length(iso[1]),
      my(Ej = ellinit(iso[1][j]));
      my(rj = ellrank(Ej, 6));
      if(rj[1] > iso_lo,
        iso_lo = rj[1]; iso_up = rj[2]; iso_idx = j;
        if(iso_lo == iso_up, break);
      );
    );
  );
  my(final_lo = max(lo, iso_lo), final_up = min(up, iso_up));
  if(iso_idx > 0 && iso_lo == iso_up, final_lo = iso_lo; final_up = iso_up);
  my(verdict);
  if(final_lo == final_up,
    verdict = Str("RANK", final_lo, "_PROVEN");
    if(final_lo == 5, n_rk5 = n_rk5 + 1);
    if(final_lo == 4, n_rk4 = n_rk4 + 1);
    if(final_lo == 3, n_rk3 = n_rk3 + 1);
    if(final_lo == 2, n_rk2 = n_rk2 + 1);
  ,
    if(final_up >= 5, verdict = Str("AMBIG_", final_lo, "_", final_up); n_amb = n_amb + 1,
                     verdict = Str("GAP_", final_lo, "_", final_up));
  );
  write(OUTFILE, m, " ", n, " ", lo_orig, " ", up_orig, " ", lo, " ", up, " ", gens, " ", iso_lo, " ", iso_up, " ", t, " ", verdict);
  print("(", m, ",", n, ") orig=[", lo_orig, ",", up_orig, "] e6=[", lo, ",", up, "] -> ", verdict, " t=", t, "s");
  if(final_up >= 5,
    write(FLAGFILE, m, " ", n, " ", final_lo, " ", final_up, " ", verdict);
    print("  *** AMBIG5/RANK5 FLAG ***");
  );
);
}

print();
print("=== ESCALATION SUMMARY ===");
print("Rank-5 proven: ", n_rk5);
print("Rank-4 proven: ", n_rk4);
print("Rank-3 proven: ", n_rk3);
print("Rank-2 proven: ", n_rk2);
print("Ambig5: ", n_amb);
print("Total time: ", (getwalltime() - global_t0)/1000.0, "s");
quit;

\\ Re-run ellrank at effort 6 on all 36 lo>=3 candidates to check for rank >= 5 hidden
\\ Also escalate via isogeny class if gap appears
default(parisize, 1500000000);

INFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/rank3plus.txt";
OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/verify_rank3plus.txt";
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

write(OUTFILE, "# m n lo_e6 up_e6 gens isog_idx isog_lo isog_up isog_gens t_total verdict");
write(FLAGFILE, "# m n lo up gens VERDICT (from rank3plus escalation)");

S = load(INFILE);
print("Loaded ", #S, " candidates with lo>=3");

global_t0 = getwalltime();
n_rk5 = 0; n_amb5 = 0; n_rk4 = 0; n_rk3 = 0; n_other = 0;

{
for(k=1, #S,
  my(p = S[k], m = p[1], n = p[2]);
  my(q = (m^2-n^2)/(2*m*n), E = ellinit([0, 1+q^2, 0, q^2, 0]), Emin = ellminimalmodel(E));
  my(t0 = getwalltime(), rk6 = ellrank(Emin, 6), t6 = (getwalltime()-t0)/1000.0);
  my(lo = rk6[1], up = rk6[2], gens = #rk6[4]);
  my(iso_idx = 0, iso_lo = lo, iso_up = up, iso_gens = gens);
  if(lo < up && up >= 4,
    \\ Walk isogeny class
    my(iso = ellisomat(Emin, 0, 1));
    for(j=2, #iso[1],
      my(Ej = ellinit(iso[1][j]), rj);
      rj = ellrank(Ej, 6);
      if(rj[1] > iso_lo,
        iso_lo = rj[1]; iso_up = rj[2]; iso_gens = #rj[4]; iso_idx = j;
        if(iso_lo == iso_up, break);
      );
    );
  );
  my(final_lo = max(lo, iso_lo), final_up = min(up, iso_up));
  if(iso_idx > 0 && iso_lo == iso_up, final_lo = iso_lo; final_up = iso_up);
  my(verdict);
  if(final_lo == final_up,
    verdict = Str("RANK", final_lo, "_PROVEN");
    if(final_lo == 5, n_rk5 = n_rk5+1);
    if(final_lo == 4, n_rk4 = n_rk4+1);
    if(final_lo == 3, n_rk3 = n_rk3+1);
    if(final_lo != 3 && final_lo != 4 && final_lo != 5, n_other = n_other+1);
  ,
    if(final_up >= 5, verdict = Str("GAP_", final_lo, "_", final_up, "_AMBIG5"); n_amb5 = n_amb5+1,
                     verdict = Str("GAP_", final_lo, "_", final_up); n_other = n_other+1);
  );
  write(OUTFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", iso_idx, " ", iso_lo, " ", iso_up, " ", iso_gens, " ", t6, " ", verdict);
  print("(", m, ",", n, "): e6=[", lo, ",", up, "] gens=", gens, " isog=", iso_idx, "/[", iso_lo, ",", iso_up, "] -> ", verdict, " t=", t6, "s");
  if(final_lo >= 5,
    write(FLAGFILE, m, " ", n, " ", final_lo, " ", final_up, " ", iso_gens, " ", verdict);
    print("  *** RANK5 FLAG ***");
  );
  if(final_up >= 5 && final_lo < 5,
    write(FLAGFILE, m, " ", n, " ", final_lo, " ", final_up, " ", iso_gens, " ", verdict);
    print("  *** AMBIG5 ***");
  );
);
}

print();
print("=== ESCALATION TO EFFORT 6 SUMMARY ===");
print("Rank-5 proven: ", n_rk5);
print("Ambig5 (gap with upper>=5): ", n_amb5);
print("Rank-4 proven: ", n_rk4);
print("Rank-3 proven: ", n_rk3);
print("Other: ", n_other);
print("Total time: ", (getwalltime() - global_t0)/1000.0, "s");
quit;

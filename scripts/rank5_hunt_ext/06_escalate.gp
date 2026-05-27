\\ Escalation: for any lo >= 3 in main hunts, run ellrank at higher effort
\\ For lo >= 4, run at effort 6, then 10 if rank-5 candidate emerges
default(parisize, 1200000000);

\\ Read promising from both hunts, plus all lo>=3 from base output
INFILES = ["/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/gapfill_hunt.txt",
           "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/ext_hunt.txt"];
OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/escalate.txt";
FLAGFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/rank5_flagged_ext.txt";

\\ Load all lines with lo >= 3
load_promising(fname, threshold) = {
  my(L = List(), s = readstr(fname));
  for(i=1, length(s),
    my(line = s[i]);
    if(length(line) == 0, next);
    my(v = Vecsmall(line));
    if(length(v) > 0 && v[1] == 35, next);
    my(parts = strsplit(line, " "));
    if(length(parts) < 4, next);
    my(m = eval(parts[1]), n = eval(parts[2]), lo = eval(parts[3]), up = eval(parts[4]));
    if(lo >= threshold,
      listput(L, [m, n, lo, up]);
    );
  );
  return(L);
};

write(OUTFILE, "# m n lo_orig up_orig lo_e6 up_e6 gens iso_idx iso_lo iso_up t_total verdict");
write(FLAGFILE, "# m n final_lo final_up gens verdict");

global_t0 = getwalltime();
n_rk5 = 0; n_amb5 = 0; n_rk4 = 0; n_rk3 = 0; n_other = 0;

{
for(fi = 1, length(INFILES),
  my(S = load_promising(INFILES[fi], 3));
  print("Loaded ", length(S), " lo>=3 from ", INFILES[fi]);

  for(k=1, length(S),
    my(p = S[k], m = p[1], n = p[2], lo_orig = p[3], up_orig = p[4]);
    my(q = (m^2-n^2)/(2*m*n));
    my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
    my(Emin = ellminimalmodel(E));
    my(t0 = getwalltime());
    my(rk6 = ellrank(Emin, 6));
    my(t6 = (getwalltime()-t0)/1000.0);
    my(lo = rk6[1], up = rk6[2], gens = length(rk6[4]));
    my(iso_idx = 0, iso_lo = lo, iso_up = up);
    if(lo < up && up >= 4,
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
      if(final_lo == 5, n_rk5 = n_rk5+1);
      if(final_lo == 4, n_rk4 = n_rk4+1);
      if(final_lo == 3, n_rk3 = n_rk3+1);
      if(final_lo != 3 && final_lo != 4 && final_lo != 5, n_other = n_other+1);
    ,
      if(final_up >= 5, verdict = Str("GAP_", final_lo, "_", final_up, "_AMBIG5"); n_amb5 = n_amb5+1,
                       verdict = Str("GAP_", final_lo, "_", final_up); n_other = n_other+1);
    );
    write(OUTFILE, m, " ", n, " ", lo_orig, " ", up_orig, " ", lo, " ", up, " ", gens, " ", iso_idx, " ", iso_lo, " ", iso_up, " ", t6, " ", verdict);
    print("(", m, ",", n, ") orig=[", lo_orig, ",", up_orig, "] e6=[", lo, ",", up, "] -> ", verdict, " t=", t6, "s");
    if(final_lo >= 5 || final_up >= 5,
      write(FLAGFILE, m, " ", n, " ", final_lo, " ", final_up, " ", gens, " ", verdict);
      print("  *** RANK5 FLAG ***");
    );
  );
);
}

print();
print("=== ESCALATION DONE ===");
print("Rank-5 proven: ", n_rk5);
print("Ambig5: ", n_amb5);
print("Rank-4 proven: ", n_rk4);
print("Rank-3 proven: ", n_rk3);
print("Other: ", n_other);
print("Time: ", (getwalltime()-global_t0)/1000.0, "s");
quit;

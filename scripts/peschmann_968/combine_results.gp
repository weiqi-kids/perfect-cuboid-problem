\\ combine_results.gp
\\ Read enum_epcp + attack_rank0/1/2 outputs and produce a unified
\\ summary table.
\\
\\ Output: closure_summary.txt and hard_remainders.txt.

default(parisize, 500000000);

parse_lines(fn) = {
  my(out, lines, ln, pieces);
  out = List();
  lines = iferr(readstr(fn), ERR, []);
  for(i = 1, #lines,
    ln = lines[i];
    if(ln == "" || Vecsmall(ln)[1] == 35, next);
    pieces = strsplit(ln, " ");
    listput(out, pieces);
  );
  return(out);
};

{
\\ All rank-N pairs from enum
rank0 = parse_lines("epcp_rank0.txt");
rank1 = parse_lines("epcp_rank1.txt");
rank2 = parse_lines("epcp_rank2.txt");
rankhi = parse_lines("epcp_rankhi.txt");
ramb = parse_lines("epcp_rank_ambig.txt");
err_enum = parse_lines("epcp_errored.txt");

print("Enum totals:");
print("  rank 0   = ", #rank0);
print("  rank 1   = ", #rank1);
print("  rank 2   = ", #rank2);
print("  rank >=3 = ", #rankhi);
print("  rank ambig (lo<up): ", #ramb);
print("  errored  = ", #err_enum);
print("  total    = ", #rank0 + #rank1 + #rank2 + #rankhi + #ramb + #err_enum);

\\ Attack results
att0 = parse_lines("attack_rank0_results.txt");
att1 = parse_lines("attack_rank1_results.txt");
att1p2 = parse_lines("attack_rank1_pass2.txt");
att2 = parse_lines("attack_rank2_results.txt");

\\ Tally statuses
closed_r0 = 0; hit_r0 = 0;
for(i = 1, #att0,
  if(#att0[i] >= 6,
    if(att0[i][6] == "0", closed_r0 = closed_r0 + 1, hit_r0 = hit_r0 + 1);
  );
);

closed_r1 = 0; hit_r1 = 0; hard_r1 = 0;
for(i = 1, #att1,
  if(#att1[i] >= 4,
    s = att1[i][4];
    if(s == "CLOSED_RANK1", closed_r1 = closed_r1 + 1);
    if(s == "HIT_RANK1", hit_r1 = hit_r1 + 1);
    if(s != "CLOSED_RANK1" && s != "HIT_RANK1", hard_r1 = hard_r1 + 1);
  );
);
\\ Pass 2 closures (subtract from hard, add to closed)
closed_r1_p2 = 0; hit_r1_p2 = 0; persist_r1 = 0;
for(i = 1, #att1p2,
  if(#att1p2[i] >= 4,
    s = att1p2[i][4];
    if(s == "CLOSED_RANK1_PASS2", closed_r1_p2 = closed_r1_p2 + 1);
    if(s == "HIT_RANK1_PASS2", hit_r1_p2 = hit_r1_p2 + 1);
    if(s != "CLOSED_RANK1_PASS2" && s != "HIT_RANK1_PASS2",
       persist_r1 = persist_r1 + 1);
  );
);

closed_r2 = 0; hit_r2 = 0; hard_r2 = 0;
for(i = 1, #att2,
  if(#att2[i] >= 4,
    s = att2[i][4];
    if(s == "CLOSED_RANK2", closed_r2 = closed_r2 + 1);
    if(s == "HIT_RANK2", hit_r2 = hit_r2 + 1);
    if(s != "CLOSED_RANK2" && s != "HIT_RANK2", hard_r2 = hard_r2 + 1);
  );
);

total_pairs = #rank0 + #rank1 + #rank2 + #rankhi + #ramb + #err_enum;
total_closed = closed_r0 + closed_r1 + closed_r2 + closed_r1_p2;
total_hard = persist_r1 + hard_r2 + #rankhi + #ramb + #err_enum;
total_hits = hit_r0 + hit_r1 + hit_r2 + hit_r1_p2;

print("");
print("Attack tallies:");
print("  CLOSED_RANK0          : ", closed_r0);
print("  CLOSED_RANK1 (pass 1) : ", closed_r1);
print("  CLOSED_RANK1 (pass 2) : ", closed_r1_p2);
print("  CLOSED_RANK2          : ", closed_r2);
print("  HIT_RANK0             : ", hit_r0);
print("  HIT_RANK1             : ", hit_r1 + hit_r1_p2);
print("  HIT_RANK2             : ", hit_r2);
print("  HARD R1 (persist no gen): ", persist_r1);
print("  HARD R2 (no gen)        : ", hard_r2);
print("  HARD R>=3 (rank-3+)     : ", #rankhi);
print("  HARD rank-ambiguous     : ", #ramb);
print("  Enum errors             : ", #err_enum);
print("");
print("TOTAL CLOSED  : ", total_closed, " / ", total_pairs);
print("TOTAL HARD    : ", total_hard);
print("TOTAL HITS    : ", total_hits, " (PCP candidates -- should be 0)");

\\ Write hard_remainders.txt
write("hard_remainders.txt",
  "# m  n  reason   (HARD cases requiring quadratic Chabauty or further work)");
for(i = 1, #rankhi,
  p = rankhi[i];
  write("hard_remainders.txt", p[1], " ", p[2], " RANK_GEQ_3 (cond=", p[3], " lo=", p[4], " up=", p[5], ")");
);
for(i = 1, #ramb,
  p = ramb[i];
  write("hard_remainders.txt", p[1], " ", p[2], " RANK_AMBIG (lo=0 up=2; possible Sha)");
);
for(i = 1, #att1p2,
  if(#att1p2[i] >= 4,
    s = att1p2[i][4];
    if(s != "CLOSED_RANK1_PASS2" && s != "HIT_RANK1_PASS2",
      write("hard_remainders.txt", att1p2[i][1], " ", att1p2[i][2], " R1_HIGH_COND_NO_GEN");
    );
  );
);
for(i = 1, #att2,
  if(#att2[i] >= 4,
    s = att2[i][4];
    if(s != "CLOSED_RANK2" && s != "HIT_RANK2",
      write("hard_remainders.txt", att2[i][1], " ", att2[i][2], " R2_", s);
    );
  );
);
for(i = 1, #err_enum,
  write("hard_remainders.txt", err_enum[i][1], " ", err_enum[i][2], " ENUM_ERR");
);

\\ Write closure_summary.txt
write("closure_summary.txt", "PCP -- per-fiber closure on 2,040 master tuples");
write("closure_summary.txt", "");
write("closure_summary.txt", "Total pairs : ", total_pairs);
write("closure_summary.txt", "Total CLOSED: ", total_closed);
write("closure_summary.txt", "Total HARD  : ", total_hard);
write("closure_summary.txt", "Total HITS  : ", total_hits);
write("closure_summary.txt", "");
write("closure_summary.txt", "Breakdown:");
write("closure_summary.txt", "  rank 0 closed       : ", closed_r0, " / ", #rank0);
write("closure_summary.txt", "  rank 1 closed pass1 : ", closed_r1, " / ", #rank1);
write("closure_summary.txt", "  rank 1 closed pass2 : ", closed_r1_p2);
write("closure_summary.txt", "  rank 2 closed       : ", closed_r2, " / ", #rank2);
write("closure_summary.txt", "  rank >=3 (HARD)     : ", #rankhi);
write("closure_summary.txt", "  rank ambig (HARD)   : ", #ramb);
write("closure_summary.txt", "  rank 1 HARD (persist): ", persist_r1);
write("closure_summary.txt", "  rank 2 HARD          : ", hard_r2);
write("closure_summary.txt", "  enum errored         : ", #err_enum);
}

quit;

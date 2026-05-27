\\ attack_rank1_hard.gp
\\ Second pass on the 99 HARD_NO_GEN_R1_HIGHCOND cases from attack_rank1.gp.
\\ Use ellrank(_, 3) and ellrank(_, 4) with larger Mordell-Weil sieve.
\\ Each call may take up to a few minutes.

default(parisize, 4000000000);
default(timer, 0);
NMAX = 12;

face3_is_square(q, pt) = {
  my(X, Y, denom, c, a3, num, den);
  if(pt == [0], return(-1));
  X = pt[1];
  Y = pt[2];
  denom = q^2 - X^2;
  if(denom == 0, return(-2));
  c = 2 * Y * q / denom;
  if(c == 0, return(-3));
  a3 = c^2 + 1 + q^2;
  if(a3 == 0, return(0));
  num = numerator(a3);
  den = denominator(a3);
  return(issquare(num) * issquare(den));
};

direct_scan_rank1(E, P0, q, NMAX) = {
  my(nP, hits, sq);
  hits = List();
  nP = P0;
  for(n = 1, NMAX,
    sq = face3_is_square(q, nP);
    if(sq == 1, listput(hits, [n, nP]));
    if(sq == -2, break);
    if(n < NMAX, nP = elladd(E, nP, P0));
  );
  return(hits);
};

attack_hard_r1(mm, nn) = {
  my(q, E, Emin, v, gen_min, P0, hits, rk);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  \\ Try effort 3 (which uses more 2-descent search)
  rk = iferr(ellrank(Emin, 3), ERR, [-1, -1, 0, []]);
  if(rk[1] != 1 || #rk < 4 || #rk[4] < 1,
    rk = iferr(ellrank(Emin, 4), ERR, [-1, -1, 0, []]);
    if(rk[1] != 1 || #rk < 4 || #rk[4] < 1,
      return([mm, nn, q, "HARD_NO_GEN_R1_PERSIST", 0, 0]);
    );
  );
  gen_min = rk[4][1];
  P0 = ellchangepointinv(gen_min, v);
  if(!ellisoncurve(E, P0),
    return([mm, nn, q, "HARD_OFF_CURVE", 0, 0]);
  );
  hits = direct_scan_rank1(E, P0, q, NMAX);
  if(#hits == 0,
    return([mm, nn, q, "CLOSED_RANK1_PASS2", NMAX, 0]);
  ,
    return([mm, nn, q, "HIT_RANK1_PASS2", NMAX, #hits]);
  );
};

{
\\ Read HARD pairs from attack_rank1_results.txt
lines = readstr("attack_rank1_results.txt");
hard_pairs = List();
for(i = 1, #lines,
  ln = lines[i];
  if(ln == "" || Vecsmall(ln)[1] == 35, next);
  pieces = strsplit(ln, " ");
  if(#pieces >= 4 && strsplit(pieces[4], "_")[1] == "HARD",
    listput(hard_pairs, [eval(pieces[1]), eval(pieces[2])]);
  );
);
print("Loaded ", #hard_pairs, " HARD pairs for pass-2 attack.");

write("attack_rank1_pass2.txt", "# m  n  q  status  scan_window  n_hits");

closed_p2 = 0; hit_p2 = 0; persist_hard = 0;
for(i = 1, #hard_pairs,
  p = hard_pairs[i];
  res = iferr(attack_hard_r1(p[1], p[2]), ERR,
              [p[1], p[2], 0, "ERROR_PASS2", 0, 0]);
  status = res[4];
  if(status == "CLOSED_RANK1_PASS2", closed_p2 = closed_p2 + 1);
  if(status == "HIT_RANK1_PASS2", hit_p2 = hit_p2 + 1);
  if(strsplit(status, "_")[1] == "HARD", persist_hard = persist_hard + 1);
  write("attack_rank1_pass2.txt",
        res[1], " ", res[2], " ", res[3], " ", res[4], " ", res[5], " ", res[6]);
  if(i % 5 == 0,
    print("  pass2 attacked ", i, "/", #hard_pairs,
          " closed=", closed_p2, " hits=", hit_p2, " persist=", persist_hard);
  );
);
print("");
print("=== Rank-1 pass-2 summary ===");
print("Total HARD pairs       : ", #hard_pairs);
print("CLOSED_RANK1_PASS2     : ", closed_p2);
print("HIT_RANK1_PASS2        : ", hit_p2);
print("HARD_PERSIST           : ", persist_hard);
}

quit;

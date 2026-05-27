\\ attack_rank1.gp
\\ Read epcp_rank1.txt: all master tuples (m, n) with rk E_PCP(q) = 1.
\\ For each, find a generator P_0 (ellheegner / ellrank), pull back to the
\\ original E_PCP(q) model, run direct Face-3 check for n = 1..12.
\\
\\ If no a_n is a rational square (and 12 >= rigorous N_0), close.
\\ Outputs attack_rank1_results.txt and attack_rank1.log.

default(parisize, 3000000000);
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
  if(c == 0, return(-3));    \\ trivial / degenerate
  a3 = c^2 + 1 + q^2;
  if(a3 == 0, return(0));
  num = numerator(a3);
  den = denominator(a3);
  return(issquare(num) * issquare(den));
};

direct_scan_rank1(E, P0, q, NMAX) = {
  my(nP, hits, sq, scan_window);
  hits = List();
  scan_window = NMAX;
  nP = P0;
  for(n = 1, NMAX,
    sq = face3_is_square(q, nP);
    if(sq == 1, listput(hits, [n, nP]));
    if(sq == -2,
      scan_window = n - 1;
      break;
    );
    if(n < NMAX, nP = elladd(E, nP, P0));
  );
  return([hits, scan_window]);
};

attack_rank1(mm, nn) = {
  my(q, E, Emin, v, gen_min, P0, hits, scan_window, rk, cond);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  cond = ellglobalred(Emin)[1];
  \\ Use ellrank(_, 1) directly: ~10ms vs 5+ seconds for ellheegner.
  rk = iferr(ellrank(Emin, 1), ERR, [-1, -1, 0, []]);
  if(rk[1] != 1 || #rk < 4 || #rk[4] < 1,
    \\ Try effort 2 (slightly more); skip for very high conductor
    if(cond < 10^11,
      rk = iferr(ellrank(Emin, 2), ERR, [-1, -1, 0, []]);
    );
    if(rk[1] != 1 || #rk < 4 || #rk[4] < 1,
      \\ Final fallback: ellheegner only for small conductors (else mark HARD)
      if(cond < 10^9,
        gen_min = iferr(ellheegner(Emin), ERR, 0);
        if(gen_min == 0,
          return([mm, nn, q, "HARD_NO_GEN_R1", 0, 0]);
        );
      ,
        return([mm, nn, q, "HARD_NO_GEN_R1_HIGHCOND", 0, 0]);
      );
    ,
      gen_min = rk[4][1];
    );
  ,
    gen_min = rk[4][1];
  );
  P0 = ellchangepointinv(gen_min, v);
  if(!ellisoncurve(E, P0),
    return([mm, nn, q, "HARD_OFF_CURVE", 0, 0]);
  );
  scan_res = direct_scan_rank1(E, P0, q, NMAX);
  hits = scan_res[1];
  win = scan_res[2];
  if(#hits == 0,
    return([mm, nn, q, "CLOSED_RANK1", win, 0]);
  ,
    return([mm, nn, q, "HIT_RANK1", win, #hits]);
  );
};

{
lines = readstr("epcp_rank1.txt");
pairs = List();
for(i = 1, #lines,
  ln = lines[i];
  if(ln == "" || Vecsmall(ln)[1] == 35, next);
  pieces = strsplit(ln, " ");
  if(#pieces >= 2,
    mm = eval(pieces[1]);
    nn = eval(pieces[2]);
    listput(pairs, [mm, nn]);
  );
);
print("Loaded ", #pairs, " rank-1 candidate pairs from epcp_rank1.txt");

write("attack_rank1_results.txt",
  "# m  n  q  status  scan_window  n_hits");

closed = 0; hits_count = 0; hard = 0; err = 0;
for(i = 1, #pairs,
  p = pairs[i];
  mm = p[1]; nn = p[2];
  res = iferr(attack_rank1(mm, nn), ERR,
              [mm, nn, 0, "ERROR", 0, 0]);
  status = res[4];
  if(status == "CLOSED_RANK1", closed = closed + 1);
  if(status == "HIT_RANK1", hits_count = hits_count + 1);
  if(status == "ERROR", err = err + 1);
  if(status != "CLOSED_RANK1" && status != "HIT_RANK1" && status != "ERROR",
     hard = hard + 1);
  write("attack_rank1_results.txt",
        res[1], " ", res[2], " ", res[3], " ", res[4], " ", res[5], " ", res[6]);
  if(i % 25 == 0,
    print("  rank1 attacked ", i, "/", #pairs,
          " closed=", closed, " hits=", hits_count,
          " hard=", hard, " err=", err);
  );
);
print("");
print("=== Rank-1 attack summary ===");
print("Total rank-1 pairs : ", #pairs);
print("CLOSED_RANK1       : ", closed);
print("HIT_RANK1          : ", hits_count);
print("HARD (no gen, etc) : ", hard);
print("ERROR              : ", err);
}

quit;

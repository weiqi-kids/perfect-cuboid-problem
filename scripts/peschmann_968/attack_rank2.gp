\\ attack_rank2.gp
\\ Read epcp_rank2.txt: all master tuples (m, n) with rk E_PCP(q) = 2.
\\ For each, find generators G_1, G_2 via ellrank, scan box |a|,|b| <= 8.
\\
\\ Outputs attack_rank2_results.txt.

default(parisize, 3500000000);
default(timer, 0);
NBOX = 8;

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

direct_scan_rank2(E, G1, G2, q, NBOX) = {
  my(hits, R, aG, bG, sq);
  hits = List();
  for(a = -NBOX, NBOX,
    if(a == 0, aG = [0], aG = ellmul(E, G1, a));
    for(b = -NBOX, NBOX,
      if(a == 0 && b == 0, next);
      if(b == 0, bG = [0], bG = ellmul(E, G2, b));
      if(aG == [0], R = bG,
         if(bG == [0], R = aG,
            R = elladd(E, aG, bG)));
      if(R == [0], next);
      sq = face3_is_square(q, R);
      if(sq == 1, listput(hits, [a, b]));
    );
  );
  return(hits);
};

attack_rank2(mm, nn) = {
  my(q, E, Emin, v, rk, G1m, G2m, G1, G2, hits);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  rk = iferr(ellrank(Emin, 4), ERR, [-1, -1, []]);
  \\ ellrank returns [r_lo, r_up, sha_bound, [g1, g2, ...]]; gens are rk[4].
  if(rk[1] < 2 || #rk < 4 || #rk[4] < 2,
    return([mm, nn, q, "HARD_RANK2_NO_GENS", 0, 0]);
  );
  G1m = rk[4][1];
  G2m = rk[4][2];
  G1 = ellchangepointinv(G1m, v);
  G2 = ellchangepointinv(G2m, v);
  if(!ellisoncurve(E, G1) || !ellisoncurve(E, G2),
    return([mm, nn, q, "HARD_OFF_CURVE_R2", 0, 0]);
  );
  hits = direct_scan_rank2(E, G1, G2, q, NBOX);
  if(#hits == 0,
    return([mm, nn, q, "CLOSED_RANK2", NBOX, 0]);
  ,
    return([mm, nn, q, "HIT_RANK2", NBOX, #hits]);
  );
};

{
lines = readstr("epcp_rank2.txt");
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
print("Loaded ", #pairs, " rank-2 candidate pairs.");

write("attack_rank2_results.txt", "# m  n  q  status  box_size  n_hits");

closed = 0; hits_count = 0; hard = 0; err = 0;
for(i = 1, #pairs,
  p = pairs[i];
  mm = p[1]; nn = p[2];
  res = iferr(attack_rank2(mm, nn), ERR,
              [mm, nn, 0, "ERROR", 0, 0]);
  status = res[4];
  if(status == "CLOSED_RANK2", closed = closed + 1);
  if(status == "HIT_RANK2", hits_count = hits_count + 1);
  if(status == "ERROR", err = err + 1);
  if(status != "CLOSED_RANK2" && status != "HIT_RANK2" && status != "ERROR",
     hard = hard + 1);
  write("attack_rank2_results.txt",
        res[1], " ", res[2], " ", res[3], " ", res[4], " ", res[5], " ", res[6]);
  if(i % 10 == 0,
    print("  rank2 attacked ", i, "/", #pairs,
          " closed=", closed, " hits=", hits_count,
          " hard=", hard, " err=", err);
  );
);
print("");
print("=== Rank-2 attack summary ===");
print("Total rank-2 pairs    : ", #pairs);
print("CLOSED_RANK2          : ", closed);
print("HIT_RANK2             : ", hits_count);
print("HARD                  : ", hard);
print("ERROR                 : ", err);
}

quit;

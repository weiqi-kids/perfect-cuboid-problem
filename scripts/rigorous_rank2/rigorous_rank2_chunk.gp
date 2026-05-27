\\ rigorous_rank2_chunk.gp
\\ Run rigorous full-box scan over a range [START_IDX, END_IDX] of pairs in
\\ ../peschmann_968/epcp_rank2.txt. Pass START_IDX, END_IDX, OUT_SUFFIX as
\\ command-line args (set before reading this script via -p or by reading
\\ environment / file rigorous_chunk_params.txt).
\\
\\ Theory: Silverman 1988 + Ingram-Silverman 2009 (translated orbits)
\\ See SILVERMAN-RANK-JUMP-CLOSURE.md §7.

default(parisize, 1000000000);
default(realprecision, 38);
default(timer, 0);

face3_is_square(q, pt) =
{
  if(pt == [0], return(-1));
  my(X = pt[1], Y = pt[2]);
  my(denom = q^2 - X^2);
  if(denom == 0, return(-2));
  my(c = 2 * Y * q / denom);
  if(c == 0, return(-3));
  my(a3 = c^2 + 1 + q^2);
  if(a3 == 0, return(0));
  my(num = numerator(a3), den = denominator(a3));
  if(sign(num) != 1, return(0));
  issquare(num) * issquare(den);
}

scan_box(E, G1, G2, q, B) =
{
  my(cnt_sq = 0, hits = List());
  for(av = -B, B,
    my(aG = if(av == 0, [0], ellmul(E, G1, av)));
    for(bv = -B, B,
      if(av == 0 && bv == 0, next);
      my(bG = if(bv == 0, [0], ellmul(E, G2, bv)));
      my(R = if(aG == [0], bG, if(bG == [0], aG, elladd(E, aG, bG))));
      if(R == [0], next);
      my(sq = face3_is_square(q, R));
      if(sq == 1,
        cnt_sq = cnt_sq + 1;
        listput(hits, [av, bv]);
      );
    );
  );
  [cnt_sq, hits];
}

find_two_gens(Emin) =
{
  my(rkdata);
  rkdata = iferr(ellrank(Emin, 4), ERR, [-1, -1, 0, []]);
  if(#rkdata >= 4 && #rkdata[4] >= 2, return(rkdata[4]));
  rkdata = iferr(ellrank(Emin, 5), ERR, [-1, -1, 0, []]);
  if(#rkdata >= 4 && #rkdata[4] >= 2, return(rkdata[4]));
  if(#rkdata >= 4, return(rkdata[4]));
  [];
}

process_fiber(mm, nn) =
{
  my(q = (mm^2 - nn^2) / (2 * mm * nn));
  my(E = ellinit([0, 1 + q^2, 0, q^2, 0]));
  my(v, Emin = ellminimalmodel(E, &v));
  my(NE = ellglobalred(Emin)[1]);

  my(gens = find_two_gens(Emin));
  if(#gens < 2,
    return([mm, nn, q, NE, "HARD_NO_GENS", 0, 0.0, 0.0, 0, #gens]);
  );

  my(G1m = gens[1], G2m = gens[2]);
  my(G1 = ellchangepointinv(G1m, v), G2 = ellchangepointinv(G2m, v));
  if(!ellisoncurve(E, G1) || !ellisoncurve(E, G2),
    return([mm, nn, q, NE, "HARD_OFF_CURVE", 0, 0.0, 0.0, 0, 2]);
  );

  my(h11 = ellheight(Emin, G1m), h22 = ellheight(Emin, G2m));
  my(G1pG2m = elladd(Emin, G1m, G2m));
  my(h12 = (ellheight(Emin, G1pG2m) - h11 - h22) / 2);
  my(trM = h11 + h22, detM = h11 * h22 - h12^2);
  if(detM <= 0,
    return([mm, nn, q, NE, "DEGENERATE", 0, 0.0, 0.0, 0, 2]);
  );
  my(disc = trM^2 - 4 * detM);
  if(disc < 0, disc = 0);
  my(lambda_min = (trM - sqrt(disc)) / 2);
  if(lambda_min <= 0,
    return([mm, nn, q, NE, "DEGENERATE_LAM", 0, 0.0, 0.0, 0, 2]);
  );

  my(log_NE = log(NE * 1.0));
  my(nq = numerator(q), dq = denominator(q));
  my(h_f = 4 * log(max(nq, dq)^2 * 1.0));
  my(H_E = 100 * (log_NE + h_f + 1));
  my(B = ceil(sqrt(H_E / lambda_min)));

  my(scan_res = scan_box(E, G1, G2, q, B));
  my(cnt_sq = scan_res[1]);
  if(cnt_sq == 0,
    return([mm, nn, q, NE, "CLOSED", B, lambda_min, H_E, 0, 2]);
  ,
    return([mm, nn, q, NE, "PCP_CANDIDATE", B, lambda_min, H_E, cnt_sq, 2]);
  );
}

{
\\ Read params from file rigorous_chunk_params.txt: "START_IDX END_IDX OUT_SUFFIX"
my(params_str = readstr("rigorous_chunk_params.txt"));
my(parts = strsplit(params_str[1], " "));
START_IDX = eval(parts[1]);
END_IDX = eval(parts[2]);
OUT_SUFFIX = parts[3];
OUTFILE = Strprintf("rigorous_rank2_results_%s.txt", OUT_SUFFIX);
LOGFILE = Strprintf("rigorous_rank2_chunk_%s.log", OUT_SUFFIX);

lines = readstr("/root/proof/perfect-cuboid-problem/scripts/peschmann_968/epcp_rank2.txt");
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

write(LOGFILE, "Chunk ", OUT_SUFFIX, ": rows ", START_IDX, ".. ", END_IDX, " of ", #pairs);
write(OUTFILE, "# m  n  q  N(E)  status  B  lambda_min  H(E)  squares  #gens_found");

closed = 0; pcp = 0; hard = 0; degen = 0; err = 0; maxB = 0;
for(i = START_IDX, END_IDX,
  if(i > #pairs, break);
  p = pairs[i];
  mm = p[1]; nn = p[2];
  res = iferr(process_fiber(mm, nn), ERR,
              [mm, nn, 0, 0, "ERROR", 0, 0.0, 0.0, 0, 0]);
  status = res[5];
  if(status == "CLOSED", closed = closed + 1; if(res[6] > maxB, maxB = res[6]));
  if(status == "PCP_CANDIDATE", pcp = pcp + 1);
  if(status == "HARD_NO_GENS" || status == "HARD_OFF_CURVE", hard = hard + 1);
  if(status == "DEGENERATE" || status == "DEGENERATE_LAM", degen = degen + 1);
  if(status == "ERROR", err = err + 1);
  write(OUTFILE, res[1], " ", res[2], " ", res[3], " ", res[4], " ", res[5],
        " ", res[6], " ", res[7], " ", res[8], " ", res[9], " ", res[10]);
  write(LOGFILE, "[", i, "] (", mm, ",", nn, ") ", status, " B=", res[6],
        " closed=", closed, " pcp=", pcp, " hard=", hard);
);
write(LOGFILE, "=== Chunk ", OUT_SUFFIX, " DONE ===");
write(LOGFILE, "closed=", closed, " pcp=", pcp, " hard=", hard,
      " degen=", degen, " err=", err, " maxB=", maxB);
}
quit;

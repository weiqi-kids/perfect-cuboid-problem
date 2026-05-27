\\ Test rigorous full-box scan on one rank-2 fiber to estimate per-fiber time.
\\ Use (m, n) = (6, 5), q = 11/60, expected B ~ 50.
default(parisize, 4000000000);
default(realprecision, 38);
default(timer, 1);

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

process_fiber(mm, nn) =
{
  my(q = (mm^2 - nn^2) / (2 * mm * nn));
  print("=== (m, n) = (", mm, ", ", nn, "), q = ", q, " ===");
  my(E = ellinit([0, 1 + q^2, 0, q^2, 0]));
  my(v, Emin = ellminimalmodel(E, &v));
  my(NE = ellglobalred(Emin)[1]);
  print("  conductor N(E) = ", NE);

  \\ Use ellrank effort 3 for generators
  my(rkdata = iferr(ellrank(Emin, 3), ERR, [-1, -1, [], []]));
  if(#rkdata < 4 || #rkdata[4] < 2,
    \\ Try effort 4
    rkdata = iferr(ellrank(Emin, 4), ERR, [-1, -1, [], []]);
  );
  if(#rkdata < 4 || #rkdata[4] < 2,
    print("  HARD_NO_GENS"); return([mm, nn, q, NE, "HARD_NO_GENS", 0, 0, 0, 0]);
  );
  my(G1m = rkdata[4][1], G2m = rkdata[4][2]);
  my(G1 = ellchangepointinv(G1m, v), G2 = ellchangepointinv(G2m, v));
  if(!ellisoncurve(E, G1) || !ellisoncurve(E, G2),
    print("  HARD_OFF_CURVE"); return([mm, nn, q, NE, "HARD_OFF_CURVE", 0, 0, 0, 0]);
  );

  \\ Height pairing matrix on Emin (canonical heights are invariant)
  my(h11 = ellheight(Emin, G1m));
  my(h22 = ellheight(Emin, G2m));
  my(G1pG2m = elladd(Emin, G1m, G2m));
  my(h12 = (ellheight(Emin, G1pG2m) - h11 - h22) / 2);
  my(trM = h11 + h22, detM = h11 * h22 - h12^2);
  if(detM <= 0,
    print("  DEGENERATE pairing detM=", detM); return([mm, nn, q, NE, "DEGENERATE", 0, 0, 0, 0]);
  );
  my(lambda_min = (trM - sqrt(trM^2 - 4 * detM)) / 2);
  print("  lambda_min = ", lambda_min);

  \\ Rigorous height threshold (Ingram-Silverman 2009 / Ingram-Mahe), C1=100
  my(log_NE = log(NE * 1.0));
  my(nq = numerator(q), dq = denominator(q));
  my(h_f = 4 * log(max(nq, dq)^2 * 1.0));
  my(C1 = 100);
  my(H_E = C1 * (log_NE + h_f + 1));
  my(R2_max = H_E / lambda_min);
  my(B = ceil(sqrt(R2_max)));
  print("  log N(E) = ", log_NE);
  print("  h(f) <= ", h_f);
  print("  H(E) = ", H_E);
  print("  B = ", B);

  \\ Direct box scan
  my(scan_res = scan_box(E, G1, G2, q, B));
  my(cnt_sq = scan_res[1]);
  print("  scan |a|,|b| <= ", B, ": squares = ", cnt_sq);
  if(cnt_sq == 0,
    return([mm, nn, q, NE, "CLOSED", B, lambda_min, H_E, 0]);
  ,
    print("  PCP CANDIDATE: ", scan_res[2]);
    return([mm, nn, q, NE, "PCP_CANDIDATE", B, lambda_min, H_E, cnt_sq]);
  );
}

\\ Test on first fiber from epcp_rank2.txt: (6, 5)
gettime();
res = process_fiber(6, 5);
print("Elapsed (ms): ", gettime());
print(res);
quit;

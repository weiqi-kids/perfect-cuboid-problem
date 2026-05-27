\\ Test ellrank effort 4 on high-conductor cases.
default(parisize, 4000000000);
default(realprecision, 38);
default(timer, 0);

compute_B(mm, nn) =
{
  my(q = (mm^2 - nn^2) / (2 * mm * nn));
  my(E = ellinit([0, 1 + q^2, 0, q^2, 0]));
  my(v, Emin = ellminimalmodel(E, &v));
  my(NE = ellglobalred(Emin)[1]);
  gettime();
  my(rkdata = iferr(ellrank(Emin, 4), ERR, [-1, -1, [], []]));
  my(t_rk = gettime());
  if(#rkdata < 4 || #rkdata[4] < 2,
    print("(", mm, ",", nn, ") cond=", NE, " HARD_NO_GENS  ellrank_time=", t_rk, "ms");
    return(0);
  );
  my(G1m = rkdata[4][1], G2m = rkdata[4][2]);
  my(h11 = ellheight(Emin, G1m), h22 = ellheight(Emin, G2m));
  my(G1pG2m = elladd(Emin, G1m, G2m));
  my(h12 = (ellheight(Emin, G1pG2m) - h11 - h22) / 2);
  my(trM = h11 + h22, detM = h11 * h22 - h12^2);
  my(lambda_min = (trM - sqrt(trM^2 - 4 * detM)) / 2);
  my(log_NE = log(NE * 1.0));
  my(nq = numerator(q), dq = denominator(q));
  my(h_f = 4 * log(max(nq, dq)^2 * 1.0));
  my(H_E = 100 * (log_NE + h_f + 1));
  my(B = ceil(sqrt(H_E / lambda_min)));
  print("(", mm, ",", nn, ") cond=", NE, " lam_min=", lambda_min, " B=", B, " ellrank_time=", t_rk, "ms");
  B;
}

compute_B(99, 98);
compute_B(50, 1);
compute_B(89, 2);
compute_B(99, 1);
compute_B(100, 93);
quit;

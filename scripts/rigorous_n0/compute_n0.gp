\\ ====================================================================
\\ Per-fiber rigorous Ingram-Mahe N_0 bound for all 921 closed rank-1
\\ fibers in epcp_rank1.txt (PESCHMANN attack closures).
\\
\\ Author: CΛ / Lightman Chang
\\ Date:   2026-05-18
\\
\\ For each (m, n) with q = (m^2 - n^2)/(2 m n), build E_PCP(q) via
\\   E: y^2 = x^3 + (1 + q^2) x^2 + q^2 x,
\\ pass to its minimal model, find a non-torsion generator using the
\\ same procedure as attack_rank1.gp (ellrank effort 1/2/3 then
\\ ellheegner fallback for small conductor), compute hhat(P0) and the
\\ Silverman 1990 c_S(E), w_2(E), then output
\\
\\     N_0_rig = ceil( sqrt( 8(c_S + log(2 w2) + 1) / hhat(P0) ) ).
\\
\\ Compare with the direct-check window NMAX = 12 used by attack_rank1.gp.
\\ ====================================================================

default(parisize, 4000000000);
default(realprecision, 50);
default(timer, 0);

\\ ----- Silverman 1990 upper c_S (same form as ingram_mahe_rigorous_main.gp)
c_S_upper(E) = {
  my(Delta = E[12], j_inv = E[13], b2 = E[6], hj, term);
  hj = log(max(abs(numerator(j_inv)), abs(denominator(j_inv))));
  term = (1.0/12) * log(abs(Delta)) + hj/12.0;
  term += 0.5 * log(max(1, abs(b2)/12.0 + 1));
  term += 2.0;
  term;
};

w2_E(E) = {
  my(Delta = abs(E[12]), fac, m = 1);
  fac = factor(Delta);
  for(i = 1, matsize(fac)[1],
    if(fac[i, 2] > m, m = fac[i, 2]);
  );
  m;
};

N_0_rigorous(E, hhat) = {
  my(cS, w, K);
  cS = c_S_upper(E);
  w = w2_E(E);
  K = 8.0 * (cS + log(2.0 * w) + 1.0);
  ceil(sqrt(K / hhat));
};

\\ ----- Find a non-torsion generator of E_min
\\ Mirrors attack_rank1.gp + attack_rank1_hard.gp:
\\   effort 1 -> 2 -> 3 -> 4 (used together they closed all 921 in pass1+pass2)
find_generator(Emin, cond) = {
  my(rk, gen);
  rk = iferr(ellrank(Emin, 1), ERR, [-1, -1, 0, []]);
  if(rk[1] == 1 && #rk >= 4 && #rk[4] >= 1,
    return(rk[4][1]);
  );
  rk = iferr(ellrank(Emin, 2), ERR, [-1, -1, 0, []]);
  if(rk[1] == 1 && #rk >= 4 && #rk[4] >= 1,
    return(rk[4][1]);
  );
  rk = iferr(ellrank(Emin, 3), ERR, [-1, -1, 0, []]);
  if(rk[1] == 1 && #rk >= 4 && #rk[4] >= 1,
    return(rk[4][1]);
  );
  rk = iferr(ellrank(Emin, 4), ERR, [-1, -1, 0, []]);
  if(rk[1] == 1 && #rk >= 4 && #rk[4] >= 1,
    return(rk[4][1]);
  );
  if(cond < 10^9,
    gen = iferr(ellheegner(Emin), ERR, 0);
    if(type(gen) != "t_INT", return(gen));
  );
  return(0);
};

\\ ----- One fiber's rigorous N0 computation
compute_one(mm, nn) = {
  my(q, E, Emin, v, cond, gen, P0, hhat, cS, w, K, N0, Delta, j_inv);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  cond = ellglobalred(Emin)[1];
  gen = find_generator(Emin, cond);
  if(type(gen) == "t_INT" && gen == 0,
    return([mm, nn, cond, "NOGEN", 0, 0, 0, 0]);
  );
  if(!ellisoncurve(Emin, gen),
    return([mm, nn, cond, "OFFCURVE", 0, 0, 0, 0]);
  );
  hhat = iferr(ellheight(Emin, gen), ERR, -1);
  if(hhat <= 0,
    return([mm, nn, cond, "BADH", 0, 0, 0, 0]);
  );
  cS = c_S_upper(Emin);
  w  = w2_E(Emin);
  K  = 8.0 * (cS + log(2.0 * w) + 1.0);
  N0 = ceil(sqrt(K / hhat));
  return([mm, nn, cond, "OK", hhat, cS, w, N0]);
};

\\ ----- Driver
{
  lines = readstr("closed_rank1_mn.txt");
  pairs = List();
  for(i = 1, #lines,
    ln = lines[i];
    if(ln == "", next);
    if(Vecsmall(ln)[1] == 35, next);
    pieces = strsplit(ln, " ");
    if(#pieces >= 2,
      mm = eval(pieces[1]);
      nn = eval(pieces[2]);
      listput(pairs, [mm, nn]);
    );
  );
  print("Loaded ", #pairs, " closed rank-1 fibers");

  write("n0_results.txt",
    "# m n cond status hhat cS w2 N0_rig");

  hist = vector(40);  \\ N0 histogram (cap at 40)
  ok_count = 0; nogen = 0; bad = 0;
  max_N0 = 0; over12 = 0;
  over12_list = List();

  for(i = 1, #pairs,
    p = pairs[i];
    mm = p[1]; nn = p[2];
    res = iferr(compute_one(mm, nn), ERR,
                [mm, nn, 0, "ERROR", 0, 0, 0, 0]);
    status = res[4];
    if(status == "OK",
      ok_count = ok_count + 1;
      n0 = res[8];
      if(n0 > max_N0, max_N0 = n0);
      if(n0 > 12,
        over12 = over12 + 1;
        listput(over12_list, [mm, nn, res[3], res[5], n0]);
      );
      idx = if(n0 > 40, 40, if(n0 < 1, 1, n0));
      hist[idx] = hist[idx] + 1;
    ,
      if(status == "NOGEN" || status == "OFFCURVE" || status == "BADH",
        nogen = nogen + 1,
        bad = bad + 1);
    );
    write("n0_results.txt",
          res[1], " ", res[2], " ", res[3], " ", res[4], " ",
          res[5], " ", res[6], " ", res[7], " ", res[8]);
    if(i % 25 == 0,
      print("  progress ", i, "/", #pairs,
            " OK=", ok_count, " max_N0=", max_N0,
            " over12=", over12, " nogen=", nogen, " err=", bad);
    );
  );

  print("");
  print("=== Rigorous N_0 summary (rank-1 closed fibers) ===");
  print("Total fibers     : ", #pairs);
  print("OK (computed N0) : ", ok_count);
  print("No generator     : ", nogen);
  print("Other errors     : ", bad);
  print("Max N0 observed  : ", max_N0);
  print("Fibers with N0>12: ", over12);
  print("");
  print("N_0 histogram (rigorous, capped at 40):");
  for(i = 1, 40,
    if(hist[i] > 0,
      print("  N0=", i, " : ", hist[i])
    )
  );
  if(#over12_list > 0,
    print("");
    print("Fibers with N_0_rig > 12:");
    print("  m n cond hhat N0_rig");
    for(j = 1, #over12_list,
      r = over12_list[j];
      print("  ", r[1], " ", r[2], " ", r[3], " ", precision(r[4], 6), " ", r[5]);
    );
  );
}

quit;

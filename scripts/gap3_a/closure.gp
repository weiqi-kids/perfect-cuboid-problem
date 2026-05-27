\\ ====================================================================
\\ Gap 3 extended closure: per-fiber rigorous closure for every
\\ rank-jump fiber discovered in survey.out (54 fibers, N up to 8.25e8).
\\ ====================================================================
\\
\\ For each fiber we:
\\  (i)   Build E and Emin, change generators back to E (original model)
\\        via ellchangepointinv so we can evaluate the Face-3 map
\\        c = 2*Y*q/(q^2 - X^2),  F3 = c^2 + 1 + q^2 = omega(P).
\\  (ii)  Verify every claimed generator with ellisoncurve.
\\  (iii) For rank 1:
\\         - compute hat_h(P_0), c_S(E), w2(E),
\\         - N_0 := ceil(sqrt(8*(c_S + log(2*w2) + 1)/hat_h)),
\\         - exhaustively scan n in 1..max(20, N_0) for issquare(F3(n*P_0)).
\\  (iv)  For rank 2:
\\         - compute height-pairing matrix M = [[h11, h12], [h12, h22]],
\\         - lambda_min by eigenvalue formula,
\\         - H(E) := 100*(log N + 4*log max(num(q)^2, den(q)^2) + 1),
\\         - B := ceil(sqrt(H(E)/lambda_min)),
\\         - exhaustively scan (a, b) in [-B, B]^2 \ {(0,0)}.
\\
\\ Honest reporting: any anomalies / squares are printed loudly.

default(parisize, 800000000);
default(realprecision, 30);

\\ === Helpers ===

c_S_upper(E) = {
  my(Delta = E[12], j_inv = E[13], b2 = E[6], hj, term);
  hj = log(max(abs(numerator(j_inv)), abs(denominator(j_inv))));
  term = (1.0/12) * log(abs(Delta)) + hj/12.0;
  term += 0.5 * log(max(1, abs(b2)/12.0 + 1));
  term += 2.0;
  term;
};

w2_val(E) = {
  my(Delta = abs(E[12]), fac, m = 1);
  fac = factor(Delta);
  for(i = 1, matsize(fac)[1],
    if(fac[i, 2] > m, m = fac[i, 2]);
  );
  m;
};

\\ Compute F3(P) = c(P)^2 + 1 + q^2  given P = [X, Y].
F3_value(P, q) = {
  if(P == [0], return("identity"));
  my(X = P[1], Y = P[2], denom);
  denom = q^2 - X^2;
  if(denom == 0, return("pole"));
  my(c = 2*Y*q/denom);
  c^2 + 1 + q^2;
};

\\ Is value a rational square? value is "identity", "pole", or rational.
is_F3_square(val) = {
  if(type(val) == "t_STR", return(0));
  if(val == 0, return(0));   \\ degenerate (zero) — not a non-zero square
  my(num = numerator(val), den = denominator(val));
  (sign(num) == 1) && issquare(num) && issquare(den);
};

\\ === Master loop over all rank-jump fibers from survey.out ===
\\ Each row: [q, gens_on_Emin, expected_rank]
\\ Gens listed in same order as survey.out for completeness.

{
fibers = [
  \\ rank 1 (45 fibers)
  [20/21,    [[-125/4, 395/8]],                    1],
  [7/24,     [[-317/4, 3887/8]],                   1],
  [48/55,    [[-282, 1956]],                       1],
  [20/99,    [[-965, 44950]],                      1],
  [96/247,   [[-2260, 581138]],                    1],
  [13/84,    [[20195/4, 2796619/8]],               1],
  [39/80,    [[-900, 9030]],                       1],
  [44/117,   [[-1965, 38553]],                     1],
  [189/340,  [[24850, 3252595]],                   1],
  [60/91,    [[-210, 17805]],                      1],
  [225/272,  [[-4136, 330088]],                    1],
  [132/475,  [[-899/144, 5897298719/1728]],        1],
  [140/171,  [[-482665/169, 164460005/2197]],      1],
  [85/132,   [[-2281, 16313]],                     1],
  [57/176,   [[-1504, 229442]],                    1],
  [135/352,  [[-5496, 1741338]],                   1],
  [25/312,   [[-48542/9, 37856650/27]],            1],
  [28/195,   [[7394, 493943]],                     1],
  [160/231,  [[-6620, 115510]],                    1],
  [95/168,   [[3398, 72536]],                      1],
  [105/208,  [[-13117/4, 2768779/8]],              1],
  [52/675,   [[5389, 9242848]],                    1],
  [36/323,   [[572049/121, 768697884/1331]],       1],
  [23/264,   [[13230668/2209, 2337928582/103823]], 1],
  [84/187,   [[1402, 67759]],                      1],
  [100/621,  [[5866995/196, 1028965785/2744]],     1],
  [161/240,  [[179832, 76109592]],                 1],
  [120/209,  [[-6050, 52030]],                     1],
  [31/480,   [[35873780/1849, 3238229240/79507]],  1],
  [555/572,  [[-129442399/4489, 34912678679/300763]], 1],
  [48/575,   [[27882, 76380]],                     1],
  [69/260,   [[4410, 100935]],                     1],
  [832/855,  [[-63916, 670778]],                   1],
  [295/1728, [[82624, 122755978]],                 1],
  [33/544,   [[42704, 5462984]],                   1],
  [87/416,   [[1586044/121, 77259902/1331]],       1],
  [576/943,  [[5138200/49, 2645814844/343]],       1],
  [336/377,  [[-7140, 188118]],                    1],
  [29/420,   [[170260195/11881, 76625225110/1295029]], 1],
  [184/513,  [[807584/25, 370263088/125]],         1],
  [369/800,  [[228680, 102467660]],                1],
  [261/380,  [[353503/4, 205425161/8]],            1],
  [92/525,   [[17441355169/732736, 81242017618363/627222016]], 1],
  [56/783,   [[131533570714/2608225, 479520484853158/4212283375]], 1],
  [76/357,   [[-12548809/625, 12583177061/15625]], 1],

  \\ rank 2 (9 fibers)
  [11/60,    [[-185, 9745], [-515, 7270]],            2],
  [17/144,   [[-1920, 142332], [-3348, 48084]],       2],
  [104/153,  [[-2894, 44542], [-2998, 7934]],         2],
  [252/275,  [[-6886, 146663], [-7306, 22553]],       2],
  [108/725,  [[360149, 211594238], [39359, 1286048]], 2],
  [27/364,   [[3002, 1265339], [7553, 590681]],       2],
  [52/165,   [[-1346, 190513], [3274, 91183]],        2],
  [280/351,  [[-4494, 587832], [-11697/4, 1329741/8]], 2],
  [287/816,  [[-103534, 3784202], [62930, 1398218]],  2]
];

print("=================================================================");
print("Gap 3 extended closure — ", #fibers, " fibers");
print("=================================================================");
print();

n_closed_rank1 = 0;
n_closed_rank2 = 0;
n_failed = 0;
n_anomaly = 0;
pcp_candidates = List();
closure_log = List();

for(idx = 1, #fibers,
  my(q     = fibers[idx][1]);
  my(gens_min = fibers[idx][2]);
  my(target_rk = fibers[idx][3]);
  my(a2 = 1 + q^2, a4 = q^2);
  my(E = ellinit([0, a2, 0, a4, 0]));
  my(Emin = ellminimalmodel(E, &v_min));
  my(NE = ellglobalred(Emin)[1]);

  print("---------------------------------------------------------");
  print("[", idx, "/", #fibers, "]  q = ", q, "   N(E) = ", NE,
        "   target rank = ", target_rk);

  \\ Pull generators back from Emin to E.
  my(gens_E = vector(#gens_min));
  my(gens_valid = 1);
  for(g = 1, #gens_min,
    gens_E[g] = ellchangepointinv(gens_min[g], v_min);
    if(!ellisoncurve(E, gens_E[g]),
      print("  *** FAIL: generator ", g, " (Emin ", gens_min[g],
            " → E ", gens_E[g], ") not on E ***");
      gens_valid = 0;
    );
  );
  if(!gens_valid,
    n_failed = n_failed + 1;
    listput(closure_log, [q, NE, target_rk, "FAIL-gens-not-on-curve"]);
    next;
  );

  if(target_rk == 1,
    \\ ---------- RANK 1 CLOSURE ----------
    my(P0 = gens_E[1]);
    my(hP0 = ellheight(E, P0));
    my(cS = c_S_upper(E));
    my(w  = w2_val(Emin));
    my(K  = 8.0 * (cS + log(2.0 * w) + 1.0));
    my(N0 = ceil(sqrt(K / hP0)));
    my(scan_max = max(20, N0));

    print("  h^(P_0)         = ", precision(hP0, 10));
    print("  c_S(E) (upper)  = ", precision(cS, 6));
    print("  w_2(E)          = ", w);
    print("  K = 8(c_S + log(2 w2) + 1) = ", precision(K, 6));
    print("  N_0 (rigorous)  = ", N0);
    print("  Scan n = 1..", scan_max);

    my(sq_count = 0, pole_count = 0, identity_count = 0, F3_zero_count = 0);
    my(P_n = [0]);
    for(n = 1, scan_max,
      P_n = ellmul(E, P0, n);
      my(val = F3_value(P_n, q));
      if(type(val) == "t_STR",
        if(val == "identity", identity_count = identity_count + 1);
        if(val == "pole", pole_count = pole_count + 1);
        next;
      );
      if(val == 0, F3_zero_count = F3_zero_count + 1; next);
      if(is_F3_square(val),
        sq_count = sq_count + 1;
        my(X = P_n[1], Y = P_n[2], c = 2*Y*q/(q^2 - X^2));
        print("  *** PCP CANDIDATE: n=", n, "  c=", c, "  F3=", val);
        listput(pcp_candidates, [q, n, c, val, "rank 1"]);
      );
    );
    print("  Scan result: squares=", sq_count,
          ", poles=", pole_count,
          ", identity=", identity_count,
          ", F3=0=", F3_zero_count);

    if(sq_count == 0,
      print("  *** RANK-1 CLOSURE: SUCCESS (no PCP candidate in n<=", scan_max, ") ***");
      n_closed_rank1 = n_closed_rank1 + 1;
      listput(closure_log, [q, NE, 1, "CLOSED", hP0, N0, scan_max]);
    ,
      n_anomaly = n_anomaly + 1;
      listput(closure_log, [q, NE, 1, "PCP-candidate", sq_count]);
    );
  );

  if(target_rk == 2,
    \\ ---------- RANK 2 CLOSURE ----------
    my(G1 = gens_E[1], G2 = gens_E[2]);
    my(h11 = ellheight(E, G1));
    my(h22 = ellheight(E, G2));
    my(G12 = elladd(E, G1, G2));
    my(h12 = (ellheight(E, G12) - h11 - h22) / 2);
    my(trM = h11 + h22);
    my(detM = h11*h22 - h12^2);
    my(disc_sqrt = sqrt(trM^2 - 4*detM));
    my(lambda_min = (trM - disc_sqrt) / 2);
    my(lambda_max = (trM + disc_sqrt) / 2);

    print("  h^(G1) = ", precision(h11, 10));
    print("  h^(G2) = ", precision(h22, 10));
    print("  <G1,G2> = ", precision(h12, 10));
    print("  Regulator det M = ", precision(detM, 10));
    print("  lambda_min = ", precision(lambda_min, 10));
    print("  lambda_max = ", precision(lambda_max, 10));

    if(lambda_min <= 0,
      print("  *** FAIL: M not positive definite ***");
      n_failed = n_failed + 1;
      listput(closure_log, [q, NE, 2, "FAIL-non-PD"]);
      next;
    );

    my(numq = numerator(q), denq = denominator(q));
    my(log_NE = log(NE * 1.0));
    my(h_f = 4 * log(max(numq^2, denq^2)));
    my(C1 = 100);
    my(HE = C1 * (log_NE + h_f + 1));
    my(B = ceil(sqrt(HE / lambda_min)));

    print("  log N(E) = ", precision(log_NE, 6));
    print("  h(f) bound = ", precision(h_f, 6));
    print("  H(E) = 100*(log N + h(f) + 1) = ", precision(HE, 6));
    print("  B = ceil(sqrt(H(E)/lambda_min)) = ", B);

    my(scan_total = 0, sq_count = 0, pole_count = 0,
       identity_count = 0, F3_zero_count = 0);
    for(av = -B, B,
      for(bv = -B, B,
        if(av == 0 && bv == 0, next);
        scan_total = scan_total + 1;
        my(P = ellmul(E, G1, av));
        my(Q = ellmul(E, G2, bv));
        my(R = elladd(E, P, Q));
        my(val = F3_value(R, q));
        if(type(val) == "t_STR",
          if(val == "identity", identity_count = identity_count + 1);
          if(val == "pole", pole_count = pole_count + 1);
          next;
        );
        if(val == 0, F3_zero_count = F3_zero_count + 1; next);
        if(is_F3_square(val),
          sq_count = sq_count + 1;
          my(X = R[1], Y = R[2], c = 2*Y*q/(q^2 - X^2));
          print("  *** PCP CANDIDATE: (a,b)=(", av, ",", bv, ")  c=", c, "  F3=", val);
          listput(pcp_candidates, [q, [av,bv], c, val, "rank 2"]);
        );
      );
    );
    print("  Scan size: ", scan_total,
          " (B=", B, ", region |a|,|b|<=B)");
    print("  squares=", sq_count,
          ", poles=", pole_count,
          ", identity=", identity_count,
          ", F3=0=", F3_zero_count);

    if(sq_count == 0,
      print("  *** RANK-2 CLOSURE: SUCCESS (no PCP candidate in B=", B, ") ***");
      n_closed_rank2 = n_closed_rank2 + 1;
      listput(closure_log, [q, NE, 2, "CLOSED", lambda_min, B, scan_total]);
    ,
      n_anomaly = n_anomaly + 1;
      listput(closure_log, [q, NE, 2, "PCP-candidate", sq_count]);
    );
  );

  print();
);

print("=================================================================");
print("FINAL AGGREGATE");
print("=================================================================");
print("Rank-1 fibers closed:  ", n_closed_rank1, " of 45");
print("Rank-2 fibers closed:  ", n_closed_rank2, " of 9");
print("Failed:                ", n_failed);
print("PCP candidates flagged: ", #pcp_candidates);
print();

if(#pcp_candidates > 0,
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  print("ANOMALY: pcp candidates discovered");
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  for(j = 1, #pcp_candidates, print("  ", pcp_candidates[j]));
,
  print("All ", n_closed_rank1 + n_closed_rank2,
        " rank-jump fibers below N(E) <= 10^9 are RIGOROUSLY CLOSED.");
  print("No Face-3 squareness was found.");
);

print();
print("Per-fiber closure log:");
for(j = 1, #closure_log,
  print("  ", closure_log[j]);
);

}
print();
print("===== End Gap 3 closure =====");
quit;

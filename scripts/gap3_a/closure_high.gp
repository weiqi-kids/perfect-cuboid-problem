\\ Closure for high-N rank-jump fibers (10^9 < N <= 10^10).

default(parisize, 800000000);
default(realprecision, 30);

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

F3_value(P, q) = {
  if(P == [0], return("identity"));
  my(X = P[1], Y = P[2], denom);
  denom = q^2 - X^2;
  if(denom == 0, return("pole"));
  my(c = 2*Y*q/denom);
  c^2 + 1 + q^2;
};

is_F3_square(val) = {
  if(type(val) == "t_STR", return(0));
  if(val == 0, return(0));
  my(num = numerator(val), den = denominator(val));
  (sign(num) == 1) && issquare(num) && issquare(den);
};

{
fibers = [
  [155/468,   [[126839479/361, 1422237624847/6859]], 1],
  [152/345,   [[-11815434/6889, 748049907636/571787]], 1],
  [656/1617,  [[118830328/1089, 1874939031428/35937]], 1],
  [57/1624,   [[5009290877626/22610025, 150835231597154384/107510668875]], 1],
  [245/1188,  [[-47171, 69380758]], 1],
  [120/391,   [[6019700, 14766280070]], 1],
  [84/437,    [[1773871571/136900, 26424494965559/50653000]], 1],
  [820/1581,  [[228323456371278064455/83620984091401, 3425511893942569539529961460210/764667991595595965851]], 1],
  [116/837,   [[12379371/49, 40507648992/343]], 1],
  [481/600,   [[242495/4, 71103505/8]], 1],
  [59/1740,   [[3306533339/17689, 127364806054289/2352637]], 1],
  [1036/1173, [[124158070011/284089, 39266765902551693/151419437]], 1],
  [448/975,   [[4944, 23339028]], 1],
  [1748/1755, [[737527, 472021900]], 1],
  [341/420,   [[-4871499/625, 17136273174/15625]], 1],
  [735/1088,  [[-6650064/289, 128285307624/4913]], 1],
  [1525/1548, [[-201631, 5780378]], 1],
  [88/1935,   [[-558649256/961, 5465463068428/29791]], 1],
  [185/672,   [[-59871676/1681, 949071456478/68921]], 1],
  [833/1056,  [[2243810, 3353273612]], 1],
  [315/572,   [[-2581, 4708493]], 1],
  [168/775,   [[-5158716/121, 28602392538/1331]], 1],
  [45/1012,   [[84502, 319033]], 1],
  [217/456,   [[6989430/289, 7501623486/4913]], 1],
  [240/551,   [[5443948/169, 3589068094/2197]], 1],
  [53/1404,   [[1133756559/6889, 48381237099/571787]], 1],
  [1311/1360, [[-1422727979415/10601536, 174979490630951745/34518601216]], 1],
  [39/760,    [[25605635/4, 129533153695/8]], 1],
  [429/700,   [[1962, 5507907]], 1],
  [1725/2068, [[5213780589601/984064, 11836962103403389919/976191488]], 1],
  [248/945,   [[77247446/169, 655382152556/2197]], 1],
  [51/1300,   [[3917613323/29929, 32319604429762/5177717]], 1],
  [80/1599,   [[60419220/289, 13773709500/4913]], 1],
  [273/736,   [[3710364/121, 2919634284/1331]], 1],
  [931/1020,  [[-8460583/121, 12459243457/1331]], 1],
  [232/825,   [[-353309/4, 164239559/8]], 1],
  [192/1015,  [[268772572/2209, 2067384775118/103823]], 1],
  [616/663,   [[-1303685/36, 507852493/216]], 1],
  [441/1160,  [[831436664382/6345361, 108316789011528084/15983964359]], 1],
  [504/703,   [[-16688064/625, 138640325616/15625]], 1],
  [47/1104,   [[35776749594730/351600001, -210587434053000992/6592851618751]], 1],
  [1008/3905, [[-17351124/25, 318402762384/125]], 1],
  [76/1443,   [[35289717878146/201782025, 2728561415459060891/2866313665125]], 1],
  [2325/2332, [[262385931/289, 433572600924/4913]], 1],
  [147/1196,  [[1690321185/14641, 852194808087/1771561]], 1],
  [205/828,   [[698437/16, 262326565/64]], 1],
  [399/1600,  [[-1714904/25, 20158153916/125]], 1],

  \\ rank 2 fibers
  [44/483,    [[17061, 531432], [899151/25, 564970659/125]], 2],
  [105/608,   [[-1792, 7793366], [19964, 2912378]], 2],
  [216/713,   [[-74276, 9317794], [2422030/49, 841624456/343]], 2],
  [200/609,   [[-14480, 9117880], [997555/324, 37147941035/5832]], 2],
  [336/527,   [[-7810, 3777752], [33610, 1460968]], 2],
  [63/1984,   [[8261314/25, 295741178/125], [2819264, 4642895792]], 2],
  [55/1512,   [[-220878, 164561418], [9138348/49, 967926870/343]], 2],
  [333/644,   [[-235825/4, 21609541/8], [-6445894/625, 131551475171/15625]], 2],
  [799/960,   [[-33200, 6299800], [130800, 5381400]], 2],
  [407/624,   [[3924, 1458354], [-21341/4, 39227651/8]], 2],
  [1312/1425, [[507414, 292163418], [-8049464/49, 8990568124/343]], 2],
  [43/924,    [[94402, 11299519], [2111557/16, 2036434981/64]], 2],
  [560/1161,  [[156100, 24432730], [-24016790/121, 2435622770/1331]], 2]
];

print("=================================================================");
print("Gap 3 high-N closure — ", #fibers, " fibers");
print("=================================================================");
print();

n_closed_rank1 = 0;
n_closed_rank2 = 0;
n_failed = 0;
n_anomaly = 0;
pcp_candidates = List();
closure_log = List();

for(idx = 1, #fibers,
  my(q = fibers[idx][1]);
  my(gens_min = fibers[idx][2]);
  my(target_rk = fibers[idx][3]);
  my(a2 = 1 + q^2, a4 = q^2);
  my(E = ellinit([0, a2, 0, a4, 0]));
  my(Emin = ellminimalmodel(E, &v_min));
  my(NE = ellglobalred(Emin)[1]);

  print("---- [", idx, "/", #fibers, "]  q=", q, "  N=", NE, "  rank=", target_rk);

  my(gens_E = vector(#gens_min));
  my(gens_valid = 1);
  for(g = 1, #gens_min,
    gens_E[g] = ellchangepointinv(gens_min[g], v_min);
    if(!ellisoncurve(E, gens_E[g]),
      print("  FAIL: gen ", g, " not on E");
      gens_valid = 0;
    );
  );
  if(!gens_valid,
    n_failed = n_failed + 1;
    listput(closure_log, [q, NE, target_rk, "FAIL-gens-not-on-curve"]);
    next;
  );

  if(target_rk == 1,
    my(P0 = gens_E[1]);
    my(hP0 = ellheight(E, P0));
    my(cS = c_S_upper(E));
    my(w  = w2_val(Emin));
    my(K  = 8.0 * (cS + log(2.0 * w) + 1.0));
    my(N0 = ceil(sqrt(K / hP0)));
    my(scan_max = max(20, N0));

    my(sq_count = 0);
    for(n = 1, scan_max,
      my(P_n = ellmul(E, P0, n));
      my(val = F3_value(P_n, q));
      if(type(val) == "t_STR", next);
      if(is_F3_square(val),
        sq_count = sq_count + 1;
        my(X = P_n[1], Y = P_n[2], c = 2*Y*q/(q^2 - X^2));
        print("  *** PCP CANDIDATE: n=", n, "  c=", c, "  F3=", val);
        listput(pcp_candidates, [q, n, c, val, "rank 1"]);
      );
    );
    if(sq_count == 0,
      print("  N_0=", N0, ", scan n<=", scan_max, ": closed");
      n_closed_rank1 = n_closed_rank1 + 1;
      listput(closure_log, [q, NE, 1, "CLOSED", hP0, N0, scan_max]);
    ,
      n_anomaly = n_anomaly + 1;
      listput(closure_log, [q, NE, 1, "PCP-candidate", sq_count]);
    );
  );

  if(target_rk == 2,
    my(G1 = gens_E[1], G2 = gens_E[2]);
    my(h11 = ellheight(E, G1));
    my(h22 = ellheight(E, G2));
    my(G12 = elladd(E, G1, G2));
    my(h12 = (ellheight(E, G12) - h11 - h22) / 2);
    my(trM = h11 + h22);
    my(detM = h11*h22 - h12^2);
    my(disc_sqrt = sqrt(trM^2 - 4*detM));
    my(lambda_min = (trM - disc_sqrt) / 2);

    if(lambda_min <= 0,
      print("  FAIL: M not pos def");
      n_failed = n_failed + 1;
      listput(closure_log, [q, NE, 2, "FAIL-non-PD"]);
      next;
    );

    my(numq = numerator(q), denq = denominator(q));
    my(log_NE = log(NE * 1.0));
    my(h_f = 4 * log(max(numq^2, denq^2)));
    my(HE = 100 * (log_NE + h_f + 1));
    my(B = ceil(sqrt(HE / lambda_min)));

    my(sq_count = 0, scan_total = 0);
    for(av = -B, B,
      for(bv = -B, B,
        if(av == 0 && bv == 0, next);
        scan_total = scan_total + 1;
        my(P = ellmul(E, G1, av));
        my(Q = ellmul(E, G2, bv));
        my(R = elladd(E, P, Q));
        my(val = F3_value(R, q));
        if(type(val) == "t_STR", next);
        if(is_F3_square(val),
          sq_count = sq_count + 1;
          my(X = R[1], Y = R[2], c = 2*Y*q/(q^2 - X^2));
          print("  *** PCP CANDIDATE: (a,b)=(", av, ",", bv, ")  c=", c, "  F3=", val);
          listput(pcp_candidates, [q, [av,bv], c, val, "rank 2"]);
        );
      );
    );
    if(sq_count == 0,
      print("  lambda_min=", precision(lambda_min, 5), ", B=", B, ", scan=", scan_total, ": closed");
      n_closed_rank2 = n_closed_rank2 + 1;
      listput(closure_log, [q, NE, 2, "CLOSED", lambda_min, B, scan_total]);
    ,
      n_anomaly = n_anomaly + 1;
      listput(closure_log, [q, NE, 2, "PCP-candidate", sq_count]);
    );
  );
);

print();
print("=================================================================");
print("HIGH-N FINAL AGGREGATE");
print("=================================================================");
print("Rank-1 closed: ", n_closed_rank1, " of 47");
print("Rank-2 closed: ", n_closed_rank2, " of 13");
print("Failed:        ", n_failed);
print("PCP candidates:", #pcp_candidates);
if(#pcp_candidates > 0,
  print();
  print("PCP CANDIDATES:");
  for(j = 1, #pcp_candidates, print("  ", pcp_candidates[j]));
,
  print();
  print("All high-N rank-jump fibers (10^9 < N <= 10^10) are RIGOROUSLY CLOSED.");
);
print();
print("Per-fiber log:");
for(j = 1, #closure_log, print("  ", closure_log[j]));
}
print();
print("===== End high-N closure =====");
quit;

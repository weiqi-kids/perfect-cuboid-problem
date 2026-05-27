\\ Task A (extended): Apply rigorous rank-2 closure to all three rank-2
\\ Pythagorean q discovered: 60/11, 17/144, 104/153.

default(parisize, 4000000000);
default(realprecision, 38);

scan(B, q, E, G1, G2) =
{
  my(cnt_total = 0, cnt_sq = 0, cnt_pole = 0, cnt_id = 0, cnt_zero = 0);
  for(av = -B, B,
    for(bv = -B, B,
      if(av == 0 && bv == 0, next);
      cnt_total = cnt_total + 1;
      my(P_pt = ellmul(E, G1, av));
      my(Q_pt = ellmul(E, G2, bv));
      my(R_pt = elladd(E, P_pt, Q_pt));
      if(R_pt == [0], cnt_id = cnt_id + 1; next);
      my(Tn = R_pt[1], Yn = R_pt[2]);
      my(denom = q^2 - Tn^2);
      if(denom == 0, cnt_pole = cnt_pole + 1; next);
      my(cn = 2 * Yn * q / denom);
      my(an = cn^2 + 1 + q^2);
      if(an == 0, cnt_zero = cnt_zero + 1; next);
      my(valnum = numerator(an), valden = denominator(an));
      my(is_sq = (sign(valnum) == 1) && issquare(valnum) && issquare(valden));
      if(is_sq,
        cnt_sq = cnt_sq + 1;
        print("(a=", av, ", b=", bv, "): SQUARE!  an=", an);
      );
    );
  );
  [cnt_total, cnt_id, cnt_pole, cnt_zero, cnt_sq];
}

closure(q, G1m, G2m) =
{
  print("============================================================");
  print("Rigorous rank-2 closure for q = ", q);
  print("============================================================");
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E, &v));
  my(NE = ellglobalred(Emin)[1]);
  print("Conductor N(E): ", NE);

  my(G1 = ellchangepointinv(G1m, v));
  my(G2 = ellchangepointinv(G2m, v));
  print("Generators on E:");
  print("  G1 = ", G1, "  on E? ", ellisoncurve(E, G1));
  print("  G2 = ", G2, "  on E? ", ellisoncurve(E, G2));

  my(h11 = ellheight(E, G1));
  my(h22 = ellheight(E, G2));
  my(G1pG2 = elladd(E, G1, G2));
  my(h12 = (ellheight(E, G1pG2) - h11 - h22)/2);
  my(trM = h11 + h22, detM = h11*h22 - h12^2);
  my(lambda_min = (trM - sqrt(trM^2 - 4*detM))/2);
  my(lambda_max = (trM + sqrt(trM^2 - 4*detM))/2);

  print("Canonical heights:");
  print("  h(G1) = ", h11);
  print("  h(G2) = ", h22);
  print("  <G1,G2> = ", h12);
  print("  regulator = ", detM);
  print("  lambda_min = ", lambda_min, "  lambda_max = ", lambda_max);

  my(log_NE = log(NE * 1.0));
  my(nq = numerator(q), dq = denominator(q));
  my(h_f = 4 * log(max(nq^2, dq^2) * 1.0));
  my(C1 = 100);
  my(height_threshold = C1 * (log_NE + h_f + 1));
  my(R2_max = height_threshold / lambda_min);
  my(B = ceil(sqrt(R2_max)));

  print("log N(E) = ", log_NE);
  print("h(f) <= ", h_f);
  print("Height threshold (C_1=100, Ingram-Mahe): ", height_threshold);
  print("Uniform bound B (|a|, |b| <= B): ", B);
  print();
  print("Direct scan |a|, |b| <= ", B, "...");

  my(stats = scan(B, q, E, G1, G2));
  print("  Total non-(0,0) combos: ", stats[1]);
  print("  Identity:               ", stats[2]);
  print("  Poles of c:             ", stats[3]);
  print("  a_n = 0:                ", stats[4]);
  print("  Rational squares:       ", stats[5]);
  if(stats[5] == 0,
    print("VERDICT: rank-2 fiber q = ", q, " CLOSED (no PCP)."));
  print();
  stats[5];
}

\\ q = 60/11
sq1 = closure(60/11, [-185, 9745], [-515, 7270]);

\\ q = 17/144   generators on Emin: [-1920, 142332], [-3348, 48084]
sq2 = closure(17/144, [-1920, 142332], [-3348, 48084]);

\\ q = 104/153  generators on Emin: [-2894, 44542], [-2998, 7934]
sq3 = closure(104/153, [-2894, 44542], [-2998, 7934]);

print();
print("============================================================");
print("Summary: rank-2 closures");
print("  q = 60/11:    ", if(sq1 == 0, "CLOSED", "OPEN"));
print("  q = 17/144:   ", if(sq2 == 0, "CLOSED", "OPEN"));
print("  q = 104/153:  ", if(sq3 == 0, "CLOSED", "OPEN"));
print("============================================================");
quit;

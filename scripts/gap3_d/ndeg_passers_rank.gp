/* gap3_d/ndeg_passers_rank.gp
 *
 * For every non-degenerate 3-face passer with m ≤ 500, compute analytic rank
 * (low precision, fast). Tabulate rank distribution.
 * If any has rank ≥ 1, run Face-3 test on each generator.
 */
default(parisize, 2000000000);
default(realprecision, 19);

build_E_pcp(m, n) = { my(a = m^2 - n^2, b = 2*m*n);
  ellinit([0, a^2 + b^2, 0, a^2 * b^2, 0]);
};

\\ Face-3 test on minimal-model point: pull back to integral model, then to q-model.
\\ X_integ = X_min via Vmin (change of variables vector).
\\ Then X_qmodel = X_integ / b^2, Y_qmodel = Y_integ / b^3.
\\ c = 2 q Y_q / (q^2 - T^2), F3 = c^2 + 1 + q^2 — should be square.
face3_check(m, n, gens, Vmin) = { my(a = m^2 - n^2, b = 2*m*n, q, hits);
  q = a / b; hits = 0;
  for (j = 1, #gens, my(Pmin = gens[j]); \
    my(Pint = ellchangepointinv(Pmin, Vmin)); \
    my(X = Pint[1], Y = Pint[2]); \
    /* Translate from y^2 = x(x+a^2)(x+b^2) to E_q via x = b^2 T, y = b^3 Y_q */ \
    my(T = X / b^2, Yq = Y / b^3); \
    if (T == q^2, next); \
    my(c = 2 * Yq * q / (q^2 - T^2)); \
    my(F3 = c^2 + 1 + q^2); \
    my(sq = issquare(F3, &sqrtF3)); \
    if (sq, printf("    !!! HIT: m=%d n=%d  gen #%d: c=%s  F3=%s = SQUARE %s !!!\n", m, n, j, Str(c), Str(F3), Str(sqrtF3)); hits += 1) \
  );
  return (hits);
};

\\ Load non-degenerate passer list (m, n, deg) from scale_filter_M2000.out
data = readstr("/root/proof/perfect-cuboid-problem/scripts/gap3_d/scale_filter_M2000.out");
passers = List();
for (i = 1, #data, \
  my(s = data[i]); \
  my(t = strsplit(s, " ")); \
  if (#t == 3, \
    iferr( my(m = eval(t[1]), n = eval(t[2]), d = eval(t[3])); \
           if (type(m) == "t_INT" && d == 0 && m <= 300, listput(passers, [m, n])), \
           E, ) \
  ) \
);
printf("Non-degenerate passers with m ≤ 500: %d\n", #passers);

\\ Rank distribution
rank_dist = [0, 0, 0, 0, 0, 0];  /* 0..5 */
total_face3_hits = 0;
genfailed = 0;
for (i = 1, #passers, my(p = passers[i], m = p[1], n = p[2]); \
  iferr( my(E = build_E_pcp(m, n)); \
         my(Em = ellminimalmodel(E, &Vmin)); \
         my(ar = ellanalyticrank(Em, 0.05)[1]); \
         if (ar <= 5, rank_dist[ar + 1] += 1); \
         printf("  m=%-4d n=%-4d ar=%d", m, n, ar); \
         if (ar >= 1, \
           my(rr = ellrank(Em, 1)); \
           my(rlo = rr[1], rhi = rr[2], gens = rr[4]); \
           printf("  ellrank=[%d,%d]  gens=%d", rlo, rhi, #gens); \
           if (#gens >= 1, \
             my(hits = face3_check(m, n, gens, Vmin)); \
             total_face3_hits += hits \
           ) \
         ); \
         print(""), \
    E, printf("  m=%d n=%d ERR\n", m, n); genfailed += 1) \
);
printf("\nRank distribution:\n");
for (r = 0, 5, printf("  rank %d: %d\n", r, rank_dist[r + 1]));
printf("Face-3 HITS total: %d  (any HIT means PCP candidate!)\n", total_face3_hits);
printf("Failed: %d\n", genfailed);

quit;

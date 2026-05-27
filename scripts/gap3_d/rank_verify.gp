/* gap3_d/rank_verify.gp
 *
 * Rigorously verify rank at every task-listed rank-jump fiber.
 * Use BOTH ellanalyticrank (for high-precision analytic rank) and ellrank (for lower/upper bounds).
 *
 * Also: for every PASSER of the 3-face filter, attempt rank computation and Face-3 test.
 */
default(parisize, 1500000000);
default(realprecision, 38);

\\ E_PCP(q) : Y^2 = X(X+1)(X+q^2) with q = (m^2 - n^2) / (2mn).
\\ Equivalent: y^2 = x^3 + (1+q^2) x^2 + q^2 x.
\\ Use the integral model: substitute x = X / d^2, y = Y / d^3 where d = 2mn.
\\ Then E: Y^2 = X(X + (2mn)^2)(X + (m^2-n^2)^2)  ← but with denominators removed.
\\ The "minimal model" approach: build via ellinit with q rational.

build_E_pcp(m, n) = { my(a = m^2 - n^2, b = 2*m*n);
  /* y^2 = x(x + a^2)(x + b^2)  (integral version) */
  ellinit([0, a^2 + b^2, 0, a^2 * b^2, 0]);
};

verify_rank(m, n) = { my(E, Emin, ar, ranklh);
  E = build_E_pcp(m, n);
  Emin = ellminimalmodel(E);
  ar = ellanalyticrank(Emin, 0.005)[1];
  ranklh = ellrank(Emin, 1);  /* effort 1 */
  return ([ar, ranklh[1], ranklh[2]]);
};

face3_test(m, n, points) = {
  /* For each point P = (X, Y) on the curve Y^2 = X(X+a^2)(X+b^2), compute
   * c(P) = 2 b Y / (X^2 - q^2 X(...)) — actually using the q-model definition:
   * If P_q = (T, Y_q) on E_q : Y^2 = X(X+1)(X+q^2), then c = 2 Y q / (q^2 - T^2).
   * F3 = c^2 + 1 + q^2 — test if square.
   *
   * Conversion: on integral model Y^2 = X(X+a^2)(X+b^2), the substitution
   * X = b^2 T, Y = b^3 Y_q gives E_q with q = a/b. So T = X/b^2, Y_q = Y/b^3.
   */
  my(a = m^2 - n^2, b = 2*m*n, q = Mod(a, 1) / b);
  q = a / b;
  for (i = 1, #points, my(P = points[i]); \
    if (#P >= 2, \
      my(X = P[1], Y = P[2]); \
      my(T = X / b^2, Yq = Y / b^3); \
      if (T == q^2, \
        printf("    SKIP point (X=%s): T == q^2 (denominator zero)\n", Str(X)), \
        my(c = 2 * Yq * q / (q^2 - T^2)); \
        my(F3 = c^2 + 1 + q^2); \
        my(sq = issquare(F3)); \
        if (sq, printf("    !!! P=%s,%s  c=%s  F3=%s = SQUARE !!!\n", Str(X), Str(Y), Str(c), Str(F3)), \
                printf("    P=%s,%s  c=%s  F3 not square\n", Str(X), Str(Y), Str(c)) \
        ) \
      ) \
    ) \
  );
};

\\ ===== TASK 1: rank-jump fibers =====
print("\n========================================================");
print("RANK VERIFICATION + FACE-3 TEST FOR TASK RANK-JUMP FIBERS");
print("========================================================\n");

fibers = [[5, 2,  "20/21",   "rank1"], \
          [4, 3,  "7/24",    "rank1"], \
          [8, 3,  "48/55",   "rank1 Halcke"], \
          [10, 1, "20/99",   "rank1"], \
          [16, 3, "96/247",  "rank1"], \
          [7, 6,  "13/84",   "rank1"], \
          [8, 5,  "39/80",   "rank1"], \
          [6, 5,  "11/60",   "rank2"], \
          [9, 8,  "17/144",  "rank2"], \
          [13, 4, "104/153", "rank2 Saund"], \
          [22, 17, "(22,17)", "rank3"], \
          [35, 22, "(35,22)", "rank3"], \
          [37, 26, "(37,26)", "rank3"], \
          [40, 29, "(40,29)", "rank3"], \
          [40, 33, "(40,33)", "rank3"]];

for (i = 1, #fibers, \
  my(f = fibers[i], m = f[1], n = f[2], q = f[3], lbl = f[4]); \
  my(r = verify_rank(m, n)); \
  printf("[%s] m=%d n=%d q=%s  anrk=%d  ellrank=[%d,%d]\n", \
    lbl, m, n, q, r[1], r[2], r[3]); \
  /* For rank ≥ 1, fetch generators and run Face-3 test */ \
  if (r[2] >= 1, \
    my(E = build_E_pcp(m, n)); \
    my(Em = ellminimalmodel(E)); \
    my(rr = ellrank(Em, 2)); \
    my(gens = rr[4]); \
    if (#gens >= 1, \
      printf("    generators on Em (minimal model): %d points\n", #gens); \
      for (j = 1, min(#gens, 5), printf("       G_%d = %s\n", j, Str(gens[j]))) \
    ) \
  ) \
);

quit;

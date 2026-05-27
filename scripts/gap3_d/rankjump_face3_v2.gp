/* gap3_d/rankjump_face3_v2.gp
 * Use the q-model directly: E: Y² = X(X+1)(X+q²) with q the value listed in the task.
 * For each rank-jump fiber:
 *   - Choose q = "task value"
 *   - Build E_q on minimal integer model
 *   - Find generators, run Face-3 c = 2 q Y/(q² - X²), F3 = c² + 1 + q²
 */
default(parisize, 1500000000);

\\ The task's rank-jump q values
fibers_q = [["20/21",  1, "rank1"], \
            ["7/24",   1, "rank1"], \
            ["48/55",  1, "rank1 Halcke"], \
            ["20/99",  1, "rank1"], \
            ["96/247", 1, "rank1"], \
            ["13/84",  1, "rank1"], \
            ["39/80",  1, "rank1"], \
            ["11/60",  2, "rank2"], \
            ["17/144", 2, "rank2"], \
            ["104/153",2, "rank2"], \
            ["195/748",  3, "rank3 (22,17)"], \
            ["741/1540", 3, "rank3 (35,22)"], \
            ["693/1924", 3, "rank3 (37,26)"], \
            ["759/2320", 3, "rank3 (40,29)"], \
            ["511/2640", 3, "rank3 (40,33)"]];

parse_q(s) = { my(t = strsplit(s, "/")); eval(t[1]) / eval(t[2]); };

face3_q(q, T, Yq) = { my(c, F3);
  if (q^2 == T^2, return ([0, 0]));
  c = 2 * q * Yq / (q^2 - T^2);
  F3 = c^2 + 1 + q^2;
  return ([c, F3]);
};

build_int_model(q) = {
  /* y² = x(x+1)(x+q²). Multiply both sides by (denom q²)^3 to clear.
   * Easier: use ellinit on coefficients [0, 1+q², 0, q², 0] directly. PARI handles rationals.
   */
  ellinit([0, 1 + q^2, 0, q^2, 0]);
};

go(qstr, rk, lbl) = { my(q, E, Em, Vmin, rr, gens);
  q = parse_q(qstr);
  E = build_int_model(q);
  Em = ellminimalmodel(E, &Vmin);
  rr = ellrank(Em, 1);
  printf("[%s q=%s] ellrank=[%d,%d]  gens=%d\n", lbl, qstr, rr[1], rr[2], #rr[4]);
  if (#rr[4] == 0, return (0));
  /* Run face-3 over small linear combos of generators */
  my(hits = 0, tried = 0, r_actual = #rr[4]);
  my(maxg = if (r_actual == 1, 20, if (r_actual == 2, 7, 5)));
  forvec(v = vector(r_actual, k, [-maxg, maxg]), \
    if (vecmax(abs(v)) == 0, next); \
    my(P = ellmul(Em, rr[4][1], v[1])); \
    for (j = 2, r_actual, P = elladd(Em, P, ellmul(Em, rr[4][j], v[j]))); \
    if (type(P) == "t_INT", next); \
    iferr( my(Pback = ellchangepointinv(P, Vmin)); \
           my(T = Pback[1], Yq = Pback[2]); \
           my(fr = face3_q(q, T, Yq)); \
           if (fr[2] == 0, next); \
           tried += 1; \
           if (issquare(fr[2]), printf("\n!!! HIT q=%s combo=%s c=%s F3=%s !!!\n", qstr, Str(v), Str(fr[1]), Str(fr[2])); hits += 1), \
      E, ));
  printf("    tested %d combos, %d Face-3 HITS\n", tried, hits);
  return (hits);
};

total = 0;
for (i = 1, #fibers_q, my(f = fibers_q[i]); total += go(f[1], f[2], f[3]));
printf("\nTotal Face-3 HITS: %d\n", total);
quit;

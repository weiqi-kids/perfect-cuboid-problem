/* gap3_d/rankjump_face3.gp
 * Run Face-3 test on EVERY rank-jump fiber from Task 1, for every small linear
 * combination of generators with |coefficients| ≤ 5.
 */
default(parisize, 1500000000);

build_E_pcp(m, n) = { my(a = m^2 - n^2, b = 2*m*n);
  ellinit([0, a^2 + b^2, 0, a^2 * b^2, 0]);
};

face3_test(m, n, Em, Vmin, gens) = { my(a = m^2 - n^2, b = 2*m*n, q = a/b, hits = 0, tried = 0);
  /* enumerate |c_i| ≤ 5 linear combos */
  my(r = #gens);
  if (r == 0, return (0));
  my(grid = vectorsmall(r), maxg = 5);
  /* iterate over all c in [-5..5]^r */
  forvec(v = vector(r, k, [-maxg, maxg]), \
    if (vecmax(abs(v)) == 0, next); \
    my(P = ellmul(Em, gens[1], v[1])); \
    for (j = 2, r, P = elladd(Em, P, ellmul(Em, gens[j], v[j]))); \
    if (type(P) == "t_INT" && P == 0, next);   /* identity */ \
    iferr( my(Pint = ellchangepointinv(P, Vmin)); \
           my(X = Pint[1], Y = Pint[2]); \
           my(T = X / b^2, Yq = Y / b^3); \
           if (T == q^2, next); \
           my(c = 2 * Yq * q / (q^2 - T^2)); \
           my(F3 = c^2 + 1 + q^2); \
           tried += 1; \
           if (issquare(F3), printf("\n!!! HIT m=%d n=%d combo=%s c=%s F3=%s !!!\n", m, n, Str(v), Str(c), Str(F3)); hits += 1), \
      E, ) \
  );
  printf("  m=%d n=%d  tested %d combos, %d Face-3 HITS\n", m, n, tried, hits);
  return (hits);
};

fibers = [[5, 2], [4, 3], [8, 3], [10, 1], [16, 3], [7, 6], [8, 5], \
          [6, 5], [9, 8], [13, 4], \
          [22, 17], [35, 22], [37, 26], [40, 29], [40, 33]];
print("\n=== FACE-3 TEST AT RANK-JUMP FIBERS (|c_i| ≤ 5) ===\n");

total = 0;
for (i = 1, #fibers, my(f = fibers[i], m = f[1], n = f[2]); \
  my(E = build_E_pcp(m, n)); \
  my(Em = ellminimalmodel(E, &Vmin)); \
  my(rr = ellrank(Em, 1)); \
  printf("[m=%d n=%d]  ellrank=[%d,%d]  ", m, n, rr[1], rr[2]); \
  if (#rr[4] >= 1, my(h = face3_test(m, n, Em, Vmin, rr[4])); total += h, \
    print(" (no generators)")) \
);
printf("\nTotal Face-3 HITS across all rank-jump fibers: %d\n", total);
quit;

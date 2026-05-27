/* gap3_d/scale_filter_m2000.gp — same but at M=2000 */
default(parisize, 1000000000);

hilbert_global(A, B) = { my(badp, badset, S);
  if (A == 0 || B == 0, return ([0]));
  S = abs(A) * abs(B);
  if (A != B, S = S * abs(A - B));
  S = S * abs(A + B) * 2;
  badp = factor(S)[, 1];
  if (hilbert(A, B) != 1, return ([0]));
  for (i = 1, #badp, my(p = badp[i]); if (hilbert(A, B, p) != 1, return ([0])));
  return ([1]);
};

three_face_quick(m, n) = { my(P, Q, r);
  P = (m + n)^2 - 2*n^2; Q = (m - n)^2 - 2*n^2;
  r = hilbert_global(P, Q); if (r[1] == 0, return (0));
  r = hilbert_global(P, -Q); if (r[1] == 0, return (0));
  r = hilbert_global(-P, Q); if (r[1] == 0, return (0));
  return (1);
};

is_degenerate(m, n) = { my(P, Q, sfP, sfQ);
  P = (m + n)^2 - 2*n^2; Q = (m - n)^2 - 2*n^2;
  sfP = core(P); sfQ = core(Q);
  if (abs(sfP) == 1 || abs(sfQ) == 1, return (1));
  if (isprime(abs(sfP)) && (abs(sfP) % 8 == 1), \
    if (isprime(abs(sfQ)) && (abs(sfQ) % 8 == 1), return (2)));
  return (0);
};

{
  total = 0; passers = 0; deg_passers = 0; ndeg_passers = 0;
  outfile = "/root/proof/perfect-cuboid-problem/scripts/gap3_d/scale_filter_M2000.out";
  write(outfile, "# 3-face filter, m <= 2000");
  for (m = 2, 2000, \
    for (n = 1, m - 1, \
      if (gcd(m, n) == 1 && ((m + n) % 2 == 1), \
        total += 1; \
        if (three_face_quick(m, n), \
          passers += 1; \
          my(d = is_degenerate(m, n)); \
          if (d, deg_passers += 1, ndeg_passers += 1); \
          write(outfile, Strprintf("%d %d %d", m, n, d)) \
        ) \
      ) \
    ); \
    if (m % 100 == 0, printf("  m=%d  total=%d  pass=%d  deg=%d  ndeg=%d\n", m, total, passers, deg_passers, ndeg_passers)) \
  );
  printf("\n  FINAL: total=%d  passers=%d  deg=%d  ndeg=%d\n", total, passers, deg_passers, ndeg_passers);
  write(outfile, Strprintf("# FINAL: total=%d passers=%d deg=%d ndeg=%d", total, passers, deg_passers, ndeg_passers));
}
quit;

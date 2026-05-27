/*
 * gap3_d/scale_filter.gp
 *
 * Push the 3-face filter to m ≤ M (default M = 1000).
 * Tabulate pass counts by m-range, and emit the list of ALL-3 passers.
 * Mark each passer "degenerate" (sf(P)=1 or sf(Q)=1 — note sf in PARI sense returns positive squarefree part).
 */

default(parisize, 500000000);

hilbert_global(A, B) = { my(badp, badset, S);
  if (A == 0 || B == 0, return ([0, "deg"]));
  S = abs(A) * abs(B);
  if (A != B, S = S * abs(A - B));
  S = S * abs(A + B) * 2;
  badp = factor(S)[, 1];
  badset = List();
  if (hilbert(A, B) != 1, listput(badset, "oo"));
  for (i = 1, #badp, my(p = badp[i]); if (hilbert(A, B, p) != 1, listput(badset, p)));
  return ([#badset == 0, Vec(badset)]);
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
  /* Pure-square degenerate cases */
  if (abs(sfP) == 1 || abs(sfQ) == 1, return (1));
  /* Single-prime ≡ 1 mod 8 degenerate: trivial conic */
  if (isprime(abs(sfP)) && (abs(sfP) % 8 == 1), \
    if (isprime(abs(sfQ)) && (abs(sfQ) % 8 == 1), return (2)));
  return (0);
};

run_scale(M, outfile) = { my(total = 0, passers = 0, deg_passers = 0, ndeg_passers = 0, passlist = List());
  printf("\n=== 3-face filter, m ≤ %d ===\n", M);
  for (m = 2, M, \
    for (n = 1, m - 1, \
      if (gcd(m, n) == 1 && ((m + n) % 2 == 1), \
        total += 1; \
        if (three_face_quick(m, n), \
          passers += 1; \
          my(d = is_degenerate(m, n)); \
          if (d, deg_passers += 1, ndeg_passers += 1); \
          listput(passlist, [m, n, d]); \
          if (passers <= 50 || passers % 25 == 0, \
            printf("  pass #%d  m=%d n=%d  deg=%d\n", passers, m, n, d) \
          ) \
        ) \
      ) \
    ) \
  );
  printf("\n  Total primitive fibers (m ≤ %d):  %d\n", M, total);
  printf("  ALL-3 passers:                    %d  (%.2f%%)\n", passers, 100.0*passers/total);
  printf("  Degenerate passers:               %d\n", deg_passers);
  printf("  NON-degenerate passers:           %d\n", ndeg_passers);
  if (outfile != "",
    write(outfile, Strprintf("# 3-face filter at m <= %d", M));
    write(outfile, Strprintf("# total=%d passers=%d deg=%d ndeg=%d", total, passers, deg_passers, ndeg_passers));
    for (i = 1, #passlist, write(outfile, Strprintf("%d %d %d", passlist[i][1], passlist[i][2], passlist[i][3])));
  );
  return ([total, passers, deg_passers, ndeg_passers, Vec(passlist)]);
};

/* Buckets by m for the long-form table */
bucket_report(passlist) = { my(buckets = vector(20)); /* 0..1000 in 50-wide buckets */
  for (i = 1, #passlist, my(m = passlist[i][1], b = (m - 1) \ 50 + 1); \
    if (b <= 20, buckets[b] += 1));
  print("\n  m-range pass-count");
  for (b = 1, 20, my(lo = 50*(b-1) + 1, hi = 50*b); \
    printf("  %4d-%4d  %d\n", lo, hi, buckets[b]));
};

\\ MAIN
{
  r = run_scale(1000, "/root/proof/perfect-cuboid-problem/scripts/gap3_d/scale_filter_M1000.out");
  bucket_report(r[5]);
}

quit;

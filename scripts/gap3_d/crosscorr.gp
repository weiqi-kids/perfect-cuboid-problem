/* gap3_d/crosscorr.gp
 *
 * Cross-correlate the 3-face filter pass-set with the existing rank survey.
 * For every primitive (m, n) with m ≤ 100, list:
 *   - 3-face filter status (pass/fail, degenerate type)
 *   - analytic rank (from rank_survey_m100.out)
 */
default(parisize, 500000000);

hilbert_global(A, B) = { my(badp, S);
  if (A == 0 || B == 0, return (0));
  S = abs(A) * abs(B);
  if (A != B, S = S * abs(A - B));
  S = S * abs(A + B) * 2;
  badp = factor(S)[, 1];
  if (hilbert(A, B) != 1, return (0));
  for (i = 1, #badp, my(p = badp[i]); if (hilbert(A, B, p) != 1, return (0)));
  return (1);
};

three_face_pass(m, n) = { my(P, Q);
  P = (m + n)^2 - 2*n^2; Q = (m - n)^2 - 2*n^2;
  if (!hilbert_global(P, Q), return (0));
  if (!hilbert_global(P, -Q), return (0));
  if (!hilbert_global(-P, Q), return (0));
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

\\ Load rank survey
ranks = matrix(101, 101);
data = readstr("/root/proof/perfect-cuboid-problem/scripts/rank_survey_m60.out");
for (i = 1, #data, \
  my(s = data[i]); \
  my(t = strsplit(s, " ")); \
  if (#t >= 5, \
    my(m, n, rk); \
    iferr(m = eval(t[1]); n = eval(t[2]); rk = eval(t[5]); \
          if (type(m) == "t_INT" && type(n) == "t_INT" && type(rk) == "t_INT" && m <= 100 && n <= 100, ranks[m+1, n+1] = rk + 1), \
          E, ) \
  ) \
);

\\ Print cross-correlation report
print("\n=== CROSS-CORRELATION: 3-FACE FILTER vs ANALYTIC RANK (m ≤ 60) ===\n");
print("Columns: m n m+n  anrk  3face  deg-type  (sf(P), sf(Q))");

\\ Count
counters = matrix(5, 4);  \\ rank 0..4, pass/notpass × deg/notdeg
pass_rk_jump = List();
fail_rk_jump = List();
pass_all = List();

for (m = 2, 60, \
  for (n = 1, m-1, \
    if (gcd(m, n) == 1 && (m + n) % 2 == 1, \
      my(rk = ranks[m+1, n+1]); \
      if (rk == 0, next);  /* no rank data */ \
      rk -= 1;  /* unencode */ \
      my(p = three_face_pass(m, n)); \
      my(d = is_degenerate(m, n)); \
      if (rk >= 1, \
        if (p, listput(pass_rk_jump, [m, n, rk, d]), \
              listput(fail_rk_jump, [m, n, rk, d])) \
      ); \
      if (p, listput(pass_all, [m, n, rk, d])); \
    ) \
  ) \
);

printf("\nTotal m≤60 rank-jump fibers (rk ≥ 1, from survey data): %d\n", #pass_rk_jump + #fail_rk_jump);
printf("    that PASS 3-face filter: %d\n", #pass_rk_jump);
printf("    that FAIL 3-face filter: %d\n", #fail_rk_jump);

printf("\n=== Rank-jump PASSERS (m ≤ 60) ===\n");
for (i = 1, #pass_rk_jump, \
  my(r = pass_rk_jump[i], m = r[1], n = r[2], rk = r[3], d = r[4]); \
  my(P = (m+n)^2 - 2*n^2, Q = (m-n)^2 - 2*n^2); \
  printf("  m=%d n=%d  anrk=%d  deg=%d  sf(P)=%d sf(Q)=%d\n", m, n, rk, d, core(P), core(Q)) \
);

printf("\n=== All-3 PASSERS (m ≤ 60) (rank ≥ 0) ===\n");
for (i = 1, #pass_all, \
  my(r = pass_all[i], m = r[1], n = r[2], rk = r[3], d = r[4]); \
  my(P = (m+n)^2 - 2*n^2, Q = (m-n)^2 - 2*n^2); \
  printf("  m=%d n=%d  anrk=%d  deg=%d  sf(P)=%d sf(Q)=%d\n", m, n, rk, d, core(P), core(Q)) \
);

quit;

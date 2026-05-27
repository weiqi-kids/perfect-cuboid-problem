\\ ============================================================================
\\ MASSIVE H_q DIRECT POINT SEARCH on the 4 remaining BEYOND-QC fibers.
\\ ============================================================================
\\
\\ Hyperelliptic integer model:
\\   H_q^Z : Y^2 = (X^2 + d^2)(X^2 + p^2)(X^2 + w^2)
\\ where (d, p, w) = (m^2 - n^2, 2mn, m^2 + n^2) for the Pythagorean
\\ parametrization q = 2mn / (m^2-n^2).
\\
\\ Open BEYOND-QC fibers (after (99,28) became closeable via QCMod):
\\   (61, 38), (63, 38), (73, 24), (88, 35).
\\
\\ Two-pass search per fiber to bound B = 10^6:
\\   PASS A. Integer X in [-B, B] \ {0}: 2*B candidates.
\\   PASS B. Fractional X = a/b^2 with gcd(a,b) = 1,
\\           |a| <= B and 2 <= b <= floor(sqrt(B)).
\\
\\ Because f is even in X, we test only a >= 1 in both passes; if (a, b)
\\ gives a hit then so does (-a, b).
\\
\\ Acceleration: per-(b,p) precomputed "QR residue tables" v[r+1] = 1 iff
\\ ((r*r + d^2 b^4)(r*r + p^2 b^4)(r*r + w^2 b^4)) is a QR (or zero) mod p.
\\ The inner loop reduces to ~9 array lookups per (a,b) pair.
\\
\\ DEGENERATE BASELINE: At X = 0, f(0) = (d p w)^2, so Y = +- d*p*w.
\\ We assert this explicitly. Any other rational X with f(X) square is a
\\ PCP candidate to be verified and pulled back to V_q.
\\ ============================================================================

default(parisize, 500000000);
default(realprecision, 38);

B = 1000000;

\\ 9 small primes for the QR sieve.
SIEVE_PRIMES = [5, 7, 11, 13, 17, 19, 23, 29, 31];

\\ The 4 BEYOND-QC fibers still open (after (99,28) closeable).
{FIBERS = [
  ["(61,38)", 61, 38],
  ["(63,38)", 63, 38],
  ["(73,24)", 73, 24],
  ["(88,35)", 88, 35]
];}

\\ ------------------------------------------------------------------
\\ Build "good residues" table for sieve at given prime modp.
\\ v[r+1] = 1 iff
\\   (r^2 + d2b4) * (r^2 + p2b4) * (r^2 + w2b4) ≡ 0 or QR (mod modp),
\\ i.e., it is *possible* for f(a) with a ≡ r (mod modp) to be a square in Z.
\\ ------------------------------------------------------------------
build_good_residues(d2b4, p2b4, w2b4, modp) =
{
  my(v, r, val);
  v = vector(modp);
  for(r = 0, modp - 1,
    val = ((r*r + d2b4) * (r*r + p2b4) * (r*r + w2b4)) % modp;
    if(val == 0,
      v[r+1] = 1,
      v[r+1] = if(issquare(Mod(val, modp)), 1, 0)
    );
  );
  return(v);
};

\\ ------------------------------------------------------------------
\\ PASS A: integer X in [-B, B] \ {0}.
\\ For each X in [1, B], sieve via the b = 1 residue tables.
\\ Then full issquare on survivors.
\\ ------------------------------------------------------------------
pass_A_integer(mm, nn, B_param) =
{
  my(d, p_, w, d2, p2, w2, found, t_start, n_scanned, n_sieved_in, n_issquared,
     X, big, Yout,
     v1, v2, v3, v4, v5, v6, v7, v8, v9,
     p1, p2_, p3, p4, p5, p6, p7, p8, p9, expected_Y0);

  d = mm^2 - nn^2;
  p_ = 2 * mm * nn;
  w = mm^2 + nn^2;
  d2 = d^2; p2 = p_^2; w2 = w^2;

  \\ Degenerate baseline check (X = 0).
  expected_Y0 = d * p_ * w;
  if(!issquare(d2 * p2 * w2, &Yout), error("INTERNAL: X=0 must give square"));
  if(Yout != expected_Y0, error("INTERNAL: Y(0) != d*p*w"));
  print("    [baseline] X=0 -> Y = +-", expected_Y0, "  (verified)");

  p1 = SIEVE_PRIMES[1]; p2_ = SIEVE_PRIMES[2]; p3 = SIEVE_PRIMES[3];
  p4 = SIEVE_PRIMES[4]; p5 = SIEVE_PRIMES[5]; p6 = SIEVE_PRIMES[6];
  p7 = SIEVE_PRIMES[7]; p8 = SIEVE_PRIMES[8]; p9 = SIEVE_PRIMES[9];

  v1 = build_good_residues(d2, p2, w2, p1);
  v2 = build_good_residues(d2, p2, w2, p2_);
  v3 = build_good_residues(d2, p2, w2, p3);
  v4 = build_good_residues(d2, p2, w2, p4);
  v5 = build_good_residues(d2, p2, w2, p5);
  v6 = build_good_residues(d2, p2, w2, p6);
  v7 = build_good_residues(d2, p2, w2, p7);
  v8 = build_good_residues(d2, p2, w2, p8);
  v9 = build_good_residues(d2, p2, w2, p9);

  t_start = getwalltime();
  found = List();
  n_scanned = 0;
  n_sieved_in = 0;
  n_issquared = 0;

  for(X = 1, B_param,
    n_scanned += 1;
    if(v1[X % p1 + 1] == 0, next);
    if(v2[X % p2_ + 1] == 0, next);
    if(v3[X % p3 + 1] == 0, next);
    if(v4[X % p4 + 1] == 0, next);
    if(v5[X % p5 + 1] == 0, next);
    if(v6[X % p6 + 1] == 0, next);
    if(v7[X % p7 + 1] == 0, next);
    if(v8[X % p8 + 1] == 0, next);
    if(v9[X % p9 + 1] == 0, next);
    n_sieved_in += 1;
    big = (X*X + d2) * (X*X + p2) * (X*X + w2);
    n_issquared += 1;
    if(issquare(big, &Yout),
      listput(found, [X, Yout]);
      print("    !!! NON-DEGENERATE INTEGER X FOUND: X=", X, " Y=", Yout);
    );
  );

  print("    Pass A: scanned ", n_scanned, " positive X values");
  print("    Pass A: ", n_sieved_in, " survived 9-prime QR sieve");
  print("    Pass A: ", n_issquared, " full issquare tests");
  print("    Pass A: ", #found, " non-degenerate integer X found");
  print("    Pass A wall: ", getwalltime() - t_start, " ms");
  return(found);
};

\\ ------------------------------------------------------------------
\\ PASS B: fractional X = a / b^2, gcd(a,b) = 1, b in [2, floor(sqrt(B))].
\\ For each b, rebuild the 9 residue tables (since they depend on b^4).
\\ Then inline-sieve, gcd-check, full issquare on survivors.
\\
\\ Note: f(X) = F(a,b) / b^12 where F(a,b) = product over c of (a^2 + c^2 b^4).
\\ Since b^12 is always square, f(X) is a square iff F(a,b) is a square.
\\ ------------------------------------------------------------------
pass_B_fractional(mm, nn, B_param) =
{
  my(d, p_, w, d2, p2, w2, found, t_start, n_scanned, n_sieved_in, n_issquared,
     b, a, b2, b4, d2b4, p2b4, w2b4, Yout, sqrtB, big,
     v1, v2, v3, v4, v5, v6, v7, v8, v9,
     p1, p2_, p3, p4, p5, p6, p7, p8, p9, last_t);

  d = mm^2 - nn^2;
  p_ = 2 * mm * nn;
  w = mm^2 + nn^2;
  d2 = d^2; p2 = p_^2; w2 = w^2;
  sqrtB = sqrtint(B_param);

  p1 = SIEVE_PRIMES[1]; p2_ = SIEVE_PRIMES[2]; p3 = SIEVE_PRIMES[3];
  p4 = SIEVE_PRIMES[4]; p5 = SIEVE_PRIMES[5]; p6 = SIEVE_PRIMES[6];
  p7 = SIEVE_PRIMES[7]; p8 = SIEVE_PRIMES[8]; p9 = SIEVE_PRIMES[9];

  t_start = getwalltime();
  last_t = t_start;
  found = List();
  n_scanned = 0;
  n_sieved_in = 0;
  n_issquared = 0;

  for(b = 2, sqrtB,
    b2 = b * b; b4 = b2 * b2;
    d2b4 = d2 * b4; p2b4 = p2 * b4; w2b4 = w2 * b4;
    v1 = build_good_residues(d2b4, p2b4, w2b4, p1);
    v2 = build_good_residues(d2b4, p2b4, w2b4, p2_);
    v3 = build_good_residues(d2b4, p2b4, w2b4, p3);
    v4 = build_good_residues(d2b4, p2b4, w2b4, p4);
    v5 = build_good_residues(d2b4, p2b4, w2b4, p5);
    v6 = build_good_residues(d2b4, p2b4, w2b4, p6);
    v7 = build_good_residues(d2b4, p2b4, w2b4, p7);
    v8 = build_good_residues(d2b4, p2b4, w2b4, p8);
    v9 = build_good_residues(d2b4, p2b4, w2b4, p9);

    for(a = 1, B_param,
      n_scanned += 1;
      if(v1[a % p1 + 1] == 0, next);
      if(v2[a % p2_ + 1] == 0, next);
      if(v3[a % p3 + 1] == 0, next);
      if(v4[a % p4 + 1] == 0, next);
      if(v5[a % p5 + 1] == 0, next);
      if(v6[a % p6 + 1] == 0, next);
      if(v7[a % p7 + 1] == 0, next);
      if(v8[a % p8 + 1] == 0, next);
      if(v9[a % p9 + 1] == 0, next);
      if(gcd(a, b) != 1, next);
      n_sieved_in += 1;
      big = (a*a + d2b4) * (a*a + p2b4) * (a*a + w2b4);
      n_issquared += 1;
      if(issquare(big, &Yout),
        listput(found, [a, b, Yout]);
        print("    !!! NON-DEGENERATE FRACTIONAL X FOUND: a=", a, " b=", b,
              " X=a/b^2=", a, "/", b2, " Y_num=", Yout);
      );
    );
    if(b % 100 == 0,
      print("      [progress] b=", b, "/", sqrtB,
            " elapsed=", getwalltime() - t_start, "ms",
            " incr=", getwalltime() - last_t, "ms",
            " sieved_in=", n_sieved_in);
      last_t = getwalltime();
    );
  );

  print("    Pass B: scanned ", n_scanned, " (a,b) pairs");
  print("    Pass B: ", n_sieved_in, " coprime+sieved-in");
  print("    Pass B: ", n_issquared, " full issquare tests");
  print("    Pass B: ", #found, " non-degenerate fractional X found");
  print("    Pass B wall: ", getwalltime() - t_start, " ms");
  return(found);
};

\\ ------------------------------------------------------------------
\\ Driver
\\ ------------------------------------------------------------------
print("======================================================================");
print("MASSIVE H_q DIRECT POINT SEARCH");
print("Bound B = ", B);
print("Sieve primes: ", SIEVE_PRIMES);
print("Fibers: ", #FIBERS);
print("======================================================================");

global_start = getwalltime();
GLOBAL_RESULTS = List();

{
for(i = 1, #FIBERS,
  my(label, mm, nn, foundA, foundB, d, p_, w);
  label = FIBERS[i][1];
  mm = FIBERS[i][2];
  nn = FIBERS[i][3];
  d = mm^2 - nn^2;
  p_ = 2 * mm * nn;
  w = mm^2 + nn^2;
  print("\n----------------------------------------------------------------------");
  print("FIBER ", label, "  m=", mm, "  n=", nn);
  print("  (d, p, w) = (", d, ", ", p_, ", ", w, ")");
  print("  d^2 = ", d^2, "   p^2 = ", p_^2, "   w^2 = ", w^2);
  print("----------------------------------------------------------------------");
  foundA = pass_A_integer(mm, nn, B);
  foundB = pass_B_fractional(mm, nn, B);
  listput(GLOBAL_RESULTS, [label, mm, nn, foundA, foundB]);
);
}

print("\n======================================================================");
print("FINAL SUMMARY");
print("======================================================================");
{
for(i = 1, #GLOBAL_RESULTS,
  my(r);
  r = GLOBAL_RESULTS[i];
  print("Fiber ", r[1], ":  Pass A hits=", #r[4], "   Pass B hits=", #r[5]);
  if(#r[4] > 0,
    print("  >>> NON-DEGENERATE INTEGER X POINTS:");
    for(j = 1, #r[4], print("    ", r[4][j]));
  );
  if(#r[5] > 0,
    print("  >>> NON-DEGENERATE FRACTIONAL X POINTS:");
    for(j = 1, #r[5], print("    ", r[5][j]));
  );
);
}

print("\nTotal wall time: ", getwalltime() - global_start, " ms");
print("======================================================================");

quit;

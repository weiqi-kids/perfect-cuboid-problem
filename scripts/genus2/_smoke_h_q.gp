\\ Smoke v4: per-(b,p) precompute "good a residues mod p" table, then inner-loop
\\ becomes just 9 table lookups + AND.

default(parisize, 500000000);

B = 100000;
SIEVE_PRIMES = [5, 7, 11, 13, 17, 19, 23, 29, 31];

FIBERS = [["(61,38)", 61, 38]];

\\ For given (d2b4, p2b4, w2b4) and prime modp, return a vector v of length modp
\\ where v[r+1] = 1 iff (r^2+d2b4)*(r^2+p2b4)*(r^2+w2b4) is a QR (or zero) mod modp.
build_good_residues(d2b4, p2b4, w2b4, modp) =
{
  my(v, r, val);
  v = vector(modp);
  for(r = 0, modp - 1,
    val = ((r*r + d2b4) * (r*r + p2b4) * (r*r + w2b4)) % modp;
    if(val == 0, v[r+1] = 1, v[r+1] = if(issquare(Mod(val, modp)), 1, 0));
  );
  v;
};

pass_B_table(mm, nn, B_param) =
{
  my(d, p_, w, d2, p2, w2, found, t_start, n_scanned, n_sieved_in, n_issquared,
     b, a, b2, b4, d2b4, p2b4, w2b4, ok, Yout, sqrtB, big, NP,
     v1, v2, v3, v4, v5, v6, v7, v8, v9,
     p1, p2_, p3, p4, p5, p6, p7, p8, p9);
  d = mm^2 - nn^2;
  p_ = 2 * mm * nn;
  w = mm^2 + nn^2;
  d2 = d^2; p2 = p_^2; w2 = w^2;
  sqrtB = sqrtint(B_param);
  NP = #SIEVE_PRIMES;
  p1 = SIEVE_PRIMES[1]; p2_ = SIEVE_PRIMES[2]; p3 = SIEVE_PRIMES[3];
  p4 = SIEVE_PRIMES[4]; p5 = SIEVE_PRIMES[5]; p6 = SIEVE_PRIMES[6];
  p7 = SIEVE_PRIMES[7]; p8 = SIEVE_PRIMES[8]; p9 = SIEVE_PRIMES[9];

  t_start = getwalltime();
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
      \\ Inline sieve: 9 table lookups.
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
        print("    !!! a=", a, " b=", b, " Yn=", Yout);
      );
    );
  );
  print("  Pass B B=", B_param, ": ", n_scanned, " scanned, ", n_sieved_in,
        " sieved-in, ", n_issquared, " issquared, ", #found, " hits, ",
        getwalltime()-t_start, "ms");
  return(found);
};

{
for(i = 1, #FIBERS,
  my(mm, nn);
  mm = FIBERS[i][2];
  nn = FIBERS[i][3];
  print("=== ", FIBERS[i][1], " ===");
  pass_B_table(mm, nn, B);
);
}
quit;

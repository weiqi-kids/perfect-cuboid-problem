/* gap3_d/refined_degeneracy.gp
 *
 * Apply REFINED degeneracy definition (matching prior FINAL-SYNTHESIS notion):
 *  - "narrow": sf(P) = ±1, sf(Q) = ±1, or both single prime ≡ 1 mod 8
 *  - "extension": one of sf(P), sf(Q) is single prime ≡ 1 mod 8 (Hilbert
 *    symbol with anything that's a square mod that prime trivializes)
 *  - "double-extension": both sf(P) and sf(Q) products of 2 primes ≡ 1 mod 8
 *    with all 4 primes pairwise QNR  (the (265, 14)-type pattern)
 *
 * Note: I'll use the simpler classifier: "narrow_deg" or "ext_deg" if either
 * P or Q has sf in {±1, single prime ≡ 1 mod 8}, since such factor makes the
 * 3 Hilbert conditions trivially satisfiable. The (265, 14) two-by-two QNR
 * pattern is an additional non-degenerate-but-trivial case.
 */
default(parisize, 1000000000);

is_deg_class(m, n) = { my(P, Q, sfP, sfQ, fP, fQ);
  P = (m + n)^2 - 2*n^2; Q = (m - n)^2 - 2*n^2;
  sfP = core(P); sfQ = core(Q);
  /* narrow: square */
  if (abs(sfP) == 1, return ("sq_P"));
  if (abs(sfQ) == 1, return ("sq_Q"));
  /* narrow: single prime ≡ 1 mod 8 */
  if (isprime(abs(sfP)) && (sfP > 0) && (sfP % 8 == 1), return ("prime1mod8_P"));
  if (isprime(abs(sfQ)) && (sfQ > 0) && (sfQ % 8 == 1), return ("prime1mod8_Q"));
  /* now both sfP, sfQ are non-trivial (composite or sign-changing or not ≡ 1 mod 8) */
  /* extension: 2 primes ≡ 1 mod 8 with mutual QNR */
  fP = factor(abs(sfP))[, 1]; fQ = factor(abs(sfQ))[, 1];
  if (#fP == 2 && #fQ == 2 && sfP > 0 && sfQ > 0, \
    if (fP[1] % 8 == 1 && fP[2] % 8 == 1 && fQ[1] % 8 == 1 && fQ[2] % 8 == 1, \
      /* check all 4 pairwise quadratic-non-residue */ \
      my(all_qnr = 1); \
      for (i = 1, 2, for (j = 1, 2, \
        if (kronecker(fP[i], fQ[j]) != -1, all_qnr = 0); \
      )); \
      if (all_qnr, return ("2x2_QNR")) \
    ) \
  );
  /* default: genuinely non-degenerate */
  return ("none");
};

/* Re-classify previously found passers */
data = readstr("/root/proof/perfect-cuboid-problem/scripts/gap3_d/scale_filter_M2000.out");
counters = Map();
truly_ndeg = List();
for (i = 1, #data, \
  my(s = data[i]); \
  my(t = strsplit(s, " ")); \
  if (#t == 3, \
    iferr( my(m = eval(t[1]), n = eval(t[2]), d0 = eval(t[3])); \
           if (type(m) == "t_INT", \
             my(cls = is_deg_class(m, n)); \
             iferr(my(c = mapget(counters, cls)); mapput(counters, cls, c + 1), \
                   EE, mapput(counters, cls, 1)); \
             if (cls == "none", listput(truly_ndeg, [m, n])) \
           ), \
           E, ) \
  ) \
);

print("\n=== REFINED DEGENERACY CLASSIFICATION ===");
ks = Mat(counters)[, 1];
for (i = 1, #ks, my(k = ks[i]); printf("  %-15s: %d\n", k, mapget(counters, k)));
printf("\n  truly non-degenerate: %d\n", #truly_ndeg);

print("\nFirst 20 TRULY non-degenerate passers (m ≤ 2000):");
for (i = 1, min(#truly_ndeg, 20), my(p = truly_ndeg[i]); \
  printf("  m=%d n=%d  sf(P)=%d sf(Q)=%d\n", p[1], p[2], core((p[1]+p[2])^2 - 2*p[2]^2), core((p[1]-p[2])^2 - 2*p[2]^2)));

/* Save the truly non-degenerate list */
write("/root/proof/perfect-cuboid-problem/scripts/gap3_d/truly_ndeg_M2000.out", "# truly non-degenerate 3-face passers, m <= 2000");
for (i = 1, #truly_ndeg, write("/root/proof/perfect-cuboid-problem/scripts/gap3_d/truly_ndeg_M2000.out", Strprintf("%d %d", truly_ndeg[i][1], truly_ndeg[i][2])));

quit;

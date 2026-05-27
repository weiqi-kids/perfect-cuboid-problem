/* gap3_d/ndeg_passers_anrk.gp
 * Compute analytic rank only for every non-degenerate 3-face passer with m ≤ 300.
 * Just analytic rank — fast.
 */
default(parisize, 1000000000);
default(realprecision, 19);

build_E_pcp(m, n) = { my(a = m^2 - n^2, b = 2*m*n);
  ellinit([0, a^2 + b^2, 0, a^2 * b^2, 0]);
};

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
printf("Non-degenerate passers (m ≤ 300): %d\n\n", #passers);

rank_dist_lo = [0, 0, 0, 0, 0, 0];
rank_dist_hi = [0, 0, 0, 0, 0, 0];
maxlo = 0; maxhi = 0;
hits_total = 0;
for (i = 1, #passers, my(p = passers[i], m = p[1], n = p[2]); \
  iferr( my(E = build_E_pcp(m, n)); \
         my(Em = ellminimalmodel(E, &Vmin)); \
         my(rno = ellrootno(Em)); \
         my(rr = ellrank(Em, 1)); \
         my(rlo = rr[1], rhi = rr[2], gens = rr[4]); \
         if (rlo <= 5, rank_dist_lo[rlo + 1] += 1); \
         if (rhi <= 5, rank_dist_hi[rhi + 1] += 1); \
         if (rlo > maxlo, maxlo = rlo); \
         if (rhi > maxhi, maxhi = rhi); \
         printf("  m=%-4d n=%-4d rootno=%2d  ellrank=[%d,%d]  gens=%d", m, n, rno, rlo, rhi, #gens); \
         if (#gens >= 1, \
           my(a = m^2 - n^2, b = 2*m*n, q = a / b); \
           for (j = 1, #gens, my(Pmin = gens[j]); \
             iferr( my(Pint = ellchangepointinv(Pmin, Vmin)); \
                    my(X = Pint[1], Y = Pint[2]); \
                    my(T = X / b^2, Yq = Y / b^3); \
                    if (T != q^2, \
                      my(c = 2 * Yq * q / (q^2 - T^2)); \
                      my(F3 = c^2 + 1 + q^2); \
                      if (issquare(F3), printf("\n  !!! HIT m=%d n=%d gen #%d c=%s F3=%s !!!", m, n, j, Str(c), Str(F3)); hits_total += 1) \
                    ), \
               EI, ) \
           ) \
         ); \
         print(""), \
    E, printf("  m=%d n=%d ERR: %s\n", m, n, E)) \
);
printf("\nRank distribution (ellrank low, hi):\n");
for (r = 0, 5, printf("  rank %d: low=%d hi=%d\n", r, rank_dist_lo[r + 1], rank_dist_hi[r + 1]));
printf("Max lower bound: %d   Max upper bound: %d\n", maxlo, maxhi);
printf("Face-3 HITS total: %d\n", hits_total);

quit;

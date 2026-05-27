/* gap3_d/truly_ndeg_rank.gp
 * Run ellrank + Face-3 on every TRULY non-degenerate passer (m ≤ M).
 * Save output incrementally so we can monitor.
 */
default(parisize, 2000000000);

build_E_pcp(m, n) = { my(a = m^2 - n^2, b = 2*m*n);
  ellinit([0, a^2 + b^2, 0, a^2 * b^2, 0]);
};

face3_check_one(m, n, Pmin, Vmin) = { my(a = m^2 - n^2, b = 2*m*n, q, Pint, X, Y, T, Yq, c, F3);
  q = a / b;
  iferr( Pint = ellchangepointinv(Pmin, Vmin); X = Pint[1]; Y = Pint[2]; \
         T = X / b^2; Yq = Y / b^3; \
         if (T == q^2, return (0)); \
         c = 2 * Yq * q / (q^2 - T^2); \
         F3 = c^2 + 1 + q^2; \
         if (issquare(F3), printf("\n  !!! HIT m=%d n=%d  c=%s  F3=%s !!!", m, n, Str(c), Str(F3)); return (1)); \
         return (0), \
    E, return (0));
};

go(m, n, outfile) = { my(E, Em, Vmin, rno, rr, gens, rlo, rhi);
  iferr( E = build_E_pcp(m, n); \
         Em = ellminimalmodel(E, &Vmin); \
         rno = ellrootno(Em); \
         rr = ellrank(Em, 1); \
         rlo = rr[1]; rhi = rr[2]; gens = rr[4]; \
         my(hits = 0); \
         for (j = 1, #gens, hits += face3_check_one(m, n, gens[j], Vmin)); \
         my(line = Strprintf("m=%d n=%d rootno=%d ellrank=[%d,%d] gens=%d hits=%d", m, n, rno, rlo, rhi, #gens, hits)); \
         print(line); \
         write(outfile, line); \
         return ([rlo, rhi, hits]), \
    E, my(line = Strprintf("m=%d n=%d  ERR", m, n)); print(line); write(outfile, line); return ([-1, -1, 0]));
};

outfile = "/root/proof/perfect-cuboid-problem/scripts/gap3_d/truly_ndeg_rank.out";
write(outfile, "# truly non-degenerate passer ranks");

\\ Load truly_ndeg list
data = readstr("/root/proof/perfect-cuboid-problem/scripts/gap3_d/truly_ndeg_M2000.out");
passers = List();
for (i = 1, #data, \
  my(s = data[i]); \
  my(t = strsplit(s, " ")); \
  if (#t == 2, \
    iferr( my(m = eval(t[1]), n = eval(t[2])); \
           if (type(m) == "t_INT" && m <= 1000, listput(passers, [m, n])), \
           E, ) \
  ) \
);
printf("Loaded %d truly non-degenerate passers with m ≤ 1000\n\n", #passers);

total_hits = 0;
rank_dist = [0, 0, 0, 0, 0, 0];
for (i = 1, #passers, my(p = passers[i]); \
  my(r = go(p[1], p[2], outfile)); \
  if (r[1] >= 0 && r[1] <= 5, rank_dist[r[1] + 1] += 1); \
  total_hits += r[3] \
);
printf("\nDone. Rank dist (lower): ");
for (r = 0, 5, printf("rk%d=%d ", r, rank_dist[r + 1]));
printf("\nFace-3 hits total: %d\n", total_hits);
quit;

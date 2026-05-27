default(parisize, 1200000000);

\\ Known rank-3 fibers
{
rank3 = [[22,17], [35,22], [37,26], [40,29], [40,33], [161,48], [173,16], [197,20]];
\\ Known rank-4 fibers
rank4 = [[99,28], [118,25], [174,83], [176,63], [181,38], [205,66], [209,72], [216,185], [221,202], [261,52], [273,86]];
}

\\ For each known rank-r fiber, tabulate arithmetic of (m, n)
analyze(mn) = {
  my(m, n, mpn, mmn, m2pn2, m2mn2, twomn, mn_prod);
  m = mn[1]; n = mn[2];
  mpn = m + n;
  mmn = m - n;
  m2pn2 = m^2 + n^2;
  m2mn2 = m^2 - n^2;
  twomn = 2*m*n;
  mn_prod = m * n;
  [m, n, m+n, m-n, m^2+n^2, m^2-n^2, m*n,
   omega(mpn), omega(mmn), omega(m2pn2), omega(m2mn2), omega(mn_prod),
   factor(mpn), factor(mmn), factor(m2pn2)];
};

print("=== RANK 3 FIBERS ===");
print("(m, n, m+n, m-n, m²+n², m²-n², mn, ω(m+n), ω(m-n), ω(m²+n²), ω(m²-n²), ω(mn))");
{
for(i=1, length(rank3),
  my(d, m, n);
  d = analyze(rank3[i]);
  m = d[1]; n = d[2];
  print("(", m, ", ", n, "):  m+n=", d[3], " (ω=", d[8], ") m-n=", d[4], " (ω=", d[9], ")");
  print("     m²+n²=", d[5], " (ω=", d[10], ")  m²-n²=", d[6], " (ω=", d[11], ")  mn=", d[7], " (ω=", d[12], ")");
  print("     factors: m+n=", d[13], "  m-n=", d[14]);
  print("     m²+n²=", d[15]);
);
}

print();
print("=== RANK 4 FIBERS ===");
{
for(i=1, length(rank4),
  my(d, m, n);
  d = analyze(rank4[i]);
  m = d[1]; n = d[2];
  print("(", m, ", ", n, "):  m+n=", d[3], " (ω=", d[8], ") m-n=", d[4], " (ω=", d[9], ")");
  print("     m²+n²=", d[5], " (ω=", d[10], ")  m²-n²=", d[6], " (ω=", d[11], ")  mn=", d[7], " (ω=", d[12], ")");
  print("     factors: m+n=", d[13], "  m-n=", d[14]);
  print("     m²+n²=", d[15]);
);
}

\\ Look for common arithmetic properties
print();
print("=== SUMMARY STATISTICS ===");
{
omega_mpn = vector(length(rank3), i, omega(rank3[i][1] + rank3[i][2]));
omega_mmn = vector(length(rank3), i, omega(rank3[i][1] - rank3[i][2]));
omega_m2pn2 = vector(length(rank3), i, omega(rank3[i][1]^2 + rank3[i][2]^2));
omega_m2mn2 = vector(length(rank3), i, omega(rank3[i][1]^2 - rank3[i][2]^2));
print("Rank-3 ω(m+n):    ", omega_mpn, "  mean=", sum(i=1,length(omega_mpn),omega_mpn[i])*1.0/length(omega_mpn));
print("Rank-3 ω(m-n):    ", omega_mmn, "  mean=", sum(i=1,length(omega_mmn),omega_mmn[i])*1.0/length(omega_mmn));
print("Rank-3 ω(m²+n²):  ", omega_m2pn2, "  mean=", sum(i=1,length(omega_m2pn2),omega_m2pn2[i])*1.0/length(omega_m2pn2));
print("Rank-3 ω(m²-n²):  ", omega_m2mn2, "  mean=", sum(i=1,length(omega_m2mn2),omega_m2mn2[i])*1.0/length(omega_m2mn2));

omega_mpn4 = vector(length(rank4), i, omega(rank4[i][1] + rank4[i][2]));
omega_mmn4 = vector(length(rank4), i, omega(rank4[i][1] - rank4[i][2]));
omega_m2pn24 = vector(length(rank4), i, omega(rank4[i][1]^2 + rank4[i][2]^2));
omega_m2mn24 = vector(length(rank4), i, omega(rank4[i][1]^2 - rank4[i][2]^2));
print();
print("Rank-4 ω(m+n):    ", omega_mpn4, "  mean=", sum(i=1,length(omega_mpn4),omega_mpn4[i])*1.0/length(omega_mpn4));
print("Rank-4 ω(m-n):    ", omega_mmn4, "  mean=", sum(i=1,length(omega_mmn4),omega_mmn4[i])*1.0/length(omega_mmn4));
print("Rank-4 ω(m²+n²):  ", omega_m2pn24, "  mean=", sum(i=1,length(omega_m2pn24),omega_m2pn24[i])*1.0/length(omega_m2pn24));
print("Rank-4 ω(m²-n²):  ", omega_m2mn24, "  mean=", sum(i=1,length(omega_m2mn24),omega_m2mn24[i])*1.0/length(omega_m2mn24));
}

\\ Compare to typical (m, n) — sample a baseline
print();
print("=== BASELINE (1000 random small Pythagorean (m, n) pairs) ===");
{
bs_mpn = List();
bs_mmn = List();
bs_m2pn2 = List();
bs_m2mn2 = List();
count = 0;
for(m=2, 60,
  for(n=1, m-1,
    if (gcd(m, n) == 1 && (m+n) % 2 == 1,
      listput(bs_mpn, omega(m+n));
      listput(bs_mmn, omega(m-n));
      listput(bs_m2pn2, omega(m^2+n^2));
      listput(bs_m2mn2, omega(m^2-n^2));
      count = count + 1;
    );
  );
);
print("Baseline N = ", count);
print("Baseline mean ω(m+n)   = ", sum(i=1,length(bs_mpn),bs_mpn[i])*1.0/length(bs_mpn));
print("Baseline mean ω(m-n)   = ", sum(i=1,length(bs_mmn),bs_mmn[i])*1.0/length(bs_mmn));
print("Baseline mean ω(m²+n²) = ", sum(i=1,length(bs_m2pn2),bs_m2pn2[i])*1.0/length(bs_m2pn2));
print("Baseline mean ω(m²-n²) = ", sum(i=1,length(bs_m2mn2),bs_m2mn2[i])*1.0/length(bs_m2mn2));
}

quit;

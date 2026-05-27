\\ =====================================================================
\\ 02_sel2_vs_H.gp  -- Empirical test: how does dim Sel_2 relate to |H(m,n)|?
\\
\\ For each fiber where rank is *proven*, we have dim Sel_2 = rank + 2
\\ (since the curve has full 2-torsion (Z/2)^2 over Q, and we use
\\  ellrank with lo = up confirmed; Sha[2] then absorbed into lower bound).
\\ Actually:  dim_F2 Sel_2 = rank + dim E(Q)[2]/2E(Q)[2] + dim Sha[2]
\\          = rank + 2 + dim Sha[2]   (since E[2](Q) = (Z/2)^2)
\\ When ellrank returns lo = up, that means rank is determined; but
\\ ellrank's upper bound is the 2-Selmer bound rank + 2 = lo + 2
\\ ONLY if Sha[2] = 0. We have to be careful: ellrank's "up" is the
\\ 2-Selmer rank upper bound for the rank, i.e. dim Sel_2 - 2.
\\ So  dim Sel_2 = up + 2  WHEN  up matches the actual Selmer dim.
\\ =====================================================================

default(parisize, 1500000000);

\\ Heron-form prime set H(m, n) per FINAL-SYNTHESIS Theorem A
heron_set(m, n) = {
  my(values, primes = List(), v);
  \\ NOTE: 2 always implicitly included (for E_PCP the prime 2 always
  \\       appears via the rational reduction of (x+1)*(x+q^2)).
  values = [m, n, m+n, abs(m-n), m^2+n^2, m^2-n^2,
            (m+n)^2 - 2*n^2, (m-n)^2 - 2*n^2];
  for(i=1, #values, v = abs(values[i]); if(v > 1, listput(primes, factor(v)[,1]~)));
  primes = concat(Vec(primes));
  vecsort(Set(concat(primes)));
};

\\ Tighter "PCP support" set: primes dividing 2 * (m^2-n^2) * (2mn) * conductor factors
\\ which is just bad_primes of E_PCP, union {2}.
support_set(Em) = {
  my(N = ellglobalred(Em)[1], pfac);
  pfac = factor(N)[,1]~;
  Set(concat(pfac, [2]));
};

build_E(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  [q, E, Em];
};

\\ Compute dim Sel_2 using ellrank: return [dim_sel_lower, dim_sel_upper, rank_lo, rank_up]
compute_sel2(Em, effort) = {
  my(rk = ellrank(Em, effort));
  \\ rk = [lo, up, ..., gens]
  \\ dim Sel_2 = rank + 2 + dim Sha[2]
  \\ ellrank's "up" is dim Sel_2 - 2 (since Sha[2] absorbed)
  \\ So dim Sel_2 = up + 2 always.
  \\ But careful: when lo < up, the "up" is genuinely an upper bound on rank;
  \\ dim Sel_2 = up + 2 might be a slight overestimate if Sha[2] caps it.
  \\ Actually: ellrank returns up = dim_F2(Sel_2 / E[2](Q)) bound on rank.
  \\ Translation: dim Sel_2 = up + dim E[2](Q) = up + 2 always.
  [rk[2] + 2, rk[2] + 2, rk[1], rk[2]];
};

\\ All known rank-3 and rank-4 fibers
{
known_fibers = [[22,17], [35,22], [37,26], [40,29], [40,33], [41,18], [44,9], [53,32], [59,40], [60,43], [161,48], [173,16], [197,20], [217,24], [99,28], [118,25], [174,83], [176,63], [181,38], [205,66], [209,72], [216,185], [221,202], [261,52], [273,86], [578,319]];
}

print("===== dim Sel_2 vs |H(m,n)| on known high-rank fibers =====");
print("(m,n)       |H|    rank_lo  rank_up  dimSel2  H-rank-2  |H|/(rank+2)");

{
results = List();
for(i=1, #known_fibers,
  mn = known_fibers[i];
  m = mn[1]; n = mn[2];
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
  data = build_E(m, n);
  Em = data[3];
  s2 = compute_sel2(Em, 3);
  H = heron_set(m, n);
  badN = support_set(Em);
  diff = #H - s2[1];
  excess_H_over_rank = #H - (s2[3] + 2);
  print(mn, "  ", #H, "    ", s2[3], "       ", s2[4], "       ", s2[1], "       ", diff, "     ", excess_H_over_rank);
  listput(results, [m, n, #H, #badN, s2[3], s2[4], s2[1]]);
);
}

print();
print("===== Now also test some rank-2 and rank-1 baseline fibers =====");

{
baseline_fibers = [[3,2], [5,2], [4,1], [5,4], [7,2], [8,3], [9,4], [11,2], [12,5], [13,8], [15,4], [16,9], [17,8], [18,13], [21,10], [23,14], [25,12], [27,4], [28,5], [29,8], [30,17], [32,15]];
}

print("(m,n)       |H|    rank_lo  rank_up  dimSel2  H-dimSel2");

{
for(i=1, #baseline_fibers,
  mn = baseline_fibers[i];
  m = mn[1]; n = mn[2];
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
  data = build_E(m, n);
  Em = data[3];
  s2 = compute_sel2(Em, 1);  \\ rapid for these
  H = heron_set(m, n);
  print(mn, "  ", #H, "    ", s2[3], "       ", s2[4], "       ", s2[1], "       ", #H - s2[1]);
);
}

quit;

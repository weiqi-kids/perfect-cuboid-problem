\\ Track T5 / Iwasawa-Family — Step 1
\\ Compute p-adic L-function 𝓛_p(E_PCP(q), s) at individual Pythagorean fibers
\\ E_PCP(q): Y^2 = X(X+1)(X+q^2), integer model: y^2 = x(x+u^2)(x+v^2),
\\           u = 2mn, v = m^2 - n^2 (Pythagorean parametrization).
\\
\\ Method: PARI's ellpadicL(E, p, n) returns 𝓛_p(E, T) modulo (p^n, T^d) using
\\ the Mazur-Tate-Teitelbaum / overconvergent modular symbol construction
\\ (Pollack-Stevens machinery in PARI 2.15).
\\
\\ Honest note: ellpadicL is delicate.  For conductor ≳ 5000, the internal
\\ computation of overconvergent modular symbols requires several GB of RAM
\\ and minutes to hours.  We therefore restrict to fibers with N ≤ 25000
\\ and request precision n = 3 or 4.

default(parisize, 2000000000);
default(parisizemax, 6500000000);

print("=================================================================");
print("Track T5 - Iwasawa-Family - 01_padicL_individual");
print("=================================================================");
print();

\\ Roster of fibers, in order of increasing conductor for tractability
\\ Each entry: [m, n, "q", expected_rank_from_step5]
{
roster = [
  [2,1, "3/4",   0],
  [3,2, "5/12",  0],
  [5,2, "21/20", 1],
  [5,4, "9/40",  0],
  [4,3, "7/24",  1],
  [6,1, "35/12", 0],
  [7,2, "45/28", 0],
  [8,1, "63/16", 0],
  [8,3, "55/48", 1],
  [5,1, "12/5",  0]
];
}

print("Roster size: ", length(roster));
print();

\\ Output file
out = "/root/proof/perfect-cuboid-problem/scripts/iwasawa_family/01_padicL_individual.out";
write(out, "# Track T5 - p-adic L-values L_p(E_PCP(q), 1)");
write(out, "# Format: (m,n) q N rank p reduction a_p L_p_at_1 valuation walltime_s");

\\ Compute p-adic L for each fiber at primes p in {3, 5, 7, 11} when feasible
{
ps = [3, 5, 7, 11];
prec = 3;            \\ p-adic precision; reduce if memory pressure
N_cutoff = 25000;    \\ skip fibers with N exceeding this (heuristic)

for(i=1, length(roster),
  m = roster[i][1]; n = roster[i][2]; qs = roster[i][3]; rk_expected = roster[i][4];
  u = 2*m*n; v = m^2 - n^2;
  E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
  Emin = ellminimalmodel(E);
  N = ellglobalred(Emin)[1];

  printf("\n--- (m,n)=(%d,%d), q=%s, N=%d, expected rank=%d ---\n",
          m, n, qs, N, rk_expected);

  if(N > N_cutoff,
    printf("  N exceeds cutoff %d, SKIPPING p-adic L computation.\n", N_cutoff);
    write(out, "(", m, ",", n, ") q=", qs, " N=", N, " SKIPPED (too large)"),
    \\ else
    for(j=1, length(ps),
      p = ps[j];
      ap = ellap(Emin, p);
      reduction = if(N % p == 0,
        if(Emin[10] % p != 0 || ap == 0, "additive",
           if(ap == 1, "split_mult", "nonsplit_mult")),
        "good"
      );
      ordinary = (reduction == "good" && ap % p != 0) || (reduction == "split_mult") || (reduction == "nonsplit_mult");
      printf("  p=%d  a_p=%d  reduction=%s  ordinary?=%d\n", p, ap, reduction, ordinary);

      if(ordinary,
        t0 = getwalltime();
        L_at_1 = "ERROR"; val = "n/a";
        iferr(
            L = ellpadicL(Emin, p, prec);
            \\ ellpadicL returns the value (a t_PADIC) when no series-variable
            \\ is requested.  At s=1 that's exactly L_at_1.
            L_at_1 = L;
            val = if(type(L) == "t_PADIC", valuation(L_at_1, p), "n/a"),
          E,
          printf("    ellpadicL FAILED.\n");
          L_at_1 = "ERROR";
          val = "n/a"
        );
        t1 = getwalltime();
        dt = (t1-t0)/1000.0;
        printf("    L_p(E,1) = %s, val_p = %s, [%.2fs]\n", L_at_1, val, dt);
        write(out, Strprintf("(%d,%d) q=%s N=%d rank=%d p=%d red=%s a_p=%d L_p(1)=%s val=%s t=%.2fs",
                              m, n, qs, N, rk_expected, p, reduction, ap, L_at_1, val, dt));
        \\ Force garbage collection by reinitializing parisize (clears stack)
        ,
        printf("    skipping (non-ordinary at p=%d)\n", p);
      );
    );
  );
);
}

print();
print("Done step 1.  Output: ", out);
quit

\\ Task B: Density / rank-jump survey for E_PCP(q), q Pythagorean.
\\
\\ We enumerate Pythagorean rationals q = (m^2 - n^2)/(2*m*n) and the
\\ reciprocals 2*m*n/(m^2 - n^2), with m up to MMAX, gcd(m,n)=1, m + n odd.
\\ For each such q we build E_PCP(q): Y^2 = X(X+1)(X+q^2), compute the
\\ minimal model, conductor N(E), analytic rank.
\\
\\ Output: list of all (q, N(E), analytic_rank) sorted by N(E) up to NMAX,
\\ with rank >= 1 highlighted.

default(parisize, 4000000000);
default(realprecision, 38);

MMAX = 30;    \\ m up to 30 generates ~hundreds of Pythagorean q
NMAX = 10^6;  \\ only retain curves with conductor <= 10^6

\\ Build list of distinct Pythagorean q in lowest terms.
{
  pyth_set = Set();
  for(m = 2, MMAX,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        q1 = (m^2 - n^2)/(2*m*n);
        q2 = (2*m*n)/(m^2 - n^2);
        pyth_set = setunion(pyth_set, Set([q1, q2]));
      );
    );
  );
  pyth = vecsort(Vec(pyth_set));
  print("Total distinct Pythagorean q from m <= ", MMAX, ": ", #pyth);
}

\\ Compute conductor and analytic rank for each q.
\\ Many curves will be huge; skip if conductor > NMAX.

results = List();
skipped_big_N = 0;
rank0 = 0;
rank1 = 0;
rank2plus = 0;

{
  for(i = 1, #pyth,
    q = pyth[i];
    if(q == 0 || q == 1 || q == -1, next);
    a2_co = 1 + q^2;
    a4_co = q^2;
    E = ellinit([0, a2_co, 0, a4_co, 0]);
    Emin = ellminimalmodel(E);
    NE = ellglobalred(Emin)[1];
    if(NE > NMAX, skipped_big_N = skipped_big_N + 1; next);
    \\ Analytic rank
    ar = ellanalyticrank(Emin)[1];
    if(ar == 0, rank0 = rank0 + 1);
    if(ar == 1, rank1 = rank1 + 1);
    if(ar >= 2, rank2plus = rank2plus + 1);
    listput(results, [q, NE, ar]);
    if(ar >= 1,
      print("  q=", q, "  N=", NE, "  ar=", ar);
    );
  );
  print();
  print("==== Survey summary ====");
  print("Pythagorean q tried:           ", #pyth);
  print("Conductors > ", NMAX, ":        ", skipped_big_N);
  print("Curves analyzed (N <= NMAX):   ", #results);
  print("  rank 0:                      ", rank0);
  print("  rank 1:                      ", rank1);
  print("  rank >= 2:                   ", rank2plus);
  print();
  print("==== Full rank >= 1 list (sorted by N) ====");
  rank_ge_1 = List();
  for(j = 1, #results,
    if(results[j][3] >= 1, listput(rank_ge_1, results[j]));
  );
  rank_ge_1 = vecsort(Vec(rank_ge_1), 2);
  for(j = 1, #rank_ge_1,
    print(j, ".  q=", rank_ge_1[j][1], "  N=", rank_ge_1[j][2], "  ar=", rank_ge_1[j][3]);
  );
}
print();
print("===== End Task B — density survey =====");
quit;

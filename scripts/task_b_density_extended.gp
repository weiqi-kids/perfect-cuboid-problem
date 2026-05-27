\\ Task B (extended): wider Pythagorean q survey.
\\ Identify q <-> 1/q symmetry (canonical "small" q with |q| < 1, say).

default(parisize, 4000000000);
default(realprecision, 30);

MMAX = 60;
NMAX = 5*10^6;

{
  pyth_set = Set();
  for(m = 2, MMAX,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        q1 = (m^2 - n^2)/(2*m*n);
        q2 = (2*m*n)/(m^2 - n^2);
        \\ Canonical representative: |q| < 1 form (smaller of q, 1/q)
        qcan = if(abs(q1) <= 1, q1, q2);
        pyth_set = setunion(pyth_set, Set([qcan]));
      );
    );
  );
  pyth = vecsort(Vec(pyth_set));
  print("Total distinct Pythagorean canonical q (|q|<=1) from m <= ", MMAX, ": ", #pyth);
}

results = List();
skipped_big_N = 0;
rank0 = 0;
rank_ge1_list = List();

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
    ar = ellanalyticrank(Emin, 0.01)[1];
    listput(results, [q, NE, ar]);
    if(ar == 0, rank0 = rank0 + 1);
    if(ar >= 1, listput(rank_ge1_list, [q, NE, ar]));
  );
  print();
  print("==== Extended survey summary ====");
  print("Canonical Pythagorean q tried:    ", #pyth);
  print("Skipped (N > ", NMAX, "):         ", skipped_big_N);
  print("Analyzed (N <= NMAX):             ", #results);
  print("  rank 0:                         ", rank0);
  print("  rank >= 1:                      ", #rank_ge1_list);
  print();
  print("==== All rank >= 1 canonical q (sorted by N) ====");
  rk = vecsort(Vec(rank_ge1_list), 2);
  for(j = 1, #rk, print(j, ".  q=", rk[j][1], "  N=", rk[j][2], "  ar=", rk[j][3]));
}

print();
print("===== End Task B extended =====");
quit;

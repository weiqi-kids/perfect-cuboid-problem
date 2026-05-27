\\ ====================================================================
\\ Gap 3 extended Pythagorean rank-jump survey
\\ ====================================================================
\\
\\ Author: CL / Lightman Chang (assistant: Claude Opus 4.7)
\\ Date:   2026-05-20
\\
\\ Goal: Extend the rank-jump census from N(E_PCP(q)) <= 5*10^6
\\       (the existing m <= 60 / 23 analyzed fibers) up to N(E) <= NMAX
\\       with m up to MMAX.
\\
\\ For each canonical Pythagorean q = (m^2 - n^2)/(2*m*n) with |q|<=1
\\ (coprime m,n, m+n odd) we form E_PCP(q): Y^2 = X(X+1)(X+q^2),
\\ compute the minimal model, conductor, and rank bounds via
\\ ellanalyticrank (when N small) and ellrank.
\\
\\ Output: a textual census log with one line per fiber including the
\\ canonical q, conductor, and rank-bound triple.

default(parisize, 800000000);
default(realprecision, 30);

MMAX = 200;        \\ m up to 200 → ~6000 canonical Pythagorean q
NMAX = 10^9;       \\ conductor cutoff: 200× larger than previous 5e6
EFFORT = 2;        \\ ellrank effort parameter (pilot shows 2 is fast and accurate)

print("============================================================");
print("Gap 3 extended survey: MMAX = ", MMAX, ", NMAX = ", NMAX);
print("============================================================");

\\ Build canonical Pythagorean q set (|q| <= 1 representative).
{
  pyth_set = Set();
  for(m = 2, MMAX,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        q1 = (m^2 - n^2)/(2*m*n);
        q2 = (2*m*n)/(m^2 - n^2);
        qcan = if(abs(q1) <= 1, q1, q2);
        pyth_set = setunion(pyth_set, Set([qcan]));
      );
    );
  );
  pyth = vecsort(Vec(pyth_set));
  print("Total distinct canonical Pythagorean q from m <= ", MMAX, ": ", #pyth);
}

print();
print("Pass 1: conductor screening");
print();

\\ Pass 1: screen by conductor.
candidates = List();
{
  for(i = 1, #pyth,
    q = pyth[i];
    if(q == 0 || q == 1 || q == -1, next);
    a2_co = 1 + q^2;
    a4_co = q^2;
    E = ellinit([0, a2_co, 0, a4_co, 0]);
    Emin = ellminimalmodel(E);
    NE = ellglobalred(Emin)[1];
    if(NE <= NMAX,
      listput(candidates, [q, NE]);
    );
  );
}
candidates = vecsort(Vec(candidates), 2);
print("Fibers with N(E) <= ", NMAX, ": ", #candidates);
print();

\\ Pass 2: rank analysis on every surviving fiber.
\\ For each, compute ellrank(Emin, EFFORT) which returns [low, high, gens, ...]
print("Pass 2: rank analysis (ellrank effort=", EFFORT, ")");
print();

results = List();
rank0 = 0;
rank1 = 0;
rank2 = 0;
rank3plus = 0;
undetermined = 0;

{
  for(j = 1, #candidates,
    q  = candidates[j][1];
    NE = candidates[j][2];
    a2_co = 1 + q^2;
    a4_co = q^2;
    E = ellinit([0, a2_co, 0, a4_co, 0]);
    Emin = ellminimalmodel(E, &v_min);

    t0 = getwalltime();
    \\ ellrank for arbitrary rank
    rk_info = ellrank(Emin, EFFORT);
    rlow = rk_info[1];
    rhigh = rk_info[2];
    gens = rk_info[4];
    elapsed = (getwalltime() - t0)/1000.0;

    \\ Try analytic rank only for fibers with rank-jump (rlow >= 1) AND moderate N.
    aran = -1;
    if(rlow >= 1 && NE <= 5*10^7,
      iferr(
        aran = ellanalyticrank(Emin, 0.1)[1],
        E_err,
        aran = -1
      );
    );

    if(rlow == rhigh,
      if(rlow == 0, rank0 = rank0 + 1);
      if(rlow == 1, rank1 = rank1 + 1);
      if(rlow == 2, rank2 = rank2 + 1);
      if(rlow >= 3, rank3plus = rank3plus + 1);
    ,
      undetermined = undetermined + 1;
    );

    listput(results, [q, NE, rlow, rhigh, gens, aran, elapsed]);
    print(j, "/", #candidates,
          "  q=", q,
          "  N=", NE,
          "  ellrank=[", rlow, ",", rhigh, "]",
          "  ar=", aran,
          "  ngens=", #gens,
          "  t=", round(elapsed), "s");
  );
}

print();
print("============================================================");
print("CENSUS SUMMARY  (MMAX=", MMAX, ", NMAX=", NMAX, ")");
print("============================================================");
print("Canonical Pythagorean q tried:   ", #pyth);
print("Surviving conductor cutoff:      ", #candidates);
print("  rank = 0:                      ", rank0);
print("  rank = 1:                      ", rank1);
print("  rank = 2:                      ", rank2);
print("  rank >= 3:                     ", rank3plus);
print("  undetermined (low<high):       ", undetermined);
print();

print("============================================================");
print("RANK-JUMP FIBERS (rank >= 1, sorted by N)");
print("============================================================");
{
  rank_ge_1 = List();
  for(j = 1, #results,
    if(results[j][3] >= 1, listput(rank_ge_1, results[j]));
  );
  rk = vecsort(Vec(rank_ge_1), 2);
  for(j = 1, #rk,
    print(j, ".  q=", rk[j][1],
          "  N=", rk[j][2],
          "  ellrank=[", rk[j][3], ",", rk[j][4], "]",
          "  ar=", rk[j][6]);
    print("    gens (on min model) = ", rk[j][5]);
  );
}

print();
print("===== End Gap 3 extended survey =====");
quit;

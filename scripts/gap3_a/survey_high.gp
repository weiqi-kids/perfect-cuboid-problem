\\ ====================================================================
\\ Gap 3 second-pass survey: push N to 10^10 (200× higher)
\\ ====================================================================
\\
\\ Same enumeration but with N(E) <= 10^10. We expect ~hundred fibers
\\ and possibly hit rank-3 cases (PICK-9 found first rank-3 at
\\ (22,17), q=195/748, N ~ 1.9*10^10 — just above our cutoff).
\\
\\ We resume from N > 10^9 to avoid recomputing the lower-N survey.

default(parisize, 800000000);
default(realprecision, 30);

MMAX = 200;
NMIN = 10^9 + 1;
NMAX = 10^10;
EFFORT = 2;

print("============================================================");
print("Gap 3 high-N survey: MMAX=", MMAX, ", NMIN=", NMIN, ", NMAX=", NMAX);
print("============================================================");

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
  print("Total canonical Pythagorean q from m <= ", MMAX, ": ", #pyth);
}

print();
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
    if(NE >= NMIN && NE <= NMAX,
      listput(candidates, [q, NE]);
    );
  );
}
candidates = vecsort(Vec(candidates), 2);
print("Fibers with ", NMIN, " <= N(E) <= ", NMAX, ": ", #candidates);
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
    rk_info = ellrank(Emin, EFFORT);
    rlow = rk_info[1];
    rhigh = rk_info[2];
    gens = rk_info[4];
    elapsed = (getwalltime() - t0)/1000.0;

    if(rlow == rhigh,
      if(rlow == 0, rank0 = rank0 + 1);
      if(rlow == 1, rank1 = rank1 + 1);
      if(rlow == 2, rank2 = rank2 + 1);
      if(rlow >= 3, rank3plus = rank3plus + 1);
    ,
      undetermined = undetermined + 1;
    );

    listput(results, [q, NE, rlow, rhigh, gens, elapsed]);
    print(j, "/", #candidates,
          "  q=", q,
          "  N=", NE,
          "  ellrank=[", rlow, ",", rhigh, "]",
          "  ngens=", #gens,
          "  t=", elapsed, "s");
  );
}

print();
print("============================================================");
print("HIGH-N SUMMARY  (10^9 < N <= 10^10)");
print("============================================================");
print("Fibers analyzed:                  ", #candidates);
print("  rank = 0:                       ", rank0);
print("  rank = 1:                       ", rank1);
print("  rank = 2:                       ", rank2);
print("  rank >= 3:                      ", rank3plus);
print("  undetermined:                   ", undetermined);
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
          "  gens=", rk[j][5]);
  );
}

print();
print("===== End high-N survey =====");
quit;

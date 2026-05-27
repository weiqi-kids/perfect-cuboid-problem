\\ attack_ambig17.gp
\\ For each of the 17 ambiguous fibers (lo=0, up=2), run ellanalyticrank.
\\ If analytic rank = 0 (L(E,1) != 0): true rank = 0 (BSD parity + analytic-rank<=algebraic),
\\   and modular-symbol non-vanishing implies (under BSD, or unconditionally via
\\   Kolyvagin: analytic rank 0 -> rank 0) the curve has rank 0 -> PCP-trivial fiber.
\\ If analytic rank = 2: rank >= 2 unconditionally; try ellrank(_, 5) for generators.
\\ Output: ambig17_attack.txt

default(parisize, 3500000000);
default(timer, 0);

\\ List of 17 ambiguous (m, n) pairs
AMBIG = [[56,41],[60,1],[67,60],[68,41],[68,61],[73,12],[78,25],[84,79],
         [86,15],[89,4],[92,13],[93,80],[94,89],[95,82],[97,82],[100,51],[100,91]];

write("ambig17_attack.txt", "# m  n  q  cond  analytic_rank  Lvalue_or_deriv  result  time_ms");

for(i = 1, #AMBIG,
  pair = AMBIG[i];
  mm = pair[1]; nn = pair[2];
  q = (mm^2 - nn^2) / (2*mm*nn);
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  cond = ellglobalred(Emin)[1];
  print("===== ambig (", mm, ",", nn, ") cond=", cond);
  gettime();
  ar = iferr(ellanalyticrank(Emin, 0.001), ERR, [-1, 0.0]);
  ms = gettime();
  arank = ar[1];
  lval = ar[2];
  print("  ellanalyticrank -> rank=", arank, " L^(rank)=", lval, " in ", ms, " ms");

  result = "UNKNOWN";
  if(arank == 0,
    \\ Analytic rank 0 -> algebraic rank 0 unconditionally (Kolyvagin/Gross-Zagier).
    \\ EPCP fiber with rank 0 + torsion-only -> closed (no nontrivial rational points
    \\ that satisfy Face-3 issquare).
    result = "CLOSED_RANK_0";
  );
  if(arank == 2,
    \\ Unconditionally rank >= 2 (analytic rank). For BSD it's = 2; either way,
    \\ we still need a generator. Try ellrank(_, 5).
    gettime();
    rk = iferr(ellrank(Emin, 5), ERR, [-1,-1,0,[]]);
    ms2 = gettime();
    print("  ellrank(_,5) -> ", rk[1], "..", rk[2], " ngens=", #rk[4], " in ", ms2, " ms");
    if(#rk[4] >= 2,
      result = "RANK_2_GENS_FOUND";
      ,
      result = "RANK_GEQ_2_NO_GENS";
    );
  );
  if(arank == 1,
    \\ Should not happen for r_up=2 cases (analytic rank parity must match BSD parity).
    result = "UNEXPECTED_RANK_1";
  );
  if(arank < 0,
    result = "ELLANALYTICRANK_ERR";
  );

  write("ambig17_attack.txt",
        mm, " ", nn, " ", q, " ", cond, " ", arank, " ", lval, " ", result, " ", ms);
);
print("Done.");
quit;

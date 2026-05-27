\\ attack_r1_67.gp
\\ Aggressive generator search for the 67 "no MW generator" cases.
\\ 66 R1_HIGH_COND_NO_GEN + 1 R2_HARD_RANK2_NO_GENS = 67 fibers.
\\
\\ Strategy per fiber:
\\   1. ellrank(Emin, 5) -> often produces generator at effort 5 even when 3,4 fail.
\\   2. If still no gen and conductor < 10^13, try ellheegner(Emin)
\\      (PARI auto-selects Heegner discriminant).
\\   3. If gen found: pull back to E, scan n*P0 for n = 1..NMAX, check Face-3 issquare.
\\
\\ Each fiber has a per-stage soft timeout via alarm() (60 s for ellrank-5, 60 s for heegner).

default(parisize, 4000000000);
default(timer, 0);
NMAX = 12;

face3_is_square(q, pt) = {
  my(X, Y, denom, c, a3, num, den);
  if(pt == [0], return(-1));
  X = pt[1]; Y = pt[2];
  denom = q^2 - X^2;
  if(denom == 0, return(-2));
  c = 2 * Y * q / denom;
  if(c == 0, return(-3));
  a3 = c^2 + 1 + q^2;
  if(a3 == 0, return(0));
  num = numerator(a3);
  den = denominator(a3);
  return(issquare(num) * issquare(den));
};

\\ Pull a point on Emin back to E using inverse change of variables v.
pullback(Emin, v, P) = {
  if(P == [0], return([0]));
  ellchangepointinv(P, v);
};

direct_scan(E, P0, q, NMAX) = {
  my(nP, hits, sq);
  hits = List();
  nP = P0;
  for(n = 1, NMAX,
    sq = face3_is_square(q, nP);
    if(sq == 1, listput(hits, [n, nP]));
    if(sq == -2, break);
    if(n < NMAX, nP = elladd(E, nP, P0));
  );
  return(Vec(hits));
};

\\ The 67 hard fibers (m, n).
HARD = [[38,35],[52,49],[54,49],[59,50],[61,40],[62,1],[67,4],[67,16],[67,42],
        [68,29],[68,37],[71,30],[71,42],[73,40],[74,63],[74,73],[76,7],[76,29],
        [78,5],[78,7],[79,12],[79,30],[79,44],[79,58],[79,70],[79,78],[81,28],
        [81,50],[81,80],[82,19],[82,23],[82,31],[82,81],[83,4],[84,43],[85,46],
        [86,25],[86,51],[86,53],[86,81],[87,70],[87,86],[88,71],[89,20],[90,67],
        [91,68],[92,19],[92,39],[92,47],[92,61],[92,81],[93,68],[94,17],[94,19],
        [94,21],[94,25],[94,37],[95,68],[97,4],[98,3],[98,9],[99,14],
        [100,53],[100,59],[100,67],[100,99],
        [89,2]];  \\ last is the rank-2 case

write("r1_67_attack.txt",
  "# m  n  q  cond  rank_claim  ngens  hits  result  time_ms");

attack_one(mm, nn) = {
  my(q, E, Emin, v, cond, rk, gens, P0_min, P0, hits, t_ell, t_heeg, success, result, ngens);
  q = (mm^2 - nn^2) / (2*mm*nn);
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  cond = ellglobalred(Emin)[1];
  print("===== (", mm, ",", nn, ") cond=", cond);

  success = 0;
  result = "STILL_HARD";
  gens = [];
  ngens = 0;
  hits = [];
  rk = [-1,-1,0,[]];

  \\ Stage A: ellrank(_, 5)
  gettime();
  rk = iferr(alarm(60, ellrank(Emin, 5)), ERR, [-1,-1,0,[]]);
  t_ell = gettime();
  if(type(rk) == "t_VEC" && #rk >= 4 && #rk[4] >= 1,
    gens = rk[4];
    ngens = #gens;
    print("  ellrank(_,5) -> ", rk[1], "..", rk[2], " ngens=", ngens, " in ", t_ell, " ms");
    success = 1;
  ,
    print("  ellrank(_,5) -> no gen in ", t_ell, " ms");
  );

  \\ Stage B: ellheegner (only if conductor not too huge)
  if(!success && cond < 5*10^13,
    gettime();
    P0_min = iferr(alarm(60, ellheegner(Emin)), ERR, "ERR");
    t_heeg = gettime();
    if(type(P0_min) == "t_VEC" && P0_min != [0],
      \\ Check it's not torsion
      if(ellorder(Emin, P0_min) == 0,
        gens = [P0_min];
        ngens = 1;
        print("  ellheegner -> ", P0_min, " in ", t_heeg, " ms");
        success = 1;
      ,
        print("  ellheegner gave torsion in ", t_heeg, " ms");
      );
    ,
      print("  ellheegner -> ", P0_min, " in ", t_heeg, " ms");
    );
  );

  \\ Stage C: if we have a generator, run direct scan
  if(success && ngens >= 1,
    P0 = pullback(Emin, v, gens[1]);
    hits = direct_scan(E, P0, q, NMAX);
    if(#hits == 0,
      result = "CLOSED_GEN_SCANNED",
      result = concat("HITS_", Str(#hits))
    );
    if(ngens >= 2,
      \\ try second generator too
      my(P1, hits2);
      P1 = pullback(Emin, v, gens[2]);
      hits2 = direct_scan(E, P1, q, NMAX);
      if(#hits2 > 0,
        result = concat("HITS_GEN2_", Str(#hits2));
      );
    );
  );

  write("r1_67_attack.txt",
    mm, " ", nn, " ", q, " ", cond, " ", (if(#rk>=1, rk[1], -1)),
    " ", ngens, " ", #hits, " ", result, " ", (t_ell + (if(success && cond < 5*10^13, 0, 0))));
};

for(i = 1, #HARD,
  pair = HARD[i];
  iferr(attack_one(pair[1], pair[2]), ERR,
    write("r1_67_attack.txt", pair[1], " ", pair[2], " - - - 0 0 ERR_EXCEPTION 0");
  );
);

print("Done.");
quit;

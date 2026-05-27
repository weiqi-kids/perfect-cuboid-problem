/* 11_test_F_on_MW.gp
 *
 * For each known rank-jump Pythagorean fiber, compute MW generators on E_PCP(q),
 * iterate through linear combinations up to bound B = 6 (giving (2B+1)^r ≈ 169 / 2197 / ...),
 * evaluate F(x_P, q) and check issquare.
 *
 * 0 squares would empirically confirm PCP closure on the orbit.
 */
default(parisize, 1000000000);

A = x^2 + 'q^2;
G = (1+'q^2)*x^2 + 4*'q^2*x + 'q^2*(1+'q^2);
F = A * G;

/* Format: [n, m, rank, tag] */
test_fibers = [\
  [3,4,0,"generic"], [5,12,0,"generic"],\
  [7,24,1,"r1"], [20,21,1,"r1"], [48,55,1,"r1"], [39,80,1,"r1"],\
  [225,272,1,"r1"], [13,84,1,"r1"], [44,117,1,"r1"],\
  [11,60,2,"r2"], [17,144,2,"r2"], [104,153,2,"r2"],\
  [52,165,2,"r2"], [55,1512,2,"r2"], [27,364,2,"r2"],\
  [195,748,3,"r3"]\
];

/* For each fiber, compute generators and iterate orbit, test F(x_P, q) issquare */
{
total_squares = 0;
total_evals = 0;
for(i=1, #test_fibers,
  n = test_fibers[i][1];
  m = test_fibers[i][2];
  r_expected = test_fibers[i][3];
  tag = test_fibers[i][4];

  q0 = n/m;
  hsq = m^2 + n^2;
  if(!issquare(hsq),
    print("Skip (",n,",",m,"): not Pythagorean");
    next;
  );

  /* E_PCP(q): integer model [0, m^2+n^2, 0, m^2*n^2, 0] */
  /* Scaling: rational x_orig = X/m^2  (and y_orig = Y/m^3) */
  Epcp = ellinit([0, m^2+n^2, 0, m^2*n^2, 0]);

  /* Get MW generators (in this integer model) */
  er = ellrank(Epcp, 3);  /* effort=3 for harder cases */
  print();
  print("=== (n,m) = (", n, ",", m, ") tag=", tag, " ===");
  print("  ellrank = [", er[1], ",", er[2], "]");
  gens = if(#er >= 4, er[4], []);
  if(gens != [], print("  generators: ", gens));

  if(er[1] != r_expected,
    print("  ! rank mismatch with catalog: expected ", r_expected, " got [", er[1], ",", er[2], "]");
  );

  /* Iterate orbit */
  rank = #gens;
  if(rank > 0,
    bound = if(rank == 1, 12, if(rank == 2, 6, if(rank == 3, 4, 3)));
    /* Generate combinations */
    pts_seen = List();
    if(rank == 0,
      /* No nontrivial generators */
      ,
      /* Recursive enumeration */
      coefs = vector(rank);
      done = 0;
      for(j=1, rank, coefs[j] = -bound);
      cnt = 0;
      while(!done,
        P = ellmul(Epcp, gens[1], coefs[1]);
        for(j=2, rank, P = elladd(Epcp, P, ellmul(Epcp, gens[j], coefs[j])));
        if(P != [0] && P[2] != 0,
          /* Test point: X coordinate of P, scaled back: x_orig = X / m^2 */
          X = P[1];
          x_orig = X / m^2;
          /* Skip degenerate: x = 0, -1, -q^2, ±q */
          if(x_orig != 0 && x_orig != -1 && x_orig != -q0^2 && x_orig != q0 && x_orig != -q0,
            Fval = subst(subst(F, 'q, q0), 'x, x_orig);
            total_evals++;
            if(Fval != 0 && issquare(Fval),
              total_squares++;
              print("    !!! PCP CANDIDATE: (n,m)=(",n,",",m,"), coefs=", coefs, ", x=", x_orig);
              print("    F(x,q) = ", Fval, " = ", sqrtint(Fval)^2);
            );
          );
          cnt++;
        );
        /* increment coefs */
        j = 1;
        while(j <= rank,
          coefs[j]++;
          if(coefs[j] > bound,
            if(j == rank, done = 1);
            coefs[j] = -bound;
            j++;
          , break);
        );
      );
      print("  tested ", cnt, " orbit combinations within bound ±", bound);
    );
  );
);

print();
print("=== TOTALS ===");
print("Total F evaluations: ", total_evals);
print("Total issquare(F) hits: ", total_squares);
if(total_squares == 0,
  print("");
  print("UNIFORM RESULT: 0 PCP candidates across all tested orbit points.");
,
  print("");
  print("!!! ", total_squares, " PCP CANDIDATES FOUND -- INVESTIGATE !!!");
);
}
quit;

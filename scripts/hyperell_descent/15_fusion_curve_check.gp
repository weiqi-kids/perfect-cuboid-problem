/* 15_fusion_curve_check.gp
 *
 * E*(q): v^2 = u(u-1)(u-q^4) -- the "fusion curve"
 * captures simultaneous rational points on E_PCP(q) and E_PCP(q)^(-1).
 *
 * But for PCP we need u = a^2 (a perfect SQUARE).
 *
 * Each generator of E*(q) gives a u value. Check if u is a perfect square.
 * If u = a^2 with a rational, AND a corresponds to a non-degenerate x of E_PCP,
 * then we have a candidate PCP solution!
 */
default(parisize, 1000000000);

print("=== Test E*(q) generators: is u a perfect square? ===");
print();

test_qs = [[3,4], [5,12], [8,15], [7,24], [20,21], [9,40], [12,35], [11,60], [13,84], [27,364], [48,55], [39,80], [17,144], [104,153], [195,748], [44,117], [16,63], [33,56], [65,72]];

{
candidates = 0;
for(i=1, #test_qs,
  n = test_qs[i][1];
  m = test_qs[i][2];
  if(!issquare(m^2+n^2), next);
  /* E*(q) integer model: y^2 = X (X - m^4)(X - n^4), i.e., [0, -(m^4+n^4), 0, m^4*n^4, 0] */
  Estar = ellinit([0, -(m^4+n^4), 0, m^4*n^4, 0]);
  rs = ellrank(Estar, 3);
  print();
  print("=== (n,m) = (", n, ",", m, ") ===");
  print("  ellrank E*: [", rs[1], ",", rs[2], "]");
  gens = if(#rs >= 4, rs[4], []);
  if(rs[1] == 0,
    print("  rank 0 — only torsion. (No new PCP info from E*.)");
  ,
    /* Enumerate orbit */
    print("  generators (integer model): ", gens);
    rank = #gens;
    bound = if(rank == 1, 10, if(rank == 2, 5, 3));
    cnt = 0;
    pts_seen = List();
    coefs = vector(rank);
    for(j=1, rank, coefs[j] = -bound);
    done = 0;
    while(!done,
      P = if(coefs[1] == 0 && rank >= 2 && coefs[2] == 0, [0],
            ellmul(Estar, gens[1], coefs[1]));
      for(j=2, rank, P = elladd(Estar, P, ellmul(Estar, gens[j], coefs[j])));
      if(P != [0] && #P >= 2,
        X = P[1]; /* X coord in integer model */
        /* Original u = X / m^4 */
        u_orig = X / m^4;
        cnt++;
        /* Check if u_orig is a square */
        if(u_orig > 0 && issquare(u_orig) && u_orig != 0 && u_orig != 1,
          a_val = sqrtint(numerator(u_orig)) / sqrtint(denominator(u_orig));
          /* Skip degenerate: a^2 == 1, q^4 i.e., a = ±1, ±q^2 */
          if(a_val != 1 && a_val != -1 && a_val != (n/m)^2 && a_val != -(n/m)^2,
            candidates++;
            print("    !!! u = ", u_orig, " is a perfect SQUARE = (", a_val, ")^2 !!!");
            print("    coefs = ", coefs);
            /* Check if a is x-coord of a rational point of E_PCP */
            yPCP_sq = a_val * (a_val + 1) * (a_val + (n/m)^2);
            yTwist_sq = a_val * (a_val - 1) * (a_val - (n/m)^2);
            print("    y_PCP^2 = ", yPCP_sq, " issquare: ", issquare(yPCP_sq));
            print("    y_twist^2 = ", yTwist_sq, " issquare: ", issquare(yTwist_sq));
            if(issquare(yPCP_sq) && issquare(yTwist_sq),
              print("    *** REAL PCP CANDIDATE *** at q = ", n, "/", m, ", x = ", a_val);
            );
          );
        );
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
    print("  tested ", cnt, " orbit points.");
  );
);

print();
print("Total non-trivial PCP candidates found: ", candidates);
}
quit;

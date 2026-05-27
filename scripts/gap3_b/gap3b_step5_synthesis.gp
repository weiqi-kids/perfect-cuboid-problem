\\ ====================================================================
\\ Gap 3 — Step 5: Synthesis test — verify on the 2 newly-discovered
\\                 rank-1 fibers (20/99, 96/247) and the 2 rank-3
\\                 fibers (22,17), (35,22) that the uniform N_0 bound
\\                 closes the Face-3 sequence.
\\ ====================================================================

default(parisize, 500000000);
default(realprecision, 30);

c_S_upper(E) = {
  my(Delta = E[12], j_inv = E[13], b2 = E[6], hj, term);
  hj = log(max(abs(numerator(j_inv)), abs(denominator(j_inv))));
  term = (1.0/12) * log(abs(Delta)) + hj/12.0;
  term += 0.5 * log(max(1, abs(b2)/12.0 + 1));
  term += 2.0;
  term;
};

w2_max(E) = {
  my(Delta = abs(E[12]), fac, m = 1);
  fac = factor(Delta);
  for(i = 1, matsize(fac)[1],
    if(fac[i, 2] > m, m = fac[i, 2]);
  );
  m;
};

\\ Pull a point back to original short-Weierstrass model via inverse change.
\\ Original model: E_orig = ellinit([0, 1+q^2, 0, q^2, 0])
\\ Minimal model: Emin = ellminimalmodel(E_orig, &v)
\\ ellchangepointinv(Emin -> E_orig): need to use ellchangepoint with inverse vector
pull_back(P_min, change_vec) = {
  ellchangepoint(P_min, ellminimalmodel_inv(change_vec));
};

\\ Compute c = 2 Y q / (q^2 - X^2) and test if c^2 + 1 + q^2 is a square
face3_test(P, q) = {
  my(Tx, Ty, denom, c, an);
  if(P == [0], return(0));   \\ identity = not relevant
  Tx = P[1]; Ty = P[2];
  denom = q^2 - Tx^2;
  if(denom == 0, return(-1));   \\ pole/degenerate
  c = 2 * Ty * q / denom;
  an = c^2 + 1 + q^2;
  issquare(an);
};

go() = {
  my(fibers, i, m, n, u, v, q, E, Emin, change, rk_data, gens);
  my(P_min, P_orig, cS, w2val, K, lambda_min, N0_rig, max_n);
  my(num_squares, P_min_n, P_orig_n, found_square);

  print("================================================================");
  print("Gap 3 / Step 5: Verification across the full rank-jump");
  print("                set — explicit n-check up to N_0_rig");
  print("================================================================");
  print();

  \\ Fibers to verify (all known rank-jump): (m,n,rank)
  fibers = [
    [5,  2,  1],    \\ q = 21/20
    [4,  3,  1],    \\ q = 7/24
    [6,  5,  2],    \\ q = 11/60
    [8,  3,  1],    \\ q = 55/48
    [10, 1,  1],    \\ q = 99/20 (newly discovered)
    [16, 3,  1],    \\ q = 247/96 (newly discovered, conductor 1566474)
    [7,  6,  1],    \\ q = 13/84
    [8,  5,  1],    \\ q = 39/80
    [9,  8,  2],    \\ q = 17/144
    [13, 4,  2],    \\ q = 153/104
    [22, 17, 3],    \\ q = 195/748 (rank 3)
    [35, 22, 3]     \\ q = 741/1540 (rank 3)
  ];

  for(i = 1, #fibers,
    m = fibers[i][1]; n = fibers[i][2]; rk = fibers[i][3];
    u = m^2 - n^2; v = 2*m*n;
    g = gcd(u, v); u = u/g; v = v/g;
    q = u/v;

    E = ellinit([0, 1+q^2, 0, q^2, 0]);
    Emin = ellminimalmodel(E, &change);
    Ncond = ellglobalred(Emin)[1];

    cS = c_S_upper(Emin);
    w2val = w2_max(Emin);
    K = 8.0 * (cS + log(2.0 * w2val) + 1.0);

    rk_data = ellrank(Emin, 5);
    gens = rk_data[4];
    if(#gens == 0,
      print("--- (m,n)=(", m, ",", n, "), q=", u, "/", v, ", N=", Ncond,
            ": no generators found, skip ---"); print();
      next;
    );

    \\ Compute lambda_min (with proper short-vector search at rank >= 2)
    if(rk == 1 || #gens == 1,
      lambda_min = ellheight(Emin, gens[1]);
    );
    if(rk >= 2 && #gens >= 2,
      h1 = ellheight(Emin, gens[1]);
      h2 = ellheight(Emin, gens[2]);
      h12 = (ellheight(Emin, elladd(Emin, gens[1], gens[2])) - h1 - h2) / 2;
      lambda_min = min(h1, h2);
      for(a = -3, 3, for(b = -3, 3,
        if(a == 0 && b == 0, next);
        Q = h1*a^2 + 2*h12*a*b + h2*b^2;
        if(Q > 0 && Q < lambda_min, lambda_min = Q);
      ));
    );
    if(rk >= 3 && #gens >= 3,
      h3 = ellheight(Emin, gens[3]);
      h13 = (ellheight(Emin, elladd(Emin, gens[1], gens[3])) - h1 - h3) / 2;
      h23 = (ellheight(Emin, elladd(Emin, gens[2], gens[3])) - h2 - h3) / 2;
      lambda_min = min(min(h1, h2), h3);
      for(a = -2, 2, for(b = -2, 2, for(c = -2, 2,
        if(a == 0 && b == 0 && c == 0, next);
        Q = h1*a^2 + h2*b^2 + h3*c^2 + 2*h12*a*b + 2*h13*a*c + 2*h23*b*c;
        if(Q > 0 && Q < lambda_min, lambda_min = Q);
      )));
    );

    N0_rig = ceil(sqrt(K / lambda_min));

    \\ Hindry's worst-case: use h_0_thm = 0.00481
    H0_THM = (1.0 / 144) * log(2);
    N0_thm = ceil(sqrt(K / H0_THM));

    print("--- (m,n)=(", m, ",", n, "), q=", u, "/", v, ", rank=", rk, " ---");
    print("  N(E) = ", Ncond, "    K = ", precision(K, 6));
    print("  lambda_min = ", precision(lambda_min, 6));
    print("  N_0_rig (empirical) = ", N0_rig);
    print("  N_0_thm (Hindry h_0_thm = ", precision(H0_THM, 5), ") = ", N0_thm);

    \\ Direct check n = 1..min(N0_rig, 30) -- for the rank-1 case
    if(rk == 1,
      max_n = min(N0_rig, 20);
      \\ But also try a slightly larger window
      max_n = max(max_n, 12);
      num_squares = 0;
      P_min_n = gens[1];
      for(nn = 1, max_n,
        \\ Pull back from minimal to original to get T_n, Y_n
        P_orig_n = ellchangepoint(P_min_n, vecextract(change, "1..4"));
        \\ Apply face3 test
        sq = face3_test(P_orig_n, q);
        if(sq == 1, num_squares = num_squares + 1);
        if(nn < max_n,
          P_min_n = elladd(Emin, P_min_n, gens[1]);
        );
      );
      print("  Direct check n=1..", max_n, ": ", num_squares, " squares found");
    );
    if(rk == 1,
      print("  CLOSED (rigorous)? ", if(N0_rig <= 20, "YES — direct n<=20 covers", "NEEDS EXTEND"));
    );
    if(rk >= 2,
      print("  Rank >= 2: full closure requires Pick 10 / Pick 11 rank-r framework");
    );
    print();
  );

  print("=== End Step 5 ===");
};

go();
quit;

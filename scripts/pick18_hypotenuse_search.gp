\\ ============================================================
\\ PICK-18: SHARED HYPOTENUSE REFORMULATION OF PCP
\\ ------------------------------------------------------------
\\ For a Perfect Cuboid (a,b,c,d,e,f,g):
\\   a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2, a^2+b^2+c^2=g^2
\\ Subtracting from g^2:
\\   g^2 - a^2 = e^2  => (a,e,g) Pythagorean
\\   g^2 - b^2 = f^2  => (b,f,g) Pythagorean
\\   g^2 - c^2 = d^2  => (c,d,g) Pythagorean
\\ So g must be hypotenuse of 3 distinct Pythagorean triples
\\ sharing the SAME hypotenuse g. Plus extra constraints:
\\   a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2.
\\ ============================================================

\\ ------------------------------------------------------------
\\ Step 1: For each g, enumerate all (x,y) with 0<x<y, x^2+y^2=g^2.
\\ ------------------------------------------------------------

pyth_reps(g) = {
  my(sols = List(), g2 = g^2, lim);
  lim = sqrtint(g2 \ 2);  \\ x < y means x^2 < g^2/2
  for(x = 1, lim,
    my(y2 = g2 - x^2);
    if(issquare(y2),
      my(y = sqrtint(y2));
      if(x < y, listput(sols, [x, y]));
    );
  );
  Vec(sols);
}

\\ ------------------------------------------------------------
\\ Step 2: g must have >=3 distinct prime factors p ≡ 1 (mod 4).
\\ ------------------------------------------------------------

count_pyth_primes(g) = {
  my(f = factor(g), cnt = 0);
  for(i = 1, matsize(f)[1],
    if(f[i,1] % 4 == 1, cnt++);
  );
  cnt;
}

\\ Number of distinct (x,y) representations: for g = product of k distinct
\\ primes ≡ 1 mod 4 with exponents all 1, the count of essentially distinct
\\ representations of g^2 = x^2+y^2 with 0<=x<=y is (3^k+1)/2 minus
\\ the trivial g^2 = 0^2 + g^2 (x=0). We want x>0, y>0, x<y => count = (3^k-1)/2.

predicted_reps(g) = {
  my(f = factor(g), k = 0, ok = 1);
  for(i = 1, matsize(f)[1],
    my(p = f[i,1], e = f[i,2]);
    if(p == 2, ok = 1, \\ factor of 2 contributes nothing extra here
      if(p % 4 == 1, k = k + e, ok = 0);
    );
  );
  if(!ok, return(0));
  (3^k - 1) / 2;
}

\\ ------------------------------------------------------------
\\ Step 3: enumerate candidate g values
\\ Build g = product of >=3 distinct primes ≡ 1 (mod 4), possibly
\\ multiplied by 2's and primes ≡ 3 mod 4 (which keep the count).
\\ We focus on the "primitive" case: g = squarefree product of primes ≡ 1 mod 4.
\\ ------------------------------------------------------------

\\ Get primes ≡ 1 mod 4 up to N
primes_1mod4(N) = {
  my(L = List());
  forprime(p = 5, N, if(p % 4 == 1, listput(L, p)));
  Vec(L);
}

\\ Generate squarefree products of >=3 primes from list, up to bound B
gen_candidates_3prime(plist, B) = {
  my(L = List(), n = #plist);
  for(i = 1, n - 2,
    for(j = i+1, n - 1,
      if(plist[i] * plist[j] > B, break);
      for(k = j+1, n,
        my(g = plist[i] * plist[j] * plist[k]);
        if(g > B, break);
        listput(L, g);
      );
    );
  );
  vecsort(Vec(L));
}

\\ Generate squarefree products of >=4 primes from list, up to bound B
gen_candidates_4prime(plist, B) = {
  my(L = List(), n = #plist);
  for(i = 1, n - 3,
    for(j = i+1, n - 2,
      if(plist[i] * plist[j] > B, break);
      for(k = j+1, n - 1,
        if(plist[i] * plist[j] * plist[k] > B, break);
        for(l = k+1, n,
          my(g = plist[i] * plist[j] * plist[k] * plist[l]);
          if(g > B, break);
          listput(L, g);
        );
      );
    );
  );
  vecsort(Vec(L));
}

\\ ------------------------------------------------------------
\\ Step 4: For each g, try all PCP assignments
\\
\\ Given pairs P = [(x_i, y_i)]: we need to pick three (possibly overlapping)
\\ index choices (i, j, k) and an assignment of which entry plays which role.
\\
\\ Roles: (a, e), (b, f), (c, d).
\\ Meaning: from triple (a,e,g): leg a, leg e (which plays role e^2 = g^2 - a^2)
\\         from triple (b,f,g): leg b, leg f
\\         from triple (c,d,g): leg c, leg d
\\ Within each Pythagorean pair (x,y) with x^2+y^2=g^2, EITHER {a=x,e=y} OR {a=y,e=x}
\\ (analogously for b,f and c,d).
\\
\\ Then check:
\\   a^2 + b^2 == d^2  (where d comes from the (c,d) pair, the OTHER element)
\\   b^2 + c^2 == e^2  (e is partner of a in its pair)
\\   a^2 + c^2 == f^2  (f is partner of b in its pair)
\\
\\ Note: a,b,c are PCP edges, and d=hyp(a,b), e=hyp(b,c), f=hyp(a,c).
\\ Within shared-g framework, (a,e), (b,f), (c,d) are the three pairs.
\\ ------------------------------------------------------------

check_pcp_for_g(g, verbose=0) = {
  my(P = pyth_reps(g), n, found = 0, count_tests = 0);
  n = #P;
  if(n < 3, return([0, 0]));
  if(verbose, print("  g=", g, " n_reps=", n));

  \\ Iterate over ordered triples of (possibly different) pair indices
  \\ for the three Pythagorean triples (a,e,g), (b,f,g), (c,d,g).
  \\ We allow distinct pairs because a,b,c are distinct edges of cuboid.
  \\ For each pair index, we have 2 choices of which element is "first role"
  \\ (a, b, c respectively) and which is "second role" (e, f, d).
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(k = 1, n, if(k == i || k == j, next);
        \\ Pair i provides (a, e); pair j provides (b, f); pair k provides (c, d)
        for(si = 0, 1,
          my(a, e);
          if(si == 0, a = P[i][1]; e = P[i][2], a = P[i][2]; e = P[i][1]);
          for(sj = 0, 1,
            my(b, f);
            if(sj == 0, b = P[j][1]; f = P[j][2], b = P[j][2]; f = P[j][1]);
            for(sk = 0, 1,
              my(c, d);
              if(sk == 0, c = P[k][1]; d = P[k][2], c = P[k][2]; d = P[k][1]);
              count_tests++;
              \\ Sanity: a^2+e^2=g^2, b^2+f^2=g^2, c^2+d^2=g^2 are automatic
              \\ Check PCP face equations:
              if(a^2 + b^2 == d^2 && b^2 + c^2 == e^2 && a^2 + c^2 == f^2,
                print("    *** PCP FOUND *** g=", g, " a=", a, " b=", b, " c=", c,
                      " d=", d, " e=", e, " f=", f);
                found++;
              );
            );
          );
        );
      );
    );
  );
  [found, count_tests];
}

\\ ------------------------------------------------------------
\\ Diagnostic counters and partial-condition counters
\\ ------------------------------------------------------------
\\ Count how often each individual face equation is satisfied across
\\ all g <= BOUND. This reveals whether the obstruction is global.

diagnostic_for_g(g) = {
  my(P = pyth_reps(g), n, c_ab = 0, c_bc = 0, c_ac = 0, c_all = 0);
  n = #P;
  if(n < 3, return([0, 0, 0, 0, n]));
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(k = 1, n, if(k == i || k == j, next);
        for(si = 0, 1, for(sj = 0, 1, for(sk = 0, 1,
          my(a, e, b, f, c, d);
          if(si == 0, a = P[i][1]; e = P[i][2], a = P[i][2]; e = P[i][1]);
          if(sj == 0, b = P[j][1]; f = P[j][2], b = P[j][2]; f = P[j][1]);
          if(sk == 0, c = P[k][1]; d = P[k][2], c = P[k][2]; d = P[k][1]);
          my(ok1 = (a^2 + b^2 == d^2), ok2 = (b^2 + c^2 == e^2), ok3 = (a^2 + c^2 == f^2));
          if(ok1, c_ab++);
          if(ok2, c_bc++);
          if(ok3, c_ac++);
          if(ok1 && ok2 && ok3, c_all++);
        )));
      );
    );
  );
  [c_ab, c_bc, c_ac, c_all, n];
}

\\ ------------------------------------------------------------
\\ Main driver
\\ ------------------------------------------------------------

main() = {
  print("========================================================");
  print("PICK-18 SHARED-HYPOTENUSE ENUMERATION FOR PCP");
  print("========================================================");

  \\ Phase A: enumerate small g with 3 primes ≡ 1 mod 4
  my(BOUND = 200000);   \\ search up to this g
  my(PMAX  = 1000);     \\ primes ≡ 1 mod 4 up to this
  my(plist = primes_1mod4(PMAX));
  print("\nNumber of primes ≡ 1 (mod 4) up to ", PMAX, ": ", #plist);
  print("First 10: ", vector(min(10,#plist), i, plist[i]));

  my(cands3 = gen_candidates_3prime(plist, BOUND));
  my(cands4 = gen_candidates_4prime(plist, BOUND));
  print("\nCandidates with exactly 3 distinct primes ≡ 1 mod 4, g <= ", BOUND, ": ", #cands3);
  print("Candidates with exactly 4 distinct primes ≡ 1 mod 4, g <= ", BOUND, ": ", #cands4);
  print("First 10 of 3-prime: ", vector(min(10,#cands3), i, cands3[i]));
  if(#cands4 > 0, print("First 5 of 4-prime: ", vector(min(5,#cands4), i, cands4[i])));

  \\ Phase B: sanity-check rep count predictions
  print("\n--- Sanity-check (3^k-1)/2 prediction ---");
  for(idx = 1, min(5, #cands3),
    my(g = cands3[idx], P = pyth_reps(g), pred = predicted_reps(g));
    print("  g=", g, " actual #reps=", #P, " predicted=", pred);
  );
  if(#cands4 >= 1,
    for(idx = 1, min(3, #cands4),
      my(g = cands4[idx], P = pyth_reps(g), pred = predicted_reps(g));
      print("  g=", g, " actual #reps=", #P, " predicted=", pred);
    );
  );

  \\ Phase C: enumerate PCP for each candidate g
  print("\n--- Enumerating PCP for 3-prime g ---");
  my(total_tests = 0, total_found = 0, total_partials = [0,0,0]);
  for(idx = 1, #cands3,
    my(g = cands3[idx]);
    my(diag = diagnostic_for_g(g));
    total_partials[1] += diag[1];
    total_partials[2] += diag[2];
    total_partials[3] += diag[3];
    total_tests += 8 * diag[5] * (diag[5]-1) * (diag[5]-2);  \\ ordered triples * 2^3 signs
    total_found  += diag[4];
    if(diag[4] > 0,
      print("  !!! g=", g, " yields ", diag[4], " PCP-satisfying assignments");
    );
    \\ Periodic progress
    if(idx % 50 == 0,
      print("  progress idx=", idx, "/", #cands3, " g=", g,
            " tests so far=", total_tests, " found=", total_found);
    );
  );

  print("\n--- Enumerating PCP for 4-prime g ---");
  for(idx = 1, #cands4,
    my(g = cands4[idx]);
    my(diag = diagnostic_for_g(g));
    total_partials[1] += diag[1];
    total_partials[2] += diag[2];
    total_partials[3] += diag[3];
    total_tests += 8 * diag[5] * (diag[5]-1) * (diag[5]-2);
    total_found  += diag[4];
    if(diag[4] > 0,
      print("  !!! g=", g, " yields ", diag[4], " PCP-satisfying assignments");
    );
    if(idx % 20 == 0,
      print("  progress idx=", idx, "/", #cands4, " g=", g,
            " tests so far=", total_tests, " found=", total_found);
    );
  );

  print("\n========================================================");
  print("SUMMARY");
  print("========================================================");
  print("Bound on g                  : ", BOUND);
  print("Candidates (3 prime)        : ", #cands3);
  print("Candidates (4 prime)        : ", #cands4);
  print("Total tests run             : ", total_tests);
  print("Partial hits a^2+b^2=d^2    : ", total_partials[1]);
  print("Partial hits b^2+c^2=e^2    : ", total_partials[2]);
  print("Partial hits a^2+c^2=f^2    : ", total_partials[3]);
  print("Full PCP solutions found    : ", total_found);
  if(total_found == 0,
    print("\nNo PCP found in shared-hypotenuse enumeration up to g <= ", BOUND, ".");
  );
}

\\ ------------------------------------------------------------
\\ Step 5: structural / Gaussian-integer analysis on g = 1105
\\ For g = p1*p2*p3 with p_i ≡ 1 mod 4, write p_i = pi_i * pibar_i in Z[i].
\\ Then g^2 = prod (pi_i * pibar_i)^2. The Z[i] representations of g^2
\\ correspond to choices x+iy = (sign) * prod pi_i^{e_i} * pibar_i^{2-e_i}
\\ with e_i in {0,1,2}, modulo units and conjugation.
\\ We print the explicit Gaussian factorizations and the (x,y) pairs they yield.
\\ ------------------------------------------------------------

gaussian_struct_dump(g) = {
  print("\n--- Gaussian-integer structure dump for g=", g, " ---");
  my(P = pyth_reps(g));
  print("Representations g^2 = x^2+y^2 (0<x<y):");
  for(i = 1, #P,
    print("  (", P[i][1], ", ", P[i][2], ")  check: ", P[i][1]^2 + P[i][2]^2, " vs g^2=", g^2);
  );
  \\ Pairwise structural check: for distinct pairs (x1,y1), (x2,y2),
  \\ is x1^2 + x2^2 a perfect square? (would-be d when a=x1, b=x2.)
  print("\nPairwise leg-sum-square table (does x_i^2 + x_j^2 = square?):");
  for(i = 1, #P,
    for(j = i+1, #P,
      for(si = 0, 1, for(sj = 0, 1,
        my(a, b);
        a = if(si == 0, P[i][1], P[i][2]);
        b = if(sj == 0, P[j][1], P[j][2]);
        if(a < b,  \\ avoid double print
          my(s = a^2 + b^2);
          if(issquare(s),
            print("  a=", a, " b=", b, " a^2+b^2=", sqrtint(s), "^2  *** square hit ***");
          );
        );
      ));
    );
  );
}

\\ ------------------------------------------------------------
\\ Run
\\ ------------------------------------------------------------
main();
gaussian_struct_dump(1105);
gaussian_struct_dump(1885);
print("\nDONE.");
quit;

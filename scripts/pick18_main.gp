\\ ============================================================
\\ PICK-18 MAIN: shared-hypotenuse PCP enumeration
\\ ============================================================

gauss_prime(p) = {
  my(sol = qfbsolve(Qfb(1,0,1), p));
  if(type(sol) == "t_INT", error("not representable: ", p));
  my(a = abs(sol[1]), b = abs(sol[2]));
  if(a > b, [b, a], [a, b]);
}
gmul(z1, z2) = [z1[1]*z2[1] - z1[2]*z2[2], z1[1]*z2[2] + z1[2]*z2[1]];
gconj(z) = [z[1], -z[2]];

all_reps_g2(g) = {
  my(fac = factor(g), k = matsize(fac)[1]);
  my(splits = List(), inert_factor = 1, ram_exp_in_g = 0);
  for(i = 1, k,
    my(p = fac[i,1], e = fac[i,2]);
    if(p == 2, ram_exp_in_g = e,
      if(p % 4 == 1, listput(splits, [p, e]),
        inert_factor *= p^e;
      );
    );
  );
  splits = Vec(splits);
  my(reps = List());
  my(scale = 2^ram_exp_in_g * inert_factor);
  my(k2 = #splits);
  my(gprimes = vector(k2, i, gauss_prime(splits[i][1])));
  my(maxs = vector(k2, i, 2 * splits[i][2]));
  forvec(A = vector(k2, i, [0, maxs[i]]),
    my(z = [1, 0]);
    for(i = 1, k2,
      my(pi = gprimes[i], pibar = gconj(pi));
      my(ai = A[i]);
      for(t = 1, ai, z = gmul(z, pi));
      for(t = 1, maxs[i] - ai, z = gmul(z, pibar));
    );
    my(x = abs(z[1]) * scale, y = abs(z[2]) * scale);
    if(x > y, my(t = x); x = y; y = t);
    if(x > 0, listput(reps, [x, y]));
  );
  Vec(Set(Vec(reps)));
}

\\ Count distinct primes ≡ 1 mod 4 in g (with multiplicity, for representation count)
\\ Actually, the number of essentially distinct reps of g^2 depends on full factorization.
\\ We restrict to g with >= 3 distinct primes ≡ 1 mod 4 (could repeat, or include 2's, 3 mod 4)
\\ For PCP enumeration we want at least 3 reps available — equivalent to at least 3 distinct primes ≡ 1 mod 4 when squarefree.

count_split_primes_dist(g) = {
  my(f = factor(g), cnt = 0);
  for(i = 1, matsize(f)[1], if(f[i,1] % 4 == 1, cnt++));
  cnt;
}

\\ ----- PCP enumeration over reps -----
\\ Given reps P (list of [x,y]): try all ordered (i,j,k) of distinct indices
\\ and all 2^3 sign-swap choices. Check three face equations.

diagnostic_for_g(g) = {
  my(P = all_reps_g2(g), n, c_ab = 0, c_bc = 0, c_ac = 0, c_all = 0, found_list = List());
  n = #P;
  if(n < 3, return([0, 0, 0, 0, n, Vec(found_list)]));
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(k = 1, n, if(k == i || k == j, next);
        for(si = 0, 1, for(sj = 0, 1, for(sk = 0, 1,
          my(a, e, b, f, c, d);
          if(si == 0, a = P[i][1]; e = P[i][2], a = P[i][2]; e = P[i][1]);
          if(sj == 0, b = P[j][1]; f = P[j][2], b = P[j][2]; f = P[j][1]);
          if(sk == 0, c = P[k][1]; d = P[k][2], c = P[k][2]; d = P[k][1]);
          my(ok1 = (a^2 + b^2 == d^2));
          my(ok2 = (b^2 + c^2 == e^2));
          my(ok3 = (a^2 + c^2 == f^2));
          if(ok1, c_ab++);
          if(ok2, c_bc++);
          if(ok3, c_ac++);
          if(ok1 && ok2 && ok3,
            c_all++;
            listput(found_list, [a,b,c,d,e,f,g]);
          );
        )));
      );
    );
  );
  [c_ab, c_bc, c_ac, c_all, n, Vec(found_list)];
}

\\ ----- Candidate generators -----
primes_1mod4(N) = {
  my(L = List());
  forprime(p = 5, N, if(p % 4 == 1, listput(L, p)));
  Vec(L);
}

\\ Generate squarefree g with exactly r distinct primes ≡ 1 mod 4 (no other prime factors)
gen_squarefree(plist, r, B) = {
  my(L = List(), n = #plist);
  if(r == 3,
    for(i = 1, n - 2, for(j = i+1, n - 1,
      if(plist[i] * plist[j] > B, break);
      for(k = j+1, n,
        my(g = plist[i] * plist[j] * plist[k]);
        if(g > B, break);
        listput(L, g);
      );
    ));
  );
  if(r == 4,
    for(i = 1, n - 3, for(j = i+1, n - 2,
      if(plist[i] * plist[j] > B, break);
      for(k = j+1, n - 1,
        if(plist[i] * plist[j] * plist[k] > B, break);
        for(l = k+1, n,
          my(g = plist[i] * plist[j] * plist[k] * plist[l]);
          if(g > B, break);
          listput(L, g);
        );
      );
    ));
  );
  if(r == 5,
    for(i = 1, n - 4, for(j = i+1, n - 3,
      if(plist[i] * plist[j] > B, break);
      for(k = j+1, n - 2, if(plist[i]*plist[j]*plist[k] > B, break);
        for(l = k+1, n - 1, if(plist[i]*plist[j]*plist[k]*plist[l] > B, break);
          for(m = l+1, n,
            my(g = plist[i]*plist[j]*plist[k]*plist[l]*plist[m]);
            if(g > B, break);
            listput(L, g);
          );
        );
      );
    ));
  );
  vecsort(Vec(L));
}

\\ ----- MAIN -----

main(BOUND) = {
  print("========================================================");
  print("PICK-18 SHARED-HYPOTENUSE ENUMERATION  BOUND = ", BOUND);
  print("========================================================");
  my(PMAX = BOUND);
  my(plist = primes_1mod4(PMAX));
  print("Primes ≡ 1 mod 4 up to ", PMAX, ": ", #plist);

  my(cands3 = gen_squarefree(plist, 3, BOUND));
  my(cands4 = gen_squarefree(plist, 4, BOUND));
  my(cands5 = gen_squarefree(plist, 5, BOUND));
  print("3-prime squarefree candidates: ", #cands3);
  print("4-prime squarefree candidates: ", #cands4);
  print("5-prime squarefree candidates: ", #cands5);

  my(total_found = 0, total_partials = [0,0,0], total_tests = 0);
  my(max_g_tested = 0);
  my(all_finds = List());

  \\ 3-prime
  print("\n-- 3-prime g enumeration --");
  for(idx = 1, #cands3,
    my(g = cands3[idx], diag = diagnostic_for_g(g));
    total_partials[1] += diag[1]; total_partials[2] += diag[2]; total_partials[3] += diag[3];
    total_found += diag[4];
    total_tests += 8 * diag[5] * (diag[5]-1) * (diag[5]-2);
    if(g > max_g_tested, max_g_tested = g);
    if(diag[4] > 0,
      print("  !!!! PCP at g=", g, " count=", diag[4]);
      for(t = 1, #diag[6], listput(all_finds, diag[6][t]));
    );
    if(idx % 200 == 0, print("  3p progress ", idx, "/", #cands3, " g=", g, " found=", total_found));
  );

  \\ 4-prime
  print("\n-- 4-prime g enumeration --");
  for(idx = 1, #cands4,
    my(g = cands4[idx], diag = diagnostic_for_g(g));
    total_partials[1] += diag[1]; total_partials[2] += diag[2]; total_partials[3] += diag[3];
    total_found += diag[4];
    total_tests += 8 * diag[5] * (diag[5]-1) * (diag[5]-2);
    if(g > max_g_tested, max_g_tested = g);
    if(diag[4] > 0,
      print("  !!!! PCP at g=", g, " count=", diag[4]);
      for(t = 1, #diag[6], listput(all_finds, diag[6][t]));
    );
    if(idx % 100 == 0, print("  4p progress ", idx, "/", #cands4, " g=", g, " found=", total_found));
  );

  \\ 5-prime
  print("\n-- 5-prime g enumeration --");
  for(idx = 1, #cands5,
    my(g = cands5[idx], diag = diagnostic_for_g(g));
    total_partials[1] += diag[1]; total_partials[2] += diag[2]; total_partials[3] += diag[3];
    total_found += diag[4];
    total_tests += 8 * diag[5] * (diag[5]-1) * (diag[5]-2);
    if(g > max_g_tested, max_g_tested = g);
    if(diag[4] > 0,
      print("  !!!! PCP at g=", g, " count=", diag[4]);
      for(t = 1, #diag[6], listput(all_finds, diag[6][t]));
    );
    if(idx % 20 == 0, print("  5p progress ", idx, "/", #cands5, " g=", g, " found=", total_found));
  );

  print("\n========================================================");
  print("SUMMARY  (BOUND = ", BOUND, ")");
  print("========================================================");
  print("max g tested        : ", max_g_tested);
  print("# 3-prime candidates: ", #cands3);
  print("# 4-prime candidates: ", #cands4);
  print("# 5-prime candidates: ", #cands5);
  print("total test cases    : ", total_tests);
  print("partial a^2+b^2=d^2 : ", total_partials[1]);
  print("partial b^2+c^2=e^2 : ", total_partials[2]);
  print("partial a^2+c^2=f^2 : ", total_partials[3]);
  print("full PCP found      : ", total_found);
  if(total_found > 0,
    print("\nPCP SOLUTIONS:");
    for(i = 1, #all_finds, print("  ", all_finds[i]));
  );
}

main(200000);
quit;

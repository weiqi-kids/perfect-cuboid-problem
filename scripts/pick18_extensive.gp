\\ Extensive search: enumerate ALL g up to BOUND with >= 3 distinct primes ≡ 1 mod 4
\\ (squarefree odd, also include those with factor 2 or factor ≡ 3 mod 4).
\\ For each g, run the full PCP test (diagnostic). Track:
\\   - any full PCP found
\\   - any "two-out-of-three" hits (refinement of partial counter)
\\   - any d ∈ legs(g) hit

gauss_prime(p) = { my(sol = qfbsolve(Qfb(1,0,1), p)); my(a=abs(sol[1]),b=abs(sol[2])); if(a>b,[b,a],[a,b]); }
gmul(z1,z2) = [z1[1]*z2[1]-z1[2]*z2[2], z1[1]*z2[2]+z1[2]*z2[1]];
gconj(z) = [z[1], -z[2]];

all_reps_g2(g) = {
  my(fac = factor(g), splits = List(), inert_factor = 1, ram_exp_in_g = 0);
  for(i = 1, matsize(fac)[1],
    my(p = fac[i,1], e = fac[i,2]);
    if(p == 2, ram_exp_in_g = e, if(p % 4 == 1, listput(splits, [p, e]), inert_factor *= p^e));
  );
  splits = Vec(splits);
  my(reps = List(), scale = 2^ram_exp_in_g * inert_factor, k2 = #splits);
  my(gprimes = vector(k2, i, gauss_prime(splits[i][1])));
  my(maxs = vector(k2, i, 2 * splits[i][2]));
  forvec(A = vector(k2, i, [0, maxs[i]]),
    my(z = [1, 0]);
    for(i = 1, k2,
      my(pi = gprimes[i], pibar = gconj(pi), ai = A[i]);
      for(t = 1, ai, z = gmul(z, pi));
      for(t = 1, maxs[i] - ai, z = gmul(z, pibar));
    );
    my(x = abs(z[1])*scale, y = abs(z[2])*scale);
    if(x > y, my(t = x); x = y; y = t);
    if(x > 0, listput(reps, [x, y]));
  );
  Vec(Set(Vec(reps)));
}

legs_of_g(g) = {
  my(R = all_reps_g2(g), L = List());
  for(i = 1, #R, listput(L, R[i][1]); listput(L, R[i][2]));
  Set(Vec(L));
}

\\ For a given g, find all (a, b, d, c) such that:
\\   a, e both legs of pair P_i; b, f both legs of pair P_j (i != j)
\\   a^2 + b^2 = d^2  (NEW SQUARE)
\\   AND d is a leg of g (i.e. there exists c with c^2 + d^2 = g^2)
\\   AND a^2 + c^2 = f^2 AND b^2 + c^2 = e^2
\\
\\ Implementation: iterate over (i, j, si, sj) for (a, b); compute d = sqrt(a^2+b^2);
\\ check if d in legs; then c = sqrt(g^2 - d^2); verify the remaining two equations.

deep_scan(g) = {
  my(R = all_reps_g2(g), n = #R, legs = legs_of_g(g));
  my(found = List(), pairhits = 0, leghits = 0);
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(si = 0, 1, for(sj = 0, 1,
        my(a = if(si==0, R[i][1], R[i][2]));
        my(b = if(sj==0, R[j][1], R[j][2]));
        my(s = a^2 + b^2);
        if(issquare(s),
          pairhits++;
          my(d = sqrtint(s));
          if(setsearch(legs, d) > 0,
            leghits++;
            my(c2 = g^2 - d^2);
            if(c2 > 0 && issquare(c2),
              my(c = sqrtint(c2));
              \\ Now check a^2 + c^2 and b^2 + c^2
              my(s1 = a^2 + c^2, s2 = b^2 + c^2);
              if(issquare(s1) && issquare(s2),
                listput(found, [a, b, c, d, sqrtint(s2), sqrtint(s1), g]);
                print("    *** PCP FOUND *** g=", g, " (a,b,c,d,e,f)=(", a, ",", b, ",", c, ",", d, ",",
                      sqrtint(s2), ",", sqrtint(s1), ")");
              );
            );
          );
        );
      ));
    );
  );
  [pairhits, leghits, #found, Vec(found)];
}

run(BOUND) = {
  print("Deep scan up to BOUND = ", BOUND);
  my(total_pair = 0, total_leg = 0, total_full = 0, max_g = 0, cnt = 0);
  forstep(g = 5, BOUND, 1,
    \\ Quick filter: skip g without >= 3 distinct primes ≡ 1 mod 4
    my(f = factor(g), nsp = 0);
    for(i = 1, matsize(f)[1], if(f[i,1] % 4 == 1, nsp++));
    if(nsp < 3, next);
    cnt++;
    my(res = deep_scan(g));
    total_pair += res[1]; total_leg += res[2]; total_full += res[3];
    if(g > max_g, max_g = g);
    if(res[2] > 0, print("  g=", g, "  pair_hits=", res[1], "  leg_hits=", res[2], "  full=", res[3]));
    if(cnt % 100 == 0, print("  scanned ", cnt, " candidates, current g=", g));
  );
  print("\nFinal: max_g=", max_g, " candidates=", cnt, " total_pair=", total_pair,
        " total_leg=", total_leg, " full_PCP=", total_full);
}

run(200000);
quit;

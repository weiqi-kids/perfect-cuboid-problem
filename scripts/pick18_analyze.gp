\\ Analyse why no a^2+b^2 is a perfect square for legs (a,b) of shared-hyp triples

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

dump_g(g) = {
  my(R = all_reps_g2(g), n);
  n = #R;
  print("\ng = ", g, " (", factor(g)[,1]~, "), n_reps = ", n);
  print("(x, y, x mod 4, y mod 4, x mod 8, y mod 8):");
  for(i = 1, n,
    my(x = R[i][1], y = R[i][2]);
    print("  ", x, "  ", y, "  ", x%4, "  ", y%4, "  ", x%8, "  ", y%8);
  );
}

modular_scan(g) = {
  my(R = all_reps_g2(g), n, tot = 0, fail4 = 0, fail8 = 0, fail_other = 0, hits = 0);
  n = #R;
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(si = 0, 1, for(sj = 0, 1,
        my(a = if(si==0, R[i][1], R[i][2]));
        my(b = if(sj==0, R[j][1], R[j][2]));
        my(s = a^2 + b^2);
        tot++;
        if(s % 4 == 2 || s % 4 == 3, fail4++,
          if(!issquare(s),
            if(s % 8 != 0 && s % 8 != 1 && s % 8 != 4, fail8++, fail_other++);
          ,
            hits++;
          );
        );
      ));
    );
  );
  print("g=", g, "  tot=", tot, "  fail_mod4=", fail4, "  fail_mod8=", fail8,
        "  fail_other=", fail_other, "  hits=", hits);
}

\\ Run for several g
dump_g(1105);
modular_scan(1105);
dump_g(1885);
modular_scan(1885);
dump_g(2210);
modular_scan(2210);
dump_g(5*13*17*29);  \\ 32045
modular_scan(5*13*17*29);

\\ Hypothesis: in every (x,y) for g odd, one is even one is odd.
\\ Pair (i,j) sign choices: (si, sj) ∈ {0,1}^2. Let pi[i] = parity of R[i][1].
\\ Then a's parity = pi[i] if si=0 else 1-pi[i]. Same for b.
\\ Same parity iff (si, sj) such that pi[i] XOR si == pi[j] XOR sj.
\\ Per (i,j), exactly 2 of 4 sign choices give same parity, 2 give different.
\\ Different parity: a^2+b^2 ≡ 1 mod 4 (possibly square).
\\ Same parity: both odd ⇒ a^2+b^2 ≡ 2 mod 4 (NEVER square);
\\              both even ⇒ a^2+b^2 ≡ 0 mod 4 (possibly square).
\\
\\ For g odd, in ANY rep (x,y) with x²+y²=g²: WLOG x odd, y even.
\\ Then "both even" requires si and sj both selecting the even component.
\\ That's 1 of 4 sign choices. So per (i,j): 1 "both even", 1 "both odd", 2 "mixed parity".
\\
\\ Mixed: a^2+b^2 ≡ 1 mod 4 (passes mod 4)
\\ Both even: a^2+b^2 ≡ 0 mod 4 (passes mod 4)
\\ Both odd: ≡ 2 mod 4 (fails)

\\ So roughly 1/4 of (si,sj) FAIL just on mod 4.

print("\nPredicted: per pair (i,j), 1/4 of sign-choices fail by mod 4.");
print("For g=1105 with n=13 reps, n*(n-1)=156 (i,j); times 4 sign = 624.");
print("Expected mod 4 fails ≈ 624/4 = 156.");

quit;

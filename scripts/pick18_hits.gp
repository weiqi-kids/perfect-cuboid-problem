\\ For g=1105, find all (a,b) with a^2+b^2 = perfect square, where a,b come from
\\ shared-hyp legs. Then check if the resulting d is itself a leg of some pair.

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

\\ Collect "legs" of g: all values appearing as x or y in some rep.
legs_of_g(g) = {
  my(R = all_reps_g2(g), L = List());
  for(i = 1, #R, listput(L, R[i][1]); listput(L, R[i][2]));
  Set(Vec(L));
}

scan_full(g) = {
  my(R = all_reps_g2(g), n = #R, legs = legs_of_g(g));
  my(legset = setbinop((x,y)->x, legs));  \\ trick to get a set
  print("\ng=", g, " n_reps=", n, " #legs=", #legs);
  print("  legs: ", legs);
  \\ Find all (a, b) from distinct pairs with a^2+b^2 = perfect square
  my(square_hits = List());
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(si = 0, 1, for(sj = 0, 1,
        my(a = if(si==0, R[i][1], R[i][2]));
        my(b = if(sj==0, R[j][1], R[j][2]));
        my(s = a^2 + b^2);
        if(issquare(s),
          my(d = sqrtint(s));
          \\ Is d also a leg?
          my(d_is_leg = setsearch(legs, d) > 0);
          listput(square_hits, [a, b, d, d_is_leg, i, j]);
        );
      ));
    );
  );
  print("\nPair hits (a, b, d=sqrt(a^2+b^2), d_is_leg, i, j):");
  for(t = 1, #square_hits, print("  ", square_hits[t]));
}

scan_full(1105);
scan_full(1885);
scan_full(2210);
scan_full(5*13*17*29);
scan_full(5*13*17*37);

quit;

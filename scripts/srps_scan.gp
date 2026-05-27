\\ Compute legs(g) for squarefree g with all primes != 3 mod 4.
\\ Then find all pair-hits (a,b) in legs(g)^2 with a^2+b^2 = d^2,
\\ check if d in legs(g).

compute_legs(g) = {
  my(fct, primes, n, legs, pi_list, exps_max, alpha, p, pi, pibar, re, im, sol);
  fct = factor(g);
  primes = fct[,1];
  n = #primes;
  legs = List();
  pi_list = vector(n);
  for(i=1, n,
    p = primes[i];
    if(p == 2,
      pi_list[i] = 1 + Mod(x, x^2+1)
    ,
      if(Mod(p, 4) == 1,
        sol = qfbsolve(Qfb(1,0,1), p);
        pi_list[i] = sol[1] + sol[2] * Mod(x, x^2+1)
      ,
        pi_list[i] = p
      )
    )
  );
  exps_max = vector(n, i, 2 * fct[i,2]);
  forvec(v = vector(n, i, [0, exps_max[i]]),
    alpha = Mod(1, x^2+1);
    for(i=1, n,
      pi = pi_list[i];
      pibar = conj(pi);
      alpha = alpha * pi^v[i] * pibar^(exps_max[i] - v[i])
    );
    re = abs(polcoeff(lift(alpha), 0));
    im = abs(polcoeff(lift(alpha), 1));
    if(re != 0 && im != 0,
      listput(legs, re);
      listput(legs, im)
    )
  );
  vecsort(Vec(Set(legs)))
}

find_pair_hits(g) = {
  my(L, hits, leg_hits, a, b, d, L_set, NL);
  L = compute_legs(g);
  L_set = Set(L);
  NL = #L;
  hits = 0;
  leg_hits = 0;
  for(i=1, NL,
    for(j=i+1, NL,
      a = L[i]; b = L[j];
      if(issquare(a^2 + b^2),
        d = sqrtint(a^2 + b^2);
        hits = hits + 1;
        if(setsearch(L_set, d) > 0,
          leg_hits = leg_hits + 1;
          print("    LEG-HIT g=", g, " (a,b,d)=(", a, ",", b, ",", d, ")")
        )
      )
    )
  );
  [hits, leg_hits, NL]
}

\\ Test
print("=== Test g = 1105 ===");
res = find_pair_hits(1105);
print("  #legs = ", res[3], ", pair-hits = ", res[1], ", leg-hits = ", res[2]);

print("=== Test g = 1885 ===");
res = find_pair_hits(1885);
print("  #legs = ", res[3], ", pair-hits = ", res[1], ", leg-hits = ", res[2]);

print("=== Test g = 32045 ===");
res = find_pair_hits(32045);
print("  #legs = ", res[3], ", pair-hits = ", res[1], ", leg-hits = ", res[2]);

print("=== Test g = 86173 ===");
res = find_pair_hits(86173);
print("  #legs = ", res[3], ", pair-hits = ", res[1], ", leg-hits = ", res[2]);

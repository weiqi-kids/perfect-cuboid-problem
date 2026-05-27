\\ For pair hits (a, b, d) with a^2 + b^2 = d^2, factor d and see whether d's
\\ prime factorization contains the primes of g. The criterion "d is a leg of g"
\\ requires that g^2 - d^2 is a perfect square, equivalently d corresponds to a
\\ Gaussian-integer divisor of g^2.

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

\\ For g, find pair hits (a,b,d) and print Gaussian-prime supports
analyse_pairs(g) = {
  my(R = all_reps_g2(g), n = #R);
  print("\n=== g = ", g, " = ", factor(g), " ===");
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(si = 0, 1, for(sj = 0, 1,
        my(a = if(si==0, R[i][1], R[i][2]));
        my(b = if(sj==0, R[j][1], R[j][2]));
        my(s = a^2 + b^2);
        if(issquare(s),
          my(d = sqrtint(s));
          \\ Skip d >= g (impossible for PCP anyway)
          if(d < g,
            print("  a=", a, " b=", b, " d=", d, " g=", g);
            print("    a = ", factor(a));
            print("    b = ", factor(b));
            print("    d = ", factor(d));
            print("    gcd(d, g) = ", gcd(d, g));
            \\ Crucial: d is a leg of g iff g^2 - d^2 is a perfect square,
            \\ iff the Gaussian prime factorization of (g+id)(g-id) [= g^2-d^2 + 0i? no]
            \\ Actually: g^2 - d^2 = (g-d)(g+d), both ints.
            \\ This is square iff (g-d)(g+d) is square — needs (g-d) and (g+d) to share structure.
            print("    (g-d) = ", factor(g - d), "   (g+d) = ", factor(g + d));
            print("    g^2 - d^2 = ", g^2 - d^2, "  square? ", issquare(g^2 - d^2));
          );
        );
      ));
    );
  );
}

\\ The case g=86173 we saw was suspicious. Let's enumerate more g where d < g.
\\ This requires a^2+b^2 < g^2, i.e., we use "small" legs of two pairs.
\\ Search up to g = 100000.

\\ Just show g=86173 in detail
analyse_pairs(86173);

\\ Look for any other small-d hits in 200k < g < 400k
scan_for_smalld(LO, HI) = {
  my(cnt = 0, hits = 0);
  forstep(g = LO, HI, 1,
    my(f = factor(g), nsp = 0);
    for(i = 1, matsize(f)[1], if(f[i,1] % 4 == 1, nsp++));
    if(nsp < 3, next);
    cnt++;
    my(R = all_reps_g2(g), n = #R);
    for(i = 1, n,
      for(j = 1, n, if(j == i, next);
        for(si = 0, 1, for(sj = 0, 1,
          my(a = if(si==0, R[i][1], R[i][2]));
          my(b = if(sj==0, R[j][1], R[j][2]));
          my(s = a^2 + b^2);
          if(issquare(s),
            my(d = sqrtint(s));
            if(d < g && issquare(g^2 - d^2),
              hits++;
              my(c = sqrtint(g^2 - d^2));
              \\ Now we have (a,b,c,d) with a^2+b^2=d^2, c^2+d^2=g^2.
              \\ Need also a^2+c^2 = perfect square (=f^2), b^2+c^2 = perfect square (=e^2).
              my(ok1 = issquare(a^2+c^2), ok2 = issquare(b^2+c^2));
              print("  HIT g=", g, " a=", a, " b=", b, " c=", c, " d=", d,
                    "  a^2+c^2 sq? ", ok1, "  b^2+c^2 sq? ", ok2);
              if(ok1 && ok2,
                print("    !!!! FULL PCP !!!! ");
              );
            );
          );
        ));
      );
    );
  );
  print("scan ", LO, "..", HI, ": ", cnt, " candidates, ", hits, " (a,b,d) with d<g & d leg of g");
}

\\ Find d < g cases efficiently
scan_for_smalld(50000, 200000);

quit;

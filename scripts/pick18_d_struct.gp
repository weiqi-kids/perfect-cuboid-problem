\\ For all pair hits (a, b, d) where d = sqrt(a^2+b^2), study d's structure:
\\ - Does d's hypotenuse-set contain g? i.e., is there h with d^2 + something^2 = h^2 and h | g, etc?
\\ - More specifically: PCP needs three pairs sharing hypotenuse g where the
\\   "third legs" interlock. The hit table shows there exist (a, b) with a^2+b^2=d^2
\\   BUT d > g (i.e., d itself is bigger than g!). Let's verify.

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

\\ Theoretical observation:
\\ In a PCP (a,b,c,d,e,f,g):
\\   a^2+b^2=d^2  =>  d <= sqrt(a^2+b^2) < sqrt(g^2) = g  iff  a^2+b^2 < g^2
\\   a^2+b^2+c^2 = g^2  with c > 0  =>  a^2+b^2 < g^2  =>  d < g.
\\ So d < g STRICTLY. In particular, d MUST be smaller than g.
\\
\\ Yet our hit list shows d > g in almost every case! Let's check:

check_d_vs_g(g) = {
  my(R = all_reps_g2(g), n = #R);
  print("\ng=", g);
  for(i = 1, n,
    for(j = 1, n, if(j == i, next);
      for(si = 0, 1, for(sj = 0, 1,
        my(a = if(si==0, R[i][1], R[i][2]));
        my(b = if(sj==0, R[j][1], R[j][2]));
        my(s = a^2 + b^2);
        if(issquare(s),
          my(d = sqrtint(s));
          if(d <= g - 1, print("  *** d < g hit: a=", a, " b=", b, " d=", d, " g=", g, " ***");
          ,
            \\ silently skip; d >= g case is structurally impossible for PCP
          );
        );
      ));
    );
  );
}

drive() = {
  forprime(p1 = 5, 50,
    if(p1 % 4 == 1,
      forprime(p2 = p1+1, 100,
        if(p2 % 4 == 1,
          forprime(p3 = p2+1, 200,
            if(p3 % 4 == 1,
              my(g = p1 * p2 * p3);
              if(g <= 100000, check_d_vs_g(g));
            );
          );
        );
      );
    );
  );
}
drive();
quit;

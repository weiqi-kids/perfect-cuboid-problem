\\ ============================================================
\\ Frobenius trace t_1 on H^2(V'_min) for primes p up to 29.
\\ V' : a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2 in P^5.
\\
\\ Smart count via:
\\   #V'_aff(F_p) = sum_{a,b,c} n_d(a^2+b^2)*n_e(b^2+c^2)*n_f(a^2+c^2)
\\   where n(s)=1 if s=0, 2 if s a nonzero square, 0 else.
\\ #V'_sing(F_p)_proj = (#V'_aff - 1)/(p-1).
\\ Minimal resolution adds 12*p points.
\\
\\ t_1 = #V'_min(F_p) - 1 - p^2.
\\ ============================================================

countAff(p) = {
  my(N = 0);
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        my(s1 = (a*a + b*b) % p);
        my(s2 = (b*b + c*c) % p);
        my(s3 = (a*a + c*c) % p);
        my(nd, ne, nf);
        if(s1 == 0, nd = 1, nd = if(issquare(Mod(s1, p)), 2, 0));
        if(s2 == 0, ne = 1, ne = if(issquare(Mod(s2, p)), 2, 0));
        if(s3 == 0, nf = 1, nf = if(issquare(Mod(s3, p)), 2, 0));
        N += nd * ne * nf;
      )
    )
  );
  N
}

{
  print("=== Frobenius trace t_1 for V'_min (good primes) ===");
  print("p  | #V'_aff    | #V'_proj | #V'_min   | t_1 = #-1-p^2 | t_1/p");
  print("---+------------+----------+-----------+---------------+--------");
  forprime(p = 3, 29,
    my(N = countAff(p));
    my(Nproj = (N - 1)/(p-1));
    my(Nmin = Nproj + 12*p);
    my(t1 = Nmin - 1 - p^2);
    print(p, " | ", N, " | ", Nproj, " | ", Nmin, " | ", t1, " | ", t1*1.0/p);
  );
}

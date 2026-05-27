\\ Verify F_{p^2} counting for p=3, p=5
\\ Wrapped in a function.

countV_q(p, k) = {
  my(q = p^k, T, x, elems, N = 0);
  if(k == 1,
    \\ direct enumeration
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
    return(N);
  );
  T = ffinit(p, k);
  x = ffgen(T, 'x);
  elems = vector(q);
  elems[1] = x*0;
  for(i = 1, q-1, elems[i+1] = x^(i-1));

  \\ Quick test: count squares
  my(sq_count = 0);
  for(i = 1, q,
    if(elems[i] != 0,
      if(elems[i]^((q-1)/2) == 1, sq_count++);
    )
  );

  for(ia = 1, q,
    my(A = elems[ia]);
    for(ib = 1, q,
      my(B = elems[ib]);
      for(ic = 1, q,
        my(C = elems[ic]);
        my(s1 = A^2 + B^2);
        my(s2 = B^2 + C^2);
        my(s3 = A^2 + C^2);
        my(nd, ne, nf);
        nd = if(s1 == 0, 1, if(s1^((q-1)/2) == 1, 2, 0));
        ne = if(s2 == 0, 1, if(s2^((q-1)/2) == 1, 2, 0));
        nf = if(s3 == 0, 1, if(s3^((q-1)/2) == 1, 2, 0));
        N += nd * ne * nf;
      )
    )
  );
  N;
}

\\ Sanity: countV_q(p, 1) should equal direct.
{
  print("=== Self-test: F_p counts ===");
  forprime(p = 3, 13,
    print("p=", p, " F_p count: ", countV_q(p, 1));
  );

  print("");
  print("=== F_{p^2} counts (slow for large p) ===");
  forprime(p = 3, 7,
    my(N = countV_q(p, 2));
    my(Nproj = (N - 1)/(p^2 - 1));
    my(Nmin = Nproj + 12 * p^2);
    my(t2 = Nmin - 1 - p^4);
    print("p=", p, " (q=", p^2, "): aff=", N, " proj_sing=", Nproj, " V'_min=", Nmin, " t_2=", t2);
    \\ Sanity: |t_2| <= 22 * p^2
    print("  bound: |t_2| <= 22*p^2 = ", 22*p^2);
  );
}

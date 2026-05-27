\\ ============================================================
\\ Full L-polynomial extraction at p=3 from Newton sums.
\\ We need t_1, t_2, ..., t_k for k up to (b_2 - ρ_alg)/2 to determine
\\ the transcendental factor.
\\
\\ At p=3: t_1 = 38, t_2 = 166 (computed).
\\ Now compute t_3 from #V'_min(F_{27}).
\\ ============================================================

countV_q(p, k) = {
  my(q = p^k, N = 0);
  if(k == 1,
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

  my(T = ffinit(p, k), xx = ffgen(T, 'xx));
  \\ Enumerate as F_p-linear combinations of {1, xx, xx^2, ..., xx^(k-1)}
  my(elems = vector(q));
  \\ For k=2: i + j*xx, i,j in F_p
  \\ For k=3: i + j*xx + l*xx^2, i,j,l in F_p
  if(k == 2,
    for(i = 0, p-1,
      for(j = 0, p-1,
        elems[i*p + j + 1] = i + j * xx;
      )
    );
  );
  if(k == 3,
    for(i = 0, p-1,
      for(j = 0, p-1,
        for(l = 0, p-1,
          elems[i*p^2 + j*p + l + 1] = i + j * xx + l * xx^2;
        )
      )
    );
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

{
  print("=== Newton sums at p=3 ===");
  print("");
  my(p = 3);
  for(k = 1, 3,
    my(q = p^k);
    my(N = countV_q(p, k));
    my(Nproj = (N - 1)/(q - 1));
    my(Nmin = Nproj + 12 * q);
    my(tk = Nmin - 1 - p^(2*k));
    print("k=", k, " q=", q, ": #V'_min(F_q)=", Nmin, " t_k=tr(Frob^k|H^2)=", tk, " (bound ", 22*p^k, ")");
  );

  print("");
  print("=== Newton sums at p=5 ===");
  print("");
  my(p = 5);
  for(k = 1, 2,
    my(q = p^k);
    my(N = countV_q(p, k));
    my(Nproj = (N - 1)/(q - 1));
    my(Nmin = Nproj + 12 * q;);
    my(tk = Nmin - 1 - p^(2*k));
    print("k=", k, " q=", q, ": #V'_min(F_q)=", Nmin, " t_k=tr(Frob^k|H^2)=", tk, " (bound ", 22*p^k, ")");
  );
}

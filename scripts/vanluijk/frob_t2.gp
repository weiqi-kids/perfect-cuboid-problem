\\ ============================================================
\\ Compute t_2 = trace(Frob^2 | H^2) via #V'_min(F_{p^2}).
\\ Already computed for p=3,5,7 in PICK-15. Extend to p=11.
\\
\\ #V'_min(F_q) = #V'_sing_proj(F_q) + 12*q  for K3 with 12 rational nodes.
\\ t_k = #V'_min(F_{p^k}) - 1 - p^(2k).
\\
\\ For p=11, q=121: enumerate F_121 = F_11[X]/(T) where T is irreducible.
\\ This is 11^6 = 1.77 million tuples. Borderline feasible.
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
  \\ k = 2 case
  my(T = ffinit(p, k), xx = ffgen(T, 'xx));
  my(elems = vector(q));
  for(i = 0, p-1,
    for(j = 0, p-1,
      elems[i*p + j + 1] = i + j * xx;
    )
  );
  for(ia = 1, q,
    my(A = elems[ia], A2 = A^2);
    for(ib = 1, q,
      my(B = elems[ib], B2 = B^2);
      my(s1 = A2 + B2);
      my(nd = if(s1 == 0, 1, if(s1^((q-1)/2) == 1, 2, 0)));
      if(nd == 0, next);  \\ early skip
      for(ic = 1, q,
        my(C = elems[ic], C2 = C^2);
        my(s2 = B2 + C2);
        my(s3 = A2 + C2);
        my(ne = if(s2 == 0, 1, if(s2^((q-1)/2) == 1, 2, 0)));
        my(nf = if(s3 == 0, 1, if(s3^((q-1)/2) == 1, 2, 0)));
        N += nd * ne * nf;
      )
    )
  );
  N
}

{
  print("=== t_2 for p=11 (and re-verify p=3,5,7) ===");
  foreach([3, 5, 7, 11], p,
    print1("p=", p, " computing... ");
    my(N = countV_q(p, 2));
    my(q = p^2);
    my(Nproj = (N - 1)/(q - 1));
    my(Nmin = Nproj + 12*q);
    my(t2 = Nmin - 1 - p^4);
    print(" aff=", N, " proj=", Nproj, " min=", Nmin, " t_2=", t2, " (bound ", 22*q, ")");
  );
}

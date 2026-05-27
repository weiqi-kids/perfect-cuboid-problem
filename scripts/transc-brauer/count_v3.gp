\\ ============================================================
\\ FIXED F_q enumeration using ALL elements as F_p-linear combos
\\ of {1, x, x^2, ..., x^(k-1)} where x is a root of T(X).
\\
\\ For F_{p^k}: q = p^k elements = {sum_{i=0}^{k-1} c_i * x^i : c_i in F_p}.
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
  \\ k = 2: enumerate as a + b*x where x^2 + ... = 0 (T).
  my(T = ffinit(p, k), xx = ffgen(T, 'xx));
  \\ Build list of all q elements as F_p-combinations of {1, xx}.
  my(elems = vector(q));
  for(i = 0, p-1,
    for(j = 0, p-1,
      elems[i*p + j + 1] = i + j * xx;  \\ NOTE: this gives an F_q element
    )
  );

  \\ Sanity: count squares
  my(sqc = 0);
  for(i = 1, q,
    if(elems[i] != 0 && elems[i]^((q-1)/2) == 1, sqc++);
  );
  print("F_", q, ": nonzero squares = ", sqc, " (expected ", (q-1)/2, ")");

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
  print("=== Recomputing #V'(F_{p^2}) with FIXED enumeration ===");
  forprime(p = 3, 7,
    my(N = countV_q(p, 2));
    my(Nproj = (N - 1)/(p^2 - 1));
    my(Nmin = Nproj + 12 * p^2);
    my(t2 = Nmin - 1 - p^4);
    print("p=", p, " (q=", p^2, "): aff=", N, " proj_sing=", Nproj, " V'_min=", Nmin, " t_2=", t2, " (bound: |t_2| <= ", 22*p^2, ")");
  );
}

\\ Compute t_3 at p=3 by counting #V'(F_{27}).
\\ q = 27 = 3^3, so we enumerate F_27 elements as F_3-linear combos
\\ of {1, x, x^2} where x is a root of an irreducible cubic over F_3.

countV_q(p, k) = {
  my(q = p^k, N = 0);
  my(T = ffinit(p, k), xx = ffgen(T, 'xx));
  my(elems = vector(q));
  my(idx = 1);
  for(i = 0, p-1,
    for(j = 0, p-1,
      for(l = 0, p-1,
        elems[idx] = i + j*xx + l*xx^2;
        idx += 1;
      )
    )
  );
  for(ia = 1, q,
    my(A = elems[ia], A2 = A^2);
    for(ib = 1, q,
      my(B = elems[ib], B2 = B^2);
      my(s1 = A2 + B2);
      my(nd = if(s1 == 0, 1, if(s1^((q-1)/2) == 1, 2, 0)));
      if(nd == 0, next);
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
  print("=== t_3 at p=3 (F_27) ===");
  my(p = 3, k = 3, q = p^k);
  my(N = countV_q(p, k));
  my(Nproj = (N - 1)/(q - 1));
  my(Nmin = Nproj + 12*q);
  my(t3 = Nmin - 1 - p^(2*k));
  print("p=", p, " k=", k, " q=", q);
  print("  aff=", N, " proj=", Nproj, " min=", Nmin, " t_3=", t3);
  print("  Theoretical bound |t_3| <= 22 p^3 = ", 22*p^k);
}

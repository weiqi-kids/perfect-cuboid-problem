\\ Determine actual dimension of V' and verify its arithmetic class.
\\ #V'(F_p) ~ p^d for d = dim V'. If V' is a surface (d=2): expect O(p^2).
\\
\\ Look at ratios.

countV_smart(p) = {
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
  N;
}

{
  print("p   | #V'_aff | #V'_proj | ratio proj/p^2");
  print("----+---------+----------+----------------");
  forprime(p = 3, 23,
    my(N = countV_smart(p));
    my(Nproj = (N - 1)/(p - 1));
    print(p, "  | ", N, "  | ", Nproj, "  | ", 1.0 * Nproj / p^2);
  );
}

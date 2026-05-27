\\ ============================================================
\\ Count F_p-points on the RESOLUTION V'_min of the Euler-brick K3.
\\ V'_sing has 12 nodes (A_1) at:
\\   [0:0:1:0:±1:±1], [0:1:0:±1:±1:0], [1:0:0:±1:0:±1]    (12 total)
\\
\\ Each node, when blown up, is replaced by an exceptional P^1.
\\ For F_p-rational nodes: #blown-up - #removed-node = (p+1) - 1 = p.
\\ All 12 nodes have coords in {0,±1}, so they are Q-rational and hence
\\ F_p-rational for any odd p. (Each node is also F_p-rational because
\\ 0, 1, -1 all live in F_p.)
\\
\\ Thus: #V'_min(F_p) = #V'_sing(F_p) - 12 + 12*(p+1) = #V'_sing(F_p) + 12*p.
\\
\\ Lefschetz on V'_min (smooth K3):
\\   #V'_min(F_p) = 1 + tr(Frob|H^2(V'_min)) + p^2
\\ ============================================================

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

\\ #V'_sing(F_p) projective
countVsing_proj(p) = (countV_smart(p) - 1) / (p - 1);

\\ #V'_min(F_p) accounting for the 12 nodes
\\ All 12 nodes are F_p-rational for p odd, so add 12p.
countVmin(p) = countVsing_proj(p) + 12 * p;

\\ Trace of Frobenius on H^2(V'_min)
trace_H2_min(p) = countVmin(p) - 1 - p^2;

\\ Also count #V'_sing(F_p^2) and compare
\\ For F_p^2 the same code, just over F_{p^2}.
\\ But this is expensive. Alternative: use the relation
\\   #X(F_{p^k}) = 1 + sum_i α_i^k + p^{2k}
\\ where α_i are the eigenvalues. With #X(F_p) and #X(F_{p^2}),
\\ we get the moments t_1 = sum α_i, t_2 = sum α_i^2.

countV_smart_q(q) = {
  \\ q = p^k as a Mod-modulus.... no, q is an actual finite field size.
  \\ For q = p^2, work in GF(p^2). Use ffinit() to get a model.
  my(p = factor(q)[1,1], k = factor(q)[1,2], T, x, N = 0);
  if(k == 1, return(countV_smart(p)));
  T = ffinit(p, k);
  \\ x is a generator of F_q
  x = ffgen(T, 'x);
  \\ Enumerate F_q as 0, 1, x, x^2, ..., x^{q-2} powers and 0
  my(elems = vector(q));
  elems[1] = x*0;  \\ zero
  for(i = 1, q-1, elems[i+1] = x^(i-1));
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
        \\ Number of solutions y^2 = s in F_q:
        \\   if s = 0: 1; if s nonzero square: 2; else 0.
        \\ Squareness in F_q: s is a square iff s = 0 or s^((q-1)/2) = 1.
        nd = if(s1 == 0, 1, if(s1^((q-1)/2) == 1, 2, 0));
        ne = if(s2 == 0, 1, if(s2^((q-1)/2) == 1, 2, 0));
        nf = if(s3 == 0, 1, if(s3^((q-1)/2) == 1, 2, 0));
        N += nd * ne * nf;
      )
    )
  );
  N;
}

\\ Project count over F_q for V'_sing
countVsing_proj_q(q) = (countV_smart_q(q) - 1) / (q - 1);

\\ V'_min over F_q: still 12 rational nodes => +12*q
countVmin_q(q) = countVsing_proj_q(q) + 12 * q;

\\ Trace formulas for K3
\\   #X(F_p) = 1 + t1 + p^2,   t1 = sum α_i,  |α_i|=p
\\   #X(F_p^2) = 1 + t2 + p^4, t2 = sum α_i^2, eigenvalues α_i^2 of Frob^2.

{
  print("Computing #V'_min(F_p), #V'_min(F_p^2), Frobenius moments");
  print("");
  print("p  | #V'_sing(F_p) | #V'_min(F_p) | t_1 = tr(Frob|H^2)");
  print("---+---------------+--------------+--------------------");
  forprime(p = 3, 13,
    my(Ns = countVsing_proj(p));
    my(Nm = countVmin(p));
    my(t = Nm - 1 - p^2);
    print(p, "  | ", Ns, "         | ", Nm, "        | ", t);
  );

  print("");
  print("p  | #V'_min(F_p^2) | t_2 = tr(Frob^2|H^2)");
  print("---+----------------+---------------------");
  forprime(p = 3, 7,
    my(Nm2 = countVmin_q(p^2));
    my(t2 = Nm2 - 1 - p^4);
    print(p, "  | ", Nm2, "         | ", t2);
  );
}

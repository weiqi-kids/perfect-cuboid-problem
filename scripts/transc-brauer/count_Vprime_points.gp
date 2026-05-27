\\ ============================================================
\\ Count F_p-points on the Euler-brick K3 V' for small primes p
\\ V' ⊂ P^5 cut out by:
\\   Q1: a^2 + b^2 - d^2 = 0
\\   Q2: b^2 + c^2 - e^2 = 0
\\   Q3: a^2 + c^2 - f^2 = 0
\\ This is a smooth K3 (3 quadrics in P^5) of degree 8.
\\
\\ Lefschetz fixed-point on a K3:
\\   #V'(F_p) = 1 + p^2 + p * tr(Frob_p | H^2)
\\ ============================================================

\\ Count affine solutions over F_p^k (in 6-dim space, then project)
\\ For an irreducible affine variety of dim d, #X^aff(F_p) ~ p^d + ...
\\ V' is a surface, projectively, so the affine cone has dim 3.
\\ We count #(F_p^6 satisfying 3 quadrics, [a:b:c:d:e:f] not all zero),
\\ then divide by (p-1) to get projective count.

countVprime(p) = {
  my(N = 0, a, b, c, d, e, f, q1, q2, q3);
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        \\ For each (a,b,c) need d^2 = a^2+b^2, e^2 = b^2+c^2, f^2 = a^2+c^2
        my(s1 = Mod(a^2 + b^2, p));
        my(s2 = Mod(b^2 + c^2, p));
        my(s3 = Mod(a^2 + c^2, p));
        \\ count solutions for d, e, f independently
        my(nd, ne, nf);
        nd = if(s1 == 0, 1, if(issquare(s1), 2, 0));
        ne = if(s2 == 0, 1, if(issquare(s2), 2, 0));
        nf = if(s3 == 0, 1, if(issquare(s3), 2, 0));
        N += nd * ne * nf;
      )
    )
  );
  \\ Subtract origin (0,0,0,0,0,0)
  N -= 1;
  \\ Divide by p-1 to get projective count
  N / (p-1);
}

\\ Lefschetz trace
trace_Frob(p) = {
  my(N = countVprime(p));
  \\ N = 1 + p^2 + p * t
  (N - 1 - p^2) / p;
}

\\ ============================================================
\\ MAIN
\\ ============================================================
{
  print("Euler-brick K3 V': Frobenius trace computation");
  print("V' = {a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2} ⊂ P^5");
  print("");
  print("p    | #V'(F_p)  | 1+p^2  | t = tr(Frob|H^2)");
  print("-----+-----------+--------+------------------");
  for(i = 1, 8,
    my(p = prime(i+1));  \\ skip p=2 (bad reduction)
    if(p < 30,           \\ keep small for speed
      my(N = countVprime(p));
      my(t = (N - 1 - p^2) / p);
      print(p, "    | ", N, "       | ", 1+p^2, "    | ", t);
    );
  );
  print("");
  print("Note: K3 has b_2 = 22, so |t| <= 22.");
  print("Algebraic eigenvalues = p * (root of unity); contribute p, -p, or ±p·ζ_k.");
  print("Transcendental eigenvalues have |λ| = p but irrational.");
}

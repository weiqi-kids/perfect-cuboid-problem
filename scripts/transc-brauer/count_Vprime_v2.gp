\\ ============================================================
\\ Careful count of projective F_p-points on V' ⊂ P^5
\\ V': Q1=a^2+b^2-d^2=0, Q2=b^2+c^2-e^2=0, Q3=a^2+c^2-f^2=0
\\
\\ Strategy: enumerate all [a:b:c:d:e:f] ∈ P^5(F_p).
\\ Standard chart enumeration: pick a "leading" non-zero coord.
\\ Easier: count affine solutions of all 6 vars = 0 mod p satisfying
\\ the 3 equations, subtract origin, divide by (p-1).
\\ This is correct because the equations are homogeneous of degree 2.
\\
\\ The issue with non-integer t in v1 must be a counting bug.
\\ Let me recount more directly: iterate over (a,b,c,d,e,f) ∈ F_p^6.
\\ ============================================================

countV_naive(p) = {
  my(N = 0);
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        for(d = 0, p-1,
          for(e = 0, p-1,
            for(f = 0, p-1,
              if( (a^2+b^2-d^2) % p == 0 &&
                  (b^2+c^2-e^2) % p == 0 &&
                  (a^2+c^2-f^2) % p == 0,
                  N++);
            )
          )
        )
      )
    )
  );
  N;
}

\\ Smarter: for each (a,b,c) count #{(d,e,f) : the three equations hold}
\\ d satisfies d^2 = a^2+b^2 mod p
\\   - if a^2+b^2 == 0: d = 0 only (1 solution)
\\   - if a^2+b^2 is a nonzero square: 2 solutions for d
\\   - else: 0 solutions
\\ Similarly for e, f.
\\ Then #affine = sum_{a,b,c} nd(a,b)*ne(b,c)*nf(a,c)

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

\\ Sanity-check at p=3
{
  print("Sanity: comparing naive vs smart at p=3");
  print("naive: ", countV_naive(3));
  print("smart: ", countV_smart(3));
}

\\ Projective count:
\\ All homogeneous, so #aff sols = 1 (origin) + (p-1) * #proj-points
\\ Hence #proj = (countV_smart(p) - 1) / (p - 1)
\\
\\ For a smooth K3, Lefschetz gives:
\\   #X(F_p) = 1 + tr(Frob|H^2)*p + p^2     (where H^2 has 22 eigenvalues |λ|=p)
\\   Wait — actually for surfaces with H^0 = H^4 = Q, H^1 = H^3 = 0 (K3):
\\   #X(F_p) = 1 + tr(Frob|H^2) + p^2     [trace over the whole H^2, eigvals of size p]
\\   No — let me re-derive. Lefschetz:
\\   #X(F_p) = sum (-1)^i tr(Frob | H^i_et(X, Q_ell))
\\   For K3: H^0 = Q (eig 1), H^1 = 0, H^2 = Q^22, H^3 = 0, H^4 = Q(-2) (eig p^2).
\\   So #X(F_p) = 1 + tr(Frob|H^2) + p^2.
\\   The eigenvalues on H^2 have abs value p.
\\   So if eigenvalues are α_1,...,α_22 with |α_i|=p,
\\     tr = sum α_i, an integer with |tr| ≤ 22p.

trace_H2(p) = {
  my(N_aff = countV_smart(p));
  my(N_proj = (N_aff - 1) / (p - 1));
  my(t = N_proj - 1 - p^2);
  [N_aff, N_proj, t];
}

{
  print("");
  print("p  | #V'_aff | #V'_proj | tr(Frob|H^2)");
  print("---+---------+----------+--------------");
  forprime(p = 3, 23,
    my(v = trace_H2(p));
    print(p, "  | ", v[1], "      | ", v[2], "       | ", v[3]);
  );
}

\\ 02_torsion_sweep.gp
\\ For a sample of Pythagorean q, confirm E_PCP(q)(Q)_tors = Z/4 x Z/2 (order 8)
\\ and that phi(X,Y) = 2 Y q / (q^2 - X^2) sends all 8 torsion points to {0, infinity}.

print("=== Torsion sweep + recovery-map degeneracy for E_PCP(q) ===");
print("");

{
  pyth = List();
  for(m = 2, 12,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        listput(pyth, (m^2 - n^2)/(2*m*n));
        listput(pyth, (2*m*n)/(m^2 - n^2));
      );
    );
  );
  pyth = vecsort(Set(pyth));
}
print("Number of Pythagorean q tested: ", #pyth);

{
  total_pts = 0;
  nondegen  = 0;
  bad_tors  = 0;
  for(i = 1, #pyth,
    q = pyth[i];
    if(1 + q^2 != (numerator(1+q^2)) / (denominator(1+q^2)), 0); \\ noop
    E = ellinit([0, 1+q^2, 0, q^2, 0]);   \\ Y^2 = X(X+1)(X+q^2)
    T = elltors(E);
    if(T[2] != [4,2], bad_tors++; print("  q=", q, " torsion=", T[2], "  <-- NOT [4,2]"));
    g1 = T[3][1]; g2 = T[3][2];
    for(a = 0, 3,
      for(b = 0, 1,
        P = elladd(E, ellmul(E, g1, a), ellmul(E, g2, b));
        total_pts++;
        if(P == [0],
          ,  \\ identity: phi undefined affinely, treat as degenerate (c=0 branch)
          Tx = P[1]; Ty = P[2];
          denom = q^2 - Tx^2;
          if(denom != 0,
            c = 2*Ty*q/denom;
            if(c != 0, nondegen++);
          );
        );
      );
    );
  );
  print("");
  print("Total torsion points enumerated: ", total_pts, "  (expected ", 8*#pyth, ")");
  print("Curves with torsion != [4,2]:    ", bad_tors);
  print("Non-degenerate finite c (c!=0):  ", nondegen);
  print("");
  if(bad_tors==0 && nondegen==0,
    print("RESULT: every curve has torsion Z/4 x Z/2; every torsion point -> {0, infinity}.  PASS");
  ,
    print("RESULT: FAIL");
  );
}
quit;

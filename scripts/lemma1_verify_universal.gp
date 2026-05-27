\\ =====================================================================
\\ Lemma 1 universal verification:
\\ For E_PCP(q): Y^2 = X(X+1)(X+q^2), torsion ⊆ {c = 0 or c = pole}
\\ where c = 2*Y*q / (q^2 - X^2)
\\ =====================================================================

print("=================================================================");
print("Lemma 1 — Universal Torsion Verification for E_PCP(q)");
print("=================================================================");
print();

\\ ---- Generate Pythagorean rationals q from (m,n) coprime, opposite parity
{
pyth = List();
for(m = 2, 12,
  for(n = 1, m-1,
    if(gcd(m,n) == 1 && (m+n) % 2 == 1,
      q1 = (m^2 - n^2) / (2*m*n);
      q2 = (2*m*n) / (m^2 - n^2);
      listput(pyth, q1);
      listput(pyth, q2);
    );
  );
);
pyth = vecsort(Set(pyth));
}

print("Number of distinct Pythagorean q tested: ", #pyth);
print();

\\ ---- Verification loop
{
total_q = 0;
total_pts = 0;
bad_q = List();
nondegen_count = 0;

for(i = 1, #pyth,
  q = pyth[i];
  \\ Sanity check: 1 + q^2 must be a rational square
  sq = 1 + q^2;
  num = numerator(sq);
  den = denominator(sq);
  if(!issquare(num) || !issquare(den),
    print("ERROR: q = ", q, " is NOT Pythagorean!"); next;
  );

  \\ E_PCP(q): Y^2 = X(X+1)(X+q^2) = X^3 + (1+q^2)*X^2 + q^2*X
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  T = elltors(E);
  ord = T[1];
  struc = T[2];

  if(ord != 8 || struc != [4, 2],
    print("q = ", q, "  WARNING torsion = ", struc, " (order ", ord, ")");
    listput(bad_q, [q, struc]);
  );

  \\ Build generators (g1 of order 4, g2 of order 2)
  if(#T[3] >= 2,
    g1 = T[3][1];
    g2 = T[3][2];
    print("q = ", q, "  torsion = ", struc);
    for(a = 0, 3,
      for(b = 0, 1,
        P = elladd(E, ellmul(E, g1, a), ellmul(E, g2, b));
        total_pts = total_pts + 1;
        if(P == [0],
          print("    (a=", a, ",b=", b, "): O (point at infinity)  ->  c = 0 (identity)");
        ,
          Tx = P[1]; Ty = P[2];
          denom = q^2 - Tx^2;
          if(denom == 0,
            if(2*Ty*q == 0,
              print("    (a=", a, ",b=", b, "): P=", P, "  ->  c = 0/0 INDETERMINATE");
              listput(bad_q, [q, P, "indet"]);
            ,
              print("    (a=", a, ",b=", b, "): P=", P, "  ->  c = POLE");
            );
          ,
            c = 2*Ty*q/denom;
            if(c != 0,
              print("    (a=", a, ",b=", b, "): P=", P, "  ->  c = ", c, " NONZERO !!!");
              nondegen_count = nondegen_count + 1;
              listput(bad_q, [q, P, c]);
            ,
              print("    (a=", a, ",b=", b, "): P=", P, "  ->  c = 0");
            );
          );
        );
      );
    );
    total_q = total_q + 1;
  );
  print();
);

print("=================================================================");
print("SUMMARY");
print("=================================================================");
print("Total q tested:        ", total_q);
print("Total torsion points:  ", total_pts);
print("Non-degenerate c found: ", nondegen_count);
print("Anomalies:             ", #bad_q);
if(#bad_q > 0, print("Bad list: ", bad_q));
if(nondegen_count == 0, print("RESULT: All torsion points map to c in {0, infinity} (POLE).  Lemma 1 verified."));
}

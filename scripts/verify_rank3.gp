\\ Verify the three rank-3 candidates from the m<=37 survey at higher precision.
\\ Candidates: (22,17), (35,22), (37,26).

default(parisize, 4000000000);
default(realprecision, 38);

check(m, n) = {
  my(a, b, s, E, Emin, N, ar1, ar2);
  a = m^2 - n^2;
  b = 2*m*n;
  s = m^2 + n^2;
  E = ellinit([0, a^2+b^2, 0, a^2*b^2, 0]);
  Emin = ellminimalmodel(E);
  N = ellglobalred(Emin)[1];
  print("");
  print("(m,n) = (", m, ",", n, ")  a=", a, " b=", b, " s=", s);
  print("  conductor N = ", N);
  print("  factor(N)   = ", factor(N));
  \\ ellanalyticrank with progressively tighter epsilon
  print("  eps=0.1   : ", ellanalyticrank(Emin, 0.1)[1]);
  print("  eps=1e-3  : ", ellanalyticrank(Emin, 0.001)[1]);
  print("  eps=1e-5  : ", ellanalyticrank(Emin, 0.00001)[1]);
  default(realprecision, 30);
  print("  Computing L^(k)(E,1) for k=0..5 ...");
  for(k = 0, 5,
    my(v = lfun(Emin, 1, k));
    print("    L^(", k, ")(E,1) = ", v);
  );
  default(realprecision, 38);
};

check(22, 17);
check(35, 22);
check(37, 26);

print("");
print("=== Attempt ellrank for (22,17), small effort ===");
{
  m=22; n=17; a=m^2-n^2; b=2*m*n;
  E=ellinit([0, a^2+b^2, 0, a^2*b^2, 0]);
  Emin=ellminimalmodel(E);
  print("ellrank effort=0: ", ellrank(Emin, 0));
}
quit;

\\ Task 1b: Find generators for rank >= 1 fibers
\\ Strategy: use ellheegner for rank 1 curves; ellrank with effort for rank 2

default(parisize, 2000000000);

\\ Rank >= 1 fibers
{
rank1q = [[20/21, 1], [80/39, 1], [24/7, 1], [84/13, 1], [48/55, 1]];
rank2q = [[60/11, 2]];

print("=== Task 1b: Generator search ===");

for(i = 1, #rank1q,
  q = rank1q[i][1];
  print("--- q = ", q, " (rank 1) ---");
  a2 = 1 + q^2;
  a4 = q^2;
  E = ellinit([0, a2, 0, a4, 0]);
  Emin = ellminimalmodel(E, &v);
  print("  v (iso to original): ", v);

  \\ try ellheegner
  print("  attempting ellheegner...");
  P = ellheegner(Emin);
  print("  Heegner point on Emin: ", P);
  if(P != [0],
    h = ellheight(Emin, P);
    print("  height on Emin: ", h);
    \\ map back to E via inverse of v
    \\ v is the change of variable; ellchangepoint applies v.
    \\ To go from Emin back to E, use inverse [u^-2, ..., ...]
    Pback = ellchangepointinv(P, v);
    print("  Point on original E (Y^2 = X^3+(1+q^2)X^2+q^2 X): ", Pback);
    if(ellisoncurve(E, Pback),
      print("  CHECK PASS: on E");
      print("  Height on E: ", ellheight(E, Pback));
    ,
      print("  CHECK FAIL");
    );
  );
  print();
);

print("--- q = 60/11 (rank 2) ---");
q = 60/11;
a2 = 1 + q^2; a4 = q^2;
E = ellinit([0, a2, 0, a4, 0]);
Emin = ellminimalmodel(E, &v);
print("  v = ", v);

\\ Try ellrank with effort 4
print("  attempting ellrank(E, 4)...");
rk = ellrank(Emin, 4);
print("  rank result: low=", rk[1], " up=", rk[2]);
print("  gens (raw): ", rk[3]);
if(#rk[3] > 0,
  for(j = 1, #rk[3],
    P = rk[3][j];
    print("  raw gen ", j, ": ", P);
    h = ellheight(Emin, P);
    print("    height: ", h);
    Pback = ellchangepointinv(P, v);
    print("    on original E: ", Pback);
    print("    on E? ", ellisoncurve(E, Pback));
  );
);

print();
print("=== End Task 1b ===");
}

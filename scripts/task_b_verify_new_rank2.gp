\\ Task B follow-up: verify the two new rank-2 candidates q = 17/144 and 104/153.

default(parisize, 4000000000);
default(realprecision, 38);

check(q) =
{
  print("=== q = ", q, " ===");
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E, &v));
  my(NE = ellglobalred(Emin)[1]);
  print("Conductor: ", NE);
  print("Emin: ", Emin[1..5]);
  print("v: ", v);
  my(ar = ellanalyticrank(Emin)[1]);
  print("Analytic rank: ", ar);
  my(rk = ellrank(Emin, 5));
  print("ellrank(E, 5): ", rk);
  print();
}

check(17/144);
check(104/153);

\\ Bonus: check q = 96/247 and q = 20/99 which are new rank-1 fibers
print(">>> Confirm new rank-1 fibers <<<");
check(96/247);
check(20/99);

quit;

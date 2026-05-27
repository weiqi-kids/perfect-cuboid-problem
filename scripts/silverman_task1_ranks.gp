\\ Task 1: Verify ranks of E_PCP(q): Y^2 = X(X+1)(X+q^2)

default(parisize, 1000000000);

{
candidates = [20/21, 80/39, 60/11, 24/7, 8/15, 40/9, 16/63, 56/33, 84/13, 48/55, 112/15, 28/45];

print("=== Task 1: Rank verification ===");
print("Curve: E_PCP(q): Y^2 = X^3 + (1+q^2)X^2 + q^2 X");
print();

for(i = 1, #candidates,
  q = candidates[i];
  print("--- q = ", q, " ---");

  a2 = 1 + q^2;
  a4 = q^2;

  E = ellinit([0, a2, 0, a4, 0]);
  Emin = ellminimalmodel(E);

  print("  Emin a-invariants: [", Emin.a1, ",", Emin.a2, ",", Emin.a3, ",", Emin.a4, ",", Emin.a6, "]");
  gr = ellglobalred(Emin);
  print("  conductor: ", gr[1]);

  ar = ellanalyticrank(Emin);
  print("  analytic rank: ", ar[1]);

  rk = ellrank(Emin);
  print("  ellrank: low=", rk[1], " up=", rk[2]);
  print("  generators (MW): ", rk[3]);
  print();
);

print("=== End Task 1 ===");
}

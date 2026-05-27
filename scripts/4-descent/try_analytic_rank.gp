\\ Try analytic rank / L-value for E_Hm to give independent corroboration.
\\ Conductor ~10^17 so this is borderline feasible.

default(parisize, 4000000000);
default(realprecision, 60);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
print("E_Hm conductor = ", ellglobalred(E_Hm)[1]);
print("log10 N = ", log(1.0*ellglobalred(E_Hm)[1])/log(10.0));
print();

\\ Try L(E, 1) at moderate precision
print("Attempting ellL1(E_Hm) ...");
t0 = getwalltime();
L1_val = ellL1(E_Hm);
t1 = getwalltime();
print("  ellL1(E_Hm) = ", L1_val);
print("  wall = ", (t1-t0)/1000.0, "s");
print();
if(abs(L1_val) > 1e-5,
  print("  → L(E, 1) is nonzero; by BSD (heuristic), rk = 0.");
,
  print("  → L(E, 1) is (apparently) zero; rk >= 2 by parity.");
);
print();

\\ Try ellanalyticrank
print("Attempting ellanalyticrank(E_Hm, 0.05) ...");
t0 = getwalltime();
ar = ellanalyticrank(E_Hm, 0.05);
t1 = getwalltime();
print("  ellanalyticrank = ", ar);
print("  wall = ", (t1-t0)/1000.0, "s");

quit;

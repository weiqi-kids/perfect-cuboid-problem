\\ Sharpen ellrank bounds for the two borderline/loose-rank fibers
\\   (61,38): E_Hm rank in [0,2]
\\   (73,24): E_Hm rank in [1,3]
\\
\\ Use ellrank with effort=4 (slower but possibly tighter).
\\ Also try ellanalyticrank for a parity check / L-function indication.

default(parisize, 500000000);
default(realprecision, 38);

EHm_61_38 = [1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972];
EHm_73_24 = [1, 0, 0, -4296889542830417930548255320, 69513195990628448299367172717433334517312];

sharpen(label, coef) = {
  my(E, r2, r4);
  E = ellinit(coef);
  print("\n========== ", label, " ==========");
  print("E_Hm: a4=", coef[4], " a6=", coef[5]);
  print("Conductor: ", ellglobalred(E)[1]);

  print("\nellrank effort=2:");
  gettime();
  iferr(r2 = ellrank(E, 2), Err, print("  errored: ", Err); r2 = -1);
  print("  result = ", r2, "  (t=", gettime()/1000.0, "s)");

  print("\nellrank effort=4:");
  gettime();
  iferr(r4 = ellrank(E, 4), Err, print("  errored: ", Err); r4 = -1);
  print("  result = ", r4, "  (t=", gettime()/1000.0, "s)");

  \\ ellanalyticrank for an upper-bound BSD-style check (parity / leading term)
  print("\nellanalyticrank (modular root-number / leading term check):");
  gettime();
  iferr(my(ar = ellanalyticrank(E)); print("  analytic rank = ", ar[1], "  L^(r) = ", ar[2]), Err,
    print("  ellanalyticrank errored: ", Err));
  print("  (t=", gettime()/1000.0, "s)");
};

sharpen("(61,38)  E_Hm", EHm_61_38);
sharpen("(73,24)  E_Hm", EHm_73_24);

print("\n=== DONE SHARPEN ===");
quit;

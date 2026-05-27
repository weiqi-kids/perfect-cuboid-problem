\\ Verify (578, 319) rank-4 RIGOROUSLY at effort 10, compute Face-3, height matrix
default(parisize, 1500000000);

m = 578; n = 319;
q = (m^2 - n^2)/(2*m*n);
print("=== Verifying (578, 319) ===");
print("q = ", q);

E = ellinit([0, 1+q^2, 0, q^2, 0]);
Emin = ellminimalmodel(E);
print("E_PCP coefficients = ", E[:5]);
print("E_min coefficients = ", Emin[:5]);
print("E_min conductor = ", ellglobalred(Emin)[1]);
print("Torsion: ", elltors(Emin));

\\ Push effort to 10 - definitive
print();
print("=== ellrank(Emin, 10) ===");
t0 = getwalltime();
rk10 = ellrank(Emin, 10);
print("ellrank=[", rk10[1], ",", rk10[2], "] gens=", #rk10[4], " (time=", (getwalltime()-t0)/1000.0, "s)");

\\ Get the change-of-variable from E to Emin so we can map gens back to E_PCP form
chcoords = ellminimalmodel(E, &chv); \\ chv is the change of variable
\\ Actually we want: P_E = (Emin point -> E point) via inverse change
\\ ellchangepointinv(P_on_Emin, chv) gives P on E
print();
print("Change-of-variable (Emin -> E): ", chv);

\\ Verify the 4 generators on Emin
print();
print("=== Verifying 4 generators on Emin ===");
gens_E_PCP = vector(#rk10[4]);
{
for(i=1, #rk10[4],
  my(P = rk10[4][i]);
  print("G", i, " on Emin = ", P);
  print("  ellisoncurve(Emin, G", i, ") = ", ellisoncurve(Emin, P));
  print("  height = ", ellheight(Emin, P));
  \\ Map to E_PCP form
  my(PE = ellchangepointinv(P, chv));
  gens_E_PCP[i] = PE;
  print("  G", i, " on E_PCP = ", PE);
  print("  ellisoncurve(E, G", i, ") = ", ellisoncurve(E, PE));
);
}

\\ Height matrix on Emin
print();
print("=== Height pairing matrix on Emin ===");
H = matrix(#rk10[4], #rk10[4], i, j, ellheight(Emin, rk10[4][i], rk10[4][j]));
print("H = ", H);
print("det H = ", matdet(H));

\\ Face-3 chain: c = 2qy/(q^2 - x^2), F3 = c^2 + 1 + q^2
print();
print("=== Face-3 verification ===");
{
for(i=1, #gens_E_PCP,
  my(P = gens_E_PCP[i], x = P[1], y = P[2], c, F3, sq);
  c = 2*q*y/(q^2 - x^2);
  F3 = c^2 + 1 + q^2;
  sq = issquare(F3);
  print("G", i, ": x=", x, "  c=", c);
  print("  F3 = ", F3, "  issquare = ", sq);
);
}

quit;

\\ Ultra-verify a single candidate (m, n) — usage: gp -q 07_verify_rank5.gp
\\ Expects M and N to be set externally, e.g.:
\\   echo "M=578; N=319; \\\\r 07_verify_rank5.gp" | gp -q
\\
\\ Hard-coded variables for direct use:
default(parisize, 1200000000);

if(type(M) != "t_INT" || type(N) != "t_INT", error("Set M and N before running"));

print("=== ULTRA-VERIFY (", M, ",", N, ") ===");
q = (M^2 - N^2)/(2*M*N);
print("q = ", q);

E = ellinit([0, 1+q^2, 0, q^2, 0]);
chcoords = ellminimalmodel(E, &chv);
Emin = chcoords;
print("E_min coefficients: ", Emin[1..5]);
print("conductor: ", ellglobalred(Emin)[1]);

print();
print("=== ellrank effort 6 ===");
t0 = getwalltime();
rk6 = ellrank(Emin, 6);
print("ellrank=[", rk6[1], ",", rk6[2], "] gens=", length(rk6[4]), " t=", (getwalltime()-t0)/1000.0, "s");

if(rk6[2] < 5,
  print("Upper bound < 5; STOPPING (not a rank-5 candidate).");
  quit;
);

print();
print("=== ellrank effort 8 ===");
t0 = getwalltime();
rk8 = ellrank(Emin, 8);
print("ellrank=[", rk8[1], ",", rk8[2], "] gens=", length(rk8[4]), " t=", (getwalltime()-t0)/1000.0, "s");

print();
print("=== ellrank effort 10 ===");
t0 = getwalltime();
rk10 = ellrank(Emin, 10);
print("ellrank=[", rk10[1], ",", rk10[2], "] gens=", length(rk10[4]), " t=", (getwalltime()-t0)/1000.0, "s");

print();
print("=== Generator verification ===");
rk = rk10;
gens_E_PCP = vector(length(rk[4]));
{
for(i=1, length(rk[4]),
  P = rk[4][i];
  print("G", i, " on Emin = ", P);
  print("  ellisoncurve(Emin) = ", ellisoncurve(Emin, P));
  print("  height = ", ellheight(Emin, P));
  PE = ellchangepointinv(P, chv);
  gens_E_PCP[i] = PE;
  print("  G", i, " on E_PCP = ", PE);
  print("  ellisoncurve(E) = ", ellisoncurve(E, PE));
);
}

print();
print("=== Height pairing matrix on Emin ===");
H = matrix(length(rk[4]), length(rk[4]), i, j, ellheight(Emin, rk[4][i], rk[4][j]));
print("H = ", H);
print("det H = ", matdet(H));

print();
print("=== Face-3 verification: F3 = (2qy/(q²-x²))² + 1 + q² ===");
{
for(i=1, length(gens_E_PCP),
  P = gens_E_PCP[i]; x = P[1]; y = P[2];
  c = 2*q*y/(q^2 - x^2);
  F3 = c^2 + 1 + q^2;
  sq = issquare(F3);
  print("G", i, ": x=", x);
  print("  c=", c);
  print("  F3=", F3);
  print("  issquare(F3) = ", sq);
);
}

quit;

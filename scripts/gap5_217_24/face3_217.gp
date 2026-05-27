default(parisize, 1500000000);

q = 46513/10416;
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Emin = ellminimalmodel(E);
chg = ellminimalmodel(E, &v);  \\ change of variable

\\ Get the 3 known generators on Emin from ellrank
print("=== Get generators on Emin ===");
rkE = ellrank(Emin, 6);
print("ellrank(Emin, 6) = [", rkE[1], ",", rkE[2], "]");

{
gens_emin = rkE[4];
print("Generators on Emin:");
for(i=1, length(gens_emin),
  print("  G", i, " = ", gens_emin[i], "  isoncurve? ", ellisoncurve(Emin, gens_emin[i]));
);
}

\\ Map back to E (the non-minimal E_PCP form)
\\ The change of variable from E to Emin is encoded in v: [u, r, s, t]
print();
print("Change of variable [u, r, s, t] = ", v);

{
print("=== Pull generators back to E_PCP(q) ===");
for(i=1, length(gens_emin),
  my(P, P_E, c, F3);
  P = gens_emin[i];
  P_E = ellchangepointinv(P, v);
  print();
  print("G", i, " on Emin: ", P);
  print("  -> on E_PCP: ", P_E);
  print("  ellisoncurve(E, ...) = ", ellisoncurve(E, P_E));
  if (P_E[1]^2 != q^2,
    c = 2*q*P_E[2]/(q^2 - P_E[1]^2);
    F3 = c^2 + 1 + q^2;
    print("  c = ", c);
    print("  c Pythagorean? ", issquare(1+c^2));
    print("  F3 = ", F3);
    print("  issquare(F3) = ", issquare(F3));
  );
);
}

\\ Compute height matrix to confirm independence
print();
print("=== Height pairing matrix (rank 3 ↔ det != 0) ===");
{
H = matrix(3, 3);
for(i=1, 3, for(j=1, 3,
  H[i, j] = if(i == j, ellheight(Emin, gens_emin[i]), 
                       (ellheight(Emin, elladd(Emin, gens_emin[i], gens_emin[j])) - 
                        ellheight(Emin, gens_emin[i]) - 
                        ellheight(Emin, gens_emin[j]))/2);
));
print("H = ", H);
print("det(H) = ", matdet(H));
}

quit;

default(parisize, 1500000000);

q = 46513/10416;
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Emin = ellminimalmodel(E);
print("=== Confirming rank=3 via E_2 (2-isogenous) ===");

iso = ellisomat(Emin, 0, 1);
E2 = ellinit(iso[1][2]);
print("E_2 coefficients = ", iso[1][2]);
print("E_2 conductor = ", ellglobalred(E2)[1]);
print("E_2 torsion order = ", elltors(E2)[1]);

\\ Higher effort to confirm
print();
print("ellrank(E_2, 6) — definitive rank check:");
rk2 = ellrank(E2, 6);
print("  rank=[", rk2[1], ",", rk2[2], "]  generators=", length(rk2[4]));

\\ Verify generators on E_2 + Face-3
print();
print("=== Pull-back to E_1 (= Emin) ===");

\\ The isogeny from E_1 to E_2 is encoded in iso[2]. Let's get it.
\\ Actually it's easier to just compute on E_2 and isogeny-map back.
\\ But for Face-3, we need to work on E_PCP form. Let me just check rank rigorously.

\\ Pull 3 generators of E_2 through the isogeny back to E_1, then to E_PCP form
psi = ellisogeny(Emin, ellisomat(Emin, 0, 1)[2][2]);  \\ won't work, different API

\\ Alternative: ellrank(Emin, 5) on the original — if it now returns [3,3] thanks to deeper search
print();
print("=== Re-run ellrank on Emin with higher effort ===");
rkE = ellrank(Emin, 6);
print("  ellrank(Emin, 6) = [", rkE[1], ",", rkE[2], "]");

if (rkE[1] == rkE[2],
  print("*** RIGOROUS: rank(Emin) = ", rkE[1], " ***");
  for(i=1, length(rkE[4]),
    my(P, isoncurve);
    P = rkE[4][i];
    isoncurve = ellisoncurve(Emin, P);
    print("  G", i, " = ", P, "  on curve? ", isoncurve, "  height=", ellheight(Emin, P));
  );
);

quit;

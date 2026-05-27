\\ Verify rank=4 at (m,n) = (99, 28) with ellrank effort=10 and ellanalyticrank.
default(parisize, 1000000000);
print("=== Verifying (m,n)=(99,28) RANK-4 fiber ===");
m = 99; n = 28;
print("gcd(m,n) = ", gcd(m,n));
print("(m+n) odd? ", (m+n)%2 == 1);
q = (m^2-n^2)/(2*m*n);
print("q = ", q);
a = m^2-n^2; b = 2*m*n;
print("a=", a, " b=", b);
print("a^2+b^2 = (m^2+n^2)^2? ", a^2+b^2 == (m^2+n^2)^2);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E, &change);
print("Conductor = ", ellglobalred(Em)[1]);
print("Change = ", change);
print("\nellanalyticrank...");
ar = ellanalyticrank(Em, 0.001);
print("Analytic rank = ", ar);
print("\nellrank(_, 2)...");
r2 = ellrank(Em, 2);
print("  effort=2: rank=[", r2[1], ",", r2[2], "] #gens=", length(r2[4]));
print("\nellrank(_, 5)...");
r5 = ellrank(Em, 5);
print("  effort=5: rank=[", r5[1], ",", r5[2], "] #gens=", length(r5[4]));
print("\nellrank(_, 10)...");
r10 = ellrank(Em, 10);
print("  effort=10: rank=[", r10[1], ",", r10[2], "] #gens=", length(r10[4]));
gens = r10[4];
print("\nGenerators on Em:");
for(i=1, length(gens), my(P=gens[i]); print("  gen[", i, "] = ", P, " on Em? ", ellisoncurve(Em, P)));
\\ Map to E
print("\nGenerators on E:");
gens_E = [];
for(i=1, length(gens), my(PE=ellchangepointinv(gens[i], change)); if(!ellisoncurve(E, PE), error("inverse failed!")); gens_E = concat(gens_E, [PE]); print("  ", PE));
\\ Heights
print("\nCanonical heights (on Em):");
for(i=1, length(gens), print("  h(gen[", i, "]) = ", ellheight(Em, gens[i])));
\\ Face-3
print("\nFace-3 chain:");
flag = 0;
for(i=1, length(gens_E), my(P=gens_E[i], xp, yp, dnp, cv, F3v, sqv); xp = P[1]; yp = P[2]; dnp = q^2 - xp^2; if(dnp == 0, print("  gen[", i, "] x = ±q, skip"), cv = 2*q*yp/dnp; F3v = cv^2 + 1 + q^2; sqv = issquare(F3v); print("  gen[", i, "] c = ", cv, " F3 = ", F3v, " sq? ", sqv); if(sqv, flag++)));
print("\nFlag count: ", flag);
quit;

\\ CRITICAL verification: (217, 24) might have rank >= 5!
\\ rk=[3, 5] from effort=2 means lo=3, up=5, with possible Sha[2] gap.
\\ Use effort=10 to resolve.
default(parisize, 2000000000);
print("=== CRITICAL: verify (217, 24): possible rank-5 fiber ===");
m = 217; n = 24;
print("gcd: ", gcd(m,n), " (m+n)%2: ", (m+n)%2);
q = (m^2-n^2)/(2*m*n);
print("q = ", q);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E, &change);
print("Conductor = ", ellglobalred(Em)[1]);
print("\nellrank effort 5...");
t0 = getwalltime();
r5 = ellrank(Em, 5);
print("  time = ", (getwalltime()-t0)/1000.0, "s");
print("  effort 5: rank=[", r5[1], ",", r5[2], "] unprov=", r5[3], " #gens=", length(r5[4]));
print("\nellrank effort 10...");
t0 = getwalltime();
r10 = ellrank(Em, 10);
print("  time = ", (getwalltime()-t0)/1000.0, "s");
print("  effort 10: rank=[", r10[1], ",", r10[2], "] unprov=", r10[3], " #gens=", length(r10[4]));
print("\nellrank effort 20...");
t0 = getwalltime();
r20 = ellrank(Em, 20);
print("  time = ", (getwalltime()-t0)/1000.0, "s");
print("  effort 20: rank=[", r20[1], ",", r20[2], "] unprov=", r20[3], " #gens=", length(r20[4]));
\\ List generators
print("\nGenerators on Em (from effort=20):");
for(i=1, length(r20[4]), print("  gen[",i,"]=", r20[4][i], " on Em? ", ellisoncurve(Em, r20[4][i])));
\\ If rank = 5, this is news
if(r20[1] >= 5, print("\n*** RANK >= 5 CONFIRMED ***"); print("*** This violates the empirical r ≤ 4 bound and refutes Pick 13! ***"), if(r20[1] == r20[2], print("\nRigorous rank: ", r20[1], " (no gap)"), print("\nGap: lo=", r20[1], " up=", r20[2], " — Sha[2] not resolved")));
\\ Push generators through Face-3
gens_E = [];
for(i=1, length(r20[4]), my(PE = ellchangepointinv(r20[4][i], change)); if(!ellisoncurve(E, PE), error("inv map failed")); gens_E = concat(gens_E, [PE]));
print("\nGenerators on E:");
for(i=1, length(gens_E), print("  ", gens_E[i]));
print("\nFace-3 chain:");
for(i=1, length(gens_E), my(P=gens_E[i], xp, yp, dnp, cv, F3v, sqv); xp = P[1]; yp = P[2]; dnp = q^2 - xp^2; if(dnp == 0, print("  [gen", i, "] x=±q, skip"), cv = 2*q*yp/dnp; F3v = cv^2 + 1 + q^2; sqv = issquare(F3v); print("  [gen", i, "] c=", cv); print("       F3 sq? ", sqv, if(sqv, "  *** FLAG ***", ""))));
quit;

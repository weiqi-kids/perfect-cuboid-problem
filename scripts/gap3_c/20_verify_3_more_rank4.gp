\\ Verify the 3 new rank-4 fibers and push through Face-3.
default(parisize, 1500000000);
print("=== Verify 3 new rank-4 fibers: (174,83), (176,63), (181,38) ===");

rank4 = [[174, 83], [176, 63], [181, 38]];
total_flags = 0;

for(i=1, length(rank4), my(pair=rank4[i], m=pair[1], n=pair[2], q, E, Em, change, rk, gens_E); m = pair[1]; n = pair[2]; q = (m^2-n^2)/(2*m*n); print("\n--- (m,n) = (", m, ",", n, "), q = ", q, " ---"); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E, &change); print("  conductor = ", ellglobalred(Em)[1]); print("  computing ellrank(_, 10)..."); rk = ellrank(Em, 10); print("  rank = [", rk[1], ",", rk[2], "] unprov=", rk[3], " #gens=", length(rk[4])); for(j=1, length(rk[4]), my(P=rk[4][j]); if(!ellisoncurve(Em, P), error("not on Em!"))); gens_E = []; for(j=1, length(rk[4]), my(PE=ellchangepointinv(rk[4][j], change)); if(!ellisoncurve(E, PE), error("inv map failed")); gens_E = concat(gens_E, [PE])); print("  Generators on E:"); for(j=1, length(gens_E), print("    ", gens_E[j])); print("  Face-3:"); for(j=1, length(gens_E), my(P=gens_E[j], xp, yp, dnp, cv, F3v, sqv); xp = P[1]; yp = P[2]; dnp = q^2 - xp^2; if(dnp == 0, print("    gen[", j, "] x=±q skip"), cv = 2*q*yp/dnp; F3v = cv^2 + 1 + q^2; sqv = issquare(F3v); print("    [gen", j, "] c=", cv, " F3 sq?=", sqv); if(sqv, total_flags++; print("       *** FLAG POTENTIAL PCP ***")))));

print("\n=== Summary ===");
print("Total flags (PCP candidates) across 3 fibers: ", total_flags);
quit;

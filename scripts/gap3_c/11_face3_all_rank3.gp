\\ GAP3-C task 11: Verify all 10 rank-3 fibers with full generators and push through Face-3.
default(parisize, 800000000);
print("=== GAP3-C task 11: Face-3 chain on all 10 rank-3 fibers ===");

rank3_list = [[22,17], [35,22], [37,26], [40,29], [40,33], [41,18], [44,9], [53,32], [59,40], [60,43]];

flag_count = 0;
for(i=1, length(rank3_list), my(pair=rank3_list[i], m=pair[1], n=pair[2], q, a, b, E, Em, change, rk, gens_E); print("\n--- (m,n) = (", m, ",", n, ") ---"); q = (m^2-n^2)/(2*m*n); a = m^2-n^2; b = 2*m*n; E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E, &change); print("  q = ", q, " (a=", a, ", b=", b, ")"); print("  conductor = ", ellglobalred(Em)[1]); rk = ellrank(Em, 10); print("  rank=[", rk[1], ",", rk[2], "] #gens=", length(rk[4])); gens_E = []; for(j=1, length(rk[4]), my(PE=ellchangepointinv(rk[4][j], change)); if(!ellisoncurve(E, PE), error("inverse map failed!")); gens_E = concat(gens_E, [PE])); print("  generators on E:"); for(j=1, length(gens_E), print("    ", gens_E[j])); print("  Face-3:"); for(j=1, length(gens_E), my(P=gens_E[j], xp, yp, dnp, cv, F3v, sqv); xp = P[1]; yp = P[2]; dnp = q^2 - xp^2; if(dnp == 0, print("    [gen", j, "] x = ±q, skip"), cv = 2*q*yp/dnp; F3v = cv^2 + 1 + q^2; sqv = issquare(F3v); print("    [gen", j, "] c=", cv, " F3=", F3v, " sq?=", sqv, if(sqv, "  *** FLAG ***", "")); if(sqv, flag_count++))));

print("\n=== Summary ===");
print("Total fibers verified: ", length(rank3_list));
print("Total Face-3 flags (PCP candidates): ", flag_count);
quit;

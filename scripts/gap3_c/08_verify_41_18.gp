\\ Verify (m,n) = (41, 18) as rank-3 fiber and push generators through Face-3.
default(parisize, 800000000);

m = 41; n = 18;
print("=== Verifying (m,n)=(", m, ",", n, ") rank-3 candidate ===");
q = (m^2 - n^2) / (2*m*n);
print("q = ", q);
a = m^2-n^2; b = 2*m*n;
print("a = ", a, ", b = ", b);
print("a^2+b^2 = (m^2+n^2)^2? ", a^2+b^2 == (m^2+n^2)^2);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E, &change);
print("Conductor = ", ellglobalred(Em)[1]);
print("Change [u,r,s,t] = ", change);
ar = ellanalyticrank(Em, 0.0001);
print("Analytic rank = ", ar[1], " (L^(",ar[1],")(E,1) = ", ar[2], ")");
print("Running ellrank(_,10)...");
rk = ellrank(Em, 10);
print("ellrank result: lo=", rk[1], " up=", rk[2], " unprov=", rk[3], " #gens=", length(rk[4]));
\\ Verify each gen
for(i=1, length(rk[4]), my(P=rk[4][i], oc); oc = ellisoncurve(Em, P); print("  gen[", i, "] = ", P, " on Em? ", oc));
\\ Map to E
gens_E = [];
for(i=1, length(rk[4]), my(PE = ellchangepointinv(rk[4][i], change)); if(!ellisoncurve(E, PE), error("Inverse map failed!")); gens_E = concat(gens_E, [PE]));
print("Generators on E (PCP form):");
print(gens_E);
\\ Face-3 chain
print("\nFace-3 chain c = 2qy/(q^2 - x^2), F3 = c^2 + 1 + q^2:");
for(i=1, length(gens_E), my(P=gens_E[i], xp, yp, dnp, cv, F3v, sqv); xp = P[1]; yp = P[2]; dnp = q^2 - xp^2; if(dnp == 0, print("  gen[", i, "]: x = ±q, c = inf, skip"), cv = 2*q*yp/dnp; F3v = cv^2 + 1 + q^2; sqv = issquare(F3v); print("  gen[", i, "]: x=", xp, " y=", yp); print("     c = ", cv); print("     F3 = ", F3v); print("     F3 square? ", sqv, if(sqv, "  *** FLAG POTENTIAL PCP ***", ""))));
quit;

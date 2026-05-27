\\ Verification of key claims

\\ Claim 1: (X = 0, Y = qw) is a section of E_H+ over the Pythag locus 1+q^2 = w^2

\\ E_H+: Y^2 = (X + q^2)(X + 1)(X + 1 + q^2)
\\ At X = 0: Y^2 = q^2 · 1 · (1+q^2) = q^2(1+q^2)
\\ If 1+q^2 = w^2, then Y^2 = (qw)^2. ✓

\\ Verify at q = 4/3:
q0 = 4/3;
w0 = 5/3;  \\ 1 + 16/9 = 25/9 = (5/3)^2 ✓
X0 = 0;
Y0_sq = (X0 + q0^2)*(X0 + 1)*(X0 + 1 + q0^2);
print("At q_0 = 4/3, X = 0:");
print("  Y^2 = ", Y0_sq, " = ", numerator(Y0_sq), "/", denominator(Y0_sq));
print("  Expected (qw)^2 = ", (q0*w0)^2, " = (", q0*w0, ")^2");

\\ Match. ✓

\\ Claim 2: This section has infinite order (not torsion)
\\ Compute it on the minimal model of E_H+(4/3) and check
c2 = 3 + 2*q0^2;
c1 = 1 + 3*q0^2 + q0^4;
c0 = q0^2 + q0^4;
E = ellinit([0, c2, 0, c1, c0]);
print("\nE_H+(4/3) Weierstrass: y^2 = x^3 + ", c2, " x^2 + ", c1, " x + ", c0);
print("Point P = [0, ", q0*w0, "] on E:");
P = [0, q0*w0];
\\ verify on E
chk = P[2]^2 - (P[1]^3 + c2*P[1]^2 + c1*P[1] + c0);
print("Check Y^2 - RHS = ", chk);

\\ Convert to minimal model
Em = ellminimalmodel(E);
print("\nMinimal model: ", [Em.a1, Em.a2, Em.a3, Em.a4, Em.a6]);

\\ Use elltors and orderof P
print("Torsion of E: ", elltors(E));
print("Point P = ", P);
\\ Multiply P by torsion orders to see if it's torsion
print("2P = ", ellmul(E, P, 2));
print("3P = ", ellmul(E, P, 3));
print("4P = ", ellmul(E, P, 4));
print("5P = ", ellmul(E, P, 5));
\\ If non-torsion, the coordinates blow up.

print("\n");

\\ Claim 3: Rank of E_H+(q) over Q(q) is exactly 2
\\ This is hard to verify directly. We verified that min observed rank over non-Pythag q_0 is 2.
\\ Need to also confirm the SECTION at X = 0 is independent of the 2 generic sections.

\\ More verification: at q_0 = 2 (non-Pythag), rank = 2. Find the 2 free generators?
q0_test = 2;
c2 = 3 + 2*q0_test^2;
c1 = 1 + 3*q0_test^2 + q0_test^4;
c0 = q0_test^2 + q0_test^4;
E2 = ellinit([0, c2, 0, c1, c0]);
E2m = ellminimalmodel(E2);
print("E_H+(q=2) minimal model:");
print("  a-coeffs: ", [E2m.a1, E2m.a2, E2m.a3, E2m.a4, E2m.a6]);
print("  Conductor: ", ellglobalred(E2m)[1]);

r2 = ellrank(E2m);
print("  Rank: ", r2[1], "..", r2[2]);
print("  Generators found: ", r2[3]);

\\ Examine the generators — they should correspond to "geometric" sections not in our list

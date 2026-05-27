\\ Step 1: symbolic verification that (q, q(q+1)) has order exactly 4
\\ on E_PCP(q): Y^2 = X(X+1)(X+q^2) = X^3 + (1+q^2)X^2 + q^2 X

\\ Treat q as a symbolic variable. Use rational function ring Q(q).
\\ a2 = 1 + q^2, a4 = q^2, a6 = 0

\\ Point P = (q, q(q+1))
print("=== Step 1: Symbolic doubling of P1=(q, q(q+1)) on E_PCP(q) ===");

E = ellinit([0, 1+q^2, 0, q^2, 0]);

P1 = [q, q*(q+1)];
\\ Verify P1 is on E: Y^2 - (X^3 + (1+q^2)X^2 + q^2 X) should be 0
chk1 = P1[2]^2 - (P1[1]^3 + (1+q^2)*P1[1]^2 + q^2*P1[1]);
print("P1 on E? (should be 0): ", chk1);

\\ Double P1
P2 = elladd(E, P1, P1);
print("2*P1 = ", P2);

\\ Now P3 = (-q, q(q-1)) should also be order 4
print("");
print("=== Symbolic doubling of P3=(-q, q(q-1)) ===");
P3 = [-q, q*(q-1)];
chk3 = P3[2]^2 - (P3[1]^3 + (1+q^2)*P3[1]^2 + q^2*P3[1]);
print("P3 on E? (should be 0): ", chk3);

P3d = elladd(E, P3, P3);
print("2*P3 = ", P3d);

\\ Also verify P1' = (q, -q(q+1)) doubles to same point
print("");
print("=== 2*(q, -q(q+1)) ===");
P1n = [q, -q*(q+1)];
P1nd = elladd(E, P1n, P1n);
print("2*(q,-q(q+1)) = ", P1nd);

print("");
print("=== 2*(-q, -q(q-1)) ===");
P3n = [-q, -q*(q-1)];
P3nd = elladd(E, P3n, P3n);
print("2*(-q,-q(q-1)) = ", P3nd);

quit;

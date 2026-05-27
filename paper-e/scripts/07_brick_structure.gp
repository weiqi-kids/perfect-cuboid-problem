/* ============================================================
   07_brick_structure.gp
   Explicit brick structure at the unique non-degenerate SG
   candidate (p,q)=(11,71): legs (a,b,c), the three face-diagonal
   conditions, and the space diagonal. Shows precisely WHICH
   condition fails (the third face b^2+c^2), confirming it is a
   genuine non-cuboid (near-miss), not a perfect cuboid.
   ============================================================ */

p = 11; q = 71;
a = 4*p*q; b = q^2 - 4*p^2; c = 2*(q^2 - p^2);
print("SG Case-II candidate (p,q) = (", p, ",", q, ")");
print("Euler-brick legs (a,b,c) = (", a, ",", b, ",", c, ")");
print("");
print("Face diagonal a^2+b^2 = ", a^2+b^2, "  perfect square? ", issquare(a^2+b^2));
print("Face diagonal a^2+c^2 = ", a^2+c^2, "  perfect square? ", issquare(a^2+c^2));
print("Face diagonal b^2+c^2 = ", b^2+c^2, "  perfect square? ", issquare(b^2+c^2), "  <== FAILS");
print("Space diagonal a^2+b^2+c^2 = ", a^2+b^2+c^2, "  perfect square? ", issquare(a^2+b^2+c^2));
print("");
print("Face/Pi value 5q^4 - 16p^2q^2 + 20p^4 = ", 5*q^4-16*p^2*q^2+20*p^4);
print("  equals b^2+c^2 ? ", (5*q^4-16*p^2*q^2+20*p^4) == b^2+c^2);
print("");
print("Conclusion: (11,71) satisfies the space diagonal and TWO face");
print("diagonals (a^2+b^2, a^2+c^2) but NOT the third (b^2+c^2). It is a");
print("near-cuboid, not a perfect cuboid. Hence no SG perfect cuboid arises.");
quit;

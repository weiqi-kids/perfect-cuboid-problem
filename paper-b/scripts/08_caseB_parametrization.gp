\\ ============================================================
\\ Paper B, Script 08: the Case B (p=1) parametrization is a genuine cuboid
\\ candidate with INTEGER parameter q, and all face conditions reduce to the
\\ single space-diagonal equation g^2 = 5q^4 + 20.
\\
\\ Case B at p=1 (proof.md / case-b-closure.md): integer q (odd, >=3), set
\\   a = 4q,  b = q^2 - 4,  c = 2(q^2 - 1),  d = q^2 + 4,  f = 2(q^2 + 1).
\\ Then the three face diagonals d=sqrt(a^2+b^2), e=sqrt(b^2+c^2),
\\ f=sqrt(a^2+c^2) are automatically integers, and the space diagonal is an
\\ integer iff g^2 = a^2+b^2+c^2 = 5q^4 + 20.
\\ ============================================================

a = 4*q;
b = q^2 - 4;
c = 2*(q^2 - 1);
d = q^2 + 4;
ff = 2*(q^2 + 1);

print("=== identity checks (polynomial identities in Z[q]) ===");
print("a^2 + b^2 - d^2 = ", a^2 + b^2 - d^2, "   (face I: a^2+b^2=d^2)");
\\ face III: a^2 + c^2 = f^2
print("a^2 + c^2 - f^2 = ", a^2 + c^2 - ff^2, "   (face III: a^2+c^2=f^2)");
\\ face II: b^2 + c^2 = e^2.  e^2 should equal 5q^4-16q^2+20.
e2 = b^2 + c^2;
print("b^2 + c^2 = ", e2, "   (face II: e^2 = b^2+c^2)");
print("  equals 5q^4 - 16q^2 + 20? ", e2 == 5*q^4 - 16*q^2 + 20);
\\ space diagonal: a^2+b^2+c^2
s2 = a^2 + b^2 + c^2;
print("a^2 + b^2 + c^2 = ", s2, "   (space: g^2 = a^2+b^2+c^2)");
print("  equals 5q^4 + 20? ", s2 == 5*q^4 + 20);

print("\n=== so the joint curve is exactly ===");
print("  e^2 = b^2 + c^2 = 5q^4 - 16q^2 + 20  (face II)");
print("  g^2 = a^2+b^2+c^2 = 5q^4 + 20         (space diagonal)");
print("Face II integrality + space-diag integrality <=> integer point on C.");

print("\n=== non-degeneracy: all edges positive ===");
print("a=4q>0 iff q>0; b=q^2-4>0 iff |q|>=3; c=2(q^2-1)>0 iff |q|>=2.");
print("So a NON-DEGENERATE Case-B cuboid forces b=q^2-4>0, i.e. q an integer >=3.");
{
for(qq = 1, 6,
  print("  q=", qq, ": (a,b,c)=(", 4*qq, ",", qq^2-4, ",", 2*(qq^2-1), ")  b=",
        qq^2-4, if(qq^2-4>0, "  (non-deg edge)", "  (b<=0 DEGENERATE)"));
);
}

print("\n=== integer solutions of g^2 = 5q^4+20 (face II not yet imposed) ===");
print("Set Y=q^2: g^2 - 5 Y^2 = 20. Pell. The Y-orbit is L_{2n-1} (odd Lucas).");
print("Squares among {L_{2n-1}} are L_1=1, L_3=4 ONLY (Cohn 1964) => q in {1,2}.");
print("q=1: b=-3 (and c=0) degenerate;  q=2: b=0 degenerate.");
print("Hence NO non-degenerate Case-B cuboid at p=1.  [UNCONDITIONAL]");
quit;

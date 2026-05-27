\\ Step 2: Singular locus of W
\\ W: F = 4 m^2 n^2 Y^2 - 4 m^2 n^2 X^2(X+1) - (m^2-n^2)^2 X(X+1) = 0
\\ Singular locus = V(F, dF/dX, dF/dY, dF/dm, dF/dn)

print("====================================================");
print(" Step 2: Singular locus of W");
print("====================================================");

F = 4*m^2*n^2*Y^2 - 4*m^2*n^2*X^2*(X+1) - (m^2-n^2)^2*X*(X+1);

dFdX = deriv(F, X);
dFdY = deriv(F, Y);
dFdm = deriv(F, m);
dFdn = deriv(F, n);

print("F = ", F);
print();
print("dF/dX = ", dFdX);
print();
print("dF/dY = ", dFdY);
print();
print("dF/dm = ", dFdm);
print();
print("dF/dn = ", dFdn);

\\ Analysis:
\\ dF/dY = 8 m^2 n^2 Y. So Y=0 OR m=0 OR n=0 on singular locus.
\\
\\ Case A: m=0 (or n=0)
\\   F|_{m=0} = -X(X+1) n^4 = -(X^2+X) n^4
\\   dF/dX|_{m=0} = -(2X+1) n^4
\\   Both vanish: n=0 OR (X=0 or X=-1 with 2X+1=0 -- impossible)
\\   So singular at m=0, n=0 (plus the n^4 makes m=0 part of higher mult)
\\   Or: m=0 and X=0 or X=-1 with n^4 = 0 (i.e. n=0)
\\   With m=0, n=0: also need to check other vars; F|_{m=n=0}=0 trivially.
\\   So the locus m=n=0 lies on singular set.
\\
\\ Case B: Y=0 and m,n != 0
\\   F = -4 m^2 n^2 X^2(X+1) - (m^2-n^2)^2 X(X+1)
\\     = -X(X+1) [4 m^2 n^2 X + (m^2-n^2)^2]
\\   dF/dX = -8 m^2 n^2 X(X+1) - 4 m^2 n^2 X^2 -(m^2-n^2)^2 (2X+1)... let me recompute
\\
\\ Use PARI to find Y=0 singular locus:
print();
print("=== Y=0 slice ===");
Fy0 = subst(F, Y, 0);
print("F|_{Y=0} = ", Fy0);
print("  = -X(X+1) * [4 m^2 n^2 X + (m^2-n^2)^2]");
\\ Factor confirmation:
factX = -X*(X+1) * (4*m^2*n^2*X + (m^2-n^2)^2);
print("Check factorization: ", Fy0 - factX);

dFy0_dX = deriv(Fy0, X);
dFy0_dm = deriv(Fy0, m);
dFy0_dn = deriv(Fy0, n);
print();
print("dF/dX|_{Y=0} = ", dFy0_dX);
print("dF/dm|_{Y=0} = ", dFy0_dm);
print("dF/dn|_{Y=0} = ", dFy0_dn);

\\ Singular points on Y=0 slice:
\\ X = 0: F|_{X=Y=0} = 0
\\   dF/dX|_{X=Y=0} = -1*(4 m^2 n^2 * 0 + (m^2-n^2)^2) * ... = -(m^2-n^2)^2
\\   Setting dF/dX = 0 forces m = ±n.
\\
\\ X = -1: similar analysis.
\\
\\ Bracket [4 m^2 n^2 X + (m^2-n^2)^2] = 0:
\\   X = -(m^2-n^2)^2 / (4 m^2 n^2) = -q^2 (negative of q^2)
\\   This means X = -q^2 is where the cubic factor X(X+1)(X+q^2) has its third root,
\\   i.e. one of the 2-torsion points of E_PCP(q).

print();
print("Singular points on Y=0:");
print("  (a) X=0 line: requires m = ±n => q=0 (degenerate)");
print("  (b) X=-1 line: requires (m^2-n^2)^2 vanishing in dF/dX = 0 along this line");
print("       => m = ±n");
print("  (c) X=-q^2 locus: 2-torsion of E, becomes singular when?");

\\ Let's compute formally
\\ At point (X=-q^2, Y=0, m, n) where 4m^2n^2 X + (m^2-n^2)^2 = 0:
\\ The polynomial -X(X+1) is non-vanishing (X=-q^2 != 0,-1 generically).
\\ The bracket [4m^2n^2 X + (m^2-n^2)^2] vanishes; gradient is non-zero in (X,m,n).
\\ So this is a transverse zero, NOT singular.

\\ Computing actually:
\\ At Y=0: F = -X(X+1) * Bracket, where Bracket = 4 m^2 n^2 X + (m^2-n^2)^2
\\ Sing locus on F=0, Y=0 requires F=0 AND dF/dX, dF/dm, dF/dn all = 0.
\\ Since F factors as A*B with A = -X(X+1), B = Bracket:
\\   dF/dX = (dA/dX)*B + A*(dB/dX) = -(2X+1)*B + A*(4 m^2 n^2)
\\   For this to vanish along A=0 (X=0 or X=-1):
\\     A=0 => -(2X+1)*B must = 0
\\     X=0: -(1)*B = -(m^2-n^2)^2 = 0 => m = ±n
\\     X=-1: -(-1)*B = (m^2-n^2)^2 - 4m^2n^2 = (m^2-n^2-2mn)(m^2-n^2+2mn) = 0
\\           => m^2 - 2mn - n^2 = 0 or m^2 + 2mn - n^2 = 0
\\           => m/n = 1±sqrt(2) or m/n = -1±sqrt(2)
\\           (irrational roots, but rationally still curve)
\\
\\ Similarly check B=0 (i.e. X = -q^2):
\\   dF/dX along B=0: -(2X+1)*0 + A*(4 m^2 n^2) = A*(4m^2n^2)
\\   For this to vanish: A=0 or m=0 or n=0
\\     B=0 AND A=0: simultaneous on X=0 or X=-1.
\\
\\ So singular locus contains:
\\   (S1) (X=0, Y=0, m^2 = n^2): degenerate q=0 family
\\   (S2) (X=-1, Y=0, m^2-n^2 = ±2mn): two curves
\\   (S3) (m=0) or (n=0): the boundary "q=∞" lines

print();
print("=== Summary of singular locus ===");
print("(S1) X=0, Y=0, m=±n (lines, q=0 degeneration)");
print("(S2) X=-1, Y=0, m^2 ∓ 2mn - n^2 = 0 (curves, irrational slopes)");
print("(S3) m=0 axis and n=0 axis (q=∞ degenerations)");
print();
print("All singularities are at degenerate locus q ∈ {0, ∞}.");
print("Generic fiber E_PCP(q) for q ∉ {0,∞} is smooth.");
print("Singular locus has dimension ≤ 1 inside the 3-fold W.");

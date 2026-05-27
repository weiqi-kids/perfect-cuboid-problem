\\ ============================================================
\\ 01_identity_and_reduction.gp
\\ Verify the Sophie-Germain identity, the Case I/II polynomials,
\\ and the reduction of the SG sub-family to the quartic C_anom.
\\ PARI/GP 2.15.4
\\ ============================================================

print("=== Sophie-Germain identity (*) ===");
\\ q^4 + 4 p^4 = ((q-p)^2 + p^2)*((q+p)^2 + p^2)
resid = (q^4 + 4*p^4) - ( ((q-p)^2 + p^2)*((q+p)^2 + p^2) );
print("Identity (*) residual (must be 0): ", resid);

print("");
print("=== Case II polynomial: 4B = poly_II(p) ===");
\\ Case II: A = (q-p)^2+p^2 = alpha^2  (Pythagorean: q-p = 2mn, p odd leg)
\\ For p prime: m=(p+1)/2, n=(p-1)/2, so q - p = 2mn = (p^2-1)/2,
\\ q = (p^2 + 2p - 1)/2.
\\ B = (q+p)^2 + p^2 = 5 beta^2.  Clear denominators: 4B = poly_II.
qII = (p^2 + 2*p - 1)/2;
B_II = (qII + p)^2 + p^2;
polyII_check = 4*B_II;
print("4*B in Case II = ", polyII_check);
polyII = p^4 + 8*p^3 + 18*p^2 - 8*p + 1;
print("poly_II(p)     = ", polyII);
print("difference (must be 0): ", polyII_check - polyII);

print("");
print("=== Case I polynomial: poly_I(p) = poly_II(-p) ===");
\\ Case I: q = (p^2 - 2p - 1)/2
qI = (p^2 - 2*p - 1)/2;
B_I = (qI + p)^2 + p^2;
polyI_check = 4*B_I;
print("4*B in Case I  = ", polyI_check);
polyI = p^4 - 8*p^3 + 18*p^2 + 8*p + 1;
print("poly_I(p)      = ", polyI);
print("difference (must be 0): ", polyI_check - polyI);
print("poly_I(p) - poly_II(-p) (must be 0, symmetry Y -> -Y): ", subst(polyI,p,p) - subst(polyII,p,-p));

print("");
print("=== C_anom : 20 Z^2 = Y^4 + 8 Y^3 + 18 Y^2 - 8 Y + 1 ===");
print("(Y=p, Z=2*beta; the SG Case-II reduction quartic)");
f(Y) = Y^4 + 8*Y^3 + 18*Y^2 - 8*Y + 1;
print("f(1) = ", f(1), "  (so (Y,Z)=(1,1) is a rational point: 20*1 = 20)");

quit;

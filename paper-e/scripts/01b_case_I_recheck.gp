\\ ============================================================
\\ 01b_case_I_recheck.gp
\\ Carefully re-derive Case I to resolve the discrepancy found in 01.
\\ In Case I: A = (q-p)^2 + p^2 = 5 alpha^2,  B = (q+p)^2 + p^2 = beta^2.
\\ So the Pythagorean triple is (q+p, p, beta) with p the odd leg.
\\ For p prime: q + p = 2mn = (p^2-1)/2  => q = (p^2 - 2p - 1)/2.
\\ Then A = (q-p)^2 + p^2 must equal 5*alpha^2.  Clear denominators on A.
\\ ============================================================

print("=== Case I: re-derive the constraining quartic ===");
qI = (p^2 - 2*p - 1)/2;
A_I = (qI - p)^2 + p^2;       \\ this is the '= 5 alpha^2' side
print("4*A in Case I = ", 4*A_I);
print("  vs poly_I(p) = ", p^4 - 8*p^3 + 18*p^2 + 8*p + 1);
print("  difference   = ", 4*A_I - (p^4 - 8*p^3 + 18*p^2 + 8*p + 1));

print("");
print("So in Case I the '=5*square' constraint is on A, giving 4A=poly_I(p),");
print("not on B. The earlier '4B' was the trivially-square Pythagorean side.");
print("");
print("Cross-check: poly_I(p) = poly_II(-p) ?");
polyII = p^4 + 8*p^3 + 18*p^2 - 8*p + 1;
print("  poly_II(-p) = ", subst(polyII,p,-p));
print("  4*A_I       = ", 4*A_I);
print("  equal? diff = ", 4*A_I - subst(polyII,p,-p));

print("");
print("=> Case I reduces to 20 Z^2 = poly_I(Y) = poly_II(-Y),");
print("   i.e. the SAME curve C_anom under Y -> -Y.  Confirmed.");
quit;

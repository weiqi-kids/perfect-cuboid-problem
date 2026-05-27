\\ Compute p_lo for each patch on ε = [1, 219, 219].

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;
C21 = e2 - e1;  \\ positive
C31 = e3 - e1;  \\ positive
C12 = e1 - e2;  \\ negative
C32 = e3 - e2;  \\ positive
C13 = e1 - e3;  \\ negative
C23 = e2 - e3;  \\ negative

d1 = 1; d2 = 219; d3 = 219;

print("=== p_lo per patch ===");
print();

\\ z_1 patch (X̃ = (d1 p^2 + e1 q^2)/q^2):
\\   d2*(d1 p^2 - C21 q^2) >= 0 since d2 > 0 ⇒ p^2 >= C21*q^2/d1
\\   d3*(d1 p^2 - C31 q^2) >= 0 since d3 > 0 ⇒ p^2 >= C31*q^2/d1
\\   max(p_lo) = sqrt(C31)*q = 22.59e6 * q
print("z_1 patch  ε=[1,219,219]:");
print("  C21 = ", C21, "  sqrt(C21) = ", sqrtint(C21));
print("  C31 = ", C31, "  sqrt(C31) = ", sqrtint(C31));
print("  q=1 ⇒ p_lo = ", sqrtint(C31) + 1, " (~22.6M)");
print();

\\ z_2 patch (X̃ = (d2 p^2 + e2 q^2)/q^2):
\\   d1*(d2 p^2 - C12 q^2) > 0. d1=1>0, C12=-(C21)<0 ⇒ d2 p^2 + C21 q^2 > 0 always; no lower bound.
\\   d3*(d2 p^2 - C32 q^2) > 0. d3=219>0, C32>0 ⇒ p^2 >= C32*q^2/d2.
\\   p_lo = sqrt(C32/d2)*q
print("z_2 patch  ε=[1,219,219]:");
print("  C12 = ", C12, " (negative; auto-satisfied)");
print("  C32 = ", C32, "  d2 = ", d2);
print("  C32/d2 = ", C32 * 1.0 / d2);
print("  q=1 ⇒ p_lo = ", sqrtint(C32 \ d2) + 1, " (≈", sqrt(C32 * 1.0 / d2), ")");
print();

\\ z_3 patch (X̃ = (d3 p^2 + e3 q^2)/q^2):
\\   d1*(d3 p^2 - C13 q^2) > 0. d1=1>0, C13<0 ⇒ auto-satisfied (always nonneg, indeed positive).
\\   d2*(d3 p^2 - C23 q^2) > 0. d2=219>0, C23<0 ⇒ auto-satisfied.
\\   p_lo = 0!
print("z_3 patch  ε=[1,219,219]:");
print("  C13 = ", C13, " (negative; auto-satisfied)");
print("  C23 = ", C23, " (negative; auto-satisfied)");
print("  q=1 ⇒ p_lo = 0 — search starts at 0 (but range capped by height bound)");
print();

\\ Sanity: for z_2 patch we need C32 and to check
\\ d3*(d2 p^2 - C32 q^2) = 219*(219 p^2 - (e3-e2) q^2)
print("  C32 numeric: ", C32);
print("  C32 / d2 numeric: ", C32 * 1.0/ d2);

\\ Note: z_3 patch ε=[1,219,219] is highly symmetric to z_2 because d2=d3=219; if (X̃, ...) on z_2 with (p,q) corresponds, swapping the role of e2 and e3...
\\ Actually z_2 and z_3 are different patches: z_2 = pt with X̃-e2 = d2 z_2^2, z_3 = pt with X̃-e3 = d3 z_3^2.
\\ For the same x_E we'd have different p,q since e2 ≠ e3.

quit;

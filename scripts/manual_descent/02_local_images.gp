\\ 02_local_images.gp — Compute the LOCAL 2-descent image at each bad place v of Q(q)
\\
\\ At each place v of Q(q), we restrict the curve E_PCP/Q(q) to its completion at v.
\\ The local 2-descent image is the image of E(K_v)/2E(K_v) → (K_v*/K_v*^2)^2.
\\
\\ For multiplicative (split or non-split) reduction at v:
\\   image(E(K_v)/2E(K_v) → K_v*/K_v*^2 x K_v*/K_v*^2) has F_2-dim = 1
\\
\\ For good reduction at v: image has dim = 0 (assuming residue char ≠ 2 and v unramified).
\\
\\ For our places:
\\   v = (q):   I_4 (split? non-split?), residue field Q
\\   v = (q-1): I_2
\\   v = (q+1): I_2
\\   v = infty: I_4 (degree -1 at infinity)
\\   v = 2 (arithmetic): char 2, complicated
\\   v = R:    archimedean

default(parisize, 1000000000);

\\ STEP 1: Verify reduction type at each geometric place.
\\
\\ At v = (q), uniformizer is q.
\\ Discriminant of E: 16 q^4 (q-1)^2 (q+1)^2, v_q-valuation = 4.
\\ j-invariant: j(E) = 256(...) / (q^4 (q-1)^2 (q+1)^2) -- pole, hence multiplicative reduction.
\\ Type: I_4 (since v(j) = -4 and v(Δ) = 4).
\\ Split iff some condition on minimal model coefficients mod q.
\\
\\ Let me check the minimal Weierstrass form at q=0.
\\ E: Y^2 = X^3 + (1+q^2)X^2 + q^2 X
\\ a_2 = 1+q^2, a_4 = q^2, a_6 = 0.
\\ At q=0: y^2 = x^3 + x^2, node at (0,0).
\\ Tangent directions: y = ±x (rational), so SPLIT multiplicative at q=0.
\\
\\ At q=1: y^2 = x(x+1)(x+1) = x(x+1)^2.
\\ Double root at x=-1. Tangent: y^2 = (x+1)^2 * (-1+...) -- let's check.
\\ At x = -1, y = 0: y^2 = x(x+1)^2. So (x+1)^2 = y^2/x. Near (-1, 0), x ≈ -1 + ε:
\\   y^2 = (-1+ε) ε^2 ≈ -ε^2 for small ε. Tangents y = ± i*ε: NON-SPLIT multiplicative.
\\ Wait, over Q(q), specializing at q=1 gives this. Over Q[q]/(q-1) the residue is Q,
\\ and -1 is not a square in Q. So NON-SPLIT.
\\
\\ Similarly at q=-1: y^2 = x(x+1)(x+1) -- same form, NON-SPLIT.
\\
\\ At q=∞: use t = 1/q. Substitute x = q^2 X, y = q^3 Y in y^2 = x(x+1)(x+q^2):
\\   q^6 Y^2 = q^2 X (q^2 X + 1)(q^2 X + q^2)
\\           = q^2 X * (q^2 X + 1) * q^2 (X+1)
\\           = q^4 X (X+1)(q^2 X + 1)
\\ So Y^2 = X(X+1)(q^2 X + 1)/q^2... not quite right. Let me redo.
\\ Actually: substitute X = q^2 X', Y = q^3 Y':
\\   q^6 Y'^2 = q^2 X' (q^2 X' + 1)(q^2 X' + q^2)
\\           = q^2 X' (q^2 X' + 1) q^2 (X' + 1)
\\           = q^4 X' (X'+1)(q^2 X' + 1)
\\ So Y'^2 = X'(X'+1)(q^2 X' + 1)/q^2 -- not nice.
\\
\\ Better: substitute X = X'/q^2, Y = Y'/q^3:
\\   Y'^2/q^6 = (X'/q^2)(X'/q^2 + 1)(X'/q^2 + q^2)
\\           = X'/q^2 * (X' + q^2)/q^2 * (X' + q^4)/q^2
\\           = X'(X'+q^2)(X'+q^4)/q^6
\\ So Y'^2 = X'(X'+q^2)(X'+q^4). At t = 1/q = 0:
\\           Y'^2 = X'(X' + 0)(X' + 0) = X'^3, a cusp. Wait that's bad.
\\ Hmm. Let me re-examine.
\\
\\ Actually the standard approach: the elliptic surface has reduction type determined
\\ by j-invariant. j has poles at q=0 of order 4 (since v_q(Δ) = 4 and 1/j has zero of order 4
\\ ... no wait).
\\
\\ Let me compute j(E):
\\   c_4 = 16(a_2^2 - 3 a_4) = 16((1+q^2)^2 - 3 q^2) = 16(1 + 2q^2 + q^4 - 3q^2) = 16(q^4 - q^2 + 1)
\\   c_6 = -64(...complicated...)
\\   Δ = 16 (e_1-e_2)^2 (e_1-e_3)^2 (e_2-e_3)^2 = 16 * 1 * q^4 * (q^2-1)^2
\\        = 16 q^4 (q-1)^2 (q+1)^2
\\   j = c_4^3/Δ = 16^3 (q^4-q^2+1)^3 / (16 q^4 (q-1)^2 (q+1)^2)
\\     = 256 (q^4-q^2+1)^3 / (q^4 (q^2-1)^2)
\\
\\ At q=0: v_q(c_4) = 0, v_q(Δ) = 4, v_q(j) = -4. So I_4 multiplicative.
\\ At q=1: v(c_4) = 0 (since q^4-q^2+1 = 1 at q=1), v(Δ) = 2, so I_2.
\\ At q=-1: same, I_2.
\\ At q=∞: use t = 1/q. Let's substitute q = 1/t and clear denominators.
\\   y^2 = x(x+1)(x + 1/t^2)
\\ Multiply both sides by t^4 and let Y = y * t^3, X = x * t^2:
\\   t^4 y^2 = (x t^2)(x t^2 + t^2)(x t^2 + 1)
\\         => (t^3 y)^2 / t^2 = (x t^2)(x t^2 + t^2)(x t^2 + 1)
\\   This is messy. Standard substitution X = x*t^2, Y = y*t^3:
\\     Y^2 = t^6 y^2 = t^6 x(x+1)(x+1/t^2) = (xt^2)(xt^2 + t^2)(xt^2 + 1) * t^0
\\         = X (X + t^2)(X + 1).
\\   So Y^2 = X(X+1)(X + t^2). At t=0: Y^2 = X^2(X+1) -- I_2 type? But v(Δ) at t=0?
\\   Δ_new = 16 (X-X')... actually for E': Y^2 = X(X+1)(X+t^2), e_1' = 0, e_2' = -1, e_3' = -t^2.
\\   Differences: e_1'-e_2' = 1, e_1'-e_3' = t^2, e_2'-e_3' = t^2-1.
\\   Δ' = 16 * 1 * t^4 * (t^2-1)^2 ~ t^4 at t=0. So v_t(Δ') = 4, and v_t(c_4') = 0,
\\   so v_t(j') = -4, I_4 reduction at t=0 ⟺ q=∞. ✓
\\
\\ But wait, I had X(X+1) factoring as I_2 at t=0. Let me recheck: at t=0,
\\   Y^2 = X(X+1)(X+0) = X^2(X+1).
\\   This has a node at (0,0) with tangents Y = ± X * sqrt(0+1) = ± X. SPLIT MULTIPLICATIVE.
\\   Why does v(Δ') = 4 then? Because it's I_4 (4 components in the special fiber), and
\\   each node contributes... no. A single node is type I_n where n = v(Δ). So I_4 at t=0.
\\   But seeing y^2 = X^2(X+1) shows just a node, suggesting I_1. Discrepancy!
\\
\\ Resolution: the equation Y^2 = X^2(X+1) gives a NODAL singular fiber, but the model
\\ is not yet minimal. The Tate algorithm would give a minimal model and the actual fiber
\\ type. Type I_4 means 4 components arrange as a cycle.
\\
\\ For us, the key fact is just that ALL bad fibers are MULTIPLICATIVE (Kodaira I_n).
\\ For multiplicative reduction, image(E(K_v)/2E(K_v)) → (K_v^*/K_v^*2)^2 has F_2-dim ≤ 1
\\ (Mazur-style: it's "1 bit per place of multiplicative reduction").

\\ Now we set up the global Selmer enumeration.
print("=== Function-field 2-Selmer over Q(q) ===");
print();
print("Bad places v of Q(q) (the support set):");
print("  v_0 = (q),    type I_4 split multiplicative");
print("  v_1 = (q-1),  type I_2 non-split multiplicative");
print("  v_-1 = (q+1), type I_2 non-split multiplicative");
print("  v_inf = (1/q), type I_4 (mult, split status TBD)");
print();
print("Plus arithmetic places of Q under Q(q):");
print("  v_2 = prime 2");
print("  v_R = archimedean");
print();
print("Selmer ambient subgroup of (K*/K*^2)^2:");
print("  K = Q(q), so K*/K*^2 has F_2-basis: {-1, 2, 3, 5, ..., q, q-1, q+1, ...}");
print("  Restricted to S-support: basis = {-1, 2, q, q-1, q+1}, dim = 5.");
print("  (d_1, d_2) ambient: 5 + 5 = 10 dimensions.");
print();
print("Constraint: d_1 * d_2 ≡ (e_1-e_2)(e_1-e_3) = q^2 ≡ 1 mod squares.");
print("Wait, actually we need d_1 d_2 ≡ e_3 - e_1)^{-1} (e_3-e_1) ... need to be careful.");
print();
print("In the standard 3-coordinate descent (d_1, d_2, d_3), product is a square.");
print("Here d_3 ~ d_1 * d_2 (mod squares).");
print("Equivalently, d_3 = X(P) - e_3 = X(P) + q^2.");
print("Constraint: d_3 = d_1 d_2 / (some constant)?");
print("Actually d_1 d_2 d_3 = Y^2, so d_1 d_2 d_3 ≡ 1 mod squares.");
print("So d_3 ≡ d_1 d_2 mod squares, AND d_3 must also be S-supported.");
print();
print("So the ambient is just 10-dim (d_1, d_2), with the IMPLICIT constraint that d_1*d_2");
print("is S-supported (automatic since d_1, d_2 are).");

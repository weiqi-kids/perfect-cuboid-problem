\\ 04_function_field_descent.gp — Manual function-field 2-descent of E_PCP/Q(q)
\\
\\ STRATEGY: Compute dim_F_2 Sel_2(E_PCP/Q(q)) by enumeration over the candidate Selmer group
\\           and local solvability check at each bad place.
\\
\\ The 2-Selmer group sits inside (K*/K*^2)^2 where K = Q(q). The image must be supported
\\ on the bad places of E, which are S = { (q), (q-1), (q+1), infty (geometric), -1, 2 }.
\\
\\ Generators of K*/K*^2 supported on S:
\\   {-1, 2, q, q-1, q+1}      (5 generators, F_2-dim 5)
\\
\\ Ambient (d_1, d_2) space: 10-dim.
\\
\\ Constraint: d_1 * d_2 * d_3 ∈ K*^2 (since product = Y(P)^2).
\\   But d_3 is also restricted to S-support, so this is a consistency condition.
\\   Equivalently, d_3 = d_1 * d_2 (mod squares), and we need d_3 to be in our S-supported group.
\\   Since our S-group is closed under multiplication, this is automatic ⟺
\\   the ambient is closed: 10-dim.
\\
\\ For each candidate (d_1, d_2), the local solvability conditions are:
\\   At each place v ∈ S, the homogeneous space C(d_1, d_2):
\\     d_1 z_1^2 - d_2 z_2^2 = e_2 - e_1 = -1     (T_{12})
\\     d_1 z_1^2 - d_3 z_3^2 = e_3 - e_1 = -q^2   (T_{13})
\\   has a K_v-point.
\\
\\ Note: (d_3 = d_1 d_2 mod squares, so T_{13} becomes:
\\        d_1 z_1^2 - d_1 d_2 z_3^2 = -q^2
\\        Dividing by d_1: z_1^2 - d_2 z_3^2 = -q^2 / d_1)
\\
\\ Using Hilbert symbols: ternary form A x^2 + B y^2 + C z^2 = 0 over K_v is isotropic iff
\\   (-AB, -AC)_v = 1.
\\
\\ Rewrite:
\\   T_{12}: d_1 z_1^2 - d_2 z_2^2 - (-1) z_0^2 = 0  (with z_0=1, "-1" coefficient)
\\          form: d_1 x_1^2 - d_2 x_2^2 + x_0^2 = 0 ⟹ A=d_1, B=-d_2, C=1
\\          Iso iff (-d_1 * -d_2, -d_1 * 1)_v = (d_1 d_2, -d_1)_v = 1
\\
\\   T_{13}: d_1 z_1^2 - d_1 d_2 z_3^2 = -q^2
\\          d_1 z_1^2 - d_1 d_2 z_3^2 + q^2 z_0^2 = 0  ⟹ A=d_1, B=-d_1 d_2, C=q^2
\\          Iso iff (-d_1 * -d_1 d_2, -d_1 * q^2)_v = (d_1^2 d_2, -d_1 q^2)_v
\\                                                  ~ (d_2, -d_1)_v   (since q^2, d_1^2 are squares)
\\
\\ So necessary conditions:
\\   C_{12}: (d_1 d_2, -d_1)_v = 1  ⟺  (d_1, -d_1)_v (d_2, -d_1)_v = 1
\\           Since (d_1, -d_1)_v = 1 always, this reduces to (d_2, -d_1)_v = 1
\\   C_{13}: (d_2, -d_1)_v = 1
\\
\\ Wait these are the same! Let me recheck.

default(parisize, 1000000000);

\\ Sanity check on T_{13}:
\\ Let me recompute. T_{13} is d_1 z_1^2 - d_3 z_3^2 = e_3 - e_1, where d_3 = (X - e_3),
\\ etc. The original equation says z_i^2 = (X - e_i)/d_i, so:
\\   d_1 z_1^2 = X - e_1
\\   d_3 z_3^2 = X - e_3
\\   Subtract: d_1 z_1^2 - d_3 z_3^2 = e_3 - e_1
\\
\\ For us e_1 = 0, e_3 = -q^2, so RHS = -q^2.
\\ Conic: d_1 X^2 - d_3 Y^2 + q^2 Z^2 = 0  (writing it as homogenized form)
\\   Hmm, that's d_1 X^2 - d_3 Y^2 = -q^2 Z^2.
\\   ⟹ d_1 X^2 - d_3 Y^2 + q^2 Z^2 = 0
\\   A = d_1, B = -d_3, C = q^2.
\\   Isotropic iff (-AB, -AC)_v = (d_1 d_3, -d_1 q^2)_v = 1.
\\   Substituting d_3 = d_1 d_2 (mod squares): (d_1^2 d_2, -d_1 q^2) ~ (d_2, -d_1) (since d_1^2, q^2 sq).
\\   So C_{13}: (d_2, -d_1)_v = 1.
\\
\\ T_{12}: d_1 z_1^2 - d_2 z_2^2 = e_2 - e_1 = -1 - 0 = -1
\\   d_1 X^2 - d_2 Y^2 + Z^2 = 0
\\   A = d_1, B = -d_2, C = 1.
\\   Iso iff (-AB, -AC) = (d_1 d_2, -d_1) = 1
\\         ⟺ (d_1, -d_1)(d_2, -d_1) = 1 ⟺ (d_2, -d_1) = 1.
\\
\\ T_{23}: d_2 z_2^2 - d_3 z_3^2 = e_3 - e_2 = -q^2 + 1 = 1 - q^2
\\   d_2 X^2 - d_3 Y^2 + (q^2-1) Z^2 = 0
\\   A = d_2, B = -d_3, C = q^2 - 1.
\\   Iso iff (-AB, -AC) = (d_2 d_3, -d_2 (q^2-1)) = (d_1 d_2^2, -d_2(q^2-1))
\\                       ~ (d_1, -d_2(q^2-1))
\\                       = (d_1, -d_2) (d_1, q^2-1)
\\
\\ So T_{23} gives: (d_1, -d_2)(d_1, q^2-1) = 1
\\   ⟺ (d_1, d_2)(d_1, -1)(d_1, q^2-1) = 1
\\   ⟺ (d_1, -d_2(q^2-1))_v = 1.
\\
\\ Combining C_{12} = C_{13}: (d_2, -d_1)_v = 1 = (d_1, -d_2)_v.
\\
\\ So necessary conditions for local solvability at v:
\\   (P1) (d_1, -d_2)_v = 1     (from T_{12} and T_{13})
\\   (P2) (d_1, -d_2(q^2-1))_v = (d_1, -d_2)_v (d_1, q^2-1)_v = 1
\\        Given P1, this simplifies to (d_1, q^2-1)_v = 1.
\\
\\ EXCELLENT! Two clean conditions:
\\   C1: (d_1, -d_2)_v = 1
\\   C2: (d_1, q^2-1)_v = 1
\\
\\ At each bad place v of K = Q(q).

print("=== Function-field 2-descent: setup ===");
print();
print("Necessary local conditions for (d_1, d_2) ∈ Sel_2 image at place v:");
print("  C1: (d_1, -d_2)_v = 1");
print("  C2: (d_1, q^2-1)_v = (d_1, (q-1)(q+1))_v = 1");
print();
print("Note: C2 involves d_1 only (not d_2). Interesting decoupling!");
print();
print("Plus the SAME conditions with d_1 ↔ d_2 (by symmetry):");
print("  C1' = C1 (symmetric in d_1, d_2 up to sign of -d_2)");
print("  C2': (d_2, q^2-1)_v = 1");
print();
print("Wait, the original system is NOT symmetric in (d_1, d_2).");
print("Let me redo: T_{12}, T_{13}, T_{23} are 3 conditions.");
print("After substituting d_3 = d_1 d_2 mod squares, we get 3 Hilbert conditions:");
print("  T_{12}: (d_2, -d_1)_v = 1");
print("  T_{13}: (d_2, -d_1)_v = 1   [same!]");
print("  T_{23}: (d_1, -d_2)(d_1, q^2-1)_v = 1");
print();
print("Hmm, T_{12} and T_{13} give the same condition; T_{23} is independent.");
print("Conditions become:");
print("  N1: (d_1, -d_2)_v = (d_2, -d_1)_v = 1");
print("  N2: (d_1, q^2-1)_v = 1   (given N1)");

\\ Let me explicitly verify the derivation by examining the conic structure.
\\
\\ Hilbert symbol bilinearity:
\\   (a, b)_v = (b, a)_v
\\   (a, b c)_v = (a, b)_v (a, c)_v
\\   (a, -a)_v = (a, 1-a)_v = 1
\\
\\ So (d_1, -d_2)_v = (d_1, d_2)_v (d_1, -1)_v.
\\
\\ N1 ⟺ (d_1, d_2)_v (d_1, -1)_v = 1
\\
\\ This is symmetric in d_1, d_2? Yes, by Hilbert symmetry: (d_1, d_2)(d_2, d_1) = 1, etc.

print();
print("=== Equivalent form via bilinearity ===");
print("N1: (d_1, d_2)_v (d_1, -1)_v = 1");
print("N2: (d_1, q^2-1)_v = 1");
print();
print("Alternatively, swap roles 1↔2: from T_{12}' (or just by symmetry of pairs):");
print("  (d_2, d_1)_v (d_2, -1)_v = 1, so by reciprocity (d_1, d_2)_v (d_2, -1)_v = 1.");
print("Combined with N1: (d_1, -1) = (d_2, -1) at each v.");
print();
print("=== Therefore final necessary conditions ===");
print("  N1: (d_1, d_2)_v = (d_1, -1)_v = (d_2, -1)_v");
print("  N2: (d_1, q^2 - 1)_v = 1");
print("  N3: (d_2, q^2 - 1)_v = 1   (by analogous T_{23} argument with d_2)");
print();
print("Equivalently:");
print("  (d_1, d_2)_v = (d_1 d_2, -1)_v / 1   [need to re-derive]");

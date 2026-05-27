\\ Script 03: Determine the integral lattice structure of Pic(V'_bar).
\\
\\ The KEY geometric question:
\\
\\ Consider one face Pythagorean cover, say a^2 + b^2 = d^2.
\\ Over Q(i): a^2 + b^2 = (a + ib)(a - ib).  So:
\\   L+ := {a + ib = 0} ∩ V'   (over Q(i))
\\   L- := {a - ib = 0} ∩ V'   (complex conjugate)
\\
\\ The divisor {d = 0} ∩ V' is the locus where d = 0, but also a^2+b^2=0,
\\ b^2+c^2=e^2, a^2+c^2=f^2.  Locus is 0-dimensional (a=±ib gives a/b=±i,
\\ then b^2+c^2=e^2, a^2+c^2=f^2 reduce to (i b)^2 + c^2 = f^2,
\\ i.e. c^2 - b^2 = f^2, and c^2 + b^2 = e^2.  Adding: 2c^2 = e^2 + f^2;
\\ subtracting: 2b^2 = e^2 - f^2.)  So {d=0} is generically 0-dim, NOT a
\\ divisor.
\\
\\ However: the divisor [d] = H_d (hyperplane d=0 in P^5 intersected with V')
\\ is a DEGREE-8 curve (the hyperplane section is degree-8 K3 ∩ P^4 = curve
\\ of arithmetic genus 9 by adjunction, since K3 ∩ H = K + H restriction).
\\
\\ Actually [d] = [a=0] = ... = [f=0] all equal the hyperplane class H in Pic.
\\
\\ The CONIC {a^2 + b^2 = 0} pulled back to V' splits OVER Q(i) into
\\ two LINES:
\\   {a + ib = 0} and {a - ib = 0}.
\\ But wait, these are loci in V', not in P^2. In V', the condition
\\ a + ib = 0 (and the other quadrics) defines a CURVE.  Let's check
\\ its dimension and genus.
\\
\\ At a + ib = 0 (so b = i*a):
\\   d^2 = a^2 + b^2 = a^2 - a^2 = 0  =>  d = 0  (a 1-dim'l condition).
\\   b^2 + c^2 = e^2  =>  -a^2 + c^2 = e^2  (codim 1 in (a, c, e) space)
\\   a^2 + c^2 = f^2  (codim 1 in (a, c, f) space)
\\ So {a+ib=0, d=0, b^2+c^2=e^2, a^2+c^2=f^2} is a complete intersection
\\ in P^5_Q(i) of 4 equations, giving generically dim = 5 - 4 = 1.  YES,
\\ it's a curve.
\\
\\ This curve consists of solutions:
\\   (a : ia : c : 0 : ±√(c²-a²) : ±√(c²+a²))
\\ over Q(i), with a, c free.  In P^1 with [a:c], the e, f are determined
\\ up to ±.  4 components (sign choices of e, f).  Genus computation later.
\\
\\ KEY: L+ = {a + ib = 0} ∩ V' is a divisor (curve) on V' defined over Q(i).
\\ Its complex conjugate L- = {a - ib = 0} ∩ V' is also a curve defined over Q(i).
\\
\\ Galois action: sigma(L+) = L- and vice versa.
\\
\\ Linear equivalence class: [L+] + [L-] = ?
\\ Algebraically: (a + ib) (a - ib) = a^2 + b^2 = d^2 on V'.
\\ So the divisor [L+] + [L-] is the divisor of the rational function
\\ (a + ib)(a - ib) - d^2 evaluated... but on V' the equation a^2+b^2 = d^2
\\ already holds, so this is the divisor of 0, which is improper.
\\
\\ Better: the divisor [L+] + [L-] is given by the intersection
\\ V' ∩ {(a + ib)(a - ib) = 0} = V' ∩ {a^2 + b^2 = 0} = V' ∩ {d^2 = 0}
\\ = V' ∩ {d = 0} (with multiplicity 2).
\\
\\ So [L+] + [L-] = 2 [V' ∩ {d = 0}] = 2 · H (in Pic, since {d=0} cuts out a
\\ hyperplane section).
\\
\\ Therefore: [L+] + [L-] = 2 H in NS(V'_bar).
\\
\\ Equivalently: [L+] + [L-] - 2H = 0 in Pic.
\\
\\ This is exactly Scenario D.  In integral basis:
\\   The Galois orbit {L+, L-} has SUM = 2H (twice a Q-rational class)
\\   In NS, the rank-2 sublattice spanned by L+, L- contains 2H but NOT H/2.
\\   So Z*L+ + Z*L- is a rank-2 lattice on which sigma swaps the basis
\\   (permutation orbit, Scenario A).
\\
\\ Question: is H itself in this rank-2 sublattice?  No — H is in a separate
\\ Q-rational direction (counted among the 16 Q-rational classes).
\\
\\ So the relevant orbit lattice is JUST Z*L+ + Z*L-, which is permutation.
\\ The fact that L+ + L- = 2H IS a relation in NS, but it forces 2H to be
\\ equal to a specific element of the orbit sublattice — i.e., H is
\\ identified with (L+ + L-)/2 in NS_geom.
\\
\\ Wait — that's an INTEGRALITY question.  Is H = (L+ + L-)/2 INTEGRAL?
\\ YES! H is integral (it's the hyperplane class).
\\
\\ So the integral lattice spanned by H, L+, L- has rank ≤ 3 with
\\ relation L+ + L- = 2H.  Integrally:
\\   The lattice is Z * H + Z * L+ + Z * L- / (L+ + L- = 2H)
\\   ≅ Z * H + Z * L+    (using L- = 2H - L+)
\\   ≅ Z^2 with basis (H, L+).
\\
\\ Galois action: sigma fixes H, sigma sends L+ to L- = 2H - L+.
\\ So in basis (H, L+):
\\   sigma . H = H
\\   sigma . L+ = 2H - L+ = -L+ + 2H
\\ Matrix:  [[1, 2], [0, -1]]
\\
\\ This is NOT diagonal!  Let me compute H^1 in this basis.

default(parisize, 1000000000);

print("==============================================================");
print("Script 03: Actual integral lattice structure of Pic-orbit");
print("==============================================================");

\\ One face orbit:  basis (H, L+), sigma matrix [[1, 2], [0, -1]].
print("\nOne face orbit (basis: H, L+):");
M1 = [1, 2; 0, -1];
print("sigma = ", M1);
N1 = M1 + matid(2);
delta1 = matid(2) - M1;
print("N = ", N1, "  (matrix is M+I)");
print("delta = ", delta1, "  (matrix is I-M)");
print("ker(N) = ");
print(matker(N1));
print("im(delta) = ");
print(mathnf(delta1));

\\ ker(N) (since N = [[2, 2], [0, 0]] = rank 1):
\\   kernel of [[2,2],[0,0]] over Q is {x: 2x_1 + 2x_2 = 0} = {(t, -t)}.
\\   Over Z: ker = Z * (1, -1).
\\ im(delta) (delta = [[0, -2], [0, 2]] = rank 1):
\\   col span = Z * (-2, 2) = Z * (1, -1) * 2 in saturation.
\\   So im(delta) = 2 * Z * (1, -1).
\\
\\ H^1 = ker(N) / im(delta) = Z * (1,-1) / 2 * Z * (1,-1) = Z/2.

\\ Verify by Smith normal form:
K = matker(N1);
print("\nker(N) basis = ", K);
\\ K is a Q-basis of kernel; saturate to Z-basis.
K_Z = mathnf(K);
print("K saturated (HNF) = ", K_Z);

I_Z = mathnf(delta1);
print("im(delta) Z-basis (HNF) = ", I_Z);

\\ Express I_Z in basis K_Z (over Z):
\\ K_Z is 2x1, I_Z is 2x1 (column vectors).
\\ Solve K_Z * x = I_Z for integer x.
k1 = matsize(K_Z)[2];
m1 = matsize(I_Z)[2];
print("k = ", k1, ", m = ", m1);

X = matrix(k1, m1);
for(j = 1, m1,
  sol = matsolve(K_Z * 1.0, I_Z[, j] * 1.0);
  for(i = 1, k1, X[i, j] = round(sol[i]));
);
print("Inclusion matrix X = ", X);
print("X * K_Z = ", K_Z * X);
print("Matches I_Z? ", K_Z * X == I_Z);

snf = matsnf(X);
print("SNF of X = ", snf);
print("");
print("H^1(<sigma>, integral orbit lattice for ONE face)  = Z/", snf[1]);
print("(elementary divisors: ", snf, ")");

\\ ----- Multi-face computation: all 3 face Pythagorean pairs -----
\\
\\ Full Galois module structure of Pic(V'_bar) (using rho_geom = 20):
\\   - 16 Q-rational classes:
\\     1. H (hyperplane)
\\     2-4. F_1, F_2, F_3 (face fibrations)
\\     5-16. E_1..E_12 (exceptional curves over the 12 A_1 nodes)
\\   - 3 face Pythagorean pairs (L_i^+, L_i^-) for i = 1, 2, 3 (one per face):
\\     L_1^+ = {a + ib = 0}, L_1^- = {a - ib = 0}   (face d^2 = a^2 + b^2)
\\     L_2^+ = {b + ic = 0}, L_2^- = {b - ic = 0}   (face e^2 = b^2 + c^2)
\\     L_3^+ = {a + ic = 0}, L_3^- = {a - ic = 0}   (face f^2 = a^2 + c^2)
\\
\\ Linear relations (one per face):
\\   L_1^+ + L_1^- = 2H
\\   L_2^+ + L_2^- = 2H
\\   L_3^+ + L_3^- = 2H
\\
\\ Choose basis:  H, F_1, F_2, F_3, E_1..E_12, L_1^+, L_2^+, L_3^+
\\   (use L_i^- = 2H - L_i^+ to eliminate L_i^-)
\\ Rank = 1 + 3 + 12 + 3 = 19.
\\
\\ But VANLUIJK gives ρ_geom = 16, 18, or 20.  If 20, we need ONE more class.
\\ Candidate: the "diagonal" splitting a^2 + b^2 + c^2 = 0 (which is a Q(i)-conic).
\\ Or a 4th independent class from the linear system relations.
\\
\\ Actually I miscounted: 16 Q-rat + 3 sign-twist classes (each contributing 1
\\ NEW class after L+ + L- = 2H reduction) = 19, NOT 20.
\\
\\ So if rho_geom = 20, we need a 4th orbit (e.g. from a^2+b^2+c^2 = 0 splitting,
\\ which is a smooth Q-conic but reducible over Q(i)).
\\
\\ For now: compute H^1 for the rank-19 case (3 orbits, each contributing Z/2)
\\ AND for the rank-20 case (4 orbits, contributing (Z/2)^4).

print("");
print("=== Multi-face H^1 computation ===");

\\ Build the full Galois module Pic(V'_bar) action matrix.
\\
\\ Basis order:
\\   1: H
\\   2-4: F_1, F_2, F_3
\\   5-16: E_1..E_12
\\   17-19: L_1^+, L_2^+, L_3^+   (sigma sends L_i^+ -> 2H - L_i^+)
\\
\\ rho = 19 for now.

rho = 19;
M_sigma = matid(rho);
\\ Galois action on L_i^+:  L_i^+ -> 2H - L_i^+
\\ i.e., column-i (i = 17, 18, 19) sends sigma(L_i^+) = 2 * H - L_i^+
\\ Matrix entries: M_sigma[1, 17] = 2 (coefficient of H), M_sigma[17, 17] = -1.
M_sigma[1, 17] = 2;  M_sigma[17, 17] = -1;
M_sigma[1, 18] = 2;  M_sigma[18, 18] = -1;
M_sigma[1, 19] = 2;  M_sigma[19, 19] = -1;

print("\nFull Galois action matrix (only rows 1, 17, 18, 19; rest is identity):");
print("Row 1 (H): ", vecextract(M_sigma[1, ], "1..19"));
for(i = 17, 19, print("Row ", i, " (L_", i-16, "^+): ", vecextract(M_sigma[i, ], "1..19")));

\\ Compute H^1.
N_full = M_sigma + matid(rho);
delta_full = matid(rho) - M_sigma;

K_full = matker(N_full);
print("\nker(N) has Q-dim = ", matsize(K_full)[2]);
\\ Need integer basis of saturation:
K_full_Z = mathnf(K_full);
print("ker(N) HNF (Z-basis) =");
print(K_full_Z);

I_full_Z = mathnf(delta_full);
print("\nim(delta) HNF (Z-basis) =");
print(I_full_Z);

kf = matsize(K_full_Z)[2];
mf = matsize(I_full_Z)[2];
print("k = ", kf, ", m = ", mf);

X_full = matrix(kf, mf);
{
for(j = 1, mf,
  sol = matsolve(K_full_Z * 1.0, I_full_Z[, j] * 1.0);
  for(i = 1, kf, X_full[i, j] = round(sol[i]));
);
}
print("Inclusion matrix X (k x m) =");
print(X_full);
print("X * K = I?  ", K_full_Z * X_full == I_full_Z);

snf_full = matsnf(X_full);
print("SNF elementary divisors = ", snf_full);

H1_order_full = 1;
H1_factors_full = [];
{
for(i = 1, length(snf_full),
  d = snf_full[i];
  if(d > 1,
    H1_order_full = H1_order_full * d;
    H1_factors_full = concat(H1_factors_full, [d]);
  );
);
}
print("");
print("=== RESULT (rho = 19, 3 face sign-twist orbits) ===");
print("H^1(Gal, Pic(V'_bar)) = ", H1_factors_full, " (order ", H1_order_full, ")");
print("");

print("This corresponds to Br_1(V')/Br_0 of order ", H1_order_full, ".");
print("");

\\ Also rho = 20: add 4th sign-twist orbit (from a^2+b^2+c^2 = 0, splits over Q(i) via (a+ib)(...) etc)
\\
\\ Hmm actually a^2+b^2+c^2 is not directly a Pythagorean conic, it's the
\\ "anisotropic" form -1 = a^2+b^2+c^2 with no Q-rational point on the
\\ conic.  It DOES split over Q(i) but not in such a simple way.
\\
\\ Alternative: the 20th class could be the 4-torsion-related class from the
\\ "Heron face" structure (m^2 + n^2 + Q(i)-splittings).  We don't have a
\\ clean description.
\\
\\ Conservatively: rho_geom in {16, 18, 19, 20} all give H^1 ∈ {0, Z/2, (Z/2)^2, (Z/2)^3}.
\\ Compute (Z/2)^3 case for 19 = 16 + 3 directly above.
\\
\\ Add a 4th orbit (rho = 20 case):
print("\n=== rho = 20: add 4th sign-twist orbit ===");
rho4 = 20;
M_sigma4 = matid(rho4);
M_sigma4[1, 17] = 2;  M_sigma4[17, 17] = -1;
M_sigma4[1, 18] = 2;  M_sigma4[18, 18] = -1;
M_sigma4[1, 19] = 2;  M_sigma4[19, 19] = -1;
M_sigma4[1, 20] = 2;  M_sigma4[20, 20] = -1;

N4 = M_sigma4 + matid(rho4);
delta4 = matid(rho4) - M_sigma4;

K4_Z = mathnf(matker(N4));
I4_Z = mathnf(delta4);
k4 = matsize(K4_Z)[2];
m4 = matsize(I4_Z)[2];

X4 = matrix(k4, m4);
{
for(j = 1, m4,
  sol = matsolve(K4_Z * 1.0, I4_Z[, j] * 1.0);
  for(i = 1, k4, X4[i, j] = round(sol[i]));
);
}
snf4 = matsnf(X4);
H1_order4 = 1;
H1_factors4 = [];
{
for(i = 1, length(snf4),
  d = snf4[i];
  if(d > 1,
    H1_order4 = H1_order4 * d;
    H1_factors4 = concat(H1_factors4, [d]);
  );
);
}
print("rho = 20: H^1 = ", H1_factors4, " (order ", H1_order4, ")");

print("");
print("=== OVERALL CONCLUSION ===");
print("For rho_geom in {17, 18, 19, 20} the algebraic Brauer group is");
print("(Z/2)^(rho_geom - 16), assuming each extra class comes from a face Pythagorean splitting.");

quit;

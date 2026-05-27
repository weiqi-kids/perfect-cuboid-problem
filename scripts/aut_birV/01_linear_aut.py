#!/usr/bin/env python3
"""
01_linear_aut.py — Compute the obvious linear automorphism group of V.

V ⊂ P^6 with coords (a,b,c,d,e,f,g) is defined by:
  Q1: d^2 - a^2 - b^2 = 0
  Q2: e^2 - b^2 - c^2 = 0
  Q3: f^2 - a^2 - c^2 = 0
  Q4: g^2 - a^2 - b^2 - c^2 = 0

Aut_lin(V) ⊂ PGL(7) preserves the 4-dim ideal I = (Q1,Q2,Q3,Q4) in deg 2.

We exhibit:
  (i)   Sign-flip group S = (Z/2)^7 acting coord-wise (a -> ±a etc.).
        Each Q_i is invariant under independent sign changes of each variable,
        so the full (Z/2)^7 stabilizes I.
  (ii)  Permutation group on (a,b,c) and induced permutation on (d,e,f).
        S_3 acts on {a,b,c} and simultaneously on {d,e,f} via the bijection
        d <-> {a,b}, e <-> {b,c}, f <-> {a,c} (each face fix the pair).
        g is fixed by S_3 (it sees all three).
  (iii) The 4 quadrics are not symmetric in S_4, but {Q1,Q2,Q3} are S_3-permuted.

Total obvious linear group has order |S_3| * 2^7 = 6 * 128 = 768.

We additionally check whether there's any hidden GL(7) symmetry that mixes
(d,e,f,g) with (a,b,c) — there isn't one over Q because the 4 quadrics have
distinct "leading squares" structure, but we verify by computing the
linear infinitesimal stabilizer.
"""

import sympy as sp
from itertools import permutations, product

a, b, c, d, e, f, g = sp.symbols('a b c d e f g')
vars7 = [a, b, c, d, e, f, g]

Q1 = d**2 - a**2 - b**2
Q2 = e**2 - b**2 - c**2
Q3 = f**2 - a**2 - c**2
Q4 = g**2 - a**2 - b**2 - c**2

quadrics = [Q1, Q2, Q3, Q4]

print("=== §1. Quadrics defining V ⊂ P^6 ===")
for i, q in enumerate(quadrics):
    print(f"  Q{i+1} = {q}")

# (i) Sign flips: each var → ±var
# (ii) S_3 on (a,b,c) + induced action on (d,e,f)

# Build linear maps explicitly.
def apply_sub(Q, sub):
    return sp.expand(Q.subs(sub, simultaneous=True))

# Test S_3 action on (a,b,c). The induced action on (d,e,f) is:
#   d (face ab) -> face σ(a)σ(b)
#   e (face bc) -> face σ(b)σ(c)
#   f (face ac) -> face σ(a)σ(c)
# So we need a permutation of {d,e,f} that matches the permutation of the
# 2-subsets of {a,b,c}.
def two_subset(x, y):
    return frozenset([x, y])

face_map = {
    two_subset(a, b): d,
    two_subset(b, c): e,
    two_subset(a, c): f,
}

def s3_action_sub(perm):
    # perm: permutation of (a,b,c) given as tuple (pa, pb, pc)
    pa, pb, pc = perm
    sub_abc = {a: pa, b: pb, c: pc}
    # Now induced on (d,e,f):
    # d is "face ab", under perm it becomes "face pa pb"
    new_d = face_map[two_subset(pa, pb)]
    new_e = face_map[two_subset(pb, pc)]
    new_f = face_map[two_subset(pa, pc)]
    sub_def = {d: new_d, e: new_e, f: new_f}
    sub_g = {g: g}
    sub = {**sub_abc, **sub_def, **sub_g}
    return sub

# Check all 6 permutations preserve the ideal (Q1, Q2, Q3, Q4) (mod permutation of generators)
print("\n=== §2. S_3 action on (a,b,c) + induced on (d,e,f) ===")
perms = list(permutations([a, b, c]))
preserved = []
for perm in perms:
    sub = s3_action_sub(perm)
    QQ = [apply_sub(q, sub) for q in quadrics]
    # Test: each QQ[i] should be ±Q_j for some j (since these are square equations,
    # leading sign doesn't matter; check QQ[i] ∈ ±{Q1,Q2,Q3,Q4})
    ok = True
    for qq in QQ:
        match = False
        for q in quadrics:
            if sp.simplify(qq - q) == 0 or sp.simplify(qq + q) == 0:
                match = True
                break
        if not match:
            ok = False
            break
    preserved.append((perm, ok))
    name = "".join(str(x) for x in perm)
    status = "OK" if ok else "FAIL"
    print(f"  perm (a,b,c) -> ({name}): {status}")

n_s3 = sum(1 for _, ok in preserved if ok)
print(f"  S_3 preservation: {n_s3}/6")

# (Z/2)^7 sign flips. Each Q is a sum of squares, so independent sign flips of
# any variable preserve each Q. Full (Z/2)^7 stabilizes I.
print("\n=== §3. Sign-flip (Z/2)^7 action ===")
# Sample check: flip a -> -a.
sub_flip_a = {a: -a}
for i, q in enumerate(quadrics):
    qq = apply_sub(q, sub_flip_a)
    assert sp.simplify(qq - q) == 0, f"Q{i+1} not preserved under a -> -a"
print("  a -> -a preserves all 4 quadrics: OK")
print("  By symmetry (each Q is sum of squares of subset of vars),")
print("  full (Z/2)^7 sign-flip group preserves I_V.")
print(f"  |sign-flip subgroup| = 2^7 = 128")

# Center of PGL: (Z/2) from scaling all coords by -1 is absorbed.
# In PGL(7), (Z/2)^7 quotients by the diagonal scaling, giving (Z/2)^6.
print(f"  In PGL(7): quotient by diagonal => effective sign group is (Z/2)^6 of order 64")

print("\n=== §4. Total obvious Aut_lin(V) ⊂ PGL(7) ===")
print("  G_obvious = S_3 ⋉ (Z/2)^6 of order 6 * 64 = 384")
print("  (semidirect: S_3 permutes the 7 sign-flip generators consistently)")

# (iii) Test: any linear map mixing (a,b,c) with (d,e,f,g)?
# We check the infinitesimal Lie algebra: a linear vector field X = sum M_ij x_j ∂/∂x_i
# preserving the ideal must satisfy X(Q_k) ∈ I_V (degree 2) for each k.
# Since X is linear in x and Q_k is degree 2, X(Q_k) is degree 2, so must be
# a linear combination of Q_1..Q_4.
print("\n=== §5. Infinitesimal stabilizer (Lie algebra) ===")
print("  Computing the linear stabilizer of I in gl(7) ...")

# We set up a 7x7 matrix M with symbolic entries and compute the constraints.
M = sp.Matrix(7, 7, lambda i, j: sp.Symbol(f'm_{i}_{j}'))
x = sp.Matrix(vars7)
Mx = M * x

# The Lie-derivative action on Q is: L_X Q = sum_i (Mx)_i * ∂Q/∂x_i
def lie_deriv(Q):
    return sum(Mx[i] * sp.diff(Q, vars7[i]) for i in range(7))

# We require L_X Q_k = λ_k1 Q_1 + λ_k2 Q_2 + λ_k3 Q_3 + λ_k4 Q_4
# (for some scalars λ_kj which can depend on i but not on x).
# This is the condition that I is M-stable.
lambdas = sp.symbols('lam_:16')  # 4x4 matrix flattened
LamM = sp.Matrix(4, 4, lambdas)

constraints = []
for k in range(4):
    LDQ = sp.expand(lie_deriv(quadrics[k]))
    rhs = sum(LamM[k, j] * quadrics[j] for j in range(4))
    diff = sp.expand(LDQ - rhs)
    # Extract coefficients of all degree-2 monomials in (a,b,c,d,e,f,g)
    poly = sp.Poly(diff, *vars7)
    for mono, coeff in poly.terms():
        if sum(mono) == 2:  # quadratic monomial
            constraints.append(coeff)

# Linear constraints in M and λ entries.
constraint_set = set(c for c in constraints if c != 0)
print(f"  # quadratic monomial constraints: {len(constraint_set)} (deduplicated)")

# Variables to solve for: 49 (M entries) + 16 (λ entries) = 65
all_vars = list(M.free_symbols.union(LamM.free_symbols))
print(f"  Total free parameters before constraints: {len(all_vars)}")

sol = sp.solve(list(constraint_set), all_vars, dict=True)
if sol:
    sol_dict = sol[0]
    # Count free parameters remaining
    M_subst = M.subs(sol_dict)
    # Identify which entries of M remain free
    free_in_M = M_subst.free_symbols
    print(f"  Dimension of linear stabilizer (Lie alg): {len(free_in_M)}")
    print(f"  Free symbols in M: {sorted(s.name for s in free_in_M)}")
    # The diagonal (which scales each variable independently) and
    # the entries that mix variables of the same "type"
    print("\n  Substituted M:")
    sp.pprint(M_subst)
else:
    print("  No solution found (something wrong).")

print("\n=== §6. Conclusion ===")
print("  Aut_lin(V) ⊂ PGL(7) is at LEAST the order-384 group S_3 ⋉ (Z/2)^6.")
print("  The Lie algebra computation above shows whether additional continuous symmetries exist.")
print("  Expectation: the only continuous symmetries are the diagonal scalings (which are absorbed in PGL),")
print("  so Aut_lin(V) is the discrete group of order 384.")

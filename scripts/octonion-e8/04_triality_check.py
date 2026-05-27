#!/usr/bin/env python3
"""
F_4 / Triality analysis of PCP.

Triality of Spin(8) is the outer automorphism group S_3 of Spin(8)
which permutes the three 8-dimensional representations:
  - V (vector rep, sometimes called V_8)
  - S+ (positive half-spinor)
  - S- (negative half-spinor)

In the octonion picture (Cayley algebra O):
- O acts on itself by left-multiplication L_x, right-multiplication R_x.
- The three 'columns' of the SO(8) triple (L, R, bimultiplication) give triality.

PCP perspective: We have 4 quadratic forms
  q_1 = a^2 + b^2 - d^2 = 0   (face 1)
  q_2 = b^2 + c^2 - e^2 = 0   (face 2)
  q_3 = a^2 + c^2 - f^2 = 0   (face 3)
  q_4 = a^2 + b^2 + c^2 - g^2 = 0  (space diagonal)

NOTICE the identity:
  q_1 + q_2 + q_3 - 2 q_4 = -d^2 - e^2 - f^2 + 2 g^2 = 0  (from 2g^2 = d^2+e^2+f^2)

So the 4 quadrics span a 3-dim subspace in the 28-dim space of
quadratic forms on R^7 (homogeneous polynomials of degree 2).

F_4 / Triality intersection: The Triality outer auto sends
- vector rep to one of the spinor reps
- so vectors (a,b,c,d,e,f,g,0) get sent to spinor vectors.
The PCP locus q_i = 0 is INVARIANT under what?

Investigate: what is the (a,b,c) <-> (d,e,f) involution doing?
Claim: it is induced by triality on a sub-locus.

We need: a transformation T of the 7-vector (a,b,c,d,e,f,g) preserving
the 4 PCP equations. The trivial ones:
  S_3 permuting a, b, c (and simultaneously d, e, f).
  Sign flips: (a,b,c,d,e,f,g) -> (a,b,c,d,e,f,-g), etc.

Question: is there a 'half-spin' transformation?
"""

import numpy as np
from sympy import symbols, simplify, Matrix, sqrt, expand, factor, Rational, sympify, Eq, solve

a, b, c, d, e, f, g = symbols('a b c d e f g', positive=True)

# Define the 4 PCP polynomials:
q1 = a**2 + b**2 - d**2
q2 = b**2 + c**2 - e**2
q3 = a**2 + c**2 - f**2
q4 = a**2 + b**2 + c**2 - g**2

print("Verify: q1 + q2 + q3 - 2*q4 =")
result = expand(q1 + q2 + q3 - 2*q4)
print(f"  {result}")
print(f"  (should equal -(d^2+e^2+f^2) + 2g^2 = 0 on PCP locus)")

# So the 4 polynomials are linearly dependent on the locus.

# Triality / F4 symmetric structure check:
# In E_6/F_4 picture, there's a cubic form CUBE on (Im O)^3 or similar.
# For (Im O), the most natural F_4-invariant quadratic form is just the norm.

# Let's check the claim from prompt §3: "the 4-tuple (a^2, b^2, c^2, g^2) sit on a Triality-invariant variety"
# By PCP: g^2 = a^2 + b^2 + c^2.
# So (a^2, b^2, c^2, g^2) lies on the affine cone over a 'tetrahedron' or projective P^2.
# Triality on Spin(8) acts on TRIPLES of 8-dim spaces; on 4-tuples not directly.

# But F_4 ACTS ON THE EXCEPTIONAL JORDAN ALGEBRA J_3(O) - 27-dim of Hermitian octonion 3x3 matrices.
# Element of J_3(O):
#   [α₁   x₁    x₂]
#   [x̄₁   α₂    x₃]   with α_i ∈ R, x_i ∈ O
#   [x̄₂   x̄₃    α₃]

# Hmm — can we encode PCP in J_3(O)?

# Try: take x_1, x_2, x_3 ∈ O with specific structure related to PCP.
# Let x_1 = a * e_1 (so |x_1|^2 = a^2 in O).
# x_2 = b * e_2, x_3 = c * e_3.
# Then det(M) = α_1 α_2 α_3 + 2 Re(x_1 (x_2 x_3)) - α_1 |x_3|^2 - α_2 |x_2|^2 - α_3 |x_1|^2

# But e_1 (e_2 e_3) — in the standard Cayley table, e_2 e_3 = e_1 (or ±e_1 depending on convention).
# So Re(e_1 * (±e_1)) = ±1. Times a*b*c gives ±abc.

# So det(M) with x_i = (a*e_1, b*e_2, c*e_3) and α_i = chosen properly:
# det = α_1 α_2 α_3 + 2 abc * eps - α_1 c^2 - α_2 b^2 - α_3 a^2
# where eps = ±1.

# Setting α_1 = α_2 = α_3 = g (the space diagonal):
# det = g^3 + 2 eps abc - g (a^2 + b^2 + c^2) = g^3 + 2 eps abc - g^3 = 2 eps abc.
# So det(M_PCP) = ±2abc.

# But the discriminant of M (also F_4-invariant) involves...
# Let's compute the F_4 invariants tr, tr_2, det for this matrix.

# Easier: define J_3(O) computation symbolically.
# F_4 fixes tr(M), tr(M^2), det(M).

# tr(M) = α_1 + α_2 + α_3 = 3g
# tr(M^2) = sum α_i^2 + 2 sum |x_i|^2 = 3g^2 + 2(a^2+b^2+c^2) = 3g^2 + 2g^2 = 5g^2
# det(M) = 2 eps abc (as computed).

# Hmm — interesting that tr(M^2) = 5g^2 and det = ±2abc.
# These are NOT free invariants: PCP imposes 4 constraints among 7 vars.
# But J_3(O) embedding uses 6 vars (a, b, c, α_1, α_2, α_3) — we set α_i = g.

# Wait — F_4 stabilizes ELEMENTS of J_3(O), not the structure of having
# this particular form. Different x_i give different orbits.

# What's the orbit structure under F_4?
# F_4 acts on J_3(O) with 'rank' invariant: rank-1 elements form a 16-dim
# orbit (the Cayley plane, OP^2), rank-2 a 16-dim, rank-3 a generic 26-dim.

# Rank of M:
# rank 1 ⟺ M^2 = tr(M) * M (i.e. trace * M)
# rank ≤ 2 ⟺ det(M) = 0
# rank 3 ⟺ det(M) ≠ 0

# For PCP: det = ±2abc ≠ 0 (since a, b, c > 0), so M has rank 3.

# F_4 invariants on rank-3 elements: tr and tr_2, det (free invariants).
# tr = 3g, tr_2 = (tr(M)^2 - tr(M^2))/2 = (9g^2 - 5g^2)/2 = 2g^2
# det = ±2abc

# So under F_4, the equivalence class of M_PCP is determined by (3g, 2g^2, ±2abc).
# This means F_4 acts TRANSITIVELY on M with these specific invariants up to sign.

# But this doesn't help PCP closure: F_4 just tells us the orbit, not that
# PCP solutions DON'T exist.

# UNLESS — we can find a SECOND embedding of PCP variables into J_3(O)
# that gives DIFFERENT F_4 invariants for the same brick, leading to a contradiction.

# Let me try x_1 = a*e_1 + d*e_4, etc.
# Hmm, this would require choosing 7 octonions for the brick.

# Actually, the natural multi-variable embedding is:
# M = [g, a*e_1+b*e_2, c*e_3+d*e_4; ...; ...]
# But this picks arbitrary choices and isn't canonical.

# Let me think about this differently:

# Heron-like F_4 invariant:
# For a triangle with sides p, q, r and area S, Heron: 16 S^2 = (p+q+r)(-p+q+r)(p-q+r)(p+q-r)
# Brick analog: a, b, c sides; d, e, f face diagonals; g space diagonal.
# Volume = abc.
# Surface area = 2(ab + bc + ca).
# Sum of edges = 4(a+b+c).
# These are independent invariants under (a,b,c) permutation.

# Now F_4 invariants of (a, b, c, g) tuple (as J_3 trace/det data):
# - tr = 3g (forced by space diagonal)
# - det / 2 = abc (the volume!)

# So 'volume' = det/2 is an F_4 invariant in this embedding.
# This is a real but ALGEBRAIC observation: PCP imposes a relationship between
# the F_4 invariants of two different J_3 embeddings... but it doesn't give an obstruction.

# Let me CHECK numerically with a non-PCP Euler brick:
print("\n=== F_4 invariants for known Euler bricks ===")
euler_bricks = [
    (44, 117, 240),   # Halcke
    (85, 132, 720),
    (140, 480, 693),
    (160, 231, 792),
    (88, 234, 480),  # double Halcke (non-primitive)
]
for (av, bv, cv) in euler_bricks:
    gv2 = av**2 + bv**2 + cv**2
    gv = np.sqrt(gv2)
    tr_M = 3 * gv
    tr_M2 = 5 * gv2
    tr_2 = 2 * gv2  # = (tr_M^2 - tr_M2)/2
    det_M = 2 * av * bv * cv
    # For PCP we'd need gv integer.
    print(f"  (a,b,c)=({av},{bv},{cv}), g^2={gv2}, g={gv:.4f}")
    print(f"     tr={tr_M:.4f}, tr_2={tr_2}, det={det_M}")
    print(f"     det/g^3 = {det_M / gv**3 :.6f}, det/tr_2^(3/2) = {det_M / tr_2**1.5 :.6f}")

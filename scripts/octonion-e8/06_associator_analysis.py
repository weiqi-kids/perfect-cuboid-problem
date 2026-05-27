#!/usr/bin/env python3
"""
Associator analysis: the deepest octonion-specific structure.

The associator [x, y, z] = (xy)z - x(yz) measures NON-associativity.
Octonion alternative law: [x, y, z] is ALTERNATING in (x, y, z), so
the associator vanishes when any two arguments are equal.

For our PCP octonion x = sum_i x_i e_i (purely imaginary), we explore:
1. [x, e_i, e_j] for i ≠ j: a purely imaginary octonion. Compute N([x, e_i, e_j]).
2. Special combinations that the W1 file claims have specific norms.

Claim from W1: N([o, e_1, e_2]) = 12 g^2.
Claim: N([o, e_4, e_7]) = 8 g^2.

Let's VERIFY these computationally.
"""

import numpy as np

def conj_quat(q):
    return (q[0], -q[1], -q[2], -q[3])

def mul_quat(p, q):
    (a, b, c, d) = p
    (e, f, g, h) = q
    return (
        a*e - b*f - c*g - d*h,
        a*f + b*e + c*h - d*g,
        a*g - b*h + c*e + d*f,
        a*h + b*g - c*f + d*e,
    )

def mul_oct(p, q):
    a = p[:4]; b = p[4:]
    c = q[:4]; d = q[4:]
    a_c = mul_quat(a, c)
    d_bar = conj_quat(d)
    db_b = mul_quat(d_bar, b)
    b_c_bar = mul_quat(b, conj_quat(c))
    d_a = mul_quat(d, a)
    real_part = tuple(a_c[i] - db_b[i] for i in range(4))
    imag_part = tuple(b_c_bar[i] + d_a[i] for i in range(4))
    return real_part + imag_part

def conj_oct(p):
    return (p[0], -p[1], -p[2], -p[3], -p[4], -p[5], -p[6], -p[7])

def norm_oct(p):
    p_bar = conj_oct(p)
    r = mul_oct(p, p_bar)
    return r[0]

def sub(p, q):
    return tuple(p[i] - q[i] for i in range(8))

def add(p, q):
    return tuple(p[i] + q[i] for i in range(8))

def scale(p, s):
    return tuple(p[i]*s for i in range(8))

def associator(p, q, r):
    """[p, q, r] = (pq)r - p(qr)"""
    pq = mul_oct(p, q)
    qr = mul_oct(q, r)
    pq_r = mul_oct(pq, r)
    p_qr = mul_oct(p, qr)
    return sub(pq_r, p_qr)

# Build PCP octonion symbolically using sympy for exactness:
from sympy import symbols, expand, simplify, factor, Rational, sympify

# We use the multiplication implementation but with symbolic entries.
def mul_quat_sym(p, q):
    (a, b, c, d) = p; (e, f, g, h) = q
    return (
        expand(a*e - b*f - c*g - d*h),
        expand(a*f + b*e + c*h - d*g),
        expand(a*g - b*h + c*e + d*f),
        expand(a*h + b*g - c*f + d*e),
    )

def conj_quat_sym(q):
    return (q[0], -q[1], -q[2], -q[3])

def mul_oct_sym(p, q):
    a = p[:4]; b = p[4:]
    c = q[:4]; d = q[4:]
    a_c = mul_quat_sym(a, c)
    d_bar = conj_quat_sym(d)
    db_b = mul_quat_sym(d_bar, b)
    b_c_bar = mul_quat_sym(b, conj_quat_sym(c))
    d_a = mul_quat_sym(d, a)
    return tuple(expand(a_c[i] - db_b[i]) for i in range(4)) + tuple(expand(b_c_bar[i] + d_a[i]) for i in range(4))

def conj_oct_sym(p):
    return (p[0], -p[1], -p[2], -p[3], -p[4], -p[5], -p[6], -p[7])

def sub_sym(p, q):
    return tuple(expand(p[i] - q[i]) for i in range(8))

def associator_sym(p, q, r):
    pq = mul_oct_sym(p, q)
    qr = mul_oct_sym(q, r)
    pq_r = mul_oct_sym(pq, r)
    p_qr = mul_oct_sym(p, qr)
    return sub_sym(pq_r, p_qr)

def norm_oct_sym(p):
    return sum(expand(p[i]**2) for i in range(8))

# Symbolic PCP octonion
sa, sb, sc, sd, se, sf, sg = symbols('a b c d e f g', positive=True)
x = (0, sa, sb, sc, sd, se, sf, sg)

# Standard basis vectors
def e_sym(i):
    v = [0]*8
    v[i] = 1
    return tuple(v)

# Compute associator and its norm for various (e_i, e_j) pairs
print("Associator [x, e_i, e_j] norm analysis (symbolic, PCP constraint applied)")
print("=" * 70)

# Apply PCP constraints in substitution:
constraint_subs = {
    sd**2: sa**2 + sb**2,
    se**2: sb**2 + sc**2,
    sf**2: sa**2 + sc**2,
    sg**2: sa**2 + sb**2 + sc**2,
}

results = {}
for i in range(1, 8):
    for j in range(i+1, 8):
        assoc = associator_sym(x, e_sym(i), e_sym(j))
        # Compute norm
        n_assoc = sum(expand(assoc[k]**2) for k in range(8))
        n_assoc_red = expand(n_assoc.subs(constraint_subs))
        results[(i, j)] = n_assoc_red
        # Print only those that simplify nicely:
        # Try to express as a multiple of g^2 = a^2+b^2+c^2
        factor_g2 = expand(n_assoc_red / (sa**2 + sb**2 + sc**2))
        try:
            factor_g2_simplified = simplify(factor_g2)
        except Exception:
            factor_g2_simplified = factor_g2
        print(f"[x, e_{i}, e_{j}]: N = {n_assoc_red}")
        print(f"     /g^2 = {factor_g2_simplified}")

print("\n" + "=" * 70)
print("SUMMARY: associator norms under PCP constraints")
print("=" * 70)

# Group results by norm pattern
from collections import defaultdict
by_form = defaultdict(list)
for (i, j), val in results.items():
    by_form[str(val)].append((i, j))

for form, pairs in sorted(by_form.items()):
    print(f"\n  N = {form}")
    print(f"     pairs: {pairs}")

# CHECK W1 claims:
print("\n\n--- Checking W1 claims ---")
print(f"N([x, e_1, e_2]) = {results[(1,2)]}")
print(f"  W1 claims = 12 g^2 = 12(a^2+b^2+c^2) = {12*(sa**2 + sb**2 + sc**2)}")
print(f"  Match: {expand(results[(1,2)] - 12*(sa**2+sb**2+sc**2)) == 0}")

print(f"\nN([x, e_4, e_7]) = {results[(4,7)]}")
print(f"  W1 claims = 8 g^2 = 8(a^2+b^2+c^2) = {8*(sa**2 + sb**2 + sc**2)}")
print(f"  Match: {expand(results[(4,7)] - 8*(sa**2+sb**2+sc**2)) == 0}")

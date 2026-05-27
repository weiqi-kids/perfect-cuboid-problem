#!/usr/bin/env python3
"""
Mod-2 coset analysis of the PCP vector in E_8.

E_8 / 2E_8 ≅ (F_2)^8.  The PCP vector x_PCP = (0,a,b,c,d,e,f,g) ∈ E_8.
Its mod-2 reduction has parity pattern (0, a, b, c, d, e, f, g) mod 2.

Two-even-one-odd (e.g., a, b even, c odd):
  d = sqrt(a^2+b^2) (4|d^2, so 2|d), d even.
  e = sqrt(b^2+c^2) (even+odd=odd), e odd.
  f = sqrt(a^2+c^2) (even+odd=odd), f odd.
  g^2 = a^2+b^2+c^2 (even+even+odd=odd), so g odd.

Parity pattern (0, 0, 0, 1, 0, 1, 1, 1).
Sum mod 2 = 0+0+0+1+0+1+1+1 = 4 = 0 mod 2.  So in D_8 ⊂ E_8.

If a,c even, b odd: pattern (0, 0, 1, 0, ?, ?, ?, ?).
  d^2 = a^2+b^2 = even^2+odd^2 = odd. d odd.
  e^2 = b^2+c^2 = odd^2+even^2 = odd. e odd.
  f^2 = a^2+c^2 = even+even = even (4|f^2), f even.
  g^2 = odd. g odd.
  pattern (0, 0, 1, 0, 1, 1, 0, 1). sum mod 2 = 4 = 0. In D_8.

If b,c even, a odd: pattern (0, 1, 0, 0, ?, ?, ?, ?).
  d^2 = a^2+b^2 = odd. d odd.
  e^2 = b^2+c^2 = even. e even.
  f^2 = a^2+c^2 = odd. f odd.
  g^2 = odd. g odd.
  pattern (0, 1, 0, 0, 1, 0, 1, 1). sum mod 2 = 4 = 0. In D_8.

So in all 3 parity cases, PCP vector lies in D_8 ⊂ E_8.
The 3 patterns are SYMMETRIC under S_3 permutation of (a,b,c).

Now: is the PCP vector EXTRA constrained mod 4? Let's check.
"""

# Search for primitive PCP candidates with small structure.
# Recall: PCP doesn't exist for edges < 10^12 by computational search.
# But Euler bricks (without space diagonal integer) exist.
# Let's check: for a CHEMICAL Euler brick (a,b,c,d,e,f) with d,e,f integer,
# what is the parity pattern of (a,b,c,d,e,f,g) where g = sqrt(a^2+b^2+c^2)?

import math
from collections import Counter

def find_primitive_euler_bricks(max_a):
    """Find primitive Euler bricks with a < b < c <= max_a."""
    bricks = []
    for a in range(1, max_a + 1):
        for b in range(a + 1, max_a + 1):
            d2 = a*a + b*b
            d = int(math.isqrt(d2))
            if d*d != d2:
                continue
            for c in range(b + 1, max_a + 1):
                e2 = b*b + c*c
                e = int(math.isqrt(e2))
                if e*e != e2:
                    continue
                f2 = a*a + c*c
                f = int(math.isqrt(f2))
                if f*f != f2:
                    continue
                if math.gcd(math.gcd(a, b), c) != 1:
                    continue
                bricks.append((a, b, c, d, e, f))
    return bricks

print("Searching primitive Euler bricks with all sides ≤ 1000...")
bricks = find_primitive_euler_bricks(1000)
print(f"Found {len(bricks)} primitive Euler bricks.")

# Parity pattern analysis for each:
patterns = Counter()
for (a, b, c, d, e, f) in bricks:
    g2 = a*a + b*b + c*c
    # parity pattern of (a, b, c, d, e, f, g^2 mod 4)
    pat = (a%2, b%2, c%2, d%2, e%2, f%2, g2 % 4, g2 % 8)
    patterns[pat] += 1

print("\nParity / mod-4 / mod-8 patterns of (a,b,c,d,e,f,g^2):")
for pat, count in patterns.most_common():
    print(f"  {pat}: {count} bricks")

# Mod 8 of g^2 is critical: if PCP, g is integer, g^2 mod 8.
# For odd g: g^2 ≡ 1 mod 8. For even g: g^2 ≡ 0 or 4 mod 8.
# Primitive PCP: parity pattern says g odd, so g^2 ≡ 1 mod 8.

# Check this for primitive Euler bricks:
g2_mod8_count = Counter()
for (a, b, c, d, e, f) in bricks:
    g2 = a*a + b*b + c*c
    g2_mod8_count[g2 % 8] += 1
print("\ng^2 mod 8 distribution among primitive Euler bricks:")
for k, v in g2_mod8_count.most_common():
    print(f"  g^2 ≡ {k} (mod 8): {v}")

# Now: an PCP solution must have g^2 a perfect square.
# Perfect squares mod 8 are 0, 1, 4.  But primitive => odd g, so 1.
# So PCP must have g^2 ≡ 1 (mod 8).  This is just the standard
# 'odd g' parity, nothing new.

# Stronger: PCP requires g^2 = sum_of_3_squares of a particular form.
# The (a,b,c) must have one odd, two even.

# Let's check: is there any 'mod something' obstruction at higher level
# that's encoded in the E_8 / nE_8 quotient?

# E_8 / 2E_8 ≅ (F_2)^8 with quadratic form (norm/2 mod 2).
# Our PCP vector has norm 4g^2. In mod-2 coords:
# - For 'two even, one odd' parity, primitive (a,b,c,d,e,f) = (even,even,odd,even,odd,odd)
#   and g is odd.
# - vector mod 2 = (0, 0, 0, 1, 0, 1, 1, 1) (7 nonzero components: positions 3, 5, 6, 7)
# - Wait, in (x_0, x_1, ..., x_7) = (0, a, b, c, d, e, f, g):
#   x_0=0, x_1=a, x_2=b, x_3=c, x_4=d, x_5=e, x_6=f, x_7=g.
#   mod 2: (0, 0, 0, 1, 0, 1, 1, 1). 4 ones. weight 4.

# In F_2^8 ≅ E_8/2E_8, weight 4 vectors with sum 0 are in D_8/2D_8.
# These weight-4 patterns are E_8 weight-4 cosets.

# In E_8/2E_8 (with norm form N/2 mod 2):
# N(v)/2 mod 2 for v = (0,0,0,1,0,1,1,1) is (0+0+0+1+0+1+1+1)/2 = 4/2 = 2 = 0 mod 2.
# So PCP vector lies in the 'null' coset (norm 0 in E_8/2E_8).

# The 'null' coset of E_8/2E_8 has cardinality 120 (number of weight-2 vectors in mod-2 / quadratic vanishing).
# Wait, let me recompute. F_2^8 has 256 vectors. The quadratic form on E_8/2E_8 ≅ F_2^8
# distinguishes the 135 'isotropic' from 120 'non-isotropic' nonzero vectors plus 1 zero vector.
# 135 + 120 + 1 = 256.
# Actually for the E_8 lattice the form is split orthogonal of plus type:
# Number of nonzero isotropic = 2^7 - 2^3 - 1 + 2^3 = 135 (let me verify).

# Just verify: of the 240 root vectors of E_8 (norm 2), they map to E_8/2E_8 in pairs (v, -v).
# So 120 distinct cosets in E_8/2E_8 correspond to root pairs. These are the
# 'norm-2 mod 4' cosets, which under N/2 mod 2 give norm-1 mod 2 ≠ 0.
# So those 120 cosets are 'non-isotropic'.
# The remaining 256 - 1 - 120 = 135 nonzero cosets are isotropic.

# PCP vector lies in an isotropic coset (since 4g^2 / 2 = 2g^2 is even).
# Among 135 isotropic cosets, which one(s) does PCP live in?

print("\n--- Mod-2 cosets of PCP for found Euler bricks ---")
mod2_cosets = Counter()
for (a, b, c, d, e, f) in bricks:
    g2 = a*a + b*b + c*c
    # parity tuple as vector mod 2:
    # (0, a, b, c, d, e, f, g_parity)
    g_parity = 1 if g2 % 2 == 1 else 0
    pat = (0, a%2, b%2, c%2, d%2, e%2, f%2, g_parity)
    mod2_cosets[pat] += 1
print("Number of distinct mod-2 cosets seen:", len(mod2_cosets))
for pat, count in mod2_cosets.most_common(10):
    weight = sum(pat)
    norm_over_2_mod_2 = weight % 2
    print(f"  {pat} (weight {weight}, N/2 mod 2 = {norm_over_2_mod_2}): {count}")

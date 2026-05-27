#!/usr/bin/env python3
"""
Verify the basic 8-dimensional identities for the PCP / Euler brick lift.

Setup: PCP variables (a, b, c, d, e, f, g) satisfy
   d^2 = a^2 + b^2
   e^2 = b^2 + c^2
   f^2 = a^2 + c^2
   g^2 = a^2 + b^2 + c^2
   2g^2 = d^2 + e^2 + f^2.

Octonion lift: x = a*e1 + b*e2 + c*e3 + d*e4 + e*e5 + f*e6 + g*e7
              (purely imaginary, 7 components).

Quaternion / Hamilton norm formula:
   N(x) = a^2+b^2+c^2+d^2+e^2+f^2+g^2
        = g^2 + d^2 + e^2 + f^2 + g^2
        = g^2 + (a^2+b^2) + (b^2+c^2) + (a^2+c^2) + g^2
        = 2g^2 + 2(a^2+b^2+c^2)
        = 2g^2 + 2g^2 = 4g^2.

So N(x) = 4g^2 = (2g)^2. This says x lies on a sphere of radius 2g
in the 7-dimensional space of imaginary octonions.

For a perfect cuboid (g, h with g^2 + h^2 = square space-diag), we'd add an 8th coord.

Check numerically on several known Euler bricks.
"""

# Known Euler bricks (a,b,c,d,e,f) - the "near miss" Saunderson family:
euler_bricks = [
    (44, 117, 240, 125, 267, 244),   # Halcke's brick (1719)
    (240, 117, 44, 267, 125, 244),   # permutation
    (85, 132, 720, 157, 732, 725),   # another famous one
    (140, 480, 693, 500, 843, 707),
    (160, 231, 792, 281, 825, 808),
]

for (a, b, c, d, e, f) in euler_bricks:
    # Sanity check on face diagonals
    assert d**2 == a**2 + b**2, f"d failed for {a},{b},{c}"
    assert e**2 == b**2 + c**2, f"e failed for {a},{b},{c}"
    assert f**2 == a**2 + c**2, f"f failed for {a},{b},{c}"
    space2 = a**2 + b**2 + c**2
    # space diagonal squared
    import math
    g_real = math.sqrt(space2)
    # PCP would require g_real integer
    g_int = int(g_real)
    is_perfect = (g_int * g_int == space2)
    # The octonion norm computation: use g_real^2 = space2
    # N(x) = a^2+b^2+c^2 + d^2+e^2+f^2 + space2
    # We have d^2+e^2+f^2 = 2*space2 (the famous identity)
    sum_face_sq = d**2 + e**2 + f**2
    assert sum_face_sq == 2 * space2, "2g^2 = d^2+e^2+f^2 failed"
    # So N(x) excluding g term:
    N_no_g = (a**2 + b**2 + c**2) + (d**2 + e**2 + f**2)
    # = space2 + 2*space2 = 3*space2
    assert N_no_g == 3 * space2

    # Including g^2 (if we set g_8 = sqrt(space2), real):
    N_with_g = N_no_g + space2
    assert N_with_g == 4 * space2

    print(f"Brick (a,b,c)=({a},{b},{c}): space^2={space2}, "
          f"PCP={is_perfect}, N(x w/g)={N_with_g}=4*{space2}")

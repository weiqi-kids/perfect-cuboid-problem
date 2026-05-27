#!/usr/bin/env python3
# 05_recovery_degeneracy.py
# SYMBOLIC proof over Q(q) of the degeneracy theorem:
# the recovery map phi(X,Y) = 2 Y q / (q^2 - X^2) sends every one of the 8 rational
# torsion points of E_PCP(q) (q a Pythagorean rational, q != 0,+-1) to {0, infinity}.
#
# The 8 torsion points (Z/4 x Z/2), explicit over Q(q):
#   O (identity at infinity),
#   2-torsion:  (0,0), (-1,0), (-q^2,0),
#   order-4:    (q,  q(q+1)), (q, -q(q+1)), (-q, q(q-1)), (-q, -q(q-1)).

import sympy as sp
q, Y = sp.symbols('q Y')

print("=== Symbolic degeneracy of phi on the 8 torsion points (over Q(q)) ===\n")

def phi(X, Yv):
    den = q**2 - X**2
    if den == 0:
        return ("POLE", sp.simplify(2*Yv*q))   # numerator must be nonzero
    return ("FINITE", sp.simplify(2*Yv*q/den))

pts = {
    "(0,0)":        (sp.Integer(0),  sp.Integer(0)),
    "(-1,0)":       (sp.Integer(-1), sp.Integer(0)),
    "(-q^2,0)":     (-q**2,          sp.Integer(0)),
    "(q,q(q+1))":   (q,   q*(q+1)),
    "(q,-q(q+1))":  (q,  -q*(q+1)),
    "(-q,q(q-1))":  (-q,  q*(q-1)),
    "(-q,-q(q-1))": (-q, -q*(q-1)),
}

# verify each point is on E_PCP(q): Y^2 = X(X+1)(X+q^2)
print("Point-on-curve checks (residual should be 0):")
allon = True
for name,(X,Yv) in pts.items():
    res = sp.simplify(Yv**2 - X*(X+1)*(X+q**2))
    allon = allon and (res == 0)
    print("  %-14s on curve residual = %s" % (name, res))
print()

print("phi values:")
deg_ok = True
# identity: degenerate (c=0 branch) by convention/closure; report explicitly
print("  O (identity)   -> c = 0  (degenerate identity / c=0 branch)")
for name,(X,Yv) in pts.items():
    kind, val = phi(X, Yv)
    if kind == "FINITE":
        # must be 0 for degeneracy
        is_deg = (sp.simplify(val) == 0)
        print("  %-14s -> c = %s   %s" % (name, val, "(=0, degenerate)" if is_deg else "(NONZERO!)"))
        deg_ok = deg_ok and is_deg
    else:
        numerator = val
        nonzero = sp.simplify(numerator) != 0   # numerator 2Yq nonzero for q!=0,+-1
        print("  %-14s -> POLE (num 2Yq = %s, nonzero for q!=0,+-1: %s)" % (name, numerator, nonzero))
        deg_ok = deg_ok and nonzero

print()
print("All 8 torsion points map to {0, infinity}:", allon and deg_ok)
print("\nRESULT:", "PASS" if (allon and deg_ok) else "FAIL")

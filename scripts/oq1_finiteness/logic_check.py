#!/usr/bin/env python3
"""
Logical sanity check: can a height LOWER bound (OQ1) defeat the Pila-Wilkie
T^eps upper bound to yield finiteness, in the ABSENCE of a Galois orbit?

This is NOT a numerical experiment on PCP fibers (those are done elsewhere:
scripts/pila_oq2/). It is a symbolic accounting of the inequality directions,
to confirm/refute the OQ1-HS-RESOLUTION.md §5 finiteness claim.

The Pila-Zannier finiteness engine (Pila-Zannier 2008; Habegger-Pila 2016):
    #{special pts of height <= T on Z^trans} <= C_eps * T^eps          (UPPER, PW)
    #{conjugates of one special pt} >= c * T^delta                     (LOWER, Galois)
  =>  c T^delta <= C_eps T^eps, choose eps<delta  =>  T bounded => FINITE.

KEY: the LOWER bound that defeats PW is a lower bound on the NUMBER of points
(Galois conjugates), NOT a lower bound on the height of one point.
"""

print("="*72)
print("DIRECTION-OF-INEQUALITY ACCOUNTING FOR OQ1 ==> FINITENESS")
print("="*72)

# ---- The PCP datum ----
print("""
PCP candidate datum: (q, P) with
  q in Q Pythagorean (rank-jump locus R), so DEGREE [Q(q):Q] = 1
  P in E_PCP(q)(Q) non-torsion,            so DEGREE [Q(P):Q] = 1
  F3(q,P) = 1+q^2+c(P)^2 a rational square.
Maps to a SINGLE rational point y(q,P) in Y^trans of naive height H.
""")

# ---- What Pila-Wilkie needs to be defeated ----
print("PILA-WILKIE (upper):  N_trans(T) := #{rat pts of Y^trans, H<=T} <= C_eps T^eps")
print("To FORCE FINITENESS one needs a LOWER bound on a COUNT that grows >= T^delta,")
print("delta>0, so that for eps<delta the only way to satisfy both is T bounded.\n")

# ---- What OQ1 supplies ----
print("OQ1 supplies:  hat h(P) >= c1 * log H_j(q) - c2   (a HEIGHT LOWER bound on ONE point)")
print("This is NOT a lower bound on the NUMBER of points. It bounds the height of P")
print("from BELOW in terms of the parameter height of q.\n")

# ---- The Galois orbit that PZ uses does not exist here ----
print("Galois-orbit count available for a Q-RATIONAL point:")
deg = 1
num_conjugates = deg  # only itself
print(f"  [Q(P):Q] = {deg}  =>  # Galois conjugates = {num_conjugates}  =>  T^delta = T^0 = 1.")
print("  ==> NO large Galois orbit. The PZ T^delta engine yields delta = 0. NO finiteness.\n")

# ---- Does OQ1's lower bound substitute? Trace the claimed implication ----
print("-"*72)
print("Trace OQ1-HS-RESOLUTION.md §5 claim verbatim:")
print('  "the height lower bound forces sporadic generators to have H_j bounded')
print('   by a polynomial in their canonical height, yielding finiteness."')
print("-"*72)
print("""
Read literally, OQ1 gives:   log H_j(q) <= (hat h(P) + c2)/c1.            (*)
For (*) to bound H_j(q) (hence #q), one needs an UPPER bound on hat h(P).
But hat h(P) of a sporadic Mordell-Weil generator is UNBOUNDED across the
family (it GROWS like log H_j by OQ1's own empirical slope c1~0.05).
So (*) reads:  log H_j(q) <= (c1 log H_j(q) + ...)/c1 = log H_j(q) + ...,
a TAUTOLOGY. It bounds nothing. There is no independent upper bound on
hat h(P) to feed into (*).

The ONLY way to get such an upper bound on hat h is the Pila-Wilkie window
itself -- but PW gives a COUNT bound, not a per-point height upper bound,
and converting a count bound to finiteness is exactly what needs the
Galois-orbit lower bound (absent here).
""")

print("="*72)
print("CONCLUSION (logical):")
print("  - PZ finiteness = PW-upper DEFEATED BY Galois-orbit-LOWER (count of conjugates).")
print("  - PCP points are Q-rational: Galois orbit size = 1, T^delta = T^0 = 1.")
print("  - OQ1 is a HEIGHT-LOWER bound on ONE point, the WRONG TYPE of input;")
print("    it is neither a count lower bound nor a height UPPER bound.")
print("  - The OQ1-HS §5 'yielding finiteness' step is a NON-SEQUITUR (tautology).")
print("  ==> OQ1 does NOT supply the T^delta. Implication is GAPPED at the count.")
print("="*72)

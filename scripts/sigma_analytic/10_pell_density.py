#!/usr/bin/env python3
"""
Step 4 (Pell density / sparsity exponent).

The quadratic-form-square locus F6 = (m+n)^2 - 2 n^2 = k^2 is the set of
integer points on the affine Pell conic. We bound its density in the
(m,n)-box [1,H]^2.

THEORY (binary-quadratic-form powerful/square values):
  A primitive binary quadratic form Q(x,y) of nonzero discriminant takes a
  PERFECT SQUARE value Q(x,y)=k^2 on a set of (x,y) with |x|,|y|<=H of
  cardinality O(H * (log H)^{O(1)}) -- the locus is a finite union of
  Pell-conic orbits (X^2 - 2n^2 = k^2 is a CONIC in P^2, genus 0, with a
  1-parameter rational parametrization), so the integer points up to height H
  number O(H) (parametrized by (s,t) with s^2+2t^2 <~ H, i.e. O(H) lattice
  points in a disk of radius ~sqrt H -> O(H) points actually O(sqrt(H)^2)=O(H)).

  More precisely: the param (m,n)=(s^2-2st+2t^2, 2st) has m ~ |s,t|^2, so
  m<=H <=> s^2+2t^2 <~ H <=> (s,t) in a region of area ~H/sqrt2 -> ~c*H
  primitive points. Hence #{(m,n): m<=H, F6=square} = Theta(H).  Density H/H^2
  = 1/H -> 0.  SPARSE with exponent exactly 1.

  The NEAR-SQUARE locus F6 = k^2 * d (d squarefree, d<=D bounded) is a FINITE
  union (over d<=D) of such conics, each contributing Theta(H), total O(D*H)=O(H)
  for bounded D.  The full sigma>sigma0 set requires the powerful part to exceed
  a threshold growing with sigma0; for fixed sigma0 it is covered by finitely
  many such conics => O(H^{1+eps}).

We CONFIRM the Theta(H) count empirically below: count F6=exact square fibers
and F6=near-square (powerful part >= |F6|^{2/3}) up to H, fit exponent.
"""
import math
from sympy import factorint, gcd, integer_nthroot

def powerful_part(K):
    K = abs(K)
    if K == 0:
        return 0
    r = 1
    for p, e in factorint(K).items():
        if e >= 2:
            r *= p**e
    return r

def is_square(K):
    K = abs(K)
    s, ex = integer_nthroot(K, 2)
    return ex

Hs = [200, 400, 800, 1600, 3000]
print("=== Count of quadratic-form-SQUARE and NEAR-SQUARE fibers vs H ===")
print("H      #F6=square  #F5=square  #(F5 or F6 sq)  #(near-square pw>=|F|^{2/3})")
prev = None
rows = []
for H in Hs:
    c6 = c5 = ceither = cnear = 0
    for m in range(2, H+1):
        for n in range(1, m):
            if (m + n) % 2 == 1 and math.gcd(m, n) == 1:
                F5 = m*m - 2*m*n - n*n
                F6 = m*m + 2*m*n - n*n
                s5 = is_square(F5); s6 = is_square(F6)
                if s6: c6 += 1
                if s5: c5 += 1
                if s5 or s6: ceither += 1
                # near-square: powerful part exceeds |F|^{2/3}
                if powerful_part(F5) >= abs(F5)**(2/3) or powerful_part(F6) >= abs(F6)**(2/3):
                    cnear += 1
    rows.append((H, c6, c5, ceither, cnear))
    print(f"{H:<6} {c6:<11} {c5:<11} {ceither:<15} {cnear}")

print()
print("=== Local log-log slope (exponent theta) ===")
print("between H_i:   theta(F6=sq)   theta(F5orF6 sq)   theta(near-sq)")
for i in range(1, len(rows)):
    H0, c60, _, ce0, cn0 = rows[i-1]
    H1, c61, _, ce1, cn1 = rows[i]
    dl = math.log(H1) - math.log(H0)
    t6 = (math.log(c61) - math.log(c60)) / dl if c60 > 0 and c61 > 0 else float('nan')
    te = (math.log(ce1) - math.log(ce0)) / dl if ce0 > 0 and ce1 > 0 else float('nan')
    tn = (math.log(cn1) - math.log(cn0)) / dl if cn0 > 0 and cn1 > 0 else float('nan')
    print(f"[{H0},{H1}]:   {t6:.4f}          {te:.4f}            {tn:.4f}")

print()
print("Prediction: theta -> 1 for the exact-square Pell locus (genus-0 conic, O(H) points).")
print("Total primitive fibers ~ (3/pi^2) H^2; so square-locus density ~ c/H -> 0 (sparse, exponent 1).")

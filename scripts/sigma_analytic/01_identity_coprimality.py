#!/usr/bin/env python3
"""
Step 1. Verify Identity 1 symbolically and compute the pairwise coprimality
structure of the SIX forms appearing in the factorization of ab(a^2-b^2).

a = m^2 - n^2,  b = 2mn   (Pythagorean leg parametrization, gcd(m,n)=1, m+n odd)

Identity 1 (to verify):
  ab(a^2-b^2) = 2mn * (m-n)(m+n) * (m^2-2mn-n^2)(m^2+2mn-n^2)

The six forms:
  F1 = m
  F2 = n
  F3 = m - n
  F4 = m + n
  F5 = m^2 - 2mn - n^2
  F6 = m^2 + 2mn - n^2
"""
import sympy as sp

m, n = sp.symbols('m n', integer=True)

a = m**2 - n**2
b = 2*m*n

lhs = sp.expand(a*b*(a**2 - b**2))

F1 = m
F2 = n
F3 = m - n
F4 = m + n
F5 = m**2 - 2*m*n - n**2
F6 = m**2 + 2*m*n - n**2

rhs = sp.expand(2*F1*F2 * F3*F4 * F5*F6)

print("=== Identity 1 ===")
print("LHS = ab(a^2-b^2)      =", lhs)
print("RHS = 2mn(m-n)(m+n)(m^2-2mn-n^2)(m^2+2mn-n^2) =", rhs)
print("LHS - RHS =", sp.expand(lhs - rhs))
print("Identity 1 HOLDS:", sp.expand(lhs - rhs) == 0)
print()

# sub-identity: a^2 - b^2 = (m^2-2mn-n^2)(m^2+2mn-n^2)
print("=== sub-identity a^2-b^2 = F5*F6 ===")
print("a^2-b^2 =", sp.expand(a**2 - b**2))
print("F5*F6   =", sp.expand(F5*F6))
print("equal:", sp.expand(a**2 - b**2 - F5*F6) == 0)
print()
# also = m^4 - 6 m^2 n^2 + n^4
print("m^4-6m^2n^2+n^4 - (a^2-b^2):", sp.expand(m**4 - 6*m**2*n**2 + n**4 - (a**2-b**2)))
print()

# a = m^2-n^2 = (m-n)(m+n) so F1..F4 already cover a's factorization with b=2mn
print("=== a = (m-n)(m+n) check ===")
print("a - F3*F4 =", sp.expand(a - F3*F4))
print()

# ----------------------------------------------------------------------
# Pairwise gcd / resultant structure of the six forms.
# We compute Res_m and Res_n of each pair (eliminating one variable) to get
# the integer that any common prime divisor must divide.  A nonzero constant
# resultant => the two forms are coprime as polynomials and share only
# primes dividing that constant (bounded factor).
# ----------------------------------------------------------------------
forms = {'m':F1, 'n':F2, 'm-n':F3, 'm+n':F4, 'm^2-2mn-n^2':F5, 'm^2+2mn-n^2':F6}
names = list(forms.keys())

print("=== pairwise resultants (eliminate n, treat as poly in m; then eliminate m) ===")
print("A nonzero integer resultant => common prime divisors are bounded (divide that resultant).")
print()
for i in range(len(names)):
    for j in range(i+1, len(names)):
        Fi, Fj = forms[names[i]], forms[names[j]]
        # resultant eliminating n
        try:
            rn = sp.resultant(sp.Poly(Fi, n), sp.Poly(Fj, n))
        except sp.PolynomialError:
            rn = None
        try:
            rm = sp.resultant(sp.Poly(Fi, m), sp.Poly(Fj, m))
        except sp.PolynomialError:
            rm = None
        print(f"({names[i]:>12}, {names[j]:>12}): Res_n = {sp.factor(rn) if rn is not None else 'NA'}    Res_m = {sp.factor(rm) if rm is not None else 'NA'}")

#!/usr/bin/env python3
"""
Step 3. Parametrize the quadratic-form-square loci.

The two quadratic forms in the factorization of a^2-b^2 are
  F5 = m^2 - 2mn - n^2
  F6 = m^2 + 2mn - n^2

Completing the square:
  F6 = (m+n)^2 - 2 n^2          [since (m+n)^2 = m^2+2mn+n^2, minus 2n^2 gives m^2+2mn-n^2]
  F5 = (m-n)^2 - 2 n^2          [since (m-n)^2 = m^2-2mn+n^2, minus 2n^2 gives m^2-2mn-n^2]

So F6 = X^2 - 2 n^2  with X = m+n,
   F5 = X^2 - 2 n^2  with X = m-n.

The 'quadratic-form-square locus' F6 = k^2 (resp F5=k^2) is the conic
  X^2 - 2 n^2 = k^2,  i.e.  X^2 - k^2 = 2 n^2,  (X-k)(X+k) = 2 n^2.
This is a PELL-CONIC / norm form: X^2 - 2 n^2 = k^2 means the integer X+n*sqrt(2)
has norm k^2 in Z[sqrt 2].  We parametrize all primitive integer solutions.
"""
import sympy as sp

m, n = sp.symbols('m n', integer=True)

F5 = m**2 - 2*m*n - n**2
F6 = m**2 + 2*m*n - n**2

print("=== Completing the square ===")
print("F6 = m^2+2mn-n^2 ; (m+n)^2 - 2n^2 =", sp.expand((m+n)**2 - 2*n**2),
      " ; equal to F6:", sp.expand(F6 - ((m+n)**2 - 2*n**2)) == 0)
print("F5 = m^2-2mn-n^2 ; (m-n)^2 - 2n^2 =", sp.expand((m-n)**2 - 2*n**2),
      " ; equal to F5:", sp.expand(F5 - ((m-n)**2 - 2*n**2)) == 0)
print()
print("So with X=m+n: F6 = X^2 - 2 n^2  (norm form of Z[sqrt2])")
print("   with X=m-n: F5 = X^2 - 2 n^2")
print()

# F6 = k^2  <=>  X^2 - 2 n^2 = k^2  <=> X^2 - k^2 = 2 n^2.
# Treat as: we want (m+n)^2 - 2 n^2 to be a perfect square k^2.
# Equivalently the point (X:n:k) on the projective conic X^2 - 2 n^2 - k^2 = 0.
# This conic has rational points (e.g. X=1,n=0,k=1), hence is parametrizable by P^1.
print("=== Rational parametrization of the conic X^2 - 2 n^2 = k^2 ===")
# Param: fix the base point P0 = (X,n,k) = (1,0,1). Lines through P0 with slope (s,t):
# X = 1 + ... ; easier: standard conic param.
# X^2 - k^2 = 2 n^2 => (X-k)(X+k) = 2 n^2. Set X-k = 2 u^2 d, X+k = v^2 d /?
# Use the Pythagorean-like solution of A*B = 2 n^2.
# General: X = s^2 + 2 t^2, k = s^2 - 2 t^2, n = 2 s t  gives
#   X^2 - k^2 = (X-k)(X+k) = (4 t^2)(2 s^2) = 8 s^2 t^2 = 2*(2 s t)^2 = 2 n^2. YES.
s, t = sp.symbols('s t', integer=True)
Xp = s**2 + 2*t**2
kp = s**2 - 2*t**2
npar = 2*s*t
print("Param A: X = s^2+2t^2, k = s^2-2t^2, n = 2 s t")
print("  Check X^2 - 2 n^2 - k^2 =", sp.expand(Xp**2 - 2*npar**2 - kp**2), " (should be 0)")
print()
# also the 'twisted' family X = 2s^2 + t^2 etc. Let's get the other branch:
Xp2 = 2*s**2 + t**2
kp2 = -(2*s**2 - t**2)
npar2 = 2*s*t
print("Param B: X = 2s^2+t^2, k = 2s^2-t^2, n = 2 s t")
print("  Check X^2 - 2 n^2 - k^2 =", sp.expand(Xp2**2 - 2*npar2**2 - kp2**2))
print()

# For F6: X = m+n, n=n. So given (s,t):  n = 2 s t,  m = X - n = (s^2+2t^2) - 2 s t = s^2 - 2 s t + 2 t^2.
print("=== F6 = k^2 parametrization in (m,n) ===")
m_of = (s**2 + 2*t**2) - 2*s*t   # m = X - n
n_of = 2*s*t
print("m = s^2 - 2 s t + 2 t^2,  n = 2 s t")
F6val = (m_of**2 + 2*m_of*n_of - n_of**2)
print("F6(m,n) =", sp.factor(sp.expand(F6val)))
ksq = sp.expand(F6val)
print("  Is it a perfect square in s,t? sqrt:", sp.sqrt(sp.factor(ksq)))
print()

# For F5: X = m-n. Given (s,t): n=2st, m = X + n = (s^2+2t^2)+2st = s^2+2st+2t^2.
print("=== F5 = k^2 parametrization in (m,n) ===")
m5 = (s**2 + 2*t**2) + 2*s*t
n5 = 2*s*t
F5val = sp.expand(m5**2 - 2*m5*n5 - n5**2)
print("m = s^2 + 2 s t + 2 t^2,  n = 2 s t")
print("F5(m,n) =", sp.factor(F5val))
print("  sqrt:", sp.sqrt(sp.factor(F5val)))
print()

# But these give n EVEN (n=2st). We also need the branch with n odd. The conic
# X^2 - 2n^2 = k^2 also has solutions with n odd: use (X-k)(X+k)=2n^2 with both
# factors... if n odd then 2n^2 = 2 * odd^2, factor as (X-k)=2a^2? no. Let's enumerate
# numerically instead to capture ALL primitive families (incl n odd) -- done in 05.
print("NOTE: the param above yields n=2st (even). Solutions with n odd come from the")
print("other factorization of 2n^2; enumerated numerically in 05_pell_enumerate.gp.")

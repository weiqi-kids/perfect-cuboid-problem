#!/usr/bin/env python3
# Step 1 (symbolic): verify the integral model & discriminant of E_PCP.
# E_PCP(q): y^2 = x(x+1)(x+q^2).  Substitution x->X/b^2, y->Y/b^3 with q=a/b (gcd(a,b)=1).
# Claim integral model:  E: Y^2 = X(X+b^2)(X+a^2),  Delta = 16 a^4 b^4 (a^2-b^2)^2.
import sympy as sp

a, b, q, x, y, X, Y = sp.symbols('a b q x y X Y')

# --- (A) Discriminant of a general short/long Weierstrass via standard formula ---
# Curve in form y^2 = (x-e1)(x-e2)(x-e3). For y^2 = x(x+r)(x+s):
# roots e1=0, e2=-r, e3=-s. Standard: Delta = 16 * (e1-e2)^2 (e1-e3)^2 (e2-e3)^2
def disc_three_roots(e1, e2, e3):
    return 16 * (e1-e2)**2 * (e1-e3)**2 * (e2-e3)**2

# Original E_PCP(q): roots 0, -1, -q^2
D_orig = sp.simplify(disc_three_roots(0, -1, -q**2))
print("Delta(E_PCP(q)) [y^2=x(x+1)(x+q^2)] =", sp.factor(D_orig))
# Expect 16 q^4 (q^2-1)^2

# Integral model with q=a/b: roots 0, -b^2, -a^2
D_int = sp.factor(disc_three_roots(0, -b**2, -a**2))
print("Delta(integral E) [Y^2=X(X+b^2)(X+a^2)] =", D_int)
D_claim = 16*a**4*b**4*(a**2-b**2)**2
print("matches 16 a^4 b^4 (a^2-b^2)^2 ?", sp.simplify(D_int - D_claim) == 0)

# --- (B) verify the substitution x=X/b^2, y=Y/b^3 maps E_PCP(a/b) to integral model ---
# E_PCP: y^2 = x(x+1)(x+q^2), q=a/b.
lhs = y**2
rhs = x*(x+1)*(x+(a/b)**2)
# substitute
sub = {x: X/b**2, y: Y/b**3}
lhs2 = lhs.subs(sub)         # Y^2/b^6
rhs2 = rhs.subs(sub)         # (X/b^2)(X/b^2+1)(X/b^2+a^2/b^2)
# multiply both sides by b^6
eqL = sp.simplify(lhs2*b**6)
eqR = sp.simplify(rhs2*b**6)
print("after x=X/b^2,y=Y/b^3, x b^6 form:")
print("  LHS*b^6 =", sp.expand(eqL))
print("  RHS*b^6 =", sp.factor(eqR))
target = X*(X+b**2)*(X+a**2)
print("  RHS*b^6 == X(X+b^2)(X+a^2) ?", sp.simplify(eqR - target) == 0)

# --- (C) c4, c6, j of integral model ---
# y^2 = x^3 + A2 x^2 + A4 x with A2=(a^2+b^2), A4=a^2 b^2 (expand X(X+b^2)(X+a^2))
A2 = a**2 + b**2
A4 = a**2 * b**2
# b2=4A2, b4=2A4, b6=0, b8 = -A4^2 ... use standard: for y^2=x^3+a2 x^2+a4 x+a6
a1,a3,a6 = 0,0,0
a2v, a4v = A2, A4
b2 = a1**2 + 4*a2v
b4 = 2*a4v + a1*a3
b6 = a3**2 + 4*a6
b8 = a1**2*a6 + 4*a2v*a6 - a1*a3*a4v + a2v*a3**2 - a4v**2
c4 = b2**2 - 24*b4
c6 = -b2**3 + 36*b2*b4 - 216*b6
Delta = -b2**2*b8 - 8*b4**3 - 27*b6**2 + 9*b2*b4*b6
print("c4 =", sp.factor(c4))
print("c6 =", sp.factor(c6))
print("Delta(via c-invariants) =", sp.factor(Delta), " matches?", sp.simplify(Delta - D_claim)==0)
jinv = sp.simplify(c4**3 / Delta)
print("j =", sp.factor(jinv))

# Pythagorean: a=m^2-n^2, b=2mn -> a^2-b^2 factor
m,n = sp.symbols('m n')
a2mb2 = sp.factor((m**2-n**2)**2 - (2*m*n)**2)
print("a^2-b^2 with a=m^2-n^2,b=2mn :", a2mb2, " = m^4-6m^2n^2+n^4 ?",
      sp.simplify(a2mb2-(m**4-6*m**2*n**2+n**4))==0)
# ABC identity
print("ABC identity b^2+(a^2-b^2)=a^2 ?", sp.simplify(b**2+(a**2-b**2)-a**2)==0)

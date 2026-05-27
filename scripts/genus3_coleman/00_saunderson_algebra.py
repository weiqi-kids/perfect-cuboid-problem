import sympy as sp

u,v,w,p,q,g,t,T = sp.symbols('u v w p q g t T', positive=False)

# Saunderson parametrization of a primitive Euler brick:
#   a = u(4v^2 - w^2),  b = v(4u^2 - w^2),  c = 4 u v w,  with u^2+v^2=w^2.
a = u*(4*v**2 - w**2)
b = v*(4*u**2 - w**2)
c = 4*u*v*w

# A perfect cuboid (Euler brick with space diagonal): need a,b,c to be the *edges*
# and the three face diagonals integer (Euler brick = body with integer edges + face diagonals).
# Saunderson's parametrization yields an Euler brick; the remaining PCP condition is the
# integral space diagonal: a^2+b^2+c^2 = g^2.

S = sp.expand(a**2 + b**2 + c**2)
print("a^2+b^2+c^2 (raw) =", S)

# Reduce using u^2+v^2 = w^2  (i.e. replace w^2 -> u^2+v^2)
S2 = sp.expand(S.subs(w**2, u**2+v**2))
# also w^4 -> (u^2+v^2)^2, w^6 etc. Do it via polynomial reduction in w using w^2=u^2+v^2.
def reduce_w(expr):
    expr = sp.expand(expr)
    # repeatedly substitute highest even powers of w
    for power in [8,6,4,2]:
        expr = expr.subs(w**power, (u**2+v**2)**(power//2))
        expr = sp.expand(expr)
    return expr

Sred = reduce_w(S)
print("a^2+b^2+c^2 reduced with w^2=u^2+v^2:", sp.factor(Sred))

# Claim: = w^2 (w^4 + 16 u^2 v^2).  Test:
claim = sp.expand((u**2+v**2)*((u**2+v**2)**2 + 16*u**2*v**2))
print("claim w^2(w^4+16u^2v^2) reduced =", sp.factor(claim))
print("difference =", sp.simplify(Sred - claim))

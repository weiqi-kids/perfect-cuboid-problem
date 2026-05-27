import sympy as sp
p,q,t,T,g,w = sp.symbols('p q t T g w')

u = p**2 - q**2
v = 2*p*q
wsq = p**2 + q**2   # = w (already the hypotenuse), w^2 = (p^2+q^2)^2... careful

# PCP condition: a^2+b^2+c^2 = g^2, and we showed a^2+b^2+c^2 = w^2(w^4+16u^2v^2)
# Here w = u^2+v^2? NO. In Saunderson u^2+v^2=w^2, and (u,v,w) Pythagorean.
# With (u,v,w) = (p^2-q^2, 2pq, p^2+q^2):  check u^2+v^2 = w^2
W = p**2 + q**2
print("u^2+v^2 - W^2 =", sp.expand(u**2+v**2 - W**2))  # should be 0

# a^2+b^2+c^2 = W^2 (W^4 + 16 u^2 v^2)
expr = sp.expand(W**2 * (W**4 + 16*u**2*v**2))
print("a^2+b^2+c^2 in p,q =", sp.factor(expr))

# g^2 = expr.  Set g = G, and (g/W)^2 = W^4 + 16 u^2 v^2.
RHS = sp.expand(W**4 + 16*u**2*v**2)
print("W^4+16u^2v^2 =", sp.expand(RHS))
print("factored:", sp.factor(RHS))

# This is homogeneous degree 8 in p,q. Dehomogenize: t=p/q, divide by q^8.
RHS_t = sp.expand(RHS.subs(p, t*q)/q**8)
RHS_t = sp.simplify(RHS_t)
print("\n(g/(W q^4))^2 ... dehomogenized in t=p/q:")
print("  f(t) =", sp.expand(RHS_t))

# Compare with claimed octic t^8+68t^6-122t^4+68t^2+1
claimed = t**8 + 68*t**6 - 122*t**4 + 68*t**2 + 1
print("\nclaimed octic f(t) =", claimed)
print("difference (RHS_t - claimed) =", sp.expand(RHS_t - claimed))

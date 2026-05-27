import sympy as sp

# ---- Theorem E (Saunderson palindrome -> E_PCP) ----
# Saunderson family: primitive Pythagorean (u,v,w) with w^2=u^2+v^2.
# The CLEANEST-PCP doc derives, with primitive quadruple
#   (p,q,n,m) = (2*lam*mu, 2*lam*nu, lam^2-mu^2-nu^2, lam^2+mu^2+nu^2)
# eliminating to discriminant D(r) with r=mu/nu:
#   D(r) = 256 r^2 (r^2-1)^2 + 4 (r^2+1)^4
# Claim (Step 4): D(r) = 4*(r^8 + 68 r^6 - 122 r^4 + 68 r^2 + 1)
r = sp.symbols('r')
D = 256*r**2*(r**2-1)**2 + 4*(r**2+1)**4
claim4 = 4*(r**8 + 68*r**6 - 122*r**4 + 68*r**2 + 1)
print("Step4 D(r) expand:", sp.expand(D))
print("Step4 claim     :", sp.expand(claim4))
print("Step4 identity holds:", sp.expand(D - claim4) == 0)

# Step 5 palindrome: (r^8+68 r^6-122 r^4+68 r^2+1)/r^4 = W^4+64 W^2-256 with W=r+1/r
W = sp.symbols('W')
poly = r**8 + 68*r**6 - 122*r**4 + 68*r**2 + 1
lhs = sp.expand(poly / r**4)
# substitute r+1/r = W: express lhs in terms of t=r^2? Use W = r+1/r => W^2 = r^2+2+1/r^2, W^4 = ...
# Build lhs as Laurent in r: r^4 + 68 r^2 - 122 + 68/r^2 + 1/r^4
# Want to show = W^4 + 64 W^2 - 256
Wexpr = r + 1/r
rhs = Wexpr**4 + 64*Wexpr**2 - 256
print("Step5 lhs - rhs simplify:", sp.simplify(lhs - rhs))

# Step6 lifting: W = r+1/r for rational r  <=>  W^2-4 in (Q*)^2
# r+1/r=W => r^2 - W r + 1 = 0 => r = (W +- sqrt(W^2-4))/2 rational iff W^2-4 is a square.
print("Step6: r rational solving r^2-W r+1=0 needs disc W^2-4 square. disc =", sp.discriminant(r**2 - W*r + 1, r))

# ---- PAPER-DRAFT Theorem E version (t = p/q) ----
# a^2+b^2+c^2 = (p^2+q^2)^2 * [ ((p^2+q^2)^4 + 64 p^2 q^2 (p^2-q^2)^2)/(p^2+q^2)^2 ]
# After rationalization with t=p/q: T^2 = t^8 + 68 t^6 - 122 t^4 + 68 t^2 + 1
p,q,t = sp.symbols('p q t')
bracket_num = (p**2+q**2)**4 + 64*p**2*q**2*(p**2-q**2)**2
# divide by q^8 and set t=p/q:
expr = sp.expand(bracket_num / q**8)
expr_t = sp.expand(expr.subs(p, t*q))  # substitute p=t q
print("\nPAPER-DRAFT bracket numerator /q^8 with p=t q:", sp.expand(expr_t))
target = t**8 + 68*t**6 - 122*t**4 + 68*t**2 + 1
print("equals t^8+68t^6-122t^4+68t^2+1 ?", sp.expand(expr_t - target) == 0)

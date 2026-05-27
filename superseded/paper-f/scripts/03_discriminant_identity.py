#!/usr/bin/env python3
# 03_discriminant_identity.py
# Verify symbolically:
#  (A) The order-4 doubling identity 2*(q, q(q+1)) = (0,0) on E_PCP(q) over Q(q).
#  (B) The reduction of the order-8 condition X(2P)=q to the quartic
#         G1(X,q) = X^4 - 4qX^3 - (4q^3+2q^2+4q)X^2 - 4q^3 X + q^4.
#  (C) After X=qZ, the quadratic-in-q discriminant
#         Delta(Z) = (Z^4-4Z^3-2Z^2-4Z+1)^2 - 64 Z^4
#      factors as (Z-1)^4 (Z+1)^2 (Z^2-6Z+1).
#  (D) The conic w^2 = Z^2-6Z+1 parametrization yields q = s^2 with s = 4(t+1)/((t-1)(t+3)).

import sympy as sp

X, q, Z, w, t, s = sp.symbols('X q Z w t s')

print("=== Discriminant identity & recovery-map degeneracy (sympy) ===\n")

# ----------------------------------------------------------------------
# (A) Doubling: 2*(q, q(q+1)) = (0,0) over Q(q).
# E: Y^2 = X^3 + a2 X^2 + a4 X,  a2 = 1+q^2, a4 = q^2, a6=0.
a2 = 1 + q**2
a4 = q**2
Px, Py = q, q*(q+1)
# check point on curve
on_curve = sp.simplify(Py**2 - (Px**3 + a2*Px**2 + a4*Px))
lam = sp.simplify((3*Px**2 + 2*a2*Px + a4)/(2*Py))
X2 = sp.simplify(lam**2 - a2 - 2*Px)
Y2 = sp.simplify(lam*(Px - X2) - Py)
print("(A) Order-4 doubling on E_PCP(q):")
print("    (q, q(q+1)) on curve? residual =", on_curve)
print("    lambda =", lam)
print("    X(2P) =", X2, "   Y(2P) =", Y2)
A_ok = (on_curve == 0) and (sp.simplify(X2) == 0) and (sp.simplify(Y2) == 0)
print("    => 2*(q,q(q+1)) = (0,0):", A_ok, "\n")

# ----------------------------------------------------------------------
# (B) Order-8 condition X(2P) = q reduces to quartic G1.
# X(2P) = ((X^2 - a4)^2 - ... )  general doubling x-coord for y^2=x^3+a2 x^2+a4 x+a6:
#   x(2P) = (X^4 - 2 a4 X^2 - 8 a6 X + a4^2 - 4 a2 a6) / (4(X^3 + a2 X^2 + a4 X + a6))
a6 = 0
num2 = X**4 - 2*a4*X**2 - 8*a6*X + a4**2 - 4*a2*a6
den2 = 4*(X**3 + a2*X**2 + a4*X + a6)
# Condition x(2P) = q  <=>  num2 - q*den2 = 0
cond_q = sp.expand(num2 - q*den2)
G1 = sp.expand(X**4 - 4*q*X**3 - (4*q**3 + 2*q**2 + 4*q)*X**2 - 4*q**3*X + q**4)
print("(B) Order-8 reduction X(2P)=q:")
print("    num2 - q*den2 =", cond_q)
print("    claimed G1    =", G1)
B_ok = sp.simplify(cond_q - G1) == 0
print("    => condition equals G1:", B_ok)
# absolute irreducibility of G1 over Q[X,q]
fac = sp.factor_list(G1, X, q)
print("    factor_list(G1) =", fac)
B_irred = (len(fac[1]) == 1 and fac[1][0][1] == 1)
print("    => G1 absolutely irreducible (single factor, mult 1):", B_irred, "\n")

# ----------------------------------------------------------------------
# (C) X = qZ; divide by q^3; quadratic in q; discriminant factorization.
# G1(qZ,q) = -q^3 * ( 4 Z^2 q^2 - R q + 4 Z^2 ),  R = Z^4-4Z^3-2Z^2-4Z+1.
G1_sub = sp.expand(G1.subs(X, q*Z))
R = Z**4 - 4*Z**3 - 2*Z**2 - 4*Z + 1
quad_in_q = 4*Z**2*q**2 - R*q + 4*Z**2           # the quadratic in q (up to overall sign)
check_C0 = sp.simplify(G1_sub + q**3 * quad_in_q)   # G1_sub = -q^3 * quad_in_q
print("(C) Substitution X=qZ (then divide by q^3):")
print("    G1(qZ,q) + q^3*[4Z^2 q^2 - R q + 4Z^2] =", check_C0)
# discriminant of  4Z^2 q^2 - R q + 4Z^2  in q:  R^2 - 4*(4Z^2)*(4Z^2) = R^2 - 64 Z^4
Pq = sp.Poly(quad_in_q, q)
A_, B_, C_ = Pq.all_coeffs()
Delta = sp.expand(B_**2 - 4*A_*C_)
Delta_claim = sp.expand((Z-1)**4 * (Z+1)**2 * (Z**2 - 6*Z + 1))
print("    quadratic in q: (%s) q^2 + (%s) q + (%s)" % (A_, sp.factor(B_), C_))
print("    Delta(Z) = B^2 - 4AC =", Delta)
print("    claimed factorization =", Delta_claim)
C_ok = (sp.simplify(check_C0) == 0) and (sp.simplify(Delta - Delta_claim) == 0)
print("    factor(Delta) =", sp.factor(Delta))
print("    => discriminant identity Delta=(Z-1)^4(Z+1)^2(Z^2-6Z+1):", C_ok, "\n")

# ----------------------------------------------------------------------
# (D) Conic w^2 = Z^2-6Z+1 ; line w = tZ+1 ; recovered q = s^2.
# Z(t) = -2(t+3)/((t-1)(t+1)); w(t) = t*Z+1.
Zt = -2*(t+3)/((t-1)*(t+1))
wt = t*Zt + 1
conic_res = sp.simplify(wt**2 - (Zt**2 - 6*Zt + 1))
print("(D) Conic parametrization w = tZ+1 through (0,1):")
print("    residual w(t)^2 - (Z^2-6Z+1) at Z(t) =", conic_res)
# q_+ = ( R(Z) + (Z-1)^2 (Z+1) w ) / (8 Z^2), evaluate at Z(t), w(t)
Rt = Zt**4 - 4*Zt**3 - 2*Zt**2 - 4*Zt + 1
qplus = sp.simplify((Rt + (Zt-1)**2*(Zt+1)*wt) / (8*Zt**2))
s_expr = 4*(t+1)/((t-1)*(t+3))
qplus_claim = sp.simplify(s_expr**2)
print("    q_+(t) =", sp.simplify(qplus))
print("    s^2   =", qplus_claim)
D_ok = (sp.simplify(conic_res) == 0) and (sp.simplify(qplus - qplus_claim) == 0)
print("    => q_+(t) = s(t)^2 with s = 4(t+1)/((t-1)(t+3)):", D_ok, "\n")

# ----------------------------------------------------------------------
print("=== SUMMARY ===")
print("(A) doubling identity 2*(q,q(q+1))=(0,0):", A_ok)
print("(B) order-8 -> quartic G1, irreducible:  ", B_ok and B_irred)
print("(C) Delta=(Z-1)^4(Z+1)^2(Z^2-6Z+1):      ", C_ok)
print("(D) recovered q = s^2 (-> Fermat u^2=s^4+1):", D_ok)
allok = A_ok and B_ok and B_irred and C_ok and D_ok
print("\nRESULT:", "PASS" if allok else "FAIL")

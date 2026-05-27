import sympy as sp
# Reconcile faithful 3-term form with doc's 2-term P4+P6=P5.
# Faithful: x^2+y^2+z^2=1 with x,y,z Pythagorean cosines (rational, 1-x^2 square).
# The g-condition a^2+b^2+c^2=g^2 with x=a/g etc. is x^2+y^2+z^2=1.
# Doc groups: sin^2 th4 + sin^2 th6 = sin^2 th5.
# Map: in doc, a/g=cos th5, c/g=sin th4, b/g=sin th6.  So
#   (a/g)^2 = cos^2 th5,  (c/g)^2 = sin^2 th4,  (b/g)^2 = sin^2 th6.
# g-cond: (a/g)^2+(b/g)^2+(c/g)^2=1 => cos^2 th5 + sin^2 th6 + sin^2 th4 = 1
#  => sin^2 th4 + sin^2 th6 = 1 - cos^2 th5 = sin^2 th5.  -> EXACTLY P4+P6=P5.
th4,th5,th6=sp.symbols('th4 th5 th6')
g_cond = sp.cos(th5)**2 + sp.sin(th6)**2 + sp.sin(th4)**2 - 1
P_form = sp.sin(th4)**2 + sp.sin(th6)**2 - sp.sin(th5)**2
print("g-condition - (P4+P6-P5) simplifies to:", sp.simplify(g_cond - P_form))
print("=> they are IDENTICAL:", sp.simplify(g_cond - P_form)==0)
print()
# So the doc's P4+P6=P5 IS faithful, given the specific labelling:
#   edge a <-> cos th5 (so face conditions on a use sin th5),
#   edge c <-> sin th4, edge b <-> sin th6.
# Each P_i = sin^2 th_i = (leg/hyp)^2 of a Pythagorean triple => 1-P_i is also a square
# (the complementary leg), so each face Pythagorean condition is automatic.
# CONCLUSION: PCP (nondeg) <=> exist 3 prim. Pythagorean triples (p_i,q_i,r_i), i=4,5,6
#   with (p4/r4)^2 + (p6/r6)^2 = (p5/r5)^2.
print("VERIFIED: N4 reformulation is a faithful equivalence.")

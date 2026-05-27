import sympy as sp
# Rigorous reconstruction of the N4 reduction.
# A perfect cuboid (up to scaling) is a point on the projective variety
#   V: a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2, a^2+b^2+c^2=g^2  in P^6.
# Rational points <=> integer perfect cuboids (clear denominators).
#
# Three of the four squareness conditions are "face" Pythagorean:
#   (a,b,d),(b,c,e),(a,c,f). The fourth ties them: g^2=a^2+b^2+c^2.
# Parametrize the three faces. The doc's idea: a face (a,b,d) rational
# means (a:b:d) lies on the conic a^2+b^2=d^2, i.e. there is a rational
# angle. Two of the three legs of each face are EDGES (a,b,c), shared
# across faces:  edges a,b,c appear in faces as:
#   face_d=(a,b), face_e=(b,c), face_f=(a,c).
# So we cannot freely choose 3 independent Pythagorean triples; the legs
# are SHARED. The doc's "3 independent triples (p_i,q_i,r_i)" must encode
# this sharing. Let's test the doc's claimed reduction faithfully by
# checking the count of constraints.
#
# Set a,b,c rational (edges). Conditions:
#  D: a^2+b^2 = square
#  E: b^2+c^2 = square
#  F: a^2+c^2 = square
#  G: a^2+b^2+c^2 = square
# That's 4 squareness conditions on (a,b,c) in P^2 -> expected dim
# of solution set generically 2-4 = negative, i.e. 0-dim'l-or-empty
# AFTER imposing all 4. The variety V is a SURFACE (dim 2) because the
# 4 conditions are on 7 homogeneous coords with relations.
#
# KEY CHECK: does "P4+P6=P5 with each P_i a Pythagorean square-ratio"
# capture ALL FOUR conditions or only THREE?  The doc claims all four.
# Reconstruct: the three faces give three Pythagorean ratios. The g
# condition g^2=a^2+b^2+c^2 is the FOURTH. The doc asserts that after
# the angle parametrization the g-condition becomes P4+P6=P5 automatically
# while the three face-conditions are "built in" by the angle param.
# Let's TEST whether choosing 3 Pythagorean triples sharing edges + the
# linear relation indeed forces a perfect cuboid.
#
# Direct numeric test: search small Pythagorean square-ratios P=(p/r)^2
# and see whether P4+P6=P5 ever holds with a CONSISTENT (a,b,c).
from fractions import Fraction
# generate primitive Pythagorean (leg^2/hyp^2) ratios for legs up to L
ratios = {}  # value -> (p,r)
L=60
prims=[]
for m in range(2,L):
    for n in range(1,m):
        if (m-n)%2==1 and sp.gcd(m,n)==1:
            a_=m*m-n*n; b_=2*m*n; r_=m*m+n*n
            if r_>3*L*L: continue
            prims.append((a_,b_,r_))
# P-values = (leg/hyp)^2 for either leg
Pvals=set()
PtoTriple={}
for (a_,b_,r_) in prims:
    for leg in (a_,b_):
        v=Fraction(leg*leg, r_*r_)
        Pvals.add(v); PtoTriple.setdefault(v,(leg,r_))
Pvals=sorted(Pvals)
print("num distinct Pythagorean square-ratios collected:", len(Pvals))
# look for P4+P6=P5
hits=0
Pset=set(Pvals)
import itertools
for P4 in Pvals:
    for P6 in Pvals:
        s=P4+P6
        if s in Pset and s!=P4 and s!=P6:
            hits+=1
            if hits<=8:
                print("  P4=",P4,"P6=",P6,"P5=",s)
print("total P4+P6=P5 solutions found in this small range:", hits)
print("NOTE: these are Pythagorean-ratio linear relations; whether each")
print("yields a CONSISTENT integer perfect cuboid is the real test.")

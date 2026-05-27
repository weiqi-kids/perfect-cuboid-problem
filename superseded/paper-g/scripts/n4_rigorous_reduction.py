import sympy as sp
# Faithful reconstruction.
# Edges a,b,c>0. The 4 squareness conditions:
#   d^2=a^2+b^2, e^2=a^2+c^2, f^2=b^2+c^2, g^2=a^2+b^2+c^2.
# (I'll use d=ab-face, e=ac-face, f=bc-face.)
#
# Normalize a^2+b^2+c^2=g^2. Divide everything by g^2 and set
#   x=a/g, y=b/g, z=c/g, so x^2+y^2+z^2=1.  (the g-condition is now identity)
# The three FACE conditions become:
#   x^2+y^2 = (d/g)^2 = 1 - z^2  -> automatically rational square iff (1-z^2) is square
#   x^2+z^2 = 1 - y^2 square
#   y^2+z^2 = 1 - x^2 square
# So the perfect-cuboid condition (given x^2+y^2+z^2=1) becomes:
#   1-x^2, 1-y^2, 1-z^2 all rational squares,  AND x,y,z rational.
# i.e. (x, sqrt(1-x^2)) etc. are rational points on the unit circle.
# So x = cos A, y = cos B, z = cos C with A,B,C "Pythagorean angles"
# (rational cosine AND rational sine), and cos^2 A+cos^2 B+cos^2 C = 1.
#
# A rational point on unit circle: cos = (1-t^2)/(1+t^2), sin=2t/(1+t^2).
# So x=cos A => 1-x^2 = sin^2 A is square automatically. GOOD: each face
# condition is "x is a rational-circle-cosine" i.e. x in the set
#   {(1-t^2)/(1+t^2)} = {Pythagorean leg-ratios}.
# Then the ONLY remaining condition is cos^2 A+cos^2 B+cos^2 C = 1, i.e.
#   sin^2 A + sin^2 B + sin^2 C = 2, equivalently
#   cos^2A+cos^2B+cos^2C=1.
# Rewrite cos^2C = 1-cos^2A-cos^2B = sin^2A - cos^2B ... let's just state:
#   set P_A=cos^2 A etc.  P_A+P_B+P_C = 1.
# Hmm the doc says P4+P6=P5 (a 2-term = 1-term). Let me see: with
# sin^2 = 1-cos^2, the relation cos^2A+cos^2B+cos^2C=1 can be written
#   (1-sin^2A)+(1-sin^2B)+(1-sin^2C)=1 => sin^2A+sin^2B+sin^2C=2. NOT 2-term.
# So a CLEAN 2-term form P4+P6=P5 requires a different grouping. Let's verify
# the doc's exact claim by direct algebra is INCONSISTENT with the faithful one.
print("Faithful reduction: PCP (a,b,c>0) <=> rationals x,y,z on unit circle")
print("with x^2+y^2+z^2=1 and each of 1-x^2,1-y^2,1-z^2 a rational square.")
print("Equivalent single relation: cos^2A+cos^2B+cos^2C = 1  (3 Pyth. cosines)")
print()
# Now test: is the doc's 'P4+P6=P5' the SAME as cos^2A+cos^2B+cos^2C=1?
# 2-term vs 3-term. They cannot be literally identical. BUT maybe the doc
# uses a different face assignment where one edge ratio is determined.
# Let's check the doc's integer identity numerically against a TRUE
# (cos^2A+cos^2B+cos^2C=1) solution to see if its 'single equation' is
# faithful or drops a constraint.
#
# Search rational x,y,z on unit circle with x^2+y^2+z^2=1, all from
# Pythagorean leg-ratios -> that's exactly a "perfect cuboid up to scale".
from fractions import Fraction
def circ_cosines(L):
    out=set()
    for m in range(2,L):
        for n in range(1,m):
            if (m-n)%2==1 and sp.gcd(m,n)==1:
                num=m*m-n*n; den=m*m+n*n
                out.add(Fraction(num,den))
                out.add(Fraction(2*m*n,den))
    return sorted(out)
C=circ_cosines(40)
Cset=set(C)
print("num circle-cosines:",len(C))
found=0
for x in C:
    for y in C:
        rem=1-x*x-y*y
        if rem<=0: continue
        # need z^2=rem with z a circle-cosine
        # z rational with z^2=rem
        # rem=Fraction; check perfect square
        from sympy import Rational, sqrt, nsimplify
        rr=Rational(rem.numerator,rem.denominator)
        s=sp.sqrt(rr)
        if s.is_rational:
            z=Fraction(int(s.p),int(s.q)) if hasattr(s,'p') else Fraction(s)
            if z in Cset:
                found+=1
                if found<=5: print("  PERFECT-CUBOID-up-to-scale:",x,y,z)
print("perfect-cuboid-up-to-scale solutions in range:",found,"(expect 0)")

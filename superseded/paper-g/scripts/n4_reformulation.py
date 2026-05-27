import sympy as sp
# ------------------------------------------------------------------
# N4 reformulation. The doc claims PCP <=> exist 3 primitive Pythagorean
# triples (p_i,q_i,r_i), i=4,5,6 with  P4 + P6 = P5,  P_i = (p_i/r_i)^2.
# Let's reconstruct from the angle parametrization and check it is a
# genuine equivalence to the perfect-cuboid system.
#
# PCP: positive integers (a,b,c) with
#   a^2+b^2 = d^2, b^2+c^2 = e^2, a^2+c^2 = f^2, a^2+b^2+c^2 = g^2.
# Normalize by g: set A=a/g,B=b/g,C=c/g with A^2+B^2+C^2=1.
# The three face conditions: a^2+b^2 square, etc.
# The doc sets (writing angles) the 7 quantities a..g/g as sines/cosines.
# Let's just TEST the integer-version identity it states, symbolically.
M4,N4,M5,N5,M6,N6 = sp.symbols('M4 N4 M5 N5 M6 N6')
LHS = ( (M4**2-N4**2)**2*(M5**2+N5**2)**2*(M6**2+N6**2)**2
      + (M6**2-N6**2)**2*(M4**2+N4**2)**2*(M5**2+N5**2)**2 )
RHS = (M5**2-N5**2)**2*(M4**2+N4**2)**2*(M6**2+N6**2)**2
# This is the integer-version condition asserted equivalent to P4+P6=P5.
# Check: dividing by (M4^2+N4^2)^2(M5^2+N5^2)^2(M6^2+N6^2)^2 gives
#  ((M4^2-N4^2)/(M4^2+N4^2))^2 + ((M6^2-N6^2)/(M6^2+N6^2))^2 = ((M5^2-N5^2)/(M5^2+N5^2))^2
# i.e. cos^2 th4 + cos^2 th6 = cos^2 th5  -- note doc text mixes sin/cos. Verify which.
den = (M4**2+N4**2)**2*(M5**2+N5**2)**2*(M6**2+N6**2)**2
expr = sp.simplify((LHS-RHS)/den)
print("Integer-version reduced identity (should be cos^2+cos^2-cos^2):")
print(sp.simplify(expr))
c4 = ((M4**2-N4**2)/(M4**2+N4**2))**2
c5 = ((M5**2-N5**2)/(M5**2+N5**2))**2
c6 = ((M6**2-N6**2)/(M6**2+N6**2))**2
print("matches cos4^2+cos6^2-cos5^2 ?", sp.simplify(expr - (c4+c6-c5))==0)

# So the integer-version states cos^2 th4 + cos^2 th6 = cos^2 th5.
# The boxed claim says sin^2 th4 + sin^2 th6 = sin^2 th5 (P_i = sin^2).
# These are DIFFERENT unless there's a consistent leg/hyp labelling.
# The substance: PCP reduces to a single quadratic relation among three
# Pythagorean ratios. Let's sanity-check the CLAIM direction on a real
# (non-perfect) Euler brick to ensure no PCP-spurious solution and check
# the structural shape, AND verify it on the known parametrization.
print()
# Build the actual reduction from scratch following route-N4 angle setup:
# a/g=cos th5, e/g=sin th5 ; c/g=sin th4, d/g=cos th4 ; b/g=sin th6, f/g=cos th6
# Constraints to be a perfect cuboid (a,b,c edges; d,e,f face diag; g space diag):
#   d^2=a^2+b^2, e^2=b^2+c^2, f^2=a^2+c^2, g^2=a^2+b^2+c^2.
t4,t5,t6 = sp.symbols('t4 t5 t6', positive=True)
def cos2(t): return ((1-t**2)/(1+t**2))**2
def sin2(t): return (2*t/(1+t**2))**2
a = sp.sqrt(cos2(t5)); e = sp.sqrt(sin2(t5))
c = sp.sqrt(sin2(t4)); d = sp.sqrt(cos2(t4))
b = sp.sqrt(sin2(t6)); f = sp.sqrt(cos2(t6))
# require a^2+b^2+c^2 = 1 (g=1). Check what that gives:
g2 = sp.simplify(cos2(t5)+sin2(t6)+sin2(t4))
print("a^2+b^2+c^2 (=g^2) in terms of t4,t5,t6:", sp.simplify(g2))
print("g^2 == 1 condition:", sp.simplify(g2-1))

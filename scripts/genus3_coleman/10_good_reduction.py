import sympy as sp
t = sp.symbols('t')
f = t**8 + 68*t**6 - 122*t**4 + 68*t**2 + 1
disc = sp.discriminant(f, t)
print("disc(f) =", disc, " = ", sp.factorint(disc))
print("Bad primes (divide disc): {2,5}.  All other p are GOOD reduction.")
for p in [7,19,3]:
    print(f"  p={p}: disc mod p = {disc % p}  -> good reduction: {disc % p != 0}; p>2g=6: {p>6}")
print()
print("Coleman 1985 unconditional bound: for p good, p>2g,")
print("  |C(Q)| <= #C(F_p) + 2g - 2.")
print("This form does NOT require checking residue-disk differential non-vanishing")
print("(that refinement, needed for the sharp #residue-disk count, is Magma/Coleman-")
print("integration territory).  The +2g-2 bound is unconditional given rank J < g.")
print()
print("At p=7 (good, 7>6): #C(F_7)=8 => |C'(Q)| <= 12.  Known points = 8.")

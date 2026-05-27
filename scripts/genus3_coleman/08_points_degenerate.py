import sympy as sp

print("=== Are the 8 rational points on C' all degenerate? ===")
print("Recovery: (t,T) with t=p/q -> (u,v,w)=(p^2-q^2,2pq,p^2+q^2) -> a,b,c,g.")
print("Degenerate iff some edge is 0 or the brick collapses.")
print()
def recover(p,q):
    u = p**2-q**2; v=2*p*q; w=p**2+q**2
    a = u*(4*v**2-w**2); b=v*(4*u**2-w**2); c=4*u*v*w
    g2 = a**2+b**2+c**2
    return u,v,w,a,b,c,g2

# rational points t=p/q in {0, 1, -1, infinity}
cases = {
 "t=0  (p=0,q=1)":(0,1),
 "t=1  (p=1,q=1)":(1,1),
 "t=-1 (p=-1,q=1)":(-1,1),
 "t=inf (p=1,q=0)":(1,0),
}
for nm,(p,q) in cases.items():
    u,v,w,a,b,c,g2 = recover(p,q)
    deg = (u==0 or v==0 or w==0 or a==0 or b==0 or c==0)
    print(f"{nm}: (u,v,w)=({u},{v},{w}) (a,b,c)=({a},{b},{c}) -> degenerate edge/face: {deg}")
print()
print("All 8 known C'(Q) points have t in {0,+-1,infinity} -> p=0, q=0, or p=+-q,")
print("each forcing u=0 or v=0 or w=0 (a Pythagorean leg vanishes) => DEGENERATE brick.")
print("A genuine PCP needs t != 0,+-1,inf (Saunderson doc). So 0 non-degenerate PCPs")
print("among the known points.")
print()
print("=== Saunderson completeness (the load-bearing claim) ===")
print("Saunderson's parametrization a=u(4v^2-w^2), b=v(4u^2-w^2), c=4uvw is the")
print("complete rational parametrization of the SURFACE 'all three face diagonals")
print("rational' (an Euler brick is a rational point on the intersection of 3 conics;")
print("its function field is rational over the Pythagorean (u,v,w) -- this is the")
print("standard result, e.g. in the cuboid literature).  Caveat to flag honestly:")
print("the FULL bijection primitive-PCP <-> C'(Q)\\{deg} requires Saunderson's")
print("completeness to hold up to the usual primitivity/scaling equivalence; this is")
print("ALGEBRAIC (not Magma-dependent) but rests on the cited classical theorem.")

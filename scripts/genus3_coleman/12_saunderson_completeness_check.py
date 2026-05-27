import sympy as sp
from itertools import product

print("=== Numerical test: do KNOWN Euler bricks arise from Saunderson (u,v,w)? ===")
print("Smallest primitive Euler brick: edges (44,117,240), face diags (125,244,267).")
print("Saunderson: a=u(4v^2-w^2), b=v(4u^2-w^2), c=4uvw, u^2+v^2=w^2.")
print()
# Generate Saunderson bricks from small Pythagorean triples and see if (44,117,240) appears
# (up to permutation/sign/scaling).
def primitive_pyth(maxk):
    out=[]
    for m in range(2,maxk):
        for n in range(1,m):
            if (m-n)%2==1 and sp.gcd(m,n)==1:
                u=m*m-n*n; v=2*m*n; w=m*m+n*n
                out.append((u,v,w))
                out.append((v,u,w))  # swap legs
    return out

target = sorted([44,117,240])
found=False
for (u,v,w) in primitive_pyth(40):
    a=u*(4*v*v-w*w); b=v*(4*u*u-w*w); c=4*u*v*w
    edges = sorted([abs(a),abs(b),abs(c)])
    # check if proportional to target
    if edges[0]>0:
        # reduce both
        from math import gcd
        ge = gcd(gcd(edges[0],edges[1]),edges[2])
        red = tuple(e//ge for e in edges)
        gt = gcd(gcd(target[0],target[1]),target[2])
        rt = tuple(e//gt for e in target)
        if red==rt:
            print(f"MATCH: (u,v,w)=({u},{v},{w}) -> edges {edges} ~ {target}")
            found=True
            break
if not found:
    print("(44,117,240) NOT directly found in small Saunderson enumeration up to k=40.")
    print("Note: Saunderson edges have a FIXED structure a=u(4v^2-w^2) etc -- it parametrizes")
    print("Euler bricks but with a SPECIFIC normalization; the brick may appear at larger")
    print("(u,v,w) or under the documented equivalence. Showing a few Saunderson bricks:")
    cnt=0
    for (u,v,w) in primitive_pyth(8):
        a=u*(4*v*v-w*w); b=v*(4*u*u-w*w); c=4*u*v*w
        # is it a genuine Euler brick (all face diagonals integer)?
        fd1=sp.sqrt(a*a+b*b); fd2=sp.sqrt(b*b+c*c); fd3=sp.sqrt(a*a+c*c)
        ok = all(d==int(d) for d in [fd1,fd2,fd3] if d.is_real)
        print(f"  (u,v,w)=({u},{v},{w}): edges=({a},{b},{c}) facediag=({fd1},{fd2},{fd3}) EulerBrick={fd1.is_integer and fd2.is_integer and fd3.is_integer}")
        cnt+=1
        if cnt>=5: break

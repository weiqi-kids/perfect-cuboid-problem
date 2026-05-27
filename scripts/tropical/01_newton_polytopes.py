#!/usr/bin/env python3
"""
01_newton_polytopes.py

Compute the Newton polytopes N(Q_i) of the 4 defining quadrics of V ⊂ P^6:

    Q_1 = a^2 + b^2 - d^2
    Q_2 = b^2 + c^2 - e^2
    Q_3 = a^2 + c^2 - f^2
    Q_4 = a^2 + b^2 + c^2 - g^2

Variables: a=0, b=1, c=2, d=3, e=4, f=5, g=6  ∈ ℝ^7.

Each monomial x_i^2 corresponds to the lattice point 2*e_i in ℤ^7 (where e_i is
the i-th standard basis vector).  So every Newton polytope is a simplex (or
segment) inside the dilated standard simplex 2*Δ_6.

Outputs:
  - vertex list per polytope,
  - dimension of affine hull,
  - lineality (= 0 always since vertices are bounded),
  - centroid,
  - support of variables used.

We also write a polymake input for the Newton polytope Minkowski sum N(Q_1) + N(Q_2) + N(Q_3) + N(Q_4),
which controls the BKK bound (mixed volume).

Honest note:  Newton polytopes of quadratic equations are always simplices,
hence the analysis here is short.  The structure carried into tropical
geometry is which variables appear (giving the "shape" of trop(V) in 7-space).
"""

import itertools
import json
import os
from pathlib import Path

OUTDIR = Path(__file__).parent / "output"
OUTDIR.mkdir(exist_ok=True)

VARS = ["a", "b", "c", "d", "e", "f", "g"]  # 7 variables in P^6

# Each quadric: list of (sign, [exponent vector])  --- only squares appear.
# We represent monomials by their exponent vector of length 7.

def e(i):
    v = [0] * 7
    v[i] = 2
    return tuple(v)

QUADRICS = {
    "Q1": [(+1, e(0)), (+1, e(1)), (-1, e(3))],   # a^2 + b^2 - d^2
    "Q2": [(+1, e(1)), (+1, e(2)), (-1, e(4))],   # b^2 + c^2 - e^2
    "Q3": [(+1, e(0)), (+1, e(2)), (-1, e(5))],   # a^2 + c^2 - f^2
    "Q4": [(+1, e(0)), (+1, e(1)), (+1, e(2)), (-1, e(6))],  # a^2 + b^2 + c^2 - g^2
}


def newton_polytope_vertices(monomials):
    """Return list of vertex tuples of N(Q) = conv{exponent vectors of monomials with nonzero coeff}."""
    return sorted({m for (_, m) in monomials})


def affine_dim(vertices):
    """Dimension of the affine hull = rank({v - v_0 : v in vertices}) for v_0 = first vertex."""
    if not vertices:
        return -1
    v0 = vertices[0]
    diffs = [tuple(a - b for a, b in zip(v, v0)) for v in vertices[1:]]
    # gauss-eliminate over Q to count rank
    import fractions
    M = [list(map(fractions.Fraction, row)) for row in diffs]
    if not M:
        return 0
    n = 7
    rank = 0
    col = 0
    while col < n and rank < len(M):
        pivot = None
        for r in range(rank, len(M)):
            if M[r][col] != 0:
                pivot = r
                break
        if pivot is None:
            col += 1
            continue
        M[rank], M[pivot] = M[pivot], M[rank]
        for r in range(len(M)):
            if r != rank and M[r][col] != 0:
                factor = M[r][col] / M[rank][col]
                M[r] = [a - factor * b for a, b in zip(M[r], M[rank])]
        rank += 1
        col += 1
    return rank


def report():
    out = {}
    for name, mons in QUADRICS.items():
        verts = newton_polytope_vertices(mons)
        d = affine_dim(verts)
        vars_used = sorted({i for v in verts for i, c in enumerate(v) if c != 0})
        centroid = tuple(sum(v[i] for v in verts) / len(verts) for i in range(7))
        out[name] = {
            "polynomial": " + ".join(
                ("+" if s > 0 else "-") + VARS[next(i for i, c in enumerate(m) if c)] + "^2"
                for (s, m) in mons
            ),
            "vertices": verts,
            "num_vertices": len(verts),
            "affine_dim": d,
            "variables_used (indices)": vars_used,
            "variables_used (names)": [VARS[i] for i in vars_used],
            "centroid": centroid,
        }
        print(f"--- {name} : {out[name]['polynomial']}")
        print(f"    vertices : {verts}")
        print(f"    affine dim = {d}  (a simplex of dim {d})")
        print(f"    uses vars {[VARS[i] for i in vars_used]}\n")

    # Minkowski sum: every vertex of the sum is sum of one vertex from each polytope.
    minkowski_pts = set()
    for vlists in itertools.product(*[newton_polytope_vertices(QUADRICS[q]) for q in ["Q1", "Q2", "Q3", "Q4"]]):
        p = tuple(sum(v[i] for v in vlists) for i in range(7))
        minkowski_pts.add(p)
    print(f"--- Minkowski sum N(Q1)+N(Q2)+N(Q3)+N(Q4) preliminary points: {len(minkowski_pts)} (candidate vertices)")

    # Save polymake input for mixed volume / Minkowski sum (computed in script 03).
    # Here we just write the raw vertex sets:
    pm_path = OUTDIR / "newton_polytopes.poly"
    with open(pm_path, "w") as f:
        for i, q in enumerate(["Q1", "Q2", "Q3", "Q4"], start=1):
            verts = newton_polytope_vertices(QUADRICS[q])
            f.write(f"# {q}\n")
            for v in verts:
                f.write("1 " + " ".join(str(c) for c in v) + "\n")
            f.write("\n")
    print(f"Wrote {pm_path}")

    with open(OUTDIR / "newton_polytopes.json", "w") as f:
        json.dump(out, f, indent=2, default=list)
    print(f"Wrote {OUTDIR / 'newton_polytopes.json'}")

    return out


if __name__ == "__main__":
    report()

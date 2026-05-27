#!/usr/bin/env python3
"""
04_polynomial_obstruction.py

Search for low-degree polynomials Q(a,b,c,d,e,f,g) over F_p (or as integer
polynomials) vanishing on the PCP locus V but NOT vanishing on the "Euler
brick" locus W (where only the 3 face-diagonal equations hold).

If we find such a Q with low degree, it's a PCP-specific obstruction beyond
the four obvious quadrics.

Approach:
1. Generate the PCP variety V_p(F_p) as a list of points for small p.
2. Generate the Euler-brick variety W_p(F_p) (3 face diagonals, g free → 7-tuples
   with arbitrary g). Actually we use the "Euler-brick" 7-locus E ⊂ F_p^7 where
   eq1,eq2,eq3 hold (g free).
3. For each degree d = 1, 2, 3, ...:
     - Form the vector space M_d of monomials in 7 vars of total degree ≤ d
       and per-variable degree ≤ p-1.
     - Build the evaluation matrix E_V: rows = points of V, cols = monomials.
     - kernel(E_V) = polynomials vanishing on V at degree ≤ d.
     - Similarly E_W.
     - Compute kernel(E_V) / kernel(E_W) — quotient gives PCP-specific obstructions.

If for small d there's a "new" relation in V not in W, that's interesting.
"""

import itertools
import json
import numpy as np
import time
from pathlib import Path

OUTDIR = Path(__file__).parent
OUT_JSON = OUTDIR / "04_obstruction.json"

NVARS = 7  # (a,b,c,d,e,f,g)


def build_qr(p):
    qr = set()
    for x in range(1, p):
        qr.add(x * x % p)
    return qr


def sqrts(s, p, qr):
    if s == 0:
        return [0]
    if s in qr:
        for x in range(1, (p + 1) // 2 + 1):
            if x * x % p == s:
                return [x, (p - x) % p]
    return []


def gen_V(p):
    """All (a,b,c,d,e,f,g) in F_p^7 satisfying the 4 PCP equations."""
    qr = build_qr(p)
    sq = [(x * x) % p for x in range(p)]
    V = []
    for a in range(p):
        a2 = sq[a]
        for b in range(p):
            b2 = sq[b]
            for d in sqrts((a2 + b2) % p, p, qr):
                for c in range(p):
                    c2 = sq[c]
                    for e_ in sqrts((b2 + c2) % p, p, qr):
                        for f in sqrts((a2 + c2) % p, p, qr):
                            for g in sqrts((a2 + b2 + c2) % p, p, qr):
                                V.append((a, b, c, d, e_, f, g))
    return V


def gen_W(p):
    """Euler brick: only 3 face diagonals; g free (so 7-tuples)."""
    qr = build_qr(p)
    sq = [(x * x) % p for x in range(p)]
    W = []
    for a in range(p):
        a2 = sq[a]
        for b in range(p):
            b2 = sq[b]
            for d in sqrts((a2 + b2) % p, p, qr):
                for c in range(p):
                    c2 = sq[c]
                    for e_ in sqrts((b2 + c2) % p, p, qr):
                        for f in sqrts((a2 + c2) % p, p, qr):
                            for g in range(p):
                                W.append((a, b, c, d, e_, f, g))
    return W


def monomials_up_to(deg, p):
    """All monomials (e_0,...,e_6) with sum ≤ deg and each e_i ≤ p-1."""
    mons = []
    def rec(idx, rem, cur):
        if idx == NVARS:
            mons.append(tuple(cur))
            return
        max_here = min(p - 1, rem)
        for e in range(max_here + 1):
            cur.append(e)
            rec(idx + 1, rem - e, cur)
            cur.pop()
    rec(0, deg, [])
    return mons


def eval_monomials(points, mons, p):
    """Matrix M[i, j] = points[i]^mons[j] mod p. Shape (|points|, |mons|)."""
    n = len(points)
    m = len(mons)
    M = np.zeros((n, m), dtype=np.int64)
    P = np.array(points, dtype=np.int64) % p
    Mons = np.array(mons, dtype=np.int64)
    for j in range(m):
        col = np.ones(n, dtype=np.int64)
        for v in range(NVARS):
            e = int(Mons[j, v])
            if e > 0:
                col = (col * pow_vec(P[:, v], e, p)) % p
        M[:, j] = col
    return M


def pow_vec(vec, e, p):
    r = np.ones_like(vec)
    base = vec.copy()
    while e > 0:
        if e & 1:
            r = (r * base) % p
        base = (base * base) % p
        e >>= 1
    return r


def kernel_dim(M, p):
    """Dimension of right null space of M over F_p."""
    M = M.copy().astype(np.int64) % p
    rows, cols = M.shape
    r = 0
    for c in range(cols):
        piv = -1
        for i in range(r, rows):
            if M[i, c] % p != 0:
                piv = i
                break
        if piv == -1:
            continue
        M[[r, piv]] = M[[piv, r]]
        inv = pow(int(M[r, c]) % p, p - 2, p)
        M[r] = (M[r] * inv) % p
        for i in range(rows):
            if i != r and M[i, c] % p != 0:
                M[i] = (M[i] - M[i, c] * M[r]) % p
        r += 1
        if r == rows:
            break
    return cols - r, r  # null dim, rank


def analyze_p(p, degs):
    print(f"\n=== p = {p} ===")
    V = gen_V(p)
    W = gen_W(p)
    print(f"|V_p| = {len(V)}, |W_p| (Euler 7-tuples) = {len(W)}")
    out = {"p": p, "V_size": len(V), "W_size": len(W), "by_degree": []}
    for d in degs:
        mons = monomials_up_to(d, p)
        nm = len(mons)
        # eval matrices
        Mv = eval_monomials(V, mons, p)
        Mw = eval_monomials(W, mons, p)
        nullV, rkV = kernel_dim(Mv, p)
        nullW, rkW = kernel_dim(Mw, p)
        # PCP-specific obstructions: dim(ker(E_V)) - dim(ker(E_W) restricted to same monomial space)
        # Note: ker(E_W) ⊆ ker(E_V) since W ⊃ V? No, V ⊄ W: V has 4 eqs, W has 3 — so V ⊂ W
        # (any PCP solution is also an Euler brick solution).
        # So ker(E_W) ⊆ ker(E_V). PCP-specific = dim quotient = nullV - nullW.
        specific = nullV - nullW
        print(f"  deg ≤ {d}: #mons = {nm}, rank(V) = {rkV}, null(V) = {nullV}, "
              f"rank(W) = {rkW}, null(W) = {nullW}, PCP-specific obstruction dim = {specific}")
        out["by_degree"].append({
            "deg": d, "num_monomials": nm,
            "rank_V": rkV, "null_V": nullV,
            "rank_W": rkW, "null_W": nullW,
            "PCP_specific_obstruction_dim": specific,
        })
    return out


def main():
    results = []
    # For p=3: deg ≤ 6 is full space (per-var ≤ 2, 7 vars → max total 14 but mons up to ≤ deg)
    for p, degs in [(3, [1, 2, 3, 4, 5, 6, 7, 8]),
                    (5, [1, 2, 3, 4, 5, 6])]:
        results.append(analyze_p(p, degs))
    OUT_JSON.write_text(json.dumps(results, indent=2))
    print(f"\nWritten: {OUT_JSON}")


if __name__ == "__main__":
    main()

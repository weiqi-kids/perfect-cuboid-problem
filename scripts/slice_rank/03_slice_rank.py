#!/usr/bin/env python3
"""
03_slice_rank.py

Compute slice rank of the PCP indicator viewed as a function of slices.

Recall: For a function T : S_1 x ... x S_k -> F_p (a k-tensor), slice rank is
the minimum r such that
   T = sum_{j=1}^r f_j(x_{i_j}) * g_j(remaining vars)
where each f_j depends on exactly one of the k coordinates. Slice rank
satisfies the multilinear-algebra lower bound: tensor rank ≤ slice rank ≤
tensor rank in some settings.

For the capset problem, Croot-Lev-Pach use a *3-tensor* (k=3). Here our
indicator is a 7-tensor — slice rank of 7-tensors is more subtle.

We focus on the standard CLP setup:
  - Partition the 7 variables into 3 groups.
  - View I_PCP as a 3-tensor on F_p^{n_1} x F_p^{n_2} x F_p^{n_3}.
  - Compute slice rank.

A natural partition for PCP given the symmetry:
  Group A: {a, d}     (the face diagonal pair with b)
  Group B: {b, c, e}
  Group C: {f, g}
This breaks symmetry; we'll try several partitions and report best.

A simpler partition:
  Group A: {a}, Group B: {b}, Group C: {c,d,e,f,g}
  Reduces to a 3-tensor F_p x F_p x F_p^5 → F_p with sizes (p, p, p^5).
  Slice rank ≤ min(p, p, p^5) = p.
This won't give a sub-cubic bound directly, but we can ask: what is the
*actual* slice rank?

For p=3, we can compute slice rank explicitly via the matrix-rank algorithm.

Slice rank algorithm (greedy / via Tao's bound):
  slice_rank(T) ≤ min over decompositions of sum of ranks of "matricizations"
  along each direction.

Specifically, if T is a 3-tensor on X x Y x Z, then
  T(x,y,z) = sum_j A_j(x,y) * B_j(z) — flattening Z direction.
  slice_rank ≤ rank(T_flat_Z) where T_flat_Z is a (|X|*|Y|) x |Z| matrix.
Similarly for X and Y flattenings. Slice rank ≤ min of the three flattening ranks.

That min-flattening bound is the easy upper bound. We compute all three for the
PCP indicator as a 3-tensor.
"""

import numpy as np
import json
import time
from pathlib import Path
from itertools import product

OUTDIR = Path(__file__).parent
OUT_JSON = OUTDIR / "03_slice_rank.json"


def build_qr(p):
    qr = set()
    for x in range(1, p):
        qr.add((x * x) % p)
    return qr


def count_sqrt(s, qr, p):
    if s == 0:
        return 1
    if s in qr:
        return 2
    return 0


def build_indicator_tensor(p):
    """Build I_PCP as a 7-dim array of shape (p,)*7 over F_p."""
    qr = build_qr(p)
    sq = [(x * x) % p for x in range(p)]
    T = np.zeros((p,) * 7, dtype=np.int64)
    for a in range(p):
        a2 = sq[a]
        for b in range(p):
            b2 = sq[b]
            s1 = (a2 + b2) % p
            for d in range(p):
                if sq[d] != s1:
                    continue
                for c in range(p):
                    c2 = sq[c]
                    s2 = (b2 + c2) % p
                    s3 = (a2 + c2) % p
                    s4 = (a2 + b2 + c2) % p
                    for e_ in range(p):
                        if sq[e_] != s2:
                            continue
                        for f in range(p):
                            if sq[f] != s3:
                                continue
                            for g in range(p):
                                if sq[g] != s4:
                                    continue
                                T[a, b, c, d, e_, f, g] = 1
    return T


def flatten_to_3tensor(T7, groups):
    """T7 has shape (p,)*7. groups is a partition like [[0,1],[2,3,4],[5,6]].
    Returns T3 of shape (p^|g0|, p^|g1|, p^|g2|).
    """
    perm = tuple(g for grp in groups for g in grp)
    T_perm = np.transpose(T7, perm)
    p = T7.shape[0]
    sizes = [p ** len(g) for g in groups]
    return T_perm.reshape(sizes)


def flatten_ranks_mod_p(T3, p):
    """Compute rank over F_p of the three matricizations of T3."""
    s = T3.shape
    M0 = T3.reshape(s[0], s[1] * s[2])
    M1 = T3.transpose(1, 0, 2).reshape(s[1], s[0] * s[2])
    M2 = T3.transpose(2, 0, 1).reshape(s[2], s[0] * s[1])
    return rank_mod_p(M0, p), rank_mod_p(M1, p), rank_mod_p(M2, p)


def rank_mod_p(M, p):
    """Row reduce M (numpy 2D array) over F_p, return rank."""
    M = M.copy().astype(np.int64) % p
    rows, cols = M.shape
    r = 0
    for c in range(cols):
        # find pivot
        piv = -1
        for i in range(r, rows):
            if M[i, c] % p != 0:
                piv = i
                break
        if piv == -1:
            continue
        M[[r, piv]] = M[[piv, r]]
        # normalize
        inv = pow(int(M[r, c]) % p, p - 2, p)
        M[r] = (M[r] * inv) % p
        for i in range(rows):
            if i != r and M[i, c] % p != 0:
                M[i] = (M[i] - M[i, c] * M[r]) % p
        r += 1
        if r == rows:
            break
    return r


def main():
    results = []
    for p in [3, 5]:
        print(f"\n=== p = {p} ===")
        t0 = time.time()
        T7 = build_indicator_tensor(p)
        dt = time.time() - t0
        nnz = int(T7.sum())
        print(f"Built I_PCP tensor (shape={T7.shape}), nnz={nnz}, in {dt:.2f}s")

        # Try partitions into 3 groups
        partitions = [
            [[0], [1], [2, 3, 4, 5, 6]],          # {a}, {b}, rest
            [[0, 3], [1, 4], [2, 5, 6]],           # {a,d}, {b,e}, {c,f,g}
            [[0, 3], [1, 2, 4], [5, 6]],
            [[0, 1], [2, 3, 4], [5, 6]],
            [[0, 1, 2], [3, 4, 5], [6]],
            [[0, 1, 2], [3], [4, 5, 6]],
            [[0, 6], [1, 4], [2, 3, 5]],
        ]
        part_results = []
        for groups in partitions:
            T3 = flatten_to_3tensor(T7, groups)
            shape = T3.shape
            r0, r1, r2 = flatten_ranks_mod_p(T3, p)
            slr_ub = min(r0, r1, r2)
            print(f"  partition {groups} → 3-tensor shape {shape}; "
                  f"flatten ranks=({r0},{r1},{r2}), slice rank ≤ {slr_ub}")
            part_results.append({
                "groups": groups,
                "shape": list(shape),
                "flatten_ranks": [int(r0), int(r1), int(r2)],
                "slice_rank_upper_bound": int(slr_ub),
            })
        results.append({
            "p": p,
            "indicator_nnz": nnz,
            "p7": p ** 7,
            "partitions": part_results,
        })
    OUT_JSON.write_text(json.dumps(results, indent=2))
    print(f"\nWritten: {OUT_JSON}")


if __name__ == "__main__":
    main()

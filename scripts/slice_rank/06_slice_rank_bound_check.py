#!/usr/bin/env python3
"""
06_slice_rank_bound_check.py

Croot-Lev-Pach machinery summary:
For a 3-tensor T : X x Y x Z -> F_p with T(x,y,z) = δ_{x+y+z=0} (where X=Y=Z=F_p^n),
the diagonal {(x,x,x) : x in S} = S, and slice rank of T restricted to S^3 is ≥ |S|.
This gives |S| ≤ slice rank of T_{S x S x S} ≤ slice rank of T ≤ 3 * (# mons of deg ≤ d).

For PCP we have a 7-tensor (not 3-tensor), and the "diagonal trick" doesn't
apply because the PCP equations are not in the "x + y + z = 0" form on a
product of *single* coordinates.

Question: can we use a CLP-type bound at all? We try the following encoding:
view the indicator as a function of three coordinate groups
   X = (a, b, d) ∈ F_p^3
   Y = (c, e, f) ∈ F_p^3
   Z = g ∈ F_p
Then the four equations:
   a^2 + b^2 = d^2   (depends only on X)
   b^2 + c^2 = e^2   (mixes X, Y)
   a^2 + c^2 = f^2   (mixes X, Y)
   a^2 + b^2 + c^2 = g^2  (mixes X, Y, Z)
The indicator factors:
   I_PCP(X, Y, Z) = I_X(X) * I_XY(X, Y) * I_Z|XY(X, Y, Z)
where I_Z|XY = [g^2 = a^2+b^2+c^2].

This doesn't immediately decompose. But: # solutions = sum over (X,Y) on a 6-tuple
of N_Z(X,Y) where N_Z ∈ {0,1,2} depending on whether a^2+b^2+c^2 is a QR.

We compute the *exact* slice rank for the 3-tensor of shape (p^3, p^3, p)
encoding I_PCP(X,Y,Z), for small p.

Slice rank computation via the greedy algorithm: too expensive for general
3-tensors. But the FLATTENING rank (the matrix rank of one unfolding) is an
upper bound. We already saw flatten ranks of size 7-13 for p=5. Below we
report tighter analysis.
"""

import numpy as np
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from importlib import import_module
m03 = import_module('03_slice_rank')
import time


def slice_rank_greedy_upper_bound(T3, p, max_iters=200):
    """A greedy heuristic for slice rank upper bound.
    Repeatedly:
      - pick the matricization with smallest max non-zero row support.
      - subtract its dominant rank-1 part.
    Return # rank-1 terms used."""
    T = T3.copy().astype(np.int64) % p
    rank_count = 0
    while np.any(T % p) and rank_count < max_iters:
        # try each direction; pick the one whose 1-flatten has lowest rank already
        s = T.shape
        flats = [T.reshape(s[0], s[1] * s[2]),
                 T.transpose(1, 0, 2).reshape(s[1], s[0] * s[2]),
                 T.transpose(2, 0, 1).reshape(s[2], s[0] * s[1])]
        # rank each
        ranks = [m03.rank_mod_p(F, p) for F in flats]
        # pick direction with smallest rank
        direction = int(np.argmin(ranks))
        F = flats[direction]
        # find first nonzero row, then find a column for pivot
        rows = F.shape[0]
        cols = F.shape[1]
        pivot_row = -1
        for i in range(rows):
            if np.any(F[i] % p):
                pivot_row = i
                break
        if pivot_row == -1:
            break
        pivot_col = -1
        for j in range(cols):
            if F[pivot_row, j] % p:
                pivot_col = j
                break
        # Subtract slice: F[pivot_row, :] times indicator of pivot_row
        # Slice rank: T -= e_pivot_row ⊗ F[pivot_row, :]
        # In tensor form, set the pivot slice along direction to zero, but use F[pivot_row,:]
        # as the row vector.
        # Reconstruct tensor update
        row_vec = F[pivot_row].copy() % p
        # Subtract from T: along direction, slice index = pivot_row, all others contribute.
        # In F (the flattening), zero out row pivot_row.
        F_new = F.copy()
        F_new[pivot_row] = 0
        # Unflatten back
        if direction == 0:
            T_new = F_new.reshape(s[0], s[1], s[2])
        elif direction == 1:
            T_new = F_new.reshape(s[1], s[0], s[2]).transpose(1, 0, 2)
        else:
            T_new = F_new.reshape(s[2], s[0], s[1]).transpose(1, 2, 0)
        T = T_new % p
        rank_count += 1
    return rank_count, (not np.any(T % p))


def main():
    print("Slice rank upper bounds (greedy + flatten):")
    for p in [3, 5]:
        T7 = m03.build_indicator_tensor(p)
        # Partition: X=(a,b,d), Y=(c,e,f), Z=(g) — indices [0,1,3], [2,4,5], [6]
        groups = [[0, 1, 3], [2, 4, 5], [6]]
        T3 = m03.flatten_to_3tensor(T7, groups)
        print(f"\np={p}: shape {T3.shape}, nnz = {int(T3.sum())}")
        # flatten ranks
        r0, r1, r2 = m03.flatten_ranks_mod_p(T3, p)
        print(f"  flatten ranks: ({r0}, {r1}, {r2}) → slice rank ≤ {min(r0,r1,r2)}")
        # greedy
        t0 = time.time()
        gr, ok = slice_rank_greedy_upper_bound(T3, p, max_iters=300)
        dt = time.time() - t0
        print(f"  greedy slice rank upper bound: {gr} (in {dt:.2f}s); zeroed? {ok}")

        # Conclusion: # V_p = sum over (X,Y,Z) of T3(X,Y,Z) = sum over rank-1 components.
        # CLP-style bound: # solutions ≤ 3 × (max layer sum). But this is generally
        # a much weaker bound than p^3 for our case — let's just record.

        # Also: another partition Y=(c,d), X=(a,b), Z=(e,f,g) — see if better
        groups2 = [[0, 1], [2, 3], [4, 5, 6]]
        T3b = m03.flatten_to_3tensor(T7, groups2)
        r0, r1, r2 = m03.flatten_ranks_mod_p(T3b, p)
        print(f"  alt partition {groups2}: shape {T3b.shape}, flatten ranks ({r0},{r1},{r2})")
        # 7-permutation symmetry: try all "1 var vs 1 var vs 5 vars" partitions
        best = (None, 10**9)
        for i in range(7):
            for j in range(7):
                if j <= i:
                    continue
                rest = [k for k in range(7) if k != i and k != j]
                gs = [[i], [j], rest]
                T3c = m03.flatten_to_3tensor(T7, gs)
                ra, rb, rc = m03.flatten_ranks_mod_p(T3c, p)
                m = min(ra, rb, rc)
                if m < best[1]:
                    best = (gs, m)
        print(f"  best (1,1,5) split: groups={best[0]}, slice rank UB = {best[1]}")


if __name__ == "__main__":
    main()

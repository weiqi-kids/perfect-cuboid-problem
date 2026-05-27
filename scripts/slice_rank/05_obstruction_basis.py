#!/usr/bin/env python3
"""
05_obstruction_basis.py

Find an explicit basis for the *new* polynomials that vanish on V_p but not
on W_p, at each degree. Look for nontrivial PCP-specific obstructions
beyond the obvious 4 equations.

The 4 obvious quadrics generate an ideal; modulo that ideal, are there any
new low-degree relations?
"""

import numpy as np
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from importlib import import_module
m04 = import_module('04_polynomial_obstruction')

NVARS = 7
VAR_NAMES = ['a', 'b', 'c', 'd', 'e', 'f', 'g']


def mon_str(e):
    parts = []
    for i, ei in enumerate(e):
        if ei == 0:
            continue
        if ei == 1:
            parts.append(VAR_NAMES[i])
        else:
            parts.append(f"{VAR_NAMES[i]}^{ei}")
    return "1" if not parts else "*".join(parts)


def poly_str(vec, mons, p):
    """Convert kernel vector to a readable polynomial string mod p."""
    terms = []
    for j, c in enumerate(vec):
        c = int(c) % p
        if c == 0:
            continue
        ms = mon_str(mons[j])
        if ms == "1":
            terms.append(f"{c}")
        elif c == 1:
            terms.append(ms)
        elif c == p - 1:
            terms.append(f"-{ms}")
        else:
            # Render as -k if c > p/2
            if c > p // 2:
                terms.append(f"-{p - c}*{ms}")
            else:
                terms.append(f"{c}*{ms}")
    return " + ".join(terms) if terms else "0"


def kernel_basis(M, p):
    """Return basis of null space of M over F_p. M is (rows, cols).
       Returns list of column-vectors (each length cols).
    """
    M = M.copy().astype(np.int64) % p
    rows, cols = M.shape
    # Row-reduce to RREF
    pivot_cols = []
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
        pivot_cols.append(c)
        r += 1
        if r == rows:
            break
    # Free columns are those not in pivot_cols
    free_cols = [c for c in range(cols) if c not in set(pivot_cols)]
    basis = []
    for fc in free_cols:
        vec = np.zeros(cols, dtype=np.int64)
        vec[fc] = 1
        # For each pivot row, set basis vec[pivot_col] = -(M[row, fc])
        for ri, pc in enumerate(pivot_cols):
            vec[pc] = (-int(M[ri, fc])) % p
        basis.append(vec)
    return basis, pivot_cols


def analyze_diff(p, deg):
    V = m04.gen_V(p)
    W = m04.gen_W(p)
    mons = m04.monomials_up_to(deg, p)
    Mv = m04.eval_monomials(V, mons, p)
    Mw = m04.eval_monomials(W, mons, p)
    # Compute basis for ker(E_V) and ker(E_W).
    kerV, _ = kernel_basis(Mv, p)
    kerW, _ = kernel_basis(Mw, p)
    print(f"\np={p}, deg≤{deg}: dim ker(V)={len(kerV)}, dim ker(W)={len(kerW)}")
    # Find PCP-specific subspace: ker(V) / ker(W).
    # I.e. project ker(V) modulo span(ker(W)). Each kerW vec extended to len(mons).
    # Implementation: stack kerW as rows of a matrix and reduce, then reduce kerV vectors mod kerW.
    if not kerW:
        kerW_mat = np.zeros((0, len(mons)), dtype=np.int64)
    else:
        kerW_mat = np.stack(kerW, axis=0) % p
    # Row-reduce kerW_mat
    kw = kerW_mat.copy()
    rows, cols = kw.shape
    rr = 0
    piv_cols_kw = []
    for c in range(cols):
        piv = -1
        for i in range(rr, rows):
            if kw[i, c] % p != 0:
                piv = i
                break
        if piv == -1:
            continue
        kw[[rr, piv]] = kw[[piv, rr]]
        inv = pow(int(kw[rr, c]) % p, p - 2, p)
        kw[rr] = (kw[rr] * inv) % p
        for i in range(rows):
            if i != rr and kw[i, c] % p != 0:
                kw[i] = (kw[i] - kw[i, c] * kw[rr]) % p
        piv_cols_kw.append(c)
        rr += 1
        if rr == rows:
            break
    # Reduce each kerV vector against kw
    new_basis = []
    for v in kerV:
        v = v.copy() % p
        for ri, pc in enumerate(piv_cols_kw):
            if v[pc] % p != 0:
                v = (v - int(v[pc]) * kw[ri]) % p
        if np.any(v % p):
            new_basis.append(v)
    # Now new_basis might still have redundancies; do Gaussian elimination.
    if not new_basis:
        print("  No PCP-specific obstructions.")
        return []
    NB = np.stack(new_basis, axis=0) % p
    rows, cols = NB.shape
    rr = 0
    piv_cols = []
    for c in range(cols):
        piv = -1
        for i in range(rr, rows):
            if NB[i, c] % p != 0:
                piv = i
                break
        if piv == -1:
            continue
        NB[[rr, piv]] = NB[[piv, rr]]
        inv = pow(int(NB[rr, c]) % p, p - 2, p)
        NB[rr] = (NB[rr] * inv) % p
        for i in range(rows):
            if i != rr and NB[i, c] % p != 0:
                NB[i] = (NB[i] - NB[i, c] * NB[rr]) % p
        piv_cols.append(c)
        rr += 1
    reduced = [NB[i] for i in range(rr)]
    print(f"  PCP-specific obstructions: {len(reduced)} relations")
    for v in reduced:
        s = poly_str(v, mons, p)
        # truncate display
        if len(s) < 220:
            print(f"     {s}")
        else:
            print(f"     {s[:200]} ... (len {len(s)})")
    return reduced


def main():
    print("Searching PCP-specific obstructions (those vanishing on V but not on Euler-brick W)")
    print("=" * 80)
    for p in [3, 5]:
        for d in [2, 3, 4]:
            analyze_diff(p, d)


if __name__ == "__main__":
    main()

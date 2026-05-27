#!/usr/bin/env python3
"""
02_indicator_degree.py

For each small prime p, build the indicator polynomial I_PCP : F_p^7 -> {0,1}
that is 1 iff the 7-tuple satisfies all 4 PCP equations.

Strategy: I_PCP is a product of 4 indicator polynomials, one per equation:
    I_eq(x,y,z) = 1 iff x^2 + y^2 = z^2  (over F_p)
              = 1 - (x^2+y^2-z^2)^{p-1}    (using Fermat)
Then I_PCP = I_1 * I_2 * I_3 * I_4. Each factor has degree 2(p-1), total
degree ≤ 8(p-1) — way more than 7(p-1), so trivial.

But the *per-variable* degree of I_PCP is at most p-1 in each var (since we
can reduce mod x_i^p - x_i). We compute:
  - The polynomial of degree ≤ p-1 in each var that agrees with I_PCP on F_p^7.
  - Its total degree
  - The min degree we'd need a vanishing polynomial Q to have
    (i.e. low-degree polynomial obstruction).

For small p this is feasible by direct expansion.

Slice rank: For a function f : F_p^n -> F_p of degree ≤ d, slice_rank(f) ≤
            #{monomials of degree ≤ d in n variables}.
"""

import itertools
import json
from pathlib import Path
from collections import Counter

OUTDIR = Path(__file__).parent
OUT_JSON = OUTDIR / "02_indicator_degree.json"


def poly_mul_modp_modreduce(P, Q, p, nvars):
    """Multiply two polys (dict: exponent-tuple -> coeff) mod p, then reduce
       x_i^p -> x_i (since x^p = x in F_p for any x in F_p; so as a function
       polynomial of *minimal* degree per variable is ≤ p-1).
    """
    R = {}
    for ea, ca in P.items():
        for eb, cb in Q.items():
            e = tuple(ea[i] + eb[i] for i in range(nvars))
            c = (ca * cb) % p
            if c == 0:
                continue
            R[e] = (R.get(e, 0) + c) % p
            if R[e] == 0:
                del R[e]
    return reduce_mod_field(R, p, nvars)


def reduce_mod_field(P, p, nvars):
    """Reduce exponents using x_i^p = x_i (as functions on F_p)."""
    out = {}
    for e, c in P.items():
        new_e = tuple(((ei - 1) % (p - 1)) + 1 if ei > 0 else 0 for ei in e)
        # Above is wrong; correct rule: for ei > 0, replace ei by 1 + ((ei-1) mod (p-1))
        # That maps p -> 1, p+1 -> 2, ..., 2p-2 -> p-1, 2p-1 -> 1, etc. Good.
        out[new_e] = (out.get(new_e, 0) + c) % p
        if out[new_e] == 0:
            del out[new_e]
    return out


def poly_from_term(coef, exps):
    return {tuple(exps): coef % 1000003}  # not used directly


def indicator_one_eq_x2_y2_z2(p, vars_idx, nvars):
    """Indicator of x^2 + y^2 = z^2 where x,y,z are vars at given indices in
       an nvars-variable polynomial.
       I(x,y,z) = 1 - (x^2 + y^2 - z^2)^{p-1}   over F_p
    """
    # First build P = x^2 + y^2 - z^2
    P = {}
    e = [0] * nvars
    e[vars_idx[0]] = 2
    P[tuple(e)] = 1
    e = [0] * nvars
    e[vars_idx[1]] = 2
    P[tuple(e)] = 1
    e = [0] * nvars
    e[vars_idx[2]] = 2
    P[tuple(e)] = (p - 1) % p  # -1
    # Compute P^{p-1} mod p, reducing as functions on F_p^nvars
    R = {tuple([0] * nvars): 1}
    for _ in range(p - 1):
        R = poly_mul_modp_modreduce(R, P, p, nvars)
    # I = 1 - P^{p-1}
    one = {tuple([0] * nvars): 1}
    out = {}
    for e, c in one.items():
        out[e] = c
    for e, c in R.items():
        out[e] = (out.get(e, 0) - c) % p
        if out[e] == 0:
            del out[e]
    return reduce_mod_field(out, p, nvars)


def total_degree(P):
    return max((sum(e) for e in P), default=0)


def per_var_degree(P, nvars):
    return [max((e[i] for e in P), default=0) for i in range(nvars)]


def analyze(p):
    """7 vars: (a,b,c,d,e,f,g) = (0,1,2,3,4,5,6).
       Eq1: a^2+b^2=d^2   indices (0,1,3)
       Eq2: b^2+c^2=e^2   indices (1,2,4)
       Eq3: a^2+c^2=f^2   indices (0,2,5)
       Eq4: a^2+b^2+c^2=g^2   needs separate construction
    """
    nvars = 7
    print(f"\n--- p = {p} ---")
    I1 = indicator_one_eq_x2_y2_z2(p, (0, 1, 3), nvars)
    print(f"I1 size={len(I1)}, total deg={total_degree(I1)}, per-var deg={per_var_degree(I1, nvars)}")
    I2 = indicator_one_eq_x2_y2_z2(p, (1, 2, 4), nvars)
    print(f"I2 size={len(I2)}, total deg={total_degree(I2)}, per-var deg={per_var_degree(I2, nvars)}")
    I3 = indicator_one_eq_x2_y2_z2(p, (0, 2, 5), nvars)
    print(f"I3 size={len(I3)}, total deg={total_degree(I3)}, per-var deg={per_var_degree(I3, nvars)}")
    # Eq4: a^2+b^2+c^2-g^2 = 0
    # I4 = 1 - (a^2+b^2+c^2-g^2)^{p-1}
    P4 = {}
    for idx, sign in [(0, 1), (1, 1), (2, 1), (6, p - 1)]:
        e = [0] * nvars
        e[idx] = 2
        P4[tuple(e)] = sign
    R4 = {tuple([0] * nvars): 1}
    for _ in range(p - 1):
        R4 = poly_mul_modp_modreduce(R4, P4, p, nvars)
    I4 = {tuple([0] * nvars): 1}
    for e, c in R4.items():
        I4[e] = (I4.get(e, 0) - c) % p
        if I4[e] == 0:
            del I4[e]
    I4 = reduce_mod_field(I4, p, nvars)
    print(f"I4 size={len(I4)}, total deg={total_degree(I4)}, per-var deg={per_var_degree(I4, nvars)}")

    # Full indicator I = I1*I2*I3*I4
    I12 = poly_mul_modp_modreduce(I1, I2, p, nvars)
    print(f"I12 size={len(I12)}, total deg={total_degree(I12)}")
    I123 = poly_mul_modp_modreduce(I12, I3, p, nvars)
    print(f"I123 size={len(I123)}, total deg={total_degree(I123)}")
    I_full = poly_mul_modp_modreduce(I123, I4, p, nvars)
    td = total_degree(I_full)
    pvd = per_var_degree(I_full, nvars)
    print(f"I_PCP size={len(I_full)} total deg={td}, per-var deg={pvd}")
    # Compare: trivial upper-bound for any function on F_p^7 is per-var degree ≤ p-1,
    # total degree ≤ 7(p-1).
    print(f"  Trivial bounds: per-var ≤ {p-1}, total ≤ {7*(p-1)}")

    return {
        "p": p,
        "I_PCP_num_monomials": len(I_full),
        "I_PCP_total_degree": td,
        "I_PCP_per_var_degrees": pvd,
        "trivial_per_var_max": p - 1,
        "trivial_total_max": 7 * (p - 1),
    }


def main():
    results = []
    for p in [3, 5, 7]:
        r = analyze(p)
        results.append(r)
    OUT_JSON.write_text(json.dumps(results, indent=2))
    print(f"\nWritten: {OUT_JSON}")


if __name__ == "__main__":
    main()

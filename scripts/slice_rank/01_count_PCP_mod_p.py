#!/usr/bin/env python3
"""
01_count_PCP_mod_p.py

Count exactly |V_p(F_p)| for the PCP variety:
    a^2 + b^2 = d^2
    b^2 + c^2 = e^2
    a^2 + c^2 = f^2
    a^2 + b^2 + c^2 = g^2

over F_p, where (a,b,c,d,e,f,g) in F_p^7.

The trivial bound from 4 generic quadrics in 7 vars is p^3.
We report exact counts and log_p ratio.

Strategy:
- Loop over (a,b,c) in F_p^3 (p^3 triples).
- For each triple, compute s1 = a^2+b^2, s2 = b^2+c^2, s3 = a^2+c^2, s4 = a^2+b^2+c^2.
- Count #{d : d^2 = s1} * #{e : e^2=s2} * #{f : f^2=s3} * #{g : g^2=s4}.
- Each factor is 1 if s = 0, 2 if s is a nonzero QR, 0 otherwise.
"""

import sys
import time
import json
from pathlib import Path

OUTDIR = Path(__file__).parent
OUT_JSON = OUTDIR / "01_pcp_counts.json"
OUT_TXT = OUTDIR / "01_pcp_counts.txt"


def count_sqrt(s, qr_set, p):
    """Number of x in F_p with x^2 = s."""
    if s == 0:
        return 1
    if s in qr_set:
        return 2
    return 0


def count_pcp_mod_p(p):
    """Exact count |V_p(F_p)|."""
    # QR table
    qr_set = set()
    for x in range(1, p):
        qr_set.add((x * x) % p)
    # Loop
    total = 0
    for a in range(p):
        a2 = (a * a) % p
        for b in range(p):
            b2 = (b * b) % p
            s1 = (a2 + b2) % p
            n1 = count_sqrt(s1, qr_set, p)
            if n1 == 0:
                continue
            for c in range(p):
                c2 = (c * c) % p
                s2 = (b2 + c2) % p
                n2 = count_sqrt(s2, qr_set, p)
                if n2 == 0:
                    continue
                s3 = (a2 + c2) % p
                n3 = count_sqrt(s3, qr_set, p)
                if n3 == 0:
                    continue
                s4 = (a2 + b2 + c2) % p
                n4 = count_sqrt(s4, qr_set, p)
                if n4 == 0:
                    continue
                total += n1 * n2 * n3 * n4
    return total


def count_euler_brick_mod_p(p):
    """Count Euler brick variety (only first 3 equations: 3 face diagonals)."""
    qr_set = set()
    for x in range(1, p):
        qr_set.add((x * x) % p)
    total = 0
    for a in range(p):
        a2 = (a * a) % p
        for b in range(p):
            b2 = (b * b) % p
            s1 = (a2 + b2) % p
            n1 = count_sqrt(s1, qr_set, p)
            if n1 == 0:
                continue
            for c in range(p):
                c2 = (c * c) % p
                s2 = (b2 + c2) % p
                n2 = count_sqrt(s2, qr_set, p)
                if n2 == 0:
                    continue
                s3 = (a2 + c2) % p
                n3 = count_sqrt(s3, qr_set, p)
                if n3 == 0:
                    continue
                total += n1 * n2 * n3 * p  # g is free in 1 variable (no constraint)
                # Wait — Euler brick has 3 equations, 6 vars (a,b,c,d,e,f). To compare apples to
                # apples we want same ambient F_p^7 (add free g). So multiply by p.
    return total


def count_pcp_face_diagonals_only(p):
    """Three face diagonals: a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2.
       Six variables; we count |W_p| in F_p^6 (no g)."""
    qr_set = set()
    for x in range(1, p):
        qr_set.add((x * x) % p)
    total = 0
    for a in range(p):
        a2 = (a * a) % p
        for b in range(p):
            b2 = (b * b) % p
            s1 = (a2 + b2) % p
            n1 = count_sqrt(s1, qr_set, p)
            if n1 == 0:
                continue
            for c in range(p):
                c2 = (c * c) % p
                s2 = (b2 + c2) % p
                n2 = count_sqrt(s2, qr_set, p)
                if n2 == 0:
                    continue
                s3 = (a2 + c2) % p
                n3 = count_sqrt(s3, qr_set, p)
                if n3 == 0:
                    continue
                total += n1 * n2 * n3
    return total


def count_space_diag_only(p):
    """Just a^2+b^2+c^2=g^2. F_p^4."""
    qr_set = set()
    for x in range(1, p):
        qr_set.add((x * x) % p)
    total = 0
    for a in range(p):
        a2 = (a * a) % p
        for b in range(p):
            b2 = (b * b) % p
            for c in range(p):
                c2 = (c * c) % p
                s = (a2 + b2 + c2) % p
                total += count_sqrt(s, qr_set, p)
    return total


def main():
    import math
    primes = [3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
    results = []
    print(f"{'p':>3} {'|V_p|':>10} {'p^3':>10} {'|V_p|/p^3':>10} {'log_p|V_p|':>12} "
          f"{'|W_p|(3eq)':>11} {'|U_p|(spc)':>11}")
    print("-" * 80)
    for p in primes:
        t0 = time.time()
        Vp = count_pcp_mod_p(p)
        Wp = count_pcp_face_diagonals_only(p)
        Up = count_space_diag_only(p)
        dt = time.time() - t0
        logp = math.log(Vp) / math.log(p) if Vp > 0 else float('nan')
        ratio = Vp / (p ** 3)
        print(f"{p:>3} {Vp:>10} {p**3:>10} {ratio:>10.4f} {logp:>12.4f} "
              f"{Wp:>11} {Up:>11}  ({dt:.2f}s)")
        results.append({
            "p": p,
            "V_p": Vp,
            "p3": p ** 3,
            "ratio": ratio,
            "log_p_Vp": logp,
            "W_p_3eq": Wp,
            "U_p_spc_diag": Up,
            "elapsed_sec": dt,
        })
    OUT_JSON.write_text(json.dumps(results, indent=2))
    lines = ["p\t|V_p|\tp^3\tratio\tlog_p|V_p|\t|W_p|\t|U_p|"]
    for r in results:
        lines.append(f"{r['p']}\t{r['V_p']}\t{r['p3']}\t{r['ratio']:.4f}\t"
                     f"{r['log_p_Vp']:.4f}\t{r['W_p_3eq']}\t{r['U_p_spc_diag']}")
    OUT_TXT.write_text("\n".join(lines))
    print(f"\nWritten: {OUT_JSON}\n         {OUT_TXT}")


if __name__ == "__main__":
    main()

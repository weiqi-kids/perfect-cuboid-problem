---
title: PCP — 2-Isogenous Descent on E_Hm for the (61,38) Borderline Fiber
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: PARTIAL — 2-isogeny class fully traversed (8 curves), no generator found on any curve; rank gap rk(E_Hm) ∈ [0, 2] UNCHANGED. Magma 4-descent still required.
---

# 2-Isogenous Descent on E_Hm for the (61, 38) Borderline Fiber

**Author:** CΛ / Lightman Chang · Independent Researcher · 2026-05-18

## §1. Context

`BORDERLINE-61-38-SHARPEN.md` recorded that for the (61, 38) BEYOND-QC
genus-2 fiber, the second elliptic factor of `J(H_q)` is

```
E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410,
                103564307677747011646913552825626935447972])
```

with conductor `N(E_Hm) = 148 190 386 641 437 910 ≈ 1.48 · 10¹⁷`
(`log₁₀ N ≈ 17.171`), torsion `Z/8 × Z/2`, and `ellrank(·, 4)` returning
`r ∈ [0, 2]`. The global root number is `w(E_Hm) = +1`, so the analytic
rank is even — consistent with both `r = 0` and `r = 2`.

If `r(E_Hm) = 0`, total `rk J(H_q) = 3 = g + ρ − 1` and Stoll's
genus-2 Chabauty bound is reached with margin 0 (QCMod tractable).
If `r(E_Hm) = 2`, total rank is 5 > 3 and the genus-2 shortcut fails.
This note documents the 2-isogenous descent attempt to sharpen the
gap to a single value.

## §2. Method

**Tool:** PARI/GP 2.15.4, `ellisomat(E_Hm, 2)` to enumerate the full
2-isogeny class, then `ellrank(E'_k, 5)` (timeout 600 s) on each curve
in the class. If a non-torsion generator is found on any `E'_k`,
push it back via the recorded dual isogeny `φ̂ : E'_k → E_Hm`
(`iso[1][k][3]` in PARI), verify membership with `ellisoncurve`,
and confirm positive canonical height.

A generator on any `E'_k` forces `rk(E_Hm) ≥ 1`. Combined with
parity (`w = +1`), this would force `rk(E_Hm) = 2` exactly.

## §3. The 2-isogeny class

`ellisomat(E_Hm, 2)` returns **8 curves** (richer than the typical
≤ 6 — `E_Hm` has multiple 2-torsion classes producing 2² × 2 = 8
isogenous curves). The isogeny-degree matrix is

```
[1, 2, 2, 2, 4, 4, 8, 8;
 2, 1, 4, 4, 8, 8, 16, 16;
 2, 4, 1, 4, 8, 8, 16, 16;
 2, 4, 4, 1, 2, 2,  4,  4;
 4, 8, 8, 2, 1, 4,  8,  8;
 4, 8, 8, 2, 4, 1,  2,  2;
 8,16,16, 4, 8, 2,  1,  4;
 8,16,16, 4, 8, 2,  4,  1]
```

All eight curves share the conductor `N = 1.481 · 10¹⁷`
(isogenous curves over `Q` have equal conductors; ✓ consistency
check). Their minimal-model `[a₁,a₂,a₃,a₄,a₆]` are recorded in
`scripts/genus2/isogeny_descent_61_38.out`.

## §4. Per-curve results

`ellrank(E'_k, 5)` output is `[r_lo, r_hi, s, L]` with
`s` encoding 2-Sha visibility and `L` the list of independent
non-torsion rational points found.

| k | Torsion         | r_lo | r_hi | s | n_gens | wall (s) |
|---|-----------------|------|------|---|--------|----------|
| 1 | `Z/8 × Z/2`     | 0    | 2    | 0 | 0      | 2.66     |
| 2 | `Z/8`           | 0    | 2    | 4 | 0      | 1.41     |
| 3 | `Z/8`           | 0    | 2    | 2 | 0      | 1.00     |
| 4 | `Z/4 × Z/2`     | 0    | 2    | 0 | 0      | 0.51     |
| 5 | `Z/4`           | 0    | 2    | 2 | 0      | 0.60     |
| 6 | `Z/2 × Z/2`     | 0    | 2    | 4 | 0      | 0.70     |
| 7 | `Z/2`           | 0    | 6    | 2 | 0      | 1.02     |
| 8 | `Z/2`           | 0    | 6    | 0 | 0      | 0.85     |

`E'_1` is `E_Hm` itself (consistent with the earlier
`ellrank` effort 4 → `[0, 2]`; effort 5 confirms with no new gen).

**No generator was returned on any of the 8 curves.** Hence the
push-back step (via `ellisogenyapply(iso[1][k][3], P)` + `ellisoncurve`)
was never executed — there is no point to map.

**ellanalyticrank** was conditionally attempted only for
`N(E'_k) < 10¹⁵`; since all 8 isogenous curves share
`N = 1.48·10¹⁷`, no analytic-rank call was made (consistent with the
PARI-intractability noted in `BORDERLINE-61-38-SHARPEN.md` §3).

## §5. Interpretation

The `[r_hi]` column shows two patterns:

- **Curves with `Z/8`, `Z/4·×Z/2`, `Z/2·×Z/2`, `Z/4` 2-torsion (k = 1..6)**
  yield `r_hi = 2` — same as `E_Hm` itself. 2-descent is fully
  effective on these curves (rich rational 2-torsion gives complete
  visibility of φ-Selmer / φ̂-Selmer).
- **Curves with only `Z/2` torsion (k = 7, 8)** yield `r_hi = 6` —
  weaker because the φ-isogeny on these curves is a degree-2 isogeny
  whose kernel is the unique 2-torsion point; 2-descent on a curve
  with only `Z/2` torsion can typically only bound rk by Sel_2(E)
  whose 2-rank scales as `dim φ-Selmer + dim φ̂-Selmer − 2`.

Since `r_lo = 0` everywhere, none of the 8 curves admits an explicit
non-torsion point with effort 5 (which performs 4-descent on a sub-locus
when 2-descent is conclusive on rank ≤ 2). The remaining gap is
**Sha[2]**: it is consistent with all 8 isogenous curves having
non-trivial 2-Sha (so that `r = 0` but the 2-Selmer rank reads as 2).

## §6. Verdict

> **rk(E_Hm) ∈ [0, 2] remains UNCHANGED after 2-isogenous descent.**

A `r = 1` (forcing `r = 2` by parity) hypothesis is consistent with
the data (an explicit non-torsion point exists but no 2-descent or
4-descent witness has surfaced); equally, `r = 0` (with Sha[2] of
F₂-rank 2 on E_Hm) is consistent.

**What still works:**

1. **Magma `FourDescent`** on `E_Hm` or any of the 8 isogenous curves —
   would resolve the φ-Selmer / Sha[φ] gap completely. Estimated
   runtime ~8 h at `N ≈ 10¹⁷`.
2. **Magma `EightDescent`** if 4-descent reduces but does not close.
3. **Heegner-point construction** at this conductor scale
   (non-trivial but feasible — requires Heegner discriminant `D` with
   `(D, N) = 1` and a class-number-tractable imaginary quadratic).
4. **CUBIC-CHABAUTY route** (already implemented in
   `CUBIC-CHABAUTY-BRAUER-5.md` §2.2) closes (61, 38) anyway via
   `V_q` with `δ_3 ≈ 30+` margin for `r_hi(J(V_q)) = 13`. So
   (61, 38) is unambiguously **NOT** lost; the genus-2 shortcut
   is just not available.

## §7. Files

- `scripts/genus2/isogeny_descent_61_38.gp` — full driver (PARI/GP)
- `scripts/genus2/isogeny_descent_61_38.out` — output (all 8 curves
  + per-curve `ellrank` results and SUMMARY)

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher,
lightman.chang@gmail.com — 2026-05-18.

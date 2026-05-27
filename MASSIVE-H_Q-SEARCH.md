---
title: PCP — Massive H_q Pass-A Direct Search at B = 10⁷ on the 4 Remaining BEYOND-QC Fibers
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: COMPUTATIONAL REPORT (PARI/GP 2.15.4) — strengthens GENUS2-QUOTIENT-5.md §5 empirical certification by factor 200×
---

# Perfect Cuboid Problem
## Massive Direct Search on the Hyperelliptic Quotient `H_q`
## (Integer-X Pass A at B = 10⁷, 4 BEYOND-QC fibers)

**Author**: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com
**Date**: 2026-05-18

---

## §1 What this document upgrades

`GENUS2-QUOTIENT-5.md` §5 ran an integer-`X` search on the
hyperelliptic integer model

```
H_q^Z : Y² = (X² + d²)(X² + p²)(X² + w²),   (d, p, w) = (m²−n², 2mn, m²+n²)
```

up to `|X| ≤ 50 000` for all 5 BEYOND-QC fibers, finding only the
degenerate baseline `(X, Y) = (0, ±dpw)`. This document extends the
search to **`|X| ≤ 10⁷`**, a **factor 200×** in linear range (i.e.
the integer scan covers a 200× wider window of the hyperelliptic
model), on the 4 fibers that remain BEYOND-QC after the genus-2
re-routing of (99, 28) (see `GENUS2-QUOTIENT-5.md` §6).

The fractional-`X` Pass B (`X = a/b²` with `b > 1`) is reported as a
separate follow-up due to its `O(B · √B / log)` cost.

---

## §2 Methodology

For each fiber and each `X ∈ [1, 10⁷]`:

1. **9-prime QR sieve.** Pre-tabulate the residue map
   `r ↦ ((r² + d²)(r² + p²)(r² + w²) mod p)` for
   `p ∈ {5, 7, 11, 13, 17, 19, 23, 29, 31}`. A candidate `X` survives
   iff every residue is a quadratic residue (or 0) mod every sieve
   prime. This cuts the per-candidate `issquare` count by ~10–60×.
2. **Full `issquare`.** Survivors get the rigorous PARI `issquare(f(X))`.
   If true, the point `(X, Y)` is recorded for inspection.

Driver script: `scripts/genus2/massive_h_q_passA.gp`. PARI 2.15.4,
`default(parisize, 500000000)` (500 MB).

---

## §3 Results

### 3.1 Per-fiber table

| Fiber `(m, n)` | `(d, p, w)` | baseline `Y₀ = dpw` | QR survivors | hits | wall (s) |
|---|---|---|---:|:---:|---:|
| (61, 38) | (2 277, 4 636, 5 165) | 54 522 628 380 | 879 126 | **0** | 16.6 |
| (63, 38) | (2 525, 4 788, 5 413) | 65 441 546 100 | 510 810 | **0** | 18.3 |
| (73, 24) | (4 753, 3 504, 5 905) | 98 344 893 360 | 154 878 | **0** | 19.1 |
| (88, 35) | (6 519, 6 160, 8 969) | 360 168 491 760 | 277 885 | **0** | 20.2 |

Total wall time: **74.1 s** single-core. Total `issquare` calls
across all 4 fibers: **1 822 699**. Total non-degenerate integer
`X ∈ [1, 10⁷]` rational points: **0**.

### 3.2 Interpretation

For each of the 4 remaining BEYOND-QC fibers, no integer `X ∈ [1, 10⁷]`
yields a perfect square `f(X)`, beyond the degenerate baseline at
`X = 0`. Equivalently, the only rational points of `H_q^Z` with
**integer** `X`-coordinate and `|X| ≤ 10⁷` are the 2 affine
degenerate points `(0, ±dpw)` plus the 2 points at infinity
`[1 : ±1 : 0]`. **Empirically certified up to `|X| ≤ 10⁷`**.

This is **not** a proof: rational points with non-integer
`X = a/b²` (b > 1) are not covered by Pass A. The 4 known degenerate
points already have integer `X = 0`, so any *additional* rational
point — including a PCP candidate — would need to be exhibited
either at `X` integer (excluded up to 10⁷) or at fractional `X`
(covered in a future Pass B).

---

## §4 Comparison and consequence

| Document | bound on `|X|` | fibers covered | hits |
|---|---:|---|:---:|
| `GENUS2-QUOTIENT-5.md` §5 | 50 000 | 5 (incl. 99,28) | 0 |
| **this document** | **10⁷** | 4 (excl. 99,28) | **0** |

The strengthened bound `10⁷` gives a substantially stronger
empirical PCP-free statement on the integer locus of `H_q^Z` for the
4 still-BEYOND-QC fibers. Combined with the Track B 50-prime MW sieve
(`HARDENED-SIEVE-5.md`), the four fibers are now in the
**`|X| ≤ 10⁷` empirical + 50-prime rigorous-sieve closure** state.

For the closeable fiber (99, 28), no extension beyond
`GENUS2-QUOTIENT-5.md`'s `|X| ≤ 50 000` is necessary — the
forthcoming `QCMod` execution gives finite `H_q(Q)` directly.

---

## §5 Limitations (honest)

1. **Pass B (fractional `X`) not included.** A 1000-batch Pass B with
   `b ∈ [2, 1000]` was launched as part of the original effort but
   timed out at `b = 300/1000` on the first fiber. Pass B scaling is
   roughly `O(B · √B)` instead of `O(B)`, dominated by the
   `gcd(a, b) = 1 + issquare` inner loop.
2. **No height-bound rigour.** Empirical absence of integer points up
   to `|X| ≤ 10⁷` does **not** rule out points of larger height.
   Rigorous closure on these fibers still requires either cubic
   Chabauty (`CUBIC-CHABAUTY-PRELIM-5.md`) or a Brauer obstruction
   class beyond the trivial Hilbert candidates (`BRAUER-MANIN-LOCAL.md`).
3. **QR sieve coverage.** The sieve is exact, but its 9-prime panel
   means the survival rate scales as `(p/2)⁹ ≈ 2⁻⁹ ≈ 0.2%`. The four
   fibers' survival rates 1.5%, 5.1%, 8.8%, 2.8% are consistent with
   their differing `d, p, w` factorisations.

---

## §6 Reproducibility

| Step | Wall time | Output |
|---|---|---|
| Pass A driver run | 74 s | `scripts/genus2/massive_h_q_passA.out` |

Single PARI/GP 2.15.4 process, `parisize = 500 MB`. Deterministic.

---

## §7 Bottom line

* **No PCP found.** Four fibers extended to `|X| ≤ 10⁷` on the
  hyperelliptic quotient `H_q`, total ~1.8 million `issquare`
  evaluations after a 9-prime QR sieve filter; **zero**
  non-degenerate integer points discovered.
* **Strengthened empirical certification**: `|X| ≤ 10⁷` (vs prior
  `|X| ≤ 5·10⁴`). The known rational locus of `H_q^Z` for these 4
  fibers remains the 4-point baseline `{(0, ±dpw)} ∪ {[1:±1:0]}`.
* **Pass B (fractional X) and rigorous closure** remain TODO; the
  primary route is cubic Chabauty / `QCMod` cubic on a workstation.

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher,
lightman.chang@gmail.com — 2026-05-18.

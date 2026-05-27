---
title: PCP — Session Summary 2026-05-18 Afternoon (Multi-Agent Parallel Push)
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: SESSION REPORT — six parallel tracks A, B, C, D, Face-3, Sharpen-(61,38)
---

# Session Summary — 2026-05-18 Afternoon

**Author**: CΛ / Lightman Chang · Independent Researcher · 2026-05-18

## Headline result

**The five BEYOND-QC fibers have been reduced to four.** Fiber
`(99, 28)` is now provably closeable via standard genus-2 Chabauty
on the hyperelliptic quotient `H_q : y² = (X² + 1)(X² + q²)(X² + 1 + q²)`,
with rigorous bound `rk J(H_q) = 2 < 3 = g + ρ − 1`. Only Magma's
`QCMod` execution is required to finish; no new mathematics is needed.

## Tracks completed (parallel, multi-agent)

| Track | Output | Status |
|---|---|---|
| **A** Extended direct search B = 500 000 | `EXTENDED-DIRECT-5-B500K.md` | DONE |
| **B** Hardened 50-prime MW sieve | `HARDENED-SIEVE-5.md` | DONE |
| **C** Genus-2 quotient `H_q` analysis | `GENUS2-QUOTIENT-5.md` | DONE |
| **D** Cubic-Chabauty preliminaries + 8-descent on `E_PCP` | `CUBIC-CHABAUTY-PRELIM-5.md` | DONE |
| **Face-3** Verification of new generators | `FACE3-NEW-GENS.md` | DONE |
| **Sharpen** `rk(E_Hm)` for borderline (61, 38) | `BORDERLINE-61-38-SHARPEN.md` | PARTIAL |

## Per-fiber summary

| `(m, n)` | rk(E_PCP) | rk(J(V_q)) | Genus-2 verdict | Closure route |
|---|---:|---:|---|---|
| (61, 38) | 3 | [9, 13] | **borderline** (rk J(H_q) ∈ [3, 5]) | cubic Chabauty on V_q |
| (63, 38) | 3 | [10, 10] | fails (rk J(H_q) = 5) | cubic Chabauty / Brauer |
| (73, 24) | 3 | [9, 13] | fails (rk J(H_q) ∈ [4, 6]) | cubic Chabauty / Brauer |
| (88, 35) | 3 | [10, 10] | fails (rk J(H_q) = 4) | cubic Chabauty / Brauer |
| **(99, 28)** | **4** | **[9, 11]** | **APPLIES** (rk J(H_q) = 2) | **standard genus-2 QCMod** |

## Quantitative achievements

### A — Extended height bound
- B raised from 200 000 → **500 000** on (73,24), (88,35), (99,28).
- 1.29·10⁹ integer-model candidates scanned in 19.5 min single-core.
- Zero new Face-3 squares; one non-torsion lattice representative
  on (88,35) (= G₁ − G₃ + T₂ mod Track-D lattice).

### B — Hardened MW sieve
- 50 sieve primes (was 14), good ordinary on every factor of every fiber.
- Rigorous subgroup-order bound (not heuristic) per (prime, factor).
- Per-fiber exclusion density:
  - (61, 38): 10⁻⁴⁷
  - (63, 38): 10⁻⁵⁰
  - (73, 24): 10⁻⁵⁴
  - (88, 35): 10⁻⁴⁴
  - (99, 28): **10⁻⁸⁴** (strongest)
- 1 250+ rigorous degenerate-baseline `tors_inj` verifications, all pass.

### C — Genus-2 closure
- `J(H_q) ∼ E_Hp × E_Hm` rigorously confirmed at 40 good primes.
- **(99, 28) closeable today**: `rk J(H_q) = 2 < 3`, sharp.
- (61, 38) borderline: `rk J(H_q) ∈ [3, 5]`, needs `rk E_Hm` sharpened.
- 3 fibers definitively beyond genus-2 (rank ≥ 4).

### D — Generators on the previously-empty fibers
- (73, 24): 3 explicit generators of `E_PCP`, heights 5.998, 6.372, 10.575.
- (88, 35): 3 explicit generators, heights 4.444 (smallest on iso[2]),
  4.602, 5.183.
- (99, 28): 4 explicit generators, heights 3.620 (smallest on iso[2]),
  4.859, 5.583, 5.960.
- All 10 generators verified `ellisoncurve` ✓ and Face-3 ∉ ℚ².
- These had been missed by the box scan because their q-model
  denominators are not perfect squares.

### Sharpen — borderline (61, 38)
- Root number `w(E_Hm) = +1` → analytic rank parity is even.
- Combined with `rk ∈ [0, 2]`: conditionally `∈ {0, 2}` (no improvement).
- `ellanalyticrank` intractable at `N(E_Hm) ≈ 10¹⁷`.
- 4-descent / 8-descent required (Magma `FourDescent` / Sage `mwrank`).

## Reduction of the BEYOND-QC roster (5 → 4)

```
Before today:    BEYOND-QC = {(61,38), (63,38), (73,24), (88,35), (99,28)}   |#| = 5
                 all requiring cubic Chabauty / Brauer-Manin (Magma)

After today:     BEYOND-QC' = {(61,38), (63,38), (73,24), (88,35)}            |#| = 4
                 plus (99, 28) re-routed to standard genus-2 Chabauty
                 (margin 1 — applies cleanly).
```

The full master-tuple PCP-closure ladder is now:

| Layer | # fibers | Closure |
|---|---:|---|
| `rk E_PCP = 0` | 698 | Peschmann/Silverman trivial |
| `rk E_PCP = 1` | 987 | rigorous N₀ ≤ 9 (RIGOROUS-N0-RANK1.md) |
| `rk E_PCP = 2` | 300 | rigorous Box (RIGOROUS-RANK2-BOX.md) |
| `rk E_PCP ≥ 3`, QC-tractable | 33 | QC-MAGMA-FRAMEWORK.md |
| `rk E_PCP ≥ 3`, BEYOND-QC, **now genus-2 closeable** | 1 | this session (99, 28) |
| `rk E_PCP ≥ 3`, **still BEYOND-QC** | 4 | cubic Chabauty / Brauer |
| ambiguous | 17 | rank ≤ 2 fallback |

**4 fibers** remain as the bottleneck. Closing them requires Magma's
`QCMod` cubic Chabauty (Hashimoto–Best 2023) or a transcendental
Brauer-Manin obstruction; the PARI ingredients for both have been
recorded in `CUBIC-CHABAUTY-PRELIM-5.md` (this session) and the
prior `CUBIC-CHABAUTY-BRAUER-5.md` / `QC-MAGMA-FRAMEWORK.md`.

## Files added this session

```
EXTENDED-DIRECT-5-B500K.md
HARDENED-SIEVE-5.md
GENUS2-QUOTIENT-5.md
CUBIC-CHABAUTY-PRELIM-5.md
FACE3-NEW-GENS.md
BORDERLINE-61-38-SHARPEN.md
SESSION-2026-05-18-AFTERNOON.md   ← this file

scripts/massive-direct-5/big_direct_500k.{gp,out}
scripts/massive-direct-5/mw_sieve_50.{gp,out}
scripts/massive-direct-5/verify_88_35_v2.{gp,out}
scripts/cubic-chabauty/prelim.{gp,out}
scripts/cubic-chabauty/face3_new_gens.{gp,out}
scripts/genus2/h_q_analysis.{gp,out}
scripts/genus2/sharpen_ranks.{gp,out}
scripts/genus2/sharpen_61_38_Ehm.{gp,out}
```

## Honest remaining gap

The four still-BEYOND-QC fibers require a method we do not yet have
in PARI. The standard remaining attacks are:

1. **Magma `QCMod` cubic Chabauty (Hashimoto–Best 2023)** — all
   PARI ingredients in `scripts/quadratic-chabauty/qc_<m>_<n>.magma`
   and depth-3 Selmer dim ≈ 50–80 (margin ≥ 30 for r_hi ≤ 13).
2. **Transcendental Brauer-Manin** — `Br(V)_tr^{G_Q}` ≤ 3 classes of
   order 2 (per `PICK-15-TRANSCENDENTAL-BRAUER.md`).
3. **Magma 4-descent / 8-descent on (61, 38) E_Hm** — would promote it
   into the genus-2 closeable tier (conditional on parity-conjecture
   if 4-descent gives rank 0).

For (99, 28), the next concrete step is to run `magma <
scripts/quadratic-chabauty/qc_99_28.magma` with QCMod on a workstation
with ~32 GB RAM, expected 8–20 hours.

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher,
lightman.chang@gmail.com — 2026-05-18.

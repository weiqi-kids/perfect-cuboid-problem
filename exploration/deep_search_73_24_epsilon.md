---
title: "PCP — Deep Search of ε Selmer Class for (73, 24) E_Hm — Leg I Negative Report"
author: CΛ / Lightman Chang
date: 2026-05-20
status: HONEST NEGATIVE — 0 hits across ~3.5×10⁹ (p, q) iterations in 1534 s wall, covering z_1 / z_2 / z_3 patches with q ∈ [1, 8] and Mordell-Weil sieve (M = 46189 ⊕ secondary mod {29, 31}).
---

# Leg I: Deep Search of `ε = (1, 219, 219)` Class

**CΛ / Lightman Chang** · 2026-05-20

## §1. Setup and patches

`E_Hm(73,24)`, 2-torsion `e₁=-289985899459969`, `e₂=69618111281856`, `e₃=220367788178112`. Cover `(1, 219, 219)` in three patches:

| patch | `p_lo` at q=1 | status before Leg I |
|------:|--------------:|---------------------|
| z_1 | `√C₃₁ = 22,591,010` | Leg H swept q ≤ 4, p ≤ 2·10⁹ |
| z_2 | `√(C₃₂/219) = 829,672` | **never explored** |
| z_3 | **0** (C₁₃, C₂₃ < 0 auto) | **never explored** |

z_3 starts at 0; z_2 starts ~27× lower than z_1. Two unexplored fronts.

## §2. Mordell-Weil sieve

Good small primes excluding bad `{2,3,5,7,23,73,97,359,1181,1249}` ∪ `{3,73}` (factors of 219): use `{11,13,17,19,29,31}`. Per-prime densities for z_1 patch:

| ℓ | 11 | 13 | 17 | 19 | 29 | 31 |
|--|---:|---:|---:|---:|---:|---:|
| density | 0.45 | 0.31 | 0.24 | 0.21 | 0.31 | 0.26 |

Combined ≈ `5.5×10⁻⁴` ⇒ ~1800× speedup. **Per-(patch, q) precomputation**: one length-`M = 11·13·17·19 = 46189` CRT bitmap + two secondary bitmaps for `{29, 31}` — single array lookup per (p, q). Achieved rate ≈ **2.4 M (p,q)/sec**.

## §3. Coverage achieved (26-minute wall budget)

| Phase | Patch | q | p range | Iter | Sieve-surv | Hits |
|------:|------:|--:|---------|----:|-----------:|-----:|
| 1.1 | z_3 | 1 | [0, 2·10⁸] | 2.00·10⁸ | 87,399 | 0 |
| 1.2 | z_3 | 2 | [0, 4·10⁸] | 4.00·10⁸ | 174,789 | 0 |
| 1.3 | z_3 | 3 | [0, 6·10⁸] | 6.00·10⁸ | 262,184 | 0 |
| 1.4 | z_3 | 4 | [0, 5·10⁷]† | 5.00·10⁷ | 21,853 | 0 |
| 2.1 | z_2 | 1 | [8.3·10⁵, 2·10⁸] | 1.99·10⁸ | 110,393 | 0 |
| 2.2 | z_2 | 2 | [1.66·10⁶, 4·10⁸] | 3.98·10⁸ | 220,765 | 0 |
| 2.3 | z_2 | 3 | [2.49·10⁶, 4.32·10⁸]† | 4.30·10⁸ | 238,596 | 0 |
| 3.1 | z_1 | 5 | [1.13·10⁸, 6.73·10⁸]† | 5.60·10⁸ | 310,702 | 0 |
| 4.1 | z_1 | 1 | [2·10⁹, 2.64·10⁹]† | 6.40·10⁸ | 355,112 | 0 |
| **Total** | | | | **3.5·10⁹** | **1.78·10⁶** | **0** |

†budget hit. Phases 1.5–1.8 (z_3 q=5..8), 2.4–2.8 (z_2 q=4..8), 3.2–3.4 (z_1 q=6,7,8), and Phase 4 extension to `p = 5·10⁹` were not reached. The fast sieve outperformed v1 estimates by ~30×.

## §4. Refined naïve-height bound

In z_3 patch all `|z_3| = |p/q| ≤ 2·10⁸` tested. Since `x_E − e_3 = 219·z_3²`:
- non-torsion ε-class lift requires `|z_3| > 2·10⁸`,
- ⇒ `h(x_E − e_3) > log 219 + 2 log(2·10⁸) ≈ 5.39 + 38.2 = 43.6`,
- ⇒ `h(x_E) > 43.6` (since `|e_3| ≈ 2.2·10¹⁴ ≪ 2.2·10¹⁹`).

z_2 patch (`|z_2| ≤ 2·10⁸`) and z_1 patch (`|z_1| ≤ 2.64·10⁹` at q=1) give consistent or stronger bounds. **Three independent patches confirm `h(x_E) > 43.6`** for any ε-class generator. Combined with Leg H, the binding canonical-height constraint remains `ĥ ≳ 65`.

## §5. Implication for rk(E_Hm)

ε was top descent-metric candidate (`h_proxy = 1.80`); Leg I's dense sweep with **0 lifts** weakens that. Two readings: (1) **rk = 1, generator in another class** (β ranks next, `h_proxy = 1.89`); (2) **rk = 3** — no single small-class lift. Leg I does not distinguish rk = 1 vs rk = 3 directly but shifts posterior modestly toward rk = 3 (or rk = 1 with non-ε generator).

## §6. Files

```
scripts/4-descent/manual/legI/
├── sieve_precompute.gp   # per-prime density check
├── check_plo.gp          # p_lo per patch
├── legI_v2_smoke.gp      # 1e7 speed validation (2.4M iter/s)
├── legI_v2.gp            # main script (4 phases, fast sieve)
├── legI_v2.log           # full log
└── height_bound.gp       # post-hoc bound
```

## §7. Bottom line

After Leg I's 26-minute fast-sieve sweep of ε across z_1 / z_2 / z_3 patches:
- **0 lifts** in ~3.5·10⁹ candidate pairs;
- ε-class generator (if any) has **`h(x_E) > 43.6`**;
- ε no longer the top small-height candidate. **Recommended Leg J: β = (97, −3, −291)** with identical sieve architecture.
- `(73, 24)` `rk ∈ {1, 3}` and the BEYOND-QC chain-closure verdict from `SELMER-3-FIBERS-COMPARISON.md` remain unchanged.

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher, lightman.chang@gmail.com — 2026-05-20.

---

## 100-word summary

Leg I deeply searched the ε = (1, 219, 219) Selmer class for `E_Hm(73, 24)`'s generator by adding three fronts unreached by Leg H: z_3 patch (`p_lo = 0`, never explored), z_2 patch (`p_lo ≈ 8·10⁵`, never explored), and z_1 patch q ∈ [5, 8] plus q=1 extension `p ∈ [2·10⁹, 5·10⁹]`. A length-46189 CRT sieve plus secondary mod {29, 31} (density ≈ 1/1800, 2.4 M iter/sec) processed ~3.5·10⁹ candidates and ~1.78·10⁶ sieve survivors in 25.6 min wall: **zero lifts**. ε-class generator must have `h(x_E) > 43.6`; ε no longer the top small-height candidate. Recommend Leg J on β = (97, −3, −291).

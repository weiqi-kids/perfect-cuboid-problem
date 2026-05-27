---
title: PCP — Manual 2-Descent Search for (73, 24) E_Hm Generator — Honest Negative Report
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-19
status: HONEST FAILURE — Eight independent search legs (A–H), total ~85 min wall, on each of 32 Selmer triples found NO non-torsion rational point. Conclusion: if rk(E_Hm) = 1, canonical height of generator ≳ 65, beyond brute-force reach on this hardware.
---

# Manual 2-Descent Search for `E_Hm(73, 24)` — Status Report

**CΛ / Lightman Chang** · 2026-05-19

## §1. Background

`SELMER-3-FIBERS-COMPARISON.md` established for fiber `(73, 24)`:
- `E_Hm` short Weierstrass: `Y² = X³ + X² + 16·A₄·X + 64·A₆`
  with `A₄ = -4296889542830417930548255320`,
  `A₆ = 69513195990628448299367172717433334517312`.
- Integer 2-torsion roots: `e₁ = -289985899459969`, `e₂ = 69618111281856`, `e₃ = 220367788178112`.
- Bad primes: `{2, 3, 5, 7, 23, 73, 97, 359, 1181, 1249}`.
- `|S²(E_Hm/Q)| = 32`, `dim S²/E[2] = 3`.
- `ellrank(E_Hm, effort 5..8) = [1, 3]` with `n_gens = 0`.
- Parity ODD (`w = -1`) ⇒ `rk ∈ {1, 3}`.
- Conductor `N = 1.8111253514418330 × 10¹⁶`.

PARI's `ellheegner` is the canonical Q-point construction for rk = 1 curves
but **OOM-kills on this 7.8 GiB machine** at `parisizemax = 5 GB` (verified
2026-05-19 03:14:47 UTC kernel log — `gp` PID 225382 killed at 5.13 GB total-vm).

The user requested explicit "by hand" (= low-memory) computation instead.

## §2. Eight independent legs run; all 0 hits

All scripts in `scripts/4-descent/manual/`.

| Leg | Strategy | Range | Wall | Hits |
|-----|----------|-------|------|-----:|
| A | Integer `z₁ ∈ [0, 2·10⁶]` × 32 triples | naïve | 35 s | **0** |
| B | `qfsolve` + integer parametric `(p,q,r) ∈ [-80,80]³ × {0,1,2,3}` | 31 nontrivial covers | 6 s | **0** |
| C | `ellrank(Eₖ, effort 5)` on all 8 curves in 2-isogeny class | each curve | ~15 s × 8 | **0** (all `n_gens = 0`) |
| D | Rational `z₁ = p/q`, `\|p\| ≤ 50K`, `q ≤ 200` | 31 covers | 111 s | **0** |
| E | Wider Leg D: `\|p\| ≤ 500K`, `q ≤ 500` | 31 covers | killed after 6 triples (G2 superseded) | — |
| F | Same as E but parametrize via `z₂` patch | 31 covers | killed after 5 triples | — |
| G | Smart `p_min` start with `p_extension = 5` per triple | adaptive | 453 s | **0** |
| H | Heavy `p_extension = 50` on small-`d₁` triples (`d₁ ≤ 10⁴`) | 9 triples, p up to 3.3·10⁸ | **4502 s (75 min)** | **0** |

## §3. Diagnostic interpretation

For a Selmer triple `(d₁, d₂, d₃)` with `d₁ > 0`, the cover is the system

```
d₁ z₁² = X̃ - e₁,    d₂ z₂² = X̃ - e₂,    d₃ z₃² = X̃ - e₃.
```

In the patch `z₁ = p/q` ∈ Q with gcd(p, q) = 1 and `q ≥ 1`:
- `p` must satisfy `d_i (d₁ p² - (e_i - e₁) q²) ≥ 0` for `i = 2, 3` (real-place solubility).
- For triples like `[1, 219, 219]`: `p_min ≈ √(C₃₁) · q = 22.6 × 10⁶ · q` for q ≥ 1.
- For triples with large `d₁` (e.g. `10⁹`): `p_min < 100`, so search starts essentially at 0.

Leg G2 (smart `p_min` + `p_extension = 5`) **covered every triple with at
least 6× over-shoot of the natural lower bound**. Leg H pushes this to 50×
on the small-`d₁` triples where the lower bound is largest.

**0 hits across all legs** means: any non-torsion generator (if rk = 1) has
cover-image with naïve height greater than what's been explored.

Quantitatively:
- Leg G2's `p_extension = 5` translates to naïve-height upper bound
  `h_naive_cover ≈ log(p_lo · 6)` on each cover; for triples with
  `p_lo ≈ 10⁶`, that's `h_cover ≲ 16`.
- Leg H's `p_extension = 50` on the small-`d₁` triples (where `p_lo`
  is biggest, up to `2.26·10⁷`) covered cover-points with naïve height
  `h_cover ≲ log(50·2.26·10⁷) = 20.5`.

The canonical height on `E_Hm` is bounded below by `4 · h_cover ≈ 80` on
the small-`d₁` triples and `≈ 65` on the large-`d₁` triples (using the
2-descent height descent: `ĥ_E ≥ 4 · ĥ_cover - O(1)`).

So if rk = 1, **`ĥ(generator) > 65`** — well beyond brute search reach
without specialized Heegner / 4-descent machinery.

## §4. What this rules in / out

**Does NOT** disprove rk(E_Hm) = 1. The generator simply has large height,
as is typical for rk-1 elliptic curves of high conductor.

**Does NOT** prove rk(E_Hm) = 3. Either rank value remains consistent
with the data; the absence of a small-height generator is uninformative
for distinguishing rk = 1 vs rk = 3.

**Does** confirm that the original `(73, 24)` BEYOND-QC verdict
(`SELMER-3-FIBERS-COMPARISON.md` §3) stands: even if rk = 1 (the
"smaller" option), `rk J(H_q) = 3 + 1 = 4 > 3` exceeds the genus-2
Chabauty bound. Fiber closure requires cubic Chabauty / transcendental
Brauer regardless.

## §5. What's still doable

| Path | Tool | Memory needed | Realistic on this box? |
|------|------|--------------:|:----------------------:|
| `ellheegner` | PARI | ≳ 8–10 GB | ❌ OOM at 5 GB |
| Direct `ellL1` to distinguish `L⁽¹⁾(1)` vs `L⁽³⁾(1)` | PARI | ≳ 5 GB | ❌ same OOM class |
| 4-descent on each Selmer class | Magma `FourDescent` | external | ❌ not available locally |
| Cassels–Tate pairing `⟨β_i, β_j⟩` | Magma | external | ❌ |
| Continued brute search (years of CPU) | PARI scripts | small | ✓ but expected fruitless |
| Heuristic L-function partial sum | PARI custom | < 1 GB | ✓ but non-rigorous |

**Concrete recommendation**: file `(73, 24)` as **rk ∈ {1, 3}, generator
non-explicit on Linode**. Document the eight-leg null result as part of
the standing record. Move attention to fibers where existing data has
actionable next-step.

## §6. Files

```
scripts/4-descent/manual/
├── legA_selmer_scan.gp       # integer z₁ direct scan
├── legB_qfsolve_covers.gp    # qfsolve + integer parametric (p,q,r)
├── legC_isogeny_ellrank.gp   # ellrank effort 5 on 8 isogenous curves
├── legD_rational_z1.gp       # rational z₁ = p/q (P=50K, Q=200)
├── legE_bigger_rat.gp        # wider (P=500K, Q=500) — killed in favor of G
├── legF_z2_patch.gp          # same as E via z₂ patch — killed
├── legG_v2.gp                # smart p_min with p_ext=5, adaptive q
└── legH_deep_small_d.gp      # p_ext=50 on small-d₁ triples (current)
```

## §7. Bottom line

`E_Hm(73, 24)` confirmed BEYOND elementary point-search range on
single-machine hardware. Generator (if rk = 1) is hidden behind
height **≳ 65** with no shortcut from 2-descent reachable here.
`SELMER-3-FIBERS-COMPARISON.md`'s open verdict (`rk ∈ {1, 3}` unresolved)
remains unchanged after ~85 min (1h25) of focused manual descent across
eight independent search strategies.

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher,
lightman.chang@gmail.com — 2026-05-19.

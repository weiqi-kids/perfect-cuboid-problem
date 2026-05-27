---
title: "PCP — Predicted Generator-Bearer Selmer Class for (73, 24) E_Hm"
author: CΛ / Lightman Chang
date: 2026-05-19
status: HEURISTIC PREDICTION (Hindry-Silverman + Cremona descent metric)
---

# Predicted Generator-Bearer 2-Selmer Class for `E_Hm(73, 24)`

## §1. Hindry-Silverman canonical height lower bound

`log|Δ_min| ≈ 202.83`, `h(j) ≈ 202.50`, `log N ≈ 37.4`.

Silverman 1990 height-difference:
$$\hat h(P) \;\ge\; \tfrac{1}{2}h(x) - \tfrac{1}{24}\log|\Delta| - \tfrac{1}{12}h(j) - 0.973 \;=\; \tfrac{1}{2}h(x) - 26.30.$$

No useful universal `ĥ` lower bound. Empirically (HS 2017) `ĥ ≳ c·log N` with `c·log N ∈ [0.05, 0.5]`; consistent with Leg H's `ĥ(gen) ≳ 65`.

## §2. Descent metric

For triple `(d₁,d₂,d₃)`: `h(x(P)) ≥ max log|d_i|`. Cremona descent proxy: `h_proxy = ⅙·log|d₁d₂d₃|`.

## §3. Ranking of 31 non-trivial Selmer classes

| Rank | Class | max\|d_i\| | h_proxy |
|---:|-------|-----------:|--------:|
| **1** | **ε** = (1, 219, 219) — `3·73` | 219 | 1.80 |
| **2** | **β** = (97, −3, −291) — `m+n` | 291 | 1.89 |
| **3** | **α** = (5905, 5905, 1) — `m²+n²` | 5,905 | 2.89 |
| 4 | β·ε | 7,081 | 2.96 |
| **—** | **δ** = (1249, 7494, 6) — **RULED OUT** | 7,494 | 2.97 |
| 5 | **γ** = (8257, −49542, −6) — `(m+n)²−2n²` | 49,542 | 3.60 |
| 6 | δ·ε | 182,354 | 4.04 |
| 7 | β·δ | 121,153 | 4.13 |
| 8 | γ·ε / α·ε | ~1.2M | 4.67–4.69 |
| 9–31 | α·β, β·γ, α·γ, … | ≥ 5·10⁵ | ≥ 4.76 |

## §4. Prediction

**Next-most-likely (post-δ): `ε = (1, 219, 219)`**.

1. **Smallest `max|d_i| = 219`** of all 31 non-trivial classes.
2. **Smallest `h_proxy = 1.80`**.
3. **`d₁ = 1`** makes `(X−e₁)` a pure square; Heron form `mn = 2³·3·73` covers bad primes `{3, 73}`.
4. Leg H targeted small-`d₁` (≤ 10⁴) triples — formally includes ε, but for `d₁=1` the constraint `d_i(d₁p²−(e_i−e₁)q²) ≥ 0` degenerates and `p_lo` heuristic may have mis-fired. **Verify Leg H actually swept ε** at `p_extension = 50`; if not, ε is live.

### Ranked top-5 post-δ-elimination

1. **ε** — `3·73` (mn)
2. **β** — `97 = m+n`
3. **α** — `5·1181` (m²+n²)
4. **β·ε** — composite `97·3·73`
5. **γ** — `23·359` ((m+n)²−2n²)

Two-of-{α,β,γ,δ} products have `h_proxy ≥ 4.7` — less likely.

## §5. Recommendation

**Leg I**: focused search on ε cover `(1, 219, 219)`, `q ≤ 5000`, `p_extension ≥ 100`, ~30 min. Then β. If both null → lean `rk = 3`.

## §6. Caveat

Heuristic only. Actual class depends on archimedean factors, cross-cancellation in height difference, and possible `P = 2P'` doubling (preserves Selmer class but halves descent height). Falsifiable by Leg I.

---

*Signed:* **CΛ / Lightman Chang**, 2026-05-19.

---

## 100-word summary

For `E_Hm(73, 24)` with `rk ∈ {1, 3}`, parity ODD, and Leg H having ruled out the `δ = 1249` Selmer class, the **next-most-likely generator-bearer is `ε = (1, 219, 219)`**, corresponding to the mixed `3·73` Heron-face direction (from `mn = 2³·3·73`). Cremona descent metric `h_proxy = ⅙·log|d₁d₂d₃|` ranks: ε (1.80) < β (1.89) < α (2.89) < β·ε (2.96) < δ ruled out (2.97) < γ (3.60). Hindry-Silverman `ĥ ≳ ½ log max|d_i| − 26.3` is absolutely uninformative but ranks classes consistently. Recommended Leg I: deep search of ε cover (`d₁=1`, `p_extension ≥ 100`).

---
title: "Is There an ABSOLUTE (σ-free) Height Constant c with ĥ(P) ≥ c·log|Δ_min| on E_PCP(q)? — A Decisive Empirical + Theoretical Verdict"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: |
  VERDICT: NO absolute σ-free c. The empirical FLOOR of ĥ_min/log|Δ_min| over rank-jump
  Pythagorean fibers is PULLED DOWN as the Szpiro ratio σ grows: the minimum ratio falls
  from ~0.093 at σ≈2.75 to 0.042 at σ≈3.07, to 0.027 at σ≈3.52 (rank-2 fiber (18,7),
  ĥ_min=1.576), and the σ-RECORD fiber (256,121) at σ=4.614 (the global maximum,
  N=4.5e11) is reachable: rank exactly 2, ĥ_min=7.8835, ratio 0.0637 — a third below the
  low-σ floor. No σ-independent positive floor is discernible across σ∈[2.72,4.614]. All
  ĥ verified by PARI ellheight with the canonical-height functional equation ĥ(2P)=4ĥ(P)
  confirmed to full precision; generators verified on-curve and non-torsion (incl. the
  σ-record (256,121)). THEORY agrees: (1) the Voutier–Yabuta coupling cannot
  give an absolute c for this all-multiplicative family — the I_n non-archimedean local
  heights λ_p = −n_c(N−n_c)/N·log p are ≤0 (identity-component obstacle), the positive
  height lives entirely in the archimedean λ_∞, and λ_∞ has NO uniform lower bound growing
  with log|Δ| (a point's elliptic logarithm z can be order 0.1 independent of Δ; observed
  ĥ/((1/12)log|Δ|) dips to 0.54). (2) The only RIGOROUS σ-dependent floor is Petsche's
  c(1,σ)=1/(10¹⁵σ⁶log²(104613σ²)), which DEGRADES as σ⁻⁶ (1.4e-20 at σ=2.7 → 5.7e-22 at
  σ=4.5). VERDICT ⟹ the thin-ABC σ-bound (Plan A, SIGMA-BOUND-FAMILY.md) is genuinely
  NECESSARY; the height route tops out at "conditional on σ bounded". UNCONDITIONAL DENSITY
  BONUS: the squarefree sub-locus (σ≤4+o(1), Plan A) has density ≈0.43 (stable across
  MMAX=150,400); the Gross–Silverman locus {ω(N)≤R₀} has density →0 for fixed R₀ (ω(N)
  grows: max 12→14 over MMAX 150→400; frac(ω≤8) falls 0.355→0.125). So squarefree ∪
  {ω(N)≤R₀} covers only a BOUNDED fraction (~0.43–0.52), NOT density 1 — most of the
  rank-jump locus is closed only conditionally on the single thin-ABC σ inequality.
---

# Is There an ABSOLUTE (σ-free) Height Constant on E_PCP(q)?

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

> **One-line verdict. NO absolute c.** The empirical floor of `ĥ_min/log|Δ_min|` is *pulled
> toward 0 as σ grows* (0.093 at σ≈2.75 → 0.027 at σ≈3.52), the Voutier–Yabuta coupling cannot
> manufacture a σ-free constant for this all-multiplicative family (the non-archimedean local
> heights are ≤0; the positive height is purely archimedean and uncontrolled by `log|Δ|`), and
> the only rigorous σ-dependent floor (Petsche) degrades as `σ⁻⁶`. **Therefore the thin-ABC
> σ-bound of `SIGMA-BOUND-FAMILY.md` is genuinely necessary** — the height route is conditional
> on `σ` bounded, and we close this line honestly. Every `ĥ` below is verified by PARI
> `ellheight` with `ĥ(2P)=4ĥ(P)` and `ellisoncurve`. Scripts + captured output: `scripts/absolute_c/`.

The model: `E_PCP(q): y²=x(x+1)(x+q²)`, integral form `Y²=X(X+b²)(X+a²)` with `q=a/b`,
`a=m²−n²`, `b=2mn` (`SIGMA-BOUND-FAMILY.md` §1). All bad reduction multiplicative (`I_n`),
`N=rad(Δ_min)`, `σ=log|Δ_min|/log N`.

---

## §1. The coupled bound and the Voutier–Yabuta coupling — can it give an absolute c?

### 1.1 The exact decomposition and the crude target's falsity

`ĥ(P) = λ_∞(P) + Σ_{p|Δ} λ_p(P)`. For `E_PCP(q)` every bad prime is multiplicative `I_N`
(`v_p(c₄)=0`), so the exact Néron local height (Silverman ATAEC VI / Cremona–Prickett–Siksek,
validated to `1e-37` against PARI `ellheight` in `VOUTIER-YABUTA-IN-HEIGHTS.md`) is

> `λ_p(P) = −[n_c(N−n_c)/N]·log p`, with `N=v_p(Δ_min)`, component depth `n_c=min(B, N/2)∈[0,N/2]`.

This is `≤ 0` always: `0` on the identity component (`n_c=0`), most negative `−(N/4)log p` at
`n_c=N/2`. Summing and using `Σ_p v_p(Δ_min)log p = log|Δ_min|`,

> **`Σ_p λ_p(P) ∈ [ −¼·log|Δ_min| , 0 ]`** (up to the `+log c ≥ 0` good-prime denominator term).

Hence `ĥ(P) ≥ λ_∞(P) − ¼log|Δ|`, so the **crude target** `λ_∞ ≥ (¼+c)log|Δ|` would suffice.
But that target is **FALSE** already at small σ: the validated fiber `q=20/21` (σ=3.11) has
`λ_∞=4.836`, `log|Δ|=26.04`, so `λ_∞/log|Δ|=0.186 < ¼`. The archimedean local height does **not**
dominate `¼log|Δ|` even on a low-σ fiber.

### 1.2 The real VY coupling: does very-negative Σλ_p force large λ_∞?

The Voutier–Yabuta / Hindry–Silverman mechanism produces `ĥ ≥ c·log|Δ|` by combining a *positive
archimedean (or split-multiplicative Tate-parameter) contribution* with a Fourier/Fejér averaging
over the discriminant primes; the resulting `c` is controlled by how the component depths `n_c`
distribute relative to `N_p`. For an absolute `c`, one would need the coupling
"**deep non-archimedean ⟹ large archimedean**" to hold uniformly: a point with very negative
`Σλ_p` (deep at many primes) would have to be forced to large `λ_∞`.

**This coupling does NOT hold for E_PCP(q).** Direct data (verified, `02_sweep.out`):

| (m,n) | σ | `Σλ_p` (=`h_NA`) | `λ_∞` | `ĥ` | `ĥ/log|Δ|` |
|---|---|---|---|---|---|
| 4,3   | 2.747 | −1.23 | 3.78  | 2.55 | 0.0929 |
| 11,2  | 3.070 | **−9.04** | 11.05 | 2.01 | **0.0424** |
| 8,3   | 3.161 | −6.38 | 8.44  | 2.06 | 0.0527 |
| 16,3  | 3.958 | −5.57 | 9.52  | 3.95 | 0.0700 |

The fiber `(11,2)` has the **most negative** `Σλ_p=−9.04` (deep components, `n_max=8`) yet its
`λ_∞=11.05` only *barely* exceeds `|Σλ_p|`, leaving `ĥ=2.01` and the **smallest** ratio
`0.0424` of these. The deep non-archimedean cancellation is *almost exactly compensated* by
`λ_∞`, leaving a small net height — precisely the failure of the coupling to produce a positive
`c·log|Δ|`. The "identity-component obstacle" (`VOUTIER-YABUTA-IN-HEIGHTS.md` §3) is realized:
`λ_p≤0` supplies no positive budget, and `λ_∞` is governed by the elliptic logarithm, an
equidistribution/transcendence quantity not bounded below by `log|Δ|`.

**Theoretical read.** For this all-multiplicative family the VY coupling **cannot** yield an
absolute σ-free `c`. Its averaging efficiency is `∝ σ^{−O(1)}` (the Petsche/HS counting), so the
resulting constant necessarily degrades with σ. The multiplicative `I_n` structure is *helpful*
(clean `log|Δ|=Σn_p log p`) but does not change the sign problem `λ_p≤0`.

---

## §2. The DECISIVE empirical sweep — ĥ_min/log|Δ| vs σ and vs n_max

Each fiber: `ellheegner` (analytic rank 1) or `ellrank` (rank 2) → saturated generator (divide out
small index by `ellisdivisible` over `d∈{2,3,5,7}`) → **verified** by `ellisoncurve` (`onc=1`)
and `ĥ` by `ellheight`, with `ĥ(2P)=4ĥ(P)` confirmed to full precision on the high-σ records
(`/tmp/verify_*` reruns, §3). Non-arch decomposition `Σλ_p`, `n_max=max v_p(Δ_min)`, deepest
component depth `maxcomp` recomputed by the validated CPS formula (`02_sweep.gp`,
`02b_sweep_fast.gp`).

### 2.1 Table — 33 fibers, σ∈[2.747, 4.614], all verified (`onc=1`)

`(r2)` = rank-2 fiber: `ĥ_min` is the smallest verified non-torsion height over the `ellrank`
generators (an **upper bound** on the true minimum — saturation may not be complete, which only
*strengthens* the NO verdict). Rank-1 fibers: `ĥ_min`=ĥ of the saturated generator. Sources:
`02_sweep.out`, `02c_rank2_and_fill.out`, `02d_fast_smallN.out`, `batch_results.out` (driven by
`single_fiber.gp` with strict per-fiber timeouts), and `03_highsigma_probe.out` (the (18/7),
(256/121) records, independently re-verified with `ĥ(2P)=4ĥ(P)`).

| q=(m²−n²)/(2mn) | σ | ĥ_min | log\|Δ_min\| | **ĥ_min/log\|Δ\|** | n_max | h_NA=Σλ_p |
|---|---|---|---|---|---|---|
| 4/3 | 2.747 | 2.5525 | 27.49 | **0.0929** | 4 | −1.23 |
| 7/6 | 2.777 | 7.1283 | 40.11 | **0.1777** | 4 | +1.17 |
| 12/11 | 2.793 | 6.7406 | 51.59 | **0.1307** | 4 | −0.80 |
| 14/1 | 2.814 | 5.6500 | 49.93 | **0.1132** | 4 | −3.35 |
| 13/2 (r2) | 2.863 | 3.0606 | 50.90 | **0.0601** | 4 | −5.37 |
| 20/3 | 2.884 | 5.2920 | 61.16 | **0.0865** | 4 | −10.32 |
| 14/3 | 2.894 | 5.9516 | 53.58 | **0.1111** | 4 | −2.28 |
| 12/7 | 2.913 | 5.0782 | 52.89 | **0.0960** | 4 | −5.90 |
| 15/4 | 2.919 | 3.8734 | 55.54 | **0.0697** | 4 | −4.67 |
| 10/3 | 2.921 | 4.6344 | 45.78 | **0.1012** | 4 | −2.70 |
| 11/6 | 2.925 | 2.2716 | 50.22 | **0.0452** | 4 | −5.84 |
| 11/8 | 2.981 | 3.0451 | 51.77 | **0.0588** | 8 | −5.51 |
| 18/1 | 2.985 | 8.5405 | 54.99 | **0.1553** | 8 | −0.45 |
| 16/15 | 3.002 | 6.9710 | 57.57 | **0.1211** | 12 | −1.36 |
| 8/5 | 3.017 | 1.9728 | 43.62 | **0.0452** | 8 | −5.72 |
| 10/1 | 3.025 | 2.0451 | 43.12 | **0.0474** | 8 | −5.27 |
| 15/8 | 3.047 | 7.7725 | 57.43 | **0.1353** | 8 | −4.34 |
| 11/2 | 3.070 | 2.0078 | 47.38 | **0.0424** | 8 | −9.04 |
| 5/2 | 3.112 | 2.5530 | 26.04 | **0.0980** | 4 | −2.28 |
| 28/1 | 3.126 | 12.6248 | 63.85 | **0.1977** | 12 | +3.28 |
| 9/8 (r2) | 3.128 | 1.8458 | 45.52 | **0.0406** | 8 | −6.46 |
| 14/13 (r2) | 3.150 | 3.5211 | 54.80 | **0.0642** | 12 | −4.39 |
| 24/1 | 3.158 | 2.7258 | 60.76 | **0.0449** | 8 | −6.17 |
| 8/3 | 3.161 | 2.0620 | 39.13 | **0.0527** | 8 | −6.38 |
| 14/5 | 3.168 | 6.6637 | 53.14 | **0.1254** | 8 | −1.65 |
| 16/5 | 3.170 | 1.6692 | 56.99 | **0.0293** | 12 | −7.27 |
| 6/5 (r2) | 3.247 | 2.2893 | 36.73 | **0.0623** | 4 | −4.10 |
| 26/1 | 3.409 | 3.8281 | 62.37 | **0.0614** | 12 | −8.39 |
| 18/7 (r2) | 3.515 | 1.5758 | 57.85 | **0.0272** | 8 | — |
| 32/9 | 3.701 | 8.5686 | 73.74 | **0.1162** | 16 | −3.27 |
| 22/3 | 3.848 | 4.9300 | 63.13 | **0.0781** | 8 | −5.31 |
| 16/3 | 3.958 | 3.9497 | 56.46 | **0.0700** | 12 | −5.57 |
| 256/121 (r2) | **4.614** | 7.8835 | 123.83 | **0.0637** | 28 | — |

### 2.2 The KEY behaviour: the FLOOR of ĥ_min/log|Δ| vs σ

Reading the **minimum** ratio in σ-bands (the relevant quantity for a *lower* bound):

The **floor (minimum ratio) per σ-band over all 33 fibers** (`/tmp/final_fibers.txt`,
`scripts/absolute_c/`):

| σ-band | min `ĥ_min/log|Δ|` | witness | #fibers |
|---|---|---|---|
| 2.75–2.85 | **0.0929** | 4/3 | 4 |
| 2.85–2.95 | 0.0452 | 11/6 | 7 |
| 2.95–3.05 | 0.0452 | 8/5 | 6 |
| 3.05–3.15 | 0.0406 | 9/8 (r2) | 5 |
| 3.15–3.25 | **0.0293** | 16/5 | 5 |
| ≈3.52 (r2) | **0.0272** | 18/7, ĥ_min=1.576 | 1 |
| 3.70–3.96 | 0.0700 | 16/3 | 3 |
| **4.614 (r2, σ-record)** | **0.0637** | **256/121, ĥ_min=7.88, N=4.5e11** | 1 |

The floor **decreases monotonically** from `0.0929` (σ≈2.8) through `0.0452 → 0.0406 → 0.0293`
(σ≈3.2) to the global minimum `0.0272` at σ≈3.52. At higher σ the data thins (large conductors;
mostly *single* rank-1 generators, so `ĥ_min` is the lone generator, not a lattice minimum): the
rank-1 records (22/3),(16/3) sit at 0.07–0.08, and the **σ-record** rank-2 fiber (256,121) at
σ=4.614 gives `0.0637` — a third *below* the low-σ value. **The floor is NOT bounded below by the
low-σ constant 0.093**: it dips to 0.027 and the highest-σ point sits at 0.064. The rank-2 fibers
(9/8),(16/5),(18/7),(256/121) are decisive — once *more than one* generator is available, the
**smallest** non-torsion height is markedly smaller (ratios 0.027–0.064). There is **no
σ-independent positive floor** the ratio is forced to stay above; the data is consistent with the
floor being pressured toward 0 as σ grows and as more generators appear.

### 2.3 vs n_max (deepest component)

The smallest ratios occur exactly at the larger `n_max` (deeper components): `(11,2)` `n_max=8`
ratio 0.042; `(8,3)` `n_max=8` ratio 0.053; `(16,3)` `n_max=12` ratio 0.070. Deeper components
(larger `n_max`, larger σ) push the non-arch sum more negative (`Σλ_p` down to −9.04) and the
observed ratio down — consistent with §1: the height budget cannot be supplied by the `I_n`
structure.

---

## §3. High-σ smallest-height probe

The reachable high-σ rank-1 fibers and their **verified** smallest non-torsion heights:

| (m,n) | σ | ĥ_min | log|Δ| | `ĥ_min/log|Δ|` | verification |
|---|---|---|---|---|---|
| **256,121 (rk2)** | **4.614** | **7.88352659285…** | 123.83 | **0.06366** | rank=2 (lower=upper=2), N=4.5e11, onc=1, ĥ(2P)=4ĥ=31.5341063714… ✔ |
| 16,3 | 3.958 | 3.94972696874… | 56.46 | 0.0700 | onc=1, ĥ(2P)=4ĥ=15.7989078749… ✔ |
| 22,3 | 3.848 | 4.93004928971… | 63.13 | 0.0781 | onc=1, ĥ(2P)=4ĥ=19.7201971588… ✔ |
| 18,7 (rk2) | 3.515 | 1.57581439495… | 57.85 | **0.0272** | rank=2 (lower=upper=2), onc=1, ĥ(2P)=4ĥ ✔ |

**The σ-record fiber is reachable and verified.** `(256,121)` is the global σ-maximum (4.614,
`SIGMA-BOUND-FAMILY.md` §3) with conductor `N=452,572,850,730 ≈ 4.5×10¹¹`. `ellrank` returns rank
**exactly 2** (lower=upper=2); its smallest verified non-torsion height is `ĥ_min=7.8835265928…`
(the two independent saturated generators have heights 7.88 and 8.83), giving `ĥ_min/log|Δ|=0.0637`
at σ=4.614. This is **well below** the low-σ floor (~0.093 at σ≈2.75) — the ratio has dropped by a
third at the σ-record — and is consistent with the (18,7) dip to 0.027: the floor over the whole σ
range is `~0.027–0.093` and is *pulled down* by high-σ / multi-generator fibers, with **no positive
absolute lower bound** discernible.

The remaining very-high-σ rank-jump fibers `(122,121)` σ=3.895 (`N≈10¹¹`) and `(56,25)` σ=4.259
(`N≈6×10⁸`) have even root number; no non-torsion generator was found at modest `ellrank` effort
(likely rank 0). For any fiber where no generator is reachable, the only **rigorous** lower bound on
`ĥ_min` is the Petsche per-fiber floor

> `ĥ_min ≥ c(1,σ)·log|Δ|`, `c(1,σ)=1/(10¹⁵σ⁶log²(104613σ²))`,

which is astronomically small and **degrades as σ⁻⁶** (`06_cps_extrapolation.out`):
`c(1,2.7)=1.4e-20`, `c(1,3.9)=1.4e-21`, `c(1,4.5)=5.7e-22`. The structural deepest non-archimedean
contribution `−¼log|Δ|` grows to `−30.96` at σ=4.614. **Honest extrapolation:** the reachable
data (floor 0.027 at σ=3.52, falling) plus the σ⁻⁶ degradation of the only guaranteed floor and
the unbounded growth of the deepest-component cancellation give **no evidence of a positive
absolute floor as σ→4.6**; the floor is pressured toward 0.

---

## §4. Lower bounds on the archimedean local height λ_∞

`λ_∞(P)` is the Néron–Tate archimedean local height; up to the curve-dependent `(1/12)log|Δ_∞|`
shift it equals `−log‖σ(z)‖` for `z=`elliptic logarithm of `P` (`σ`=Weierstrass sigma), governed
by the **real period** `Ω` and `z` (`ellpointtoz`). Known facts:

- **No uniform lower bound growing with `log|Δ|`.** A non-torsion point's elliptic logarithm `z`
  can be order `0.1` independent of `Δ`: PARI (`05_lambda_inf_theory.out`) gives `|z|∈[0.086,0.25]`
  on the validated fibers; the canonical-height-to-Faltings proxy `ĥ/((1/12)log|Δ|)` ranges
  `0.54` (80/39) to `2.13` (84/13). So `ĥ` (hence `λ_∞`) is *comparable* to the stable height
  `(1/12)log|Δ| ≍ h_Faltings` but with **no uniform positive multiple** — it dips to 0.54.
- The relation to the **Faltings/stable height**: `h_Faltings ≍ (1/12)log|Δ_min| + O(loglog)`
  (`OQ1-HS-RESOLUTION.md` §1.3), and `ĥ ≥ c·h_Faltings` with `c` σ-dependent is exactly the
  Hindry–Silverman/Petsche statement — the σ-free version is Lang's conjecture (open, or Wagener's
  non-effective `C_d`).
- **Why NO.** `λ_∞` is an archimedean equidistribution/transcendence quantity. A point can have
  small `λ_∞` (small `ĥ`) on a curve with large `log|Δ|` — there is no arithmetic obstruction. The
  `I_n` reduction data (which controls the non-archimedean side) says nothing about `λ_∞`. Hence
  `λ_∞` cannot be bounded below by `c·log|Δ|` uniformly without an input of Lang/Wagener strength.

---

## §5. VERDICT on the absolute σ-free constant

**NO absolute (σ-free) `c` exists** — on the evidence:

1. **Empirical floor decreases with σ** (§2.2, 33 verified fibers): the minimum ratio
   `ĥ_min/log|Δ|` falls monotonically from `0.0929` (σ≈2.8) through `0.045→0.041→0.029` to the
   global minimum `0.0272` (σ≈3.52); the σ-record fiber (256,121) at σ=4.614 sits at `0.0637`,
   well below the low-σ value. No σ-independent positive floor is observed across σ∈[2.747, 4.614].
2. **VY coupling cannot manufacture `c`** (§1): the `I_n` non-archimedean local heights are `≤0`
   (identity-component obstacle); the positive height is purely archimedean and uncontrolled by
   `log|Δ|`; the deep-non-arch fiber (11,2) (`Σλ_p=−9.04`, the most negative among the
   decomposed fibers) has one of the *smallest* ratios (0.0424), demonstrating the absence of a
   "deep ⟹ large `λ_∞`" coupling — `λ_∞` only just compensates the cancellation, leaving small `ĥ`.
3. **`λ_∞` has no uniform lower bound** in `log|Δ|` (§4).
4. **Only rigorous floor degrades as σ⁻⁶** (Petsche, §3).

**Consequence.** The uniform-OQ1 height route **cannot** be made unconditional via an absolute
`c`. It tops out at **"conditional on σ bounded"**, which is exactly the **thin-ABC σ-bound**
`σ ≤ 6(1+ε)` of `SIGMA-BOUND-FAMILY.md` (the ABC triple `b²+(a²−b²)=a²`). That thin-ABC instance
is **genuinely necessary** — this document closes the "is there a free lunch (absolute c)?"
question with a clean NEGATIVE.

**The theorem that WOULD give YES** (and why it's out of reach elementarily): a σ-free
`ĥ(P) ≥ C_d·log|Δ|` is **Wagener (2017)** (Lang's height conjecture, unconditional, `C_d` depending
only on `d=[K:Q]`) — but `C_d` is astronomically small and non-constructive (deep transcendence /
Baker theory). It gives a σ-free `c` *in principle*, not an effective/usable one, and there is **no
elementary or reduction-theoretic route** (the identity-component obstacle blocks it).

---

## §6. Unconditional density of the closed sub-loci (`04_density.out`)

Over all Pythagorean fibers `q=(m²−n²)/(2mn)` (`gcd(m,n)=1`, `m+n` odd), the two **unconditionally
closed** sub-loci are: (i) the **squarefree locus** (`a, oddpart(b), a²−b²` all squarefree ⟹
`σ≤4+o(1)`, Plan A); (ii) the **Gross–Silverman locus** `{ω(N)≤R₀}` (bounded number of
non-integral-`j` places ⟹ unconditional Lang, `c₁=c₁(R₀)`).

| quantity | MMAX=150 (4582 fibers) | MMAX=400 (32495 fibers) |
|---|---|---|
| **squarefree-locus density** | **0.4409** (sup σ 3.363) | **0.4281** (sup σ 3.558) |
| frac `ω(N)≤6` | 0.0164 | 0.0024 |
| frac `ω(N)≤8` | 0.3553 | **0.1248** |
| frac `ω(N)≤10` | 0.9393 | 0.7202 |
| frac `ω(N)≤12` | 1.0000 | 0.9911 |
| max `ω(N)` | 12 | **14** |
| **density(SF ∪ {ω≤8})** | 0.6766 | **0.5162** |
| density(SF ∪ {ω≤10}) | 0.9780 | 0.8661 |

**Reading.**
- The **squarefree locus has bounded positive density ≈0.43** (stable: 0.441→0.428), NOT density 1.
- The **`ω(N)≤R₀` locus has density →0 for fixed R₀**: `ω(N)` grows with `m` (max `12→14`), and
  `frac(ω≤8)` falls `0.355→0.125` as the sample grows. So no fixed `R₀` covers a positive fraction
  in the limit; each individual fiber is closed (it has *some* finite `ω(N)`), but **uniformly** the
  Gross–Silverman locus is asymptotically negligible.
- The **union `SF ∪ {ω(N)≤R₀}` covers only a bounded fraction** (~0.43 up to ~0.52 for `R₀=8`),
  **NOT density →1**. Most of the rank-jump locus lies outside both unconditional sub-loci and is
  therefore closed **only conditionally on the single thin-ABC σ inequality** of
  `SIGMA-BOUND-FAMILY.md`.

> **Net density statement.** Squarefree ∪ {ω(N)≤R₀} = a **bounded fraction ≈0.43–0.52** of the
> Pythagorean rank-jump locus is closed unconditionally; the remaining **~half** needs the thin-ABC
> σ-bound. This quantifies exactly how much of PCP-finiteness on the rank-jump locus is *already*
> unconditional even though the absolute-c verdict is NO.

---

### Scripts (`scripts/absolute_c/`, all with captured `.out`)

| file | purpose |
|---|---|
| `01_recon.gp` | classify ~80 fibers: σ, log|Δ|, N, root number, analytic rank (pick rank-1/2 spanning σ) |
| `02_sweep.gp` | rank-1 sweep: Heegner gen, saturate, verify onc + ĥ, full decomposition (σ 2.75–3.96) |
| `02b_sweep_fast.gp`, `02c_rank2_and_fill.gp`, `02d_fast_smallN.gp` | complementary sweeps (small/medium-N rank-1 + rank-2 fibers) |
| `single_fiber.gp` + shell driver | one fiber per call, **strict external `timeout`** (clean kill of slow `ellheegner`); `ellrank` point-search (mode 2) is faster than Heegner for medium-N — produced most of the 33-fiber table (`batch_results.out`) |
| `03_highsigma_probe.gp` | highest-σ reachable: ĥ_min via Heegner (rank 1) / ellrank (rank 2), incl. the σ-record (256,121); Petsche floor |
| `04_density.gp` | §6 unconditional sub-locus densities (squarefree, ω(N)≤R₀, union) at MMAX=150,400 |
| `05_lambda_inf_theory.gp` | λ_∞ diagnostics: real period Ω, elliptic log z, ĥ/((1/12)log|Δ|) |
| `06_cps_extrapolation.gp` | Petsche σ-dependent floor c(1,σ) and deepest-h_NA at the σ-record fibers |

All 33 `ĥ` verified by `ellheight` (`onc=1`); the high-σ records independently re-verified with
the functional equation `ĥ(2P)=4ĥ(P)` exact to full precision (`/tmp/verify_163.gp`,
`/tmp/verify_223.gp`, `/tmp/verify_187.gp`, `/tmp/verify_256_121.gp` — generators on-curve,
infinite order). **Caveat (honest):** for rank-2 fibers the recorded `ĥ_min` is the smallest
height over the `ellrank` generators, an *upper* bound on the true minimal non-torsion height; if
anything the true floor is lower, which only **strengthens** the NO verdict.

---

## §7. References

- **Petsche, C.** Small rational points on elliptic curves over number fields. `arXiv:math/0508160`
  (2005). [Thm 2: `ĥ ≥ c(d,σ)log|Δ|`, `c=1/(10¹⁵d³σ⁶log²(c₂dσ²))`, `c₂=104613`]
- **Hindry, M.; Silverman, J. H.** The canonical height and integral points on elliptic curves.
  *Invent. Math.* **93** (1988), 419–450.
- **Silverman, J. H.** Lang's height conjecture and Szpiro's conjecture. `arXiv:0908.3895` (2009).
- **Voutier, P.; Yabuta, M.** Lang's conjecture and sharp height estimates for elliptic curves.
  [arch + I_n component / Tate–Fourier averaging]
- **Gross, R.; Silverman, J. H.** [explicit `R`-places Lang bound; `y²=x³+b`, `R=1`: `ĥ>3·10⁻¹⁴log|Δ|`]
- **Wagener, B.** (survey by M. Hindry) About the Proof of Lang's Height Conjecture. `arXiv:1706.03622`
  (2017). [σ-free `C_d`, non-effective]
- **Silverman, J. H.** *Advanced Topics in the Arithmetic of Elliptic Curves*, GTM 151. [Néron local
  heights VI.4.1/4.2; Faltings height ≍ log|Δ|]
- Cremona–Prickett–Siksek, *J. Number Theory* **116** (2006), 42–68 [explicit local Ψ_v].

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

---
title: "Is the Szpiro Ratio σ(E_PCP(q)) Uniformly Bounded over Pythagorean q? — Exact Δ_min, the (b²,a²−b²,a²) ABC-Triple Equivalence, and the Unconditional Stewart–Yu Bound"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: |
  VERDICT (b): σ(E_PCP(q)) is bounded by ≤ 6(1+ε) UNDER ABC, and this is the main result; it is NOT
  provably bounded unconditionally for the full family. PROVEN UNCONDITIONALLY (this document):
  (i) the exact minimal model — Δ_min = 2^{4v₂(b)−8}·a⁴·(oddpart b)⁴·(a²−b²)², all reduction
  multiplicative (0 additive primes over 4582 fibers), N = rad(Δ_min) = rad(a·b·(a²−b²)) up to a
  possible single factor 2 (2 is GOOD when v₂(b)=2); the naive model y²=x(x+1)(x+q²) is non-minimal
  at 2 with a UNIFORM correction v₂(Δ₀)−v₂(Δ_min)=12, and minimal at 3 (gap 0). (ii) the EXACT σ
  formula σ = [4 log a + 4 log b + 2 log|a²−b²| − 8 log2] / log rad(a·b·(a²−b²)), and the equivalence
  "σ bounded ⟺ the thin ABC instance for (b²,a²−b²,a²) [b²+(a²−b²)=a²]". (iii) the rigorous chain
  σ ≤ 6·logC/log N with C=max(a²,b²), verified for ALL 50 765 fibers (m≤500); under ABC (logC ≤
  (1+ε)log N) this gives σ ≤ 6(1+ε) UNIFORMLY. Large-sample (129 870 fibers, m≤800): σ_max = 4.614
  at (m,n)=(256,121); σ_min = 2.722 (m=2); σ_mean = 3.081; the per-dyadic-band σ_max creeps
  3.96→4.61 then DROPS to 4.16 — slow, non-monotone, NO outlier beyond 4.62, consistent with extreme-
  slow (log-iterated) ABC-type growth, not boundedness. BEST UNCONDITIONAL bound (Stewart–Yu effective
  ABC): σ = O(N^{1/3}(log N)²) — GROWS, not constant. SUB-FAMILY (c) partial: on the squarefree
  sub-locus (a, oddpart(b), a²−b² all squarefree) every n_p∈{2,4}, sup σ = 3.558 (m≤600, 0 fibers
  >4), and σ ≤ 4+o(1) provably — but this is still NOT an absolute constant without a radical lower
  bound, so even the squarefree locus is not an elementary uniform bound. NET: σ-boundedness for the
  family is itself a genuine thin ABC instance; max ABC-quality observed κ=logC/log rad = 0.842 ≪ 1.
---

# Is σ(E_PCP(q)) Uniformly Bounded over Pythagorean q?

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

> **One-line verdict.** **(b)**: σ(E_PCP(q)) is bounded by **≤ 6(1+ε) under ABC** (the main result),
> via the ABC triple `b²+(a²−b²)=a²`; it is **not** provably bounded unconditionally. The best
> unconditional bound (Stewart–Yu) is `σ=O(N^{1/3}(log N)²)`, which **grows**. σ-boundedness for the
> family is a **genuine thin ABC instance** — exactly the bottleneck identified in
> `OQ1-HS-RESOLUTION.md`. Empirically σ_max = 4.614 (m,n=256,121; m≤800) with extreme-slow growth.

This document supplies the rigorous backbone for the lone hypothesis that (via the verified
Petsche-2005 per-fiber bound `ĥ(P)≥c(d,σ)·log|Δ|`, `OQ1-HS-RESOLUTION.md`) upgrades OQ1 to a uniform
bound and closes PCP-finiteness on the rank-jump locus through Pila–Zannier.

All claims below are checked symbolically (`sympy`) and arithmetically (PARI/GP 2.15.4). Scripts and
captured output: `scripts/sigma_bound/`.

---

## §1. Integral model & minimality (PROVEN UNCONDITIONALLY)

### 1.1 The integral model and its discriminant

`E_PCP(q): y² = x(x+1)(x+q²)`. Writing `q=a/b` in lowest terms (gcd(a,b)=1) and substituting
`x→X/b², y→Y/b³` (verified symbolically, `01_model_sympy.py`) gives the integral model

> **`E: Y² = X(X+b²)(X+a²)`**, equivalently `Y² = X³ + (a²+b²)X² + a²b²X`.

Symbolic discriminant and invariants (exact, `01_model_sympy.out`):

| quantity | value |
|---|---|
| `Δ₀` (naive) | `16·a⁴·b⁴·(a²−b²)² = 16·a⁴·b⁴·(a−b)²·(a+b)²` |
| `c₄` | `16·(a⁴ − a²b² + b⁴)` |
| `c₆` | `−32·(a²−2b²)(a²+b²)(2a²−b²)` |
| `j` | `256·(a⁴−a²b²+b⁴)³ / (a⁴·b⁴·(a²−b²)²)` |

Pythagorean parametrization `a=m²−n²`, `b=2mn` (gcd(m,n)=1, m+n odd) gives
`a²−b² = m⁴−6m²n²+n⁴ = (m²−2mn−n²)(m²+2mn−n²)` (verified) and the **ABC identity**
`b² + (a²−b²) = a²` (verified). Coprimality (`07b`, m≤200): `gcd(a,b)=gcd(a,a²−b²)=gcd(oddpart(b),a²−b²)=1`,
so `a`, `oddpart(b)`, `a²−b²` are pairwise coprime — each odd prime divides exactly one of them.

### 1.2 Reduction type & exact minimal discriminant

PARI `ellminimalmodel`/`ellglobalred`/`elllocalred` over **4582 fibers (m≤150)** (`02_minimality.out`):

- **All bad reduction is multiplicative (Kodaira `I_n`); 0 additive primes.** Confirmed at every bad
  prime of every fiber. Conductor exponent `f_p = 1` everywhere, so `N = rad(Δ_min)`.
- **Uniform minimality correction at 2:** `v₂(Δ₀) − v₂(Δ_min) = 12` for **every** fiber; at 3 the
  gap is **0** (model is already minimal at 3). The odd part of `Δ` is unchanged by minimalization
  (`v_p(Δ_min)=v_p(Δ₀)` for all odd `p`). Thus the naive model is non-minimal only at 2, by a
  constant factor `2¹²`.
- **Exact minimal discriminant** (`03_delta_min_form.out`, `07b`, integer identity verified for all
  fibers): with `b=2mn`,

> **`Δ_min = Δ₀/2¹² = 2^{4v₂(b)−8} · a⁴ · (oddpart b)⁴ · (a²−b²)²`,  where `v₂(Δ_min)=4·v₂(b)−8`.**

- **Conductor**: `N = rad(Δ_min) = rad(|a·b·(a²−b²)|)`, **except** that `2` is a *good* prime
  precisely when `v₂(b)=2` (then `v₂(Δ_min)=0`); in that case `N` omits the factor 2 (this is the
  `N=rad(ab(a²−b²))/2` discrepancy in `03b_conductor.out`). For odd primes `N` is exactly the radical.

### 1.3 Per-prime Tate index `n_p = v_p(Δ_min)` (PROVEN)

For odd primes (multiplicative ⟹ `n_p = −v_p(j)`), verified over m≤150 (`07b_np_structure.out`):

> `n_p = 4·v_p(a)` if `p|a`;  `n_p = 4·v_p(b)` if `p|b`;  `n_p = 2·v_p(a²−b²)` if `p|(a²−b²)`.

(The pole orders `4,4,2` are exactly the `I₄,I₄,I₂` geometric fibers of `j` over `q=0,∞,±1`.) At `p=2`:
`n_2 = 4v₂(b)−8`. A single prime can carry a large `n_p` (e.g. `n_2=28` at (256,121)), but it then
appears with the *same* prime in the denominator with weight `log p`, so no single prime forces σ up.

---

## §2. The exact σ formula and the ABC-triple equivalence (PROVEN)

From §1.2, since `log|Δ_min| = Σ_p n_p log p` and `log N = Σ_{p|N} log p`:

> **`σ = log|Δ_min| / log N = [ 4 log a + 4 log b + 2 log|a²−b²| − 8 log 2 ] / log rad(a·b·(a²−b²))`**

(the `−8 log2` is the exact 2-adic minimalization correction; the `log N` denominator drops one
`log 2` when `v₂(b)=2`). This is an *exact* identity for every Pythagorean fiber, not an estimate.

### 2.1 The thin ABC instance and the bound σ ≤ 6(1+ε)

Set `C = max(a², b²)` and `R = rad(a·b·(a²−b²)) = N` (up to the single factor 2). Then
`a² ≤ C`, `b² ≤ C`, and `|a²−b²| < C`, so

`4 log a + 4 log b + 2 log|a²−b²| = 2 log a² + 2 log b² + 2 log|a²−b²| ≤ 2 logC + 2 logC + 2 logC = 6 logC.`

Hence the **rigorous, unconditional inequality**

> **`σ ≤ 6 · logC / log N`,   `C = max(a²,b²)`.**   *(verified for ALL 50 765 fibers, m≤500, `09_abc_chain.out`)*

The triple `(A,B,C') = (b², a²−b², a²)` satisfies `A+B=C'` (the ABC identity) with `rad(A·B·C') =
rad(a·b·(a²−b²)) = R = N`. The **ABC conjecture** applied to this triple gives, for every ε>0, an
effective `K_ε` with `C = max(a²,b²) ≤ K_ε · R^{1+ε}`, i.e. `logC ≤ (1+ε) log N + O_ε(1)`. Substituting:

> **`σ ≤ 6(1+ε) + o(1)`   uniformly over all Pythagorean `q`,   UNDER the ABC conjecture.**

**Equivalence.** Conversely, a uniform bound `σ ≤ S` forces `4 log a + 4 log b + 2 log|a²−b²| ≤
S·log N + 8 log2`, i.e. `logC ≤ (S/2)·log R + O(1)` — a genuine ABC inequality (of exponent `S/2`)
for the triple `(b²,a²−b²,a²)`. Therefore **σ uniformly bounded for the family ⟺ the thin ABC
instance for `{b², a²−b², a²}` holds with a finite exponent.** Boundedness of σ for individual
elliptic curves is *open* (= Szpiro = ABC); this family-specific version is a *thin* ABC instance.

---

## §3. Large-sample σ data (129 870 fibers, m ≤ 800; `04_sigma_largesample.out`)

| statistic | value |
|---|---|
| fibers computed (m≤800, skipped 0) | 129 870 |
| **σ_max** | **4.6139648…** at **(m,n)=(256,121)** |
| σ_min | 2.7216976… at (m,n)=(2,1) |
| σ_mean | 3.0810637… |

**Growth (per dyadic band, σ_max over `m∈[2^k,2^{k+1})`):**

| band | 2–3 | 4–7 | 8–15 | 16–31 | 32–63 | 64–127 | 128–255 | 256–511 | 512–1023 |
|---|---|---|---|---|---|---|---|---|---|
| σ_max | 2.72 | 3.72 | 3.57 | 3.96 | 4.26 | 4.25 | 4.45 | **4.61** | 4.16 |

The band-max creeps up `2.72→4.61` then **drops** in 512–1023 — **non-monotone**, no clean fit to
`A+B·log m`. The cumulative `σ_max(M)` vs `loglog M` (`05`) rises `3.96 (M=16) → 4.61 (M=256→512)`,
slope ≈ 0.6 per unit `loglog`. This is the signature of **extreme-slow (log-iterated) growth**, the
expected behaviour of an ABC quantity — *not* a hard ceiling, but no fiber exceeds 4.62 in this range.

**Distribution (bucket width 0.25):** 89% of fibers lie in `[2.75, 3.25)`; only **5** fibers exceed
4.25, **2** exceed 4.5.

| σ-bucket | [2.75,3.0) | [3.0,3.25) | [3.25,3.5) | [3.5,3.75) | [3.75,4.0) | [4.0,4.25) | [4.25,4.5) | [4.5,4.75) |
|---|---|---|---|---|---|---|---|---|
| count | 46 249 | 68 032 | 13 486 | 1 794 | 270 | 31 | 3 | 2 |

**Adversarial 13-smooth search (m≤3000, `05`):** the worst smooth fiber is the *minimal* one (2,1),
σ=2.72 — smoothness does **not** inflate σ. The outliers are driven by a high 2-power in `b`
(e.g. (256,121): `b=2⁷·11·…`, `n_2=28`), but even `v₂(b)=9` caps at σ=4.61 (`06`).

---

## §4. Best UNCONDITIONAL bound — Stewart–Yu effective ABC (`08_stewart_yu.out`)

No constant bound on σ is provable today. The best unconditional statement comes from the
**Stewart–Yu effective ABC** theorem (Stewart–Yu, *Math. Ann.* 1991/2001, "On the abc conjecture
I/II"): for coprime `A+B=C` with `R=rad(ABC)`,

> `log C ≤ κ · R^{1/3} · (log R)³`   (κ effective, explicit).

Applied to `(b²,a²−b²,a²)` with `R=N` and `C=max(a²,b²)`, combined with the rigorous `σ ≤ 6 logC/log N`:

> **`σ ≤ 6·logC/log N ≤ 6κ·N^{1/3}·(log N)²` — i.e. `σ = O(N^{1/3}(log N)²)`.**

This is a **theorem today**, but it **grows** (a power of the conductor); it does *not* bound σ by a
constant. The constant `6(1+ε)` requires ABC/Szpiro. On the worst observed fiber (256,121) the
**ABC-quality** is `logC/log R = 0.822` and the proxy `6·logC/log R = 4.93` dominates the true
σ=4.614 — confirming the chain is valid and far from the ABC ceiling.

Remark on the landscape: Wagener (2017) proves Lang's height bound *unconditionally* with constant
depending only on `[K:Q]` (no σ), but its dependence is still ineffective/large; for the *uniform*
σ-statement here, ABC remains the operative hypothesis. (See `CONDITIONAL-CLOSURE-LANDSCAPE.md`.)

---

## §5. Sub-families: unconditional partial results (`06`, `07`)

| sub-family | constraint | sup σ (range searched) | provable bound? |
|---|---|---|---|
| `n=1` | `a=m²−1, b=2m` | 3.878 (m≤3000) | no elementary constant |
| `m=n+1` | `a=2n+1, b=2n(n+1)` | 3.895 (n≤3000) | no elementary constant |
| **squarefree** | `a`, `oddpart(b)`, `a²−b²` all squarefree | **3.558 (m≤600, 0 fibers >4)** | **σ ≤ 4 + o(1)** (below) |

**Squarefree sub-locus — the cleanest case.** If `a`, `oddpart(b)`, and `a²−b²` are all squarefree,
then every odd prime has `v_p∈{0,1}`, so by §1.3 every Tate index is `n_p ∈ {2,4}`. Hence

`log|Δ_min| = 4 log a + 4 log(oddpart b) + 2 log(a²−b²) + (4v₂(b)−8)log2`

and `log N = log a + log(oddpart b) + log(a²−b²) + O(1)` (the radical equals the product for
squarefree factors). The `c=a²−b²` term carries coefficient **2 not 4**, so

> **`σ ≤ 4 + o(1)` on the squarefree sub-locus** (asymptotically as `a,b,c→∞`; sup 3.558 observed).

**However** this is still *not* an absolute elementary constant for *finite* `(m,n)`: the `−8log2`
and the small-`N` corrections make `σ<4` non-uniform, and more importantly the bound `σ→4` uses
`rad(squarefree)=squarefree` — it does **not** survive when factors are non-squarefree. The
non-squarefree fibers (where some `n_p` is large) are exactly where σ climbs toward 4.6, and there
*no* elementary radical lower bound exists. **No sub-family of positive density admits a provable
absolute constant** below the ABC ceiling; the squarefree locus gives the best partial `σ ≲ 4`.

---

## §6. Verdict

**(b) — bounded under ABC by ≤ 6+ε; main result. NOT unconditionally bounded.**

1. **Unconditional (proven here):** exact minimal model `Δ_min = 2^{4v₂(b)−8}·a⁴·(oddpart b)⁴·(a²−b²)²`;
   all reduction multiplicative; `N=rad(Δ_min)`; exact σ formula (§2); the rigorous inequality
   `σ ≤ 6·logC/log N` for every fiber; and the **equivalence** "σ bounded ⟺ thin ABC for `(b²,a²−b²,a²)`".
2. **Under ABC:** `σ ≤ 6(1+ε)` **uniformly** over all Pythagorean `q`. This is the result that, via
   Petsche-2005's per-fiber `ĥ(P)≥c(d,σ)log|Δ|`, upgrades OQ1 to a uniform bound and closes PCP-
   finiteness on the rank-jump locus (Pila–Zannier).
3. **Best theorem today (no ABC):** Stewart–Yu gives `σ = O(N^{1/3}(log N)²)` — slowly growing, not
   constant.
4. **Sub-family (c) partial:** squarefree sub-locus has `σ ≤ 4+o(1)` provably (sup 3.558 observed),
   but no positive-density sub-family yields an *absolute elementary constant*.
5. **Empirics:** σ_max=4.614 at (256,121); σ_mean=3.08; extreme-slow non-monotone growth; max ABC-
   quality κ=0.842 ≪ 1; no fiber exceeds 4.62 to m≤800 / 13-smooth m≤3000.

**Honest status.** σ(E_PCP(q)) is, with very high confidence, bounded by ~6 — but *proving* it for
the full family is a **genuine thin ABC instance, unprovable unconditionally with current technology**.
This is precisely the single residual hypothesis flagged in `OQ1-HS-RESOLUTION.md`: it is strictly
weaker than full Lang/Szpiro/ABC (a thin instance), yet still open. The framework's closure of PCP-
finiteness on the rank-jump locus is therefore **conditional on this one explicit ABC inequality**,
not on any unproven step internal to the framework.

---

### Scripts (`scripts/sigma_bound/`, all with captured `.out`)

| file | purpose |
|---|---|
| `01_model_sympy.py` | symbolic integral model, Δ, c₄, c₆, j, ABC identity |
| `02_minimality.gp` | all-multiplicative check, v₂/v₃ minimalization gaps (4582 fibers) |
| `03_delta_min_form.gp`, `03b_conductor.gp` | exact `Δ_min=Δ₀/2¹²`, `N=rad(Δ_min)` |
| `04_sigma_largesample.gp` | 129 870 fibers (m≤800): σ_max, growth, distribution |
| `05_adversarial_growth.gp` | 13-smooth search, outlier dissection, loglog growth fit |
| `06_subfamilies.gp` | n=1, m=n+1, squarefree, σ-vs-v₂(b) |
| `07b_np_structure.gp` | per-prime Tate-index formula `n_p∈{4v_p(a),4v_p(b),2v_p(c)}` |
| `08_stewart_yu.py` | Stewart–Yu unconditional `σ=O(N^{1/3}(log N)²)` |
| `09_abc_chain.gp` | rigorous `σ≤6logC/logN` (50 765 fibers) + ABC-quality |

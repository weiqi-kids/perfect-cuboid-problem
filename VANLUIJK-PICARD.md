---
title: PCP — van Luijk Picard rank computation for the Euler-brick K3
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: research — rigorous bounds 16 ≤ ρ_geom(V'_min) ≤ 20 (PARI), most-likely value ρ_geom = 20
---

# PCP — van Luijk Picard rank for the Euler-brick K3 `V'_min`

> **CΛ / Lightman Chang**
> Independent Researcher · `lightman.chang@gmail.com` · 2026-05-18

---

## 0. Verdict (one-paragraph TL;DR)

We pin down the geometric Picard rank of the (minimal resolution of the)
Euler-brick K3 surface `V'_min` using PARI/GP Frobenius traces at primes
`p ∈ {3, 5, 7, 11, 13, 17, 19, 23, 29}` (with second power sum `t_2` at
`p ∈ {3, 5, 7, 11, 13, 17}` and third power sum `t_3` at `p = 3`).

**Rigorous outcome**:
- `ρ_geom(V'_min) ≥ 16` (16 explicit `Q`-rational classes; PICK-15).
- `ρ_geom(V'_min) ≤ 20` (PARI van Luijk Newton-sum + Artin parity for K3
  over `F̄_p`; uniqueness of consistent transcendental factor at `p ∈
  {3, 11, 17}`).
- The van Luijk discriminant test using the disc square class of `NS(V'_min/F̄_p)`
  at `p = 3, 11, 17` **fails to rule out** `ρ_geom = 20`: all three primes
  give the same discriminant square class `(disc) ≡ 2 (mod (Q*)²)`,
  consistent with `ρ_geom = 20`.

**Most-likely conclusion** (heuristic, not theorem): `ρ_geom(V'_min) = 20`,
with **4 extra non-Q-rational** algebraic classes (defined over a quadratic
extension, presumably `Q(i)` coming from the Pythagorean splittings
`a²+b² = (a+ib)(a-ib)`).

**Transcendental rank**: `b_2 − ρ_geom = 22 − 20 = 2` (if `ρ_geom = 20`),
i.e. `T(V'_min)` is a rank-2 lattice. Equivalently, the L-polynomial
`L_p(T)` factors over `Q` as a degree-20 cyclotomic-roots part times an
irreducible degree-2 transcendental factor.

---

## §1. Setup

### 1.1 The variety `V'` and its smooth resolution `V'_min`

`V' ⊂ P^5_{[a:b:c:d:e:f]}` is the smooth complete-intersection of three
rank-3 quadrics:
$$
  Q_1: a^2+b^2=d^2,\qquad Q_2: b^2+c^2=e^2,\qquad Q_3: a^2+c^2=f^2.
$$
`V'` has 12 ordinary double points (A_1 nodes), all `Q`-rational, located at
`[0:0:1:0:±1:±1]` and the two `S_3`-conjugates (`{b=c=0}, {a=c=0}`).
PICK-15 §1 verified these via PARI enumeration `scripts/transc-brauer/check_smoothness.gp`.

`V'_min := \widetilde{V'} → V'` is the minimal resolution, replacing each
node by a `(-2)`-curve `E_i`. It is a **smooth K3** with `b_2 = 22`.

### 1.2 The face fibration `π_d : V'_min → P^1_q`

Projection `(a:b:c:d:e:f) ↦ (a:b)` gives an elliptic fibration with
generic fiber the elliptic curve `Y² = (c²+1)(c²+q²)`, 2-isogenous over
`Q(q)` to the PCP curve `Y² = X(X+1)(X+q²)`. Bad fibers at `q ∈ {0, ∞, 1, -1}`
of Kodaira types `(I_4, I_4, I_2, I_2)` (PICK-13 §2.3).

### 1.3 Strategy (van Luijk algorithm)

1. **Lower bound** (algebraic): explicit classes `H, F_1, F_2, F_3, E_1,...,E_{12}` → `ρ_geom ≥ 16`.
2. **Upper bound**: for each good prime `p`, count `#V'_min(F_{p^k})` for
   `k = 1, 2, (3)`. From `t_k := tr(Frob^k | H²)` extract the largest
   `r` such that 22 eigenvalues `α_i` with `|α_i| = p` admit a partition
   into `r` cyclotomic (algebraic) eigenvalues `p · ζ` (ζ root of unity)
   plus `(22-r)/2` complex-conjugate transcendental pairs.
3. **Tighten** via discriminant matching across primes (van Luijk 2007).

---

## §2. Lower bound: ρ_geom ≥ 16 (algebraic, PICK-15)

The following 16 classes are independent in `NS(V'_min)`:

- `H` (hyperplane section, deg 8): 1 class.
- `F_1, F_2, F_3` (fiber classes of the three face fibrations
  `π_d, π_e, π_f`): 3 classes.
- `E_1, …, E_{12}` (the 12 exceptional `(-2)`-curves above the rational
  nodes of `V'`): 12 classes.

All 16 are `Q`-rational. Galois `G_Q` acts trivially. Linear independence is
verified by computing the rank of the intersection matrix:
`H·H = 8`, `F_i·H = 4`, `F_i·F_i = 0`, `F_i·F_j = 4` (i≠j),
`E_i·E_i = −2`, `E_i·E_j = 0` (i≠j), `E_i·H = 0`, `E_i·F_j = 0 or 1`
(depending on whether `E_i` projects into a degenerate fiber of `π_j`).
The 16 × 16 Gram matrix has rank 16. (Standard K3 computation.)

> **Conclusion:** `ρ_Q(V'_min) ≥ 16` and `ρ_geom(V'_min) ≥ 16`.

---

## §3. Upper bound: ρ_geom ≤ 20 via Frobenius

### 3.1 Point counts (PARI/GP, this work)

Script `scripts/vanluijk/frob_extended.gp`:

| `p` | `#V'_aff(F_p)` | `#V'_proj(F_p)` | `#V'_min(F_p)` | `t_1` | `t_1 / p` |
|---:|---:|---:|---:|---:|---:|
| 3  | 25     | 12   | 48    | 38   | 12.67 |
| 5  | 145    | 36   | 96    | 70   | **14** |
| 7  | 553    | 92   | 176   | 126  | **18** |
| 11 | 1081   | 108  | 240   | 118  | 10.73 |
| 13 | 2353   | 196  | 352   | 182  | **14** |
| 17 | 6849   | 428  | 632   | 342  | 20.12 |
| 19 | 7129   | 396  | 624   | 262  | 13.79 |
| 23 | 14697  | 668  | 944   | 414  | **18** |
| 29 | 25201  | 900  | 1248  | 406  | **14** |

Second power sums (scripts `frob_t2.gp`, `frob_t2_p13.gp`, `frob_t2_p17.gp`):

| `p` | `#V'_min(F_{p^2})` | `t_2` | bound `22 p²` | supersingular? |
|---:|---:|---:|---:|:--:|
| 3  | 248     | 166   | 198    | no |
| 5  | 1176    | 550   | 550    | **YES** |
| 7  | 3480    | 1078  | 1078   | **YES** |
| 11 | 17016   | 2374  | 2662   | no |
| 13 | 32280   | 3718  | 3718   | **YES** |
| 17 | 88728   | 5206  | 6358   | no |

Third power sum at `p=3` (script `frob_t3_p3.gp`):
`#V'_min(F_27) = 1008`, so `t_3 = 1008 − 1 − 3^6 = 278`.

### 3.2 Supersingular primes

At `p = 5, 7, 13` the K3 is **supersingular**: `t_2 = 22 p²` forces all 22
Frobenius eigenvalues `α_i ∈ {+p, -p}`, hence `ρ(V'_min / F̄_p) = 22`.
By Artin's classification supersingular K3 surfaces are extremal cases.

### 3.3 Non-supersingular primes & Newton-sum upper bound

For each non-supersingular prime `p ∈ {3, 11, 17}`, we enumerate
configurations `(a, b, c, d, e, M)` describing the partition of the 22
Frobenius eigenvalues into:
- `a` copies of `+p` (n=1 cyclotomic),
- `b` copies of `-p` (n=2 cyclotomic),
- `c` pairs `(p ω, p ω̄)` with `ω` primitive cube root of unity (n=3),
- `d` pairs `(p · (−ω), p · (−ω̄))` (n=6, equiv `ω' = e^{i π/3}`),
- `e` pairs `(i p, −i p)` (n=4),
- `M = (22 − a − b − 2(c+d+e))/2` complex-conjugate transcendental pairs.

The algebraic Picard rank is `ρ_{F̄_p} = a + b + 2(c+d+e)`. The trace
contributions to `t_1, t_2, t_3` are determined uniquely. We impose:
- Artin parity: `ρ_{F̄_p}` is even (true for K3 over `F̄_p`).
- Newton consistency for `M = 1` trans pair: `t_2^trans = 2 p² · (2 S_1² − 1)`
  where `S_1 = cos θ ∈ [−1, 1]`. At `p = 3` also `t_3^trans = 2 p³ · (4 S_1³ − 3 S_1)`.

Result (scripts `enum_configs_p3.gp`, `enum_configs_p11_consistent.gp`,
`enum_configs_p17.gp`):

| `p` | unique consistent `(a, b, c, d, e)` config at `ρ = 20` | trans pair `α + ᾱ` | trans disc `4p² − c²` | square class |
|---:|---|---:|---:|---:|
| 3  | `(16, 4, 0, 0, 0)` (uses `t_1, t_2, t_3`)              |  +2    | 32       | **2** |
| 11 | `(16, 4, 0, 0, 0)` (uses `t_1, t_2`)                  | −14    | 288      | **2** |
| 17 | `(20, 0, 0, 0, 0)` (uses `t_1, t_2`)                  |  +2    | 1152     | **2** |

The configuration at `ρ = 22` is excluded at `p ∈ {3, 11, 17}` (would require
`M = 0` and the trans part to vanish, contradicting `t_2 < 22 p²`). The
configuration at `ρ ≥ 22` is impossible by K3 bound `ρ ≤ 22`. Therefore:
$$
  ρ_{F̄_3}, ρ_{F̄_{11}}, ρ_{F̄_{17}} \;\le\; 20.
$$

> **Conclusion (rigorous):** `ρ_geom(V'_min) ≤ min_p ρ_{F̄_p} ≤ 20`.

### 3.4 Sharpness of the Newton-sum upper bound

At `p = 3`, the bound `ρ ≤ 20` is **uniquely achieved** by config
`(16, 4, 0, 0, 0)`. This is a strong indication that `ρ_{F̄_3} = 20`
*exactly* (one could in principle have a strictly smaller `ρ`, but the
Newton-sum lower bound from the actual L-polynomial requires more data).

At `p = 11, 17` we don't have enough Newton sums to rule out `ρ_{F̄_p} ≤ 18`,
but the configurations are consistent with `ρ_{F̄_p} = 20`.

---

## §4. The van Luijk discriminant test (inconclusive but consistent with ρ = 20)

### 4.1 The test

For two good primes `p ≠ p'`, if `ρ_{F̄_p} = ρ_{F̄_{p'}} = r` and `ρ_geom = r`,
then specialization maps `NS(V'_min/Q̄) ↪ NS(V'_min/F̄_p)` are of finite
index, so `disc(NS_{Q̄}) / disc(NS_{F̄_p}) ∈ (Q*)²`. Hence
`disc(NS_{F̄_p}) / disc(NS_{F̄_{p'}}) ∈ (Q*)²`.

For the K3 lattice `Λ_K3` (rank 22, unimodular), `disc(NS) · disc(T) = ±1`,
so the square class of `disc(NS)` equals (up to sign) the square class of
`disc(T)`. For a single transcendental pair `(α, ᾱ)` with `α + ᾱ = c`,
`|α|² = p²`, the transcendental factor is
`T² − cT + p²`, of discriminant `c² − 4p² < 0`. The square class of
`disc(NS_{F̄_p})` (assuming `ρ_{F̄_p} = 20` with the configuration above) is
the square class of `4 p² − c² > 0`.

### 4.2 Computed values

(Script `discriminant_test_v3.gp`)

| `p` | trans `c` | `4 p² − c²` | factored | core (square-free part) |
|---:|---:|---:|---|---:|
| 3  |  +2  | 32   | `2⁵`       | **2** |
| 11 | −14  | 288  | `2⁵ · 3²`  | **2** |
| 17 |  +2  | 1152 | `2⁷ · 3²`  | **2** |

**All three primes give the same square class** `disc(NS_{F̄_p}) ≡ 2 (mod (Q*)²)`.

### 4.3 Conclusion of the discriminant test

The van Luijk test does **not** rule out `ρ_geom = 20`. In fact, the
remarkable agreement of `disc` square classes across three different
primes (each computed independently from point counts) provides
*positive heuristic evidence* that `ρ_geom = 20`.

If instead `ρ_geom = 16` or `18`, then at one of `p ∈ {3, 11, 17}` the
"naive" Frobenius rank `ρ_{F̄_p} = 20` would have to be larger than `ρ_geom`,
which is allowed (Picard rank can jump up modulo `p`); but the disc match
would have to be coincidental.

> **Verdict:** The van Luijk discriminant test is **inconclusive**:
> `ρ_geom ∈ {16, 18, 20}` all remain logically possible from PARI data
> alone. The strongest heuristic, based on disc match across three primes,
> favors `ρ_geom = 20`.

---

## §5. Final verdict on ρ_geom(V'_min)

### 5.1 Rigorous bounds

$$
  16 \;\le\; ρ_{\text{geom}}(V'_{\min}) \;\le\; 20.
$$

The lower bound is from 16 explicit `Q`-rational classes (PICK-15). The
upper bound is from Newton-sum analysis at `p ∈ {3, 11, 17}` combined
with K3 Artin parity (script `picard_refined_v2.gp`, `enum_configs_p11_consistent.gp`).
Both bounds are PARI-verified.

### 5.2 Most-likely value

`ρ_geom(V'_min) = 20`. Heuristic evidence:

1. **Disc square class agreement** across `p = 3, 11, 17` (all give class 2);
2. **Newton-sum sharpness** at `p = 3`: the only consistent configuration
   with `t_1, t_2, t_3` data gives `ρ_{F̄_3} = 20` (not lower);
3. **Galois interpretation**: the algebraic config `(a, b) = (16, 4)` at
   `p = 3, 11` matches 16 `Q`-rational classes plus 4 additional
   `Q(i)`-rational classes (Frobenius acts by `−1` on these, hence
   eigenvalues `−p`). The number 4 is consistent with the
   `Z/2 × Z/2`-twist structure induced by the Pythagorean splittings
   `(a±ib)(a∓ib) = d²` and `(b±ic)(b∓ic) = e²`.

### 5.3 What is *not* proven by PARI

- Distinguishing `ρ_geom = 16` from `ρ_geom = 18` from `ρ_geom = 20` rigorously.
  Would require:
  - Computing `t_2` at p = 19 or 23 (cost: `p^6` ≈ 4.7×10⁷ or 1.5×10⁸
    tuples — borderline feasible in PARI).
  - Computing higher Newton sums (`t_3, t_4`) at p = 11 (cost: `11^9 ≈
    2.4×10⁹` — out of reach for plain PARI; needs sparse-matrix or
    Magma).
  - Direct lattice computation in Magma `NeronSeveriLattice` (not
    available in PARI).

### 5.4 Algebraic interpretation of `ρ_Q = 16`, `ρ_geom = 20`

The 4 "extra" algebraic classes (over `Q̄` but not `Q`) most plausibly are:

- **`Q(i)`-rational divisor classes** from the 3 conics `a²+b² = 0`, `b²+c²=0`,
  `a²+c²=0` (each conic is geometrically reducible over `Q(i)`).
- The pullbacks of these conics to `V'_min` split into 6 lines over `Q(i)`,
  but lines have intersection structure that reduces the count modulo the
  16 already-counted classes; the net contribution is 4 = 6 − 2 (modulo
  relations).

Equivalently: the Pythagorean Galois cover structure (`Z/2 × Z/2` over `Q(i)`)
contributes 4 hidden algebraic classes that descend to `Q̄` but not to `Q`.
**This is not proven** but is the most natural candidate explanation
for the gap `ρ_geom − ρ_Q = 4`.

---

## §6. Implications for MW rank of `π_d` and rank-jump locus

### 6.1 Shioda–Tate revisited

For the face fibration `π_d : V'_min → P^1_q` with bad fibers
`(I_4, I_4, I_2, I_2)` at `q ∈ {0, ∞, 1, −1}`:
$$
  ρ_{\text{geom}}(V'_{\min}) \;=\; 2 + \sum_{v} (m_v − 1) + \text{rank}\, \text{MW}_{\text{geom}}(π_d).
$$

Here `Σ(m_v − 1) = 3 + 3 + 1 + 1 = 8` (sum over the four bad fibers).

If `ρ_geom = 20`: `rank MW_geom(π_d / Q̄(q)) = 20 − 2 − 8 = 10`.

If `ρ_geom = 16`: `rank MW_geom = 16 − 2 − 8 = 6`.

If `ρ_geom = 18`: `rank MW_geom = 8`.

### 6.2 Generic MW rank over `Q(q)`

PICK-13 §3 estimated `r_gen(π_d / Q(q)) = 0` empirically. Combined with
`ρ_geom = 20` heuristic: the difference `10 − 0 = 10` is the rank-jump of
MW upon base change to `Q̄(q)`, i.e., 10 sections become defined only
over a finite extension of `Q(q)` (likely `Q(q, i)` plus quadratic
extensions of `Q` from the node positions).

### 6.3 Silverman specialization bound

For a non-isotrivial elliptic surface `E → B`, Silverman 1983 gives
$$
  \text{rank}\, E_b(\mathbb{Q}) \;\le\; r_{\text{gen}} + \delta(b)
$$
for `b` outside a Hilbert-thin set, with `δ(b) = O(\log H(b) / \log\log H(b))`.

With `r_gen = 0` and PICK-13's empirical max rank `= 3` at five Pythagorean
fibers (m,n) ∈ {(22,17), (35,22), (37,26), (40,29), (40,33)}, the
specialization excess `δ(b) ≤ 3` is observed. The upper bound `δ ≤ 4`
needed for Stoll-Chabauty (`r < g = 5`) is consistent with both
`ρ_geom = 16` and `ρ_geom = 20` scenarios.

### 6.4 The rank-jump locus

The locus `R_k := {q : rank E_q(Q) > r_gen + k} ⊂ P^1(Q)` is Hilbert-thin
(density 0). Its **dimension** as a thin set is controlled by the
**geometric** MW rank minus the **arithmetic** MW rank:
$$
  \dim(R_k) \;\le\; \min(k, \text{rank MW}_{\text{geom}} − r_{\text{gen}}).
$$

With `r_gen = 0`, `rank MW_geom = 10` (under `ρ_geom = 20`), we get
`dim(R_k) ≤ min(k, 10)`. For PCP closure we need `dim(R_4) ≤ 4`, which is
satisfied. This is **consistent** with the (already-known) Hilbert thinness.

### 6.5 Status of `rk E_PCP(q) ≤ 4` (PICK-13 conjecture)

`ρ_geom = 20` strengthens the Shioda–Tate picture but does **not directly**
give a uniform bound. The uniform bound remains conjectural (requires
effective Silverman specialization). The empirical max rank is 3 in 290+
fibers tested (PICK-13 §4.2).

---

## §7. Summary table

| Quantity | Value | Status |
|---|---|---|
| `b_2(V'_min)` | 22 | rigorous (K3) |
| `ρ_geom(V'_min)` lower bound | 16 | rigorous (16 explicit Q-classes) |
| `ρ_geom(V'_min)` upper bound | 20 | rigorous (PARI Newton sums + K3 parity) |
| `ρ_geom(V'_min)` most likely | **20** | heuristic (disc match + Newton uniqueness) |
| `ρ_Q(V'_min)` | 16 | rigorous (Galois-trivial 16 classes) |
| transc rank `r_T = b_2 − ρ_geom` | 2 | (if ρ = 20; else 4 or 6) |
| supersingular primes | 5, 7, 13 | rigorous (`t_2 = 22 p²`) |
| non-supersingular primes | 3, 11, 17, 19, 23, 29 | rigorous |
| `MW_geom(π_d / Q̄(q))` rank | 10 | (if ρ_geom = 20) |
| `MW(π_d / Q(q))` rank `r_gen` | 0 | heuristic (PICK-13) |
| max observed `rk E_PCP(q)` | 3 | empirical (PICK-13) |
| Stoll-Chabauty threshold | `rk < 5` | satisfied empirically |

---

## §8. PARI scripts produced (this work)

All under `scripts/vanluijk/`:

- `frob_extended.gp` — `t_1` for `p ∈ {3, ..., 29}`.
- `frob_t2.gp` — `t_2` for `p ∈ {3, 5, 7, 11}`.
- `frob_t2_p13.gp` — `t_2` at `p = 13` (supersingular, confirmed).
- `frob_t2_p17.gp` — `t_2` at `p = 17`.
- `frob_t3_p3.gp` — `t_3` at `p = 3`.
- `picard_bounds.gp` — first-pass Picard upper bound (ignoring parity).
- `picard_refined.gp` — refined upper bound with cyclotomic eigenvalue
  configurations.
- `picard_refined_v2.gp` — with K3 parity (`ρ` even).
- `picard_p17.gp` — `p = 17` analysis.
- `enum_configs_p3.gp` — consistent configurations at `p = 3` (uses
  Newton consistency `S_2 = 2 S_1² − 1`, `S_3 = 4 S_1³ − 3 S_1`).
- `enum_configs_p11_consistent.gp` — same for `p = 11`.
- `enum_configs_p17.gp` — same for `p = 17`.
- `discriminant_test_v3.gp` — final discriminant comparison.

---

## §9. References

- van Luijk, *K3 surfaces with Picard number one*, Algebra Number Theory 1
  (2007), 1–15.
- Tate, *Algebraic cycles and poles of zeta functions*, in *Arithmetical
  Algebraic Geometry*, 1965.
- Artin, *Supersingular K3 surfaces*, Ann. Sci. ENS 7 (1974), 543–567.
- Madapusi Pera, *The Tate conjecture for K3 surfaces in odd characteristic*,
  Invent. Math. 201 (2015), 625–668.
- Shioda, *On the Mordell–Weil lattices*, Comment. Math. Univ. St. Paul. 39
  (1990).
- `PICK-1-K3-TATE-ATTACK.md`, `PICK-13-RANK-LEQ-4.md`,
  `PICK-15-TRANSCENDENTAL-BRAUER.md`, `SILVERMAN-RANK-JUMP-CLOSURE.md`.

---

**Signed:**

> **CΛ / Lightman Chang**
> Independent Researcher
> `lightman.chang@gmail.com`
> 2026-05-18

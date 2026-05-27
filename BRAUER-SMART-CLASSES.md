---
title: PCP — Smart Brauer–Manin Hilbert-symbol candidate classes on V_q (Track II)
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: research-investigation (NEGATIVE — no obstruction, but locally coherent classes identified)
---

# PCP — Smart Brauer–Manin Hilbert-symbol candidate classes on V_q (Track II)

> **CΛ / Lightman Chang** — Independent Researcher — lightman.chang@gmail.com — 2026-05-18

## 0. Verdict (honest, up front)

Track I (`BRAUER-MANIN-LOCAL.md`) ruled out the "naive face Hilbert symbols"
`(q²+1, c²+1)`, `(*, c²+q²)`, `(*, c²+1+q²)`, … because on V_q the second slot
is a *rational square* and the Hilbert symbol of a square with anything is +1.

Track II tests **fresh** candidates whose first slot `d` is **not** a square on
V_q:
- `d ∈ {e+f, e−f, e+g, e−g, f+g, f−g, e·f, e·g, f·g, e·f·g}`
- `X ∈ {−1, 2, −2, 3, −3, 5, −5, 6, −6, 7, −7, 10, −10, 15}`

Evaluating `d` at the 8 c=0 baseline points of V_q (sign choices of e, f, g)
and computing `inv_p((d, X))` for `p ∈ {2, 3, 5, 7, 11, 13, ∞}`:

### Headline results

| Fiber (m,n) | (d,X) pairs with **constant, nontrivial** local-invariant tuple across all 8 baselines |
|-------------|---------------------------------------------------------------------------------------|
| (61, 38) | **25 / 140** |
| (63, 38) | **24 / 140** |
| (73, 24) | **19 / 140** |
| (88, 35) | **25 / 140** |
| **Total** | **93 / 560** |

> **No (d, X) candidate produces a Brauer–Manin obstruction at the c=0
> stratum.** This is because *global Hilbert reciprocity* — the sum `Σ_p
> inv_p(a, b) = 0` over **all** primes (including ∞) for any rational `a, b ∈
> ℚ*` — holds at every c=0 baseline. So the reciprocity sum cannot itself
> detect obstruction at a *single* rational evaluation point.
>
> However, **93 (d, X) candidates produce a locally coherent invariant
> pattern**: their local-invariant tuple is **constant** across all 8 c=0
> sign-choices, and **nontrivial** (some `inv_p ≠ 0`). These are the
> candidates that descend to a well-defined locally constant function on the
> c=0 stratum of `V_q(𝔸_ℚ)` and merit further investigation as potential
> generators of `Br(V_q)_tr^{G_ℚ}`.

## 1. Methodological correction

In the initial draft of this script I attempted to flag candidates whose
"partial reciprocity sum" over `p ∈ {2, 3, 5, 7, 11, 13, ∞}` was nonzero —
mistaking that for a Brauer–Manin obstruction signal. This is **wrong**:

- The full Hilbert reciprocity `Σ_{all p} inv_p(a, b) = 0` is a *theorem*. It
  holds at any rational point.
- A nonzero **partial** sum over a finite prime subset merely means: some
  prime outside the subset (e.g. one dividing num(d) or den(d) that we did
  not pre-list) carries the missing invariant.
- The Brauer–Manin obstruction is not "sum nonzero at one rational point";
  it is **a specific class `α ∈ Br(V_q)` whose evaluation `inv_p(α(P))` sums
  to a nonzero element of `ℚ/ℤ` for every `P ∈ V_q(𝔸_ℚ)`** — i.e., it is
  about *adèlic* incompatibility, not point-by-point reciprocity.

The correct test we can do with Hilbert-symbol evaluations at baseline points
is:

1. The full-prime-set reciprocity sum must equal 0 at every baseline
   (sanity check passed: 100% of cases).
2. The **invariant tuple** `(inv_p(d, X))_p` should be constant across all
   8 c=0 baselines for the candidate to descend to a *single* class on V_q.
3. The tuple should be nontrivial.

Tests 2+3 give 93 candidates worth examining further. None of these
constitutes an obstruction on its own — we'd need to evaluate the class at
the *non-baseline* adèlic points and check that the sum stays away from 0.

## 2. Setup

For each Pythagorean fiber `(m, n)`:
- `q = 2mn / (m² − n²)`, `w/D = (m² + n²) / (m² − n²) = √(1 + q²)`.
- The 8 baseline points: `(c, e, f, g) = (0, s_e q, s_f, s_g w/D)` with
  `s_e, s_f, s_g ∈ {±1}`.

| Fiber (m, n) | q (num/den) | w/D (num/den) |
|--------------|-------------|---------------|
| (61, 38) | 4636 / 2277 | 5165 / 2277 |
| (63, 38) | 4788 / 2525 | 5413 / 2525 |
| (73, 24) | 3504 / 4753 | 5905 / 4753 |
| (88, 35) | 6160 / 6519 | 8969 / 6519 |

For each `d ∈ {e±f, e±g, f±g, ef, eg, fg, efg}` and `X ∈ {−1, 2, −2, …, 15}`
we compute `inv_p((d, X)) ∈ {0, 1}` (representing `0` or `1/2` ∈ `½ℤ/ℤ`)
at `p ∈ {2, 3, 5, 7, 11, 13, ∞}`.

## 3. Per-fiber tables of constant-nontrivial candidates

Format: `d / X / [inv_2, inv_3, inv_5, inv_7, inv_11, inv_13, inv_∞]`.

### 3.1 Fiber (61, 38) — 25 candidates

| d      | X    | inv tuple (2, 3, 5, 7, 11, 13, ∞) |
|--------|------|-----------------------------------|
| e+f    | 2    | [1, 0, 0, 0, 1, 0, 0] |
| e−f    | 2    | [1, 0, 0, 0, 1, 0, 0] |
| e+g    | 2    | [1, 0, 0, 0, 1, 0, 0] |
| e+g    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e+g    | 10   | [1, 0, 1, 0, 1, 0, 0] |
| e−g    | 2    | [1, 0, 0, 0, 1, 0, 0] |
| e−g    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e−g    | 10   | [1, 0, 1, 0, 1, 0, 0] |
| f+g    | 2    | [1, 0, 0, 0, 1, 0, 0] |
| f+g    | 5    | [1, 0, 0, 0, 0, 0, 0] |
| f+g    | 10   | [0, 0, 0, 0, 1, 0, 0] |
| f−g    | 2    | [1, 0, 0, 0, 1, 0, 0] |
| f−g    | 5    | [1, 0, 0, 0, 0, 0, 0] |
| f−g    | 10   | [0, 0, 0, 0, 1, 0, 0] |
| e·f    | 2    | [1, 0, 0, 0, 1, 0, 0] |
| e·f    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e·f    | 10   | [1, 0, 1, 0, 1, 0, 0] |
| e·g    | 2    | [1, 0, 1, 0, 0, 0, 0] |
| e·g    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e·g    | 10   | [1, 0, 0, 0, 0, 0, 0] |
| f·g    | 2    | [0, 0, 1, 0, 1, 0, 0] |
| f·g    | 10   | [0, 0, 1, 0, 1, 0, 0] |
| e·f·g  | 2    | [1, 0, 1, 0, 0, 0, 0] |
| e·f·g  | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e·f·g  | 10   | [1, 0, 0, 0, 0, 0, 0] |

Bad primes appearing: **2, 5, 11**. Note 11 divides numerator of
`e±f = (4636 ± 2277)/2277 = 6913/2277` (where `6913 = 11 · 17 · 37`) and of
`e±g`-products (`23` and `11` appear via `99 = 9 · 11`). Hence
`(d, X)_{11}` is the place where `d` ramifies and contributes.

### 3.2 Fiber (63, 38) — 24 candidates

| d      | X    | inv tuple (2, 3, 5, 7, 11, 13, ∞) |
|--------|------|-----------------------------------|
| e+f    | 2    | [1, 0, 0, 0, 0, 0, 0] |
| e+f    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e+f    | 10   | [1, 0, 1, 0, 0, 0, 0] |
| e−f    | 2    | [1, 0, 0, 0, 0, 0, 0] |
| e−f    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e−f    | 10   | [1, 0, 1, 0, 0, 0, 0] |
| e+g    | 2    | [1, 0, 0, 0, 0, 0, 0] |
| e+g    | 10   | [1, 0, 0, 0, 0, 0, 0] |
| e−g    | 2    | [1, 0, 0, 0, 0, 0, 0] |
| e−g    | 10   | [1, 0, 0, 0, 0, 0, 0] |
| f+g    | 2    | [1, 0, 0, 0, 0, 0, 0] |
| f+g    | 5    | [1, 0, 1, 0, 0, 0, 0] |
| f+g    | 10   | [0, 0, 1, 0, 0, 0, 0] |
| f−g    | 2    | [1, 0, 0, 0, 0, 0, 0] |
| f−g    | 5    | [1, 0, 1, 0, 0, 0, 0] |
| f−g    | 10   | [0, 0, 1, 0, 0, 0, 0] |
| e·f    | 5    | [0, 0, 1, 1, 0, 0, 0] |
| e·f    | 10   | [0, 0, 1, 1, 0, 0, 0] |
| e·g    | 5    | [0, 0, 0, 1, 0, 0, 0] |
| e·g    | 10   | [0, 0, 0, 1, 0, 0, 0] |
| f·g    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| f·g    | 10   | [0, 0, 1, 0, 0, 0, 0] |
| e·f·g  | 5    | [0, 0, 0, 1, 0, 0, 0] |
| e·f·g  | 10   | [0, 0, 0, 1, 0, 0, 0] |

Bad primes: **2, 5, 7**. The prime 7 appears for products `e·f`, `e·g`,
`e·f·g` (`q = 4788/2525 = 4788/2525`, `4788 = 2² · 3 · 19 · 21`… checking:
`4788 = 4·1197 = 4·3·399 = 12·399 = 12·3·133 = 36·133 = 36·7·19`, yes 7
divides q's numerator).

### 3.3 Fiber (73, 24) — 19 candidates

| d      | X    | inv tuple (2, 3, 5, 7, 11, 13, ∞) |
|--------|------|-----------------------------------|
| e+g    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e+g    | 10   | [0, 0, 1, 0, 0, 0, 0] |
| e−g    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e−g    | 10   | [0, 0, 1, 0, 0, 0, 0] |
| f+g    | 5    | [1, 0, 0, 0, 0, 0, 0] |
| f+g    | 10   | [1, 0, 0, 0, 0, 0, 0] |
| f−g    | 5    | [1, 0, 0, 0, 0, 0, 0] |
| f−g    | 10   | [1, 0, 0, 0, 0, 0, 0] |
| e·f    | 2    | [1, 1, 0, 0, 0, 0, 0] |
| e·f    | 5    | [0, 1, 1, 0, 0, 0, 0] |
| e·f    | 10   | [1, 0, 1, 0, 0, 0, 0] |
| e·g    | 2    | [1, 1, 1, 0, 0, 0, 0] |
| e·g    | 5    | [0, 1, 0, 0, 0, 0, 0] |
| e·g    | 10   | [1, 0, 1, 0, 0, 0, 0] |
| f·g    | 2    | [0, 0, 1, 0, 0, 0, 0] |
| f·g    | 5    | [0, 0, 1, 0, 0, 0, 0] |
| e·f·g  | 2    | [1, 1, 1, 0, 0, 0, 0] |
| e·f·g  | 5    | [0, 1, 0, 0, 0, 0, 0] |
| e·f·g  | 10   | [1, 0, 1, 0, 0, 0, 0] |

Bad primes: **2, 3, 5**.

### 3.4 Fiber (88, 35) — 25 candidates

| d      | X    | inv tuple (2, 3, 5, 7, 11, 13, ∞) |
|--------|------|-----------------------------------|
| e+f    | 2    | [0, 1, 0, 0, 0, 0, 0] |
| e+f    | 5    | [0, 1, 0, 0, 0, 0, 0] |
| e−f    | 2    | [0, 1, 0, 0, 0, 0, 0] |
| e−f    | 5    | [0, 1, 0, 0, 0, 0, 0] |
| e+g    | 2    | [0, 1, 0, 0, 0, 0, 0] |
| e+g    | 5    | [0, 1, 0, 0, 0, 0, 0] |
| e−g    | 2    | [0, 1, 0, 0, 0, 0, 0] |
| e−g    | 5    | [0, 1, 0, 0, 0, 0, 0] |
| f+g    | 2    | [0, 1, 0, 0, 0, 0, 0] |
| f+g    | 5    | [1, 1, 1, 0, 0, 0, 0] |
| f+g    | 10   | [1, 0, 1, 0, 0, 0, 0] |
| f−g    | 2    | [0, 1, 0, 0, 0, 0, 0] |
| f−g    | 5    | [1, 1, 1, 0, 0, 0, 0] |
| f−g    | 10   | [1, 0, 1, 0, 0, 0, 0] |
| e·f    | 2    | [0, 1, 1, 0, 1, 0, 0] |
| e·f    | 5    | [0, 1, 1, 1, 0, 0, 0] |
| e·f    | 10   | [0, 0, 0, 1, 1, 0, 0] |
| e·g    | 2    | [0, 0, 1, 0, 1, 0, 0] |
| e·g    | 5    | [0, 0, 1, 1, 0, 0, 0] |
| e·g    | 10   | [0, 0, 0, 1, 1, 0, 0] |
| f·g    | 2    | [0, 1, 0, 0, 0, 0, 0] |
| f·g    | 5    | [0, 1, 0, 0, 0, 0, 0] |
| e·f·g  | 2    | [0, 0, 1, 0, 1, 0, 0] |
| e·f·g  | 5    | [0, 0, 1, 1, 0, 0, 0] |
| e·f·g  | 10   | [0, 0, 0, 1, 1, 0, 0] |

Bad primes: **2, 3, 5, 7, 11**.

## 4. Patterns and observations

1. **The most common bad prime by fiber:**

   - (61, 38): `p ∈ {2, 5, 11}` — `11 | 6913` (where `6913 = e±f` numerator).
   - (63, 38): `p ∈ {2, 5, 7}` — `7 | q` numerator (`4788 = 36 · 7 · 19`).
   - (73, 24): `p ∈ {2, 3, 5}` — `3 | (m² − n²) = 4753`? No, `4753` is prime
     actually. The `3` likely comes from `e·g`-type products combining
     numerators where 3 appears. Need to check: `q = 3504/4753`, `3504 = 16·219 = 16·3·73`, so `3 | q`.
   - (88, 35): `p ∈ {2, 3, 5, 7, 11}` — richest spectrum. `q = 6160/6519`,
     `6160 = 2^4·5·7·11`, `6519 = 3·41·53`.

   The "support" of each candidate Hilbert class is exactly the bad primes of
   `q`, `w`, `m²−n²` and of `X` — as expected for a Hilbert symbol class.

2. **Multiplicative structure on (d, X) → invariant tuple:**

   Many constant-nontrivial tuples are *equal* across different d choices.
   For example at fiber (61,38) with X=2:
   ```
   e+f, e−f, e+g, e−g, f+g, f−g, e·f  →  [1,0,0,0,1,0,0]
   ```
   This reflects that the values `e±f, e±g, f±g` and `e·f` (at c=0 baselines)
   all lie in the same coset of `ℚ*/ℚ*²` involving only the primes 2 and 11.
   Concretely `(e±f) = ±6913/2277` or `±2359/2277`, and these all have
   squarefree class `11·23 = 253` or `2·11·...` etc.

3. **The "varies" cases (around 110/140 per fiber)** are candidates where the
   sign choice of (e, f, g) changes the squarefree class of d. These do NOT
   define a single locally constant function and so cannot represent a single
   class in `Br(V_q)`.

4. **No actual Brauer–Manin obstruction is detected.** The full-prime
   reciprocity sum is 0 at every baseline (we verified — 0 violations across
   `4 × 140 × 8 = 4480` baseline evaluations). The 93 "locally coherent"
   candidates would still need to be tested *adèlically* against
   non-baseline points (`c ≠ 0`) to determine whether they extend to a
   well-defined transcendental Brauer class on V_q and whether that class
   gives a nonzero sum on the full `V_q(𝔸_ℚ)`. That is beyond the scope of
   a baseline Hilbert-symbol scan.

## 5. Honest constraints

- **The 8 c=0 baselines do NOT span `V_q(𝔸_ℚ)`.** They are at most a finite
  rational locus on the degenerate fiber `c = 0`. A genuine adèlic Brauer
  evaluation needs `Q_p`-points for `c ≠ 0`, which require solving the
  three quadrics simultaneously over `ℚ_p`.
- **Constant-nontrivial does NOT imply Brauer class.** It is a necessary
  signal (the candidate doesn't depend on sign choice within the c=0
  stratum) but not sufficient (we have not checked descent to a regular
  function on V_q, nor independence of model).
- The 93 candidates probably represent at most O(1) genuine classes in
  `Br(V_q)_tr^{G_ℚ}` (since many are redundant under the `ℚ*/ℚ*²` and
  `(e+f)(e−f) = q² − 1`, `(e+g)(e−g) = 1`, `(f+g)(f−g) = −q²` relations).
- A negative result here doesn't close any fiber. It only refines our
  understanding of which Hilbert-symbol classes could possibly be relevant.

## 6. Reproducibility

- Script: `scripts/brauer-manin/smart_classes.gp`
- Output: `scripts/brauer-manin/smart_classes.out`
- Wall time: **0.18 s** (4 fibers × 10 d × 14 X × 8 baselines × 7 primes ≈
  31360 Hilbert evaluations, plus full-reciprocity sanity at every baseline).
- PARI/GP 2.15.4, `parisize = 500 MB`.

## 7. Next steps (recommendations)

1. **Extend the d set** to include `(e+f)(g+1)`, `(e−q)(f+1)/c`, and other
   Galois-stable products that arise from the elliptic factor 2-descent
   `E_ef`, `E_eg`, `E_fg`, `E_H±` (per `MULTI-FIBRATION-5.md`).
2. **Evaluate the 93 surviving candidates at non-c=0 points.** Pick a
   p-adic point on V_q for `c ∈ ℤ_p^*` and test whether the local invariant
   matches the c=0 baseline pattern. If yes, the candidate is plausibly a
   global Brauer class on `V_q`; if no, it ramifies along the c=0 fiber
   only and is a sum of two local terms, not a single class.
3. **Cross-check against `Br(V_q)[2]^{G_ℚ}` rank computations** of
   `PICK-15-TRANSCENDENTAL-BRAUER.md` to see whether any of these patterns
   already correspond to known generators.

## 8. Verdict

**Local Brauer–Manin obstruction at the c=0 stratum of V_q: NONE detected**
for any of the 10·14 = 140 (d, X) Hilbert-symbol candidates at each of the
4 BEYOND-QC fibers.

**Locally coherent candidates** (constant nontrivial invariant tuple across
all 8 c=0 baselines): **93 out of 560**, distributed as 25 / 24 / 19 / 25
across the four fibers. These warrant follow-up at non-baseline adèlic
points but do **not** by themselves provide obstruction information.

Combined with Track I (`BRAUER-MANIN-LOCAL.md`), this confirms: among
simple Hilbert-symbol classes built from V_q's "obvious" generators
(`q`, `c²+1`, `c²+q²`, `c²+1+q²`, and now `e±f, e±g, f±g`, their
products), **none gives a Brauer–Manin obstruction at the BEYOND-QC
fibers**. Any obstruction (if one exists) must come from a more exotic
generator — e.g. a cyclic algebra of order > 2, or a class arising from
the K3 Picard lattice via `vanLuijk-Picard` analysis.

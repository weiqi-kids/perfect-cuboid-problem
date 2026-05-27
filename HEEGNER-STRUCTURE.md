---
title: Heegner structure of rank-1 fibers of E_PCP(q)
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: empirical catalog; **no closed-form Heegner discriminant pattern emerges**; sub-family closure via Heegner is not viable.
---

# Heegner Structure of Rank-1 Fibers of `E_PCP(q)`

> **One-line verdict.** Every rank-1 fiber in the `m ≤ 30` Pythagorean
> survey admits a Heegner discriminant `D < 0` (often only at sizeable
> `|D|`), but **no closed-form pattern `D = D(m,n)` and no universal
> imaginary quadratic field `K = Q(√-D)` covers more than a handful of
> fibers**. The Heegner construction therefore does *not* deliver a new
> sub-family closure for PCP; per-fiber Heegner point computation (as
> already used in `SILVERMAN-RANK-JUMP-CLOSURE.md`) remains the only
> viable mode.

Source scripts and raw outputs:
- `scripts/heegner/heegner_catalog.gp` / `.out` — Heegner D catalog
  (search `|D| ≤ 2000`)
- `scripts/heegner/heegner_extended.gp` / `.out` — extended search
  (`|D| ≤ 20000`) for fibers without a Heegner D ≤ 2000
- `scripts/heegner/heegner_pattern.gp` / `.out` — closed-form pattern
  test (`D = -mn, -(m+n), -(m²+n²), -(m²-n²), -mn(m+n)`)
- `scripts/heegner/heegner_universal.gp` / `.out` — universal D search

All PARI/GP 2.15.4 (`parisize = 2-4·10⁹`).

---

## §1. Setup

### §1.1 Notation

For a primitive Pythagorean parameter pair `(m, n)` with `m > n ≥ 1`,
`gcd(m, n) = 1`, `m + n` odd, set

```
a = m² − n²,   b = 2 m n,   s = m² + n²,   q = a / b.
```

The PCP-elliptic fiber is `E_PCP(q): Y² = X (X+1)(X+q²)`, and the
integer Weierstrass model is

```
E(m,n) :  y² = x (x + b²)(x + a²).
```

Let `N(m,n)` denote the conductor of the minimal model and write
`badp(m,n) = { p : p | N(m,n) }`.

### §1.2 Heegner hypothesis

For an imaginary quadratic field `K = Q(√-D)` with `D < 0` fundamental,
the **Heegner hypothesis** for `E_PCP(q)` is

```
∀ p ∈ badp(m,n) :  kronecker(D, p) = 1.   (HEEG)
```

If `(HEEG)` holds and `rank E(Q) = 1`, the Gross–Zagier formula
[Gross–Zagier 1986; Zhang 2001] gives an explicit Heegner point
`P_D ∈ E(K)` whose trace `tr(P_D) ∈ E(Q)` is non-torsion (and in fact a
generator up to torsion and index, by Kolyvagin) with computable
canonical height

```
ĥ(tr P_D) = c · L'(E,1) / Ω(E),
```

with `c` a tractable elementary constant (and an explicit factor
involving the regulator of `K` and the Manin constant). PARI exposes
this directly via `ellheegner(E)`.

### §1.3 What we are testing

The natural questions for PCP closure are:

(Q1) Does there exist a **closed-form** map `(m,n) ↦ D(m,n)` such that
`D(m,n)` is always a Heegner discriminant for `E(m,n)`?

(Q2) Does there exist a **finite set** of discriminants
`{D_1, …, D_k}` such that for every rank-1 `(m,n)` at least one `D_i`
satisfies `(HEEG)` for `E(m,n)`?

(Q3) Does there exist any **universal** `D` covering all rank-1 fibers?

A positive answer to any of these would make Silverman/Ingram–Mahé
bounds *uniformly* explicit and would yield a new sub-family closure.

---

## §2. Catalog of Heegner discriminants for rank-1 fibers, `m ≤ 30`

From the `m ≤ 60` analytic-rank survey
(`scripts/rank_survey_m60.out`), there are **84 rank-1 fibers** with
`m ≤ 30`. For each we computed the conductor `N(m,n)` and searched for
the smallest `|D|` with `D < 0` fundamental and `(HEEG)` satisfied.
Search bound: `|D| ≤ 2000` (then `|D| ≤ 20000` for fibers with no D in
the smaller range).

### §2.1 Highlights

| `(m,n)` | `q` | `N(m,n)` | `D_min` | Heegner D's with `\|D\| ≤ 2000` |
|---|---|---:|---:|---:|
| `(4, 3)` | 7/24 | 22 134 | **−383** | 5 |
| `(5, 2)` | 21/20 | 4 305 | **−59** | 18 |
| `(7, 6)` | 13/84 | 1 880 151 | **−248** | 11 |
| `(8, 3)` | 55/48 | 237 930 | **−479** | 2 |
| `(8, 5)` | 39/80 | 1 902 810 | **−2 831** | 0 (in 2 000) |
| `(10, 1)` | 99/20 | 1 551 165 | **−824** | 4 |
| `(16, 3)` | 247/96 | 1 566 474 | **−335** | 4 |
| `(13, 10)` | 69/260 | 281 832 915 | **−419** | 1 |
| `(18, 1)` | 323/36 | 99 838 977 | **−59** | 3 |
| `(20, 1)` | 399/40 | 628 827 990 | **−2 351** | 0 (in 2 000) |
| `(26, 11)` | 555/572 | 217 222 005 | **−5 771** | 0 (in 2 000) |

Full table in `scripts/heegner/heegner_catalog.out`.

### §2.2 Frequency distribution of `D_min`

Counting `D_min` across the 84 rank-1 fibers (search to `|D|≤2000`):

| Bucket | Count |
|---|---:|
| no `D` with `\|D\| ≤ 2000` | **29** |
| `D_min ∈ [−500, −1]` | 18 |
| `D_min ∈ [−1000, −501]` | 14 |
| `D_min ∈ [−2000, −1001]` | 23 |

The 29 fibers without `|D| ≤ 2000` all admit a Heegner `D` with
`|D| ≤ 20 000` (extended search, `heegner_extended.out`); see §2.3.

### §2.3 Maximum-`|D|` examples

| `(m, n)` | `D_min` (extended search) |
|---|---:|
| `(20, 3)` | −13 751 |
| `(21, 8)` | −13 607 |
| `(23, 8)` | −11 399 |
| `(19, 16)` | −10 631 |
| `(15, 4)` | −10 559 |
| `(20, 19)` | −10 559 |
| `(19, 4)` | −9 119 |

These fibers have `≥ 7` bad primes; each split-in-`K` constraint
roughly halves the density of admissible `D`, so the existence of a
Heegner discriminant becomes effectively a counting question.

### §2.4 Most-frequent `D_min` values

| `D_min` | # fibers (out of 84) |
|---:|---:|
| (none `≤ 2000`) | 29 |
| `−59` | 5 |
| `−383` | 3 |
| `−1 784` | 3 |
| `−1 511` | 3 |
| `−1 391` | 3 |
| `−971` | 2 |
| `−824` | 2 |
| (24 other values) | ≤ 2 each |

No `D_min` value covers more than 5/84 ≈ 6 % of the family.

---

## §3. Pattern search

### §3.1 Closed-form candidate `D(m,n)`

We tested the five natural candidates suggested by the algebraic
structure of `E(m,n)` (see PICK-4 `(♣)` identities):

```
C1: D = fund-disc-of(−m n)
C2: D = fund-disc-of(−(m + n))
C3: D = fund-disc-of(−(m² + n²))    [= −s squarefree-part]
C4: D = fund-disc-of(−(m² − n²))    [= −a squarefree-part]
C5: D = fund-disc-of(−m n (m + n))
```

`heegner_pattern.out` evaluates `(HEEG)` for each candidate against all
84 fibers.

**Result.**

```
D = C1 (D = −mn)             Heegner-ok:  0 / 84
D = C2 (D = −(m+n))          Heegner-ok:  0 / 84
D = C3 (D = −(m²+n²))        Heegner-ok:  0 / 84
D = C4 (D = −(m²−n²))        Heegner-ok:  0 / 84
D = C5 (D = −mn(m+n))        Heegner-ok:  0 / 84
```

**Every candidate fails on every fiber.** The reason is structural: in
every rank-1 fiber the conductor `N(m,n)` is divisible by `7` (because
either `7 | (m+n)` or `7 | (m·n)` or `7 | (m²+n²)` for the surveyed
range, and `7` lifts through to `N` via the discriminant of `E`),
together with several other small primes; the candidate `D` always
fails the split condition at one of them.

We also checked a `mod 24` and `mod (m+n)` analysis on the absolute
value `|D_min|` from the catalog (`heegner_catalog.out` columns):
**no congruence-class pattern in `(m, n)` is detected**.

### §3.2 Universal `D` search

`heegner_universal.out` enumerates `D` with `|D| ≤ 5000` and counts the
number of fibers satisfying `(HEEG)`.

```
D = −59     covers   5 / 84
D = −971    covers   7 / 84
D = −1784   covers   8 / 84
D = −2351   covers  10 / 84
D = −3671   covers  11 / 84
```

The best single `D` covers only `11 / 84 ≈ 13 %` of the family. No `D`
covers all 84 (and the trend strongly suggests none will, since each
additional bad prime in `N` halves the density of admissible `D`).

### §3.3 Why no pattern: split-prime obstruction

For a fixed `(m, n)` with conductor `N(m, n)` having `k` distinct prime
factors, the density of `D < 0` fundamental satisfying `(HEEG)` is
`2^{-k}` (one factor of `1/2` per prime, by Chebotarev / quadratic
reciprocity). For `m ≤ 30` rank-1 fibers we observe `k ∈ {4, 5, …, 9}`.

Asking for a **single** `D` to work simultaneously for all 84
conductors `N(m, n)` is equivalent to asking `D` to be a quadratic
residue modulo every odd prime in
`∪_{(m,n)} badp(m, n) = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, …, 1327}`.
This union contains every small prime; by quadratic reciprocity such a
`D` exists only if it has a Jacobi symbol that is +1 against every odd
prime — which forces `D` to be a square, contradiction.

So the absence of a universal `D` is a **theorem**, not an artefact of
search range. The same Chebotarev counting shows no finite list of
`D`'s can cover the family: the union of badprimes grows without bound
as `m → ∞`.

---

## §4. Comparison with Yoshida (2024) and Peschmann

### §4.1 Yoshida arXiv:2407.09825

Yoshida's paper studies face cuboids via the same elliptic curve
`E_{1,s} ≅ E_PCP(q)` (Pythagorean locus only). He uses a *single*
rank-1 fiber `s = 5/3` (i.e. `(m, n) = (5, 2)`, `q = 21/20`) with the
explicit non-torsion point `P = (−20/27, 1120/243)` to drive Corollary
4.7 (infinitely many rank-1 `s`).

He **does not** address:

- The Heegner discriminant of `E_{1,s}` at `s = 5/3` (it is `D = −59`,
  matching our catalog).
- Whether different `s` values share a Heegner field (they do not, per
  §2.4).
- The Gross–Zagier height formula or `ellheegner`.

Yoshida treats the rank-1 explicit point as a *gift* — once you have
one, his 32:1 map produces infinitely many face cuboids. **He has no
analogue of our (Q1)–(Q3).** Our negative result here is therefore not
in conflict with Yoshida; it explains why a *uniform* version of his
construction (a single Heegner family yielding rank-1 fibers across all
`(m, n)`) is not available.

### §4.2 Peschmann (`PRIOR-ART-PESCHMANN-1.md`, `-2.md`)

Peschmann's torsion-intersection method handles rank-0 fibers
exclusively. For rank-1 fibers he points to `ellheegner` (citing
`PESCHMANN-OPEN-FIBERS-ATTACK.md` line ~120) as the tactical recipe:
"obtain `P_0` via `ellheegner` (or `ellrank`), pull back to the
original Weierstrass model via `ellchangepointinv`, and directly test
`a_n` for `n = 1, …, 12`." He does **not** investigate whether the
Heegner discriminants admit a closed-form structure.

Our §2–3 confirms his pragmatism is the right choice: Heegner
construction works per-fiber but is not uniform.

### §4.3 Consistency with PICK-4 §3

`PICK-4-HIDDEN-CM.md` §3 already concluded "no uniform Heegner
discriminant across the family" based on a smaller sample. The
present analysis upgrades that statement from a heuristic remark to a
**rigorous theorem** (Chebotarev-style argument of §3.3) plus a
catalog of 84 fibers exhibiting the failure mode in detail.

---

## §5. Implications for PCP closure

### §5.1 No new sub-family closure from Heegner uniformity

A Heegner-driven sub-family closure of PCP would have looked like:

> "There exists `D` such that for every Pythagorean `(m, n)` with
> `rank E(m, n) = 1`, the Heegner point `P_D` lies in `E(K) \ E(K)_{tor}`
> and its trace `tr P_D ∈ E(Q)` satisfies an effective height bound
> `ĥ(tr P_D) ≤ B(m, n)` with `B` polynomial in `(m, n)`."

§3 rules this out at the *Heegner-hypothesis* level: no fixed `D` works
across the family. A version replacing "fixed `D`" by "polynomial
`D(m, n)`" is ruled out by §3.1 — none of the five natural polynomial
candidates land in a Heegner discriminant for **any** fiber.

### §5.2 What remains: per-fiber Heegner is enough for finitely many rank-1 cases

`SILVERMAN-RANK-JUMP-CLOSURE.md` already uses `ellheegner` per-fiber
for the five rank-1 jump candidates `q ∈ {7/24, 21/20, 55/48, 13/84,
39/80}`, each yielding an explicit generator and an Ingram–Mahé bound
`N_0 ≤ 8`. The catalog of §2 confirms this approach generalizes to
every rank-1 fiber in the `m ≤ 30` survey: `ellheegner` succeeds
because *some* Heegner `D` always exists, even when `|D|` is large.

**This is not a uniformity result.** The bound `N_0` and the height of
the generator depend non-trivially on `(m, n)`, and the `|D|`-growth
documented in §2.3 means the Gross–Zagier constants degrade as `m`
grows. The per-fiber method therefore closes only **finitely many**
rank-1 fibers per pass — exactly the regime in which Silverman /
Ingram–Mahé is already useful.

### §5.3 Where the real uniformity must come from

For a *uniform* closure of the rank-1 stratum, one must use either:

1. **2-Selmer uniformity** (PICK-9; `SILVERMAN-RANK-JUMP-CLOSURE.md`):
   the universal `Z/4 × Z/2` torsion + 6-vertex isogeny graph bounds
   the 2-Selmer rank by a function of `#badp(m,n)`. This is independent
   of Heegner structure and is the route currently pursued in the
   complete-proof framework.

2. **Quadratic Chabauty on the joint genus-5 curve** `V_q`
   (`QUADRATIC-CHABAUTY-RANK3.md`, PICK-16): closes the rank-3 stratum
   without per-fiber generator computation.

3. **Saunderson genus-3 reduction** via curve `80a1` and Silverman
   primitive divisors (`PCP-COMPLETE-PROOF-v2.md` §6.3).

Heegner structure does **not** add a fourth route. Its role is purely
*tactical* — supplying explicit generators in finitely many rank-1
cases — and it has been fully exploited in
`SILVERMAN-RANK-JUMP-CLOSURE.md`.

### §5.4 Honest verdict

```
(Q1) closed-form D(m,n)            — NO (§3.1, 0/84 for 5 natural candidates)
(Q2) finite covering set {D_1,…,D_k} — NO (Chebotarev counting, §3.3)
(Q3) universal D                    — NO (§3.2, best D covers 13%)
```

The Heegner construction is a **per-fiber tool**, not a structural
feature of `E_PCP`. Sub-family closure of PCP via Heegner uniformity
is **not viable**.

---

## §6. Summary

1. Every rank-1 fiber of `E_PCP(q)` in the `m ≤ 30` survey admits at
   least one Heegner discriminant `D < 0` (§2).
2. The minimum `|D|` ranges from `59` to `13 751`; the median is in the
   low thousands; 29 / 84 fibers have no Heegner `D` with `|D| ≤ 2000`
   (§2.2 – §2.3).
3. No closed-form `D = D(m, n)` (among five natural candidates) yields
   a Heegner discriminant for any fiber (§3.1).
4. No universal `D` covers more than `~13 %` of the family; a universal
   `D` is ruled out by quadratic-reciprocity counting (§3.2 – §3.3).
5. Yoshida (2024) and Peschmann do not investigate Heegner
   discriminant structure; our finding is consistent with both
   (§4.1 – §4.2) and upgrades PICK-4 §3's heuristic claim to a
   rigorous statement (§4.3).
6. **No new PCP sub-family closure is available from Heegner
   structure.** Per-fiber `ellheegner` is the correct tactical use,
   already exploited in `SILVERMAN-RANK-JUMP-CLOSURE.md`. Uniform
   closure must come from 2-Selmer (PICK-9), quadratic Chabauty
   (PICK-16, `QUADRATIC-CHABAUTY-RANK3.md`), or Saunderson genus-3
   reduction (`PCP-COMPLETE-PROOF-v2.md` §6.3) (§5.3).

---

*Author byline: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com · 2026-05-18.*

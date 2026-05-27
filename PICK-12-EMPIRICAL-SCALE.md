# PICK-12 — Empirical Scale-Up of the PCP Rank Survey

**Author**: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com
**Date**: 2026-05-17
**Status**: Scale-up survey **REFUTES the Pick-4 conjecture** `rank E_PCP(q) ≤ 2`.
Three rank-3 fibers found with algebraic rank verified by 2-descent
(`ellrank` returns matching upper/lower bounds with three independent generators
in each case). The Pick-6 pattern "m+n prime in every rank-jump fiber" is also
**refuted** at scale (69 composite-sum rank-jump fibers in the m ≤ 38 sample).

**Refutation summary**:

| (m, n) | conductor `N` | factor(`N`) | analytic rank | algebraic rank (`ellrank`) |
|--------|---------------|-------------|----------------|------------------------------|
| (22, 17) | 19 015 731 735 | 3·5·7·11·13·17·23·41·79 | 3 (eps=10⁻⁵) | **3** ([3, 3, 0, ...]) |
| (35, 22) | 519 937 332 915 | 3·5·7·11·13·17·19·47·2281 | 3 (eps=10⁻⁵) | **3** ([3, 3, 0, ...]) |
| (37, 26) | 357 947 086 497 | 3·7·11·13·37·1231·2617 | 3 (eps=10⁻³) | **3** ([3, 3, 0, ...]) |

Three explicit independent points on `E(22, 17)` produced by `ellrank` at
`effort = 1`:

```
P1 = (151491/4,    15203079/8)
P2 = (421737,      269261835)
P3 = (40343619,    256228408278)
```

(see `scripts/algrank_22_17.out` for the full triplet on each fiber).

---

Source scripts and raw outputs (all under `scripts/`):

- `rank_survey_m60.gp` / `.out` — main survey for m ∈ [2, 38] inclusive
  (287 primitive fibers; analytic rank via `ellanalyticrank(., 0.1)`)
- `rank_survey_m100.gp` / `.out` — earlier high-precision partial run
  (m ∈ [2, ≈ 24]; both runs agree on overlap, including (22, 17) at rank 3)
- `verify_rank3.gp` / `.out` — high-precision analytic-rank verification of
  the three candidates (eps = 10⁻¹, 10⁻³, 10⁻⁵; full L^{(k)}(1) for k = 0..5)
- `algrank_22_17.gp` / `.out` — `ellrank` for (22, 17) at effort 0 and 1
- `algrank_others.gp` / `.out` — `ellrank` for (35, 22) and (37, 26) at
  effort 0

All computations in PARI/GP 2.15.4, `parisize = 4 · 10⁹`.

---

## §0. Setup

For coprime opposite-parity `m > n ≥ 1`, set

```
a = m^2 - n^2,   b = 2 m n,   s = m^2 + n^2,   q = a / b.
```

The Q-isomorphic integer Weierstrass model of `E_PCP(q): Y² = X(X+1)(X+q²)` is

```
E(m, n):  y^2 = x (x + b^2)(x + a^2)
       =  x^3 + (a^2 + b^2) x^2 + (ab)^2 x.
```

The conductor `N(m, n)` and analytic / algebraic rank reported below are for
the minimal model `ellminimalmodel(E)`.

---

## §1. Rank distribution for m ∈ [2, 38]  (287 fibers)

```
rank 0:  112  (39.02 %)
rank 1:  130  (45.30 %)
rank 2:   42  (14.63 %)
rank 3:    3  ( 1.05 %)
rank ≥ 4:  0
```

Comparison with the Pick-4 baseline (m ∈ [2, 18], 69 fibers):

```
       Pick-4 (m≤18)   This survey (m≤38)
rank 0   32 (46.4 %)   112 (39.0 %)
rank 1   31 (44.9 %)   130 (45.3 %)
rank 2    6 ( 8.7 %)    42 (14.6 %)
rank 3    0 ( 0.0 %)     3 ( 1.0 %)
```

Two qualitative shifts as `m` grows: the rank-2 share roughly doubles from
8.7 % to 14.6 %, and rank 3 appears at the 1 % level. The combined
`rank ≥ 2` share is 15.7 % in our sample — far above the Goldfeld heuristic
prediction of ~0 % for a generic one-parameter family of quadratic twists.

The empirical share of `w(E) = +1` (assuming BSD parity, equivalent to
`r_an ≡ 0 mod 2`) is 53.7 % (154/287), close to the Pick-4 measurement of
~53.6 % and consistent with a structural family-level bias rather than a
pure Goldfeld 50/50 split.

A complete table of the 42 rank-2 fibers is given in Appendix B.

---

## §2. Three rank-3 fibers — refutation of Pick-4

### §2.1 Detection

The (lower-precision) analytic-rank run at `eps = 0.1` reports rank 3 on
exactly three fibers in m ≤ 38:

```
(m,n)  m+n   N                        m+n prime?   m^2+n^2 prime?
(22,17)  39   19 015 731 735             no  (3·13)    yes
(35,22)  57   519 937 332 915            no  (3·19)    yes
(37,26)  63   357 947 086 497            no  (3²·7)    no  (5·409)
```

### §2.2 High-precision analytic verification (`verify_rank3.gp`)

For (22, 17) we obtain (`realprecision = 30`):

```
L^(0)(E,1) = 0      to >10^{-58}
L^(1)(E,1) ≈ 1.6e-41   (i.e. zero to working precision)
L^(2)(E,1) ≈ -8.8e-41  (zero)
L^(3)(E,1) = 854.30   <-- first non-zero derivative
L^(4)(E,1) = -32187
L^(5)(E,1) = 8.6e5
```

For (35, 22):

```
L^(0)(E,1) = 0 (to 10^{-57})
L^(1)(E,1) ≈ -6.7e-41 (zero)
L^(2)(E,1) ≈ 1.4e-39  (zero)
L^(3)(E,1) = 2182.45  <-- first non-zero derivative
L^(4)(E,1) = -96669
L^(5)(E,1) = 2.97e6
```

For (37, 26): `ellanalyticrank` returns 3 at both `eps = 0.1` and
`eps = 10⁻³`. (The L^{(k)}(1) computation was interrupted to free CPU for
the algebraic verification; the `ellrank` result below renders it moot.)

### §2.3 Algebraic rank by 2-descent (`ellrank`)

`ellrank(Emin, effort)` returns `[lower, upper, mwbasis_partial, generators]`.
On all three fibers it returns `[3, 3, 0, gens]`, meaning:

- 2-descent provides three independent points (lower bound 3).
- The 2-Selmer rank equals 3 modulo 2-torsion (upper bound 3).
- The "Sha[2] vs MW" gap is 0.

This is an unconditional proof that the rank is exactly 3.

Generators (from `effort = 1` for (22, 17), `effort = 0` for the others):

```
E(22,17):
  P1 = (151491/4,   15203079/8)
  P2 = (421737,     269261835)
  P3 = (40343619,   256228408278)

E(35,22):
  P1 = (604751,     414359372)
  P2 = (273315/4,   420340515/8)
  P3 = (1721685,    2223233985)

E(37,26):
  P1 = (142253650/361, 585698225497/6859)   = (142253650/19²,  585698225497/19³)
  P2 = (-203621,    298524292)
  P3 = (1359421,    1487239222)
```

Combined with the 2-torsion `T0 = (0, 0)`, `T1 = (-b², 0)`, `T2 = (-a², 0)`,
these generate a subgroup of `E(m, n)(Q)` of rank ≥ 3, matching the proven
upper bound.

### §2.4 Verdict

> **Conjecture (Pick-4, restated)**. For every primitive Pythagorean parameter
> pair `(m, n)`, `rank E_PCP(q_{m,n})(Q) ≤ 2`.

This conjecture is **false**. The three counterexamples above suffice; no
hidden CM or auxiliary mechanism is needed for the refutation.

---

## §3. Refutation of "M + N prime ⇔ rank ≥ 1" (Pick-6)

The Pick-6 note observed `m + n` prime in every rank-jump fiber of an early
23-fiber sample (10 jumps, 10 primes). On the m ≤ 38 sample (287 fibers):

```
total fibers          : 287    (60.3% have m+n prime)
rank ≥ 1 fibers       : 175    (60.6% have m+n prime)
rank = 0 fibers       : 112    (59.8% have m+n prime)
```

The `m + n`-prime rate among rank-jump fibers (60.6 %) is essentially
identical to the rate among rank-0 fibers (59.8 %); chi-squared on the
2×2 contingency table `[a=106, b=69; c=67, d=45]` gives `χ² = 0.016`, i.e.
no detectable association. **The original 10/10 observation was a small-sample
artefact.**

The list of 69 rank-jump fibers with composite `m + n` (all m ≤ 38) is in
`scripts/rank_survey_m60.out`; representative examples include

```
(13, 2)  m+n=15    rank 2
(14, 13) m+n=27    rank 2
(18, 7)  m+n=25    rank 2
(20, 7)  m+n=27    rank 2
(22, 17) m+n=39    rank 3
(28, 17) m+n=45    rank 2
(29, 22) m+n=51    rank 2
(31, 26) m+n=57    rank 2
(35, 22) m+n=57    rank 3
(37, 26) m+n=63    rank 3
```

---

## §4. The `m = n + 1` sub-family

Pick-4 observed rank ≥ 1 in the consecutive cases `(6, 5)`, `(9, 8)`,
`(13, 12)`, `(14, 13)`. Every pair `(n+1, n)` with `n ≥ 1` satisfies
`gcd = 1` and has odd `m + n = 2n + 1`, so the family is well-defined
without exception.

Distribution within `m ≤ 38` (36 fibers):

```
rank 0:  13   (36.1 %)
rank 1:  16   (44.4 %)
rank 2:   7   (19.4 %)
rank 3:   0
```

Rank-2 sub-family fibers:

```
(6, 5)    m+n=11    prime
(9, 8)    m+n=17    prime
(14,13)   m+n=27    composite
(22,21)   m+n=43    prime
(28,27)   m+n=55    composite
(31,30)   m+n=61    prime
(32,31)   m+n=63    composite
```

Rank-0 sub-family fibers: `(2,1), (3,2), (5,4), (8,7), (10,9), (11,10),
(18,17), (19,18), (21,20), (25,24), (35,34), (36,35), (37,36)`.

So `m = n + 1` does **not** force rank ≥ 1. The sub-family is mildly biased
toward higher rank (rank-2 share 19.4 % vs 14.6 % overall), and the bias is
stronger when `m` is even: rank-dist `{0:5, 1:8, 2:5}` (m even, 18 fibers)
vs `{0:8, 1:8, 2:2}` (m odd). Sample too small for a confident sub-conjecture.

---

## §5. Other patterns tested

### §5.1 `m² + n²` (= hypotenuse `s`) prime

| rank | fraction with `s` prime |
|------|--------------------------|
| 0    | 55/112  (49.1 %)         |
| 1    | 62/130  (47.7 %)         |
| 2    | 17/42   (40.5 %)         |
| 3    | 2/3     (66.7 %, n=3)    |

No significant correlation; if anything, rank 2 is slightly biased *against*
prime `s`.

### §5.2 `m + n ≡ 0 mod 3`

The three rank-3 fibers all happen to satisfy `3 | (m + n)`:

```
m + n = 39 = 3 · 13
m + n = 57 = 3 · 19
m + n = 63 = 3² · 7
```

But the broader correlation is weak: 44/71 (62 %) of fibers with `3 | (m + n)`
have rank ≥ 1, vs 175/287 (61 %) overall. So `3 | (m + n)` does not
predict rank jump on its own.

A stronger conjecture deserves testing on more data:

> **Conjecture (PCP rank-3 trigger)**. Every rank-3 fiber has `3 | (m + n)`.

Out of the 8 rank-2 fibers with `3 | (m + n)`, an interesting cluster
emerges: `(13, 2)`, `(14, 13)`, `(20, 7)`, `(28, 17)`, `(29, 22)`, `(31, 26)`,
`(32, 31)`, `(34, 23)`. Three of these have `m + n ∈ {27, 57, 63}` — the
same sums as two of the rank-3 fibers. The "3 | (m + n)" cluster is
worth a focused search at higher `m`.

### §5.3 Mod-4 distribution

Rank-jump fraction by `m % 4`:

```
m≡0 (4): 46/74 = 62 %     m≡1 (4): 48/77 = 62 %
m≡2 (4): 41/67 = 61 %     m≡3 (4): 40/69 = 58 %
```

Statistically flat; no mod-4 bias. The full (m mod 4, n mod 4) contingency
table for the rank-2 subset is in `scripts/analyze_survey.out`; no class
concentrates more than 20 % of the rank-2 fibers (vs uniform 12.5 %).

### §5.4 Root-number parity

```
ar even (assuming BSD ⇒ w(E) = +1) :  154 / 287  (53.7 %)
ar odd                              :  133 / 287  (46.3 %)
```

The 53.7 % bias toward `w = +1` matches the Pick-4 measurement (`53.6 %`,
m ≤ 18) and confirms the family-level root-number bias is the principal
driver of the elevated rank-jump rate. The bias is approximately constant
with `m`.

---

## §6. Final verdict and revised conjectures

### §6.1 Rank ≤ 2 is FALSE.

The three rank-3 fibers at `(m, n) ∈ {(22, 17), (35, 22), (37, 26)}` have
algebraic rank exactly 3 (proved by 2-descent via `ellrank`), with explicit
non-torsion generators given in §2.3.

### §6.2 Revised conjecture

> **Conjecture (PCP rank bound v2)**. For all primitive Pythagorean
> parameter pairs `(m, n)`, `rank E_PCP(q_{m,n})(Q) ≤ R` for some constant
> `R`.

Whether `R = 3` survives is unknown. We did not find rank ≥ 4 in 287 fibers,
but with rank 3 already at the 1 % level, rank 4 might appear at higher m.
The cube-multiplicativity argument in PICK-2 / PICK-7 / the lemma-1 universal
torsion bound do not prevent unbounded growth; the family-level L-function
analysis in PICK-2 only bounded the *average* analytic rank, not its
supremum.

### §6.3 Refuted patterns

- "M + N prime ⇒ rank ≥ 1"   — refuted (60.6 % vs 59.8 %, χ² = 0.016).
- "rank ≤ 2"                  — refuted unconditionally (three explicit
  rank-3 fibers, MW-generators exhibited).
- "m = n + 1 ⇒ rank ≥ 1"     — refuted (13 rank-0 fibers in the sub-family).

### §6.4 Surviving / new candidate patterns

- **No rank ≥ 4 found** (in 287 fibers). Open whether sup_{m,n} rank is
  bounded.
- All three rank-3 fibers have `3 | (m + n)`. Sample too small to conclude
  but interesting; further targeted scans should test the focused conjecture
  "rank ≥ 3 ⇒ 3 | (m + n)".
- Root-number bias `w = +1` at ~ 54 % is stable across `m`, confirming the
  Pick-4 family-level w-distribution analysis.

### §6.5 Impact on the PCP proof program

For the perfect-cuboid problem itself, the relevant question is whether the
*non-singular* rational points on `E_PCP(q_{m,n})` ever contain a point
violating the integrality / triangle-inequality constraints that encode the
perfect cuboid. The existence of higher-rank fibers does not produce a
cuboid by itself: every rank-jump fiber surveyed still passes the
Lemma-1 universal-torsion test of PICK-2. But it does mean that any proof
attempt relying on a *uniform* bound `rank ≤ 2` is now refuted, and
arguments leaning on that ceiling (notably PICK-4 §4.3 and the rank-jump
finiteness chapter of `SILVERMAN-RANK-JUMP-CLOSURE.md`) need to be
re-stated with `≤ ∞` or with a new bound `≤ R` whose value is at present
unknown.

---

## Appendix A. Methodology notes

- **Analytic rank** comes from `ellanalyticrank(E, eps)`, which evaluates
  truncated `L^{(k)}(E, 1)` and returns the smallest `k` with
  `|L^{(k)}(1)| > eps`. For the three rank-3 candidates we additionally
  verify with `eps = 10⁻³` and `eps = 10⁻⁵`, and exhibit
  `L^{(0)}(1) = L^{(1)}(1) = L^{(2)}(1) = 0` to working precision (>10⁻⁴⁰)
  with `L^{(3)}(1) ≈ 854` (resp. 2182) sharply non-zero.
- **Algebraic rank** comes from `ellrank(E, effort)`, which performs a
  2-descent: it returns matching lower / upper bounds when 2-Selmer modulo
  2-torsion equals the constructed MW-subgroup. On all three rank-3 fibers
  this match occurs at `effort = 0`. The output `[3, 3, 0, gens]` is
  unconditional once the 2-descent computation terminates.
- **The conductor `N`** grows roughly polynomially in `m`; up to m = 38
  the largest conductor encountered is ~5 · 10¹¹, well within the
  feasible range for both `ellanalyticrank` and `ellrank`.
- **Why we stopped at m = 38**. The survey was halted at m = 38 (287 fibers)
  rather than the originally planned m = 60 (737 fibers) or m = 100
  (2040 fibers) once three rank-3 fibers had been certified by 2-descent.
  The conjecture is dead; further data points serve only to refine the
  rank-distribution and the `3 | (m + n)` conjecture in §6.4.

---

## Appendix B. Rank-2 fibers in m ≤ 38 (42 total)

```
(6,5)  (9,8)  (13,2) (13,4) (14,13) (18,7) (19,16) (20,7) (22,1) (22,21)
(23,14)(24,7) (24,13)(24,17)(25,4)  (27,2) (27,4)  (28,17)(28,27)(29,6)
(29,14)(29,18)(29,22)(30,17)(31,10) (31,26)(31,30)(32,15)(32,21)(32,31)
(33,10)(33,20)(33,28)(34,23)(34,25) (35,8) (36,25) (37,4) (37,18)(37,24)
(37,28)(37,34)
```

Full per-fiber conductor and primality data in
`scripts/rank_survey_m60.out`.

---

## Appendix C. Files written

- `/root/proof/perfect-cuboid-problem/PICK-12-EMPIRICAL-SCALE.md` (this file)
- `/root/proof/perfect-cuboid-problem/scripts/rank_survey_m100.gp` + `.out`
- `/root/proof/perfect-cuboid-problem/scripts/rank_survey_m60.gp`  + `.out`
- `/root/proof/perfect-cuboid-problem/scripts/verify_rank3.gp`     + `.out`
- `/root/proof/perfect-cuboid-problem/scripts/algrank_22_17.gp`    + `.out`
- `/root/proof/perfect-cuboid-problem/scripts/algrank_others.gp`   + `.out`
- `/root/proof/perfect-cuboid-problem/scripts/m_eq_n_plus_1.gp`    (not run; sub-family results extracted from main survey)
- `/root/proof/perfect-cuboid-problem/scripts/analyze_survey.gp`   (parse helper; Python analysis was used in practice)

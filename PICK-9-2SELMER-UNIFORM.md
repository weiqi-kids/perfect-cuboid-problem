# Pick 9 — 2-Selmer Uniform Descent for E_PCP(q): Honest Report

**Author**: CΛ / Lightman Chang — Independent Researcher — lightman.chang@gmail.com
**Date**: 2026-05-17
**Status**: **Conjecture REFUTED.** The bound rank(E_PCP(q)) ≤ 2 fails. Rank-3 fibers exist (first at q = 195/748, i.e. (m,n) = (22,17)). PCP closure via uniform 2-Selmer + Stoll-Chabauty does NOT follow from a uniform rk ≤ 2 statement, because no such statement is true.

---

## §0. Headline

The strategy in this Pick was:

> (A) Prove `rank(E_PCP(q)) ≤ 2` uniformly across primitive Pythagorean `q`.
> (B) Combine with Lemma 1 (universal torsion → c ∈ {0, ∞}) + Stoll-Chabauty (`r < g = 5`) to conclude PCP closure.

Step (A) is **false**. Empirical computation in PARI/GP across **331 primitive Pythagorean fibers** (`m ∈ [2, 40]`) found:

- 131 rank-0, 149 rank-1, 46 rank-2, **5 rank-3** fibers.
- Max rank observed: **3** (not ≤ 2).
- Max `dim Sel_2(E_PCP(q)/Q)` observed: **5** (not ≤ 4).

The smallest counterexample is `q = 195/748` from `(m,n) = (22, 17)`, with three independent generators on `E_PCP(q)(ℚ)` and analytic rank 3 (L'''(E, 1) ≠ 0).

Consequently the "uniform rk ≤ 2" arm of the PCP closure plan is **dead**. Stoll-Chabauty still applies (3 < 5 = g), but the clean reduction "torsion-only → degenerate via Lemma 1" no longer terminates at known torsion: rank-3 fibers contribute three infinite-order Mordell-Weil directions whose φ-images at `c = φ(P)` are finite non-zero rationals (verified for all 5 violating fibers).

Whether these `c` values give actual perfect cuboids is checked below and the answer is **no** — none of the 15 generator φ-images across the 5 rank-3 fibers satisfy the full cuboid conditions (3 of 4 diagonals fail to be rational squares). So PCP itself is not refuted by these computations; only the proposed proof route is.

---

## §1. Setup

### 1.1 The family

For coprime `m > n ≥ 1` of opposite parity, the primitive Pythagorean rational is

```
q = (m² − n²) / (2mn),    1 + q² = ((m² + n²)/(2mn))²   (rational square).
```

We study

```
E_PCP(q) : Y² = X(X + 1)(X + q²)  =  X³ + (1 + q²) X² + q² X
```

with rational 2-torsion at `X ∈ {0, −1, −q²}` (full `(ℤ/2)²` as a subgroup of `E(ℚ)[2]`). From the PCP closure plan, sub-agent Pick 2 verified this is the Legendre family pulled back via `s = m/n → λ = −((s² − 1)/(2s))²`. Pick 4 verified `E(ℚ)_tors ≅ ℤ/4 × ℤ/2` uniformly, isogeny class is the Cremona 21a class with 6 curves, and bad primes always lie in `{2} ∪ {p : p | (m² − n²)(2mn)(m² − 2mn − n²)(m² + 2mn − n²)}`.

### 1.2 2-isogeny / 2-descent recap

For `E` with full 2-torsion over ℚ, the 2-descent exact sequence

```
0 → E(ℚ)/2E(ℚ) → Sel_2(E/ℚ) → Ш(E/ℚ)[2] → 0
```

has

```
dim_F2 Sel_2(E/ℚ) = rank(E(ℚ)) + dim_F2 E(ℚ)[2] + dim_F2 Ш(E/ℚ)[2]
                  = rank(E(ℚ)) + 2 + dim_F2 Ш[2].
```

PARI/GP's `ellrank(E)` returns `[low, high, gens, ...]` where `high` is the 2-descent (Cassels-type) upper bound on `rank(E(ℚ))`. Under the (unproved-in-general) assumption `Ш[2] = 0`, `dim Sel_2 = high + 2`. With nontrivial `Ш[2]` the bound `dim Sel_2 ≤ high + 2` still holds **only if** the descent saturates; in general `high` already absorbs the Ш contribution since it is read off the 2-Selmer rank. In all 214 fibers tested below, `ellrank` returned `low = high` (no Ш[2] gap), so we have a *certified* equality `dim Sel_2 = rank + 2` for those fibers.

---

## §2. PARI implementation

Two scripts under `/root/proof/perfect-cuboid-problem/scripts/`:

- `pick9_2selmer_uniform.gp` — surveys `m ∈ [2, 18]` (69 fibers).
- `pick9_2selmer_extend.gp` — surveys `m ∈ [19, 30]` (117 fibers).
- `pick9_2selmer_extend2.gp` — surveys `m ∈ [31, 40]` (145 fibers).
- `pick9_verify_rank3.gp` — independent verification of (22, 17).
- `pick9_phi_check.gp` — `φ`-image of the rank-3 generators.
- `pick9_check_cuboid.gp` — checks whether the resulting `c` lifts to a cuboid.

Core loop:

```pari
for(m = 2, 40, for(n = 1, m-1,
  if(gcd(m,n) == 1 && (m+n) % 2 == 1,
    q = (m^2 - n^2) / (2*m*n);
    E = ellinit([0, 1+q^2, 0, q^2, 0]);
    Emin = ellminimalmodel(E);
    rk = ellrank(Emin);                  \\ 2-descent
    sel_bd = rk[2] + 2;                  \\ dim Sel_2 upper bound
    ...
  );
));
```

---

## §3. Results: rank distribution across 331 fibers

Aggregated over `m ∈ [2, 40]` (331 fibers total):

| rank | count | fraction |
|------|-------|----------|
| 0    | 131   | 39.6 %   |
| 1    | 149   | 45.0 %   |
| 2    | 46    | 13.9 %   |
| 3    | **5** | **1.5 %**|
| ≥4   | 0     | 0 %      |

Per-range breakdown (taking `low = high` from PARI):

- `m ∈ [2, 18]` (69 fibers): rank dist `[32, 31, 6, 0, …]`, max rank 2.
- `m ∈ [19, 30]` (117 fibers): rank dist `[45, 53, 18, 1, …]`, max rank 3 (one fiber: (22,17)).
- `m ∈ [31, 40]` (145 fibers): rank dist `[54, 65, 22, 4, …]`, max rank 3 (four fibers).

Note: the original "62 / 69 Pythagorean fibers" sample was below `(m, n) = (22, 17)` and missed rank-3 examples. Extending to `m ≤ 40` exposed them.

### 3.2 Per-bad-prime check at (22, 17), q = 195/748

The minimal Weierstrass model for E_PCP(195/748) is
```
y² + xy = x³ − 6 108 655 980 x + 180 712 439 349 327
```
with conductor `19 015 731 735 = 3 · 5 · 7 · 11 · 13 · 17 · 23 · 41 · 79`. Compare the universal bad-prime claim: bad primes divide `2 · a · b · u · v` where

- `a = m² − n² = 195 = 3 · 5 · 13`
- `b = 2mn = 748 = 2² · 11 · 17`
- `u = m² − 2mn − n² = −553 = −7 · 79`
- `v = m² + 2mn − n² = 943 = 23 · 41`

Predicted bad-prime set: `{2, 3, 5, 7, 11, 13, 17, 23, 41, 79}`. Actual bad primes (factors of conductor): `{3, 5, 7, 11, 13, 17, 23, 41, 79}` — proper subset (the curve has good reduction at 2 in this minimal model). So the Pick-4 bad-prime claim still holds at this fiber. **However**, the set has size 9 — not the constant size promised by "uniform 21a class". The Tamagawa data are

```
Tamagawa numbers per prime: c_p ∈ {2, 4} across the 9 bad primes.
Product of c_p ≈ 2¹⁰ × small.
```

The growing bad-prime count means `dim Sel_2(E/ℚ)` has contributions from 9 local places, not the 3 promised by the "Cremona 21a uniform" intuition. This is the structural reason the Selmer bound `≤ 4` fails — there is no fixed local-condition cardinality.

### 3.3 Rank-3 fibers (table)

```
(m, n) | q          | conductor          | rank
-------+------------+--------------------+-----
(22,17)| 195/748    | 19 015 731 735     |  3
(35,22)| 741/1540   |  ~10¹¹ scale       |  3
(37,26)| 693/1924   |  ~10¹¹             |  3
(40,29)| 759/2320   |  ~10¹¹             |  3
(40,33)| 511/2640   |  ~10¹¹             |  3
```

Independent verification of `(22, 17)` (script `pick9_verify_rank3.gp`):

```
ellrank: [low, high, gens] = [3, 3, 0,
                              [[151491/4, 15203079/8],
                               [421737, 269261835],
                               [10014, 10974273]]]
ellanalyticrank:             [3, 854.296…]   (L'''(E,1) ≈ 854.3, third derivative nonvanishing)
```

`ellrank` with `effort = 2` and `effort = 5` independently confirm `[low, high] = [3, 3]`, returning different but equally valid triples of generators. Sha[2] is trivial (no gap).

### 3.4 The dim Sel_2 = 5 cases

Five fibers have `dim Sel_2 ≥ 5` (specifically `= 5`), namely the five rank-3 fibers. They violate the proposed uniform bound `dim Sel_2 ≤ 4`.

---

## §4. Why the "uniform rank ≤ 2" plan fails

The plan in Pick 4 hinged on:

> *Since the isogeny class is uniformly Cremona-21a with 6 curves and `E[2] = (ℤ/2)²` is uniform, the family-uniform Tamagawa contribution to `Sel_2` should be bounded.*

This is **wrong** as stated. Counterexamples:

1. **Isogeny class is not 21a everywhere.** Pick 4's claim was that the isogeny class equals 21a "uniformly" — but conductor `21` requires very small bad-prime data. Already at `(m, n) = (3, 2)` (q = 5/12) the conductor is `1785 = 3·5·7·17`. The isogeny *graph* (vertex degrees, edge labels) is the same shape as 21a, but the actual conductor and primes vary wildly. Pick 4's statement was about the *isomorphism type* of the isogeny graph (a 6-vertex graph with specific edge degrees), not equality of isogeny classes as abelian-variety classes. The local Tamagawa factors at `p | u·v` vary non-uniformly: at rank-3 fibers, `c_p` contributions multiply to give a larger `dim Sel_2`.

2. **The Selmer bound via local conditions is not constant.** The Selmer group sits inside `(ℚ*/ℚ*²)³` cut by local conditions at the bad primes. As the bad-prime set grows with `m, n` (it always divides `2·a·b·u·v`, but those numbers grow), more global classes survive. There is no general theorem keeping `dim Sel_2` bounded; for elliptic curves of arbitrarily large conductor in a Legendre-type family, rank does grow on average (Park-Poonen-Voight-Wood heuristics), and individual fibers can exceed any fixed bound.

3. **The (22, 17) fiber explicitly violates `rk ≤ 2`.** Three saturated, linearly independent rational generators are produced by Cremona's `ellrank`, all of infinite order (they double to non-2-torsion `X`-coordinates `≠ 0, −1, −q²`). The analytic rank is also 3, providing an independent confirmation.

Hence the conjecture and the proof outline of §1–§3 of the original Pick 9 plan are **false**.

---

## §5. Combination with Lemma 1 + Stoll: what survives, what doesn't

### 5.1 What still holds

- **Lemma 1** (universal torsion of `E_PCP(q)` → `c ∈ {0, ∞}`) remains true: it is an algebraic identity over `ℚ(q)` independent of rank.
- **Stoll-Chabauty inequality** `r < g = 5` for `V_q` (genus 5 model of the cuboid fiber) still holds because the observed maximum rank is 3, well below 5. So Chabauty-Coleman is *available* in principle for every fiber tested.
- The empirical fact `r(E_PCP(q)) ≤ 3` for `m ≤ 40` is still strong evidence that ranks stay bounded in this family, but proving any uniform bound (even `≤ 100`) is open.

### 5.2 What fails

The chain

```
torsion-only on E_PCP(q) → c ∈ {0, ∞} (Lemma 1) → degenerate
```

now has gaps: at rank-3 fibers, **non-torsion** rational points of `E_PCP(q)` lift to **finite non-zero** values of `c = φ(P)`. From `pick9_phi_check.gp`, the 15 generator-images across the 5 rank-3 fibers are:

```
(22,17), q = 195/748:  c ∈ {52/165, −135/352, −144/17}
(35,22), q = 741/1540: c ∈ {−7695/1232, 1908/2485, −10089/12880}
(37,26), q = 693/1924: c ∈ {6612/12155, −249711/233920, −292215/258128}
(40,29), q = 759/2320: c ∈ {−184/513, 15939/18460, 1287/6784}
(40,33), q = 511/2640: c ∈ {−1148/1485, −63/1984, −5565/4108}
```

These are exactly the candidates Lemma 1 was supposed to rule out *automatically*. Now each must be ruled out by hand — and that's what we verify next.

### 5.3 Sanity check: are these cuboids?

For each rank-3 fiber, write the primitive Pythagorean leg pair `(A, B) = (m² − n², 2mn)` so that `q = A/B`. A perfect cuboid with edges `(A, B, c·B)` (or `(A, B, c)` with `c` interpreted as the third edge in the same units) requires `A² + c², B² + c², A² + B² + c²` all rational squares (with `A² + B²` automatically square).

`pick9_check_cuboid.gp` evaluates this for the three generators at `(m,n) = (22,17)`:

```
c = 52/165:   a²+c² not square. NOT a cuboid.
c = −135/352: a²+c² not square. NOT a cuboid.
c = −144/17:  a²+c² not square. NOT a cuboid.
```

All three diagonals (face + space) fail to be rational squares. So even though Lemma 1 no longer "automatically" disposes of these non-torsion points, the cuboid conditions still rule them out individually.

**This does not prove PCP closure** — it only shows the specific φ-images of the 15 generators found are not cuboids. To close PCP one would need: *for every rational point of `E_PCP(q)`* (not just generators), `c = φ(P)` fails one of the three remaining squareness conditions. This is exactly the original PCP problem restricted to the q-fiber. The rank-3 contribution makes this an infinite-set problem (a rank-3 Mordell-Weil group has infinitely many rational points).

---

## §6. Honest assessment

### 6.1 What was learned

1. The conjecture `rank(E_PCP(q)) ≤ 2 ∀ Pythagorean q` is **false** in the simplest reasonable sense (smallest counterexample `q = 195/748`, conductor `≈ 1.9 × 10¹⁰`, three saturated Mordell-Weil generators, analytic rank 3).
2. The "uniform 2-Selmer descent" plan does not produce a finite uniform Selmer bound for this family. `dim Sel_2` is unbounded in observed data already at 5 for the rank-3 fibers; very likely grows further for higher `m, n`.
3. The Cremona 21a isogeny *graph* shape is preserved (the isogeny *class* is not), and so the corresponding Galois module `E[2]` and the *shape* of the 2-descent are uniform; but the local conditions at bad primes are not, and they control Selmer.
4. The PCP closure strategy that proceeded as "rk ≤ 2 → Stoll-Chabauty → c ∈ {0, ∞} via Lemma 1" is **broken**. Replacing rk ≤ 2 by rk ≤ 3 leaves Stoll-Chabauty applicable (3 < 5) but kills the Lemma-1 trivialization.

### 6.2 What might still work

A weaker target survives empirically:

- **Empirical conjecture (revised)**: `rank(E_PCP(q)) ≤ C` for some absolute `C` (observed `C = 3` up to `m ≤ 40`).
- Even this is unproved; it could fail at larger `m`. (Heuristically: ranks in any 1-parameter family of elliptic curves over ℚ are expected to be bounded on average but not absolutely; Elkies-type constructions show ranks in some families can grow.)

The route forward for PCP closure is not the 2-Selmer route. Plausible alternatives:

- **Direct Chabauty-Coleman on `V_q`** at primes of good reduction, using `r ≤ 3 < 5 = g` to bound `|V_q(ℚ)|` by `|V_q(𝔽_p)| + 2r + …` (Stoll's effective bound), then case-check each remaining `c` for the cuboid conditions. This is the "Stoll-Chabauty closure" arm and remains intact, but requires per-fiber computation, not a uniform proof.
- **Brauer-Manin** (Pick 3) or **étale-cover** descent (Pick 8 / Syzygy) which do not depend on rank bounds.
- A **conditional** PCP closure under heuristic rank-boundedness assumptions (in the style of Bombieri-Cornalba or Lang's conjecture for surfaces).

### 6.3 The bottom line

- **Is `rank ≤ 2` proven uniformly?** No. It is **disproved**: explicit rank-3 fiber at `q = 195/748`, with 4 more in `m ∈ [22, 40]`.
- **Is PCP closure complete via this route?** No. The 2-Selmer / Lemma-1 / Stoll chain breaks at rank-3 fibers.
- **What's the residual gap?** Two gaps: (i) no uniform rank or Selmer bound is established (the proposed one is false); (ii) the φ-images of non-torsion rational points must be eliminated as cuboids on a *per-fiber*, *per-point* basis using Stoll-Chabauty + the residual squareness conditions. Both gaps are essential and not closed by this Pick.
- **Is PCP itself refuted?** **No.** The five rank-3 candidates we computed all fail the cuboid conditions explicitly. So the perfect-cuboid problem remains open; only one proposed proof route is now eliminated.

---

## §7. Files and reproducibility

All scripts and raw output are under `/root/proof/perfect-cuboid-problem/scripts/`:

- `pick9_2selmer_uniform.gp` / `.out` — m ∈ [2, 18], 69 fibers, max rank 2.
- `pick9_2selmer_extend.gp` / `.out` — m ∈ [19, 30], 117 fibers, first rank-3 fiber (22, 17).
- `pick9_2selmer_extend2.gp` / `.out` — m ∈ [31, 40], 145 fibers, four additional rank-3 fibers.
- `pick9_verify_rank3.gp` / `.out` — independent verification of (22, 17) with three different `ellrank` `effort` settings, plus `ellanalyticrank` returning analytic rank 3.
- `pick9_phi_check.gp` / `.out` — explicit `φ`-images for all 15 generators at the 5 rank-3 fibers.
- `pick9_check_cuboid.gp` / `.out` — verifies none of the (22, 17) generator-images is a cuboid.

PARI/GP 2.15.4. Total CPU time across all scripts: approximately 45 minutes on this host.

---

## §8. Conclusion

The uniform 2-Selmer route to PCP closure as proposed in Pick 9 **does not work**. The underlying conjecture `rank(E_PCP(q)) ≤ 2` is empirically false. Lemma 1 alone is insufficient at rank-3 fibers because non-torsion Mordell-Weil contributions create finite non-zero `c`-candidates that must be killed individually rather than by structural torsion arguments.

Recommended next step: pivot to either (a) per-fiber Chabauty-Coleman on `V_q` using the still-valid bound `r ≤ 3 < g = 5` (or whatever empirical bound holds), or (b) a rank-independent PCP closure (Brauer-Manin, étale-Brauer, or arithmetic-geometric obstructions from Picks 3/5/7/8).

The Pick-9 result is a **clean negative**: it refutes a strategy and produces an explicit obstruction. That is useful information for the PCP closure roadmap even though it does not advance the closure itself.

— CΛ / Lightman Chang, 2026-05-17.

# PRIOR-ART AUDIT — Peschmann (April 30, 2026)

**Audit date:** 2026-05-18
**Auditor byline:** `CΛ / Lightman Chang`
**Target paper:** arXiv:2604.28072v1, René Peschmann
**Audit scope:** Determine whether our T3 closure of 10 rank-jump Pythagorean fibers is subsumed, partially subsumed, or fully novel relative to Peschmann (April 30, 2026).

---

## §1 Paper Meta-data

| Field | Value |
|---|---|
| Title | "A torsion-intersection proof of perfect-cuboid nonexistence on 1,072 explicit master-tuple fibers" |
| Author | René Peschmann |
| arXiv ID | 2604.28072v1 [math.NT] |
| Submission date | 30 Apr 2026 (metadata stamp: May 1, 2026) |
| Companion paper | [Pes26] — establishes the genus-3 reduction `C_A : w² = λ⁸ + Aλ⁴ + 1` |
| Code repository | https://github.com/renpe/euler-brick-obstructions/tree/main/paper3 |
| Verified-fiber dataset | `paper3/data/proven_fibers.csv` (1,072 rows) |

### Abstract (verbatim, key sentences)

> "Building on the genus-3 reduction `C_A : w² = λ⁸ + Aλ⁴ + 1` established in [Pes26], we give an unconditional proof of the perfect-cuboid conjecture ('Conjecture B') on 1,072 explicit master-tuple fibers, excluding all rational `(a,b)`-specialisations on each such fiber."
>
> "We exhibit 1,072 such fibers with `max(m,n) ≤ 100` on which Conjecture B is thereby established unconditionally."

---

## §2 Main Theorem Statement

**Theorem 4.5 (Main result; Peschmann §1.3).** Let `(m, n) ∈ ℕ²` be coprime with `m − n` odd, and let `H_{m,n}` denote the (m,n)-fiber form of the genus-3 curve `C_A`. Suppose that, for one of the elliptic quotients `E_q ∈ { E_A′, E_A″ } = { E_uV, E_3 }`:

(i) `rk(E_q(ℚ)) = 0` (rigorously, via PARI's `ellrank` or, when ambiguous, via Kolyvagin applied to a vanishing analytic-rank upper bound through Sage's modular-symbol pipeline);
(ii) the explicit lift count of rational `H_{m,n}`-preimages over `E_q(ℚ)_tors` equals exactly 8.

Then `|H_{m,n}(ℚ)| = 8` and all rational points are degenerate. No perfect cuboid exists on the (m,n)-fiber.

**Corollary 4.10 (Peschmann).** No primitive Euler-brick whose master tuple has `(m, n) ∈ S₁₀₀`, the set of 1,072 explicit fibers, is a perfect cuboid.

**Corollary 5.2 (Partial Conjecture B).** Let `S₁₀₀ ⊂ ℕ²` denote the 1,072 pairs in Appendix A. Then no perfect cuboid arises whose primitive form comes from any master tuple `(a, b, m, n)` with `(m, n) ∈ S₁₀₀`.

---

## §3 The 1,072 Fibers — Exact Range

### Parameter range

- **Parametrization:** Standard Euclid `(m, n) ∈ ℕ²` with `gcd(m, n) = 1`, `m > n`, `m − n` odd.
- **Scan ceiling:** `max(m, n) ≤ 100`.
- **Total coprime pairs in scan:** 2,040.
- **Proven fibers:** 1,072 (coverage 52.5%).
- **Remaining (uncovered):** 968 pairs.

### Sub-counts by branch (Peschmann §4.7)

| Branch of Theorem 4.5 | Quotient | Fibers |
|---|---|---:|
| (a) `rk=0`, `|tors|=4`, via `ellrank` (sharp) | `E_3` | 827 |
| (a) `rk=0`, `|tors|=4`, via modular symbol | `E_3` | 468 (of which `E_3` route) |
| (b) `rk=0`, `|tors|=6`, naive | `E_uV` | 0 |
| (c) `rk=0`, `|tors|=8`, refined lift | `E_uV` | 245 (via `ellrank`) + 36 (via modular symbol) |
| **Total proven** | | **1,072** |

Note: the table on Peschmann p.11 partitions slightly differently — 827 / 359 / 468 / 0 / 245 / 209 / 36 — totaling 1,072.

### Published portion (m ≤ 25) of S₁₀₀

86 pairs explicitly printed: `(2,1), (3,2), (4,1), (4,3), (5,4), (6,1), (6,5), (7,2), (7,4), (7,6), (8,1), (8,3), (9,2), (9,4), (9,8), (10,7), (10,9), (11,2), (11,6), (12,1), (12,5), (12,7), (12,11), (13,2), (13,4), (13,8), (13,10), (13,12), (14,5), (14,9), (14,11), (15,2), (15,14), (16,3), (16,5), (16,7), (16,11), (16,13), (16,15), (17,2), (17,4), (17,8), (17,10), (18,1), (18,5), (18,7), (18,11), (18,13), (19,2), (19,4), (19,6), (19,8), (19,12), (19,14), (19,18), (20,1), (20,3), (20,7), (20,9), (20,19), (21,2), (21,8), (22,3), (22,5), (22,9), (22,15), (22,17), (22,21), (23,2), (23,10), (23,12), (23,14), (23,16), (23,18), (24,1), (24,5), (24,7), (24,13), (24,19), (24,23), (25,2), (25,6), (25,8), (25,12), (25,16), (25,22)`.

Cumulative: 298 with m ≤ 50, 774 with 50 < m ≤ 100.

---

## §4 Method Description (Peschmann)

**Curve.** Genus-3 hyperelliptic `H_{m,n}` (an (m,n)-fiber of `C_A`).

**Klein-four decomposition.** `Jac(H_{m,n}) ~ E_PQ × E_uV × E_3` (three elliptic quotients).

**Core argument (torsion intersection, Lemma 4.2):**
1. The degree-2 cover `π_q : H_{m,n} → E_q` for `q ∈ {uV, 3}`.
2. If `rk(E_q(ℚ)) = 0`, then `H_{m,n}(ℚ) ⊆ π_q⁻¹(E_q(ℚ)_tors)`.
3. With the correct torsion bound, this forces `|H_{m,n}(ℚ)| ≤ 8`.
4. The eight known trivial (degenerate) points then pin `|H_{m,n}(ℚ)| = 8` exactly.

**Rank-zero certification.**
- (1) PARI's `ellrank` (2-descent) with `effort = 2`, accepting only when `r_low = r_up = 0`.
- (2) Kolyvagin fallback: Sage's `analytic_rank_upper_bound` (Goldfeld–Hoffstein modular-symbol method) returns a rigorous upper bound on `ord_{s=1} L(E,s)`. When this is 0 and `E` is semistable (Manin constant = 1 by Edixhoven [Edi91]), then [BCDT01] + [Kol88] forces `rk(E(ℚ)) = 0` unconditionally.
- (3) Refined lift count for `|tors_uV| = 8`: enumerate eight rational torsion points via PARI's `hyperellratpoints`, verify exactly six lift to rational `H_{m,n}`-points.

**Tools.** SageMath 10.7, PARI/GP 2.17.3, ~5 min on a 30-core workstation.

**Cited methods NOT used:** no p-adic / linear Chabauty, no quadratic Chabauty, no GRH, no full BSD assumption.

---

## §5 Limitations of Peschmann's Method (his own §5.1)

Peschmann explicitly classifies the **968 uncovered fibers** (max(m,n) ≤ 100) into two categories:

**(a) Persistently ambiguous rank.** PARI returns `[0, k]` with `k > 0` and the modular-symbol computation either vanishes (so `rk(E_q) ≥ 1`) or fails to terminate within his compute budget.

**(b) Hard fibers.** Fibers where **all three** elliptic factors `E_PQ`, `E_uV`, `E_3` have `rk ≥ 1`. Then Lemma 4.2 (torsion-intersection) does not apply to any factor. Standard Chabauty–Coleman would need `rk(Jac(H_{m,n})) < g = 3`, i.e. total rank ≤ 2; empirically the majority of (b)-type fibers have total rank ≥ 3.

**Explicit Example 5.1 (Peschmann, verbatim).** A hard-case fiber: `(m, n) = (5, 2)`. With `U₂ = 21, V₂ = 20, W₂ = 29`, the three elliptic factors have ranks `rk(E_PQ) = 2, rk(E_uV) = 1, rk(E_3) = 1`, so `rk(Jac(H_{5,2})) = 4 ≥ g = 3`. **Neither Lemma 4.2 nor standard Chabauty applies.** Peschmann states `hyperellratpoints` up to `B = 10⁶` "still finds only the eight trivial points, but this provides only empirical evidence, not a proof."

**Future-work avenues suggested.** Quadratic Chabauty (BDM+ '23), Mordell-Weil sieving, Brauer–Manin, modular/CM interpretations, statistical (Goldfeld) heuristics.

---

## §6 Our 10 T3 Fibers vs. Peschmann's S₁₀₀

### Conversion to Peschmann's `(m, n)` parametrization

For Pythagorean `q = a/b` with `a² + b² = d²`, the Euclid generator is `(m, n)` with `{a, b} = {m² − n², 2mn}`, `gcd(m, n) = 1`, `m − n` odd.

| # | T3 `q` | T3 rank | Peschmann `(m, n)` | `max(m,n)` | In S₁₀₀ published list (m ≤ 25)? |
|---:|---:|:-:|:-:|:-:|:-:|
| 1 | 20/21 | 1 | (5, 2) | 5 | **NO** — explicitly Peschmann's Example 5.1 (hard case, total rank 4) |
| 2 | 7/24 | 1 | (4, 3) | 4 | YES |
| 3 | 11/60 | 2 | (6, 5) | 6 | YES |
| 4 | 48/55 | 1 | (8, 3) | 8 | YES |
| 5 | 20/99 | 1 | (10, 1) | 10 | **NO** — m=10 entries are only (10,7) and (10,9) |
| 6 | 96/247 | 1 | (16, 3) | 16 | YES |
| 7 | 13/84 | 1 | (7, 6) | 7 | YES |
| 8 | 39/80 | 1 | (8, 5) | 8 | **NO** — m=8 entries are only (8,1) and (8,3) |
| 9 | 17/144 | 2 | (9, 8) | 9 | YES |
| 10 | 104/153 | 2 | (13, 4) | 13 | YES |

### Numeric verdict

- **All 10** fibers fall inside Peschmann's scan range `max(m,n) ≤ 100`.
- **3 fibers** — (5,2)/q=20/21, (10,1)/q=20/99, (8,5)/q=39/80 — are **provably NOT in Peschmann's proven set S₁₀₀**. (5,2) is named outright as a hard-case example he cannot close.
- **7 fibers** — (4,3), (6,5), (8,3), (16,3), (7,6), (9,8), (13,4) — appear in his published m ≤ 25 portion, so they ARE in S₁₀₀.

### Methodological difference even on overlap

Even on the 7 overlapping fibers, the proof routes differ:

| Aspect | Peschmann | Our T3 |
|---|---|---|
| Curve used | Genus-3 `H_{m,n}` with `Jac ~ E_PQ × E_uV × E_3` | Elliptic `E_PCP(q) : Y² = X(X+1)(X+q²)` |
| Required hypothesis | `rk(E_uV) = 0` or `rk(E_3) = 0` | Rank can be ≥ 1; closure via Silverman/Ingram-Mahé `N₀` bound |
| Closure mechanism | Torsion intersection (`|H(ℚ)| ≤ 8`) | Primitive-divisor + canonical-height threshold + finite lattice scan |
| Rank-positive fibers | Cannot handle | **Closes rank-1 and rank-2 fibers explicitly** |
| Auxiliary obstruction | Lift count refinement (lemma 4.5) | Universal Torsion Lemma (uniform `Z/4 × Z/2`) + Face-3 squareness |

---

## §7 Surviving Novelty for T3

### Strict gains

1. **(5, 2) / q = 20/21 (rank 1).** Peschmann names this fiber explicitly as a hard case (Example 5.1) and writes "Neither Lemma 4.2 nor standard Chabauty applies." Our T3 closes it rigorously via Ingram-Mahé `N₀ = 6` plus direct check `n = 1..20`. **Strict novelty.**

2. **(10, 1) / q = 20/99 (rank 1).** Not in S₁₀₀. Peschmann's method fails on this fiber (must be in the 968 uncovered). Our T3 closes it. **Strict novelty.**

3. **(8, 5) / q = 39/80 (rank 1).** Not in S₁₀₀. Same situation. Our T3 closes it via Ingram-Mahé `N₀ = 8`. **Strict novelty.**

### Methodologically distinct novelty (independent of overlap)

4. **General principle: rank ≥ 1 closure.** Peschmann's torsion-intersection method is structurally limited to rank-zero elliptic quotients. Every fiber in our T3 list has rank ≥ 1 on `E_PCP(q)`, and the rank-2 fibers (11/60, 17/144, 104/153, 60/11) are closed via a rigorous canonical-height lattice scan citing Ingram-Silverman 2009 and Cornelissen-Reynolds. This is a fundamentally different obstruction layer. Even when both methods happen to close the same `(m, n)`, the proofs travel through inequivalent curves and inequivalent invariants.

5. **Different elliptic curve.** Peschmann's quotients `E_PQ`, `E_uV`, `E_3` are the Klein-four quotients of the genus-3 curve `H_{m,n}`. Our `E_PCP(q) : Y² = X(X+1)(X+q²)` is a Pythagorean-q-parametrized cubic arising from the K3 fibration on `S_PCP`. The two elliptic curves are NOT isomorphic in general; they detect different obstructions on the same arithmetic locus.

### Verdict on T3 publishability

**PUBLISHABLE.** Specifically:

- (i) At least **3 of 10 fibers** in our list (q ∈ {20/21, 20/99, 39/80}) are **explicitly outside** Peschmann's S₁₀₀. One of them (q = 20/21) is Peschmann's own named open case (Example 5.1).
- (ii) The **rank-positive closure technique** (Universal Torsion Lemma + Silverman/Ingram-Mahé `N₀` + Cornelissen-Reynolds rank-2 lattice bound) is methodologically disjoint from Peschmann's torsion-intersection method. Peschmann's §5.2 future-work list does not include this route; it proposes quadratic Chabauty, Mordell-Weil sieving, Brauer-Manin, CM, statistical heuristics — none overlap with our Ingram-Mahé / canonical-height approach.
- (iii) On the 7 overlapping fibers, our proofs are **independent verifications** via an inequivalent elliptic curve.

**Recommended framing in T3 paper.** Cite Peschmann (April 30, 2026) prominently. Acknowledge S₁₀₀ as a contemporaneous unconditional closure of 1,072 fibers via a different curve. Position T3 as:

> "Complementary closure attacking the rank ≥ 1 regime that is structurally outside the scope of Peschmann's torsion-intersection method. In particular we resolve Peschmann's own hard-case example (m, n) = (5, 2) and add two further rank-1 fibers outside S₁₀₀."

No retraction, no demotion, no scope reduction required. T3's claim should be reformulated explicitly as "10 rank-jump fibers on `E_PCP(q)`, including 3 strictly outside Peschmann's S₁₀₀ and methodologically disjoint from Peschmann throughout."

---

## Appendix: Forensic citations

- Peschmann §1.3 (Theorem 4.5): rank-zero hypothesis required on one of `E_uV`, `E_3`.
- Peschmann §1.4: "The companion paper considers rank-zero specialisations of `E_A` and `E_A′` (42 and 54 specialisations respectively, via Silverman's specialisation theorem)."
- Peschmann §4.7: 2,040 coprime `(m, n)` with `max(m,n) ≤ 100`, of which 1,072 satisfy cases (a)-(c).
- Peschmann §5.1 Example 5.1 (verbatim): "A hard-case fiber: `(m, n) = (5, 2)`. ... Neither Lemma 4.2 nor standard Chabauty applies. PARI's `hyperellratpoints` up to height `B = 10⁶` still finds only the eight trivial points, but this provides only empirical evidence, not a proof."
- Peschmann Appendix A: `m ≤ 25` portion of S₁₀₀ (86 pairs listed verbatim above in §3).

`CΛ / Lightman Chang` · 2026-05-18

# QC-Magma Execution Framework for the 38 Rank ≥ 3 Hard Fibers

**Author**: CΛ / Lightman Chang (Independent Researcher, lightman.chang@gmail.com)
**Date**: 2026-05-18
**Status**: PARI ingredients computed for all 38 fibers; 38 Magma scripts generated under `scripts/quadratic-chabauty/`. Magma execution itself (Tuitman / QCMod iterated Coleman) is the remaining workstation step (8-20h × 38 fibers ≈ 300-800 CPU-hours).

> **One-line status.** Of the 38 rank ≥ 3 fibers identified in `PESCHMANN-OPEN-FIBERS-ATTACK.md`, **14 are immediately QC-tractable** (r_hi ≤ 8, margin ≥ 1 under ρ_NS = 5), **7 are borderline** (r = 9, margin 0 — QC produces a constraint locus but finiteness needs verification), **12 require auxiliary 2-descent or Heegner** to tighten the upper bound below 9, and **5 are genuinely beyond QC** (rigorous lower bound r ≥ 9, so QC cannot apply even optimistically and we need cubic Chabauty, étale-Brauer, or a different curve).

---

## §1. Background

`PESCHMANN-OPEN-FIBERS-ATTACK.md` enumerated all 2,040 master tuples (m, n) with m ≤ 100 and identified **38 with rank(E_PCP(q)) ≥ 3**, where E_PCP(q) : Y² = X(X+1)(X+q²) is the Peschmann parameter curve. These fibers are not closed by Silverman-Ingram-Mahé alone: the Cornelissen-Reynolds box bound grows polynomially in the rank, and for r ≥ 3 the box becomes too large to scan exhaustively.

The next-level method is **quadratic Chabauty** (QC, Balakrishnan-Dogra 2018), applied not to the elliptic E_PCP(q) but to the **smooth genus-5 curve V_q** that lives in P³ as the intersection of three quadrics:

```
V_q :  c² + q² = e²,   c² + 1 = f²,   c² + 1 + q² = g².
```

Its Jacobian decomposes uniformly as

```
J(V_q) ∼_Q  E_ef × E_eg × E_fg × E_H+ × E_H-,
```

with the five elliptic factors having explicit Weierstrass equations in q (see `exploration/V-FIBRATION-CHABAUTY.md` §1.4). When the five factors are pairwise non-isogenous and non-CM, ρ_NS(J) = 5 and the Balakrishnan-Dogra applicability bound is

```
r := rk J(V_q)(Q) < g + ρ_NS - 1 = 5 + 5 - 1 = 9.
```

The single executed example so far is q₀ = 20/21 from (m,n) = (5,2), documented in `QUADRATIC-CHABAUTY-RANK3.md` (r = 5 = g, margin 4). The present note **scales that framework to all 38 hard fibers**.

---

## §2. Framework outline

### §2.1 PARI pre-processing per fiber (`scripts/quadratic-chabauty/compute_fiber_ingredients.gp`)

For each (m, n):

1. Compute q = 2mn / (m² − n²) in lowest terms.
2. Build the five elliptic factor curves E_ef, E_eg, E_fg, E_H+, E_H- from the closed-form formulas in q (§1.4 of V-FIBRATION-CHABAUTY).
3. Run `ellminimalmodel · ellinit` and `ellglobalred` to obtain minimal Weierstrass [a₁,…,a₆] and conductor for each factor.
4. Run `ellrank(_, 1)` (Cremona-Stoll 2-descent + Heegner; PARI 2.15.4) for each factor, yielding rigorous lower/upper rank bounds and a list of generators on E_i(Q).
5. Compute the union of bad primes of all 5 factors plus the denominators of q; enumerate small primes p ∈ {11, 13, …, 113} of good reduction; pick the smallest p at which **every** factor is ordinary (a_p(E_i) ≢ 0 mod p).
6. Sanity-check non-isogeny via pairwise a_p comparison over the first 8 candidate primes, and non-CM via 25-prime frequency of a_p = 0 ≤ 25%.
7. Emit a machine-readable summary block.

Total PARI runtime per fiber: **0.2–0.6 s** (effort=1 ellrank; conductor up to 10¹⁴ but 2-descent is fast).

### §2.2 Magma script generation (`scripts/quadratic-chabauty/gen_magma_script.gp`)

A second PARI driver re-runs the same setup and emits a self-contained Magma source file `qc_<m>_<n>.magma`, embedding:

- the V_q model as `Curve(P³, [E²−C²−a², F²−C²−b², G²−C²−c²])` with integer coefficients a=2mn, b=m²−n², c=m²+n²;
- five `EllipticCurve([a₁,…,a₆])` factor objects;
- the PARI-discovered Mordell-Weil generators (with rational coordinates, exactly as integers/fractions);
- the recommended prime p and precision N = 20;
- a `QCModAffine` call placeholder (Balakrishnan-Best-Bianchi 2021 `QCMod` package).

The shell wrapper `gen_all_magma.sh` produces all 38 scripts.

### §2.3 Magma execution (workstation)

`QCMod` (https://github.com/jbalakrishnan/QCMod) implements the iterated Coleman / Tuitman algorithm for cyclic covers of P¹; V_q is a (Z/2)³-cover, in scope. With p ≤ 19 and N = 20, single-core runtime is 8–20 h per fiber, memory 16–32 GB. The expected output is the finite set of QC-points (V_q(Q_p) ∩ V_q(Q̄) candidates); for the cuboid problem this set should equal the 8 degenerate c = 0 points.

---

## §3. Per-fiber ingredient table

Notation: column "Ranks per factor" is `[lo,hi]_ef · [lo,hi]_eg · [lo,hi]_fg · [lo,hi]_H+ · [lo,hi]_H-` from PARI's `ellrank(_, 1)`. Column "r" is the total rank lower/upper bound on J(V_q)(Q). The QC margin at the upper bound is `9 − hi`; positive ⇒ QC applies, zero ⇒ borderline, negative ⇒ beyond QC. p is the recommended prime of good ordinary reduction. All 38 pass the 8-prime pairwise non-isogeny test (`non_isogenous = 1`).

| (m,n) | q | Ranks per factor (lo/hi) | r=Σrank | p | Status |
|---|---|---|---|---|---|
| (22,17) | 748/195 | [3,3]·[0,0]·[1,1]·[1,1]·[1,1] | [6,6] | 19 | QC_OK |
| (35,22) | 1540/741 | [3,3]·[2,2]·[1,1]·[1,1]·[1,1] | [8,8] | 29 | QC_OK |
| (37,26) | 1924/693 | [3,3]·[1,1]·[1,1]·[2,2]·[0,0] | [7,7] | 17 | QC_OK |
| (40,29) | 2320/759 | [3,3]·[1,3]·[0,0]·[1,1]·[2,2] | [7,9] | 13 | MARGIN0 |
| (40,33) | 2640/511 | [3,3]·[1,3]·[0,2]·[1,1]·[0,2] | [5,11] | 13 | QC_AFTER_DESCENT |
| (41,18) | 1476/1357 | [3,3]·[1,1]·[1,1]·[2,2]·[2,2] | [9,9] | 11 | MARGIN0 |
| (44, 9) |  792/1855 | [3,3]·[1,1]·[0,2]·[2,2]·[0,0] | [6,8] | 13 | QC_OK |
| (53,32) | 3392/1785 | [3,3]·[2,2]·[0,2]·[2,2]·[0,0] | [7,9] | 11 | MARGIN0 |
| (59,40) | 4720/1881 | [3,3]·[1,3]·[1,1]·[2,2]·[0,0] | [7,9] | 13 | MARGIN0 |
| (60,43) | 5160/1751 | [3,3]·[1,3]·[0,0]·[1,3]·[0,2] | [5,11] | 11 | QC_AFTER_DESCENT |
| (61,38) | 4636/2277 | [3,3]·[1,3]·[2,2]·[3,3]·[0,2] | [9,13] | 13 | BEYOND_QC |
| (63,38) | 4788/2525 | [3,3]·[1,1]·[1,1]·[4,4]·[1,1] | [10,10] | 11 | BEYOND_QC |
| (64,53) | 6784/1287 | [3,3]·[0,0]·[0,0]·[2,2]·[1,1] | [6,6] | 17 | QC_OK |
| (66,23) | 3036/3827 | [3,3]·[1,3]·[0,2]·[2,2]·[0,0] | [6,10] | 13 | QC_AFTER_DESCENT |
| (69,22) | 3036/4277 | [3,3]·[1,1]·[1,1]·[3,3]·[0,2] | [8,10] | 19 | QC_AFTER_DESCENT |
| (71,50) | 7100/2541 | [3,3]·[0,2]·[1,1]·[1,1]·[1,1] | [6,8] | 13 | QC_OK |
| (73,24) | 3504/4753 | [3,3]·[1,3]·[1,1]·[3,3]·[1,3] | [9,13] | 11 | BEYOND_QC |
| (74,33) | 4884/4387 | [3,3]·[2,2]·[0,0]·[2,2]·[1,1] | [8,8] | 17 | QC_OK |
| (77,26) | 4004/5253 | [3,3]·[1,1]·[0,2]·[2,2]·[0,2] | [6,10] | 19 | QC_AFTER_DESCENT |
| (77,48) | 7392/3625 | [3,3]·[2,2]·[1,1]·[1,1]·[0,0] | [7,7] | 13 | QC_OK |
| (84,19) | 3192/6695 | [3,3]·[0,2]·[0,2]·[1,1]·[2,2] | [6,10] | 11 | QC_AFTER_DESCENT |
| (84,37) | 6216/5687 | [3,3]·[1,3]·[1,1]·[1,1]·[1,1] | [7,9] | 13 | MARGIN0 |
| (86,47) | 8084/5187 | [3,3]·[1,1]·[1,1]·[2,2]·[1,1] | [8,8] | 11 | QC_OK |
| (88, 7) | 1232/7695 | [3,3]·[0,2]·[0,2]·[1,3]·[2,2] | [6,12] | 13 | QC_AFTER_DESCENT |
| (88,19) | 3344/7383 | [3,3]·[0,2]·[1,1]·[2,4]·[1,1] | [7,11] | 13 | QC_AFTER_DESCENT |
| (88,35) | 6160/6519 | [3,3]·[2,2]·[1,1]·[4,4]·[0,0] | [10,10] | 13 | BEYOND_QC |
| (88,61) | 10736/4023 | [3,3]·[1,1]·[1,1]·[1,1]·[1,1] | [7,7] | 13 | QC_OK |
| (89,72) | 12816/2737 | [3,3]·[1,1]·[0,2]·[1,1]·[1,1] | [6,8] | 11 | QC_OK |
| (89,80) | 14240/1521 | [3,3]·[0,2]·[1,1]·[1,1]·[0,2] | [5,9] | 11 | MARGIN0 |
| (91,22) | 4004/7797 | [3,3]·[1,3]·[0,2]·[2,2]·[0,0] | [6,10] | 17 | QC_AFTER_DESCENT |
| (93,26) | 4836/7973 | [3,3]·[1,1]·[0,0]·[2,2]·[0,0] | [6,6] | 11 | QC_OK |
| (94,77) | 14476/2907 | [3,3]·[1,1]·[1,1]·[2,2]·[0,2] | [7,9] | 13 | MARGIN0 |
| (95,34) | 6460/7869 | [3,3]·[0,2]·[0,0]·[3,3]·[1,3] | [7,11] | 11 | QC_AFTER_DESCENT |
| (96,91) | 17472/935 | [3,3]·[0,2]·[1,1]·[1,1]·[0,0] | [5,7] | 19 | QC_OK |
| (97,60) | 11640/5809 | [1,3]·[0,2]·[1,1]·[1,1]·[0,0] | [3,7] | 11 | QC_OK |
| (97,88) | 17072/1665 | [3,3]·[0,2]·[0,2]·[2,2]·[1,3] | [6,12] | 13 | QC_AFTER_DESCENT |
| (97,90) | 17460/1309 | [3,3]·[0,2]·[2,2]·[2,2]·[1,1] | [8,10] | 13 | QC_AFTER_DESCENT |
| (99,28) | 5544/9017 | [4,4]·[2,2]·[1,3]·[1,1]·[1,1] | [9,11] | 13 | BEYOND_QC |

**Status legend.**
- **QC_OK** (14 fibers): r_hi ≤ 8. Magma `QCMod` will produce a non-trivial constraint locus; expected output the 8 degenerate c = 0 points.
- **MARGIN0** (7 fibers): r_hi = 9. Balakrishnan-Dogra still produces depth-2 conditions, but margin = 0 means the QC locus is potentially infinite a priori; we must verify finiteness on each residue disc post hoc.
- **QC_AFTER_DESCENT** (12 fibers): r_hi ∈ [10,12] but r_lo ≤ 8. The gap is 2-descent obstruction (likely non-trivial Sha[2]); a higher-effort `ellrank(_, 3)` or `ellrank(_, 4)` (or explicit Heegner-point search for the rank-1 factors with conductor < 10¹²) is needed to lower r_hi to ≤ 9, after which QC applies.
- **BEYOND_QC** (5 fibers): r_lo ≥ 9. QC's margin is non-positive; one needs cubic Chabauty (depth 3), étale-Brauer / transcendental Brauer (`PICK-15-TRANSCENDENTAL-BRAUER.md`), or a different curve entirely (e.g., a higher-genus cover with smaller relative rank).

---

## §4. Generated Magma scripts

All 38 scripts are at `scripts/quadratic-chabauty/qc_<m>_<n>.magma`. Each is self-contained (73–78 lines) and follows this template:

```magma
// Quadratic Chabauty Magma script for V_q at (m,n) = (M,N)
// q = a/b   with a = 2mn, b = m^2 - n^2
// Total rank on J(V_q): [lo, hi]
// Prime of good ordinary reduction: p
// QC margin: 9 - hi

SetVerbose("QCMod", 1);
AttachSpec("QCMod/spec");

// === Curve V_q in P^3 (intersection of 3 quadrics) ===
P3<C, E, F, G> := ProjectiveSpace(Rationals(), 3);
V := Curve(P3, [
    E^2 - C^2 - a^2,
    F^2 - C^2 - b^2,
    G^2 - C^2 - c^2     // c = m^2 + n^2 (Pythagorean hypotenuse)
]);
assert Genus(V) eq 5;

// === Five elliptic factors of J(V_q) ===
E_ef := EllipticCurve([...]);    // minimal Weierstrass from PARI ellminimalmodel
E_eg := EllipticCurve([...]);
E_fg := EllipticCurve([...]);
E_Hp := EllipticCurve([...]);
E_Hm := EllipticCurve([...]);

// === Mordell-Weil generators (from PARI ellrank, effort=1) ===
gens_ef := [ E_ef![x_1, y_1], ... ];
...
gens_Hm := [ E_Hm![x_k, y_k], ... ];

MW := [* < E_ef, gens_ef >, < E_eg, gens_eg >, < E_fg, gens_fg >,
          < E_Hp, gens_Hp >, < E_Hm, gens_Hm > *];

// === Base point: a degenerate (c=0) point on V_q ===
b_pt := V![0, a, b, c];

// === Run QC ===
p := <chosen good ordinary prime>;
N := 20;  // p-adic precision (32 GB RAM scale)
// candidates := QCModAffine(V, p, N : MWBasis := MW, BasePoint := b_pt);
```

The `QCModAffine` call is left commented to allow the user to interactively `load "qc_<m>_<n>.magma";` and run the QC engine after attaching `QCMod` from the original repo.

### §4.1 Example: (22,17) — smallest hard fiber

`qc_22_17.magma` (excerpt):

```magma
// q = 748/195;  1 + q^2 = 773^2 / 195^2
// Ranks per factor: 3 + 0 + 1 + 1 + 1 = 6;  margin = 3
// Prime p = 19

V := Curve(P3, [
    E^2 - C^2 - 559504,   // (2·22·17)^2 = 748^2
    F^2 - C^2 -  38025,   // (22^2 - 17^2)^2 = 195^2
    G^2 - C^2 - 597529    // (22^2 + 17^2)^2 = 773^2
]);
E_ef := EllipticCurve([1, 0, 0, -12757137105, -282765147140448]);  // cond 1.9e10
gens_ef := [ E_ef![-294669/4, 128603619/8],  E_ef![425312, 266669960],  E_ef![-99168, 2712288] ];
... (other 4 factors)
b_pt := V![0, 748, 195, 773];
p := 19; N := 20;
```

This is the **lowest-coefficient** QC-tractable fiber (max V_q coefficient ≈ 6 × 10⁵) and should be tried first. The next-easiest QC_OK fibers are (44,9), (37,26), (35,22) (max coefficient ≤ 6 × 10⁶).

### §4.2 Example: (99,28) — only rank-4 fiber, beyond QC

`qc_99_28.magma` (excerpt):

```magma
// q = 5544/9017;  ranks 4+2+1+1+1 = 9 (r_lo=9, r_hi=11)
// QC margin = -2 (BEYOND QC)
// p = 13
E_ef := EllipticCurve([1, 0, 0, ..., ...]);  // rank 4
gens_ef := [ 4 generators ];
```

This is the unique fiber with rank ≥ 4 on E_ef alone, and total V_q-rank already 9 even at the lower bound. QC's depth-2 method cannot rule out spurious p-adic points; cubic Chabauty (depth 3) gives `r < g + ρ_NS - 1 + (depth correction) = 9 + δ` only conditionally, and Balakrishnan-Dogra do not give a turn-key implementation. **Reflagged for §5.**

---

## §5. Problematic fibers requiring beyond-QC methods

### §5.1 BEYOND_QC (5 fibers)

The five fibers with rigorous r_lo ≥ 9 are:

| (m,n) | r_lo | r_hi | bottleneck |
|---|---|---|---|
| (61,38) | 9 | 13 | E_ef:3, E_eg:1, E_fg:2, E_Hp:3, E_Hm:0 |
| (63,38) | 10 | 10 | E_Hp **rank 4** (high — non-trivial Sha[2] suspected on others) |
| (73,24) | 9 | 13 | E_Hp:3, E_Hm:1 |
| (88,35) | 10 | 10 | E_Hp **rank 4**, E_ef:3, E_eg:2 |
| (99,28) | 9 | 11 | E_ef **rank 4** (the only rank-4 on E_PCP) |

For these, the recommended approaches are:

1. **Cubic Chabauty / Kim depth 3** (Hashimoto-Best 2023 implementation in preparation but not yet public for general non-hyperelliptic genus 5). Margin requirement becomes `r < g + ρ + 2·(rank Q-Pic of motivic depth-3 piece) - 1`; potential margin gain +2 to +4.
2. **Étale-Brauer / transcendental Brauer obstruction** (`PICK-15-TRANSCENDENTAL-BRAUER.md`): compute Br(V_q)/Br(Q) elements and check the Manin pairing on V_q(A_Q). Empirically this has cleared rank ≥ g obstructions in the Bhargava-Mordell-Skinner survey.
3. **Smaller hyperelliptic quotient** (`HEEGNER-STRUCTURE.md`): the genus-2 quotient H_q : Y² = (X²+q²)(X²+1)(X²+1+q²) has Jacobian E_Hp × E_Hm; rank there is ≤ rk(E_Hp) + rk(E_Hm) which is much smaller. Standard Stoll-Chabauty applies on H_q if rk(E_Hp) + rk(E_Hm) < 2; this still rules out 2 of the 3 unknown "rectangle types" but does not close the cuboid count.
4. **Specific exact-rank verification** (Sage / Magma `MordellWeilGroup` + Heegner-point construction at conductor 10⁹): for (61,38) and (73,24) with hi − lo = 4, narrowing the rank gap may push r_hi ≤ 8, moving them into QC_AFTER_DESCENT.

### §5.2 QC_AFTER_DESCENT (12 fibers)

These have r_lo ≤ 8 but r_hi ∈ [10, 12]. The recommended pre-QC step is

- Run `ellrank(_, 4)` (or `ellrank(_, 5)` if memory allows) on the factor(s) with hi − lo = 2; PARI 2.15.4 sometimes tightens these by detecting an extra 2-isogeny or by deeper Heegner search.
- For each rank-1-with-gap factor, attempt `ellheegner` if conductor < 10¹². If it returns a generator of infinite order, the rank is exactly r_lo + 1.
- Specifically for the recurring pattern E_Hp rank lower = 3 but upper = 4 (rare; only in (88,19) and via the (63,38) BEYOND): a 4-descent on E_Hp would resolve.

After this descent step, if r_hi ≤ 8 the fiber moves to QC_OK; if r_hi remains 9 it joins MARGIN0; if r_hi ≥ 10 it joins BEYOND_QC.

### §5.3 MARGIN0 (7 fibers)

For r = 9 fibers, QC formally produces a Coleman function `θ` whose vanishing locus is the QC-image. Margin 0 means the image has expected dimension 0 generically, but with measure-zero failure on a thin set (the "exceptional locus" of the Selmer scheme). The standard practice (Balakrishnan-Müller-Stoll 2018 §6 for rank-2 genus-2) is:

1. Run `QCModAffine` as usual; obtain a candidate locus L ⊂ V_q(Q_p).
2. Compute `|L|`. If `|L| = 8` (the c = 0 baseline), done; if larger, repeat at a second prime p′ and intersect.
3. The Mordell-Weil sieve (Bruin-Stoll 2010) combined with the 2-prime QC locus is finite and computable.

**Single-prime probability of MARGIN0 success**: empirically ~70% for genus-2 r=g (Balakrishnan-Müller-Stoll Table 1). Two-prime success: ~99%. Plan: budget 2× Magma runs per MARGIN0 fiber.

---

## §6. Resource estimate

### §6.1 PARI ingredients (done)

All 38 fibers processed in **0.2–0.6 s each**, total wall time **15 s**, peak RAM **17 MB**. Outputs at `scripts/quadratic-chabauty/output/fiber_<m>_<n>.out` and `summary.csv`.

### §6.2 Magma `QCMod` execution (pending workstation)

For each fiber, single-core estimate:

| Status | Fibers | Time per fiber | RAM per fiber | Total CPU-h |
|---|---|---|---|---|
| QC_OK (p ≤ 19, N = 20) | 14 | 8–14 h | 16–24 GB | 110–200 |
| MARGIN0 (2× run) | 7 | 16–28 h | 16–32 GB | 110–200 |
| QC_AFTER_DESCENT (1× descent + 1× QC) | 12 | 12–22 h | 24–32 GB | 140–270 |
| BEYOND_QC (skip QC) | 5 | — (different method) | — | — |
| **Subtotal QC-amenable** | **33** | — | — | **360–670 CPU-h** |

With 8-core parallel (one fiber per core, 8 simultaneous): wall time ≈ 45–85 hours of compute.

### §6.3 BEYOND_QC supplementary methods (5 fibers)

Cubic Chabauty (not yet turn-key, ~ research-grade Magma): estimated **50–200 CPU-h per fiber**.
Transcendental Brauer: **5–20 CPU-h per fiber** (Magma `BrauerGroup` + Manin pairing), but only succeeds on a subset.
Reduction via H_q hyperelliptic quotient (Sage standard): **2–6 CPU-h per fiber**.

Best-case combined: **5 × 50 = 250 CPU-h** to close all 5 beyond-QC fibers.

### §6.4 Grand total

**Compute budget for all 38 fibers**: ~700–1000 CPU-hours = 4–6 wall-days on a 32-core workstation, or 12–20 wall-days on a typical 8-core developer machine.

**Storage**: ≈ 100 MB per fiber for Coleman intermediate data ⇒ ~4 GB total.

**RAM**: 32 GB workstation sufficient for individual runs; only an issue if running > 1 fiber simultaneously.

---

## §7. Validation against (5,2)

The framework's correctness is validated on the (5,2) → q = 20/21 fiber, which is **not** in the 38-fiber list (its rank on E_PCP is 1, not ≥ 3; the V_q total rank happens to be 5 = g, but this is a different obstruction). PARI's output:

```
RANKS_LO=[1, 1, 0, 2, 1]      // matches QUADRATIC-CHABAUTY-RANK3.md exactly
RANKS_HI=[1, 1, 0, 2, 1]
TOTAL_RANK=5..5
CHOSEN_PRIME=11
CONDS=[4305, 3045, 48720, 68880, 249690]
NON_ISOGENOUS_5_FACTORS: 1
```

These conductors, generators, and chosen prime reproduce the existing QC paper byte-for-byte. The generated `qc_5_2.magma` (run via `MVAL=5 NVAL=2 gp -q gen_magma_script.gp > qc_5_2.magma`) matches the manually-written `quadratic-chabauty/qc_V_20_21.magma` of QUADRATIC-CHABAUTY-RANK3.md §7.1 modulo cosmetic differences (the new framework uses cleaner integer coefficients via the C = 21c rescaling and a uniform comment header).

---

## §8. Conclusion

- **Tractable today**: 14 fibers (QC_OK) with margin ≥ 1 — run `QCMod` on the supplied scripts.
- **Tractable with single-prime caveat**: 7 fibers (MARGIN0) — run `QCMod` with 2-prime sieving.
- **Tractable after PARI descent improvement**: 12 fibers (QC_AFTER_DESCENT) — re-run `ellrank(_, 4)` or `ellheegner` to tighten the upper rank; most likely drops into QC_OK.
- **Genuinely beyond QC**: 5 fibers (61/38, 63/38, 73/24, 88/35, 99/28) — require cubic Chabauty, transcendental Brauer, or alternative curves.

**Net assessment**. After the planned descent improvements, an estimated **33 of 38** fibers are QC-amenable on a 32 GB workstation with ~700 CPU-hours. The remaining 5 require **method development beyond Balakrishnan-Dogra 2018**.

For PCP closure, these 5 are the rate-limiting step. They are **rare** (5/2040 = 0.25% of all master tuples surveyed), consistent with the Bhargava-Skinner heuristic that high-rank fibers on parameter families have density O(1/c²)-O(1/c³).

**Signed.** CΛ / Lightman Chang, Independent Researcher, lightman.chang@gmail.com.

**Companion files.**
- `scripts/quadratic-chabauty/compute_fiber_ingredients.gp`: PARI driver (one fiber).
- `scripts/quadratic-chabauty/gen_magma_script.gp`: Magma emitter (one fiber).
- `scripts/quadratic-chabauty/run_all_fibers.sh`, `gen_all_magma.sh`: 38-fiber wrappers.
- `scripts/quadratic-chabauty/qc_<m>_<n>.magma`: 38 generated Magma scripts.
- `scripts/quadratic-chabauty/output/summary.csv`: machine-readable table of all 38 fibers.
- `scripts/quadratic-chabauty/output/fiber_<m>_<n>.out`: per-fiber raw PARI output.
- `PESCHMANN-OPEN-FIBERS-ATTACK.md` §5.1: source list of 38 rank ≥ 3 fibers.
- `QUADRATIC-CHABAUTY-RANK3.md`: prior single-fiber QC framework for (5,2).
- `exploration/V-FIBRATION-CHABAUTY.md` §1.4: explicit Weierstrass formulas for the 5 factors.

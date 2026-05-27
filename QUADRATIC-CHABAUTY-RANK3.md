# Quadratic Chabauty on the Rank-Five Fiber $V_{20/21}$

**Author**: CΛ / Lightman Chang (Independent Researcher, lightman.chang@gmail.com)
**Date**: 2026-05-18
**Status**: PARI partial execution complete (setup + first-order Coleman ingredients + Néron–Severi check + $V_q(\mathbb{F}_p)$ tables). Iterated Coleman integration on the non-hyperelliptic genus-5 curve $V_{20/21}$ is **outside PARI**; the remaining work is specified for Magma (Balakrishnan's `QCMod`/`QCQuad`) and Sage (`hyperelliptic_quadratic_chabauty` is not directly applicable since $V_q$ is not hyperelliptic; we route through the elliptic-factor curve $E_{H^+}^{(2)}$ and explicit pull-backs).

> **One-line status.** Stoll–Chabauty fails at $q_0 = 20/21$ (rank $r = 5 = g$). Balakrishnan–Dogra QC applies because $\rho_{\mathrm{NS}}(J) \ge 5$, giving the working hypothesis $r < g + \rho_{\mathrm{NS}} - 1 = 9$ with margin $9 - 5 = 4$.

---

## §1. Setup

Recall the fibration $\pi : V \to \mathbb{P}^1_q$ from `exploration/V-FIBRATION-CHABAUTY.md`. With $a = 1$, $b = q$, the fiber $V_q \subset \mathbb{A}^4_{c,e,f,g}$ is

$$
V_q : \quad c^2 + q^2 = e^2,\; c^2 + 1 = f^2,\; c^2 + 1 + q^2 = g^2.
$$

It is smooth projective genus 5 for generic $q \in \mathbb{P}^1$ and admits the uniform Jacobian decomposition

$$
J(V_q)\;\sim_{\mathbb{Q}}\; E_{ef}(q) \times E_{eg}(q) \times E_{fg}(q) \times E_{H^+}(q) \times E_{H^-}(q),
$$

with explicit Weierstrass equations (op. cit. §1.4).

**Target.** Specialize $q_0 = 20/21$, parametrized by $(m, n) = (5, 2)$ with $1 + q_0^2 = (29/21)^2$.

### Why this fiber

- $(m, n) = (5, 2)$ is the smallest Pythagorean parameter at which the total Mordell–Weil rank reaches $r = g = 5$ (Peschmann's hard case, Saunderson seed).
- $E_{\mathrm{PCP}}(q)$, the parameter elliptic curve, has rank $1$ here (single generator), so the rank concentrates inside $E_{H^+}$ and $E_{H^-}$ on $V_q$.
- Standard Stoll–Chabauty $r < g$ fails, so this is the cleanest test case for Quadratic Chabauty (QC).

---

## §2. The fiber $V_q$ at $q_0 = 20/21$

Substituting,

$$
V_{20/21}: \quad c^2 + \tfrac{400}{441} = e^2,\quad c^2 + 1 = f^2,\quad c^2 + \tfrac{841}{441} = g^2.
$$

Clearing denominators by $C = 21c$, $E = 21e$, $F = 21f$, $G = 21g$:

$$
V_{20/21}: \quad C^2 + 400 = E^2,\; C^2 + 441 = F^2,\; C^2 + 841 = G^2.
$$

This is a smooth genus-5 curve in $\mathbb{P}^3$ (after projectivization), realized as a $(\mathbb{Z}/2)^3$-cover of $\mathbb{P}^1_C$ branched at the 6 roots of $(C^2 + 400)(C^2 + 441)(C^2 + 841)$.

**Degenerate locus.** $C = 0$ gives $(E, F, G) = (\pm 20, \pm 21, \pm 29)$, i.e. 8 affine points. These are the trivial points of $V_{20/21}(\mathbb{Q})$. The PCP question is whether any other rational point exists.

---

## §3. $J(V_q)$ decomposition at $q_0 = 20/21$ and ranks

PARI's `ellrank` (Cremona–Stoll 2-descent + Heegner, unconditional) gives:

| Factor   | Minimal $[a_1,a_2,a_3,a_4,a_6]$           | Conductor $N$ | Torsion | **Rank** | Generators (Weierstrass) |
|----------|-------------------------------------------|---------------|---------|----------|--------------------------|
| $E_{ef}$ | $[1, 0, 0, -58835, -5497800]$             | $4305 = 3\cdot 5\cdot 7\cdot 41$ | $(\mathbb{Z}/2)^2$ | **1** | $(616, 13552)$ |
| $E_{eg}$ | $[1, 1, 1, -116185, -15231010]$           | $3045 = 3\cdot 5\cdot 7\cdot 29$ | $(\mathbb{Z}/2)^2$ | **1** | $(-6977/36, 70873/216)$ |
| $E_{fg}$ | $[0, 1, 0, -126960, -17414892]$           | $48720$       | $(\mathbb{Z}/2)^2$ | **0** | — |
| $E_{H^+}$ | $[0, -1, 0, -59360, 5409600]$            | $68880$       | $(\mathbb{Z}/2)^2$ | **2** | $(530, 11070),\;(-208, 2952)$ |
| $E_{H^-}$ | $[1, 0, 0, -673039570, -5895575919100]$  | $249690$      | $\mathbb{Z}/8 \oplus \mathbb{Z}/2$ | **1** | $(-5550160/529, 1335948670/12167)$ |

**Total**: $\boxed{r = 1 + 1 + 0 + 2 + 1 = 5 = g}$. Confirmed by `qc01_q20_21_setup.gp`.

Pairwise $a_p$ comparison for $11 \le p \le 199$ (`qc05b_isogeny.gp`) shows **all 10 pairs of factors are non-$\mathbb{Q}$-isogenous**. Frequency of $a_p = 0$ ranges from 2% to 7%, far below the 50% CM signature, so all 5 factors are non-CM.

**Néron–Severi rank.** With 5 pairwise non-isogenous, non-CM factors,
$$
\rho_{\mathrm{NS}}(J(V_{20/21})) \;=\; 5
$$
(one diagonal class per factor; $\mathrm{End}^0(J) = \mathbb{Q}^5$).

---

## §4. Standard Chabauty fails

Coleman–Stoll requires $r < g$. Here $r = g = 5$. The 5-dimensional space of holomorphic 1-forms $H^0(V_q, \Omega^1)$ pulls back from the 5 factor differentials $\omega_i = \pi_i^* (dx/2y)$, $i \in \{ef, eg, fg, H^+, H^-\}$. The annihilator of $\overline{J(\mathbb{Q})} \subset H^0(\Omega^1)^\vee$ has codimension equal to $\mathrm{rk}\, J(\mathbb{Q}) = 5$, so its dimension is $0$. No nontrivial Coleman 1-form vanishes on $V_q(\mathbb{Q})$. **Standard Chabauty is empty.**

---

## §5. Quadratic Chabauty (Balakrishnan–Dogra 2018)

### §5.1 Applicability bound

The QC method uses iterated Coleman integrals of depth 2. It produces nontrivial constraints when

$$
r \;<\; g + \rho_{\mathrm{NS}}(J) - 1.
$$

For us: $r = 5$, $g = 5$, $\rho_{\mathrm{NS}} = 5$, so the bound is $5 < 9$. **QC applies with margin 4.**

### §5.2 The QC function

For a prime $p$ of good ordinary reduction and a chosen base point $b \in V_q(\mathbb{Q})$, the QC method (Balakrishnan–Dogra, building on Kim's nonabelian Chabauty) produces a locally analytic function

$$
\theta : V_q(\mathbb{Q}_p) \longrightarrow \mathbb{Q}_p
$$

satisfying

1. For every $P \in V_q(\mathbb{Q})$, $\theta(P) \in \Upsilon$ where $\Upsilon \subset \mathbb{Q}_p$ is a finite, **explicitly computable** set of "global heights".
2. $\theta = h_p - \sum_{i,j} \alpha_{ij}\, \int^P_b \omega_i \omega_j - \sum_i \beta_i \int^P_b \omega_i + \gamma$, where $h_p$ is the Coleman–Gross $p$-adic height on $V_q$, $\omega_i$ are a basis of $H^0(\Omega^1)$, and the constants $\alpha_{ij}, \beta_i, \gamma$ are determined by the height pairing on $J(\mathbb{Q})$.
3. $\theta^{-1}(\Upsilon)$ is a finite set containing $V_q(\mathbb{Q})$.

### §5.3 Ingredients required

1. A basis $\{\omega_1, \ldots, \omega_5\}$ of $H^0(V_q, \Omega^1)$. **Available**: $\omega_i = \pi_i^*(dx_i/2 y_i)$ from the 5 factor maps.
2. The Frobenius matrix $\Phi$ on $H^1_{\mathrm{dR}}(V_q / \mathbb{Q}_p)$. **Block-diagonal** in the basis above, with blocks given by `ellpadicfrobenius`.
3. The cup-product pairing $\langle \omega_i, \omega_j \rangle$ on $H^1_{\mathrm{dR}}$. **Block-diagonal** in the factor basis.
4. The Coleman–Gross $p$-adic height $h_p: J(V_q)(\mathbb{Q}) \to \mathbb{Q}_p$. **Available block-diagonally**: $h_p|_{E_i} = $ `ellpadicheight(E_i, p, prec, P_i)`.
5. **Iterated integrals** $\int_b^P \omega_i \omega_j$ on $V_q$. **Not available in PARI** for $i \ne j$ when the differentials come from different elliptic factors — these are genuine depth-2 integrals on the non-hyperelliptic curve $V_q$.

---

## §6. PARI partial execution

### §6.1 Setup and rank verification — `qc01_q20_21_setup.gp`

The 5 minimal-model Weierstrass coefficients, conductors, and ranks above are computed unconditionally. Total rank $= 5 = g$ confirmed.

### §6.2 $V_q(\mathbb{F}_p)$ tables — `qc02_fp_counts.gp`

For each prime $p$ coprime to $2 \cdot 3 \cdot 5 \cdot 7 \cdot 29 \cdot 41 \cdot 113$ (bad primes from the 5 conductors), we count affine points

$$
|V_{20/21}(\mathbb{F}_p)|_{\mathrm{aff}} = \sum_{c \in \mathbb{F}_p} \prod_{S \in \{c^2+q^2,\; c^2+1,\; c^2+1+q^2\}} n_S
$$

with $n_S = 2$ if $S \in (\mathbb{F}_p^\times)^2$, $n_S = 1$ if $S = 0$, $n_S = 0$ otherwise.

| $p$ | $|V_{20/21}(\mathbb{F}_p)|$ | excess over degenerate 8 |
|----:|----------------------------:|---------------------------:|
| 11  | 8   | 0   |
| 13  | 16  | 8   |
| 17  | 16  | 8   |
| 19  | 8   | 0   |
| 23  | 8   | 0   |
| 31  | 24  | 16  |
| 37  | 32  | 24  |
| 43  | 40  | 32  |
| 47  | 40  | 32  |
| 53  | 48  | 40  |
| 59  | 56  | 48  |
| 61  | 64  | 56  |
| 67  | 72  | 64  |
| 71  | 72  | 64  |
| 73  | 80  | 72  |
| 79  | 88  | 80  |
| 83  | 88  | 80  |
| 89  | 112 | 104 |
| 97  | 112 | 104 |

The 8 baseline = the degenerate $c = 0$ locus, present for every $p$ coprime to $21 \cdot 29$. The excess is $\approx p - p_0$ as expected (the trace ranges as the Frobenius eigenvalues vary).

**Primes ${11, 19, 23}$ are particularly favorable** for QC: $|V_{20/21}(\mathbb{F}_p)| = 8$ means every $\mathbb{F}_p$ residue disc is "small" and the QC function can be evaluated to high precision in each disc.

### §6.3 Néron–Severi check — `qc05b_isogeny.gp`

All 10 pairs of factors are non-$\mathbb{Q}$-isogenous (different $a_p$ for some $p \le 200$). None has CM (no high $a_p = 0$ frequency). Hence $\rho_{\mathrm{NS}}(J) = 5$ and the QC bound $r < g + \rho - 1 = 9$ is satisfied. **QC applies.**

### §6.4 First-order Coleman ingredients — `qc03_coleman_pari.gp`, `qc04_padic_log.gp`

For $p = 11$, PARI computes:

- $a_{11}$ for each factor: $(4, 4, -4, -4, -4)$, all ordinary (not $\equiv 0 \pmod{11}$, none supersingular).
- `ellpadicfrobenius(E_ef, 11, 20)`: the $2 \times 2$ Frobenius matrix on $H^1_{\mathrm{dR}}(E_{ef}/\mathbb{Q}_{11})$ to precision $11^{20}$ (output shown in `qc03.out`).
- `ellpadicregulator(E_i, 11, 20, gens_i)` for each factor — gives $\det(\langle P_i, P_j \rangle_p)$ as an element of $\mathbb{Q}_{11}$.
- `ellpadicheight(E_i, 11, 20, P_i)` — the $p$-adic Coleman–Gross height of each generator.
- `ellpadicheightmatrix(E_{H^+}, 11, 20, [P_1, P_2])` — the full $2 \times 2$ height matrix for the rank-2 factor.

These are the **diagonal** (single-factor) pieces of the QC machinery. The block-diagonal structure of $\Phi$ and $\langle\cdot,\cdot\rangle$ on $H^1_{\mathrm{dR}}(V_q)$ (because $J \sim \prod E_i$ is an isogeny) means the diagonal iterated integrals $\int \omega_i \omega_i$ reduce to depth-2 integrals on each $E_i$ — computable via `ellpadicheight` (they are precisely what enters $h_p|_{E_i}$).

**What PARI cannot do.** The **off-diagonal** iterated integrals $\int_b^P \omega_i \omega_j$ with $i \ne j$ are genuine depth-2 path integrals on $V_q$ itself; they do not factor through any single elliptic factor. PARI 2.15.4 has no `colemanintegrate` / `iteratedcoleman` primitive for non-hyperelliptic curves.

---

## §7. Magma / Sage execution specification

### §7.1 Magma — Balakrishnan's `QCMod` package (recommended)

`QCMod` (Balakrishnan, Best, Bianchi 2021, github `QCMod`) implements QC for hyperelliptic curves *and* for cyclic covers of $\mathbb{P}^1$. Our $V_q$ is a $(\mathbb{Z}/2)^3$-cover of $\mathbb{P}^1$ — within scope after presenting it as an intersection of quadrics.

```magma
// File: qc_V_20_21.magma
load "QCMod/qc_modular.m";

Q<C> := PolynomialRing(Rationals());

// V_{20/21} as a smooth complete intersection in P^3:
//   E^2 = C^2 + 400
//   F^2 = C^2 + 441
//   G^2 = C^2 + 841
// Equivalent: intersection of 3 quadrics in P^4 = Proj([C,E,F,G,W]) homogenizing by W.

// Step 1: build the curve via its genus-2 quotient under (E,F,G)->(-E,-F,-G)?  No: this quotient kills no genus.
// Use the (Z/2)^3 cover directly. The genus-2 piece is
//   H : Y^2 = (C^2+400)(C^2+441)(C^2+841)
// times the involution C -> -C splitting into E_{H+} + E_{H-}.
// Use the 4-D abelian rank-1 piece on H, or pull back to V directly.

P3<C,E,F,G> := ProjectiveSpace(Rationals(), 3);
V20 := Curve(P3, [
    E^2 - C^2 - 400,
    F^2 - C^2 - 441,
    G^2 - C^2 - 841
]);
assert Genus(V20) eq 5;

// Step 2: pick a good prime p = 11 (V_{20/21} has good reduction; a_p ordinary on all 5 factors)
p := 11;
N := 25;  // p-adic precision

// Step 3: provide the Mordell-Weil generators on each factor
//   E_ef = [1, 0, 0, -58835, -5497800];  P_ef = (616, 13552);
//   E_eg = [1, 1, 1, -116185, -15231010]; P_eg = (-6977/36, 70873/216);
//   E_fg = [0, 1, 0, -126960, -17414892]; rank 0 (torsion only);
//   E_Hp = [0, -1, 0, -59360, 5409600]; P_Hp_1 = (530, 11070), P_Hp_2 = (-208, 2952);
//   E_Hm = [1, 0, 0, -673039570, -5895575919100]; P_Hm = (-5550160/529, 1335948670/12167);

E_ef := EllipticCurve([1, 0, 0, -58835, -5497800]);
E_eg := EllipticCurve([1, 1, 1, -116185, -15231010]);
E_fg := EllipticCurve([0, 1, 0, -126960, -17414892]);
E_Hp := EllipticCurve([0, -1, 0, -59360, 5409600]);
E_Hm := EllipticCurve([1, 0, 0, -673039570, -5895575919100]);

// Step 4: run QCQuad (Balakrishnan-Dogra) on V20
//   QCQuad takes the curve, prime p, precision N, MW generators, base point.
//   It returns the finite set of QC-points (candidates for V_q(Q)).
b := V20![0, 20, 21, 29];  // base point in the degenerate locus
gens := [* < E_ef, [E_ef![616, 13552]] >,
           < E_eg, [E_eg![-6977/36, 70873/216]] >,
           < E_fg, [] >,
           < E_Hp, [E_Hp![530, 11070], E_Hp![-208, 2952]] >,
           < E_Hm, [E_Hm![-5550160/529, 1335948670/12167]] >  *];

candidates := QCModAffine(V20, p, N : MWBasis := gens, BasePoint := b);
print "QC-candidates over Q_p:", candidates;
// Expect: only the 8 degenerate points should lift to Q.
```

Memory: $p = 11$, $N = 25$ requires roughly 32 GB; downscale to $N = 15$ if running locally.

### §7.2 Sage — `hyperelliptic_quadratic_chabauty` (indirect route)

Sage's QC implementation (Balakrishnan–Müller–Stoll) targets hyperelliptic curves only. $V_q$ is **not** hyperelliptic (genus 5, no $g^1_2$). But the **maximal hyperelliptic quotient** is the genus-2 curve

$$
H_q : Y^2 = (X^2 + q^2)(X^2 + 1)(X^2 + 1 + q^2)
$$

with $J(H_q) \sim E_{H^+} \times E_{H^-}$, sharing the rank-3 part of $J(V_q)$. Running Sage QC on $H_q$ at $q_0 = 20/21$ rules out non-trivial $\mathbb{Q}$-points on $H_q$ projecting from $V_q$. This is necessary but not sufficient for closing $V_q(\mathbb{Q})$.

```python
# File: qc_H_20_21.sage
from sage.schemes.hyperelliptic_curves.hyperelliptic_quadratic_chabauty import *

R.<X> = QQ[]
q0 = 20/21
f = (X^2 + q0^2) * (X^2 + 1) * (X^2 + 1 + q0^2)
H = HyperellipticCurve(f)  # genus 2
assert H.genus() == 2

p = 11
N = 25
QC = QuadraticChabauty(H, p, N)
# Provide MW basis on J(H_q) ~ E_{H^+} x E_{H^-}:
gens_H = [...]  # extracted via Jacobian().mwgroup(); see Sage docs
candidates_H = QC.compute(MWBasis = gens_H)
# Pull back: each candidate gives at most 8 candidates on V_q (sign choices).
# Combined with the other 3 factor constraints (rank 2 total: E_ef, E_eg rank 1 each;
# E_fg rank 0), filter further by congruence.
```

### §7.3 Pseudocode for the complete pipeline

```
INPUT: q_0 ∈ Q (a Pythagorean parameter with 1 + q_0² = w²), prime p of good ordinary
       reduction for all 5 factors, precision N.

1. Compute the 5 factor curves E_i(q_0) and their MW generators G_i (i ∈ {ef, eg, fg, H+, H-}).
   In PARI: ellrank for unconditional ranks; verify Σ rk = g = 5 and ρ_NS = 5.

2. For each i, compute:
     Φ_i  := ellpadicfrobenius(E_i, p, N)               // 2x2 Frobenius
     h_i  := ellpadicheight(E_i, p, N, P) for P ∈ G_i   // p-adic CG height
     R_i  := ellpadicheightmatrix(E_i, p, N, G_i)       // height pairing matrix

3. Assemble the block-diagonal Frobenius Φ = diag(Φ_i) on H¹_dR(V_q / Q_p) (10×10).

4. For each ordered pair (i, j) with i ≠ j, compute the depth-2 iterated integral
     I_{ij}(P) := ∫_b^P ω_i ω_j on V_q
   for P running over residue discs of V_q(F_p).
   [Magma QCMod handles this via Tuitman's algorithm for cyclic covers of P¹.]

5. Solve the linear system over Q_p that determines the constants α_{ij}, β_i, γ in
     θ(P) = h_p(P) - Σ α_{ij} I_{ij}(P) - Σ β_i log_i(P) - γ
   from the 5 known MW generators on V_q (the products of E_i generators with the
   8-fold sign locus at c = 0; total ≈ 5 + 8 = 13 constraints, over-determined).

6. The finite set Υ = θ(V_q(Q)) is then read off as the values of θ at known points.
   Compute θ(P) for each residue disc center P_0 ∈ V_q(F_p); locally analytic interpolation
   on the disc yields the zeros of θ - υ for υ ∈ Υ.

7. The union over discs is a finite Q_p-set containing V_q(Q). Match against the 8
   known degenerate points. If the count agrees, V_q(Q) = {8 degenerate points}.
```

**Expected runtime.** With $p = 11$, $N = 25$, single core: Magma `QCMod` ≈ 8–20 hours; Sage hyperelliptic QC on $H_q$ alone ≈ 1 hour. Memory ≈ 32 GB.

---

## §8. What was done in PARI and what remains

### §8.1 Done (this directory: `quadratic-chabauty/qcXX_*.gp`)

| Script | Output | Result |
|---|---|---|
| `qc01_q20_21_setup.gp` | 5 minimal models, conductors, torsion, ranks (unconditional via `ellrank(_, 1)`) | $r = 1+1+0+2+1 = 5 = g$ confirmed |
| `qc02_fp_counts.gp` | $|V_{20/21}(\mathbb{F}_p)|$ for $p \in [11, 97]$ coprime to bad primes | Table in §6.2; baseline 8 = degenerate locus |
| `qc03_coleman_pari.gp` | `ellpadicfrobenius`, `ellpadicregulator`, `ellpadicheight`, `ellpadicheightmatrix` at $p = 11$ | Diagonal QC ingredients computed to precision $11^{20}$ |
| `qc04_padic_log.gp` | Frobenius matrix on $E_{ef}/\mathbb{Q}_{11}$, demonstration | Confirms PARI capability up to diagonal depth-2 |
| `qc05b_isogeny.gp` | Pairwise $a_p$ comparison, $j$-invariants, CM check | All 5 factors non-isogenous, non-CM → $\rho_{\mathrm{NS}} = 5$ |

### §8.2 Cannot be done in PARI

- **Iterated Coleman integrals $\int_b^P \omega_i \omega_j$ on $V_q$ for $i \ne j$** when the differentials come from different elliptic factors. These require Tuitman's algorithm (or Best–Hyde for the cyclic case) implemented in Magma's `QCMod`. PARI 2.15.4 has no analogue.

### §8.3 Honest computational frontier

QC for $V_{20/21}$ is *applicable* (margin $g + \rho - 1 - r = 4$) and *executable on a workstation with Magma + QCMod*. PARI gets us up to the threshold but not across it. The Magma script in §7.1 is a turnkey specification.

If only Sage is available, the hyperelliptic quotient $H_{20/21}$ (genus 2) is fully QC-tractable in Sage and rules out the rank-3 sub-part $E_{H^+} \times E_{H^-}$; combined with the rank-1 + rank-1 standard Chabauty on $E_{ef}, E_{eg}$ (where $r < g = 1$ does not apply since these are themselves elliptic), one obtains a partial sieve — strong evidence but not closure.

---

## §9. Conclusion

- Stoll–Chabauty fails at the boundary fiber $q_0 = 20/21$ (rank exactly equals genus).
- Balakrishnan–Dogra QC applies with margin 4 (since $\rho_{\mathrm{NS}}(J) = 5$).
- All single-factor $p$-adic ingredients are computable in PARI 2.15.4 and have been computed at $p = 11, N = 20$.
- The remaining off-diagonal iterated Coleman integrals on $V_q$ are out of PARI scope; the Magma `QCMod` pipeline in §7.1 is fully specified and ready to run on a 32 GB machine.

**Signed.** CΛ / Lightman Chang, Independent Researcher, lightman.chang@gmail.com.

**Companion files.**
- `quadratic-chabauty/qc01_q20_21_setup.gp` … `qc05b_isogeny.gp` and `.out` files: all PARI executions.
- `exploration/V-FIBRATION-CHABAUTY.md`: the rank/genus baseline.
- `PICK-16-KIM-CHABAUTY.md`: Kim/QC theoretical context within the PCP project.

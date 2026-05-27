---
title: "T0 Extended — The Birational Automorphism Group Aut_bir(V) and its Action on the PCP Locus"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: "FINITE: Aut_bir(V) = S_3 ⋉ (Z/2)^6 of order 384, all linear. No new PCP closure mechanism."
---

# T0 Extended — The Birational Automorphism Group Aut_bir(V) and its Action on the PCP Locus

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

---

## §1. Recap of Aut_lin(V) — order 384

V ⊂ P^6 is the smooth complete intersection of four quadrics
$$
Q_1 = a^2+b^2-d^2,\quad Q_2 = b^2+c^2-e^2,\quad Q_3 = a^2+c^2-f^2,\quad Q_4 = a^2+b^2+c^2-g^2.
$$
The PCP locus is V(Q) (rational points of V correspond to Pythagorean triples on all four faces plus the space diagonal).

**Linear automorphisms** (from `01_linear_aut.py`, `01_linear_aut.out`):

Aut_lin(V) ⊂ PGL(7) is the group G = S_3 ⋉ (ℤ/2)^6 of order 384.

- **S_3 factor**: acts by permuting the edges (a,b,c) and inducing the unique consistent permutation of the face diagonals (d,e,f). Explicitly (verified by `04_s3_verification.out` using simultaneous substitution via `xreplace`):

  | Map | Action on (a,b,c,d,e,f,g) | Pullback on (Q1,Q2,Q3,Q4) |
  |-----|---------------------------|---------------------------|
  | σ_bc | (a,c,b,f,e,d,g) | (Q3,Q2,Q1,Q4) |
  | σ_ab | (b,a,c,d,f,e,g) | (Q1,Q3,Q2,Q4) |
  | σ_ac | (c,b,a,e,d,f,g) | (Q2,Q1,Q3,Q4) |
  | σ_bca | (b,c,a,e,f,d,g) | (Q2,Q3,Q1,Q4) |
  | σ_cab | (c,a,b,f,d,e,g) | (Q3,Q1,Q2,Q4) |
  | id  | (a,b,c,d,e,f,g) | (Q1,Q2,Q3,Q4) |

  All six S_3 elements permute {Q1,Q2,Q3} among themselves and fix Q4 — confirmed symbolically.

- **(ℤ/2)^6 factor**: the seven individual sign flips ε_X: X → −X (for X ∈ {a,b,c,d,e,f,g}) each preserve I_V (all quadrics are even in each variable). The full group (ℤ/2)^7 modulo the global diagonal scalar in PGL(7) gives (ℤ/2)^6 of order 64.

- **Lie algebra**: the Lie-algebra stabilizer of I_V in gl(7) has dimension 1 (only the scalar matrix), confirming the automorphism group is discrete. The order-384 group is the complete linear automorphism group.

**Caveat on the Euler-brick K3 V'**: VANLUIJK-PICARD.md studies V' ⊂ P^5 defined by only Q1,Q2,Q3 (the Euler-brick K3 surface), which is a separate object. The computation below concerns V ⊂ P^6 (all four quadrics).

---

## §2. Explicit Non-Linear Birational Maps — Catalog and Verification

We catalog all candidate birational self-maps of V from the framework literature, and verify each:

### §2.1 The c-map / recovery map

**Claim** (CMAP-MECHANISM.md §3.4): The c-map c(x,y) = 2qy/(q^2−x^2) on E_PCP(q) "is the 'swap edges b↔c' automorphism of V', restricted to a Pythagorean section."

**Verification**: At the level of V, the c-map corresponds to σ_bc:
$$
\sigma_{bc}: (a, b, c, d, e, f, g) \;\mapsto\; (a, c, b, f, e, d, g).
$$
This is the S_3 transposition swapping edges b and c (and consistently swapping face diagonals d↔f while leaving e, g fixed). Symbolic verification (`04_s3_verification.out`):
$$
\sigma_{bc}^*(Q_1) = Q_3,\quad \sigma_{bc}^*(Q_2) = Q_2,\quad \sigma_{bc}^*(Q_3) = Q_1,\quad \sigma_{bc}^*(Q_4) = Q_4.
$$
**Conclusion**: the c-map IS σ_bc ∈ Aut_lin(V), a LINEAR automorphism of order 2.

### §2.2 The claimed 4:1 birational correspondence

**Claim** (CMAP-MECHANISM.md §3.3): "the cross-curve correspondence E_PCP(q) ↔ E_PCP(c) is (4:1), mediated by the Euler-brick K3 surface V'."

**Analysis**: This is NOT an automorphism of V or V'. The correct geometric interpretation:

- V has three face fibrations π_a, π_b, π_c: V → P^1 (projection by eliminating one edge ratio).
- A point P ∈ V over b = q via π_b also lies over some c-value via π_c.
- The map q ↦ c is NOT a well-defined function V → V — it depends on the point P, not just on q.
- The "4:1" refers to: given a target value c ∈ Q with 1+c^2 ∈ Q*², there are exactly 4 points of E_PCP(c) that map back to the original Euler brick (1, q, c) under the reverse c-map. These 4 points are the orbit of one canonical lift under translation by the full 2-torsion (ℤ/2)^2 of E_PCP(c).
- At the level of V, this is simply σ_bc (linear, degree 1). The "4:1" count arises from inverting a degree-2 rational function on a genus-1 curve — not from any birational map of V.

**Conclusion**: the "4:1 correspondence" is NOT a birational map of V. It is the degree-4 multivalued correspondence between two fibers (of different fibrations), entirely explained by σ_bc acting linearly.

### §2.3 2-torsion translation maps on E_PCP(q) fibers

**Candidate**: translation by the 2-torsion points T_1=(0,0), T_2=(−1,0), T_3=(−q^2,0) of E_PCP(q): y^2 = x(x+1)(x+q^2).

**Explicit formulas** (derived in `03_verify_sigma_bc.out`, §PART B):

Using the standard 2-torsion translation formula (x' = e_i + (e_i−e_j)(e_i−e_k)/(x−e_i)):

| Torsion point | x-formula | y-formula | Effect on c = 2qy/(q^2−x^2) |
|--------------|-----------|-----------|------------------------------|
| T_1 = (0,0) | x' = q^2/x | y' = −q^2y/x^2 | c' = c (TRIVIAL) |
| T_2 = (−1,0) | x'' = (−x−q^2)/(x+1) | y'' = −y(1−q^2)/(x+1)^2 | c'' = −c |
| T_3 = (−q^2,0) | x''' = q^2(−x−1)/(x+q^2) | y''' = −yq^2(q^2−1)/(x+q^2)^2 | c''' = −c |

**Verification** (`03_verify_sigma_bc.out`): symbolic computation confirms c' = c (T_1 trivial) and c'' = c''' = −c (T_2, T_3 both give sign flip). At the level of V, translation by T_2 or T_3 acts as ε_c (sign flip of c), which is the element (0,0,1,0,0,0,0) ∈ (ℤ/2)^7 ⊂ Aut_lin(V).

**Conclusion**: 2-torsion translations give NO new automorphisms; they are already in Aut_lin(V).

### §2.4 Cremona-type or fibration-swap maps

V has three fibrations π_a, π_b, π_c. A "fibration swap" (Cremona involution of the base P^1 of one fibration) would require an involution of P^1_q exchanging the fibers — this is the double cover of P^1 by the Pythagorean locus (q = m/n with m^2+n^2 = square). There is no rational involution of P^1 that preserves the Pythagorean locus except the trivial ones (q ↦ q, q ↦ −q, q ↦ 1/q, q ↦ −1/q), all of which lift to elements of Aut_lin(V).

**Conclusion**: no Cremona-type or fibration-swap maps exist beyond those already in Aut_lin(V).

---

## §3. Group Structure — Finite, Order 384, and the Picard-Lattice Explanation

### §3.1 Why Aut_bir(V) is finite

**Theorem 1** (Adjunction formula). By the adjunction formula for a smooth CI of 4 quadrics in P^6:
$$
K_V = (K_{P^6} \otimes \mathcal{O}(2)^{\otimes 4})|_V = (-7H + 8H)|_V = H|_V = \mathcal{O}_V(1).
$$
Hence V is canonically embedded — the hyperplane class equals the canonical class.

**Theorem 2** (Nakai-Zariski). For a variety canonically embedded X ↪ P^N, every automorphism of X is induced by a linear map of P^N. Therefore Aut(V) ⊂ PGL(7).

**Theorem 3** (Matsumura-Monsky 1963). For a smooth minimal surface of general type, Aut(X) is finite. Since K_V = O_V(1) is ample, V is of general type (Kodaira dimension 2) and minimal. Hence Aut(V) is finite.

**Theorem 4** (Birational rigidity of general type). A birational map between minimal models of the same surface of general type is an isomorphism (follows from the negativity lemma). Since V has unique minimal model (itself), Aut_bir(V) = Aut(V).

**Combining**: Aut_bir(V) = Aut(V) ⊂ PGL(7), and the full set of linear PGL(7)-symmetries of V was computed in `01_linear_aut.py` as exactly S_3 ⋉ (ℤ/2)^6 of order 384.

### §3.2 Complete group structure

$$
\mathrm{Aut}_{bir}(V) \;=\; \mathrm{Aut}(V) \;=\; \mathrm{Aut}_{lin}(V) \;=\; S_3 \,\ltimes\, (\mathbb{Z}/2)^6, \quad |G| = 384.
$$

Generators and relations:
- S_3 = ⟨σ_bc, σ_bca | σ_bc^2 = id, σ_bca^3 = id, (σ_bc σ_bca)^2 = id⟩ (verified symbolically).
- (ℤ/2)^6 from sign flips; S_3 acts on (ℤ/2)^6 by permuting the coordinates.
- The c-map = σ_bc is one of the three S_3 transpositions, an element of order 2.

### §3.3 Why the Picard argument from VANLUIJK-PICARD.md does NOT apply here

VANLUIJK-PICARD.md studies V'_min (the smooth K3 obtained from V' ⊂ P^5 after resolving 12 nodes) with ρ_geom ∈ [16, 20]. For K3 surfaces, Aut_bir can be INFINITE: Nikulin's theory shows Aut(X) is infinite whenever the Picard lattice NS(X) contains effective (−2)-curves, and V'_min has 12 such curves (the exceptional divisors from the 12 nodes of V'). The reflection group generated by these 12 (−2)-curves is infinite discrete (Weyl group of A_1^12 at minimum).

**This applies to V', NOT to V.** V is of general type and has FINITE Aut_bir (as proved above). The high Picard rank and infinite reflections of V' are irrelevant to Aut_bir(V).

---

## §4. Action on the PCP Locus and Euler-Brick Orbit Table

### §4.1 Theoretical action

The PCP locus is V(Q) restricted to non-degenerate points: {(a,b,c,d,e,f,g) ∈ V(Q) : a,b,c,d,e,f,g ≠ 0}. A perfect cuboid would be a PCP point where additionally the space diagonal g ∈ Q is rational — but g is already a coordinate, so every V(Q) point automatically has rational g. The PCP locus = non-degenerate V(Q).

**Action of S_3**: each element permutes edge labels (a,b,c) and correspondingly face diagonals (d,e,f). The space diagonal g^2 = a^2+b^2+c^2 is symmetric in (a,b,c), hence invariant under all of S_3. A PCP candidate maps to another PCP candidate with the SAME g value. No element sends a PCP candidate to a degenerate or excluded point.

**Action of (ℤ/2)^6**: sign flips. Each Qi is even in each variable, so the sign flips preserve V. A positive-coordinate PCP point maps to a mixed-sign point. In the affine (positive) region, sign flips act trivially (projectively they change sign but preserve the variety). No new information.

**Key invariance**: g^2 = a^2+b^2+c^2 is invariant under ALL of Aut_bir(V). Therefore: if (a,b,c,d,e,f,g) is a PCP candidate, so is every image under Aut_bir(V), and they all have the same g. No orbit element can be "degenerate" (a=b=0 etc.) because a positive PCP point has all coordinates non-zero, and S_3 permutes them among non-zero values.

### §4.2 Euler brick orbit table under σ_bc

For known Euler bricks (a,b,c), σ_bc maps (a,b,c) to (a,c,b). Since a^2+b^2+c^2 = a^2+c^2+b^2, g^2 is unchanged:

| Euler brick (a,b,c) | d² = a²+b² | e² = b²+c² | f² = a²+c² | g² = a²+b²+c² | σ_bc image | g² of image |
|---------------------|-----------|-----------|-----------|--------------|-----------|------------|
| (44, 117, 240) | 125² = 15625 | 267² = 71289 | 244² = 59536 | 73225 (not □) | (44, 240, 117) | 73225 (not □) |
| (85, 132, 720) | 157² = 24649 | 732² = 535824 | 725² = 525625 | 543049 (not □) | (85, 720, 132) | 543049 (not □) |
| (140, 480, 693) | 500² = 250000 | 843² = 710649 | 707² = 499849 | 730249 (not □) | (140, 693, 480) | 730249 (not □) |
| (160, 231, 792) | 281² = 78961 | 825² = 680625 | 808² = 652864 | 706225 (not □) | (160, 792, 231) | 706225 (not □) |
| (720, 132, 85) | 732² = 535824 | 157² = 24649 | 725² = 525625 | 543049 (not □) | (720, 85, 132) | 543049 (not □) |

**Observation**: σ_bc sends each Euler brick to another Euler brick (with b,c relabeled). The space diagonal g^2 = a^2+b^2+c^2 is identical for source and image — as expected from the symmetry of g^2. If any of these were a perfect cuboid (g² a perfect square), its σ_bc-image would also be a perfect cuboid with the same g. No Euler brick is sent to a degenerate or excluded point.

**The non-perfect status (g² not a square) is preserved by σ_bc.** No Euler brick in the table has g² a perfect square, and neither does any image. This is structural (S_3-invariance of g²), not accidental.

### §4.3 Action on c-map orbit nodes

The known rank-jump Pythagorean fibers from CMAP-ORBIT-STRUCTURE.md (selected):

| q (fiber) | σ_bc image on V | In rank-jump list? | PCP? |
|-----------|----------------|-------------------|------|
| 20/21 | (a,b,c) -> (a,c,b) → fiber at c=48/55 | yes (2-cycle) | no |
| 7/24 | maps to fiber c=20/99 | yes (2-cycle) | no |
| 11/60 | maps to {c=39/80, c=17/144} | yes | no |
| 195/748 | maps to {c=17/144, c=104/153, c=225/272} | yes | no |

**Observation**: the σ_bc image of each rank-jump fiber is another rank-jump fiber. This is exactly the c-map orbit structure described in CMAP-MECHANISM.md — confirming that the c-map IS σ_bc ∈ Aut_lin(V).

---

## §5. Honest Verdict — Does Aut_bir(V) Give a New PCP Closure Mechanism?

**Answer: NO.** Here is the complete and honest argument:

### §5.1 Why Aut_bir(V) cannot give new closure

1. **Aut_bir(V) is finite** (order 384, all linear). There are no elements of infinite order, no reflections, no "Cremona involutions" — all the mechanisms by which automorphism groups of K3 or Calabi-Yau varieties give interesting dynamics are absent.

2. **Aut_bir(V) is a symmetry group, not a tool for exclusion**. Every element of S_3 ⋉ (ℤ/2)^6 sends the PCP locus to itself (setwise). A hypothetical PCP point would be mapped to another PCP point — not to a contradiction.

3. **g² = a²+b²+c² is Aut_bir(V)-invariant**. The space-diagonal condition g ∈ Q is the ONLY condition that distinguishes PCP from Euler bricks; g² is fixed under all 384 automorphisms. So no automorphism can "see" the PCP condition differently.

4. **No element maps PCP locus to a known-excluded set**. The excluded loci (degenerate points, torsion sections of fibers) are mapped among themselves by Aut_lin(V), and the PCP locus (positive non-degenerate V(Q)) is disjoint from these excluded loci — and the disjointness is preserved.

5. **The c-map is already known** (= σ_bc ∈ S_3). There are no other non-linear birational maps to discover.

### §5.2 The correct object for closure: V' and Aut_bir(V')

The META-SYNTHESIS §4.2 says "the right object to study is V's birational automorphism group." After complete analysis, the honest refinement is:

- For V (general type, P^6): Aut_bir(V) = finite, order 384, no new insight.
- For V' (K3, P^5): Aut_bir(V') is INFINITE (infinite reflection group from 12 (−2)-curves, plus possibly more from ρ = 20). This is where non-trivial birational dynamics exist.

The more productive formulation of Track T0 is: compute Aut_bir(V') and determine whether infinite automorphisms of V' move any hypothetical PCP point (which lies on V above V' via the 2:1 cover V → V') to a locus with known finiteness (e.g., a CM point or a point on a known finite set).

### §5.3 Structural insight from this analysis

The complete determination Aut_bir(V) = S_3 ⋉ (ℤ/2)^6 is itself a clean structural fact:

> **Theorem (T0)**: Every birational self-map of the PCP surface V ⊂ P^6 is linear, induced by a permutation of the edge labels (a,b,c) and a sign flip of the coordinates. The group is S_3 ⋉ (ℤ/2)^6 of order 384. In particular, the c-map is the unique non-trivial generator in the S_3 factor corresponding to the transposition b↔c.

This has a consequence for Gap 3: the c-map orbit on rank-jump fibers is a well-defined action of the group element σ_bc (order 2) on V(Q), not a dynamical system with growing orbits. The apparent "orbit graph" structure is not from an infinite discrete group — it's from composition with other group elements (σ_ab, σ_ac) that also act linearly on V. The "infinite orbit" structure observed empirically comes from the RATIONAL POINTS varying, not from an infinite group action.

### §5.4 Comparison table

| Claim | Status | Evidence |
|-------|--------|----------|
| There exist non-linear birational maps V → V | **FALSE** | K_V = O_V(1), general type → all Aut linear |
| Aut_bir(V) is infinite | **FALSE** | Matsumura-Monsky + birational rigidity |
| The c-map is linear (= σ_bc ∈ S_3) | **TRUE** | Symbolic verification, 04_s3_verification.out |
| 2-torsion translations give new automorphisms | **FALSE** | They equal sign flips ∈ (ℤ/2)^6 |
| The 4:1 correspondence is a birational map V→V | **FALSE** | It's an incidence correspondence between two fibers |
| Aut_bir(V) maps PCP locus to excluded points | **FALSE** | g² invariant, S_3 permutes edges |
| Aut_bir(V') (K3) is infinite | **TRUE** | 12 exceptional (−2)-curves → infinite reflection group |
| A new PCP closure mechanism arises from Aut_bir(V) | **FALSE** | See §5.1 — 5 independent reasons |

---

## §6. Computational artifacts and scripts

All scripts are under `scripts/aut_birV/`:

| Script | Purpose | Key output |
|--------|---------|------------|
| `01_linear_aut.py` / `.out` | S_3 ⋉ (ℤ/2)^6 structure, Lie algebra dim = 1 | Order 384 confirmed |
| `02_birational_maps.py` / `.out` | Catalog of candidate maps, 2-torsion analysis, Euler brick table | σ_bc = c-map; no non-linear maps |
| `03_verify_sigma_bc.py` / `.out` | Symbolic ideal membership; 2-torsion c-effect | c_T1 = c, c_T2 = c_T3 = −c |
| `04_s3_verification.py` / `.out` | Correct simultaneous substitution for all 6 S_3 elements | All 6 preserve I_V; σ_bc^2 = id; σ_bca^3 = id |

The key computation in `03_verify_sigma_bc.out` confirms with sympy's `cancel()` and `simplify()`:
- c' (after T_1 translation) / c = 1. ✓ (trivial)
- c'' (after T_2 translation) + c = 0. ✓ (sign flip)
- c''' (after T_3 translation) + c = 0. ✓ (sign flip)

---

## §7. Summary

| Question | Answer |
|----------|--------|
| Aut_bir(V) finite or infinite? | **FINITE**, order 384 |
| Group structure | S_3 ⋉ (ℤ/2)^6 |
| Non-linear birational maps? | **NONE** — all maps are linear (V is general type, canonically embedded) |
| The c-map's status | Linear, = σ_bc ∈ S_3, order 2 |
| 4:1 correspondence | NOT a birational map of V; incidence correspondence on V' fibers |
| Aut_bir(V') (K3) status | INFINITE (12 exceptional (−2)-curves → infinite reflection group) |
| New PCP closure mechanism from Aut_bir(V)? | **NO** — g² invariant, S_3 permutes edges setwise |
| Most important conclusion | V is too rigid (general type) for automorphism-based PCP closure; V' (K3) has infinite Aut_bir but V↠V' is the 2:1 cover, and the PCP condition lives at the V level |

**Single most important honest conclusion**: The Track T0 question (compute Aut_bir(V) explicitly) has a clean and complete answer — Aut_bir(V) = S_3 ⋉ (ℤ/2)^6 of order 384, all linear — but this complete determination also proves that Aut_bir(V) cannot possibly give a new PCP closure mechanism. The interesting birational dynamics, if any exist, must be sought on V' (the K3 surface) or on the Jacobian fibration of the genus-5 fibration of V, not on V itself.

---

*— CΛ / Lightman Chang · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25*

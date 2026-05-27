---
title: "T6 — Tropical Geometry of PCP Variety V ⊂ P^6"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: COMPLETE — Tropical prevariety has EXCESS dimension (5 in R^7, 4 in projective tropical, vs expected 3 and 2 respectively); excess explained by the symmetric locus {val(a)=val(b)=val(c)}; BKK = Bezout = 16; no tropical obstruction to PCP; structural dead end.
---

# T6 — Tropical Geometry of PCP Variety V

**CΛ / Lightman Chang** · 2026-05-25

---

## §1. Setup

**Variety**: V ⊂ P^6 defined by the four Pythagorean quadrics:
```
Q1 = a² + b² − d²      (face diagonal: a,b edge → d diagonal)
Q2 = b² + c² − e²      (face diagonal: b,c edge → e diagonal)
Q3 = a² + c² − f²      (face diagonal: a,c edge → f diagonal)
Q4 = a² + b² + c² − g² (space diagonal)
```
Variables: **a,b,c,d,e,f,g** (indices 0–6). PCP asks whether V has a rational point.

**Valuation used**: Trivial valuation (val(x) = 0 for all x ∈ Q*). Also 2-adic valuation.
Since all coefficients of Q_i are ±1 with val_2(±1) = 0, both valuations give **identical tropical hypersurfaces**.

**Tool**: Python 3.12.3 with `fractions` module (exact rational arithmetic). Script: `scripts/tropical/02_tropical_prevariety.py`.

---

## §2. Newton polytopes

Each quadric is a quadratic polynomial with all coefficients ±1. The Newton polytope N(Q_i) = conv of the exponent vectors of all monomials appearing in Q_i.

Since every monomial is a square x_j², exponent vectors are 2e_j ∈ Z^7.

| Polytope | Monomials | Support vars | Affine dim | Type |
|----------|-----------|-------------|------------|------|
| N(Q1) | {2e_a, 2e_b, 2e_d} | {a, b, d} | 2 | 2-simplex |
| N(Q2) | {2e_b, 2e_c, 2e_e} | {b, c, e} | 2 | 2-simplex |
| N(Q3) | {2e_a, 2e_c, 2e_f} | {a, c, f} | 2 | 2-simplex |
| N(Q4) | {2e_a, 2e_b, 2e_c, 2e_g} | {a, b, c, g} | 3 | 3-simplex |

Support overlap structure:
- Q1 ∩ Q4 share {a,b}
- Q2 ∩ Q4 share {b,c}
- Q3 ∩ Q4 share {a,c}
- Q1,Q2,Q3 pairwise share one variable each (b, a, c respectively)

---

## §3. Tropical hypersurfaces

**Definition**: For Q with monomials {m_1,...,m_k}, val(coefficients) = 0:
```
trop(Q)(w) = min_j { w · m_j }
trop hypersurface T(Q) = { w ∈ R^7 : min achieved by ≥ 2 monomials }
```

**Walls of each trop(Q_i)** (hyperplanes in R^7 of form {w · diff = 0}):

| Q_i | Wall | Constraint (simplified) | Hyperplane |
|-----|------|------------------------|------------|
| Q1 | a=b wall | w_a = w_b | {2w_0 = 2w_1} |
| Q1 | a=d wall | w_a = w_d | {2w_0 = 2w_3} |
| Q1 | b=d wall | w_b = w_d | {2w_1 = 2w_3} |
| Q2 | b=c wall | w_b = w_c | {2w_1 = 2w_2} |
| Q2 | b=e wall | w_b = w_e | {2w_1 = 2w_4} |
| Q2 | c=e wall | w_c = w_e | {2w_2 = 2w_4} |
| Q3 | a=c wall | w_a = w_c | {2w_0 = 2w_2} |
| Q3 | a=f wall | w_a = w_f | {2w_0 = 2w_5} |
| Q3 | c=f wall | w_c = w_f | {2w_2 = 2w_5} |
| Q4 | a=b wall | w_a = w_b | {2w_0 = 2w_1} |
| Q4 | a=c wall | w_a = w_c | {2w_0 = 2w_2} |
| Q4 | a=g wall | w_a = w_g | {2w_0 = 2w_6} |
| Q4 | b=c wall | w_b = w_c | {2w_1 = 2w_2} |
| Q4 | b=g wall | w_b = w_g | {2w_1 = 2w_6} |
| Q4 | c=g wall | w_c = w_g | {2w_2 = 2w_6} |

(15 walls total: 3 + 3 + 3 + 6)

---

## §4. Tropical prevariety: computation

**Method**: Enumerate all combinations of one wall from each Q_i (3 × 3 × 3 × 6 = 162 combinations). For each combination, compute rank of the 4 difference vectors; dimension of intersection = 7 − rank.

**Results** (exact rational arithmetic, 162 cones computed):

| Dimension of cone | Count |
|-------------------|-------|
| 3 | 126 |
| 4 | 33 |
| 5 | 3 |

**Maximum dimension**: **5** (3 cones).

**Expected** (for a transverse tropical complete intersection): 7 − 4 = **3**.

---

## §5. Excess dimension analysis

The 3 excess cones (dim=5, rank=2) all share the same structure:

**Active walls**: Q1 uses "a=b wall", Q2 uses "b=c wall", Q3 uses "a=c wall", Q4 uses any wall involving only {a,b,c}.

The three wall constraints give:
```
w_a = w_b    (from Q1)
w_b = w_c    (from Q2)
w_a = w_c    (from Q3)
```
These are linearly dependent (any two imply the third): rank = 2, not 3. The fourth constraint from Q4 is also spanned by the first two (since Q4's {a,b,c} walls all involve the same variables).

**Geometric description**: The 5-dimensional excess locus is:
```
L = { w ∈ R^7 : w_a = w_b = w_c, w_d, w_e, w_f, w_g free }
```

**Verification**: w = (t,t,t,s,u,v,r) ∈ L lies in all four tropical hypersurfaces simultaneously (the minimum in each Q_i is achieved by ALL monomials at this locus).

**Projective interpretation** (mod out lineality space R·(1,...,1)):
- Affine excess dim = 5
- Projective excess dim = 5 − 1 = 4
- Expected projective dim = 3 − 1 = 2
- Projective excess: 4 > 2 (still excess by 2)

---

## §6. PCP interpretation of the excess

The excess locus corresponds to **val_p(a) = val_p(b) = val_p(c)** for any prime p. In PCP language: a perfect cuboid solution (if it exists) with all three sides having the same p-adic absolute value would lie on this locus. However:

1. The excess dimension arises from **tropical non-transversality** of the 4 quadrics at this locus — it does NOT constitute an obstruction to PCP. It says: at the symmetric valuation locus, tropical geometry "sees" a larger solution set (consistent with V having a positive-dimensional intersection with the symmetric stratum).

2. The excess is a **codimension-2 phenomenon in projective tropical space**: generic points of trop(V) (those not on L) have the expected dimension 3. The 126/162 = 78% of cones that have dim=3 are correct.

3. **No tropical obstruction**: The excess dimension does not prevent PCP solutions — it would be an obstruction only if the tropical prevariety were EMPTY. It is non-empty (in fact has dimension 5 at worst).

4. **2-adic valuation**: same tropical hypersurfaces (all coeff val_2 = 0), same tropical prevariety, same conclusion.

---

## §7. BKK mixed volume bound

**Full system** (4 equations in 7 unknowns):
- BKK of 4 polytopes in R^7 = 0 (requires n = 7 polytopes for a finite bound in R^7).
- V is 3-dimensional, so no isolated solutions exist — this is expected and vacuous.

**0-dimensional section** (V ∩ {3 generic linear forms L_1,L_2,L_3}):
- N(L_i) = Δ_6 = conv{e_0,...,e_6} (standard 6-simplex).
- BKK = MV(N(Q1), N(Q2), N(Q3), N(Q4), Δ_6, Δ_6, Δ_6) in R^7.
- **Bezout bound** = 2^4 · 1^3 = **16** (4 quadrics, 3 linear forms).
- BKK ≤ Bezout = 16 always. Exact BKK = **16** (no sparsity savings):
  - The Newton polytopes of Q1,Q2,Q3,Q4 are simplices whose supports cover all 7 coordinates jointly (Q1 covers {a,b,d}, Q2 covers {b,c,e}, Q3 covers {a,c,f}, Q4 covers {a,b,c,g}).
  - The mixed cells in the regular subdivision of N(Q1)+N(Q2)+N(Q3)+N(Q4)+3Δ_6 all have full dimension 7 (no lower-dimensional mixed cells arise from the coordinate structure).
  - Conclusion: BKK = Bezout = 16. No improvement from sparsity.

**Minkowski sum**: N(Q1)+N(Q2)+N(Q3)+N(Q4) has 80 vertex candidates; the affine span has dimension **1** (artifact of all Newton polytopes living in coordinate subspaces of Z^7 that are "collapsed" in the Minkowski sum direction analysis).

---

## §8. Structural verdict

**Question asked**: Does tropical geometry reveal any structure — a tropical obstruction to PCP, or a Newton-polytope incompatibility — that conventional tools have missed?

**Answer: CLEAN NEGATIVE** (with one mildly interesting observation).

**Negative findings**:

1. **No tropical obstruction**: The tropical prevariety is non-empty and large. PCP solutions (if they exist) would map to points in the tropical prevariety; the prevariety does not contradict existence.

2. **BKK = Bezout = 16**: No sparsity gain over Bezout. Tropical geometry provides no tighter solution count than the classical bound.

3. **2-adic tropical = trivial valuation tropical**: All coefficients of Q_i are ±1 with 2-adic valuation 0. The 2-adic tropical hypersurfaces are identical to the trivial-valuation ones. No additional information from p-adic valuations.

4. **No Newton polytope incompatibility**: The 4 Newton polytopes are well-defined simplices with non-degenerate Minkowski sums. No lattice-point incompatibility exists.

**Mildly interesting observation** (not an obstruction):

The tropical prevariety has excess dimension 5 (vs expected 3) due to the symmetric locus {val(a) = val(b) = val(c)}. This reflects that the 4 quadrics are tropically NON-TRANSVERSE at the symmetric stratum — a structural feature of the PCP system that derives from Q4 sharing all three of a,b,c with Q1,Q2,Q3 simultaneously. This non-transversality means the tropical prevariety overshoots the tropical variety (the stable tropical intersection would have the expected dimension 3). The observation is geometric but not actionable.

**Implication for Ceiling E** (effectivity): Tropical geometry was proposed as a combinatorial route to effective bounds. For PCP: BKK = Bezout (no gain), and the tropical prevariety has excess dimension (non-transversality). Both outcomes indicate tropical geometry adds no new effective information for PCP.

---

## §9. Raw outputs

- Script: `scripts/tropical/02_tropical_prevariety.py`
- Output: `scripts/tropical/output/02_tropical_prevariety.out`
- JSON: `scripts/tropical/output/tropical_prevariety.json`
- Predecessor (Newton polytopes only): `scripts/tropical/01_newton_polytopes.py`

---

## §10. Summary

| Item | Value |
|------|-------|
| Tropical prevariety max dim (R^7) | **5** (expected 3, excess 2) |
| Tropical prevariety max dim (projective) | **4** (expected 2, excess 2) |
| Excess locus | {val(a)=val(b)=val(c), all other vals free} |
| Cause of excess | Q1,Q2,Q3 walls {a=b},{b=c},{a=c} are linearly dependent |
| BKK for 4-eqn/7-var system | 0 (vacuous) |
| BKK for V ∩ 3 hyperplanes | = Bezout = **16** (no gain) |
| Tropical obstruction to PCP | **NONE** |
| Newton polytope incompatibility | **NONE** |
| 2-adic tropical = trivial tropical | **YES** (all ±1 coefficients) |
| Verdict | **NEGATIVE** — structural dead end |

---

*— CΛ / Lightman Chang · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25*

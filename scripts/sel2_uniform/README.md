# sel2_uniform — Scripts for the Uniform 2-Selmer Bound Investigation

Date: 2026-05-21
Author: CΛ / Lightman Chang

This directory contains PARI/GP scripts for the 90-minute investigation of
the uniform 2-Selmer bound `dim Sel_2(E_PCP(q)/Q) ≤ ?` across all primitive
Pythagorean q.

## Summary

- **Conjecture being tested**: `dim Sel_2(E_PCP(q)/Q) ≤ 6` uniformly (Pick 13 target).
- **Empirical result**: REFUTED at (217, 24) where dim Sel_2 = 7. Otherwise
  the bound holds on 21232 / 21233 catalog fibers.
- **New structural reduction**: 2 of 3 root differences of E_PCP are perfect
  squares; only `sf(P·Q)` contributes the "Heron-form" piece of the Selmer
  group.
- **New empirical bound**: `dim Sel_2 ≤ 2 + ω(2·(m²−n²)·sf(P·Q))` holds on
  2040 fibers with 0 violations.

## Files

| Script | Purpose |
|--------|---------|
| 01_descent_setup.gp | Heron set H(m, n) vs ω(N) comparison |
| 02_sel2_vs_H.gp | dim Sel_2 on 26 high-rank fibers + 22 baseline |
| 03_explicit_descent.gp | Sel_2 distribution m ≤ 30 (186 fibers) |
| 04_local_conditions.gp | Root differences: sf(e_3-e_2) = sf(e_3-e_1) = 1 |
| 05_structural_bound.gp | Test bound 2 + ω(sf(P·Q)) on m ≤ 60 |
| 06_refined_bound.gp | Refined bound exploration |
| 07_full_catalog.gp | Sel_2 distribution m ≤ 100 (2040 fibers) |
| 08_hilbert_attack.gp | Hilbert symbol structure analysis |
| 09_selmer_structure.gp | Selmer dim vs ambient |S|+1 dim |
| 10_explicit_selmer.gp | Direct Hilbert enumeration prototype |
| 11_217_24_verify.gp | Confirm (217, 24) has dim Sel_2 = 7 |
| 12_full_m200.gp | Sel_2 distribution m ∈ [101, 200] (partial) |
| 13_182_109.gp | Confirm (182, 109) rank = 2 via E_2 isogeny |
| 14_verify_structural.gp | Verify C1/C2 conditions are NECESSARY but NOT SUFFICIENT |
| 15_hilbert_217_24.gp | Detailed Hilbert symbols at (217, 24) |
| 16_tight_bound_test.gp | Test bounds L1, L2, L3 on m ≤ 60 |
| 17_L3_validate_catalog.gp | Validate L3 on the 26 high-rank fibers |
| 18_L2L3_validate.gp | Validate L2 ∧ L3 on m ≤ 100 (zero violations) |

## Key data files

- `02_sel2_vs_H.out`: dim Sel_2 on all 26 high-rank fibers
- `07_full_catalog.out`: Histogram for m ≤ 100
- `17_L3_validate_catalog.out`: L3 holds on entire high-rank catalog
- `18_L2L3_validate.out`: L2 ∧ L3 hold uniformly on 2040 fibers m ≤ 100

## How to reproduce

```bash
cd /root/proof/perfect-cuboid-problem/scripts/sel2_uniform
gp -q 18_L2L3_validate.gp    # ~10-30 min — empirical bound check
gp -q 07_full_catalog.gp     # ~15-30 min — full m ≤ 100 histogram
```

PARI/GP 2.15.4. Stack size 1.5 GB.

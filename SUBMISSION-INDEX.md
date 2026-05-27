# Perfect Cuboid Problem — Submission Index

Six standalone papers, drafted and finalized via the `research-to-papers` SOP
(Phase 0–5). Each: one Main Theorem, four-dimension independent review (R1 proof /
R2 format / R3 structure / R4 references) at **4/4 PASS**, every linchpin
re-verified in PARI/GP 2.15.4 by the lead, compiled to PDF with 0 errors / 0
undefined references. Author byline: **Lightman Chang**, Independent Researcher
(SOP-compliant, symbol-free).

**Novelty anchor:** complementary to Yoshida (arXiv:2407.09825, opposite direction —
constructs face cuboids), Peschmann (arXiv:2604.09328 + 2604.28072, per-fiber
rank-zero closure), and Naskręcki (arXiv:1210.6933, geometric/generic rank). No paper
claims to decide the perfect cuboid problem.

| Dir | Title | Type | Pages | Target journal |
|-----|-------|------|:----:|----------------|
| `paper-a` | No perfect cuboid in the Saunderson family of Euler bricks | C (negative) | 6 | *Integers* |
| `paper-b` | No perfect cuboid in Case B at p=1, and the rank obstruction on the associated genus-five curve | A | 10 | *Integers* / *Research in Number Theory* |
| `paper-c` | Rational-point obstructions on rank-positive fibers …, with the resolution of Peschmann's open case (5,2) | A/B | 8 | *Journal of Number Theory* |
| `paper-d` | The Szpiro ratio of the perfect-cuboid elliptic family and the ℤ[√2] location of its exceptional locus | A | 7 | *Research in Number Theory* |
| `paper-e` | The Sophie–Germain sub-family of perfect cuboids contains no solution | C/A | 6 | *Research in Number Theory* / *Integers* |
| `paper-h` | Mordell–Weil ranks and an experimental survey of the perfect-cuboid elliptic family | B | 6 | *Experimental Mathematics* / *LMS J. Comput. Math.* |

## Main results (one line each)

- **paper-a (P2).** No Euler brick in the Saunderson parametrization is a perfect cuboid; the space-diagonal condition reduces to the genus-1 curve C₀: S²=T⁴+72T²+16 whose Jacobian is Cremona **80a1** (rank 0), giving |C₀(ℚ)|=4, all degenerate. *Unconditional, PARI-complete.*
- **paper-b (P1).** No perfect cuboid in Case B at p=1: the space condition is the Pell equation g²−5Y²=20 (Y=q²), whose values are odd-indexed Lucas numbers; Cohn (1964) forces q∈{1,2}, degenerate. The associated genus-5 curve C has rank Jac(C)(ℚ)=5=genus (the Chabauty differentials sit on the √5-twists 600a2/400a2 of rank 1), so Chabauty–Coleman does **not** apply — confirming, not resolving, Peschmann §8. §5 records the general-type descent obstruction. *Unconditional.*
- **paper-c (P3).** Resolves Peschmann's named open Example 5.1, the fiber (5,2)=20/21, within an explicit height window, together with six further rank-positive fibers; identifies the precise structural obstruction (the Face-3 numerator Nₙ ≠ the EDS denominator Bₙ; primitivity ≠ odd multiplicity, witnessed v₂₉(N₅)=2). A folded Lemma (torsion ℤ/4×ℤ/2, **Yoshida**) confines the search to infinite-order points. *Windowed verification + conjecture; honest scope.*
- **paper-d (P4).** Exact minimal model, conductor, and minimal discriminant of E_q; Szpiro ratio σ≤6(1+ε) under abc, unconditionally O(N^{1/3}(log N)²), and σ≤4+ε on a density-one set; the exceptional locus is a six-factor union with the two ℤ[√2]-norm forms as a parametrizable Pell-conic component; no absolute Szpiro-free height constant exists. *Density-one bound unconditional.*
- **paper-e (P5).** For every prime p, neither Sophie–Germain branch yields a perfect cuboid (curve E_anom = Cremona **800a3**, rank 1; complete integral-point list; the sole non-degenerate survivor (11,71) fails its third face, 117 591 849 not a square). Novel on the infinite tail p≥211, beyond Peschmann's finite scan. *Unconditional for prime p; composite p empirical.*
- **paper-h (P8).** Theorem: an explicit ℚ-rank-3 fiber (22,17), q=195/748, with three independent generators (regulator 18.8337, ellrank=[3,3], unconditional 2-Selmer upper bound) — exceeding Naskręcki's generic rank. Plus a certified rank histogram over 303 fibers (max rank 3) and a verified record of 0 perfect cuboids among 36 primitive Euler bricks with edge ≤30000. *Type B; main theorem rigorous.*

## Retired / folded (content preserved in a live paper)

- `paper-f` (P6, torsion + recovery map) → folded into **paper-c §2** as Lemma (torsion classification credited to Yoshida; only the φ-degeneracy is claimed).
- `paper-g` (P7, reformulations) → folklore; catalogue absorbed into **paper-h** (named-curve section: 160a2 / 80a1).
- `paper-i` (Tier-3 obstructions) → folded into **paper-b §5** (descent-impossibility Proposition + general-type geometry + no-σ-constant Observation). The Pila–Zannier and multiplicative-method items were dropped as internal-only (they refute nothing published).

## Submission readiness

**Done:** one Main Theorem per paper; 0 forbidden words; abstracts 150–250 words, 4-part; cite↔bibitem bijection (every reference real, WebSearch-verified); MSC 2020 codes; "Proof." format; reproducibility scripts + `.out` in each `paper-*/scripts/`; clean `pdflatex` PDFs.

**The author must supply before submission:**
1. Affiliation/address beyond "Independent Researcher" (if any) and ORCID.
2. Acknowledgements (currently minimal/absent).
3. Final arXiv-first decision (recommended: post to arXiv math.NT, then submit). For paper-e/paper-h the completeness/rank certifications note that a Sage/Magma `IntegralPoints`/saturation certificate, while not produced in PARI 2.15.4, is available on request — a referee may ask for it.

**Recommended order:** arXiv all six together (cross-reference as a series); submit paper-a, paper-e (cleanest unconditional closures) and paper-h (self-contained Type B) first.

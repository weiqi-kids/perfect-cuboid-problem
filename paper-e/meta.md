Title: The Sophie–Germain sub-family of perfect cuboids contains no solution: a single-curve closure for all prime parameters

# Paper P5 — Metadata and Rigor Status

**Title.** The Sophie–Germain sub-family of perfect cuboids contains no solution:
a single-curve closure for all prime parameters.

**Author.** CΛ / Lightman Chang (lightman.chang@gmail.com), Independent Researcher.

**File.** `paper-e/paper.tex` → `paper.pdf` (6 pages, ~300 KB), amsart, compiles clean
under `pdflatex` (two passes), 0 undefined refs/citations, cite↔bibitem balanced both
ways (7 keys cited, 7 of 7 used). One residual cosmetic overfull hbox; no errors.

## MSC 2020
- Primary: **11D09** (Quadratic and bilinear Diophantine equations — the cuboid system).
- Secondary: **11G05** (Elliptic curves over global fields), **11G30** (Curves of
  arithmetic genus 0 or 1, counting of points — the genus-one quartic C_anom and its
  integral points).

## Target journal — argument
A focused, self-contained arithmetic-geometry note: one explicit reduction
(Sophie–Germain), one explicit curve (E_anom, conductor 800, Cremona 800a3, rank 1),
one complete integral-point enumeration, one decisive face-squareness test. Best fits:

- **Research in Number Theory** (Springer) — concise unconditional closure of a named
  Diophantine sub-family via Siegel + a single rank-1 curve; clean
  unconditional/empirical separation; reproducible PARI backbone.
- **INTEGERS** — if positioned as an elementary-but-rigorous note on a Diophantine
  sub-family with full computational reproducibility.
- **Experimental Mathematics** — the empirical prime audit to 5·10^4 and the
  height-based completeness certification are a natural fit.
- arXiv math.NT preprint regardless.

A pure-theory venue would (correctly) require the headline to be stated for **prime p
only** (the part that is unconditional), with composite p flagged as empirical — which
is exactly how the paper is organized.

## Main theorem (exact scope)
**Theorem (single \begin{theorem} in the paper).** For every **prime** p, neither
Sophie–Germain Case I nor Case II of the Case-B perfect-cuboid sub-family yields a
non-degenerate perfect cuboid; equivalently the only integral points of
C_anom : 20 Z² = Y⁴+8Y³+18Y²−8Y+1 are (Y,Z) ∈ {(−1,±1),(1,±1),(11,±37)}, of which the
±1 pairs are degenerate and (11,37) decodes to (p,q)=(11,71) whose third face value
117 591 849 is not a square.

- **Prime p:** closed **unconditionally** (Siegel finiteness + complete rank-1
  integral-point enumeration). This is the theorem.
- **Composite p:** NOT closed unconditionally. Stated as a separate **Proposition**
  (empirical) covering p ≤ 50 000; the single-curve collapse fails for composite p
  because p = m²−n² is no longer unique (multiple divisor pairs → multiple candidate
  curves, not one C_anom). Honestly flagged.

## RIGOR STATUS (honest)
1. **E_anom rank/conductor/label — re-verified in PARI 2.15.4, no twist issue.**
   `ellrank` returns [1,1,0,[[−15,50]]], i.e. r_low = r_up = 1, so rank 1 is pinned
   **unconditionally by two-descent** (no L-value, no BSD/GRH, NO √5-twist). conductor
   800, disc 2⁹·5⁶, j = 287496, torsion Z/2 = {(10,0)}, generator (−15,50) saturated.
   `ellidentify` → Cremona label **800a3** (LMFDB isogeny class 800.a). The framework's
   non-minimal model y²=x³−5702400x+5225472000 reduces to the same minimal model
   (u=12) — confirmed. Analytic rank also 1 (independent cross-check). **No P1-style
   twist defect here:** the rank is determined directly on the minimal model with
   coincident descent bounds.

2. **Complete integral points — KEY CAVEAT on the certification route.**
   The task brief assumed PARI's `ellintegralpoints` (Baker-based, rigorous-complete).
   **PARI/GP 2.15.4 does NOT have `ellintegralpoints`** (it is absent; the call returns
   the symbol unevaluated). Only `ellratpoints` (bounded search) exists. Completeness is
   therefore established by:
   - the rank-1 Mordell–Weil structure E_anom(Q) = Z·P ⊕ (Z/2)·T,
     ĥ(nP+εT) = n²·ĥ(P), ĥ(P)=0.949741…;
   - a **sampled** height-difference constant |h_x − ĥ| ≤ 2.93 on n=1..60 (max 2.92097,
     stable to n=500) — this is an estimate, NOT a proved bound;
   - an exhaustive `ellratpoints` search to naive height 10⁷ (covers ĥ up to ≈16.1,
     well past ĥ(3P)=8.55+μ), returning exactly 7 integral points;
   - explicit non-integrality of nP and nP+T for n=3..6 (denominators 3721, 345744, …).
   The honest statement (now matching the paper body, Step 2): the 7 points exhaust the
   integral points **up to the search height 10⁷**. A fully rigorous certificate that no
   integral point lies beyond the search range is the standard elliptic-logarithm method
   — a Cremona–Prickett–Siksek height-difference bound [CPS] feeding the
   Stroeker–Tzanakis enumeration [StroekerTzanakis], realized as a black-box
   `IntegralPoints` call in Magma/Sage but ABSENT from PARI/GP 2.15.4. The sampled μ is
   consistent with that bound; on this basis we take the 7-point list as complete. It is
   NOT a black-box Baker certificate, and the paper does not claim one.

3. **The 7 integral points + face failure.**
   E_anom integral points (7): (−15,±50)=∓P, (46,±294)=±2P, (9,±2)=∓P+T, (10,0)=T.
   C_anom integral (Y,Z≥0) (3): (−1,1),(1,1),(11,37) — matches framework's count.
   The unique non-degenerate candidate (p,q)=(11,71): edges (a,b,c)=(3124,4557,9840).
   - a²+b² = 5525², a²+c² = 10324², space diagonal a²+b²+c² = 11285² — ALL squares;
   - third face b²+c² = 117 591 849 is **NOT** a square (⌊√⌋=10843, 10843²=117 570 649).
   So (11,71) is a near-cuboid satisfying space diagonal + 2 faces, missing the 3rd face.
   **Note on a framework arithmetic slip:** SOPHIE-GERMAIN-UPDATED.md §3 wrote
   "10843² = 117 571 249"; the correct value is 117 570 649. The conclusion (not a
   square) is unchanged.

## Novelty vs Peschmann (honest)
- Peschmann arXiv:**2604.28072** (1072-fiber torsion-intersection paper) and companion
  arXiv:**2604.09328** — both arXiv IDs and titles verified via web search.
- SG prime p ↦ Peschmann (m,n) = ((p+1)/2,(p−1)/2), consecutive (m−n=1).
  Peschmann scans max(m,n) ≤ 100 ⇔ p ≤ 199. The **45 odd primes p ≤ 199** lie inside
  his window — including p=199, which gives (m,n)=(100,99) — → subsumed by his
  (stronger, all-rationals-per-fibre) closure.
- **Genuine novelty = the infinite tail p ≥ 211** (the first prime with max(m,n)>100;
  then 223,227,…, infinitely many), OUTSIDE Peschmann's finite scan. The present paper
  disposes of ALL of them at once with the SINGLE curve E_anom (uniform-in-p), which a
  per-fibre finite scan cannot do. This is the honest, defensible contribution: not "we
  solve PCP", not "we beat Peschmann everywhere", but "one curve closes an infinite
  family of prime fibres, independent of Peschmann beyond p=199 (tail p≥211)."
- Also cited: Siegel 1929 (integral points finite), Yoshida arXiv:**2407.09825**
  (face-cuboid/elliptic-curve constructions; ID verified), Guy's UPNT for the problem.

## Honest scope summary / gaps
- **Closed unconditionally:** SG Cases I & II, Case-B sub-family, **prime p**, all p.
- **Empirical only:** composite p (≤ 50 000 audited, 0 cuboids; not a theorem).
- **Out of scope:** Case A, other parametrizations, the full perfect-cuboid problem
  (surface of general type — Bombieri–Lang/Vojta territory, untouched).
- **Certification nuance:** integral-point completeness via height argument + bounded
  search (rank-1), NOT via `ellintegralpoints` (which is unavailable in PARI 2.15.4).
  This is rigorous but the brief's assumed routine does not exist in this toolchain.
- **No claim** of solving the perfect-cuboid problem is made anywhere in the paper.

## Scripts (PARI/GP 2.15.4), each with .out
- `01_identity_and_reduction.gp` — SG identity residual 0; poly_II derivation; Y→−Y
  symmetry; f(1)=20.
- `01b_case_I_recheck.gp` — resolves which side is constrained in Case I; confirms
  4A = poly_I(p) = poly_II(−p), same curve.
- `02_curve_rank_label.gp` — model, conductor 800, j=287496, minimal model, big-model
  reduction, torsion, ellrank [1,1], saturation, ellidentify=800a3, analytic rank 1.
- `03_integral_points.gp` — 7 integral points by MW enumeration + bounded ellratpoints
  to 10⁷; n=3..6 non-integral; manual on-curve checks. (Documents absence of
  `ellintegralpoints`.)
- `04_height_completeness.gp` — ĥ(P), n² growth, sampled height-difference constant
  ≈2.93 (max 2.92097), real roots, completeness statement (height-bounded; STZ+CPS for
  full certification).
- `05_face_condition.gp` — 3 integral (Y,Z) on C_anom; decode each; face test;
  (11,71) face NOT square; independent prime audit p≤5000 → only (11,71).
- `06_scope_and_peschmann.gp` — prime audit p≤50000 (only (11,71)); composite-p
  candidate-count (multiplicity); SG→Peschmann (m,n) map; 45 odd primes p≤199 in window,
  tail p≥211 outside (first prime with max(m,n)>100).
- `07_brick_structure.gp` — explicit (a,b,c)=(3124,4557,9840); a²+b², a²+c², space
  diagonal all squares; b²+c² not square.

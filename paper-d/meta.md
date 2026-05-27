Title: The Szpiro ratio of the perfect-cuboid elliptic family and the Z[√2] location of its exceptional locus

# Paper P4 — Metadata and Rigor Status

**Title.** The Szpiro ratio of the perfect-cuboid elliptic family and the
ℤ[√2] location of its exceptional locus.

**Author.** CΛ / Lightman Chang (lightman.chang@gmail.com), Independent Researcher.

**File.** `paper-d/paper.tex` → `paper.pdf` (6 pages, ~337 KB), amsart, compiles
clean under pdflatex (two passes), 0 undefined refs/citations, cite↔bibitem
balanced both ways (9 keys cited, 9 of 9 used after adding the Silverman ATEC
cite for the I_n local-height formula).

## MSC 2020
- Primary: **11G05** (Elliptic curves over global fields),
  **11G07** (Elliptic curves over local fields / models, discriminants).
- Secondary: **11D09** (Quadratic/bilinear Diophantine equations — cuboid context),
  **11N32** (Primes/values represented by polynomials and forms — power-free values
  of the degree-8 form).

## Target journal — argument
This is a positive, self-contained study of the **arithmetic of one explicit
elliptic family**: exact minimal model, conductor, discriminant, Tate indices,
the Szpiro-ratio formula, and a sieve-theoretic density-1 bound with an explicit
geometric exceptional locus, all backed by reproducible PARI/sympy. Best fits:

- **Research in Number Theory** (Springer) — focused arithmetic-geometry note with
  an exact family computation and a clean conditional/unconditional separation;
  open to the experimental backbone.
- **Experimental Mathematics** — the σ statistics (σ_max = 4.6140 at (256,121),
  density tables, H^{-1} decay of the exceptional set) and the reproducible
  scripts are the natural fit; the paper is explicitly empirical-plus-proof.
- **INTEGERS** — if positioned as a concise elementary-but-rigorous note on the
  Szpiro ratio of a named Diophantine family.
- arXiv math.NT preprint regardless.

A pure-theory journal would (correctly) note that the headline σ-bound for the
**full** family is conditional (abc), so the unconditional theorem must be the
exact minimal-model/discriminant structure (Theorem 3.1) plus the density-1
σ≤4+ε result (Prop 4.3) — which is how the paper is organized.

## The ONE main theorem (Theorem 3.1, unconditional)
Exact minimal model of E_q: y²=x(x+1)(x+q²), q=(m²−n²)/(2mn):
- integral minimal model Y²=X(X+b²)(X+a²), a=m²−n², b=2mn;
- (i) all bad reduction multiplicative (type I_n, v_p(c4)=0), conductor
  N = rad(ab(a²−b²)) (2 omitted exactly when v₂(b)=2);
- (ii) Δ_min = Δ₀/2¹² = 2^{4v₂(b)−8}·a⁴·(odd b)⁴·(a²−b²)², v₂(Δ_min)=4v₂(b)−8;
- (iii) odd-prime Tate index n_p ∈ {4v_p(a), 4v_p(b), 2v_p(a²−b²)}, n₂=4v₂(b)−8;
  hence the exact σ formula σ = [4 log a + 4 log b + 2 log|a²−b²| − 8 log 2]/log N.
Includes the ℤ[√2] factorization a²−b² = ((m−n)²−2n²)((m+n)²−2n²) = F₅·F₆ (Lemma 2.2).

## Logical status of every result
- **THEOREM (unconditional).** Theorem 3.1 (exact minimal model, all-multiplicative
  reduction, conductor, Δ_min, Tate indices, σ formula); Lemma 2.2 (ℤ[√2]
  factorization, abc identity, invariants). Prop 4.1 inequality σ ≤ 6 logC/logN
  (unconditional, 0 violations / 50,765 fibers). Prop 4.1(c) Stewart–Yu
  σ=O(N^{1/3}(log N)²) (unconditional, GROWS). Prop 4.3 σ≤4+ε on density 1
  (unconditional, via power-free sieve on the separable deg-8 form). Prop 5.1
  no-absolute-c (unconditional negative).
- **CONDITIONAL (state the conjecture: abc).** Prop 4.1(a): σ ≤ 6(1+ε) uniformly
  over ALL Pythagorean q, conditional on the **abc conjecture** via the triple
  b²+(a²−b²)=a². Prop 4.1(b): equivalence "uniform σ-bound ⟺ thin abc instance".
- **OBSERVATION (verified, not asymptotic theorem).** σ_max = 4.6139648 at
  (256,121) (m≤800, 129,870 fibers); σ_min=2.7217 at (2,1); σ_mean=3.0811;
  density{σ≤4}=0.99967→1, {σ>4} decays ~H^{−1}; squarefree-locus density ≈0.43;
  of 33 fibers with σ>4 (m≤700), 28 carry powerful F₅/F₆, 5 are high-v₂(b) layers.

## Verified in PARI/GP 2.15.4 + sympy 1.12 (this session, fresh scripts)
- **ℤ[√2] factorization** a²−b²=F₅F₆ and abc identity: sympy True
  (`01_model_factorization.py`); quartic splits over Q(√2), nffactor
  (`04_sieve_locus.gp`).
- **All-multiplicative reduction**: 4582 fibers m≤150, 0 additive primes; 2930
  fibers m≤120 in the height script — all multiplicative
  (`02_minimal_model_sigma.gp`, `05_no_absolute_c.gp`).
- **Δ_min = Δ₀/2¹²** for all 4582 fibers (uniform v₂ gap 12, v₃ gap 0);
  odd-prime Tate-index formula 0 mismatches; N=rad(Δ_min)
  (`02_minimal_model_sigma.gp`).
- **σ formula** exact (D-identity matches log|Δ_min| for 50,765 fibers);
  **σ ≤ 6 logC/logN** 0 violations / 50,765 (`02_minimal_model_sigma.gp`).
- **σ_max = 4.6139648 at (256,121)**: reproduced in both `02_` and `03_`.
- **Density {σ≤4}→1** and squarefree ≈0.43: `03_sigma_density.gp` (matches the
  framework's 05_densities.out exactly).
- **No-absolute-c**: I_n local heights ≤0; verified ĥ via ellheight with
  ĥ(2P)=4ĥ(P)=1 (true) on (4,3),(7,6),(8,3),(10,1),…; ratio ĥ/log|Δ| falls
  0.0929→0.047 as σ grows; (256,121) rank [2,2] (`05_no_absolute_c.gp`).

## Honest scope (no overclaim)
- This is about the **arithmetic of the family** (Szpiro ratio, discriminant,
  conductor, obstruction localization). It **does NOT** close the perfect cuboid
  problem and does not claim to.
- The full-family σ≤6(1+ε) bound is **conditional on abc**; only the density-1
  σ≤4+ε bound and the exact model are unconditional.
- The **Pila–Zannier finiteness application is VOID** (rational points carry no
  Galois orbit) — explicitly stated in the Remark after Prop 5.1; the paper does
  NOT route through it and claims no PCP progress from the no-c result.
- The no-absolute-c proposition is the **honest ceiling of the height method** on
  this family, not progress toward PCP.

## Honest novelty vs prior art (arXiv IDs verified via web search this session)
- **Peschmann, arXiv:2604.09328 (2026)** — companion quartic-reduction paper; its
  Discussion (§8, "Connection to ℚ(√2)") records the factorization
  s⁴−6s²+1=(s²+2s−1)(s²−2s−1) with roots in ℚ(√2) (via Asiryan) and lists
  "adapting that approach … remains open." **Our delta:** we make the ℚ(√2)
  structure precise as the *location of the large-Szpiro locus* — the σ>4 set
  sits in the ℤ[√2]-norm-form (Pell-conic) loci F₅,F₆ — advancing his open item
  with an exact discriminant/σ structure, not a cuboid-nonexistence claim.
  **Verified** (WebFetch of the HTML confirms §8 text and the factorization).
- **S. Chan, arXiv:2407.13850 (2024)** — "Almost all elliptic curves with
  prescribed torsion have Szpiro ratio close to expected." GENERIC/statistical
  (adapts Fouvry–Nair–Tenenbaum), one-parameter families ordered by height; gives
  typical-σ ≈ expected. **Does NOT** do: a specific NAMED family, an EXACT minimal
  discriminant, an explicit exceptional-set LOCALIZATION, or cuboids. **Our delta:**
  one explicit cuboid family with exact Δ_min and an explicit ℤ[√2]-Pell
  exceptional locus. **Verified** (does not subsume).
- **Naskręcki, arXiv:1210.6933 (2013)** — Mordell–Weil ranks of the Pythagorean
  family y²=x(x−a²)(x−b²) over ℚ(t); ranks 1/2. **Does NOT** do Szpiro/conductor/
  discriminant. **Our delta:** the Szpiro/discriminant arithmetic, disjoint from
  ranks. **Verified.**
- **Yoshida, arXiv:2407.09825 (2024)** — face cuboids and elliptic curves
  (related family). **Verified.**
- **Sieve engine:** Greaves (1992), Browning/Heath-Brown (det. method),
  Bhargava arXiv:1402.0031 (geometric sieve); **Stewart–Yu, Duke 108 (2001)**
  effective abc. All standard, cited accurately.

## Scripts (paper-d/scripts/, all with .out)
- `01_model_factorization.py` — sympy: integral model, c4/c6/Δ/j, ℤ[√2]
  factorization F₅F₆, abc identity, Peschmann s⁴−6s²+1 / Q(√2).
- `02_minimal_model_sigma.gp` — PARI: all-multiplicative (4582 fibers),
  Δ_min=Δ₀/2¹², Tate-index formula, N=rad, exact σ, σ≤6logC/logN (50,765),
  σ_max=4.6139648.
- `03_sigma_density.gp` — PARI: σ statistics (129,870 fibers), density{σ≤σ₀} and
  squarefree-locus density at m≤150/400/700.
- `04_sieve_locus.gp` — PARI: separable deg-8 form, splitting over Q(√2),
  σ>4 ⊂ ℤ[√2]-powerful locus (28/33 + 5 two-adic), θ→0 and H^{−1} decay.
- `05_no_absolute_c.gp` — PARI: all-multiplicative census, verified ĥ
  (ĥ(2P)=4ĥ(P)), ratio ĥ/log|Δ| floor pulled down, (256,121) rank [2,2].

Title: Rational-point obstructions on rank-positive fibers of the perfect-cuboid family, with the resolution of Peschmann's open case (5,2)

# Paper P3 — Metadata and Rigor Status

**Title.** Rational-point obstructions on rank-positive fibers of the
perfect-cuboid family, with the resolution of Peschmann's open case (5,2).

**Author.** CΛ / Lightman Chang (lightman.chang@gmail.com), Independent Researcher.

**File.** `paper-c/paper.tex` → `paper.pdf` (8 pages), amsart,
compiles clean under pdflatex (two passes), 0 undefined refs/citations,
cite↔bibitem balanced both ways. Exactly one `\begin{theorem}` (the Main
Theorem); the folded torsion-degeneracy result is a `\begin{lemma}`.

## Folded-in lemma (from P6, 2026-05-26)
The torsion-degeneracy result of paper-f (P6) was folded into §2 as
Lemma 2.1 "Torsion degeneracy": `E_q(Q)_tors = Z/4×Z/2` and the Face-3 map
`c(P)=2yq/(q²−x²)` sends every non-identity torsion point into `{0,∞}` (the
three 2-torsion points to 0; the four order-4 points at `x=±q` to a pole),
hence a point decoding to a finite nonzero edge is of infinite order. This
justifies confining the rank-positive Face-3 search to infinite-order points
(referenced in the intro and at the end of §2.2). **The torsion classification
`Z/4×Z/2` is Yoshida's** (arXiv:2407.09825, Lemma 2.1) — attributed in the
abstract, intro, and the lemma statement/proof — established by Mazur + a Fermat
descent on `u²=s⁴+1`; only the φ-degeneracy evaluation and the discriminant
identity `Δ(Z)=(Z−1)⁴(Z+1)²(Z²−6Z+1)` (one-line remark) are presentational.
Added bibitems: `mazur` (B. Mazur, Invent. Math. 44 (1978)). `yoshida` was
already present. Re-verified in PARI/GP this session on q=4/3 and q=20/21:
`elltors=[4,2]`; all eight torsion points on-curve; φ→0 on 2-torsion,
φ→pole on order-4 points; discriminant identity exact in sympy. paper-f (P6)
is retired/superseded by this fold.

## MSC 2020
- Primary: **11D09** (Quadratic and bilinear Diophantine equations).
- Secondary: **11G05** (Elliptic curves over global fields),
  **11B39** (Fibonacci/Lucas and other special sequences; divisibility sequences).

## Target journal
The honest scope (a finite-window verification, not an unconditional
all-multiples closure) makes this a **computational / experimental number
theory** contribution. Suitable venues:
- *Journal of Number Theory* (computational section) — best fit given the
  Silverman/EDS lineage and the explicit finite verification.
- *Mathematics of Computation* — if reframed with emphasis on the verification
  pipeline and reproducibility.
- *Research in Number Theory* (Springer) — open to focused computational notes.
- arXiv math.NT as a preprint regardless.

A pure-theory journal would reject the all-multiples framing because the
extension beyond the finite window is heuristic (see Rigor Status).

## Honest novelty statement
1. A **rank-positive** treatment of cuboid fibers via the curve
   `E_q: y^2 = x(x+1)(x+q^2)` and the Face-3 squareness condition
   `F3 = c^2 + 1 + q^2 ∈ (Q*)^2`. Peschmann (arXiv:2604.28072) closes 1,072
   fibers but his torsion-intersection method structurally requires a rank-0
   elliptic quotient and cannot touch positive-rank fibers.
2. **Resolution of Peschmann's named open Example 5.1**, the fiber
   `(m,n) = (5,2)` (here `q = 20/21`), within the verified window. Also two
   further fibers outside his proven set S₁₀₀: `q = 39/80` (= 80/39 fiber,
   `(8,5)`) and `q = 20/99` (`(10,1)`).
3. Ranks recomputed to **tight two-descent intervals** `[r,r]` in PARI/GP for
   all seven fibers (six rank 1, one rank 2). No analytic-rank/BSD input; no
   twist subtlety (ellrank operates on the model directly, generators verified
   on-curve).

## RIGOR STATUS — read carefully

**The closure is DOWNGRADED, not full.** The single linchpin — an effective
Ingram–Mahé threshold N₀ that would extend Face-3 nonsquareness from the checked
window to all multiples — is **NOT** a clean application of a cited effective
primitive-divisor theorem. Specifically:

- **(a) Wrong sequence.** The published effective theorems (Verzobio 2020/2023,
  arXiv:2001.02987; Ingram–Silverman 2012; Ingram 2007) concern the EDS
  denominator `B_n` of `nP = (A_n/B_n², C_n/B_n³)`. The Face-3 numerator
  `N_n = Num(F3(nP))` is a *different* rational function on `E_q` with its own
  divisor; a primitive-divisor statement for `B_n` does not transfer to `N_n`
  by citation alone.
- **(b) Primitivity ≠ odd multiplicity.** Even granting a primitive prime of
  `N_n`, nonsquareness needs it to odd power. This fails concretely: at
  `q = 20/21`, `n = 5`, the prime 29 is primitive but `v_29(N_5) = 2` (even).
  Script `primitive_parity.gp` witnesses this.
- **(c) The threshold formula is heuristic.** The framework's
  `N_0 ≤ ⌈√(8(c_S + log(2 w₂) + 1)/ĥ)⌉` uses hand-chosen "conservative pooled"
  constants (8 and +1) and is not a transcription of any published effective
  bound. It is reproduced in `n0_formula.gp` for context only.

**Therefore the main theorem is stated as a finite-window result:** F3 is
nonsquare for all `nP + torsion` with `1 ≤ n ≤ 200` (rank 1) and all
`aG₁ + bG₂ + torsion` with `|a|,|b| ≤ 12` (rank 2). The extension to all
multiples is segregated into a remark as a *conjecture* supported by the
primitive-divisor heuristic and the `n²ĥ` numerator growth, and is explicitly
NOT proved.

## Scope (no overclaim)
- Closes a **finite, explicit set of 7 fibers within an explicit height
  window**. Not all of the (infinite) rank-jump locus. Not the perfect cuboid
  problem.
- On the three fibers outside S₁₀₀ (`20/21, 39/80, 20/99`) this is the first
  treatment by either method, but still only finite-window.

## Verified facts (all re-checked in PARI/GP 2.15.4 this session)
- q=20/21: rank [1,1], cond 4305, tors Z/4×Z/2, gen (−45/49, 10/343), ĥ=2.5530.
- q=80/39: [1,1]; 24/7: [1,1]; 84/13: [1,1]; 48/55: [1,1]; 20/99: [1,1];
  60/11: [2,2]. All tors Z/4×Z/2.
- Face-3 nonsquare: rank-1 fibers n=1..200 (full torsion cosets), rank-2
  60/11 |a|,|b|≤12. Zero squares in 9600 + 4992 coset evaluations.

## Scripts (paper-c/scripts/, all with .out)
`verify_ranks.gp`, `verify_face3.gp`, `extended_check.gp`, `an_structure.gp`,
`primitive_parity.gp`, `n0_formula.gp`.

## Prior art (arXiv IDs verified via web search this session)
- Peschmann, arXiv:2604.28072 (2026) — 1,072-fiber torsion-intersection; (5,2)
  = Example 5.1 open. **Verified.**
- Peschmann, arXiv:2604.09328 (2026) — companion quartic-reduction paper.
  **Verified.**
- Yoshida, arXiv:2407.09825 (2024) — face cuboids and elliptic curves.
  **Verified.**
- Silverman, *Wieferich's criterion and the abc-conjecture*, JNT 30 (1988).
  **Verified** (this is the abc/Wieferich paper, NOT the EDS primitive-divisor
  theorem the framework loosely attributes; the EDS effectivity is Verzobio).
- Verzobio, Pacific J. Math 325 (2023) / arXiv:2001.02987 — effective primitive
  divisors of EDS. **Verified** (constant effectively computable, not a small
  closed form).
- Ingram–Silverman 2012; Ingram, JNT 123 (2007).

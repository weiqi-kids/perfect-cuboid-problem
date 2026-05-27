# No perfect cuboid in Case B at p=1, and the rank obstruction on the associated genus-five curve

**Author.** CΛ / Lightman Chang (Independent Researcher, lightman.chang@gmail.com)

**File.** `paper.tex` (amsart, LaTeX) → `paper.pdf` (10 pages, ~360 KB, compiles
with `pdflatex` twice, 0 errors / 0 undefined refs/cites; verification scripts in `scripts/`).

---

## Folded-in section (2026-05-26): Structural obstructions to elementary descent

§5 "Structural obstructions to elementary descent" was folded in from the
Tier-3 structural-obstructions note (formerly `paper-i`, now SUPERSEDED). It is
delimitative context for paper-b's elementary route, not new progress on PCP:

- **Proposition `prop:geomV`** — the perfect-cuboid complete intersection
  `V ⊂ P^6` is a minimal surface of general type (`K_V = O(1)` ample, `K²=16`,
  `c₂=80`, `χ=8`, `p_g=7`, `q=0`, **not** K3) with finite, linear
  `Aut(V)=Bir(V)=S₃⋉(ℤ/2)⁶`, order 384. The Aut=384 / Chern facts are flagged as
  an **external Gröbner/CAS computation** (`aut_birV` package), NOT PARI-reproducible.
- **Proposition `prop:descent`** (downgraded from the note's single Theorem) — no
  birational self-map of `V` can effect a height-strict Markov–Vieta/Fermat
  descent. Proof = ample `K` ⟹ `Bir(V)` finite (Matsumura/Maehara/Iitaka folklore
  engine) ⟹ telescoping along a finite σ-orbit forces `H_L(P) ≤ H_L(P)−kC`,
  contradiction. Novel only as an *application* to the concrete `V`.
- **Observation `obs:noabs`** — `E_PCP(q)` has purely multiplicative (I_n)
  reduction at every bad prime, so all non-arch local heights ≤ 0 and no
  elementary discriminant-free height lower bound exists. Verified by new script
  `09_local_heights_In.gp` (copied from the note; re-run this session, PASS).
- `X_± = 120a2 / 80a1` (rank 0, Kolyvagin) is **referenced** to paper-b's existing
  Jacobian decomposition (Prop `prop:decomp`/`prop:rank`, Remark `rem:wrongfactors`),
  NOT duplicated.
- Honest distinction from **Yelle (arXiv:2602.00239)** made explicit in
  `rem:yelle`: Yelle's descent is divisibility-propagation along the space
  diagonal, a *different* mechanism from a birational self-map of `V`.
- Pila–Zannier-inapplicability and multiplicative-reformulation items confined to
  a single one-line parenthetical in `rem:yelle` (internal-only; not inflated).

**Theorem discipline preserved:** the merged paper still has exactly ONE
`\begin{theorem}` (the Case-B Pell–Lucas closure, `thm:main`); the descent result
is a Proposition. Bibliography merged + deduped to **18 bibitems** (added
Matsumura, Maehara, Iitaka, Hindry–Silverman, Silverman ATAEC, Wagener, Yelle,
van Luijk, Peschmann2; reused existing kolyvagin/peschmann/yoshida/pari). New
PARI verification of `X_±`: 120a2 rank 0 tors ℤ/4×ℤ/2 L(1)≈1.26949; 80a1 rank 0
tors (ℤ/2)² L(1)≈1.00945 — matches existing usage.

---

## What the paper proves

**Main Theorem (unconditional, PARI-complete).** No "Case B at p=1" candidate
`(a,b,c) = (4q, q²−4, 2(q²−1))`, `q ∈ Z_{>0}`, is a perfect cuboid. The two
faces `a²+b²` and `a²+c²` are squares identically; the remaining conditions are
`b²+c² = 5q⁴−16q²+20` and `a²+b²+c² = 5q⁴+20`. Setting `Y=q²` turns the space
condition into the Pell equation `g²−5Y²=20`, whose nonnegative orbit is
`Y_n = L_{2n−1}` (odd-indexed Lucas numbers). By **Cohn (1964)** the only squares
in the Lucas sequence are `L_1=1`, `L_3=4`, so `q ∈ {1,2}`, both degenerate
(`b = q²−4 ≤ 0`). Hence no `q ≥ 3` works.

**Structural result (corrects the prior framework).** For the joint genus-five
curve `C : {e²=5q⁴−16q²+20, g²=5q⁴+20}` (which records all *rational* parameters
and is the concrete instance behind Peschmann's §8 genus-five cover), the
Q-isogeny decomposition is
`Jac(C) ~ 480f1 × 800a1 × 1200a2 × 600a2 × 400a2`,
and **every factor has Mordell–Weil rank 1**, so `rank Jac(C)(Q) = 5 =
genus(C)`. Chabauty–Coleman therefore does **not** apply to C. The two factors
carrying the candidate Chabauty differentials `ω₁,ω₃` are the `Q(√5)`-quadratic
twists `600a2 = X₊^(5)`, `400a2 = X₋^(5)` of the rank-0 curves `120a2 = X₊`,
`80a1 = X₋`; the twist raises the rank from 0 to 1 in each factor. The unique
genus-2 quotient `C_q : w² = u(5u²−16u+20)(5u²+20)` has `Jac(C_q) ~ 600a2 × 400a2`,
rank 2 = genus 2, so it too is outside Chabauty's reach.

## Route used and honesty status

**This paper does NOT use the rank-0 quotient route, and does NOT use the
Coleman-at-p=7 route.** Both were investigated and found to be **mathematically
invalid as stated**: the genus-5/genus-2 factors that the prior writeups
labelled "X₊=120a2, X₋=80a1, rank 0" are in fact the √5-twists 600a2/400a2,
**both rank 1** (verified: tight `ellrank [1,1]` with explicit infinite-order
generators, analytic rank 1, root number −1). Hence `rank Jac(C)=5=genus`,
Chabauty fails outright; the Coleman-at-p=7 argument's claim that ω₁,ω₃ lie in
the Chabauty kernel is false. The paper's main theorem instead rests on the
**elementary Pell–Lucas (Cohn 1964) argument on integer points**, which is
unconditional, PARI-complete, and needs no Magma.

**No step needs Magma.** Every numerical claim is a finite PARI/GP computation:
polynomial identities, point counts, `ellrank` 2-descent (unconditional),
`ellidentify` Cremona labels, `ellanalyticrank`/`ellrootno`, and the Lucas
square test.

## MSC 2020 / keywords

- Primary 11D09; Secondary 11G05, 11G30, 14H45.
- Keywords: perfect cuboid, Euler brick, Pell equation, Lucas sequence,
  genus-five curve, Mordell–Weil rank, Chabauty–Coleman.

## Target journal (recommendation)

**First choice: _Integers_ (Electronic Journal of Combinatorial Number
Theory).** The paper is a clean, self-contained, computationally verified
Diophantine closure of a classical parametric stratum, plus an honest structural
determination (a genus-five Jacobian rank) that corrects a circulating
expectation. _Integers_ routinely publishes exactly this kind of
elementary/Diophantine + verified-computation result, is open access, and has no
page pressure. The Pell–Lucas core is elementary; the rank section adds genuine
arithmetic-geometry content without making the paper long.

**Strong second: _Research in Number Theory_** (or _Journal of Number Theory_,
short-paper track). RNT is a good home for the combination of an elementary
closure with an explicit Jacobian decomposition and rank computation, and is
comfortable with the Chabauty-obstruction framing relative to Peschmann's
preprint. Slightly higher bar than _Integers_, but the rank result strengthens
the case.

**Less ideal: _Experimental Mathematics_.** The paper is "theorem proved via
finite verified computation," not experimental discovery; reserve only if the
framing is broadened toward the surrounding family computations.

## Submission advice

1. Post to arXiv (math.NT) first to timestamp priority relative to Peschmann
   (2026) and Yoshida (2024); the genus-five rank determination is the
   time-sensitive part.
2. Include the eight PARI scripts and their `.out` captures as ancillary files;
   a referee can rerun them in seconds.
3. Keep the scope sentence in the abstract and §4.1 — this closes ONE stratum,
   not PCP. Do not let the title or abstract drift toward an over-claim.

## Honest novelty statement vs. Peschmann / Yoshida

- **Peschmann, arXiv:2604.09328 (2026), §8.** He introduces an *abstract*
  genus-five double cover `C_{T4}: z²=f(·+T4)/f(·)` and writes that *if*
  `rk Jac(C_{T4})(Q) < 5` then Chabauty–Coleman would make finiteness effective,
  while warning that "rank sums exceeding 5 cannot be excluded" and that he does
  not decompose the relevant abelian fourfold. This paper treats a *concrete*
  genus-five curve of that type (Case B at p=1), carries out the decomposition
  he left abstract, and shows the rank **does** reach the genus (=5). So we do
  **not** realize his hoped-for effectivity; we **confirm his stated concern**
  for this instance and close the stratum by the independent Pell–Lucas route.
  This is the honest relationship — an answer to the concrete instance, not a
  resolution of his general program. Peschmann's curve is `z²=f(·+T4)/f(·)`,
  while ours is the fibre product `{e²=f1, g²=f2}`; they are genus-five covers in
  the same circle of ideas but not literally the same equation.
- **Yoshida, arXiv:2407.09825 (2024).** Existence direction (face cuboids via
  `E_{1,s}`), opposite to ours; his curves are disjoint from `X±` and their
  twists. No overlap with the present closure.
- **Cohn (1964), Kolyvagin (1989), Cremona/LMFDB.** Cited as the unconditional
  inputs (Lucas squares; analytic-rank-0/1 ⟹ algebraic rank; Cremona labels).
- **Folklore caveat.** "To the best of our knowledge," the precise statements —
  the Pell–Lucas closure of Case B at p=1, and the rank-5 determination with the
  (−,−,−)-eigenspace governed by 600a2/400a2 rather than 120a2/80a1 — do not
  appear in the cited literature; we do not claim the underlying rank facts are
  unknown to specialists.

## Caveat / scope limits (stated in §4.1)

- Closes **only** "Case B at p=1," a single one-parameter stratum — even more
  limited than the Saunderson subfamily of the companion paper.
- Higher-p Case B, Case A, other face-III parametrizations, higher two-adic
  strata, and non-primitive sub-cases are **not** covered. PCP is **not** solved.
- The *rational*-parameter question (rational points of C) is shown to be
  **inaccessible** to Chabauty–Coleman here (rank = genus); an effective
  determination of `C(Q)` would need a higher method (quadratic Chabauty, or
  Mordell–Weil sieve + covering collections), which we do not attempt. The
  stratum closure does not depend on knowing `C(Q)` — only the integer points,
  which Pell–Lucas settles.

## What the author must still supply

- **Affiliation / acknowledgements**: currently "Independent Researcher." Add
  any funding/thanks; add an acknowledgement if anyone reviewed drafts.
- **Matson reference** (`\cite{matson}`): the ~5×10¹¹ smallest-edge bound is to
  an unpublished manuscript / unsolvedproblems.org. Confirm the exact attribution
  and the current best published bound before submission.
- **Cohn reference**: `\cite{cohn}` is "On square Fibonacci numbers," J. London
  Math. Soc. 39 (1964), 537–540. The Lucas-squares statement (only L_1, L_3 are
  squares) is in Cohn's 1964 work; if a referee prefers, cite also Cohn's
  companion "Square Fibonacci numbers, etc." (Fibonacci Quart. 2 (1964), 109–113)
  or a modern survey for the Lucas part.
- **Cremona/LMFDB labels**: verify `480f1`, `800a1`, `1200a2`, `120a2`, `80a1`,
  `600a2`, `400a2` against current LMFDB (labels are PARI `ellidentify` output;
  Cremona vs LMFDB labelling conventions occasionally differ).
- **Peschmann / Yoshida arXiv numbers**: `2604.09328`, `2407.09825` confirmed by
  web search at time of writing; re-confirm at submission.

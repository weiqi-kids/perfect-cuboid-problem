# No perfect cuboid in the Saunderson family of Euler bricks

**Author.** CΛ / Lightman Chang (Independent Researcher, lightman.chang@gmail.com)

**File.** `paper.tex` (amsart, LaTeX) → `paper.pdf` (6 pages, ~294 KB, compiles with `pdflatex` twice; verification scripts in `scripts/`).

---

## What the paper proves

**Main Theorem.** No Saunderson brick is a perfect cuboid: for every primitive
Pythagorean triple `(u,v,w)`, the brick
`(u(4v²−w²), v(4u²−w²), 4uvw)` either has a vanishing edge or has
`a²+b²+c²` non-square.

This is a SMALL-WIN paper: one clean main theorem closing the Saunderson
*subfamily* of Euler bricks. It does **not** resolve the full Perfect Cuboid
Problem. The Saunderson family is a small fraction of Euler bricks (1 of 5
primitive bricks with edges ≤ 1000; only 2 of 11 with edges ≤ 5000), and a
perfect cuboid coming from a non-Saunderson Euler brick is invisible to the
reduction. The paper states this scope limit explicitly in §5.

## Proof chain (all steps written out, no "clearly"/"a calculation shows")

1. Saunderson body-diagonal identity `a²+b²+c² = w²(w⁴+16u²v²)` (Lemma 2.2),
   verified as a `Z[p,q]` polynomial identity.
2. With `(u,v,w)=(p²−q²,2pq,p²+q²)`, `t=p/q`: reduction to genus-3 curve
   `C': T² = t⁸+68t⁶−122t⁴+68t²+1` (Lemma 2.4).
3. Palindrome `W=t+1/t`: `octic/t⁴ = W⁴+64W²−256`, so `C'_pal: S²=W⁴+64W²−256`,
   whose Jacobian is E_PCP (cond 160, rank 1, j=−64/25) (Lemma 2.5).
4. Lifting identity `W²−4=(t−1/t)²` (Lemma 2.6); substituting `W²=T₀²+4` gives
   the genus-1 curve `C₀: S²=T₀⁴+72T₀²+16` (Prop 2.7).
5. Jacobian of C₀ = Cremona **80a1** `y²=x³−7x+6`, cond 80, j=148176/25,
   torsion (Z/2)², **rank 0** (PARI `ellrank` tight [0,0]; independently
   Kolyvagin via L(80a1,1)≈1.0095≠0). Hence `|C₀(Q)|=4`, all with
   `T₀∈{0,∞}` ⟹ degenerate brick (Props 3.2, 3.3, 3.4).

All five steps are PARI-verified; scripts + `.out` captures are under `scripts/`.

## MSC 2020 / keywords

- Primary 11D09; Secondary 11G05, 11G30.
- Keywords: perfect cuboid, Euler brick, Saunderson family, elliptic curve,
  rank zero, Chabauty.

## Target journal (recommendation)

**First choice: _Integers_ (Electronic Journal of Combinatorial Number
Theory).** Rationale: it routinely publishes self-contained, computationally
verified elementary/Diophantine number-theory results of modest length; a
clean one-theorem closure of a classical parametric subfamily, resting on a
table lookup plus elementary algebra, is squarely in scope, and the journal is
fully open access with no page pressure.

**Strong second: _Journal of Integer Sequences_.** Good fit for the explicit,
reproducible-computation character and the Euler-brick / Pythagorean theme;
slightly more sequence-/enumeration-oriented than this paper, so _Integers_ is
the better primary target.

**Possible but less ideal: _Experimental Mathematics_.** The paper is more
"theorem proved via a finite verified computation" than "experimental
discovery," so EM is a weaker fit; reserve it only if the framing is broadened
to the wider Euler-brick-family computations.

## Submission advice

1. **Post to arXiv first** (math.NT), then submit to _Integers_. This
   timestamps priority relative to Yoshida (2024) and Peschmann (2026), which
   matters because the elliptic family overlaps with Yoshida's.
2. Include the PARI scripts as ancillary files on arXiv and as a supplement on
   submission; the referee can rerun them in seconds.
3. Keep the scope sentence in the abstract ("closes a single, explicitly
   delimited subfamily") — do not let an over-enthusiastic title slip in.

## What the author must still supply

- **Affiliation / acknowledgements**: currently only "Independent Researcher."
  Add any funding/thanks; add an acknowledgement if anyone reviewed drafts.
- **Matson reference** (`\cite{matson}`): the ~3×10¹² empirical bound is cited
  to an unpublished manuscript / unsolvedproblems.org. Confirm the exact
  attribution and current best published bound before submission (consider also
  citing a peer-reviewed survey for the bound).
- **Cremona reference**: verify the LMFDB URL/label `80a1` and, if preferred,
  cite the LMFDB collaboration directly in addition to Cremona's book.
- **Peschmann arXiv number** (`2604.09328`) and **Yoshida** (`2407.09825`):
  confirm the identifiers and that the cited open problem (§4.3 / §8 of
  Peschmann) is quoted accurately in §5.2.

## Honest novelty statement vs. Yoshida / Peschmann

- **Saunderson** (18th c.): the parametrization is classical; cited as such.
- **Yoshida, arXiv:2407.09825 (2024)**: studies the *same* elliptic family from
  the **existence-of-face-cuboids** direction and shares the torsion
  classification of the rank-1 curve E_PCP. Our work runs the opposite
  direction (non-existence of perfect cuboids on a parametric locus) and adds
  the rank-lowering lifting step `W²−4=T₀²` that collapses rank 1 → rank 0;
  this step has no counterpart in Yoshida. Positioned as **complementary**.
- **Peschmann, arXiv:2604.09328 (2026)**: reduces PCP to genus-3 curves
  `C_A: w²=λ⁸+Aλ⁴+1` but does **not** treat the Saunderson subfamily nor the
  rank-0 curve 80a1; the only explicit rank-0 curve there is Asiryan's
  `Y²=X(X−8)(X−9)`, and the "irreducibility → simultaneous representability"
  adaptation is left open (his §8). Our Saunderson closure is **not covered**
  by Peschmann.
- **Folklore caveat**: we do not claim the underlying rank-0 fact is unknown to
  specialists; we claim only that this precise statement and proof do not
  appear in the cited literature ("to the best of our knowledge").

## Caveat / gap not closed in the writeup

The paper closes ONLY the Saunderson subfamily, by design. The genus-3 → genus-1
collapse depends on the Saunderson-specific body-diagonal identity
`a²+b²+c² = w²(w⁴+16u²v²)` (Lemma 2.2); a different (non-Saunderson) Euler-brick
family does not satisfy this identity and is outside the reduction. No uniform
parametrization of all Euler bricks is used or claimed. The 80a1 rank-0 fact is
established by PARI's `ellrank` 2-descent (unconditional) and cross-checked by
Kolyvagin (analytic rank 0, L-value ≠ 0); both are unconditional, so the result
carries no conjectural dependence.

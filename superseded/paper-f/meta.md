# meta.md — Paper P6 (short note)

**Title.** Torsion of the perfect-cuboid elliptic family is degenerate for the cuboid recovery map

**Author.** CΛ / Lightman Chang — Independent Researcher — lightman.chang@gmail.com

**Files.** `paper.tex` (amsart, 4 pp, compiles `pdflatex` ×2 clean, 0 undefined refs), `paper.pdf` (~270 KB), `scripts/` (5 scripts + `.out`).

**MSC 2020.** Primary 11G05; Secondary 11D09, 11G07.

---

## 1. What the note contains

- **One new theorem** (`\begin{theorem}` Theorem 1, "Torsion degeneracy"): for Pythagorean
  `q`, the recovery map `φ(X,Y)=2Yq/(q²−X²)` sends all 8 rational torsion points of
  `E_PCP(q): Y²=X(X+1)(X+q²)` into `{0,∞}` — the three 2-torsion points to `0`, the four
  order-4 points (at `X=±q`, exactly the pole divisor) to `∞`. Corollary: a finite nonzero
  cuboid edge forces an infinite-order point; torsion can be discarded from any search.
- **Torsion classification** stated as a *recalled* Proposition attributed to Yoshida
  (`arXiv:2407.09825`, Lemma 2.1), re-derived via the explicit uniform discriminant identity
  `Δ(Z)=(Z−1)⁴(Z+1)²(Z²−6Z+1)`.

## 2. Verification status (all PASS)

| Claim | Script | Result |
|---|---|---|
| `2·(q,q(q+1))=(0,0)` in ℚ(q); order-8 → quartic `G₁` (abs. irreducible); `Δ(Z)=(Z−1)⁴(Z+1)²(Z²−6Z+1)`; conic → `q=s²` | `03_discriminant_identity.py` | PASS (symbolic, exact) |
| φ sends all 8 torsion points to `{0,∞}` over ℚ(q) | `05_recovery_degeneracy.py` | PASS (symbolic) |
| torsion `[4,2]` and 496/496 torsion points → `{0,∞}` over 62 Pythagorean q | `02_torsion_sweep.gp` | PASS (numeric) |
| `y²=x³+4x` (32a1) analytic rank 0, torsion ℤ/4 ⇒ `u²=s⁴+1` only `s=0` | `04_fermat_curve.gp` | PASS |
| relationship of `E_PCP(q)` to Yoshida `E_{1,s}` | `01_isomorphism.gp` | PASS (see §3) |

## 3. HONEST corrections made during drafting (do NOT propagate the old claims)

The internal note `PRIOR-ART-YOSHIDA.md` (and `LEMMA-1-UNIVERSAL-TORSION.md` by reference)
asserted that **`E_PCP(q)` is ℚ-isomorphic to Yoshida's `E_{1,s}` at `q=2s/(s²−1)`** ("on the
Pythagorean locus our `E_PCP(q)` and Yoshida's `E_{1,s}` are the same curve up to
isomorphism"). **This is false**, and I did not put it in the paper. Verified facts:

- The j-invariants of `E_PCP(q)` and `E_{1,s}` agree **only** at the **non-Pythagorean**
  value `q=(s²+1)/(2s)` (there the explicit substitution `x=4s²(X+1), y=8s³Y` is an exact
  ℚ-isomorphism — residual identically 0). The doc's `q=2s/(s²−1)` gives a **negative**
  scaling factor (only a quadratic-twist / ℚ̄ relation), not a ℚ-isomorphism.
- For genuinely Pythagorean `q` (e.g. `4/3`, `3/4`, `5/12`, ...), **no rational `s` of height
  ≤ 80 matches `j(E_{1,s})=j(E_PCP(q))`** — so `E_PCP(q)` is **not ℚ-isomorphic to any
  `E_{1,s}`** on the Pythagorean locus.
- `E_PCP(q)` has roots `{0,−1,−q²}` (two negative): it is **not even in the Yagi family**
  `y²=x(x−a²)(x+b²)` up to ℚ-isomorphism (no rational translation makes it `{0,+,−}`-shaped).
  It is the `−1`-twist of `y²=x(x−1)(x−q²)`.

**Net effect on attribution.** The torsion **conclusion** `ℤ/4×ℤ/2` and the **method**
(Mazur + Fermat descent on `s⁴+1=u²`) are genuinely Yoshida's — confirmed: his `E_{1,s}` has
`[4,2]` torsion (checked). But the curves are twist-inequivalent, so the two computations run
on **distinct curves by a common argument**. The paper states exactly this (intro ¶3,
Proposition 1 proof, verification item 4), credits Yoshida prominently, and frames the
discriminant identity as a presentation-level convenience, not a new theorem.

## 4. HONEST novelty / threshold assessment

**What is genuinely new (and verified correct):**
1. The recovery-map degeneracy theorem (Theorem 1) — no analogue in Yoshida, who maps the
   *opposite* direction (non-torsion → face cuboids).
2. The uniform discriminant identity `Δ(Z)=(Z−1)⁴(Z+1)²(Z²−6Z+1)` as a presentation of the
   order-8 obstruction directly in `q`.
3. The correction that `E_PCP(q)` is twist-inequivalent (not isomorphic) to `E_{1,s}` — a
   small but correct factual contribution that supersedes the erroneous internal claim.

**What is NOT new:** the torsion classification `ℤ/4×ℤ/2` (Yoshida 2024, Lemma 2.1), including
the Mazur + Fermat-descent method.

**Verdict — is this a viable standalone note, or too thin?**

My honest judgment: **borderline, leaning sub-threshold as a standalone research note for a
selective journal.** The single new theorem is correct but elementary — once the (cited)
torsion structure is in hand, the degeneracy is a one-line evaluation of `φ` on 8 explicit
points (numerator vanishes on 2-torsion; denominator vanishes on 4-torsion). That is real and
previously unrecorded, but it is a *lemma-sized* observation, not a theorem that would carry a
paper on its own at a research venue. The discriminant identity is cosmetic. The twist
correction is worth recording but is a footnote, not a contribution.

**Recommendation (in priority order):**

1. **Best home: as a foundational lemma inside a larger paper.** This is in fact what it is in
   the CΛ framework — the degeneracy is the lemma that licenses ignoring torsion in the
   Saunderson sub-family closure (P2) and the rank-positive analysis (P3). It belongs in
   whichever of those becomes the lead paper, as a short §2 lemma with the Yoshida citation.
2. **If a standalone is desired:** submit only as an **expository / structural note** to a venue
   that accepts them (e.g. *Integers*, *Journal of Integer Sequences*, a short-notes section, or
   arXiv-only as a companion to Yoshida). Frame it exactly as drafted — "a companion observation
   to Yoshida on the degeneracy of torsion under the cuboid recovery map" — and do **not** dress
   it as a research advance on PCP. Even then, acceptance at a refereed venue is uncertain given
   the thinness.

**Target venue (if standalone):** arXiv (math.NT) as an explicit companion to 2407.09825;
or *Integers* / a short-communications outlet. **Preferred path: fold into P2/P3 as a lemma.**

## 5. Overclaim audit

- No "we solve PCP" / "resolve" / "structural barrier" language; forbidden-word scan clean.
- Torsion explicitly attributed to Yoshida in abstract, intro, and Proposition 1.
- The (false) isomorphism claim from the internal notes is **excluded** and the correct
  twist-relationship is stated.
- Title is factual and modest ("is degenerate for the cuboid recovery map").
- Exactly one `\begin{theorem}`; torsion is a `Proposition` (recalled).
- The note states plainly it makes no claim about existence of perfect cuboids.

— CΛ / Lightman Chang, 2026-05-26

SUPERSEDED 2026-05-26: φ-degeneracy folded into paper-c §2 as a lemma.

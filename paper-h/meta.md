Title: Mordell–Weil ranks and an experimental survey of the perfect-cuboid elliptic family

# meta.md — Paper P8 (experimental-mathematics survey, Type B)

**Title.** Mordell–Weil ranks and an experimental survey of the perfect-cuboid elliptic family

**Author.** CΛ / Lightman Chang — Independent Researcher — lightman.chang@gmail.com

**Files.** `paper.tex` (amsart `[11pt,reqno]`, 6 pp, compiles `pdflatex` ×2 clean, 0 errors, 0 warnings, 0 undefined refs/citations), `paper.pdf` (272 KB), `scripts/` (4 scripts + 4 `.out`).

**MSC 2020.** Primary 11G05; Secondary 11D09, 11G07, 11Y50, 14J27.

---

## 1. What the paper contains (4 components, by logical status)

The per-fiber curve is `E_PCP(q): y² = x(x+1)(x+q²)`, with `q = (m²−n²)/(2mn)` for
coprime opposite-parity `m>n`. Integral model `E(m,n): y² = x(x+b²)(x+a²)`,
`a=m²−n²`, `b=2mn`, via `X=x/b², Y=y/b³`.

- **Theorem 1 (the one proved statement).** `E_PCP(195/748)` (from `(m,n)=(22,17)`)
  has Mordell–Weil rank EXACTLY 3 over ℚ. Proof = unconditional `ellrank`
  2-Selmer upper bound `h=3` + three explicit points with regulator
  `det H = 18.83372… ≠ 0` (independence). Genuine theorem, NOT a bare lower bound.
  Generators on the q-fiber: `Q₁=(−15/176, 2415/65824)`, `Q₂=(117/44, 169533/32912)`,
  `Q₃=(12675/44, 161213325/32912)`.
- **Observation 2.1 (no-cuboid record).** Exactly 36 primitive Euler bricks with all
  edges ≤ 30000; 0 are perfect cuboids (exact `issquare` face sieve, ~3 min).
- **Observation 3.2 (rank distribution).** 303 primitive Pythagorean fibers,
  `2≤m≤38`: ranks 0/1/2/3 = 118/137/45/3 = 38.94/45.21/14.85/0.99 %; max rank 3;
  ZERO uncertified fibers (every `ellrank` interval has lo=hi). Rank-3 fibers:
  (22,17), (35,22), (37,26).
- **Observation 5.2 (named-curve catalogue).** `E_PCP` geometry
  `Δ=16q⁴(q²−1)²`, `c₄=16(q⁴−q²+1)`, torsion ℤ/4×ℤ/2; Saunderson "cleanest"
  curve `y²=x³+x²−x+15` = Cremona 160a2 rank 1 (gen `(−1,4)`); auxiliary cover
  `y²=x³−36x²+320x` = Cremona 80a1 rank 0.
- **Conjecture 3.3.** rank-3 fibers positive frequency; max rank unbounded
  (flagged speculative; rank-4 fibers from the project's non-exhaustive search NOT imported).

## 2. Verification status (all PASS, recomputed from scratch this session)

| Claim | Script | Result |
|---|---|---|
| (22,17) rank = 3, reg ≠ 0 | `01_fiber_22_17_rank.gp` | ellrank `[3,3]`; reg `18.8337…`; numeric rank of H = 3 |
| rank histogram 303 fibers | `02_rank_distribution.gp` | 118/137/45/3, 0 uncertified, max 3 |
| 36 bricks ≤30000, 0 PCP | `03_euler_brick_search.gp` | 36 bricks, 0 cuboids (cross-checks 5@1000, 11@5000) |
| named curves + q-coords | `04_named_curves.gp` | 160a2 r1, 80a1 r0, geometry, gens on E_PCP(q) |

## 3. Honest novelty assessment

- **Genuinely new:** (i) the explicit ℚ-rank-3 fiber with full certification —
  Naskręcki (1210.6933, Acta Arith. 160 (2013) 159–183) gives only the GEOMETRIC/generic
  rank (1 generically, 2 on a subfamily, over ℚ(q)); an individual ℚ-fiber of rank 3
  with 3 independent generators is the delta. (ii) the FULLY-CERTIFIED rank histogram
  (every fiber lo=hi, no rank gaps) over a stated exhaustive range.
- **Folklore / not claimed:** the PCP→elliptic reduction template (van Luijk, Sharipov,
  Naskręcki, Peschmann); only the local Cremona identifications are claimed.
- **Complementary, not competing:** Yoshida (2407.09825, opposite direction, face cuboids);
  Peschmann (2604.09328 / 2604.28072, conditional/per-fiber closures, rank-0-quotient method).

## 4. Type-B compliance

- Computational Evidence section with explicit ALGORITHM pseudocode (face sieve),
  SEARCH RANGE (edge ≤ 30000; fibers 2≤m≤38), hardware/software (PARI/GP 2.15.4, single
  x86-64 core, parisize 2–6 GB), REPRODUCIBILITY (§7 lists all 4 script names).
- Theorem / Observation / Conjecture used precisely; single `\begin{theorem}` = the
  rank-3 certification.
- Abstract 227 words, 4-part. No forbidden words. cite↔bibitem bijection (7↔7), all real.
- Modest title; no PCP-solving claim anywhere.

## 5. Caveat on the rank-3 theorem

The rank-3 statement IS a theorem (not an ellrank lower bound only): `ellrank`'s
upper bound `h=3` is the unconditional 2-Selmer bound (no BSD/Sha hypothesis), and the
lower bound is witnessed by the nonzero regulator. Reproducible and hand-checkable.

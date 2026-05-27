# meta.md — Paper P7 (expository note)

> **SUPERSEDED 2026-05-26**: the reformulation (folklore) and named-curve catalogue (incl. the 160a2 identification) were absorbed into paper-h (P8, experimental survey) §"reformulations and named-curve catalogue". This standalone note is retired; P8 is the canonical home.


**Title.** The Saunderson sub-family of the perfect-cuboid problem reduces to the rank-one elliptic curve 160a2: an expository note

**Author.** CΛ / Lightman Chang — Independent Researcher — lightman.chang@gmail.com

**Files.** `paper.tex` (amsart, 11pt, reqno; 4 pp; compiles `pdflatex` ×2 clean, 0 errors, 0 undefined refs/citations), `paper.pdf` (~255 KB, 4 pages), `scripts/` (5 scripts + `.out` files).

**MSC 2020.** Primary 11G05; Secondary 11D09, 11D25, 11G07.

---

## 1. Honest novelty verdict — READ FIRST

**P7 is NOT standalone-viable. It is folklore + one computational nugget. Recommendation: fold into P8 (experimental survey) as a "Reformulations / named-curve catalogue" section.**

Both halves of the requested topic are low-novelty:

- **(a) N4 reformulation (PCP ⟺ P₄+P₆=P₅).** *Folklore.* A WebSearch returns this verbatim as a known search method ("the sum of the squares of two Pythagorean triple solutions for a given odd side match the square of a third"). Peschmann (arXiv:2604.09328) states the same shared-leg form in his abstract and Remark 2.3. It is a direct restatement of the four defining cuboid equations. **Not a research contribution.** Recalled as a Proposition with explicit folklore attribution.

- **(b) "Cleanest formulation" / Theorem E (Saunderson locus ⟺ rational point on E_PCP with W²−4 square).** The *reduction template* (cuboid sub-locus → genus-1 quartic → square condition on an elliptic curve's rational points) is **standard** and predates the project: van Luijk (2000 thesis), Sharipov (1208.1227, 1303.0765), Naskręcki (1210.6933), Asiryan (2510.11768), and most directly Peschmann (2604.09328, Cor. 5.2 — structurally identical: "C_A has a non-degenerate rational point iff ∃ P ∈ E_A(ℚ) with f(P) a non-trivial perfect square"). The only difference is Peschmann's E_A is a *family*; the project's E_PCP is the *single specialization* on the Saunderson fiber.

**The single defensible item:** the explicit Cremona identification **160a2** for the Saunderson fiber, plus the palindromic identity D(r) = 4(r⁸+68r⁶−122r⁴+68r²+1) realizing it. That is a reference-entry nugget, not a paper. The note is written modestly and openly states this throughout (§Introduction "Contribution and scope", §5 "Relation to prior work and limitations").

This is the same failure mode as P6 ("too thin to stand alone"); we do not pretend otherwise.

## 2. Reconstructed statements

- **N4 reformulation.** PCP (non-degenerate) ⟺ ∃ three Pythagorean square-ratios P₄,P₅,P₆ with P₄+P₆=P₅. Reconstructed faithfully (the doc's sin/cos labelling is a presentation choice; the underlying relation is the g-condition x²+y²+z²=1 among three unit-circle cosines).
- **Theorem E / cleanest formulation.** Saunderson space-diagonal condition ⟺ S²=W⁴+64W²−256 with W=r+1/r rational (⟺ W²−4 a non-zero square). The smooth model's Jacobian is E_PCP: y²=x³+x²−x+15.

## 3. PARI / sympy verification (all PASS)

| Claim | Script | Result |
|---|---|---|
| D(r)=256r²(r²−1)²+4(r²+1)² = 4(r⁸+68r⁶−122r⁴+68r²+1); palindrome → W⁴+64W²−256; lift disc = W²−4 | `theoremE_identity.py` | PASS (symbolic, exact) |
| N4: integer identity reduces to cos²θ₄+cos²θ₆=cos²θ₅; g-condition ⟺ P₄+P₆=P₅; faithful equivalence | `n4_reconcile.py` | PASS (symbolic) |
| E_PCP invariants: Cremona **160a2**, conductor 160, disc −102400, j=−64/25, torsion ℤ/2 gen (−3,0), **ellrank=[1,1]** (rank exactly 1), gen (−1,4) ĥ=0.1793, analytic rank 1 with L′=0.9777 | `epcp_curve.gp` | PASS (numeric) |
| Quartic S²=W⁴+64W²−256 → ellfromeqn → minimal model [0,1,0,−1,15]; Jacobian Cremona **160a2**; same j=−64/25 | `genus3_to_epcp.gp` | PASS (numeric) |
| Lift search |n|≤300, ε∈{0,1}: 0 non-degenerate points with W²−4 a non-zero square, 2 degenerate | `epcp_lift.gp` | PASS (numeric; consistent, not a proof) |

Note: the curve is **160a2** (conductor 160). Some project notes loosely wrote "80a1" — that is a *different* curve (the Saunderson genus-3 closure curve in paper-a / T2); 80a1 ≠ 160a2. Theorem E's curve is unambiguously 160a2, confirmed by `ellidentify` and exact minimal-model match.

## 4. The one theorem and supporting structure

- **Theorem 1** (the only `\begin{theorem}`): Jacobian of S²=W⁴+64W²−256 is E_PCP = Cremona 160a2; conductor 160, disc −102400, j=−64/25, torsion ℤ/2 gen (−3,0), rank 1 gen (−1,4), rank=analytic rank=1 unconditional (Gross–Zagier + Kolyvagin).
- Proposition 1 (folklore N4 equivalence), Lemma 1 (palindrome identities), Corollary 1 (Saunderson locus ⟺ square condition on E_PCP), Remark 1 (finite lift search, honestly flagged as non-conclusive).

## 5. Bibliography — every \bibitem verified real (WebSearch)

| Key | Reference | Verified |
|---|---|---|
| Guy | Unsolved Problems in Number Theory, 3rd ed., Springer 2004 (PCP = Problem D18) | ✓ |
| Kolyvagin | Kolyvagin 1988 (Izv. 52) + Gross–Zagier (Invent. Math. 84, 1986) | ✓ |
| vanLuijk | van Luijk, *On perfect cuboids*, MSc thesis, Utrecht 2000 | ✓ |
| Naskrecki | Acta Arith. 160 (2013) 159–183; arXiv:1210.6933 | ✓ (title/venue/vol/pages) |
| Sharipov2elliptic | *On two elliptic curves associated with perfect cuboids*, arXiv:1208.1227 (2012) | ✓ |
| Peschmann1 | *Quartic reductions and elliptic obstructions for perfect Euler bricks*, arXiv:2604.09328 (2026) | ✓ |
| Peschmann2 | *A torsion-intersection proof of perfect-cuboid nonexistence on 1,072 explicit master-tuple fibers*, arXiv:2604.28072 (2026) | ✓ (exact title) |
| Yoshida | *The relationship between face cuboids and elliptic curves*, arXiv:2407.09825 (2024) | ✓ |

All 8 cite keys ↔ 8 bibitem keys (bijection verified). No forbidden words. Title modest. No claim of solving PCP.

## 6. Compile

`pdflatex -interaction=nonstopmode paper.tex` ×2 → `paper.pdf`, 4 pages, 255 KB, 0 errors, 0 undefined references/citations.

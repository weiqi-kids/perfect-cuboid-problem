# meta.md — Paper P9–P14 consolidated (Tier-3 structural-obstructions note, Type C)

**Title.** Structural and arithmetic obstructions to elementary approaches to the perfect cuboid problem

**Author.** CΛ / Lightman Chang — Independent Researcher — lightman.chang@gmail.com

**Files.** `paper.tex` (amsart `[11pt,reqno]`, 6 pp, compiles `pdflatex` ×2 clean: 0 errors,
0 undefined refs/citations, no non-font warnings), `paper.pdf` (315 KB), `scripts/` (3 scripts + 3 `.out`).

**MSC 2020.** Primary 11D09; Secondary 14J29, 14E07, 11G05, 11G50.

---

## 1. HONEST TRIAGE of P9–P14 (the crux)

The instruction anticipated that several Tier-3 items are internal-only, like the
sibling P6/P7. After reading the source docs and running the verifications, the verdict
is: **most of P9–P14 is internal-only / folklore; there is just enough genuinely
defensible theorem-grade material for ONE consolidated structural-obstructions note,
and not a line more.** Per-item classification:

| Item | Source doc | Class | One-line justification | Novelty verdict |
|---|---|---|---|---|
| **P9** Pila–Zannier inapplicability (no Galois orbit / non-modular 4th condition) | PILA-ZANNIER-OQ2.md | **C** | Corrects the project's OWN OQ2 exploration. No one in the literature claimed Pila–Zannier/Habegger–Pila solves PCP, so this knocks down nothing published. | NOT standalone. Folded in as Remark 6.2, framed explicitly as "the ingredient the viewpoint would need," not as a refutation. |
| **P10** Vieta/Fermat descent impossibility (general type ⟹ Bir(V) finite ⟹ no height-strict descent) | exploration/route-N2-vieta-descent.md, AUT-BIR-V.md | **B** | Genuine theorem, but the engine (ample K ⟹ Bir finite ⟹ height bounded along orbits) is Matsumura/Maehara folklore. Value = explicit application to the concrete general-type surface V + the recent-literature contrast with Yelle's congruence-descent. | Theorem-grade; novel only as an *application*. This is the ONE `\begin{theorem}`. |
| **P11** Multiplicative methods (ℤ[i] / Hurwitz / octonion) give no obstruction | PICK-17-GAUSSIAN-INTEGER.md, route-N3-hurwitz-quaternion.md, route-W1-octonion.md | **C** | Strawman: nobody claimed these resolve PCP; they are the project's own exploratory routes. The one real byproduct (prime-d ⟹ no cuboid) is classical Pocklington divisibility. | NOT standalone. Folded in as Remark 6.1, stated honestly as "we are not aware of any such claim; this records why the method cannot." |
| **P12** No absolute σ-free height constant (all I_n local heights ≤ 0) | ABSOLUTE-C-VERDICT.md, VOUTIER-YABUTA-IN-HEIGHTS.md | **B** | The all-multiplicative-reduction fact and λ_p ≤ 0 are concrete and verified. But "no absolute c" is essentially the non-effectivity of Lang's height conjecture — folklore. | Theorem-grade as Observation 4.2 only. Demoted from any standalone framing. |
| **P13** Aut(V)=384, V general type (not K3), Picard rank of V′ | AUT-BIR-V.md, V-FALTINGS-ATTACK.md, VANLUIJK-PICARD.md | **B** | Concrete, fully verifiable invariants (K²=16, c₂=80, p_g=7, q=0, \|Aut\|=384, ρ(V′)∈[16,20]). Modest; these are the geometric inputs that make P10 work. | Propositions 3.1–3.4. Genuinely-computed but not a result in its own right. |
| **P14** X_± rank 0 (Kolyvagin) + reductions | COLEMAN-P1-RIGOROUS.md §2, PCP-COMPLETE-PROOF-v2.md §6.5 | **C/B** | Verified rank 0 (120a2, 80a1), but it is an ingredient feeding the genus-5 work (already in paper-b), and the finiteness is the routine consequence of a nonzero central L-value via Kolyvagin. | Proposition 5.1, explicitly called "a clean ingredient rather than a result in its own right." Too thin to stand alone. |

**Net triage.** A=0, B=4 (P10, P12, P13, P14 — but only P10 reaches a standalone
theorem statement, the others are its supporting Propositions/Observation), C=2 (P9, P11
are internal-clarification Remarks). There is NOT enough Type-A novel material for a
strong standalone paper; there IS enough theorem-grade-plus-verified-computation material
for ONE consolidated *delimitative* note that honestly frames everything as structural
obstructions / negatives. Padding beyond this would repeat the P6/P7 "too thin" failure.

## 2. What went into paper-i (the consolidated note)

- **§2 Theorem 1.1 (the single theorem):** no birational self-map of V can effect a
  height-strict infinite descent. Proof = K_V = O(1) ample (adjunction) ⟹ V minimal
  general type ⟹ Bir(V) finite (Matsumura + Maehara/Severi) ⟹ H_L ∘ σ − H_L = O(1) by
  telescoping over the finite period ⟹ contradiction with strict decrease. (P10)
- **§3 Propositions 3.1–3.4:** the Chern invariants (general type, not K3), the explicit
  Aut(V) = S_3 ⋉ (ℤ/2)^6 order 384, and the K3-cover Picard bounds. (P13)
- **§4 Proposition 4.1 + Observation 4.2:** purely multiplicative (I_n) reduction at every
  bad prime ⟹ all non-arch local heights ≤ 0 ⟹ the positive height is archimedean-only ⟹
  no elementary discriminant-free height lower bound; the only elementary handle is a Szpiro
  bound. (P12)
- **§5 Proposition 5.1:** X_+ = 120a2, X_- = 80a1, both rank 0 by Kolyvagin. (P14)
- **§6 Remarks 6.1, 6.2:** multiplicative reformulations and the unlikely-intersection
  viewpoint — stated honestly as "approaches that do not transfer," each with an explicit
  disclaimer that no published claim is being refuted. (P11, P9)

## 3. What was deliberately EXCLUDED as internal-only

- The full Habegger–Pila / X_1(4)² dimension-count machinery (PILA-ZANNIER-OQ2 §2): kept to
  a single Remark; the detailed atypicality stratification is internal exploration.
- The 9-attack Hurwitz/octonion catalogue (route-N3/W1): collapsed to one Remark; the
  per-attempt failure log belongs in project discussion.
- The 33-fiber height sweep numerics (ABSOLUTE-C-VERDICT §2): one illustrative numeric range
  cited in Observation 4.2; the full table is internal (and overlaps paper-d's Szpiro work).
- The Faltings/Bombieri–Lang conditional reduction (V-FALTINGS §5) and the genus-5 Chabauty
  correction (memory): those belong to paper-b, not here.

## 4. PARI/SymPy verification (all PASS, recomputed this session)

| Claim | Script | Result |
|---|---|---|
| X_± rank 0, labels, L-values, torsion | `01_xpm_kolyvagin.gp` | X_+ = **120a2** (ar 0, L(1)=1.26949, tors ℤ/4×ℤ/2, ellrank [0,0]); X_- = **80a1** (ar 0, L(1)=1.00945, tors (ℤ/2)², ellrank [0,0]); both corpus models have equal j ⇒ same curves |
| every bad prime multiplicative (I_n), λ_p ≤ 0 | `02_local_heights_In.gp` | 3 fibers (11,2),(8,3),(4,3): all bad primes v_p(c₄)=0, Kodaira I_n; λ_p ∈ [−N_p/4·log p, 0]; Σλ_p ∈ [−¼log\|Δ\|, 0] |
| V invariants + group order | `03_invariants_general_type.py` | K²=16, c₂=80, χ=8, p_g=7, q=0, K_V=O(1) ample (general type, not K3), \|Aut(V)\|=384 |

(The Aut(V) symbolic ideal-membership checks live in the project's prior `scripts/aut_birV/`
01_linear_aut.out / 04_s3_verification.out, referenced in Prop 3.2.)

**Honest discrepancy noted.** COLEMAN-P1-RIGOROUS.md §2.2 recorded X_+ torsion as ℤ/8 and
X_- as ℤ/4; PARI `elltors` gives ℤ/4×ℤ/2 and (ℤ/2)² respectively. PARI is authoritative;
the rank-0 conclusion (the load-bearing claim) is unaffected.

## 5. Novelty / prior-art (WebSearch-verified, all bibitems real)

- **Matsumura 1963** (Lincei) — ample canonical ⟹ no 1-param subgroup of Bir; **Maehara 1983**
  (Math. Ann.) — finiteness of general-type targets. These make Theorem 1.1's engine folklore.
- **Yelle, arXiv:2602.00239** (Jan 2026) — elementary infinite-descent obstruction via
  prime-propagation along the space diagonal. CRITICAL to cite: Theorem 1.1 is "no *birational*
  height-strict descent on V"; Yelle's descent is a *different* mechanism (divisibility, not a
  self-map of V). Remark 2.2 makes the distinction explicit to avoid overclaiming.
- **Peschmann 2604.09328 / 2604.28072** (2026) — genus-3 reduction + 1072-fiber torsion-intersection
  closure; this note is complementary (structural, not a closure).
- **Yoshida 2407.09825** (2024) — face cuboids (opposite direction).
- **Naskręcki 1210.6933**, Acta Arith. 160 (2013) 159–183 — geometric MW rank of the family.
- **Kolyvagin 1989**, **Gross–Zagier 1986**, **Silverman GTM 151 1994**, **Petsche 2006**,
  **Wagener 1706.03622**, **Pila–Zannier 2008**, **Habegger–Pila 2016**, **van Luijk 2000**,
  **Guy UPNT**, **Hindry–Silverman GTM 201** — all confirmed real.

## 6. Compliance

- English body; abstract 235 words, 4-part (problem / what we record / main observation /
  positioning vs Peschmann & Yelle). MSC 2020. Exactly ONE `\begin{theorem}`; everything else
  Proposition/Observation/Remark.
- No forbidden words (`clearly`, `obviously`, `easy to see`, `straightforward`, `we solve`,
  `revolutionary`, `structural barrier` — the title and body say "obstructions" / "approaches
  that do not transfer", never "structural barrier"). No claim of solving PCP (§1 states this
  explicitly). cite↔bibitem bijection: 19↔19, all real.
- Modest title; the framing is explicitly delimitative ("which elementary mechanisms cannot,
  by their geometry alone, contribute to a finiteness statement").

## 7. Bottom line (tell-it-straight)

Several Tier-3 items ARE internal-only, exactly as warned: **P9 and P11 refute nothing in the
literature** (they correct the project's own dead-ends / are strawmen if framed as refutations),
**P14 is an ingredient**, and **P12's headline ("no absolute c") is non-effective-Lang folklore.**
The salvageable core is the descent-impossibility theorem (P10) supported by the explicit
geometry (P13) and the multiplicative-height observation (P12) — assembled as one honest
structural-obstructions note. It is publishable as a short delimitative note (a "why elementary
methods stall" companion to Peschmann/Yelle), NOT as a research breakthrough.


---

**SUPERSEDED 2026-05-26: folded into paper-b as a Structural Obstructions section.**

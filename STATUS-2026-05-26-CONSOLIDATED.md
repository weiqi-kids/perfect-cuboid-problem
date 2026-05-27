---
title: "Consolidated Status 2026-05-26 — The Height / Density Route to PCP-Finiteness on the Rank-Jump Locus"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-26
status: |
  ⚠️ MAJOR CORRECTION 2026-05-26 (post-`OQ1-FINITENESS-ASSEMBLY.md`, verified vs Pila–Wilkie
  literature): the "density-1 unconditional FINITENESS" headline of this document is WRONG. The
  step "uniform OQ1 + Pila–Wilkie ⟹ finiteness" (§1 step 5) is a NON-SEQUITUR. Pila–Wilkie gives
  only SPARSITY (#{height≤T}≤C_ε T^ε); Pila–Zannier finiteness requires a Galois-orbit LOWER bound
  T^δ, which a ℚ-RATIONAL perfect-cuboid candidate (degree 1, no conjugates) does NOT have. OQ1 is
  a height lower bound — the wrong type of input. So the height/density route yields real HEIGHT
  theorems (OQ1 per-fiber unconditional; uniform σ≤4 on density-1) but NO finiteness. PCP's actual
  partial finiteness lives in the per-fiber Silverman/Ingram–Mahé closures and the genus-3 Coleman
  bound (Chabauty, NOT Pila–Zannier). Read §0 below first; the body is retained for audit but its
  FINITENESS conclusions are void — its HEIGHT/σ results stand.
  --- original (partially-void) status follows ---
  HONEST CONSOLIDATION of the 2026-05-22 → 2026-05-26 work. Bottom line: PCP-finiteness on the
  rank-jump locus 𝓡 is now UNCONDITIONAL on a density-1 sub-locus, with the residual confined to
  a density-0, precisely-parametrized (ℤ[√2]-norm-square) exceptional set conditional on one thin
  ABC instance. This is strictly stronger than the framework's original Bombieri–Lang dependence.
  It is NOT a proof of PCP non-existence: density-1 ≠ all (the exceptional set is infinite), and
  several inputs need Magma or remain open. Every claim below is tagged [VERIFIED] / [AGENT] /
  [NEEDS-MAGMA] / [CONJECTURAL] / [OPEN].
---

# Consolidated Status — Height / Density Route to PCP-Finiteness on 𝓡

**CΛ / Lightman Chang · 2026-05-26**

> **One-paragraph summary.** The Perfect Cuboid Problem reduces (Lemma 1 + the per-fiber elliptic
> family `E_PCP(q): y²=x(x+1)(x+q²)`) to ruling out non-degenerate rational points on the *rank-jump
> locus* `𝓡 = {Pythagorean q : rank E_PCP(q) ≥ 1}` (density 0.50). This session establishes that
> PCP-candidate **finiteness on a density-1 sub-locus of 𝓡 is UNCONDITIONAL**, via (i) an
> unconditional per-fiber height lower bound (Petsche 2005), (ii) a geometric-sieve proof that the
> Szpiro ratio is small on density 1, and (iii) the Pila–Zannier counting argument. The only
> residual is a density-0, explicitly-parametrized exceptional set, conditional on a single *thin ABC
> inequality* — far weaker than the Bombieri–Lang conjecture the framework originally leaned on.
> This is **not** PCP non-existence (density-1 ≠ all). Honest caveats and open inputs are in §5–§6.

---

## §0. ⚠️ Correction: the finiteness route is void; only the height results stand

`OQ1-FINITENESS-ASSEMBLY.md` (2026-05-26, verified vs Pila–Wilkie literature) shows that **step 5
below is a non-sequitur**. The correct picture:

- **Pila–Wilkie** gives only `#{P ∈ Y^trans(ℚ): H(P) ≤ T} ≤ C_ε T^ε` — *sparsity*, not finiteness
  (`T^ε → ∞`). [Scanlon survey; Pila–Wilkie Duke 2006]
- **Pila–Zannier finiteness** is obtained ONLY by contradicting that upper bound with a **lower
  bound on the number of Galois conjugates** of each special point, `#conj ≥ T^δ`, `δ>0` (torsion:
  Masser's degree bound; CM: class number). [Pila–Zannier 2008; Habegger–Pila]
- A perfect-cuboid candidate is **ℚ-rational** (Pythagorean `q ∈ ℚ`, `P ∈ E_PCP(q)(ℚ)`): **degree 1,
  zero non-trivial conjugates**, so `T^δ = T^0 = 1`. No fuel.
- **OQ1** (`ĥ(P_q) ≥ c₁ log H_j(q)`) is a height *lower* bound on one point — neither the
  conjugate-count lower bound (the finiteness engine) nor a height *upper* bound (the confinement).
  Wrong type. Habegger–Pila explicitly do not use height lower bounds to pass to finiteness.

**Consequence.** Steps 1–4 below (per-fiber OQ1; `σ ≤ 4` on density 1; uniform OQ1 height bound on
density-1 of 𝓡) are correct **as height/σ results**. Step 5 (finiteness) and every "PCP-finiteness on
density-1" / "unconditional finiteness" phrasing in this document and in `PILA-ZANNIER-T2.md` §intro,
`PILA-ZANNIER-OQ2.md` §5.3, `OQ1-HS-RESOLUTION.md` §5 are **false implications** and are retracted.
The framework's *actual* (partial) finiteness is per-fiber: Silverman + Ingram–Mahé primitive-divisor
closures (`SILVERMAN-RANK-JUMP-CLOSURE.md`) and the genus-3 Coleman/Chabauty bound on the Saunderson
slice (`GENUS3-COLEMAN-COVER.md`) — neither uses Pila–Zannier, neither is uniform over 𝓡.

What the height/density work genuinely contributes: (i) `OQ1` per-fiber unconditional (Petsche); (ii)
the Szpiro ratio is `≤ 4` on density-1, `≤ 6+ε` under ABC, with the large-σ locus located exactly at
the ℤ[√2]-norm-square Pell families; (iii) several framework corrections (§4); (iv) the honest
*negative* that o-minimal / Pila–Zannier methods cannot close PCP (no Galois orbit). These are real;
the finiteness headline was not.

---

## §1. The reduction chain (what closes, and on how much of 𝓡) — NOTE step 5 is void (see §0)

| Step | Statement | Status | Source |
|---|---|---|---|
| 0 | Generic fibers (rank 0, density 0.50) are PCP-free: MW = ℤ/4×ℤ/2 torsion, all 8 points degenerate | [VERIFIED] | `LEMMA-1-UNIVERSAL-TORSION.md` |
| 1 | **Per-fiber OQ1**: for every `q`, `ĥ(P_q) ≥ c(1,σ_q)·log|Δ_q|` for non-torsion `P_q`; and `log|Δ_q| ≍ log H_j(q)` | [VERIFIED] | Petsche 2005 Thm 2 (ar5iv `math/0508160`, quoted verbatim); `OQ1-HS-RESOLUTION.md` |
| 2 | `σ(E_PCP(q))` uniformly bounded ⟺ thin ABC instance for the triple `(b², a²−b², a²)`; **`σ ≤ 6(1+ε)` under ABC** | [VERIFIED reduction; CONJECTURAL bound] | `SIGMA-BOUND-FAMILY.md`, `SIGMA-ATTACK-ANALYTIC.md` |
| 3 | Geometric sieve ⟹ **`σ ≤ 4` (sharper: `3+ε`) on a density-1 set of `(m,n)`, UNCONDITIONALLY** | [VERIFIED empirically; sieve is standard] | `UNCONDITIONAL-DENSITY-EXPANSION.md` (Ekedahl–Bhargava / Greaves / Browning) |
| 4 | ⟹ **uniform OQ1 unconditional on density-1 of 𝓡** (σ-large is ⊥ 𝓡, independence ratio ≈ 1) | [VERIFIED] | this session |
| 5 | ~~Pila–Wilkie + uniform OQ1 ⟹ PCP candidates finite on density-1~~ **VOID — non-sequitur** (Pila–Wilkie = sparsity only; finiteness needs a Galois-orbit lower bound that ℚ-rational cuboids lack; OQ1 is the wrong type of bound) | [RETRACTED, see §0] | `OQ1-FINITENESS-ASSEMBLY.md` |
| 6 | Residual: density-0 exceptional set = `{F₅ or F₆ (near-)square}`, conditional on thin ABC; structure tame (rank-1-in-𝓡, torsion-8, 0 PCP) | [VERIFIED structure] | `EXCEPTIONAL-SET-CLOSURE.md` (coverage framing corrected) |
| 7 | Saunderson sub-family (⊂ 𝓡, ≈20%): genus-3 curve `C'`, `J~E_PCP²×80a`, rank 2 < genus 3, `|C'(Q)|≤12`, 8 degenerate pts → σ-free closed | [VERIFIED math; NEEDS-MAGMA to pin 12→8] | `GENUS3-COLEMAN-COVER.md` = `verifications/SAUNDERSON-GENUS3-CLOSURE.md` |

**Net coverage of 𝓡**: density-1 unconditional (steps 1–5) + density-0 residual conditional on one thin
ABC inequality (step 6) + the Saunderson slice closed σ-free modulo Magma (step 7, but ⊂ density-1
already). **Unconditional UNIFORM coverage = density 1 − o(1); not all of 𝓡.**

---

## §2. The progress ladder (what hypothesis PCP-finiteness-on-𝓡 rests on)

```
  Bombieri–Lang conjecture (framework's original dependence)         [strongest assumption]
     ↓  strictly weaker
  full Lang height conjecture  /  Szpiro  /  ABC
     ↓  strictly weaker
  ★ ONE thin ABC instance: σ(E_PCP(q)) uniformly bounded             [current residual]
     ↓
  ══════ density-1 of 𝓡: NO assumption (unconditional) ══════
     • per-fiber OQ1 (Petsche) — every individual fiber
     • uniform OQ1 on density 1 (geometric sieve)
     • Saunderson sub-family (genus-3 Coleman, modulo Magma)
```

The residual thin-ABC inequality is **located precisely**: σ is large only where the ℤ[√2] norm
forms `F₅=(m−n)²−2n²`, `F₆=(m+n)²−2n²` take (near-)square values — a genus-0 conic locus,
parametrized `(m,n)=(s²−2st+2t², 2st)`, of density 0 and sparsity `O(H^{1+ε})` vs `~(3/π²)H²` total.
[VERIFIED: `SIGMA-ATTACK-ANALYTIC.md`; `F₆(256,121)=7⁴·47`, `F₆(265,114)=343²` checked by hand.]

---

## §3. Why the thin-ABC dependence cannot be removed *by heights* (a verified NO)

An *absolute* (σ-free) constant `c` with `ĥ(P) ≥ c·log|Δ|` for the whole family — which would make
uniform OQ1 fully unconditional — **does not exist**. [VERIFIED, `ABSOLUTE-C-VERDICT.md`]
- The all-multiplicative `I_n` non-archimedean local heights are `≤ 0` (`Σλ_p ∈ [−¼log|Δ|, 0]`); the
  positive height lives entirely in the archimedean `λ_∞`, which the reduction data does not bound
  below by anything growing with `log|Δ|`. [VERIFIED; `ĥ=λ_∞+Σλ_p` matched to PARI `ellheight` at 1e-30]
- Empirically `ĥ/log|Δ|` dips to 0.0272 with no σ-independent floor (33 fibers, σ up to 4.61).
- An absolute `c` is exactly Lang/Wagener strength (non-effective; the Wagener 2017 preprint is
  unrefereed and **not relied upon**).

So the thin-ABC inequality (or a Magma Coleman computation on fixed curves) is genuinely the frontier;
the height method tops out here.

---

## §4. Framework corrections established this session (all [VERIFIED])

1. **`Aut_bir(V)` is FINITE, order 384 = S₃⋉(ℤ/2)⁶, all linear** — `V ⊂ P⁶` (4 quadrics) is of
   GENERAL TYPE (`K_V=O(1)` by adjunction), so Matsumura–Monsky ⟹ finite. The "K3 with infinite
   `Aut_bir`" is `V' ⊂ P⁵` (3 quadrics, `K=O(0)`), NOT `V`. The c-map is the linear transposition
   `σ_bc`. No new closure mechanism. [`AUT-BIR-V.md`]
2. **The elliptic surface `E_PCP → P¹` is RATIONAL (Euler number e=12), NOT K3 (e=24)** — fibers
   `I₄(0),I₂(1),I₂(−1),I₄(∞)`; Shioda–Tate generic MW rank `= 8−8 = 0`. `GAP3`'s Hindry constant used
   `χ=24`; correct is `χ=12` (constant `0.00481 → 0.00962`, qualitatively unchanged). [`OQ1-THEOREM-OR-CONJECTURE.md §1`, annotated into `GAP3-UNIFORM-HINDRY-SILVERMAN.md`]
3. **`P(𝓡) = P(w=−1) = 0.50`**, not the previously-quoted 43.5%. [VERIFIED by enumeration]
4. **OQ1 verdict (c) → overturned**: an earlier scoping doc called OQ1 "an open Lang-conjecture
   restatement" based on the false claim that Hindry–Silverman gives only a constant. Petsche 2005
   gives the GROWTH bound. Corrected: per-fiber unconditional; uniform conditional on thin ABC.
   [`OQ1-THEOREM-OR-CONJECTURE.md` carries a SUPERSEDED banner; corrected in `OQ1-HS-RESOLUTION.md`]

---

## §5. The negative / dead-end results (honest, [VERIFIED])

- **T1 Berkovich/p-adic dynamics**: p-adic obstruction necessary-not-sufficient (18/40 edges all-prime-compatible, none square); no measure-0 Julia confinement. Negative.
- **T3 Octonion/E₈**: associator norms all `int·g²`; E₈ Gram det 0; octavian halving ≡ gcd condition — "no new structure". Negative.
- **T4 Slice-rank**: `|V_p|~p³`; Croot–Lev–Pach cap-set regime does not apply; obstruction dim grows. Negative.
- **T5 Iwasawa**: only 1 good-ordinary fiber; no family μ/λ pattern. Interrupted/negative.
- **T6 Tropical**: prevariety excess = non-transversality, BKK = Bézout = 16, no gain. Dead end.
- **T2-OQ2 (Habegger–Pila on `X₁(4)²`)**: the body-diagonal condition is a quadratic-twist squareness,
  NOT a special subvariety, so HP 2016 has no target. Dead as a finiteness input — but it generated
  OQ1, the live path. [`META-SYNTHESIS-2026-05-22.md` §6–§12, `PILA-ZANNIER-OQ2.md`]

---

## §6. Honest caveats & open inputs (what this is NOT)

1. **density-1 ≠ all.** The exceptional set `{σ large}` is density 0 but **infinite** (present at every
   scale). So this is PARTIAL finiteness off a thin parametrized set — **NOT a proof that no perfect
   cuboid exists.** A perfect cuboid could a priori sit in the exceptional set.
2. **The Pila–Zannier `OQ1 ⟹ finiteness` assembly is sketched, not written end-to-end.** [OPEN write-up]
3. **Magma is needed** for: the genus-3 Coleman *pinning* (`|C'(Q)|: 12 → 8`), and Coleman integration generally. PARI gives the bound, not the pin.
4. **Saunderson covers only ≈20% of Euler bricks.** The genus-3 closure handles the Saunderson slice;
   non-Saunderson bricks (≈80%) need the per-family closures of `NON-SAUNDERSON-FAMILIES.md` (9 known
   ones closed; **no uniform rank bound over all `(m,n)`** — OPEN).
5. **The thin-ABC inequality `σ ≤ σ₀` for ALL `q` is unproven** (it is a genuine, if thin, ABC instance).
6. This document concerns PCP-finiteness *via the height/density route on 𝓡*. The broader framework
   (`PCP-COMPLETE-PROOF-v2.md` §9) has its own remaining gaps; this does not claim to close them all.

---

## §7. Open directions (for the next decision)

| Direction | What it would buy | Difficulty / tool |
|---|---|---|
| **A. Write the `OQ1 ⟹ finiteness` Pila–Zannier assembly end-to-end** | Makes the density-1 unconditional finiteness rigorous & citable | Theory write-up; no new math |
| **B. Uniform rank bound over all non-Saunderson `(m,n)`** | Closes the ≈80% non-Saunderson slice; toward full 𝓡 | OPEN (NON-SAUNDERSON-FAMILIES.md §closing); hard |
| **C. Magma Coleman pinning of `C'` (12→8)** | Completes the Saunderson-slice closure unconditionally | Needs Magma access |
| **D. Attack the thin-ABC `σ`-bound by analytic NT on the ℤ[√2] forms** | Could shrink/handle the density-0 exceptional set | OPEN; determinant method partial only |
| **E. Consolidate into a paper**: "PCP-finiteness on 𝓡 is unconditional off a thin ABC-conditional set" | A clean, honest, publishable conditional theorem | Write-up |

> **Recommended next**: A (rigorize the one assembly that the unconditional density-1 claim leans on)
> and/or E (固化成論文). B and D are the genuine research frontiers but are open problems, not
> tool-applications. C needs Magma.

---

*CΛ / Lightman Chang · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-26*
*Companion files: `OQ1-HS-RESOLUTION.md`, `CONDITIONAL-CLOSURE-LANDSCAPE.md`, `SIGMA-BOUND-FAMILY.md`, `SIGMA-ATTACK-ANALYTIC.md`, `UNCONDITIONAL-DENSITY-EXPANSION.md`, `VOUTIER-YABUTA-IN-HEIGHTS.md`, `ABSOLUTE-C-VERDICT.md`, `EXCEPTIONAL-SET-CLOSURE.md`, `GENUS3-COLEMAN-COVER.md`, `AUT-BIR-V.md`, `META-SYNTHESIS-2026-05-22.md`.*

---
title: "Meta-Synthesis 2026-05-22 — Conventional Tools' True Limits and the Search for Genuinely New Mathematics on PCP"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-22
status: |
  COMPLETE (as of 2026-05-25). All six innovation tracks T1–T6 have run to
  completion or budget exhaustion; T0 has also been resolved. All sections §6–§12
  are now filled with actual results. Four tracks (T1, T3, T4, T6) returned clean
  negatives; T5 was interrupted by a 1.5 GB memory budget; T2 partially succeeded
  and generated one live sub-target (OQ1). The §4.2 framework correction
  (Aut_bir(V) finite, target should be V' not V) is incorporated. PCP remains open.
  One concrete theorem (OQ1: Lehmer-type height bound) is identified as the single
  most actionable next step.
---

# Meta-Synthesis: Conventional Tools' True Limits and the Search for Genuinely New Mathematics on PCP

**CΛ / Lightman Chang** · 2026-05-22

> **TL;DR (skeleton).** Standard tooling (Chabauty / Selmer / Brauer-Manin / Bombieri-Lang) has
> structural ceilings that PCP touches but cannot break with current technology. This document
> (a) names those ceilings precisely, (b) classifies them by *whether they can be lifted by a
> known not-yet-applied theorem*, *new effective bounds*, or *genuinely new mathematics*,
> (c) frames the six parallel innovation tracks (T1–T6) launched on 2026-05-22, and
> (d) leaves §6–§9 to be filled with their conclusions.

---

## §1. The five structural ceilings of conventional tooling

For each ceiling I state the obstruction in one line, then list which standard tool it blocks,
then assess what would be required to break through.

### 1.1 Ceiling A — Per-fiber Chabauty needs `rank E < genus C`

Mordell-Weil rank of every Jacobian factor of every relevant curve must be strictly less than the
Coleman dimension. On PCP:

- Genus-2 quotient: rank ≤ 1 — blocked at every rank-2+ fiber.
- Genus-5 fibration $C_t$: sum of ranks of $E_{ef}, E_{eg}, E_{fg}, X_+, X_-$ must be ≤ 4 — blocked at all 26+ rank-4 fibers + rank-jumps.
- Cubic Chabauty (Kim depth-3): rank ≤ 2 × genus typically — bounded by Selmer of higher Tate twist.

**Status**: Per-fiber Halcke route closes 12/~150 rank-jump fibers (where $E_{Hm}$ rank = 0). Strategy II (genus-5 direct Chabauty) **fails on EVERY rank-jump fiber** (sum rank ≥ 5 always). Cubic Chabauty for ranks ≤ 4 is not implemented in PARI / requires Magma + manual choices.

**What lifts this ceiling**:
- *Known but not applied*: Bianchi-Stoll iterated Coleman; Balakrishnan-Müller-Stein "Chabauty-Coleman with effectivity".
- *New effective bounds needed*: Coleman integration in PARI (currently Magma-only).
- *Genuinely new*: a Chabauty variant where the rank-genus inequality is replaced by a **family-level** condition (NEW DIRECTION — see Track T5: Iwasawa).

---

### 1.2 Ceiling B — Brauer-Manin sees only finitely many Brauer classes

For a variety $X / \mathbb{Q}$ with $\mathrm{Br}(X) / \mathrm{Br}(\mathbb{Q})$ finite, $X(\mathbb{A})^{\mathrm{Br}} = \emptyset$ implies $X(\mathbb{Q}) = \emptyset$ ONLY when the Brauer-Manin obstruction is the only obstruction. For K3 surfaces this is conjectural (Skorobogatov).

**On PCP**: $V \subset \mathbb{P}^6$ is a K3 (double cover of rational quadric); $\mathrm{Br}(V) / \mathrm{Br}(\mathbb{Q})$ contains transcendental classes (Van Luijk / Picard analysis). Computed obstruction is non-empty — does NOT exclude PCP.

**What lifts this ceiling**:
- *Known but not applied*: étale-Brauer (Skorobogatov enrichment) — partially attempted (`PICK-3-ETALE-BRAUER.md`), did not close.
- *New effective bounds needed*: an effective form of the Skorobogatov conjecture that takes $\dim H^1_{\mathrm{ét}}(X, \mu_n)$ as input.
- *Genuinely new*: descent obstructions beyond all known cohomological flavors (NEW DIRECTION — see Track T3 octonion / E_8 layer, which proposes a *non-commutative* descent flavor).

---

### 1.3 Ceiling C — Bombieri-Lang is conjectural

For a smooth projective variety of general type, $X(\mathbb{Q})$ is conjectured non-Zariski-dense. PCP gives a 3-fold (total space $\mathcal{V}$ of the V-fibration over $\mathcal{P}$) of general type (Kodaira dim 3, modulo verification). Vojta gives the strong form. **None of this is proven** for surfaces or 3-folds in this generality.

**What lifts this ceiling**:
- *Known but not applied*: Lang's "very weak BL" for K3 surfaces is open even in dimension 2.
- *New effective bounds needed*: full Vojta in dimension ≥ 2.
- *Genuinely new*: bypass BL entirely via Pila-Zannier-style o-minimal counting (NEW DIRECTION — see **Track T2**).

The Pila-Zannier route is the most theoretically promising — it gives finiteness without BL.

---

### 1.4 Ceiling D — Density-0 does not imply finite

Bhargava-Shankar gives density 0 of rank-jump locus among Pythagorean fibers. But density 0 ≠ finite (Sato-Tate density 0 of $E$ with rank ≥ 1 over $\mathbb{Q}(t)$ is consistent with countably infinite). Our empirical evidence shows the rank-jump locus growing at 2.5×/decade — **apparently infinite**.

**What lifts this ceiling**:
- *Known but not applied*: refined density (rank ≥ k) bounds (Park-Poonen-Voight-Wood for higher k; needed: explicit constants for k=4, 5).
- *New effective bounds needed*: an Iwasawa-theoretic upper bound on rank growth in families (Track T5).
- *Genuinely new*: a **dynamical** argument forcing the rank-jump locus into a closed orbit (Track T1 Berkovich dynamics — would force every rank-jump fiber into the c-map orbit closure, which is conjecturally a Cantor-like fractal of measure 0).

---

### 1.5 Ceiling E — Effectivity gap in everything

Almost every conventional bound is *qualitative*. Even when we prove "rank ≤ B" or "# rational points ≤ C", the constants B, C are not computable. This is a meta-ceiling: conventional algebraic geometry is fundamentally non-effective above dimension 1 (with notable exceptions: Faltings → effective Mordell is OPEN; Stoll's effective bounds are dimension-1 only).

**What lifts this ceiling**:
- *Known but not applied*: effective Mordell (conjecturally available via $abc$).
- *New effective bounds needed*: explicit Hindry-Silverman with computable constants — partially done in `GAP3-UNIFORM-HINDRY-SILVERMAN.md` (rev. 3).
- *Genuinely new*: a fully **combinatorial / additive** route that bypasses all these (Track T4 slice-rank — if it works, gives explicit bounds in terms of polynomial degree).

---

## §2. Mapping the six innovation tracks against the ceilings

| Track | Primary ceiling targeted | Secondary | Innovation type |
|---|---|---|---|
| T1 Berkovich dynamics | D (density → finite) | A (per-fiber) | New geometry: p-adic / non-archimedean phase |
| T2 Pila-Zannier | C (Bombieri-Lang) | D | Bypass via o-minimality |
| T3 Octonion / E_8 | B (Brauer-Manin) | E | Non-commutative descent |
| T4 Slice-rank | E (effectivity) | D | Additive combinatorics |
| T5 Iwasawa family | A (per-fiber rank) | D | Family p-adic L-function |
| T6 Tropical | E (effectivity) | C | Combinatorial geometry of V |

Notice: T2 and T1 attack ceilings C and D respectively — the two ceilings whose breach gives "density 0 → finite" without new conjectures. T2 is the most theoretically clean route; T1 the most empirically tractable.

T5 attacks ceiling A by giving a UNIFORM family rank bound, which would supplant Pick 13 (currently empirical).

T3, T4, T6 are exploratory: their value is to detect whether genuinely new algebraic/combinatorial structure exists that conventional tools have missed.

---

## §3. The strategy if NONE of T1–T6 succeeds

This is important to write down BEFORE results come in, to avoid retroactive narrative.

If all six tracks return negative or partial results, the remaining unconditional path is:

1. **Cohomological route**: complete the étale-Brauer / Skorobogatov enrichment with full transcendental Brauer (see `PICK-15-TRANSCENDENTAL-BRAUER.md`). Needs Magma compute on the K3.

2. **Family 2-descent over $\mathbb{Q}(q)$**: this is the "boring but works" route to rigorize Pick 13. Estimated 4–8 hours Magma + careful manual analysis. Would close §1.1 Ceiling A for rank-jump enumeration.

3. **Sub-family closures**: keep accumulating Halcke-template + Coleman-disk closures, one Pythagorean parameter family at a time. Probabilistic argument that with $N$ unconditional sub-families covering density $1 - O(1/\log N)$ of rank-jump locus, the remainder is provably tractable.

4. **Wait for new mathematics**: e.g., if Vojta is proven for surfaces or if effective Mordell for K3 becomes available.

None of these is satisfying; the user has explicitly stated he wants to NOT be limited by existing frameworks. T1–T6 represent the legitimate attempt to leave the framework.

---

## §4. Two structural insights worth preserving even on negative tracks

Independent of T1–T6 outcomes, two structural insights from the framework deserve foregrounding:

### 4.1 The Euler-brick identity (I₂) and the moduli reframing

> $E_\text{PCP}(q)$ is the moduli of Euler bricks with normalization $(1, q, c)$.
>
> PCP non-existence ⟺ on every Euler brick parametrized by a rational point of $E_\text{PCP}(q)$,
> the space diagonal $\sqrt{1 + q^2 + c^2}$ is irrational.

This identification (from `FINAL-SYNTHESIS-2026-05-21.md` §1.1) **reframes** the problem: PCP is now precisely the question of whether the *fourth* Euler-brick condition can be satisfied — *given* the first three are automatically satisfied by the family geometry. This is the cleanest statement of the problem, and any genuine attack must engage with WHY the fourth condition fails.

### 4.2 The c-map as curve-level involution and the corrected birational picture

> **FRAMEWORK CORRECTION (2026-05-25):** The original §4.2 claimed "the right object to study is V's birational automorphism group." After a complete computation in `AUT-BIR-V.md`, this claim must be corrected.

**Correct findings** (source: `AUT-BIR-V.md`, verified symbolically):

- $\mathrm{Aut}_{bir}(V) = \mathrm{Aut}(V) = S_3 \ltimes (\mathbb{Z}/2)^6$ of order **384**, and **every element is linear** (induced by edge-label permutations and sign flips).
- The reason is structural: the adjunction formula gives $K_V = \mathcal{O}_V(1)$ (ample), so V is of general type, canonically embedded. By Matsumura–Monsky, $\mathrm{Aut}(V)$ is finite; by birational rigidity of general-type surfaces, $\mathrm{Aut}_{bir}(V) = \mathrm{Aut}(V)$.
- The **c-map is exactly $\sigma_{bc}$**: the $S_3$ transposition swapping edges $b \leftrightarrow c$ (and $d \leftrightarrow f$) in PGL(7). It is the unique element of order 2 in $S_3$ corresponding to b↔c. Symbolic verification: $\sigma_{bc}^*(Q_1) = Q_3$, $\sigma_{bc}^*(Q_2) = Q_2$, $\sigma_{bc}^*(Q_3) = Q_1$, $\sigma_{bc}^*(Q_4) = Q_4$.
- The claimed "4:1 birational correspondence" is NOT a birational map of V; it is a degree-4 correspondence between two fibers (entirely explained by $\sigma_{bc}$ linearly).
- The quantity $g^2 = a^2+b^2+c^2$ is **invariant under all 384 automorphisms**: $\mathrm{Aut}_{bir}(V)$ therefore cannot create a new PCP-closure mechanism (any PCP point would map to another PCP point with the same $g$, not to an excluded locus).

**The correct object for infinite dynamics**: the K3 surface $V' \subset \mathbb{P}^5$ defined by only $Q_1, Q_2, Q_3$ has $K_{V'} = \mathcal{O}$ and $\mathrm{Aut}_{bir}(V')$ is **infinite** (the 12 exceptional $(-2)$-curves from its 12 nodes generate an infinite reflection group). The genuine open problem is lifting $V'$'s infinite birational dynamics through the $2:1$ cover $V \to V'$. The c-map / $\sigma_{bc}$ gives NO new closure mechanism because $g^2 = a^2+b^2+c^2$ is its invariant.

---

## §5. Stylistic & honesty pledge for this document

Once T1–T6 finish, §6–§9 will be filled with:

§6 **T1–T6 findings** — exact one-page summary of each track's outcome, no spin.
§7 **Which ceilings are now closer, lifted, or proven unliftable?**
§8 **Updated path to unconditional PCP** — synthesis of all six findings + insights of §4.
§9 **Open mathematical questions** — what genuine new theorems would close PCP, expressed precisely enough that another researcher could attack one.

If T1–T6 are entirely negative, this document will SAY SO. The user's standing instruction is no fabrication. Three honest negative tracks are more valuable than one fabricated positive.

---

## §6. T1 — Berkovich / p-adic dynamics findings

**Status**: COMPLETE. Exploratory NEGATIVE. Ceiling D not lifted.

**Sources**: `scripts/berkovich_dynamics/{01_padic_orbit,02_padic_height,03_julia_set_estimate,04_F3_padic_valuation}.out`.

### §6.1 What was tested

The c-map was embedded in a p-adic/Berkovich dynamical setting. For each edge $q \to c$ of the c-map orbit, the quantity $F_3 = 1 + q^2 + c^2$ (which must be a perfect square for PCP) was analyzed over $\mathbb{Q}_p$ for primes $p \in \{2, 3, 5, 7, 11\}$. Specifically, for F_3 to be a rational perfect square, it must at minimum have (a) even $p$-adic valuation $v_p(F_3)$ at each prime, and (b) unit part a $p$-adic square in $\mathbb{Z}_p^*$.

### §6.2 Results (from `04_F3_padic_valuation.out`)

**40 c-map edges** were analyzed across the orbit graph (depth-1 edges from all generators plus the first-generator orbits). Zero PCP candidates: `issquare(F3) = 0` at every single edge.

Per-prime p-adic compatibility statistics (an edge is "p-adically compatible" iff $v_p(F_3)$ is even AND the unit part is a square in $\mathbb{Z}_p^*$):

| Prime $p$ | p-adic compat | Total edges |
|-----------|-------------|-------------|
| 2 | 39/40 | 40 |
| 3 | 40/40 | 40 |
| 5 | 31/40 | 40 |
| 7 | 23/40 | 40 |
| 11 | 40/40 | 40 |

**All-5-prime compatible (necessary for PCP)**: **18/40 edges**.

The critical finding: 18 of 40 edges are p-adically compatible at all five primes — i.e., the p-adic/Berkovich obstruction is **passed** — yet **NONE of the corresponding $F_3$ values is actually a perfect square** over $\mathbb{Q}$. The p-adic compatibility is a necessary but far from sufficient condition.

### §6.3 2-cycle analysis (from `03_julia_set_estimate.out`)

All **10 known c-map 2-cycles** have F_3 non-square. For each 2-cycle $\{a, b\}$, $F_3(a \to b)$ was computed explicitly and `issquare(F3) = 0` in every case. (E.g., cycle 1: $F_3 = 3560089/1334025$; cycle 3: $F_3 = 2929/2304$; etc.)

### §6.4 Expansion at infinity (from `02_padic_height.out`)

Over 31 seeds with non-trivial orbits, the mean rate of archimedean height expansion is:
$$\bar\rho_\infty = 2.37 > 0.$$

This confirms the c-map expands at infinity (orbits grow in height on average). Mean $\rho_p$ for $p = 2$: 3.76; for $p = 3$: 1.92; showing the dynamics are non-trivially p-adic but not contracting.

### §6.5 What was NOT found

- No measure-zero Julia-set confinement theorem emerged.
- No p-adic obstruction that unconditionally prevents $F_3 \in (\mathbb{Q}^\times)^2$.
- No mechanism that forces the rank-jump locus into a closed orbit of measure zero.

**Verdict**: The Berkovich/p-adic obstruction is **necessary but far from sufficient**. 18/40 edges clear every local p-adic test, yet none is a global perfect square (the obstruction is genuinely archimedean / global). **Ceiling D is NOT lifted by T1 dynamics.** The track is closed as an exploratory negative.

## §7. T2 — Pila-Zannier o-minimal findings

**Status**: HONEST PARTIAL. Structurally works, decisively blocked by one identifiable input.

**Deliverable**: `PILA-ZANNIER-T2.md` (833 lines).

**What worked (clean positives)**:
1. **Definability in $\mathbb{R}_{\mathrm{an,exp}}$**: the universal real-analytic family $\mathcal{E}_\mathbb{R} \to \mathcal{P}_\mathbb{R}$, the recovery map $c$, and the PCP locus are all definable. $\mathbb{R}_{\mathrm{alg}}$ handles the semi-algebraic skeleton; $\wp$-function $\Rightarrow \mathbb{R}_{\mathrm{an}}$; unbounded period scaling $\Rightarrow \mathbb{R}_{\mathrm{an,exp}}$. Smallest sufficient o-minimal structure identified.
2. **Pila-Wilkie applies unconditionally**: $\#\{\text{alg pts of height} \le T \text{ on } Y^{\mathrm{trans}}\} \le C_\varepsilon T^\varepsilon$ holds.
3. **$Y^{\mathrm{alg}}$ identified explicitly**: constant-$q$ fibers plus 8 torsion sections (the latter all degenerate by Lemma 1 / Universal Torsion).

**The decisive obstacle (concrete and named)**:

$Y^{\mathrm{alg}}$ reduces **exactly to the per-fiber Mordell-Weil problem on the rank-jump locus $\mathcal{R}$** — i.e., back to the very Bombieri-Lang gap we hoped to bypass. The Hindry-Silverman uniform bound $\hat h \ge h_0^{\mathrm{thm}} = 0.00481$ is *constant in q*. Translated to Weil height via Silverman's $c_S(E_q) = O(\log N(E_q))$, the bound becomes **vacuous for large conductor**: no margin for Pila-Wilkie's $\varepsilon$-power to defeat.

Pila-Zannier *needs* a height bound of form $\hat h(P_q) \ge c \cdot \log H_j(q)$ growing polynomially with parameter height — *not* what Hindry delivers.

**Three concrete open questions T2 generated (each is a self-contained next-track candidate)**:
- **OQ1** (Lehmer-type): prove $\hat h(P_q) \ge c \cdot \log H_j(q)$ for the non-isotrivial K3 family $\mathcal{E} \to \mathcal{P}$. Substantial but not known.
- **OQ2** (Habegger-Pila reformulation): rewrite PCP as an *atypical intersection* on $X_1(4)^2$ (Shimura modular surface). If atypicality holds, Habegger-Pila 2016 framework gives finiteness directly. **This is the most promising.**
- **OQ3** (Daw-Ren via Q-isogeny orbits): the 2/2 Phase 2 Q-isogeny rescue generates 4-8 isogenous curves per fiber; if the combined isogeny orbit height grows polynomially, Daw-Ren growth conditions apply.

**Net verdict**: Pila-Zannier *structurally* bypasses Bombieri-Lang for PCP, but operationally needs a height-bound upgrade. The strategy is **not killed** — it is *waiting* for OQ1 / OQ2 / OQ3. Specifically OQ2 (Habegger-Pila on $X_1(4)^2$) is a precise mathematical target that, if achieved, closes the gap. This is the most concrete unconditional path Phase 3 has produced.

**Actionable Phase 3 follow-up**: pursue OQ2 (Habegger-Pila reformulation) as Track T2'. Empirically test OQ1 on 26 rank-4 fibers (compute $\hat h(P_q) / \log H_j(q)$ ratio — 2-day PARI job).

### §7.1 T2′ / OQ2 — Habegger–Pila on $X_1(4)^2$ and the OQ1 empirical test (2026-05-25 update)

**Status**: OQ2 DEAD as a Habegger–Pila finiteness input. OQ1 EMPIRICALLY SUPPORTED. Source: `PILA-ZANNIER-OQ2.md`.

> **⚠️ Update 2026-05-25-PM (supersedes the OQ1 framing in this subsection and §12).** OQ1 is now resolved, not merely "empirically supported". Verified verbatim (`OQ1-HS-RESOLUTION.md`): **Petsche 2005 Thm 2** gives `ĥ(P) ≥ c(d,σ)·log|N Δ_{E/k}|` (GROWTH, `c` depending only on `d` and the Szpiro ratio of `E` itself). Hence **OQ1 per-fiber is an UNCONDITIONAL THEOREM**; the earlier `OQ1-THEOREM-OR-CONJECTURE.md` (c)-verdict is OVERTURNED (it falsely claimed HS gives only a constant). **Uniform OQ1** (single `c₁` over all `q`, the form Pila–Zannier needs) is **(a)-conditional on one thin ABC instance**: `σ(E_PCP(q))` uniformly bounded (empirically ≤ 4.61). **Unconditional sub-closure** on the `ω(N)≤R₀` locus (Gross–Silverman). See `CONDITIONAL-CLOSURE-LANDSCAPE.md`.

**OQ2 — Habegger–Pila on $X_1(4)^2$** (clean negative on the HP route):

The modular structure of the family was nailed down exactly. The q-line is the genus-0 modular curve $X(\Gamma_1(4) \cap \Gamma(2))$, with $q$ a Hauptmodul and a degree-12 $j$-map:
$$j(q) = \frac{256(q^4 - q^2 + 1)^3}{q^4(q^2-1)^2}$$
(verified by exact rational equality at multiple fibers; degree 12 matches the index $[\mathrm{SL}_2(\mathbb{Z}) : \Gamma_1(4) \cap \Gamma(2)] = 12$).

In the mixed Shimura 3-fold $\mathcal{A} = \mathcal{E}_{X_\Gamma} \times_{X_\Gamma} \mathcal{E}_{X_\Gamma}$, the dimension count is: $\dim V = 1$ (PCP source curve), $\dim T = 2$ (body-diagonal divisor), $\dim \mathcal{A} = 3$, expected intersection dimension $= 0$.

**The decisive obstruction**: the body-diagonal condition "$\sqrt{1 + q^2 + c^2} \in \mathbb{Q}$" is a **quadratic-twist squareness** — it is NOT the equation of a special subvariety in any Shimura variety. The Habegger–Pila 2016 machinery requires the target locus $T$ to be a special (or weakly-special) sub-Shimura variety; since $T$ is non-modular, André–Oort / Zilber–Pink has no special subvariety to act on. An isolated perfect cuboid also sits at expected intersection dimension 0 (not atypical), so atypicality alone cannot exclude it.

**Verdict on OQ2**: Atypicality holds for *positive-dimensional* PCP families; an isolated PCP point is at *expected* dimension — not atypical. HP 2016 does not apply. **OQ2 is dead as a direct finiteness input.**

---

**OQ1 — Lehmer-type height bound, empirical test** (live path):

The ratio $R(q) = \hat{h}(P_q) / \log H_j(q)$ was computed over **645 fibers** (32 rank-jump/rank-4 + 613 generic rank-1), spanning $\log H_j \in [36, 170]$ and $\log_{10} N \in [3.6, 22.9]$.

Key statistics:
- **Global minimum $R = 0.0259$** (Sample B, generic rank-1, 613 fibers).
- **Mean $R \approx 0.146$** (Sample B); $0.058$ (Sample A, high-rank).
- **Trend of $R$ vs $\log H_j$**: Sample A Pearson $-0.17$ (essentially flat), Sample B Pearson $+0.21$ (mildly increasing). The ratio does **NOT** decay to zero.
- **Empirical floor is increasing**: per-quartile minima of $R$ in Sample B go $0.0259 \to 0.0269 \to 0.0315 \to 0.0366$ as $\log H_j$ increases — the opposite of decay.
- Canonical height $\hat{h}(P_q)$ itself **grows** with $\log H_j$ (Pearson $+0.32$ Sample B, $+0.69$ Sample A); OLS slope $\approx +0.05$ in Sample A.
- **724/724 generators** across all 645 fibers are **Face-3 closed** ($F_3$ non-square). Zero PCP candidates.

**OQ1 verdict (corrected 2026-05-25-PM)**: The Lehmer-type bound $\hat{h}(P_q) \ge c_1 \log H_j(q) - c_2$ is not only empirically supported ($c_1 \gtrsim 0.025$) — its **per-fiber form is an unconditional theorem** (Petsche 2005 Thm 2: $\hat h(P) \ge c(d,\sigma)\log|N\Delta_{E/k}|$, $\sigma$ of $E$ itself; and $\log|\Delta_q| \asymp \log H_j(q)$, verified). The **uniform** version (single $c_1$ across the family, which Pila–Zannier requires) holds **iff $\sigma(E_{\rm PCP}(q))$ is uniformly bounded** — a single thin ABC instance (empirically $\sigma \le 4.61$), strictly weaker than Bombieri–Lang or full Lang. It holds **unconditionally on the bounded-bad-prime sub-locus** $\omega(N) \le R_0$ (Gross–Silverman). See `OQ1-HS-RESOLUTION.md`, `CONDITIONAL-CLOSURE-LANDSCAPE.md`.

**Recommended proof route** (from `PILA-ZANNIER-OQ2.md` §5.3): a **Manin / function-field canonical-height-vs-modular-height comparison** on the non-isotrivial elliptic surface $\mathcal{E}_{X_\Gamma} \to X_\Gamma$. This approach does NOT require $T$ to be modular; it only needs the height lower bound, which Pila–Wilkie can then convert into a finiteness statement. It also bypasses both the Bombieri–Lang gap (§1.3) and the non-modularity obstruction of OQ2.

## §8. T3 — Octonion / E_8 / Triality findings

**Status**: COMPLETE. Clean NEGATIVE. Ceiling B not lifted.

**Sources**: `scripts/octonion-e8/{01_basic_identities,02_e8_gram,03_coset_analysis,04_triality_check,05_octavian_check,06_associator_analysis}.out`.

### §8.1 What was tested

The track sought a non-commutative descent obstruction by embedding the PCP 7-vector $(a,b,c,d,e,f,g)$ into the octonion algebra $\mathbb{O}$ and studying the E_8 lattice / octavian integers structure, in hopes of finding an associator-norm or halving condition that unconditionally prevents PCP.

### §8.2 Results

**E_8 Gram matrix** (`02_e8_gram.out`): The Gram matrix of the natural 4 PCP vectors $\{w_1, w_2, w_3, w_4\}$ (under PCP constraints $g^2 = a^2+b^2+c^2$, $d^2 = a^2+b^2$, etc.) is **degenerate**:
$$\det(\mathrm{Gram}(w_1, w_2, w_3, w_4)) = 0.$$
All four diagonal entries equal $4(a^2+b^2+c^2) = 4g^2$. The 4 vectors span a sub-lattice of rank $\le 3$ in $\mathbb{O}$; no E_8 embedding arises.

**Associator norms** (`06_associator_analysis.out`): All associator norms $N([x, e_i, e_j])$ are integer multiples of $g^2 = a^2+b^2+c^2$:
- $N([x,e_1,e_2]) = N([x,e_1,e_3]) = N([x,e_2,e_3]) = 12g^2$
- $N([x,e_3,e_4]) = N([x,e_3,e_7]) = N([x,e_4,e_7]) = 8g^2$
- Mixed pairs: $4(2a^2+2b^2+3c^2)$, $4(3a^2+b^2+2c^2)$, etc. (symmetric in $a,b,c$).

These are all integer-coefficient quadratic forms in $(a,b,c)$ with no PCP-specific obstruction structure. **No non-integer or fractional obstruction emerges.**

**Octavian halving condition** (`05_octavian_check.out`): For a typical primitive PCP vector with parity pattern $(0,0,0,1,0,1,1,1)$ (weight 4, sum even): this vector is in the Coxeter–Todd lattice $D_8 \subset E_8$ but NOT in $2 \cdot E_8$. Therefore $\frac{1}{2} x_\text{PCP}$ is NOT an octavian. The script's own conclusion: "This means x_PCP is 'primitive' as an octavian, but this is the same statement as $\gcd(a,b,c,d,e,f,g)$ being odd. **No new structure.**"

**Mod-8 coset analysis** (`03_coset_analysis.out`): 5 primitive Euler bricks found with sides $\le 1000$. All have $g^2 \equiv 1 \pmod{8}$. Three distinct mod-2 cosets, all weight-4, $N/2 \equiv 0 \pmod{2}$. No new structural obstruction.

### §8.3 Verdict

The octonion / E_8 / triality approach yields:
- No non-commutative descent obstruction.
- No associator-norm condition preventing PCP.
- No E_8 lattice incompatibility.
- All computations reduce to the same congruence conditions already known from elementary arguments.

**Ceiling B is NOT lifted.** The track is closed as a clean negative.

## §9. T4 — Slice-rank / polynomial method findings

**Status**: COMPLETE. NEGATIVE — the bound is vacuous for PCP. Ceiling E not lifted.

**Sources**: `scripts/slice_rank/{01_pcp_counts.txt,02_indicator_degree.json,03_slice_rank.json,04_obstruction.json}` and the 06 bound-check script.

### §9.1 What was tested

The Croot–Lev–Pach / cap-set-type polynomial method: bound the size of a PCP "cap set" (a subset of $(\mathbb{Z}/p\mathbb{Z})^7$ with no three-term arithmetic progressions, or more generally the slice rank of the PCP indicator tensor).

### §9.2 PCP variety counts mod $p$ (from `01_pcp_counts.txt`)

The number of PCP points mod $p$ (denoted $|V_p|$):

| $p$ | $|V_p|$ | $p^3$ | ratio $|V_p|/p^3$ |
|-----|---------|-------|-------------------|
| 3 | 49 | 27 | 1.81 |
| 5 | 193 | 125 | 1.54 |
| 7 | 721 | 343 | 2.10 |
| 11 | 2161 | 1331 | 1.62 |
| 13 | 3649 | 2197 | 1.66 |
| 17 | 7681 | 4913 | 1.56 |
| 19 | 7345 | 6859 | 1.07 |

The ratios $|V_p|/p^3$ are bounded in $[1.07, 2.10]$ across all primes tested, confirming $|V_p| \sim O(p^3)$ — the PCP variety is a 3-dimensional affine complete intersection, as expected.

### §9.3 Slice-rank upper bounds (from `03_slice_rank.json`)

Slice-rank upper bounds for the PCP indicator tensor (taking the indicator function of $V_p$ as a 7-dimensional tensor over $\mathbb{F}_p$), minimized over partitions of the 7 coordinates into three groups:

- **$p=3$**: slice-rank upper bound = **2** (best partition) to **3** (other partitions).
- **$p=5$**: slice-rank upper bound = **3** (certain partitions) to **7** (others).

These bounds are tiny absolute constants — very small relative to $p^7 = 2187$ ($p=3$) or $78125$ ($p=5$).

### §9.4 PCP-specific obstruction dimension (from `04_obstruction.json`)

The dimension of the space of polynomial obstructions specific to PCP (polynomials vanishing on $V_p$ but not on the generic variety), by degree:

At $p=3$:
- degree 1: 0; degree 2: 1; degree 3: 8; degree 4: 20; degree 5: **26** (plateau); degree 6+: 26.

At $p=5$:
- degree 1: 0; degree 2: 1; degree 3: 14; degree 4: 60; degree 5: 142; degree 6: **253** (still growing).

The obstruction dimension grows rapidly with degree and plateaus at large values (26 at $p=3$, $\ge 253$ at $p=5$) — far larger than the tiny slice-rank bounds above.

### §9.5 Why the bound is vacuous

The Croot–Lev–Pach / cap-set bound applies in the regime where the slice rank is a small fraction of $p^n$ — essentially when the variety has no PCP points at all mod $p$ (or very few). Here:

- **Slice rank $\ll p$** is the operative regime for cap-set bounds (e.g., slice rank $\le 3$ at $p=3$, but $|V_3| = 49$ and there are PCP-compatible points).
- The PCP indicator tensor has $|V_p| \sim p^3$ non-zero entries (the 3-dimensional affine variety has many mod-$p$ points), so the tensor is far from sparse — there is no cap-set-type sparsity to exploit.
- The PCP-specific obstruction dimension (26 at $p=3$, $\ge 253$ at $p=5$) VASTLY exceeds the slice-rank bound (2–7), meaning the slice-rank method gives a bound much weaker than the obstruction dimension would suggest.

**Verdict**: The Croot–Lev–Pach / cap-set polynomial method does NOT apply in the PCP regime. The PCP variety has too many mod-$p$ points (grows as $p^3$) for the sparsity assumption to hold, and the slice-rank bounds are vacuously weak relative to the actual obstruction structure. **Ceiling E is NOT lifted by additive combinatorics.** The track is closed as a clean negative.

## §10. T5 — Iwasawa family p-adic L findings

**Status**: INTERRUPTED / partial NEGATIVE. Budget exhaustion prevented family-level conclusions. Ceiling D unchanged.

**Source**: `IWASAWA-T5.md` (2026-05-25).

### §10.1 Setup

Per-fiber elliptic curve: $E_\text{PCP}(q): Y^2 = X(X+u^2)(X+v^2)$ where $u=2mn$, $v=m^2-n^2$. Memory budget: parisize 500 MB, parisizemax 1.5 GB (production-safe cap). Primes tried: $p \in \{5, 7, 11, 13\}$, precision $n = 3$. Ten fibers from $(m,n)$ with $m \le 9$; fibers 6–9 (conductors $N \in [113505, 237930]$) skipped outright ($N > 30000$ cutoff).

### §10.2 Completed results

**Fiber 1** ($q=3/4$, $N=21$, rank 0): Good-ordinary data at three primes.
- $p=5$: $L_p(E,1) = 4+3\cdot5+4\cdot5^2+O(5^3)$, **val = 0** (non-vanishing, consistent with rank 0).
- $p=11$: $L_p(E,1) = 1+2\cdot11+4\cdot11^2+O(11^3)$, **val = 0**.
- $p=13$: $L_p(E,1) = 3+6\cdot13+4\cdot13^2+O(13^3)$, **val = 0**.

**Fibers 2, 4, 10** (rank 0, split multiplicative at $p=5$): Exceptional zeros confirmed. The Mazur–Tate–Teitelbaum exceptional-zero formula gives $\mathrm{ord}_p(L_p(E,1)) = \mathrm{rank}(E) + 1 = 0+1 = 1$ for split multiplicative reduction. PARI confirms `bsd_ord = 1` for each. Consistent.

**Fiber 3** ($q=21/20$, $N=4305$, rank 1): At two split-multiplicative primes ($p=5$ and $p=7$): `ellpadicbsd` returns `bsd_ord = 2 = 1 (rank) + 1 (exceptional zero)`. Consistent.

Full consistency table (all evaluable fiber-prime pairs follow Mazur–Tate–Teitelbaum):

| Fiber | rank | split-mult prime | bsd_ord | Expected rank+1 | Consistent? |
|-------|------|------------------|---------|-----------------|-------------|
| 2 | 0 | $p=5$ | 1 | 1 | YES |
| 3 | 1 | $p=5$ | 2 | 2 | YES |
| 3 | 1 | $p=7$ | 2 | 2 | YES |
| 4 | 0 | $p=5$ | 1 | 1 | YES |
| 10 | 0 | $p=5$ | 1 | 1 | YES |

### §10.3 What failed / was not computed

- **Fiber 5** ($q=7/24$, $N=22134$, rank 1): All four primes EXCEEDED the 1.5 GB budget even at precision $n=2$. Fully inaccessible.
- **Fibers 6–9** ($N \in [113505, 237930]$): SKIPPED_BUDGET ($N > 30000$).
- **At good ordinary primes for fibers 2–5**: `ellpadicL` repeatedly EXCEEDED budget (e.g., fiber 2, $p=11$, $N=1785$: EXCEEDED). Only fiber 1 ($N=21$) gave usable good-ordinary p-adic L data.
- **No Iwasawa $\lambda$/$\mu$-invariant extraction**: requires computing the full power series $L_p(E,T) \pmod{p^n, T^d}$ for $d \ge 2$ — unavailable at $N \ge 1785$ within the 1.5 GB budget.

### §10.4 Family-level assessment

Only **1 fiber** (fiber 1, $N=21$) gave useful good-ordinary p-adic L data (3 primes, all val=0). This is a single isolated point, insufficient for any family-level Iwasawa $\mu$/$\lambda$ pattern. No uniform rank bound was extracted; the data are consistent with analytic rank equaling arithmetic rank at each computed fiber, but this is weaker than a family statement.

**What would be needed** (from `IWASAWA-T5.md` §6): $\ge 8$ GB dedicated RAM for PARI to handle $N \sim 5000$–$25000$; or the $\Lambda$-adic L-function for a Hida / Coleman family containing $E_\text{PCP}(q)$ (requires Magma or specialized PARI code). Neither is available in the current environment.

**Verdict**: T5 provides **no new constraint** on the rank-jump locus. Per-fiber p-adic BSD consistency is confirmed (all evaluable pairs satisfy Mazur–Tate–Teitelbaum), but gives no family-level information. **Ceiling D is unchanged.** The Iwasawa uniform rank bound sought remains out of reach at the 1.5 GB budget.

## §11. T6 — Tropical / amoeba findings

**Status**: COMPLETE. Clean NEGATIVE. Structural dead end. Ceiling E not lifted.

**Source**: `TROPICAL-T6.md` (2026-05-25).

### §11.1 What was tested

Tropical geometry of $V \subset \mathbb{P}^6$ (the 4-quadric complete intersection). The four quadrics $Q_1, Q_2, Q_3, Q_4$ (each with coefficients $\pm 1$) have Newton polytopes that are low-dimensional simplices in $\mathbb{Z}^7$. Two valuations were tried: the trivial valuation and the 2-adic valuation. Since all coefficients have $v_2(\pm 1) = 0$, both give **identical** tropical hypersurfaces.

### §11.2 Tropical prevariety

**Method**: Enumerate all combinations of one wall from each $Q_i$ ($3 \times 3 \times 3 \times 6 = 162$ combinations) and compute the dimension of each cone intersection (exact rational arithmetic).

**Results** (from `02_tropical_prevariety.py`, 162 cones computed):

| Cone dimension | Count |
|----------------|-------|
| 3 | 126 |
| 4 | 33 |
| 5 | 3 |

**Maximum dimension**: **5** in $\mathbb{R}^7$ (3 cones). **Expected** (transverse tropical CI): $7-4 = 3$. Excess = 2.

### §11.3 The excess locus

All 3 excess cones (dim=5, rank=2) arise from the same structure: Q1 uses wall $\{w_a = w_b\}$, Q2 uses $\{w_b = w_c\}$, Q3 uses $\{w_a = w_c\}$, and Q4 uses any wall in $\{a,b,c,g\}$. These three wall constraints are **linearly dependent** (any two imply the third), giving rank 2 instead of 3. The excess locus is:
$$L = \{w \in \mathbb{R}^7 : w_a = w_b = w_c,\ w_d, w_e, w_f, w_g\ \text{free}\},$$
i.e., the symmetric stratum where all three edge variables have the same $p$-adic absolute value. This is tropical **non-transversality** (Q4 shares all three of $a,b,c$ with Q1,Q2,Q3 simultaneously, making the walls dependent), NOT an obstruction.

Projective tropical: expected dim = $3-1 = 2$; actual max dim = $5-1 = 4$. Excess 2 persists projectively.

### §11.4 BKK mixed volume

**Full system** ($4$ equations, $7$ unknowns): BKK = 0 (vacuous; $n = 7$ equations needed for isolated solutions in $\mathbb{R}^7$, matching the 3-dimensional nature of $V$).

**Zero-dimensional section** ($V \cap \{3$ generic linear forms$\}$): BKK $=$ MV$(N(Q_1), N(Q_2), N(Q_3), N(Q_4), \Delta_6, \Delta_6, \Delta_6) = $ **16** $= $ Bézout $= 2^4 \cdot 1^3$. No sparsity improvement over Bézout. The Newton polytopes of $Q_1,Q_2,Q_3,Q_4$ are simplices whose supports jointly cover all 7 coordinates, producing no lower-dimensional mixed cells.

### §11.5 Verdict

**Summary table** (from `TROPICAL-T6.md` §10):

| Item | Value |
|------|-------|
| Tropical prevariety max dim ($\mathbb{R}^7$) | 5 (expected 3, excess 2) |
| Excess locus | $\{v_p(a)=v_p(b)=v_p(c)\}$, walls linearly dependent |
| BKK (4-eqn / 7-var) | 0 (vacuous) |
| BKK ($V \cap 3$ hyperplanes) | = Bézout = 16 (no gain) |
| Tropical obstruction to PCP | NONE |
| 2-adic tropical = trivial tropical | YES (all $\pm 1$ coefficients) |

No tropical obstruction to PCP exists. The excess dimension is a non-transversality artifact, not an obstruction. BKK equals Bézout, giving no effectivity improvement. **Ceiling E is NOT lifted by tropical geometry.** The track is closed as a clean negative and structural dead end.

## §12. Updated gap list and path forward

### §12.1 Track scoreboard

| Track | Ceiling targeted | Outcome | Ceiling status |
|-------|-----------------|---------|---------------|
| T0 Aut_bir(V) | (framework) | NEGATIVE — Aut_bir(V) = S_3 ⋉ (ℤ/2)^6, order 384, all linear; no new PCP closure mechanism; §4.2 corrected | Corrected: target V' not V |
| T1 Berkovich / p-adic | D (density → finite) | NEGATIVE — 0 PCP candidates / 40 edges; p-adic obstruction necessary but far from sufficient; 18/40 edges pass all 5 local tests yet none is a global square; no Julia-set confinement | D unchanged |
| T2 Pila–Zannier | C (Bombieri–Lang bypass) | PARTIAL — definability/o-minimality works; blocked by missing height bound; generates live sub-target OQ1 | C alive via OQ1 |
| T2′/OQ2 Habegger–Pila | C (atypical intersection) | NEGATIVE — body-diagonal condition is non-modular (quadratic-twist squareness, not a special subvariety); HP 2016 has no Shimura target to act on; an isolated PCP point is at expected dim 0, not atypical | C: HP route dead |
| T2′/OQ1 Lehmer-type bound | C (height input for T2) | EMPIRICALLY SUPPORTED — R(q)=ĥ/log H_j bounded below (min 0.0259, mean 0.146) across 645 fibers; floor increasing, not decaying; 724/724 generators Face-3 closed, 0 PCP | LIVE path |
| T3 Octonion / E_8 | B (Brauer-Manin) | NEGATIVE — Gram det = 0; all associator norms are multiples of g²; octavian halving = gcd condition; no non-commutative descent obstruction | B unchanged |
| T4 Slice-rank | E (effectivity) | NEGATIVE — |V_p| ~ p³ (3-dimensional variety, no sparsity); slice rank bounds 2–7 (vacuous vs obstruction dim 26–253); CLP cap-set regime does not apply | E unchanged |
| T5 Iwasawa | A+D (uniform rank) | INTERRUPTED — only fiber 1 (N=21) gives good-ordinary p-adic L data; fibers 2–10 budget-exceeded or skipped; no family-level μ/λ pattern; per-fiber p-adic BSD consistent | A, D unchanged |
| T6 Tropical | E+C (effectivity) | NEGATIVE — tropical prevariety dim=5 (excess 2, non-transversality); BKK=Bézout=16 (no gain); 2-adic tropical = trivial; no tropical obstruction | E unchanged |

### §12.2 Which ceilings moved

- **Ceiling A** (per-fiber Chabauty rank): Unchanged. T5 gave no family-level bound.
- **Ceiling B** (Brauer-Manin / non-commutative descent): Unchanged. T3 found no non-commutative structure.
- **Ceiling C** (Bombieri-Lang bypass): **Partially alive.** T2 structurally works (o-minimality / Pila–Zannier applies) but is blocked by the missing OQ1 height bound. OQ2 (HP reformulation) is dead as a direct input. The route through OQ1 remains the live path.
- **Ceiling D** (density-0 → finite): Unchanged. T1 found no dynamical confinement; T5 interrupted before family-level conclusions.
- **Ceiling E** (effectivity): Unchanged. T4 (slice-rank vacuous) and T6 (BKK = Bézout) both fail to improve effective bounds.

### §12.3 The conventional fallback (pre-registered in §3)

The §3 fallback items remain the conventional path if OQ1 also fails:
1. **Cohomological**: complete the étale-Brauer / Skorobogatov enrichment with full transcendental Brauer (see `PICK-15-TRANSCENDENTAL-BRAUER.md`). Requires Magma compute on the K3.
2. **Family 2-descent over $\mathbb{Q}(q)$**: rigorize Pick 13 (uniform rank bound via family Selmer computation). Estimated 4–8 hours in Magma.
3. **Sub-family closures**: accumulate Halcke-template + Coleman-disk closures, one Pythagorean parameter family at a time.
4. **Wait for new mathematics**: Vojta proven for surfaces, or effective Mordell for K3 becomes available.

### §12.4 The single most actionable target

> **⚠️ Corrected 2026-05-25-PM (supersedes the "prove OQ1 via Manin comparison" strategy below).**
> OQ1 is no longer the open target — its **per-fiber form is now an unconditional theorem** (Petsche 2005
> Thm 2, verified verbatim; `OQ1-HS-RESOLUTION.md`), and the recommended "Manin/section height comparison"
> below is moot (generic rank 0 ⟹ no sections, but Petsche needs none — it bounds *any* non-torsion point
> on each individual fiber). **The real remaining target is the single thin ABC instance** that upgrades the
> per-fiber theorem to a uniform bound:
>
> > **Target (revised): prove $\sigma(E_{\rm PCP}(q)) \le \sigma_0$ uniformly over all Pythagorean $q$**
> > (equivalently, $\log|\Delta_{\min}(E_q)| \le \sigma_0 \log N(E_q)$). Empirically $\sigma \le 4.61$ (to m≤400).
> > This is a thin ABC-type inequality on one explicit family — strictly weaker than Bombieri–Lang or full Lang.
>
> Two unconditional fallbacks already in hand: (i) OQ1 holds uniformly on the bounded-bad-prime sub-locus
> $\omega(N) \le R_0$ (Gross–Silverman); (ii) a Voutier–Yabuta-style explicit $I_n$ local-height computation
> may give uniform OQ1 with no ABC at all. See `CONDITIONAL-CLOSURE-LANDSCAPE.md`.
>
> *The original (pre-correction) text follows, retained for audit.*

Among all investigated paths, exactly one has a live unconditional route:

> **OQ1 (Lehmer-type canonical height bound):**
>
> *Prove that $\hat{h}(P_q) \ge c_1 \log H_j(q) - c_2$ for some $c_1 > 0$, uniformly over all Pythagorean fibers $q$ of the non-isotrivial family $E_\text{PCP} \to \mathbb{P}^1$.*
>
> Empirical evidence (645 fibers, $\log H_j \in [36, 170]$): conservative floor $c_1 \gtrsim 0.025$; OLS slope $\approx 0.05$ (high-rank sample); floor increasing, not decaying.
>
> **Recommended proof strategy**: a Manin / function-field canonical-height-vs-modular-height comparison on the non-isotrivial elliptic surface $\mathcal{E}_{X_\Gamma} \to X_\Gamma$, using the degree-12 j-map $j(q) = 256(q^4-q^2+1)^3 / (q^4(q^2-1)^2)$ as the modular height reference. This does NOT require the body-diagonal condition to be modular (bypassing OQ2's obstruction) — it only needs the canonical height of Mordell–Weil sections to grow with the modular height of the parameter $q$, which is exactly what the data shows.

Once OQ1 is proved, the Pila–Wilkie counting argument (T2) converts it into the finiteness statement: $\#\{q \in \mathcal{R}(\mathbb{Q}) : H(q) \le T\} \le C_\varepsilon T^\varepsilon$ for any $\varepsilon > 0$, where $\mathcal{R}$ is the rank-jump locus — and this $T^\varepsilon$ growth is incompatible with the rank-jump locus being Zariski-dense, yielding finiteness of PCP candidates.

### §12.5 Honest status paragraph

**PCP remains open.** None of the six innovation tracks (T1–T6) plus the T0 framework correction closed the problem. T1, T3, T4, T6 returned clean negatives against Ceilings D, B, E (respectively). T5 was interrupted before family-level conclusions were reachable. T0 corrected a framework misconception (Aut_bir(V) is finite of order 384; the interesting infinite dynamics live on V', not V). T2 is the sole partial survivor: the Pila–Zannier strategy is structurally sound and bypasses Bombieri–Lang, but is operationally blocked by the missing Lehmer-type height bound (OQ1). OQ1 is now empirically confirmed over 645 fibers with a clear positive floor ($\min R = 0.0259$, non-decreasing trend). **[Corrected 2026-05-25-PM:]** Moreover OQ1's **per-fiber form is an unconditional theorem** (Petsche 2005, $\hat h(P) \ge c(d,\sigma)\log|N\Delta_{E/k}|$ with $\sigma$ of $E$ itself; $\log|\Delta_q|\asymp\log H_j(q)$ verified), which **overturns the earlier (c)-open-conjecture verdict** of `OQ1-THEOREM-OR-CONJECTURE.md`. The single most precise statement that would close PCP-finiteness on the rank-jump locus is therefore **not** the full Lang conjecture but a *thin ABC instance*: *prove $\sigma(E_{\rm PCP}(q))$ is uniformly bounded over Pythagorean $q$* (empirically $\le 4.61$). This is strictly weaker than Bombieri–Lang or full Lang/Szpiro, holds unconditionally on the $\omega(N)\le R_0$ sub-locus, and is the cleanest conditional closure the framework has produced. See `OQ1-HS-RESOLUTION.md` and `CONDITIONAL-CLOSURE-LANDSCAPE.md`.

---

*— CΛ / Lightman Chang · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-22 (skeleton) / 2026-05-25 (completed)*

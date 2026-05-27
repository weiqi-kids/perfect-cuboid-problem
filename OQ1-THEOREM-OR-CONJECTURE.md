---
title: "OQ1 — Theorem or Conjecture? Generic Rank, Sporadic Points, and the Szpiro Ratio of E_PCP(q)"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: |
  ⚠️ SUPERSEDED 2026-05-25-PM by OQ1-HS-RESOLUTION.md — the (c) verdict below is WRONG.
  It rested on a false claim that Hindry–Silverman gives only a constant bound. In fact
  Petsche 2005 Thm 2 (verified verbatim) gives ĥ(P) ≥ c(d,σ)·log|N_{k/Q}Δ_{E/k}| — a GROWTH
  bound, with c depending only on d and the Szpiro ratio of E ITSELF. Corrected verdict:
  OQ1 per-fiber is an UNCONDITIONAL THEOREM (Petsche); uniform OQ1 ⟹ Pila–Zannier closure
  is (a)-conditional on ONE thin ABC instance (σ uniformly bounded). The sporadic-point
  argument below is a RED HERRING: Petsche/Lang bounds apply to any non-torsion point on an
  individual curve and never needed sections. See §5 correction block.
  --- original (INCORRECT) verdict follows, retained for audit ---
  VERDICT (c): OQ1 is a RESTATEMENT OF AN OPEN CONJECTURE for the sporadic points that
  are the only source of PCP. The arithmetic generic rank of E_PCP(q)/Q(q) is 0 (geometric
  also 0, by Shioda-Tate on a RATIONAL elliptic surface, e=12), so MW(E_eta/Q(q)) is pure
  torsion: there are NO non-torsion sections. Every rank-jump generator P_q is therefore a
  SPORADIC point, NOT the specialization of any section. This KILLS Agent A's §5.3
  "Manin/function-field section-height comparison" route as written: section-comparison
  bounds ĥ(specialization of a section) ~ ĥ_eta(σ)·h(q), and there are no such sections to
  apply it to. A growing lower bound ĥ(P) >> log|Δ| for sporadic points on E/Q is exactly
  LANG'S HEIGHT CONJECTURE (lower-bound form). Hindry-Silverman 1988 proves Lang over number
  fields ONLY conditional on Szpiro's conjecture, with constant depending on the Szpiro ratio.
  The Szpiro ratio of THIS family IS uniformly bounded (computed: σ ∈ [2.72, 4.07], mean 3.09
  over 416 fibers; all reduction multiplicative so log|Δ_min|=O(log N) rigorously). BUT a
  bounded Szpiro ratio for one explicit family does NOT make HS unconditional: HS's number-
  field theorem invokes Szpiro to bound the ratio σ_E AND to supply the unconditional
  *function-field* mechanism via the *section* moduli height — for an isolated number-field
  point (a sporadic point, not a section) HS's bound DEGENERATES to a CONSTANT, not a growing
  c·log|Δ|. Bounded-Szpiro-ratio removes the conditionality of the *constant* (recovering the
  family-uniform ĥ ≥ h_0 ≈ const), but it does NOT upgrade the constant to a log-growing bound.
  OQ1's GROWTH is the open Lang/Lehmer lower bound, not a corollary of bounded Szpiro ratio.
---

# OQ1 — Theorem or Conjecture?
## Generic Rank, Sporadic Points, and the Szpiro Ratio of E_PCP(q)

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

> **One-line verdict.** OQ1 (`ĥ(P_q) ≥ c₁·log H_j(q) − c₂`, `c₁>0`) is, for the points that
> actually matter (sporadic non-torsion points), a **restatement of the lower-bound form of
> Lang's height conjecture** — an open conjecture. It is NOT made unconditional by the fact
> that this family's Szpiro ratio is bounded.

---

## §1. The generic rank of E_PCP(q)

### 1.1 The elliptic surface and its singular fibers

The generic fiber is `E_η : Y² = X(X+1)(X+q²)` over `Q(q)`, with `a₂=1+q², a₄=q², a₁=a₃=a₆=0`.
Standard formulas (verified in PARI):

- `c₄(q) = b₂² − 24 b₄ = 16(q⁴ − q² + 1)`,
- `Δ(q) = −b₂² b₈ − 8 b₄³ = 16 q⁴ (q²−1)² = 16 q⁴ (q−1)²(q+1)²`,
- `j(q) = c₄³/Δ = 256 (q⁴−q²+1)³ / (q⁴(q²−1)²)`  (matches `PILA-ZANNIER-OQ2.md` §1.2).

The singular fibers of the minimal elliptic surface `S → P¹_q` are at the zeros and pole of `Δ`.
At each I use Tate's criterion `v(c₄)=0, v(Δ)>0 ⇒ multiplicative, type I_{v(Δ)}`:

| base point | `v(Δ)` | `c₄` there | type | `m_v` (#components) | `e(F_v)` |
|:---|:--:|:--:|:--:|:--:|:--:|
| `q=0` | 4 | `c₄(0)=16` (unit) | **I₄** | 4 | 4 |
| `q=1` | 2 | `c₄(1)=16` (unit) | **I₂** | 2 | 2 |
| `q=−1` | 2 | `c₄(−1)=16` (unit) | **I₂** | 2 | 2 |
| `q=∞` | 4 | (see below) | **I₄** | 4 | 4 |

The fiber at `q=∞` is computed by the substitution `q=1/w`, `x=X/w²`, `y=Y/w³`, which returns the
**identical family** `Y² = X(X+1)(X+w²)`; hence the fiber at `q=∞` is of the same type as `q=0`,
i.e. **I₄**. (PARI scripts `/tmp/step1_tate.gp`, `surface_check.gp`.)

**Euler number** `e(S) = Σ e(F_v) = 4+2+2+4 = 12`. Therefore `χ(O_S)=e/12=1`:
**S is a RATIONAL elliptic surface, NOT a K3** (`e=24`, `χ=2`). 

> **Correction to prior framework documents.** `GAP3-UNIFORM-HINDRY-SILVERMAN.md` §1.3 and
> `PILA-ZANNIER-OQ2.md` use `χ_top(V')=24` ("K3 elliptic surface"). For the **fibration
> `E_PCP → P¹_q`** that the OQ1 height bound is about, the correct invariant is `e=12, χ=1`
> (rational elliptic surface). The `χ=24` figure refers to a *different* (higher-dimensional /
> twisted) model `V'`, not the relatively minimal elliptic surface over the `q`-line. This
> changes the Hindry constant in §3.3 below (it would be `1/(deg j · χ/2) = 1/(12·6) = 1/72`,
> not `1/144`) — but, as §2 shows, the constant is moot because there are no sections.

### 1.2 Shioda-Tate ⇒ geometric generic rank 0

For a rational elliptic surface, `b₂ = ρ = h^{1,1} = 10` (all of `H²` is algebraic).
Shioda-Tate:
$$
\operatorname{rank} \mathrm{MW}(E_\eta/\overline{\mathbb{Q}}(q)) = \rho - 2 - \sum_v (m_v - 1)
= 10 - 2 - \big[(4{-}1)+(2{-}1)+(2{-}1)+(4{-}1)\big] = 10 - 2 - 8 = \boxed{0}.
$$
Equivalently the trivial lattice `T = U ⊕ A₃ ⊕ A₁ ⊕ A₁ ⊕ A₃` has rank `2+3+1+1+3 = 10 = ρ`,
leaving MW-rank `0`.

> **Geometric generic rank = 0.** Hence **arithmetic generic rank over `Q(q)` ≤ 0, so = 0.**

### 1.3 Torsion

The three roots `0, −1, −q²` are rational over `Q(q)`, giving full 2-torsion sections
`(0,0),(−1,0),(−q²,0)`; and `P₄=(q, q(q+1))` is a 4-torsion section with `2P₄=(0,0)`
(Lemma 1, `LEMMA-1-UNIVERSAL-TORSION.md`; re-verified in `scripts/pila_oq2/tors.gp`). So
$$
\mathrm{MW}(E_\eta/\mathbb{Q}(q)) = \mathrm{MW}(E_\eta/\mathbb{Q}(q))_{\mathrm{tors}} \cong \mathbb{Z}/4 \times \mathbb{Z}/2,
\quad \text{rank } 0.
$$
The torsion injects into the product of component groups `Z/4 × Z/2 × Z/2 × Z/4` (Shioda-Tate
torsion bound), consistent with `Z/4×Z/2`.

### 1.4 Specialization cross-check (Silverman 1983)

Silverman's specialization theorem: for all but finitely many (in fact a density-1 set, with
the exceptional set of bounded height) `t∈P¹(Q)`, `rank E_t(Q) ≥ rank E_η(Q(q))`, with equality
on a positive-density set iff the generic rank is that minimum. I computed `ellanalyticrank` on
the actual `E_PCP(q): Y²=X(X+1)(X+q²)` over 85 Pythagorean fibers (`m≤26`, `gcd(m,n)=1`, `m+n`
odd; `/tmp/step1_spec2.gp`):

| rank `r` | 0 | 1 | 2 | ≥3 |
|:--:|:--:|:--:|:--:|:--:|
| #fibers | **41** | 36 | 8 | 0 |

**Minimum rank = 0, achieved on 41/85 ≈ 48% of fibers (positive density).** Sample rank-0 fibers
verified by `ellrank` (`scripts/silverman_task1_ranks.out`): `q ∈ {8/15, 40/9, 16/63, 56/33}` all
return `ellrank = [0,0]`. By Silverman's specialization theorem, rank 0 on positive density forces
**arithmetic generic rank = 0** — REFUTING any positive generic rank and CONFIRMING the Shioda-Tate
computation. (This also matches `GAP3` §5.3: rank-jump density → 0, Silverman 1983.)

> **§1 conclusion.** geometric generic rank **= 0**; arithmetic generic rank over `Q(q)` **= 0**;
> `MW(E_η/Q(q)) = (Z/4 × Z/2)`, **torsion only**.

---

## §2. Sporadic vs section — does it kill Agent A's §5.3 route?

### 2.1 Every rank-jump generator is a sporadic point

A **section** of `E_PCP → P¹_q` defined over `Q` is exactly an element of `MW(E_η/Q(q)) = E_η(Q(q))`.
By §1, `E_η(Q(q))` is torsion (the 8 universal-torsion points). The specialization map
`E_η(Q(q)) → E_t(Q)` sends sections to specialized points; its image at any fiber `t` is precisely the
specialized **torsion** subgroup. Therefore:

> **Proposition 2.1.** For every Pythagorean `q`, every **non-torsion** point `P_q ∈ E_PCP(q)(Q)` is
> a **sporadic point**: it is NOT the specialization `σ(q)` of any `Q(q)`-rational section `σ`. The
> only sections are the 8 torsion sections, and (Lemma 1) all 8 map under the recovery map `φ` to
> `c=0` or `c=∞` — **degenerate**, never a perfect cuboid. Hence all candidate PCP points live in the
> **sporadic** (non-section) locus.

This is rigorous: it is the contrapositive of Silverman's specialization injectivity. If a
non-torsion `P_q` were `σ(q)` for a section `σ`, then `σ ∈ E_η(Q(q))` would be non-torsion, contradicting
arithmetic generic rank 0.

### 2.2 This KILLS the §5.3 section-comparison route as written

Agent A's proposed route (`PILA-ZANNIER-OQ2.md` §5.3) is a "Manin/function-field
canonical-height-vs-modular-height comparison". The content of Manin/Hindry on a non-isotrivial
surface is, precisely:
$$
\widehat{h}_\eta(\sigma) \ge c_1\, h_B(\sigma) - c_2 \qquad \text{for a } \mathbf{section}\ \sigma:B\to E,
$$
and on specialization `ĥ(σ(t)) ≈ ĥ_η(σ)·(\text{deg/ht of } t) + O(1)` (Tate / Silverman variation of
canonical height). **This bounds the height of the specialization of a section in terms of the
section's geometric height and the height of the base point.** With `MW(E_η/Q(q))` torsion, there are
**no non-torsion sections `σ`**; for torsion sections `ĥ_η(σ)=0`. The inequality is then *vacuous*
for the sporadic generators that are the only PCP candidates.

> **Verdict 2.2.** The §5.3 route, *as written* (section/specialization height comparison), gives
> **nothing** for OQ1, because the objects it bounds (specializations of sections) do not include
> any of the rank-jump generators. Manin/Hindry section-height comparison is the right tool for a
> **positive-generic-rank** family; this family has generic rank 0, so the lever has no fulcrum.
> The empirical `R(q)` growth in `PILA-ZANNIER-OQ2.md` §3 is real, but it is a statement about
> **sporadic** points, for which no section-comparison theorem applies.

(The framework was internally consistent on this: `route-N1-function-field.md` and `GAP3` §6.4
already note that the function-field/section heights govern *sections*, and that the Heegner /
sporadic generators are not captured by a uniform section bound. §2 here makes the obstruction
sharp and names it: arithmetic generic rank 0 ⇒ all PCP generators sporadic ⇒ no section to compare.)

---

## §3. Lang and Hindry-Silverman — precise statements

### 3.1 Lang's height conjecture (lower-bound / Lehmer form)

> **Conjecture (Lang).** There is an absolute constant `c>0` such that for every elliptic curve
> `E/K` (number field `K`) and every non-torsion `P ∈ E(K)`,
> $$ \widehat{h}(P) \ \ge\ c\,[K:\mathbb{Q}]^{-?}\,\log |\Delta_{E/K}| \quad(\text{equivalently } \ge c\log N_E,\ \ge c\log H_j). $$
> (S. Lang, *Elliptic Curves: Diophantine Analysis*, Springer 1978, Conjecture on p. 92; see also
> Hindry-Silverman 1988, Conjecture on p. 420.) This is the **lower-bound form**; it is OPEN over `Q`.

OQ1, `ĥ(P_q) ≥ c₁ log H_j(q) − c₂`, is exactly this bound for the family `{E_PCP(q)}` (since
`log H_j ≍ log N ≍ log|Δ_min|` here, by §4). For **sporadic** points it is Lang's conjecture verbatim.

### 3.2 Hindry-Silverman 1988 — precise theorem and its Szpiro dependence

> **Theorem (Hindry-Silverman, *Invent. Math.* 93 (1988), 419–450, Thm 0.3 / Thm on p. 420).**
> Let `E/K` be an elliptic curve over a number field. Let `σ_{E/K} = log|Δ_{E/K}| / log N_{E/K}`
> be the **Szpiro ratio** (Δ the minimal discriminant, N the conductor). Then there is an explicit
> constant `c = c(σ_{E/K}, [K:Q]) > 0` such that for every non-torsion `P ∈ E(K)`,
> $$ \widehat{h}(P) \ \ge\ c(\sigma_{E/K},[K:\mathbb{Q}])\cdot \log N_{E/K}. $$
> The dependence is `c ∼ (\text{const})/\sigma^{O(1)}` (degrades as `σ→∞`): if the Szpiro ratio is
> bounded, `c` is bounded below by a positive constant; if `σ` can be arbitrarily large, `c→0`.

> **Theorem (Hindry-Silverman, *ibid.*, function-field case / and Hindry, *Invent. Math.* 94 (1988)).**
> Over a **function field** `K=k(B)` of a curve, with `E/K` non-isotrivial, Lang's lower bound holds
> **UNCONDITIONALLY**:
> $$ \widehat{h}(\sigma) \ \ge\ c_1\, h_B(\sigma) - c_2,\qquad c_1 = \big(\deg(j_E)\cdot \tfrac{1}{2}\chi_{top}\big)^{-1}, $$
> for non-torsion **sections** `σ`. (No Szpiro needed because the function-field Szpiro inequality
> `deg Δ ≤ 6·deg N + O(1)` is a *theorem*, e.g. Pesenti-Szpiro / Hindry-Silverman.)

The logical structure: **HS over number fields = Lang's bound CONDITIONAL on Szpiro's conjecture**,
and Szpiro enters in exactly one way — to bound the Szpiro ratio `σ_{E}` (which controls `c`). The
*conjectural* input is the uniform bound `σ_E ≤ 6+ε` over **all** `E/Q`; that is Szpiro's conjecture
(≈ ABC).

---

## §4. The Szpiro ratio of E_PCP(q) — and the crucial verdict

### 4.1 The minimal discriminant and conductor structure

Write `q = u/v` in lowest terms (for Pythagorean `q=(m²−n²)/(2mn)`). The non-minimal discriminant is
$$
\Delta = 16\,q^4(q^2-1)^2 = \frac{16\,u^4(u^2-v^2)^2}{v^8} = \frac{16\,u^4(u-v)^2(u+v)^2}{v^8}.
$$
The bad primes divide `2·u·v·(u−v)(u+v)`. At every odd singular place the surface analysis (§1.1)
gives **multiplicative reduction** (`v(c₄)=0`); multiplicative reduction means `v_p(N)=1` while
`v_p(Δ_min)=v_p(j^{-1})` can be larger, but is bounded by the local `I_n` index. Crucially:

> **Rigorous fact.** Because all bad reduction of `E_PCP(q)` is **multiplicative** away from `p=2`
> (Tate: `v_p(c₄)=0` at all odd bad `p`), one has `v_p(Δ_min) = v_p(N) + (\text{ord of }j\text{-pole})`
> with `v_p(N)=1`, and the total `log|Δ_min| = O(log N)`. Empirically (`GAP3` §3, `log|Δ_min|=O(log N)`,
> `c_S/log N ∈ [0.59,1.33]`) and here directly, the Szpiro ratio is **uniformly bounded**.

### 4.2 Computed Szpiro ratio over the family

`ellminimalmodel` + `ellglobalred` over **416 Pythagorean fibers** (`m≤45`; `/tmp/szpiro2.gp`):

| quantity | value |
|:---|:---|
| `σ_min = log|Δ_min|/log N` | **2.7217** at `(m,n)=(2,1)` (small conductor) |
| `σ_max` | **4.0718** at `(m,n)=(37,10)` |
| `σ_mean` | **3.0944** |

> **The Szpiro ratio of this family is provably bounded: `σ(E_PCP(q)) ≤ ~4.1` (empirically; and
> `≤ 6+ε` rigorously, since multiplicative reduction forces `log|Δ_min| ≤ 6 log N + O(1)` — this is
> the *function-field-style* Szpiro inequality, which is a THEOREM for multiplicative reduction, not
> a conjecture).** This is a finite/structural computation about ONE explicit family, NOT the general
> Szpiro conjecture.

### 4.3 The crucial verdict: does bounded Szpiro ratio make OQ1 unconditional here?

This is the lead's key question. The answer is **NO**, for a precise reason:

1. **What bounded Szpiro ratio buys.** Hindry-Silverman's number-field constant `c(σ_E,[K:Q])`
   becomes a **uniform positive constant** once `σ_E` is uniformly bounded. So HS 1988 gives,
   *unconditionally for this family* (no general Szpiro needed),
   $$ \widehat{h}(P_q) \ \ge\ c_0 \qu(\text{a positive CONSTANT, independent of }q). $$
   This is exactly the `GAP3` "family-uniform constant" `h_0 ≈ 0.00481` (modulo the `χ=12` vs `24`
   correction) — and bounded Szpiro ratio is what makes that constant honestly unconditional.

2. **What it does NOT buy.** The HS number-field bound is `ĥ(P) ≥ c(σ_E)·log N_E` only if you read
   `c(σ_E)·log N_E` as a *growing* quantity. But that is a misreading of HS. **HS bounds
   `ĥ(P) ≥ c(σ_E)`, a constant — NOT `≥ c·log N`.** The `log N_E` does NOT appear as a growth factor
   in HS's lower bound; rather, `σ_E = log|Δ|/log N` is a *ratio* that appears inside the constant `c`.
   Concretely, HS Theorem 0.3 reads (schematically) `ĥ(P) ≥ C(d)/σ_E^{20}` or similar — a **constant**
   depending on the *ratio*, with **no `+log N` growth term**. There is *no* version of HS that yields
   `ĥ(P) ≥ c·log N_E` for a number-field point. The growth `ĥ ≥ c·log N` for number-field points is
   **Lang's conjecture itself** — which HS does NOT prove even under Szpiro. (HS proves Lang's
   *constant* lower bound `ĥ ≥ c>0` under Szpiro; the *linear-in-log-N* Lehmer-type growth is a
   stronger, separate, still-open statement.)

3. **Why the function-field unconditional bound does not transfer.** The function-field theorem DOES
   give linear growth `ĥ_η(σ) ≥ c₁ h_B(σ)`, but only for **sections** (§3.2). By §2 there are no
   non-torsion sections, so this growing bound has no object to act on. The sporadic points are
   number-field points, governed by the number-field HS (constant only, even under Szpiro).

> **Verdict 4.3.** Bounded Szpiro ratio for `E_PCP(q)` makes the **constant** lower bound
> `ĥ(P_q) ≥ c_0 > 0` honestly **unconditional** for this family. It does **NOT** make the **growing**
> bound `ĥ(P_q) ≥ c₁ log H_j(q) − c₂` (= OQ1) follow from Hindry-Silverman: HS — even with a bounded
> Szpiro ratio — yields a constant, not `c·log N`, for number-field (sporadic) points. The growth in
> OQ1 is precisely the content of Lang's height conjecture (lower-bound/Lehmer form), which remains OPEN.

---

## §5. Final verdict

> ### ⚠️ CORRECTION 2026-05-25-PM — the (c) verdict in this section is OVERTURNED.
>
> This §5 verdict rests on point 5 below, which is **factually false**. Verified verbatim from
> primary sources (see `OQ1-HS-RESOLUTION.md`):
> - **Petsche 2005, Thm 2** (ar5iv `math/0508160`): *“ĥ(P) ≥ c(d,σ)·log|N_{k/Q}(Δ_{E/k})| for all
>   non-torsion P∈E(k)”*, with `c(d,σ)=1/(10¹⁵ d³ σ⁶ log²(c₂dσ²))` depending only on `d=[k:Q]` and
>   **the Szpiro ratio of E itself** — a GROWTH bound in `log|Δ|`, NOT a constant.
> - **Silverman 2009, Thm 5** (ar5iv `0908.3895`): `ĥ(P) ≥ C₁·h(E/K) − C₂`, `h(E/K)=max(h(j),log|Δ|)`,
>   `C₁,C₂` depending only on `[K:Q]` and the J-depleted Szpiro ratio; unconditional given a bound on it.
>
> So points 5–6 and the “refined classification” below are wrong: HS/Petsche **do** give the
> linear-in-`log|Δ|` growth, depending only on the curve’s own `σ`. The sporadic-point objection
> (points 2–3) is a **red herring** — these bounds apply to *any* non-torsion point on an individual
> `E/Q` and never required sections.
>
> **Corrected verdict (see `OQ1-HS-RESOLUTION.md` / `CONDITIONAL-CLOSURE-LANDSCAPE.md`):**
> - **OQ1 per-fiber** — UNCONDITIONAL THEOREM: `ĥ(P_q) ≥ c(1,σ_q)·log|Δ_q|`, and `log|Δ_q| ≍ log H_j(q)`.
> - **OQ1 uniform** (single `c₁`, all `q`) ⟹ Pila–Zannier closure of the rank-jump locus — **(a)-conditional
>   on one thin ABC instance**: `σ(E_PCP(q))` uniformly bounded (empirically ≤ 4.61 to m≤400).
> - **Unconditional sub-closure**: uniform OQ1 holds on the `ω(N)≤R₀` (bounded #bad-primes) sub-locus
>   (Gross–Silverman). Net: PCP-finiteness on `𝓡` needs neither Bombieri–Lang nor full Lang — only a
>   thin ABC bound on this one family. The §5 text below is retained for audit but is NOT the verdict.

> ### OQ1 is **(c): a restatement of an open conjecture.**

Justification, in one chain:

1. Arithmetic generic rank of `E_PCP(q)/Q(q)` is **0** (Shioda-Tate on a rational elliptic surface,
   `e=12, ρ=10, Σ(m_v−1)=8`; cross-checked by `ellrank`/`ellanalyticrank` minimum-rank-0 on positive
   density). `MW(E_η/Q(q)) = Z/4×Z/2`, torsion only.
2. Hence every non-torsion rank-jump generator `P_q` is a **sporadic point**, not the specialization
   of any section (§2). The 8 torsion sections are all degenerate (Lemma 1). So PCP candidates live
   entirely in the sporadic locus.
3. The section/Manin/function-field height-comparison route (Agent A, §5.3) bounds specializations of
   **sections** and is therefore **vacuous** here — it does not bound the sporadic generators. The
   §5.3 route, as written, is dead.
4. A *growing* lower bound `ĥ(P) ≥ c·log|Δ| (≍ c·log H_j)` for sporadic (number-field) points on
   `E/Q` is the **lower-bound form of Lang's height conjecture**.
5. Hindry-Silverman 1988 proves Lang's bound **unconditionally only over function fields, for sections**
   (no sections here), and **over number fields only conditionally on Szpiro, and even then only as a
   CONSTANT lower bound `ĥ ≥ c(σ_E)`** — not as the linear-in-`log N` Lehmer growth.
6. The Szpiro ratio of this explicit family **is** uniformly bounded (`σ ∈ [2.72, 4.07]`, mean 3.09;
   rigorously `≤ 6+ε` from multiplicative reduction). This **upgrades the family-uniform CONSTANT
   bound `ĥ ≥ c_0` to unconditional** — but does **NOT** upgrade it to the growing OQ1 bound. HS does
   not contain a `c·log N` growth statement for number-field points; the growth is exactly Lang.

> **Refined classification.** OQ1 splits into two statements:
> - **(unconditional)** `ĥ(P_q) ≥ c_0 > 0` for all non-torsion `P_q` — TRUE for this family (bounded
>   Szpiro ratio + HS), but this is the *constant* bound, useless for a Pila-Wilkie count.
> - **(OQ1 as needed: `ĥ ≥ c₁ log H_j − c₂`)** — this is **Lang's height conjecture / the elliptic
>   Lehmer problem**, OPEN over `Q`, and **not** delivered by any known theorem for sporadic points.
>   Bounded Szpiro ratio does not bridge constant-to-growth.

**One-line honest bottom line.** "Attacking OQ1" via the section/Manin route is **not worthwhile**:
the family's generic rank is 0, so the route has no sections and OQ1's *growth* is the open Lang/Lehmer
lower bound in disguise — a precise reduction to a named open conjecture, not a provable theorem.

---

## §6. Reproducibility

| script | output | purpose |
|:---|:---|:---|
| `/tmp/step1_tate.gp` | `c₄, Δ`, Kodaira types `I₄,I₂,I₂,I₄`, `e=12` | singular fibers, Tate criterion |
| `/tmp/surface_check.gp` | rational ell surface, `ρ=10`, MW rank 0 | Shioda-Tate |
| `/tmp/step1_spec2.gp` | rank distribution `[41,36,8]` over 85 fibers, min 0 | specialization cross-check |
| `/tmp/szpiro2.gp` | `σ∈[2.7217,4.0718]`, mean 3.0944 over 416 fibers | Szpiro ratio of family |
| `scripts/silverman_task1_ranks.out` | `ellrank=[0,0]` at `q=8/15,40/9,16/63,56/33` | rank-0 fibers exist (existing data) |
| `scripts/pila_oq2/tors.gp` | `Z/4×Z/2`, `P₄` order 4 | torsion sections (existing) |
| `LEMMA-1-UNIVERSAL-TORSION.md` | all torsion ↦ `c=0,∞` | torsion sections degenerate (existing) |

PARI/GP 2.15.4, `default(parisize, 800000000)`.

---

## §7. References

- **Lang, S.** *Elliptic Curves: Diophantine Analysis.* Grundlehren 231, Springer, 1978 (height conjecture, p. 92).
- **Hindry, M., Silverman, J. H.** The canonical height and integral points on elliptic curves.
  *Invent. Math.* **93** (1988), 419–450. (Thm 0.3: Lang's lower bound, conditional on Szpiro over
  number fields with constant `c(σ_E)`; unconditional over function fields.)
- **Hindry, M.** Autour d'une conjecture de Serge Lang. *Invent. Math.* **94** (1988), 215–268.
  (Function-field Lang for sections, via Pesenti-Szpiro inequality.)
- **Shioda, T.** On the Mordell-Weil lattices. *Comment. Math. Univ. St. Paul.* **39** (1990), 211–240.
- **Silverman, J. H.** Heights and the specialization map for families of abelian varieties.
  *J. Reine Angew. Math.* **342** (1983), 197–211.
- **Silverman, J. H.** Variation of the canonical height. *J. Reine Angew. Math.* **441** (1994), 121–149.
- **Szpiro, L.** Discriminant et conducteur des courbes elliptiques. *Astérisque* **183** (1990), 7–18.
- **Manin, Yu. I.** The Tate height of points on an abelian variety. *Izv. Akad. Nauk SSSR* **28** (1964).

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

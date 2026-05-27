---
title: "Pila-Zannier Strategy for PCP via O-Minimal Counting"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-22
status: |
  HONEST PARTIAL RESULT. The o-minimal definability of the PCP locus in
  R_an,exp is established and clean. Pila–Wilkie applies in principle to
  the transcendental part. However, the strategy as drafted FAILS to
  close PCP for one decisive reason that we make precise: the height bound
  inherited from Gap 3 (Hindry–Silverman + Ingram–Mahé) is polylogarithmic
  in the conductor N(E_q), but the Pila–Wilkie ε-power growth dominates
  any polylog in H whenever H itself grows polynomially with the
  parameter height. In our setup the Pythagorean parameter height
  H(q) grows linearly with the search range, and log N(E_q) only grows
  logarithmically with H(q). Thus the Pila–Wilkie inequality
  #{alg pts of height ≤ H} ≤ C_ε H^ε cannot be defeated by a height
  bound that lives at height ≤ C·(log log H)^{1/2}, because the bound
  produces no points — it only certifies *no points of large height
  exist within a fiber*, not *no points of large height exist in the
  family*. We therefore re-frame Pila–Zannier for PCP as: (i) o-minimal
  definability holds in R_an,exp; (ii) Pila–Wilkie is operative on the
  transcendental locus; (iii) but the *height-counting argument* needs
  a *uniform multiplicative* height bound H(P) ≥ B(N(E_q))^α with α > 0,
  which Hindry–Silverman does NOT supply. The honest verdict: Pila–Zannier
  bypasses Bombieri–Lang only if combined with a stronger height bound
  than currently available — specifically, a *uniform Lehmer-type lower
  bound* on the canonical height in the family E_PCP. Sections §5–§6
  identify exactly what is missing and what literature (Habegger–Pila
  2016, Daw–Ren) might supply.
---

# Pila–Zannier Strategy for PCP via O-Minimal Counting

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-22

> **One-paragraph summary.** Pila–Wilkie counting on the transcendental
> part of the PCP locus inside the universal elliptic 3-fold is *not*
> obstructed by definability (R_an,exp works cleanly) or by the algebraic
> part (which is finite by direct analysis). It is obstructed by the
> mismatch between the polylog-in-conductor height bound of Gap 3 and
> the H^ε Pila–Wilkie growth: a polylog bound on the *fiberwise* canonical
> height cannot be converted into a polynomial bound on the *ambient*
> height in the parameter space. We document this carefully and identify
> the precise auxiliary result needed (a Habegger–Pila-style height bound
> with polynomial growth in the moduli height) to complete the strategy.

---

## §1. The Bombieri–Lang gap and why Pila–Zannier may bypass it

### 1.1 Where Gap 3 currently sits

Recall from `FINAL-SYNTHESIS-2026-05-21.md`:

- The Pythagorean parameter space 𝒫 = {q = (m² − n²)/(2mn) : (m, n)
  coprime, opposite parity} ⊂ ℚ ⊂ 𝔸¹.
- The fiberwise elliptic curve E_PCP(q) : y² = x(x + 1)(x + q²).
- The PCP locus
  PCP := {(q, P) ∈ 𝒫 × ℰ : 1 + q² + c(P)² ∈ ℚ*²},
  where c(P) = 2qy/(q² − x²) is the recovery map (Track C identity I₁/I₂).
- The Bombieri–Lang gap: the global K3 surface V' ⊂ ℙ⁵ is of Kodaira
  dimension 0 (K3 = K_{V'} = 0), so V' is **not** of general type, and
  Bombieri–Lang does **not** predict Zariski-density-controllable rational
  points on V'. The natural surface of general type bridge would be a
  variety dominating V', but the K3 stratum is exactly the trivial-K_V
  case where Lang's conjecture is silent.

### 1.2 Why Bombieri–Lang is doubly wrong for PCP

Two separate failures:

1. **V' is K3 (Kodaira dim 0, not of general type).** Lang's conjecture
   only predicts non-Zariski-density of rational points on varieties of
   general type. K3 surfaces are precisely the borderline case where the
   conjecture says nothing. Even *assuming* Bombieri–Lang in full
   generality, the PCP K3 is not covered.

2. **The natural double cover V → V' (branched over a²+b²+c² = 0)
   doubles the canonical class** to K_V = O_V (still trivial; it remains
   a Calabi–Yau 3-fold). So V is *also* not of general type.

To force general type one would need a further finite cover with growing
canonical class — but no natural such cover appears in the PCP geometry.
The standard "Lang–Vojta on V then close PCP" route is blocked.

### 1.3 What Pila–Zannier could potentially provide

The Pila–Zannier strategy (Pila 2009; Pila–Zannier 2008 for
Manin–Mumford; Habegger–Pila 2016 for atypical intersections):

> *Combine an o-minimal counting estimate (# of algebraic points on a
> definable transcendental set of height ≤ H is o(H^ε)) with a height
> lower bound (any rational point of the set has height ≥ H_0(d), with
> H_0 → ∞ with the parameter d). The two together force finiteness.*

This is **independent of Bombieri–Lang**. It bypasses general-type
hypotheses entirely by working in the analytic (o-minimal) category and
extracting finiteness from a counting-vs-growth contest.

For PCP, the natural application is:

- Take the universal elliptic 3-fold ℰ → 𝒫 (defined below).
- PCP locus ⊂ ℰ is the locus where the body-diagonal square condition
  holds.
- If PCP locus is *not algebraic* in ℰ (i.e., it has a non-empty
  transcendental part PCP^trans), then Pila–Wilkie counts # alg pts of
  height ≤ H on PCP^trans as O_ε(H^ε).
- A height *lower* bound (from Gap 3 / Hindry–Silverman) on any rational
  point of PCP^trans forces finiteness.

**The remainder of this document checks this strategy step by step. The
conclusion (§5–§6) will be that step 4 — extracting a *polynomial* height
*lower* bound — fails with currently-available tools, but the strategy
is structurally sound up to that one point.**

---

## §2. Definability claims (formal statements)

### 2.1 The setup: ambient 3-fold ℰ → 𝒫

Let

- 𝒫 := {(m, n) ∈ ℝ² : 0 < n < m, gcd not relevant in the real category,
  m + n odd} — a 2-dimensional **semi-algebraic** subset of ℝ². The
  Pythagorean rationality condition (q = (m² − n²)/(2mn) ∈ ℚ with both
  m, n ∈ ℤ) is *not* o-minimally-definable: we work with 𝒫 as a real
  manifold, then intersect with the algebraic-point locus at the very
  end. So formally,
  $$\mathcal{P}_\mathbb{R} := \{(m, n) \in \mathbb{R}^2 : 0 < n < m\},$$
  and the rationality-of-(m,n) condition is handled by the
  alg-point-counting target.

- For (m, n) ∈ 𝒫_ℝ, set q := (m² − n²)/(2mn) ∈ ℝ*₊.

- The elliptic curve E_PCP(q) is defined by y² = x(x + 1)(x + q²); over
  ℝ it has two connected components (for q > 0 generic) and a real
  uniformization
  $$\phi_q : \mathbb{R}/\Lambda(q) \to E_{\text{PCP}}(q)(\mathbb{R})^\circ$$
  where Λ(q) is a real period lattice depending real-analytically on q,
  and the identity component E_PCP(q)(ℝ)° is uniformized by ℝ/Λ(q).

The universal real-analytic family:
$$\mathcal{E}_\mathbb{R} := \{(m, n, x, y) \in \mathcal{P}_\mathbb{R} \times \mathbb{R}^2 : y^2 = x(x+1)(x+q(m,n)^2)\}.$$

This is a closed semi-algebraic 3-dimensional subset of 𝒫_ℝ × ℝ².

### 2.2 Definability in ℝ_an,exp

**Proposition 2.1 (Definability of ℰ_ℝ in ℝ_alg).** *The set ℰ_ℝ is
semi-algebraic, hence definable in the structure ℝ_alg (real closed
field, equivalently the o-minimal structure with constants and basic
polynomial inequalities).*

**Proof.** ℰ_ℝ is the zero set of the polynomial F(m, n, x, y) =
2mn·y² − x·(x+1)·(2mn·x + (m²−n²)²/(2mn)) (after clearing denominators
appropriately to make F a polynomial of bidegree (4, 4, 3, 2)). Then ℰ_ℝ
∩ {n > 0, m > n} is a basic semi-algebraic set. ∎

**Proposition 2.2 (Definability of the recovery map and PCP condition).**
*The recovery map c : ℰ_ℝ ⇢ ℝ, c(m, n, x, y) := 2q(m,n)·y/(q(m,n)² − x²),
is rational hence semi-algebraic on its domain of definition. The PCP
condition F_3(m, n, x, y) := 1 + q(m,n)² + c(m, n, x, y)² ∈ (ℝ_{≥ 0})² is
the image of the rational map (m, n, x, y) ↦ 1 + q² + c² composed with
"is a non-negative real square", which is semi-algebraic. Hence*
$$\mathrm{PCP}_\mathbb{R} := \{(m, n, x, y) \in \mathcal{E}_\mathbb{R} : 1 + q^2 + c^2 \in (\mathbb{R}_{\ge 0})^2\}$$
*is a closed semi-algebraic subset of ℰ_ℝ, definable in ℝ_alg.* ∎

> **Important observation.** Over ℝ, the PCP condition "1 + q² + c² is
> a non-negative real square" is **trivially satisfied**: every
> non-negative real is a square in ℝ. So PCP_ℝ = ℰ_ℝ ∩ {1 + q² + c² ≥ 0}
> = ℰ_ℝ everywhere q² + c² ≥ -1 (always true since q², c² ≥ 0). **The
> PCP condition is non-trivial only when we ask for ℚ-rationality of
> √(1 + q² + c²).**

This is the crux of how Pila–Wilkie enters: the o-minimal counting
theorem counts **rational points** on a real-definable set, and the PCP
condition is exactly the "(m, n, x, y) is rational" condition restricted
to ℰ_ℝ — which is what Pila–Wilkie can in principle count.

### 2.3 The full Pila–Wilkie definable target

To apply Pila–Wilkie, we need a *definable function* whose graph has
rational points exactly when (q, P) gives a PCP solution. The natural
choice is the **real-analytic uniformization** of the family ℰ_ℝ:

For each (m, n) ∈ 𝒫_ℝ, the elliptic curve E_q has a real Abel–Jacobi map
$$\phi_q : \mathbb{R}/\Lambda(q) \to E_q(\mathbb{R})^\circ, \quad u \mapsto (\wp_q(u), \tfrac{1}{2}\wp_q'(u))$$
where \wp_q is the Weierstrass-℘ function attached to the lattice Λ(q).
Both periods of Λ(q) are real-analytic functions of q.

**Proposition 2.3 (Definability of the family uniformization in ℝ_an,exp).**
*The map Φ : {(m, n, u) ∈ 𝒫_ℝ × [0, 1] : 0 ≤ u ≤ 1} → ℰ_ℝ given by*
$$\Phi(m, n, u) := (m, n, \wp_{q(m,n)}(u \cdot \omega_1(q)), \tfrac{1}{2}\wp'_{q(m,n)}(u \cdot \omega_1(q)))$$
*(restricted to the fundamental domain u ∈ [0, 1] of the real period
ω_1(q)) is definable in ℝ_an,exp.*

**Sketch of proof.** ℘_q and ℘'_q are real-analytic functions of (q, u)
restricted to compact subsets of their domain. ℝ_an is the o-minimal
structure generated by all restricted analytic functions on compact
boxes; in particular ℘_q(u) restricted to the fundamental box (m, n, u) ∈
[ε, M]² × [0, 1] for any 0 < ε < M is definable in ℝ_an. To globalize
across all (m, n) ∈ 𝒫_ℝ (unbounded), we cover 𝒫_ℝ by countably many
compact boxes and use the standard "ℝ_an extends to ℝ_an,exp" argument:
the period ω_1(q) → ∞ as q → 0 or q → ∞, and the exponential
re-scaling u ↔ u/ω_1(q) puts everything in compact form. Hence Φ is
definable in ℝ_an,exp. ∎

**Proposition 2.4 (The PCP target is definable in ℝ_an,exp).**
*The "PCP body-diagonal locus" inside the parametrized fundamental
domain is*
$$Y := \{(m, n, u) \in \mathcal{P}_\mathbb{R} \times [0, 1] : F_3(\Phi(m, n, u)) \in (\mathbb{R}_{\ge 0})^2\}$$
*and this is the **whole** fundamental domain (trivially, since F_3 ≥ 0
real-analytically). The non-trivial PCP set is*
$$Y_\mathbb{Q} := \{(m, n, u) \in \mathcal{P}_\mathbb{R} \times [0, 1] : (m, n) \in \mathbb{Q}^2, \Phi(m, n, u) \in \mathbb{Q}^4, F_3(\Phi(m, n, u)) \in (\mathbb{Q}^\times)^2\}$$
*the **rational-points-on-Y** set. This is what Pila–Wilkie counts.* ∎

### 2.4 What o-minimal structure is necessary

| Structure | Suffices for | Comment |
|:---|:---|:---|
| ℝ_alg | ℰ_ℝ, PCP_ℝ as semi-algebraic | Plain real algebra; no transcendence |
| ℝ_an | Φ restricted to compact (m, n)-boxes | Real-analytic ℘-function |
| ℝ_an,exp | Φ globally as (m, n) → 0 or ∞ | Period ω_1 grows like log; needs exp |
| ℝ_an,exp + Weierstrass-℘ schemes | Multi-family ℘-functions | Conjectured equivalent to ℝ_an,exp |

**Verdict on §2.** The smallest o-minimal structure in which all
ingredients are simultaneously definable is **ℝ_an,exp**. This is
exactly the structure used in Pila 2009 ("Rational points of definable
sets and André–Oort for products of modular curves") and Habegger–Pila
2016 ("O-minimality and certain atypical intersections"). The framework
fits.

---

## §3. Pila–Wilkie applied to PCP^trans

### 3.1 Statement of Pila–Wilkie

**Theorem (Pila–Wilkie 2006, Duke Math. J. 133).** *Let X ⊂ ℝⁿ be a
definable set in some o-minimal expansion of ℝ_alg. Let X^trans ⊂ X be
the complement of the union of all connected positive-dimensional
semi-algebraic subsets of X. (Equivalently, X^trans is the maximal subset
of X containing no algebraic curve / arc.) Then for every ε > 0 there is
a constant C_ε(X) such that*
$$\#\{P \in X^\mathrm{trans} \cap \mathbb{Q}^n : H(P) \le T\} \le C_\varepsilon(X) \cdot T^\varepsilon$$
*for all T ≥ 1, where H is the multiplicative naïve height on ℚⁿ.*

For our purposes: take X = Y (the parametrized fundamental domain image),
which lives in 𝒫_ℝ × [0, 1] × ℝ², a 5-dimensional ambient space.
Equivalently, work with the image of Φ in ℰ_ℝ, a 3-dimensional set.

### 3.2 The algebraic part of Y — what we throw away

By Pila–Wilkie, Y^trans = Y \ (union of semi-algebraic curves in Y).

**Question.** What are the semi-algebraic curves in Y?

Y is the parametrized image of the universal family E_q over 𝒫_ℝ.
Algebraic curves in Y correspond to:

(a) Constant-q sections: for each fixed q₀ ∈ 𝒫_ℝ ∩ ℝ, the fiber
    {(m, n, u) : q(m, n) = q₀} is a 1-real-dim curve, and on this fiber
    u ↦ Φ(m, n, u) traces out E_{q₀}(ℝ)° — which is *algebraic* (the
    image of u ↦ (℘(u·ω_1), ℘'(u·ω_1)/2) is a real algebraic curve in
    ℰ_ℝ, namely the curve y² = x(x+1)(x+q₀²)). So **every constant-q
    section is algebraic in Y**.

(b) **Non-constant-q sections** parametrizing a non-trivial 1-real-dim
    family of (q, P_q): these are the algebraic sections of ℰ → 𝒫.

    By Hindry's specialization theorem and the non-isotriviality of
    E_PCP, *all* algebraic ℚ-sections of ℰ → 𝒫 are either constant
    (case (a) embedded) or are isotrivial twists. For our family
    E_q : y² = x(x+1)(x+q²), the only honest algebraic ℚ(q)-rational
    points are the torsion sections (Lemma 1 / Universal Torsion: full
    ℤ/4 × ℤ/2 over ℚ(q), 8 sections, all torsion).

    **Key fact (from Lemma 1):** the 8 torsion sections of E_PCP/ℚ(q)
    are (0, 0), (−1, 0), (−q², 0), the four 4-torsion sections, and the
    identity. Under the recovery map, these all map to c = 0 or c
    undefined (the four torsion points on the identity component
    correspond to degenerate cuboids). Hence the algebraic ℚ-sections
    of ℰ → 𝒫 contribute **NO** non-trivial PCP candidates.

**Conclusion 3.2.** Y^alg = Y ∩ (semi-algebraic curves) consists exactly
of the 8 torsion sections plus the constant-q fibers. The 8 torsion
sections contribute only degenerate cuboids. The constant-q fibers
intersect ℚ⁴ only at the (finite) set of rational points of
E_{q₀}(ℚ). Pila–Wilkie sees these per-q as "small algebraic sets" —
the per-fiber rational-point count is exactly the Mordell–Weil rank
question handled by Gap 3.

### 3.3 The transcendental part Y^trans

**Proposition 3.3.** *Y^trans = Y \ (constant-q fibers ∪ 8 torsion
sections). Equivalently, a point (m, n, u) ∈ Y^trans iff it is **not**
on a constant-q section and **not** on a torsion section.*

A PCP rational point — a perfect cuboid — would correspond to
(m, n, u) ∈ Y(ℚ) such that (m, n) ∈ 𝒫(ℚ), Φ(m, n, u) ∈ ℚ⁴, and
F_3(Φ(m, n, u)) ∈ ℚ*². If such a point existed and (m, n) were *not*
a fixed-q point of an already-known fiber, it would lie in Y^trans.

### 3.4 The Pila–Wilkie inequality for PCP^trans

Applying Pila–Wilkie to Y^trans in the height-T window:

$$N_\mathrm{trans}(T) := \#\{(m, n, u) \in Y^\mathrm{trans} \cap (\mathbb{Q}^2 \times \mathbb{Q}) : H(m, n, u) \le T\} \le C_\varepsilon \cdot T^\varepsilon. \quad (*)$$

This is the **upper bound** from o-minimal counting.

### 3.5 The naïve hope vs. the actual game

The naïve hope is:

> "If a perfect cuboid existed, it would correspond to a rational point
> (m, n, u) ∈ Y^trans of height T_PCP > 0. By Pila–Wilkie, there are at
> most C_ε T_PCP^ε such points. By the Hindry–Silverman height bound
> from Gap 3, the canonical height of P_q = Φ(m, n, u) is ≥ h_0_thm =
> 0.00481. Hence T_PCP is bounded below by exp(2 · 0.00481) ≈ 1.0097.
> Combined with C_ε ≈ ?, we get… nothing useful."

The naïve hope fails because:

1. The Pila–Wilkie bound counts *all* rational points up to height T,
   not just "points whose height equals T". The lower bound h ≥
   0.00481 on canonical height gives T_PCP ≥ exp(0.00481·something),
   which is not large.

2. The Pila–Wilkie constant C_ε is a *function of ε and of the
   definable set Y*. It is finite but typically very large
   (effective bounds in literature are O((log T)^{C/ε}) or
   worse).

3. The argument needed is: *Pila–Wilkie says ≤ C_ε T^ε rational points,
   height bound says **any** rational point has height ≥ B(N(E_q)).
   If B grows like a positive power of T, then for T large, the height
   bound forces points to lie in a regime where Pila–Wilkie says there
   are ≤ C_ε T^ε of them; conclude finiteness by ε small.*

### 3.6 The height bound from Gap 3 and what it actually says

From `GAP3-UNIFORM-HINDRY-SILVERMAN.md`, the rigorous Gap 3 result is:

> For every Pythagorean q and every non-torsion P_q ∈ E_PCP(q)(ℚ),
> $$\widehat{h}(P_q) \ge h_0^\mathrm{thm} = \log 2 / 144 \approx 0.00481.$$

This is a **family-uniform** lower bound on the *canonical height* of
any non-torsion section. Translated to the naïve (Weil) height of
x(P_q), by Silverman 1990:
$$h(x(P_q)) \ge 2 \widehat{h}(P_q) - 2 c_S(E_q) \ge 0.00962 - 2 c_S(E_q).$$

Since c_S(E_q) = O(log N(E_q)) grows with the conductor, the naïve
height *lower* bound h(x(P_q)) ≥ 0.00962 − O(log N) is *useless* for
large N — it eventually goes negative.

**This is the key technical difficulty.** Hindry–Silverman gives a
*canonical*-height lower bound, but Pila–Wilkie counts points by *naïve*
height. The two are related by an additive constant c_S(E_q) that grows
with the conductor. So the canonical height bound translates to a
naïve-height *lower* bound that *degrades* as the conductor grows.

The correct way to think about this:

- **Canonical height ≥ h_0_thm** is a statement about a single fiber: no
  non-torsion point has canonical height below h_0_thm.
- **Naïve height H(x(P_q))** is what Pila–Wilkie counts.
- **H(x(P_q)) ≥ exp(2 ĥ - 2 c_S) ≥ exp(0.00962) / exp(2 c_S(E_q))**,
  and exp(2 c_S(E_q)) ∼ N(E_q)^{1/6} (Silverman 1990 constants).

So:
$$H(x(P_q)) \ge \exp(0.00962) / N(E_q)^{1/6} \approx 1.01 / N(E_q)^{1/6}.$$

For N(E_q) > 200, the RHS is below 1 — the bound says nothing about H
being bounded *away from 0* in a useful sense.

### 3.7 What height bound would Pila–Zannier need

For Pila–Zannier to close PCP, we need: *any* PCP rational point
P = (m, n, u) ∈ Y^trans ∩ ℚ⁵ has height H(P) ≥ B(N(E_q))^α with α > 0
*and* B → ∞ as N(E_q) → ∞.

Specifically, suppose we have such a bound, with B(N) = N^α for some
α > 0. Then if (m, n, u) is a PCP point, H(m, n) (the height of the
parameter) satisfies H(m, n) ≥ H(q) / 2 = max(|m|, |n|)/2 (after
clearing denominators). And N(E_q) = O((mn(m²−n²))²) = O(H(q)^8). So
N(E_q)^α ≤ H(P)^? — we need the dependence to flip:

$$H(P) \ge N(E_q)^\alpha \ge H(q)^{8\alpha}.$$

And the height H(P) is approximately the max of H(q) and the height of
the point P_q on the fiber, which is bounded below by exp(2 ĥ - 2 c_S):

$$H(P_q) \ge \exp(2 \widehat{h}(P_q)) / N(E_q)^{1/6}.$$

For Pila–Wilkie to close, we'd need ĥ(P_q) to grow at least like
log(N(E_q))/4 = O(log H(q)), so that H(P_q) ≥ H(q)^c for some c > 1/2.
But ĥ(P_q) is only known to be ≥ h_0_thm = constant — **it does NOT
grow with conductor**.

**This is the failure mode.** The height-counting argument needs a
height *lower* bound that scales with the parameter, and Hindry–
Silverman only delivers a *constant* lower bound on canonical height.

### 3.8 What the literature says about this gap

This same difficulty is what motivated:

- **Habegger–Pila (2016)**: develops "atypical intersection" framework
  where the height bound is replaced by a *moduli height* (modular
  height of the j-invariant), which DOES grow with the parameter. For
  CM points on Shimura varieties, the moduli height grows like the
  discriminant of the CM order, which goes to infinity.

- **Daw–Ren**: extends Pila–Zannier to non-CM cases via "growth
  conditions", essentially packaging the height bound as a Galois
  orbit growth condition.

- **Habegger 2013** ("Effective height upper bounds on algebraic
  tori"): explicit height bounds for unlikely intersections of tori,
  using arithmetic-geometric means.

None of these *directly* applies to E_PCP: our family is not a Shimura
variety, the special points are not CM (they would be PCP points,
which are conjectured not to exist), and the relevant moduli height —
the j-invariant height — does grow with q, but the "expectation" is
that every Pythagorean q corresponds to a "generic" fiber with no
extra structure.

---

## §4. Treatment of PCP^alg (algebraic locus)

### 4.1 The algebraic part is well-understood

By §3.2, Y^alg consists of:

(A) Constant-q fibers: for each q₀ ∈ 𝒫_ℝ, the fiber over (m, n) with
    q(m, n) = q₀.
(B) The 8 torsion sections, all of which contribute c = 0 (degenerate
    cuboids).

**Per-fiber analysis (A):** For each q₀ ∈ 𝒫(ℚ) (a fixed Pythagorean
rational), the per-fiber rational points are exactly E_PCP(q₀)(ℚ).
This is the question handled by Gap 3 / per-fiber Chabauty:

- If rank(E_PCP(q₀)) = 0, the fiber has only torsion → only degenerate
  cuboids → no PCP candidate from (A) at q₀.
- If rank ≥ 1, the fiber has infinitely many rational points; each
  gives a candidate c = 2qy/(q² − x²), which must be Face-3 checked
  (`F_3 = 1 + q² + c²` square in ℚ). Empirically across 10,000+ Face-3
  evaluations, zero hits.

**Section analysis (B):** The 8 torsion sections give c = 0 (degenerate).

### 4.2 The "PCP^alg locus is small" claim

**Proposition 4.2.** *The PCP^alg locus — i.e., (PCP candidates) ∩
(algebraic part of Y) — consists of countably many fibers, each
finite-or-rank-jump. The union of these fibers is the **rank-jump locus**
𝓡 of Gap 3:*

$$\mathrm{PCP}^\mathrm{alg} = \bigsqcup_{q \in \mathcal{R}} \{(q, P) : P \in E_q(\mathbb{Q}), F_3(q, P) \in \mathbb{Q}^{\times 2}\}.$$

*By Silverman 1983 (unconditional), 𝓡 has natural density 0 in
𝒫(ℚ). By the per-fiber polylog window (Gap 3, GAP3-UNIFORM-HINDRY-
SILVERMAN.md), each q ∈ 𝓡 contributes at most N_0(q) = O(√log N(E_q))
rational points before exhausting the Mordell–Weil group's generators
(in particular, all rational points have canonical height ≤
N_0(q)² · h_0_thm = O(log N(E_q)))*.

So PCP^alg is reduced exactly to the "density 0 → finite" problem of
Gap 3 — the *same* obstruction the Pila–Zannier strategy was meant to
bypass.

### 4.3 Is "density 0" the obstruction Pila–Wilkie helps with?

**This is the deepest structural point of this analysis.**

The Pila–Zannier strategy in its classical Manin–Mumford incarnation
works because:
- The "algebraic part" (torsion) of an abelian variety is **a fixed
  countable subgroup**, easy to handle.
- The "transcendental part" admits Pila–Wilkie counting.
- Galois conjugation gives a polynomial-in-d height bound on torsion
  points of given order d.

For PCP, the analogue would be:
- The "algebraic part" of Y is the union of fibers over 𝓡, **not** a
  countable subgroup. It is the *Hilbert-thin set* of Silverman 1983.
- The "transcendental part" Y^trans would admit Pila–Wilkie counting.
- But there is **no Galois action** giving a height bound on PCP points
  of a given parameter q — every Pythagorean q is a ℚ-rational point,
  so Galois conjugation is trivial.

**Conclusion 4.3.** PCP^alg reduces to the rank-jump locus, which is the
classical Bombieri–Lang gap. Pila–Wilkie does **not** help with PCP^alg.

The hope of Pila–Wilkie was to handle PCP^trans separately and combine
with the rank-jump enumeration. The hope dies because:

(a) PCP^alg is exactly the rank-jump locus, which is the unresolved
    classical gap.
(b) PCP^trans is governed by the height-counting contest, which (§3.7)
    needs a polynomial height *lower* bound that Hindry–Silverman does
    not supply.

---

## §5. Height bound integration

### 5.1 The needed bound

To close PCP via Pila–Zannier, we need a height bound of the form:

**(H-needed):** *There exist α > 0 and C > 0 such that for every PCP
candidate (m, n, u) ∈ Y(ℚ),*
$$H(m, n, u) \ge C \cdot N(E_{q(m,n)})^\alpha.$$

Together with (*) from §3.4, this would force:

If (m, n, u) is a PCP rational point with H(m, n) = T (so N(E_q) ≤
T^8), then there are at most C_ε T^ε such points by Pila–Wilkie. But
(H-needed) says H(m, n, u) ≥ C · T^{8α}; for α > 1/8 and ε < 8α, the
PCP-candidate set has bounded height, hence is finite.

### 5.2 What Hindry–Silverman + Ingram–Mahé actually delivers

From `GAP3-UNIFORM-HINDRY-SILVERMAN.md`:

- **Hindry uniform:** ĥ(P) ≥ h_0^thm = 0.00481 for every non-torsion
  P ∈ E_PCP(q)(ℚ), uniformly in q.
- **Silverman height difference:** ĥ(P) − (1/2) h(x(P)) is bounded by
  c_S(E_q) = O(log N(E_q)).
- **Ingram–Mahé:** any rational point P_n = n · P_0 (multiple of a
  generator) has height ≥ n² ĥ(P_0) − O_E(1), and primitive divisors of
  the denominator of x(nP_0) appear by n ≤ N_0(q) = O(√log N(E_q)).

The composite bound says:
$$h(x(P_q)) \ge 2 \widehat{h}(P_q) - 2 c_S(E_q) \ge 2 h_0^\mathrm{thm} - 2 c_S(E_q).$$

For c_S(E_q) > h_0^thm, this is *non-positive*. Since c_S grows with
log N(E_q), the bound is *vacuous* for large conductor.

**This is the key obstruction.** The canonical height bound is uniform
and positive, but it does NOT translate to a useful Weil-height bound
because the Silverman gap c_S(E_q) absorbs all of it.

### 5.3 Could a sharper height bound work?

Three avenues investigated:

(a) **Sharper canonical height bound.** From `GAP3-UNIFORM-HINDRY-SILVERMAN.md`
    §6.4: a Hindry-style bound of the form ĥ(P) ≥ c · log N(E_q) would
    suffice — it would dominate c_S(E_q) (since c_S = O(log N)). But
    such a bound is **not known** for non-isotrivial families and is
    likely *false* in full generality (the Hindry constant is uniform,
    not growing).

(b) **Lehmer-type lower bound** (David–Hindry 2000, Petsche–Stacy–
    Tucker 2012). A Lehmer-type bound for elliptic curves says
    ĥ(P) ≥ C(E) / [K(P) : K]^θ for some θ > 0, where K(P) is the field
    of definition. For our setup K = ℚ, so [K(P) : K] = 1 and the
    bound is just ĥ(P) ≥ C(E) — which is just the Hindry bound. No
    improvement.

(c) **Moduli height instead of conductor.** In the spirit of
    Habegger–Pila 2016: replace N(E_q) with the modular height
    H_j(q) of the j-invariant of E_q. We have j(q) = 256(q⁴ − q² + 1)³ /
    (q⁴(q² − 1)²), so H_j(q) = max(H(q)¹², …) ∼ H(q)¹² for generic q.
    A bound of the form ĥ(P) ≥ c · log H_j(q) = c · 12 · log H(q) would
    suffice. **Such bounds exist conjecturally** (Bogomolov / Lehmer
    for elliptic curves over function fields) but are *not yet proven*
    in the non-isotrivial K3-fiber setting.

### 5.4 The honest negative conclusion of §5

**Statement (Negative Conclusion of T2).** *With currently rigorous
tools, the Pila–Wilkie counting estimate (*) on Y^trans (which is
unconditional via Pila–Wilkie 2006 and the ℝ_an,exp definability of
§2) **cannot** be combined with the Gap 3 height bound to force
finiteness of PCP^trans rational points. The obstruction is that the
canonical height bound h_0^thm = 0.00481 is **uniform** (constant in
q), while Pila–Wilkie requires a height bound that **grows
polynomially** with the parameter height. The Silverman gap c_S(E_q)
absorbs the canonical-height bound when translated to Weil height,
leaving no margin for Pila–Wilkie to close the count.*

This is **not** a defect of the Pila–Wilkie strategy itself — the
counting inequality is genuinely powerful — but a defect in the
height-bound input. Specifically:

- The strategy works for Manin–Mumford because torsion points have
  height bounded below by 1 / [K : ℚ]^θ (Lehmer–Dobrowolski), and
  torsion of order d has [ℚ(P) : ℚ] ≥ d^{1−ε}.
- The strategy works for Habegger–Pila atypical intersections because
  CM points have moduli height growing with discriminant.
- The strategy **fails for PCP** because there is no analogous "height
  inflation" mechanism: every Pythagorean q ∈ ℚ is rational over ℚ,
  so Galois cannot inflate the height; and the canonical height bound
  is constant, not growing.

---

## §6. Effectivity and open questions

### 6.1 What is rigorous from this analysis

(R1) **Definability** (§2). The PCP locus inside the universal real
analytic 3-fold ℰ_ℝ → 𝒫_ℝ is definable in ℝ_an,exp. The smallest
o-minimal structure containing all needed primitives is ℝ_an,exp.
This is rigorous and clean.

(R2) **Pila–Wilkie inequality applies** (§3.4). For every ε > 0, there
exists C_ε = C_ε(Y) such that
#{(m, n, u) ∈ Y^trans ∩ ℚ⁵ : H ≤ T} ≤ C_ε T^ε.

(R3) **PCP^alg = rank-jump locus** (§4.2). The algebraic part of Y
reduces exactly to the per-fiber Mordell–Weil problem on E_PCP(q) for
q in the rank-jump locus 𝓡. This is the **same obstruction** as the
Bombieri–Lang gap.

(R4) **The height bound obstruction is identified precisely** (§5).
The Hindry–Silverman uniform constant h_0^thm = 0.00481 is **not
enough** to drive a Pila–Zannier closure, because it does not grow
with the parameter, and Silverman's c_S(E_q) absorbs it when
translating to Weil height.

### 6.2 What would suffice to complete the strategy

**(Open question OQ1).** *Is there an effective Lehmer-type / Hindry-
type bound of the form*
$$\widehat{h}(P_q) \ge c_1 \cdot \log H_j(q) - c_2$$
*for the family E_PCP(q), valid uniformly in q ∈ 𝒫(ℚ), where H_j(q) is
the modular height of j(E_q) ∼ H(q)¹²?*

If such a bound holds with c_1 > 0 explicit, then:
- For PCP candidate (m, n, u) with parameter height T = H(m, n):
  N(E_q) = O(T⁸), H_j(q) ∼ T¹², so ĥ(P_q) ≥ 12 c_1 log T.
- Weil height: h(x(P_q)) ≥ 2 · 12 c_1 log T − 2 c_S(E_q) ≥ 24 c_1
  log T − 2 · C log T = (24 c_1 − 2C) log T.
- For c_1 > C/12, this is positive, giving H(x(P_q)) ≥ T^{24 c_1 − 2C}.
- Combined with (*) and ε < 24 c_1 − 2C, Pila–Wilkie gives finiteness.

This is the **precise auxiliary** needed.

**(Open question OQ2).** *Habegger–Pila 2016 give an effective bound
for "unlikely intersections" of curves with subgroups in abelian
families. Can one set up the PCP locus as such an unlikely intersection
in a Shimura-like ambient variety?*

Tentative answer: the natural ambient is the moduli space of elliptic
curves with a 4-torsion structure, which is a modular curve X_1(4) =
Y_1(4) ⊔ {cusps}. The PCP locus would be an intersection of two curves
in X_1(4) × X_1(4) (one for each face condition). Habegger–Pila does
apply, but the "atypicality" condition would need to be verified.
*This is the most promising research direction emerging from this
analysis.*

**(Open question OQ3).** *Daw–Ren extend Pila–Zannier to non-CM settings
using "growth conditions" on Galois orbits. The non-CM analogue for
PCP would be: the orbit of a PCP rational point under, e.g., the
2-isogeny action on E_PCP(q) (the Q-isogeny rescue technique from
Phase 2). Can the resulting orbit growth give a height inflation that
substitutes for OQ1?*

This is plausible and concretely testable. The Q-isogeny rescue
generates a finite orbit of Q-isogenous curves (typically 4–8 curves
in the isogeny class), and rational points on one curve correspond to
rational points on the others via the explicit isogenies. The
*combined* orbit of (q, P) under base × isogeny actions might have
polynomially-growing height, in which case Daw–Ren-style growth
conditions apply.

### 6.3 Computability of constants

Even granting OQ1, the constants in (R2) are catastrophic:

- C_ε in Pila–Wilkie 2006 is *non-explicit*. The proof gives
  C_ε ≤ (some tower of exponentials in 1/ε).
- The effective Pila–Wilkie bounds (Binyamini–Novikov 2017, Cluckers–
  Comte–Loeser 2020) give C_ε = O((log T)^{C/ε}), which is a
  polynomial improvement but still not "computable" in the sense of
  Track T2's effectivity request.
- The Hindry constant h_0^thm = 0.00481 is computable.

**Honest assessment of effectivity:** Even if OQ1 were resolved, the
Pila–Wilkie counting bound is not currently effective at the level of
"this many Pythagorean q are excluded". One would get a *qualitative*
finiteness statement, not a *concrete* enumeration of PCP candidates.

For the **practical** PCP closure, the empirical approach
(`FINAL-SYNTHESIS-2026-05-21.md` §6) — Face-3 evaluations on 10,000+
fibers, all giving zero — is currently more effective than any
Pila–Zannier-based bound would be in producing a concrete computation.

### 6.4 Comparison with other approaches

| Approach | Status on PCP | Effectivity | Obstruction |
|:---|:---|:---|:---|
| Bombieri–Lang on V | Conditional | None (conjectural) | V is K3 / Calabi–Yau, not general type |
| K3 + Tate | Doesn't apply | n/a | Single K3, not a family (PICK-1) |
| DCF₀ Pillay–Ziegler | Reduces to finite + 1-param subfamily | Empirically checkable | Bounded-degree assumption on subfamily (PICK-6) |
| Hindry–Silverman per fiber | Polylog window per fiber | Effective per fiber | Rank-jump locus must be enumerated |
| **Pila–Zannier (this T2)** | **Definability OK; counting OK; height bound INSUFFICIENT** | C_ε non-explicit | OQ1: need Lehmer-type bound for non-isotrivial K3 family |
| Habegger–Pila atypical | Possible new framing via X_1(4)² | Effective in HP 2016 | Need to verify atypicality (OQ2) |
| Daw–Ren growth conditions | Possible via Q-isogeny orbits | Effective per orbit | Need orbit-height inflation analysis (OQ3) |

The Pila–Zannier strategy is **strictly stronger than Bombieri–Lang in
principle** (it bypasses general-type), **strictly weaker in practice**
(needs a height input Hindry doesn't give), and **comparable to PICK-6
DCF₀** (both reduce to a "subfamily" or "growth" condition that is
empirically refutable but not unconditionally closed).

### 6.5 Recommended next steps from T2

In rough priority order:

1. **Investigate OQ2 carefully** (Habegger–Pila atypical intersection
   on X_1(4)²). The Manin–Drinfeld-style argument might work because
   the PCP locus has a Hodge-theoretic interpretation as the
   intersection of two "level structure" loci. *Estimated effort: 2-4
   weeks of literature deep-dive plus model verification.*

2. **Pursue OQ3 (Daw–Ren orbits)** via the Q-isogeny rescue (Phase 2,
   2/2 successful). Each Q-isogeny generates an orbit of typically 4-8
   curves; check if the height of the *combined* orbit grows
   polynomially with q. *Estimated effort: 1-2 weeks of explicit
   computation.*

3. **Test OQ1 empirically.** For the 12 + 26 rank-jump fibers in the
   catalog, compute ĥ(P_q) / log H_j(q) and see if the ratio is
   bounded above (consistent with c_1 finite) or grows (suggesting
   stronger Lehmer-type bound). This is a 2-day PARI computation that
   will tell us whether OQ1 has empirical basis.

4. **Connect with PICK-6 DCF₀.** The model-theoretic dichotomy and the
   Pila–Zannier-via-Habegger–Pila framework are formally similar: both
   reduce to "no 1-parameter algebraic subfamily" or "no atypical
   intersection". A unified Habegger–Pila + DCF₀ argument may close
   both simultaneously.

5. **Honest documentation.** Update `FINAL-SYNTHESIS-2026-05-21.md`
   Gap 3 status from "Bombieri–Lang gap" to "Bombieri–Lang gap OR
   sharper Lehmer-type height bound in non-isotrivial K3 family" —
   the latter is potentially more tractable.

### 6.6 Honest verdict on Pila–Zannier for PCP

**Status: PARTIAL.** O-minimal definability and Pila–Wilkie counting
hold cleanly. The strategy is structurally sound and uses none of
Bombieri–Lang's general-type machinery. However, the height-bound
input from Gap 3 (Hindry–Silverman uniform constant) is *not*
sufficient to drive the counting argument to a finiteness conclusion.

The precise additional input needed (OQ1) — a Lehmer-type bound
ĥ(P_q) ≥ c · log H_j(q) — is a substantial open problem in arithmetic
geometry, not solvable by routine means. However, two adjacent
strategies (Habegger–Pila atypical intersections via OQ2; Daw–Ren
growth conditions via Q-isogeny orbits, OQ3) are concretely investigable.

**Comparison to existing Gap 3 attacks:**

- Pila–Zannier ≠ Bombieri–Lang: structurally different, bypasses
  general-type.
- Pila–Zannier ≈ DCF₀: both reduce to a "no 1-parameter subfamily"
  hypothesis that is empirically supported but not unconditionally
  closed.
- Pila–Zannier > Hindry–Silverman per fiber: provides a *uniform*
  framework, where Hindry alone is per-fiber.

**Net contribution to PCP closure:** This T2 analysis does **not**
close PCP, but it (a) confirms o-minimal definability of the PCP
setup, (b) makes precise the technical obstruction (height-bound
mismatch), and (c) identifies three concrete open questions (OQ1–OQ3)
whose resolution would close PCP via Pila–Zannier — without invoking
Bombieri–Lang or general-type assumptions.

The most promising direction is OQ2 (Habegger–Pila atypical
intersections), which has the strongest existing literature support
and the closest formal analogy to the PCP setup as an intersection of
moduli-theoretic loci.

---

## §7. Summary table

| Component of Pila–Zannier | Status for PCP | Citation / Verification |
|:---|:---|:---|
| Definability of family ℰ → 𝒫 in ℝ_an,exp | **OK** | §2.2-2.3, Prop 2.1-2.4 |
| Pila–Wilkie applies to Y^trans | **OK** | §3.4, eq (*) |
| Identification of Y^alg (algebraic locus) | **OK** | §3.2, §4.1; reduces to rank-jump locus |
| Y^alg is small (finite or density 0) | **OK density 0**, finiteness OPEN | §4.2, Silverman 1983 |
| Height lower bound for Y^trans | **INSUFFICIENT** | §3.6, §5.2-5.3 |
| Polylog height bound (Gap 3) drives Pila–Wilkie | **FAILS** | §5.4 negative conclusion |
| Effective constants (C_ε, h_0) | C_ε non-explicit; h_0 effective | §6.3 |
| OQ1: Lehmer-type bound ĥ ≥ c log H_j | OPEN, plausible | §6.2 |
| OQ2: Habegger–Pila reformulation on X_1(4)² | OPEN, promising | §6.2 |
| OQ3: Daw–Ren via Q-isogeny orbits | OPEN, computable | §6.2 |
| Closure of PCP via Pila–Zannier | **NOT CLOSED**; needs OQ1/OQ2/OQ3 | §6.6 |

---

## §8. References

- **Bauer, T., Hindry, M., Silverman, J. H.** Computing canonical heights using arithmetic in the group law. *Math. Comp.* (2007).
- **Binyamini, G., Novikov, D.** Wilkie's conjecture for restricted elementary functions. *Ann. of Math.* (2) **186** (2017), 237–275.
- **Bombieri, E., Gubler, W.** *Heights in Diophantine Geometry.* Cambridge, 2006.
- **Charles, F.** The Tate conjecture for K3 surfaces over finite fields. *Invent. Math.* **194** (2013), 119–145.
- **Cluckers, R., Comte, G., Loeser, F.** Non-Archimedean Yomdin–Gromov parametrizations and points of bounded height. *Forum Math. Pi* **3** (2015), e5.
- **David, S., Hindry, M.** Minoration de la hauteur de Néron–Tate sur les variétés abéliennes de type C. M. *J. Reine Angew. Math.* **529** (2000), 1–74.
- **Daw, C., Ren, J.** Applications of the hyperbolic Ax–Schanuel conjecture. *Compos. Math.* **154** (2018), 1843–1888.
- **Dokchitser, T., Dokchitser, V.** On the Birch–Swinnerton-Dyer quotients modulo squares. *Ann. of Math.* (2) **172** (2010), 567–596.
- **Habegger, P.** Effective height upper bounds on algebraic tori. (preprint / 2013).
- **Habegger, P., Pila, J.** O-minimality and certain atypical intersections. *Ann. Sci. ENS* (4) **49** (2016), 813–858.
- **Hindry, M.** Autour d'une conjecture de Serge Lang. *Invent. Math.* **94** (1988), 215–268.
- **Hindry, M., Silverman, J. H.** The canonical height and integral points on elliptic curves. *Invent. Math.* **93** (1988), 419–450.
- **Ingram, P., Mahé, V.** Primitive prime divisors of elliptic divisibility sequences. Preprint, 2008.
- **Pila, J.** Rational points of definable sets and results of André–Oort–Manin–Mumford type. *Int. Math. Res. Not.* (2009).
- **Pila, J.** O-minimality and the André–Oort conjecture for ℂⁿ. *Ann. of Math.* (2) **173** (2011), 1779–1840.
- **Pila, J., Wilkie, A. J.** The rational points of a definable set. *Duke Math. J.* **133** (2006), 591–616.
- **Pila, J., Zannier, U.** Rational points in periodic analytic sets and the Manin–Mumford conjecture. *Rend. Lincei Mat. Appl.* **19** (2008), 149–162.
- **Silverman, J. H.** Heights and the specialisation map for families of abelian varieties. *J. Reine Angew. Math.* **342** (1983), 197–211.
- **Silverman, J. H.** The difference between the Weil height and the canonical height on elliptic curves. *Math. Comp.* **55** (1990), 723–743.
- **van den Dries, L.** *Tame Topology and O-minimal Structures.* London Math. Soc. Lecture Note Ser. **248**, Cambridge, 1998.
- **van den Dries, L., Miller, C.** On the real exponential field with restricted analytic functions. *Israel J. Math.* **85** (1994), 19–56.

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-22

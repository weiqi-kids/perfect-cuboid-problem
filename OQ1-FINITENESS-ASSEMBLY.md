---
title: "OQ1 ⟹ Finiteness? The Pila–Zannier Assembly for PCP — GAPPED at the Galois-Orbit Lower Bound (No T^δ; PCP Points Are ℚ-Rational, Degree 1)"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-26
status: |
  VERDICT: GAPPED-at-the-T^δ-lower-bound (case (b) of the task, sharpened to a NAMED missing
  ingredient that is in fact STRUCTURALLY ABSENT, not merely open). The implication
  [uniform OQ1: ĥ(P_q) ≥ c₁ log H_j(q) − c₂ on density-1 of 𝓡] ⟹ [PCP candidates FINITE on
  density-1 of 𝓡] is NOT PROVED and, as stated, CANNOT be assembled from OQ1 + Pila–Wilkie.
  Reason (triple-sourced, primary literature): the Pila–Zannier / Habegger–Pila finiteness engine
  upgrades the Pila–Wilkie UPPER bound #{pts of height ≤ T} ≤ C_ε T^ε to finiteness ONLY by opposing
  it to a LOWER bound on the NUMBER OF GALOIS CONJUGATES of a single special point: #conjugates ≥ c·T^δ,
  δ>0 (Masser's degree bound for torsion; Rémond + Large-Galois-Orbit hypothesis for atypical
  intersections). Habegger–Pila 2016 state explicitly that they do NOT use height LOWER bounds
  (Bogomolov/Dobrowolski) to pass from bounded height to finiteness — they use the Galois-orbit count.
  A perfect-cuboid PCP candidate is ℚ-RATIONAL (q ∈ ℚ Pythagorean, P ∈ E_PCP(q)(ℚ)): its degree over ℚ
  is 1, it has NO non-trivial Galois conjugates, so the available "T^δ" is T^0 = 1. OQ1 is a height
  LOWER bound on ONE ℚ-rational point — the WRONG TYPE of input: it is neither a count-of-conjugates
  lower bound nor a height UPPER bound, and the one sentence in OQ1-HS-RESOLUTION.md §5 / PILA-ZANNIER-OQ2.md
  that asserts "OQ1 ⟹ finiteness" is a non-sequitur (a tautology when unwound; see §3.4). NET: the
  STATUS-2026-05-26 step-5 ("Pila–Wilkie + uniform OQ1 ⟹ finite") is FALSE as an implication; the
  density-1 UNCONDITIONAL FINITENESS claim does NOT stand on the Pila–Zannier route. The missing
  ingredient (a large Galois orbit / a T^δ count) is not "open" — it is absent by the ℚ-rationality
  of the points; supplying it requires a DIFFERENT mechanism (algebraic-point spreading, or genuine
  Chabauty/Coleman per-fiber finiteness), not OQ1.
---

# OQ1 ⟹ Finiteness? The Pila–Zannier Assembly for PCP — Honest Failure Located

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-26

> **One-paragraph verdict.** I attempted to assemble
> `[uniform OQ1: ĥ(P_q) ≥ c₁ log H_j(q) − c₂ on density-1 of 𝓡] ⟹ [PCP candidates FINITE on
> density-1 of 𝓡]`. **It does not assemble.** The o-minimal definability (T2 §2) and the Pila–Wilkie
> upper bound (T2 §3) are correct and unconditional. But the step that converts the `C_ε T^ε` UPPER
> bound into *finiteness* — in every incarnation of the Pila–Zannier method (Manin–Mumford,
> André–Oort, Habegger–Pila atypical intersections) — is a **lower bound on the number of Galois
> conjugates** of a single special point (`#conj ≥ c·T^δ`, `δ>0`). For PCP the special points are
> **ℚ-rational** (degree 1, no non-trivial conjugates), so `δ=0` and the engine produces nothing.
> OQ1 is a height *lower* bound on *one* point; the literature (Habegger–Pila 2016, verbatim) says
> such height bounds are explicitly **not** what drives finiteness, and a height *lower* bound is
> neither the Galois-orbit count that does, nor even the height *upper* bound that confines. The
> framework's single asserting sentence (`OQ1-HS-RESOLUTION.md` §5; `PILA-ZANNIER-OQ2.md` §5.3) gives
> no `T^δ` and, unwound, is a tautology (§3.4). **GAPPED at §3; the gap is the absent Galois orbit.**

---

## §1. The o-minimal setup recalled (definability, Y^alg, Y^trans)

This section records what is correct and is *not* the gap. (Verified in `PILA-ZANNIER-T2.md` §2; I
re-checked the statements against the structure of the family and find them sound.)

- **Family.** `E_PCP(q): Y² = X(X+1)(X+q²)`, `q = (m²−n²)/(2mn)`; universal real-analytic 3-fold
  `𝓔_ℝ → 𝓟_ℝ`, `𝓟_ℝ = {(m,n)∈ℝ² : 0<n<m}`. Torsion is universally `ℤ/4×ℤ/2` (Lemma 1).
- **Definability (T2 Prop 2.1–2.4).** `𝓔_ℝ` is semi-algebraic; the real Weierstrass uniformization
  `Φ(m,n,u) = (m,n, ℘_q(uω₁), ½℘'_q(uω₁))` is definable in `ℝ_{an,exp}` (℘ real-analytic on compact
  period boxes; the `u ↔ u/ω₁` exponential rescaling globalizes as `q→0,∞`). **Correct.**
- **`Y^alg` (T2 §3.2).** The maximal algebraic part of the uniformized PCP locus `Y` = (constant-`q`
  fibers) ∪ (the 8 torsion sections). The torsion sections are degenerate by Lemma 1; the constant-`q`
  fibers meet `ℚ⁴` in `E_q(ℚ)` (the per-fiber Mordell–Weil problem). **Correct.**
- **`Y^trans` (T2 §3.3).** `Y^trans = Y ∖ Y^alg`. A perfect cuboid not lying on an already-known fiber
  would map to a rational point of `Y^trans`. **Correct.**

> **The T2 doc's own claim "the ONLY obstacle was the height bound" is FALSE.** I flag this as the
> central error this assembly exposes. T2 itself (§3.5–§3.7, §5.4) actually says the height *input*
> is insufficient, but it frames the missing piece as "a height bound with polynomial growth in the
> moduli height" — i.e. it presumes that *some* height lower bound, if it grew fast enough, would
> close the argument. **That presumption is wrong** (§2–§3 below): no height *lower* bound, however
> fast-growing, defeats Pila–Wilkie. Only a *count* lower bound (Galois orbit) does. OQ1 fixed the
> wrong input.

---

## §2. The Pila–Wilkie upper bound (precise statement)

**Theorem (Pila–Wilkie 2006, Duke Math. J. 133, 591–616).** Let `X ⊂ ℝⁿ` be definable in an o-minimal
expansion of `ℝ_alg`, and let `X^trans` be `X` minus the union of all connected positive-dimensional
semialgebraic subsets. Then for every `ε>0` there is `C_ε(X)` with
$$ \#\{P \in X^{\mathrm{trans}} \cap \mathbb{Q}^n : H(P) \le T\} \ \le\ C_\varepsilon(X)\, T^{\varepsilon}, \qquad T \ge 1, $$
`H` the multiplicative naïve height. Effective refinements (Binyamini–Novikov 2017 for restricted
elementary functions; Cluckers–Comte–Loeser 2015) sharpen `T^ε` to `N·(log T)^κ` in favorable cases.

**Two facts about this bound, both decisive for §3:**

(PW-1) **It is an UPPER bound only.** `C_ε T^ε → ∞` (and even `(log T)^κ → ∞`). By itself it never
gives finiteness; it certifies *sparsity*, not *boundedness*. (T2 §3.5 says this correctly.)

(PW-2) **To get finiteness you need a matching LOWER bound on a COUNT.** The Pila–Zannier mechanism
(below) supplies, for a *single* special point `P` of "complexity `T`", a lower bound
`#{distinct rational points of `X^trans` of height ≤ poly(T) forced to exist} ≥ c·T^δ`, `δ>0`. Then
`c T^δ ≤ C_ε (poly T)^ε`, take `ε < δ/(deg poly)`, conclude `T` bounded ⟹ finitely many such `P`.

---

## §3. The finiteness mechanism — the `T^δ` lower bound: does OQ1 supply it?

### 3.1 What the `T^δ` is, in the literature (primary sources, verbatim)

**Pila–Zannier 2008 (Manin–Mumford), `arXiv:0802.4016`, end of §3** (fetched, ar5iv HTML):

> "for `P ∈ tor(A)` set `d(P)=[K(P):ℚ]`. Then Masser [M] proves that `d(P) ≥ c₂(A) T^ρ`" … "all the
> conjugates of `P` over a number field of definition for both `A,X` are still torsion points on `X`,
> of the same order as `P`. … the number of such conjugates is at least `c₃(A) T^ρ`."

The proof: a torsion point of order `T` lifts to a rational point of the fundamental domain of height
`≤ poly(T)`; **all `≥ c₃ T^ρ` Galois conjugates** also lift, to *distinct* rational points of the
*same* `Z^trans`, all of height `≤ poly(T)`. Pila–Wilkie caps these at `C_ε (poly T)^ε`; for `ε<ρ`,
`T` is bounded ⟹ finitely many torsion points off `Z^alg`. **The `T^δ = T^ρ` is the number of Galois
conjugates** (Masser's degree bound).

**Habegger–Pila 2016 (atypical intersections), `arXiv:1409.0771`** (fetched, ar5iv HTML):

> "All current approaches towards Theorem 1.1 require a height upper bound on the set of points in
> question. … we use Rémond's height bound." (the **upper** bound, to confine to bounded height)
>
> "the 'Large Galois Orbit' hypothesis (LGO) … asserts that … certain ('optimal') isolated
> intersection points … have a 'large' Galois orbit." (the **lower** bound that gives finiteness)
>
> "In contrast to previous approaches we do not rely on delicate Dobrowolski-type or Bogomolov-type
> **height lower bounds** to pass from bounded height to finiteness … Instead we use a variation of
> the strategy originally devised by Zannier … the Pila–Wilkie point counting result."

**Cross-source agreement (also Scanlon survey "Counting special points"; H. Schmidt, "Counting
rational points and lower bounds for Galois orbits").** The division of labor is invariant across the
whole method:

| Ingredient | Type | Role |
|---|---|---|
| Pila–Wilkie | UPPER bound on a count | sparsity: `≤ C_ε T^ε` |
| Height bound (Rémond/Néron–Tate) | UPPER bound on height | confine special points to one bounded window |
| **Large Galois Orbit** (Masser; LGO) | **LOWER bound on a count (#conjugates ≥ T^δ)** | **the step that yields finiteness** |

> Habegger–Pila explicitly **reject** height *lower* bounds as the finiteness driver. OQ1 is precisely
> a height *lower* bound. It is the input the method does **not** use.

### 3.2 The PCP points are ℚ-rational — the Galois orbit is trivial

A perfect-cuboid PCP candidate is `(q, P)` with:
- `q = (m²−n²)/(2mn) ∈ ℚ` Pythagorean (a rank-jump `q ∈ 𝓡`): `[ℚ(q):ℚ] = 1`;
- `P ∈ E_PCP(q)(ℚ)` non-torsion: `[ℚ(P):ℚ] = 1`;
- `F₃(q,P) = 1+q²+c(P)² ∈ ℚ^{×2}`.

It maps to a **single** rational point `y(q,P) ∈ Y^trans` of degree 1 over ℚ. **It has no non-trivial
Galois conjugates.** Hence the only available count lower bound is
$$ \#\{\text{Galois conjugates of } y(q,P)\} = 1 = T^{0}. $$
`δ = 0`. The Pila–Zannier engine returns `C_ε T^ε ≥ 1`, i.e. nothing. **This is structural, not a
quantitative shortfall**: there is no degree to grow, because Pythagorean `q` and rational cuboid edges
are by definition rational. (This is exactly the obstruction T2 §4.3 noted — "there is no Galois action
… every Pythagorean q is a ℚ-rational point, so Galois conjugation is trivial" — and then *forgot* when
it pinned the blame on the height bound.)

### 3.3 So what does OQ1 actually give, and where could it enter?

OQ1 gives, for that one point, `ĥ(P) ≥ c₁ log H_j(q) − c₂`. There are exactly two slots in the
mechanism where an arithmetic input enters, and OQ1 fits neither:

- **Slot A — the count lower bound (`T^δ`).** OQ1 is not a statement about *how many* points exist;
  it bounds the *height of one* point. It cannot occupy Slot A. (Slot A is the empty Galois orbit.)
- **Slot B — the height *upper* bound (confinement to a bounded window).** The method needs
  `H(y) ≤ poly(complexity)`. OQ1 points the *wrong way*: it is a *lower* bound `ĥ(P) ≥ …`. It does not
  confine `P` to bounded height; on the contrary it forces `ĥ(P)` to **grow** with `H_j(q)`, pushing
  points to *larger* height as the parameter grows — the opposite of confinement.

### 3.4 The framework's "OQ1 ⟹ finiteness" sentence, unwound — it is a tautology

The only place the implication is asserted is one sentence, in two near-identical forms:

> `OQ1-HS-RESOLUTION.md` §5: "the height lower bound forces sporadic generators to have `H_j` bounded
> by a polynomial in their canonical height, yielding finiteness."
> `PILA-ZANNIER-OQ2.md` §5.3 / `STATUS-2026-05-26` step 5: "Pila–Wilkie counting + uniform OQ1 ⟹ PCP
> candidates finite."

Unwind it. OQ1 rearranges to
$$ \log H_j(q) \ \le\ \frac{\widehat h(P) + c_2}{c_1}. \qquad (\ast) $$
To bound `H_j(q)` (hence the number of admissible `q`, hence finiteness) from `(\ast)` one needs an
**upper bound on `ĥ(P)`**. The sporadic Mordell–Weil generator's canonical height is **unbounded**
across the family — indeed OQ1's *own* empirical content (T2′ §3, slope `c₁≈0.05`) is that
`ĥ(P) ≈ c₁ log H_j(q)` *grows*. Substituting any such growth into `(\ast)` gives
`log H_j(q) ≤ (c₁ log H_j(q)+c₂)/c₁ = log H_j(q) + c₂/c₁`, a **tautology** that bounds nothing. There is
no independent upper bound on `ĥ(P)` anywhere in the chain. (The numerical/logical accounting is in
`scripts/oq1_finiteness/logic_check.py`.) **The sentence is a non-sequitur.**

### 3.5 Is there any o-minimal route to finiteness from a height *lower* bound alone?

No known one. The strongest Pila–Wilkie refinements still give `N·(log T)^κ`, **unbounded** as
`T→∞` (Wilkie's conjecture / Binyamini–Novikov). A height lower bound on one rational point produces
one point per parameter and no conjugates; the count is `1`, never `T^δ`. Across Manin–Mumford,
André–Oort (Pila 2011), Habegger–Pila 2016, Daw–Ren 2018, and the Zilber–Pink program, **every**
finiteness output is `(Pila–Wilkie upper) ∧ (height upper, to confine) ∧ (Galois-orbit lower, to
finish)`. The Galois-orbit lower bound is never substitutable by a height lower bound — that is the
explicit content of the Habegger–Pila quote in §3.1.

> **§3 verdict.** OQ1 does **NOT** supply the `T^δ` lower bound. There is no `T^δ` available at all,
> because PCP candidates are ℚ-rational (Galois orbit = 1). The implication is **GAPPED**, and the gap
> is exactly the absent large Galois orbit. This is task-case **(b)**, sharpened: the missing
> ingredient is not merely "open" — it is structurally absent for ℚ-rational points, and OQ1 is the
> wrong type of theorem to supply it.

---

## §4. The assembled theorem — modulo the named (absent) ingredient

Since the implication is gapped, I state the **honest conditional** — exactly the theorem that *would*
hold *if* the missing ingredient existed, with the ingredient named — and then explain why the
ingredient is not available.

**Theorem 4.1 (conditional; the most that the o-minimal route gives).**
Suppose, in addition to (i) the `ℝ_{an,exp}`-definability of `Y` (§1, T2 Prop 2.1–2.4) and (ii) the
Pila–Wilkie bound (§2), there is a function `κ: [1,∞) → [1,∞)`, `κ(T)→∞`, and `δ>0`, `D≥1`, such that:

> **(LGO_PCP) [the missing ingredient].** Every PCP candidate `(q,P)` of "complexity" `T := H_j(q)`
> gives rise to `≥ κ(T)·T^δ` *distinct* rational points of `Y^trans`, all of height `≤ T^{D}`.

Then the set of PCP candidates on density-1 of `𝓡` is **finite**.

*Proof.* If `(q,P)` is a candidate with `H_j(q)=T`, (LGO_PCP) yields `≥ κ(T)T^δ` distinct rational
points of `Y^trans` of height `≤ T^D`. Pila–Wilkie (with `ε := δ/(2D)`) caps these at
`C_ε (T^D)^{ε} = C_ε T^{δ/2}`. So `κ(T)T^δ ≤ C_ε T^{δ/2}`, i.e. `κ(T) ≤ C_ε T^{−δ/2}`, forcing `T`
bounded. Finitely many `q` with `H_j(q)` bounded; each contributes finitely many candidates (per-fiber
Mordell–Weil + Lemma 1). ∎

**The roles, made explicit.**
- §1 (definability) and §2 (Pila–Wilkie) are **unconditional and used**.
- The entire force is in **(LGO_PCP)**, a *count* lower bound. This is the slot OQ1 was meant to fill.
- **OQ1 fills no slot in this proof.** It is a height lower bound on a single point; (LGO_PCP) needs
  *many distinct points*. OQ1 is neither necessary nor sufficient for (LGO_PCP).

**Why (LGO_PCP) is not available (and not what OQ1 is).**
For Manin–Mumford, (LGO) holds because torsion points of order `T` have `≥ T^ρ` Galois conjugates,
all torsion on `X`, all of bounded height (Masser). For PCP, the candidate is **ℚ-rational** (§3.2):
its Galois orbit is `{itself}`, giving `1 = T^0` points, so `δ=0` and (LGO_PCP) **fails with `δ=0`**.
To recover `δ>0` one would need a *different* source of many distinct points of bounded height — e.g.
spreading a candidate into an algebraic family of growing degree (a `ℚ̄`-construction), or an
isogeny/Hecke orbit that produces genuinely new bounded-height rational points (the OQ3 / Daw–Ren idea
— but `PILA-ZANNIER-OQ2.md` §2.5 leaves it open, and the body-diagonal condition is non-modular so no
Hecke orbit acts). **None of these is OQ1**, and none is currently available.

> **Therefore Theorem 4.1's hypothesis (LGO_PCP) is NOT discharged by OQ1, nor by anything in the
> framework.** The "uniform OQ1 ⟹ finiteness" implication of `STATUS-2026-05-26` step 5 is **false as
> an implication**: OQ1 is true (per-fiber; uniformly on density-1 modulo ABC), but it does not imply
> finiteness via Pila–Zannier.

---

## §5. Honest verdict: PROVED / GAPPED-at-X / NEEDS-Y

> **VERDICT: GAPPED.** The implication
> `[uniform OQ1 on density-1 of 𝓡] ⟹ [PCP candidates finite on density-1 of 𝓡]`
> is **GAPPED at the `T^δ` Galois-orbit lower bound** (§3). Precisely:

1. **§1 definability — SOUND.** `Y` is definable in `ℝ_{an,exp}`; `Y^alg`, `Y^trans` correctly
   identified. (But the T2 claim "the only obstacle was the height bound" is **wrong**; §1 above.)
2. **§2 Pila–Wilkie — SOUND but only an UPPER bound.** Gives `≤ C_ε T^ε`; never finiteness alone.
3. **§3 the finiteness step — GAPPED.** Pila–Zannier finiteness = Pila–Wilkie-upper defeated by a
   **lower bound on the number of Galois conjugates** (`≥ T^δ`, `δ>0`: Masser for torsion; LGO +
   Rémond for atypical intersections; Habegger–Pila 2016 verbatim reject height *lower* bounds as the
   driver). PCP candidates are **ℚ-rational** (degree 1, no conjugates), so the available count is
   `T^0 = 1` and `δ=0`. **OQ1 is a height *lower* bound on one point — the wrong type of input** (not a
   count lower bound, not a height *upper* bound). The single framework sentence asserting
   "OQ1 ⟹ finiteness" is a non-sequitur (a tautology when unwound, §3.4).
4. **NEEDS-Y.** Y = a genuine `T^δ` count: either a Large-Galois-Orbit / algebraic-degree-spreading
   mechanism that turns one ℚ-rational candidate into `≥ T^δ` distinct bounded-height points
   (structurally absent here; the points are rational and the body-diagonal condition is non-modular,
   so no Hecke/isogeny orbit acts — `PILA-ZANNIER-OQ2.md` §2.4–§2.5), **or** an entirely different
   route to per-fiber/uniform finiteness (Chabauty–Coleman, which the framework pursues separately and
   which does *not* go through Pila–Zannier).

**Consequence for the density-1 unconditional finiteness claim.**
The claim in `STATUS-2026-05-26-CONSOLIDATED.md` (§1 step 5, §0 summary) that "PCP-candidate finiteness
on a density-1 sub-locus of `𝓡` is UNCONDITIONAL via … (iii) the Pila–Zannier counting argument"
**does not stand**: its step (iii) is the gapped implication above. Steps (i)–(ii) (per-fiber OQ1 via
Petsche; small Szpiro ratio on density 1) are independently fine, but they feed an engine that has no
fuel. The unconditional *finiteness* output is therefore **not established on the Pila–Zannier route**;
what *is* unconditional on density-1 of `𝓡` is the *height lower bound* OQ1 itself — which is a real
theorem but is not finiteness. (The framework's genuine partial finiteness lives elsewhere — the
per-fiber Silverman/Ingram–Mahé closures of `EXCEPTIONAL-SET-CLOSURE.md` and the genus-3 Coleman bound
of `GENUS3-COLEMAN-COVER.md` — and those do **not** use Pila–Zannier.)

This is **the fourth overclaim caught.** The honest located gap is the deliverable: *Pila–Zannier
cannot close PCP because perfect cuboids are ℚ-rational and supply no Galois orbit; OQ1, though true,
is the wrong type of input and does not imply finiteness.*

---

## §6. References

- **Pila, J., Wilkie, A. J.** The rational points of a definable set. *Duke Math. J.* **133** (2006),
  591–616. [the `C_ε T^ε` upper bound]
- **Pila, J., Zannier, U.** Rational points in periodic analytic sets and the Manin–Mumford conjecture.
  *Rend. Lincei Mat. Appl.* **19** (2008), 149–162. `arXiv:0802.4016`. [§3: `d(P) ≥ c₂ T^ρ` (Masser);
  `#conjugates ≥ c₃ T^ρ` is the `T^δ`; verbatim §3.1 above]
- **Masser, D. W.** Lower bounds for the degrees of torsion points on abelian varieties. [degree of a
  torsion point of order `T` is `≫ T^ρ`, `ρ>0` depending on `dim A`]
- **Habegger, P., Pila, J.** O-minimality and certain atypical intersections. *Ann. Sci. ENS* (4)
  **49** (2016), 813–858. `arXiv:1409.0771`. [Rémond height *upper* bound to confine; Large Galois
  Orbit (LGO) lower bound to finish; "we do not rely on … height *lower* bounds to pass from bounded
  height to finiteness" — verbatim §3.1 above]
- **Daw, C., Ren, J.** Applications of the hyperbolic Ax–Schanuel conjecture. *Compos. Math.* **154**
  (2018), 1843–1888. [Zilber–Pink via LGO + functional transcendence; still a Galois-orbit lower bound]
- **Scanlon, T.** Counting special points: Logic, Diophantine geometry, and transcendence theory.
  *Bull. AMS* **49** (2012). [survey: "one opposes an upper bound from point-counting to a lower bound
  … for the size of a Galois orbit"]
- **Schmidt, H.** Counting rational points and lower bounds for Galois orbits. [title alone confirms
  the lower bound is a Galois-orbit count]
- **Binyamini, G., Novikov, D.** Wilkie's conjecture for restricted elementary functions. *Ann. of
  Math.* **186** (2017), 237–275. [effective PW: `N·(log T)^κ`, still `→∞`]
- **Petsche, C.** Small rational points on elliptic curves over number fields. `arXiv:math/0508160`
  (2005). [the per-fiber OQ1 input `ĥ(P) ≥ c(d,σ) log|Δ|`; a height *lower* bound]

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-26

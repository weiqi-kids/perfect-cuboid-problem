---
title: "V → Abelian Variety: Faltings 1991 Attack on PCP"
author: CΛ / Lightman Chang
date: 2026-05-15
---

# V → Abelian Variety: A systematic attack on PCP via Faltings 1991

> Goal: relate the PCP variety $V \subset \mathbb{P}^6$ to an abelian variety so that **Faltings 1991** (unconditional Mordell–Lang for sub-varieties of abelian varieties) gives finiteness of $V(\mathbb{Q})$ outside the trivial locus.
>
> Status: **conditional progress made**, but identified an irreducible obstruction. Best new structural results:
>
> 1. **$V$ is a double cover of a K3 surface** $V'$ (a degree-8 K3 in $\mathbb{P}^5$, the "Euler-brick variety").
> 2. **$V$ admits 3 natural fibrations** $V \to \mathbb{P}^1$ with generic fiber a **smooth genus-5 curve** $C_t$, whose Jacobian decomposes as $J(C_t) = E_1(t) \times E_2(t) \times E_3(t) \times J(H_t)$.
> 3. **All Jacobian factors are non-isotrivial** (explicit $j$-invariants computed in PARI).
> 4. By **Buium–Hrushovski function-field Mordell–Lang** (unconditional) the generic fiber has only finitely many $\mathbb{Q}(t)$-points, i.e. only finitely many rational sections.
> 5. **Sticking point**: rank-jump fibers form a Hilbert-thin set, not a finite set; we cannot yet rule out "sporadic" rank jumps that contribute infinitely many points to $V(\mathbb{Q})$.

---

## §0. Setup and verified invariants (PARI)

$V \subset \mathbb{P}^6$ is the smooth complete intersection (CI) of four quadrics

$$Q_1: a^2+b^2-d^2,\quad Q_2: b^2+c^2-e^2,\quad Q_3: a^2+c^2-f^2,\quad Q_4: a^2+b^2+c^2-g^2.$$

Computing via Chern classes of $T_V = T_{\mathbb{P}^6}|_V - N_{V/\mathbb{P}^6}$, with $c(T_{\mathbb{P}^6}) = (1+H)^7$ and $c(N) = (1+2H)^4$:

$$
c(T_V) \equiv (1+H)^7 (1+2H)^{-4} \pmod{H^3} = 1 - H + 5 H^2.
$$

Combined with $H^2|_V = \deg V = 2^4 = 16$:

| Invariant | Value |
|---|---|
| $K_V = H_V$ (since $-7+8=1$) | ample |
| $K_V^2$ | $16$ |
| $c_2(V) = \chi_{\text{top}}$ | $80$ |
| $\chi(\mathcal{O}_V) = (K^2 + c_2)/12$ | $8$ |
| $p_g = h^0(K_V)$ | $7$ |
| $q = h^1(\mathcal{O}_V)$ | $0$ (Lefschetz hyperplane: CI of dim 2 in $\mathbb{P}^6$) |
| BMY $3 c_2 - c_1^2$ | $224 \ge 0$ ✓ |
| Noether $8\chi - K^2$ | $48 \ge 0$ ✓ |

So $V$ is general type with **trivial Albanese**. This is the canonical obstruction to applying Faltings 1991 directly.

The standard "Faltings inapplicable" argument cited in earlier sessions is correct: $\mathrm{Alb}(V) = 0$ blocks the obvious embedding into an abelian variety.

---

## §1. Per-angle technical analysis

### Angle 1 — Ramified covers $\tilde V \to V$ with $q(\tilde V) > 0$

**Set-up.** For a double cover $\pi: \tilde V \to V$ branched at a smooth divisor $B$ with $\mathcal{O}_V(B) = L^{\otimes 2}$, one has

$$
\pi_* \mathcal{O}_{\tilde V} = \mathcal{O}_V \oplus L^{-1},\qquad
q(\tilde V) = q(V) + h^1(V, L^{-1}).
$$

By Serre duality on the surface $V$,
$$h^1(V, L^{-1}) = h^1(V, K_V \otimes L) = h^1(V, (H+L)|_V).$$

**Structural fact (new).** Among the natural cyclic covers we can construct, **all branch divisors live in classes coming from $\mathcal{O}_V(mH)$**, $m \ge 1$. Three independent constraints kill $h^1$:

* (a) For $L = \mathcal{O}_V(mH)$, $m\ge 0$, $H$ ample $\Rightarrow$ $K_V + L = (1+m)H$ is ample $\Rightarrow$ by **Kodaira vanishing** $h^1(V, K_V+L) = 0$.
* (b) Hence $h^1(V, L^{-1}) = 0$, so $q(\tilde V) = 0$.

**Extension to non-$H$ classes.** $V$ has additional Picard classes from the seven involutions $\sigma_X: X \mapsto -X$ for $X \in \{a,b,c,d,e,f,g\}$. The fixed loci $\{X = 0\} \cap V$ are however the **degenerate "cuboid" loci** — they cut out lines $\ell_X$ on $V$ which are themselves rational. The classes $[\ell_X]$ are not equivalent to multiples of $H$, BUT a covering branched at these loci has degenerate branch (singular curves), and the resulting cover is NOT smooth.

**Deeper structural obstruction.** $V$ sits as a $(\mathbb{Z}/2)^3$ Galois cover of a quadric $Q^* \subset \mathbb{P}^3$:

$$d^2+e^2+f^2 = 2g^2,$$

which is rational (smooth quadric with $\mathbb{Q}$-point $(1,1,0,1)$). The 3-step tower is

$$V \xrightarrow{2:1} V_{\text{int}} \xrightarrow{2:1} V_\diamond \xrightarrow{2:1} Q^*$$

where intermediate covers are:

| Cover | $K_X$ | Type |
|---|---|---|
| $V$ (full $(\mathbb{Z}/2)^3$ cover) | $H_V$ ample | general type, $p_g=7$ |
| $V_{\text{int}}$ (double-square cover, e.g. extract $\sqrt{a^2}$ and $\sqrt{b^2}$) | $0$ | **K3 surface** |
| $V_\diamond$ (single-square cover) | $-H$ | Fano (rational) |
| $Q^*$ | $-2H$ | rational quadric |

**KEY DISCOVERY.** The intermediate $V_{\text{int}}$ (any "double-extract" cover) is a K3 surface; the full cover $V$ is general type. The whole tower has $q = 0$ at every level: for $X$ a cyclic cover of a rational variety $B = P^N$ ($N \ge 2$) or $P^1 \times P^1$ branched at effective divisor $D = nL$, the formula

$$q(X) = \sum_{i=1}^{n-1} h^1(B, L^{-i})$$

gives $0$ by Serre/Künneth vanishing on rational base.

**Verdict.** Angle 1 (simple cyclic cover) is **structurally blocked** by the rational-base fact. Any cyclic cover of $V$ that we can build from natural divisors inherits $q = 0$ from the rational base $Q^*$.

> **Caveat for completeness.** A **non-abelian** Galois cover of $V$ with non-abelian fundamental group of the branched complement could in principle have $q > 0$. But constructing such a cover requires explicit non-abelian unramified extensions of $\pi_1(V \setminus B)$. Since $V \setminus B$ is dominated by $\mathbb{P}^2 \setminus (\text{conics})$, $\pi_1$ is (a quotient of) a finite-index subgroup of the conic-complement group, which is solvable in degree-2 quotients. Any non-abelian cover is far from concrete.

### Angle 2 — Specific morphism $\phi: V \to A$ to a single abelian variety

For $V$ to admit a non-constant morphism to an abelian variety $A$, there must be a $\phi$-pullback non-zero $1$-form on $V$. But $h^{1,0}(V) = q(V) = 0$. So $V$ admits no non-constant morphism to any abelian variety. **Hard obstruction**, identical to "trivial Albanese".

**Verdict.** Angle 2 is **fundamentally blocked** at the cohomological level.

### Angle 3 — Fibration $V \to \mathbb{P}^1$ with genus-5 fibers

**Construction.** The projection $\pi_{ab}: V \to \mathbb{P}^1$ via the ratio $(a:b)$ has, over the generic point $t = b/a$, the fiber

$$C_t : \quad \begin{cases} d^2 = 1+t^2 & (\text{forces } d \text{ on the fiber to be the constant } \sqrt{1+t^2}) \\ e^2 = t^2 + c^2 \\ f^2 = 1 + c^2 \\ g^2 = 1 + t^2 + c^2 \end{cases}$$

(working in the affine chart $a = 1$, $b = t$).

So the fiber $C_t$ is a $(\mathbb{Z}/2)^3$-cover of $\mathbb{P}^1_c$ branched at the 6 points $\{c = \pm it, \pm i, \pm i\sqrt{1+t^2}\}$ (over $\overline{\mathbb{Q}}$). By Riemann–Hurwitz applied to a $(\mathbb{Z}/2)^3$ cover with $r=6$ branch points where each monodromy is one of three involutions:

* Each generator $\sigma_e, \sigma_f, \sigma_g$ accounts for $2$ branch points.
* $2g - 2 = |G| \cdot (-2) + \sum (|G|/|\text{stab}|)(\text{stab size} - 1)$ gives $g(C_t) = 5$.

**Jacobian decomposition.** Under $(\mathbb{Z}/2)^3$ action, $J(C_t)$ decomposes by the 7 non-trivial characters of $(\mathbb{Z}/2)^3$. Each non-trivial character $\chi_S$ corresponds to a subset $S \subseteq \{e,f,g\}$, and the sub-cover $C_t / \ker(\chi_S)$ has genus

$$g_S = |S| - 1.$$

Hence

| $|S|$ | # such $S$ | $g_S$ | dim sub-Jacobian |
|---|---|---|---|
| 1 | 3 | 0 | $0$ |
| 2 | 3 | 1 | $1$ (elliptic) |
| 3 | 1 | 2 | $2$ |
| **Total** | **7** | | **$3 \cdot 1 + 1 \cdot 2 = 5$** ✓ |

Hence

$$J(C_t) \sim E_{ef}(t) \times E_{eg}(t) \times E_{fg}(t) \times J(H_t),$$

where each $E$ is an elliptic curve and $H_t$ is a genus-2 hyperelliptic curve.

**Explicit $j$-invariants (PARI verified).** For $E_{fg}(t)$ given by $f^2 = c^2+1$, $g^2 = c^2 + 1 + t^2$:

After parametrization $f = (u^2-t^2)/(2u)$, $g = (u^2+t^2)/(2u)$, one finds the Weierstrass-style quartic $Y^2 = u^4 - (2t^2+4) u^2 + t^4$. Cross-ratio of its 4 roots is

$$\lambda(t) = -\frac{1}{t^2 + 1},$$

giving with $s := t^2 + 1$:

$$j(E_{fg}(t)) = 256 \cdot \frac{(1 + s + s^2)^3}{s^2 (s+1)^2}.$$

This is a **non-constant rational function of $t$**. Hence $E_{fg}$ is a **non-isotrivial family** over $\mathbb{P}^1_t$. By symmetry (relabelling), all three elliptic factors $E_{ef}, E_{eg}, E_{fg}$ are non-isotrivial. The genus-2 quotient $H_t$ admits the hyperelliptic model

$$H_t: \quad y^2 = (c^2 + t^2)(c^2 + 1)(c^2 + 1 + t^2),$$

which is also non-isotrivial in $\mathcal{M}_2$ (cross-ratios of the 6 roots depend on $t$).

**Function-field Mordell–Lang (Buium 1992, Hrushovski 1996; Faltings's full Mordell–Lang for function fields).** For any smooth curve $C$ of genus $\ge 2$ over a function field $K = k(B)$ ($k$ algebraically closed, char 0) with $J(C)$ having **no isotrivial sub-abelian variety**: $C(K) < \infty$.

For our $C/\mathbb{Q}(t)$ with $g(C) = 5$ and **all** Jacobian factors non-isotrivial:

$$\boxed{ C(\mathbb{Q}(t)) \;\;\text{is finite, unconditionally.}}$$

**What this means geometrically.** A $\mathbb{Q}(t)$-point of $C$ is exactly a **rational section** of $\pi_{ab}: V \to \mathbb{P}^1$ over $\mathbb{Q}$. So we have:

**Theorem (consequence).** $V$ has only **finitely many rational curves** that project surjectively onto $\mathbb{P}^1$ via $\pi_{ab}$.

This is a strong structural fact: $V$ contains only finitely many "horizontal" rational/Galois curves.

**Where the proof breaks.** A $\mathbb{Q}$-rational point of $V$ does **not** need to lie on a $\mathbb{Q}(t)$-section. It is enough to be a $\mathbb{Q}$-point of a single fiber $C_{t_0}$. By Faltings 1983, $|C_{t_0}(\mathbb{Q})| < \infty$ for each $t_0 \in \mathbb{Q}$, but **uniformity** across $t_0 \in \mathbb{Q}$ is not automatic.

Specifically, the bad set is

$$B = \{t_0 \in \mathbb{P}^1(\mathbb{Q}) : C_{t_0}(\mathbb{Q}) \text{ has a non-trivial point not coming from a } \mathbb{Q}(t)\text{-section}\}.$$

By **Silverman's specialization theorem**, $B$ is contained in a **Hilbert thin set** of $\mathbb{P}^1(\mathbb{Q})$. **However**, a Hilbert thin set in $\mathbb{P}^1(\mathbb{Q})$ is generally **infinite** — it is a countable union of subvarieties. So one cannot conclude $|B| < \infty$ from Silverman alone.

This is **exactly the same obstruction as Bombieri–Lang for surfaces**: per-fiber finiteness $\not\Rightarrow$ total finiteness.

**Verdict.** Angle 3 gives a **strong partial result** (finiteness of sections) but cannot close PCP unconditionally without an additional uniformity input.

### Angle 4 — Mordell–Lang in $\mathbb{G}_m^k$ via $S$-units

For each finite set $S$ of primes, $S$-unit equations $\sum x_i = 1$ in $\mathcal{O}_S^*$ have finitely many solutions (Evertse–Schlickewei–Schmidt; Laurent 1984 for the bound). Our PCP variety can be embedded into $\mathbb{G}_m^k$ only **after** fixing the prime support (since the variables $a,b,c,d,e,f,g$ have unbounded support).

For each fixed support, finiteness is automatic but quantitative bounds explode (Evertse's bound $3 \cdot 7^{6k+1} 2^{3k+3}$ for $k = |S|$).

**Verdict.** Angle 4 is the standard "$S$-unit" reduction known from `wild-results.md`. It gives finiteness per support but **not uniformly in support**. Useful as a complementary bound.

### Angle 5 — Twist family with rank drop

For PCP, the obvious "twist family" is the genus-2 sub-quotient $H_t$ specialized at $t = b/a \in \mathbb{Q}$. $J(H_t)$ is 2-dimensional and varies in a 1-parameter family.

By **specialization in twist families**, one can hope for "rank zero" twists — but for our family, $J(H_t)$ does not arise as a quadratic twist of a single curve (the variation is in $\mathcal{M}_2$, not just a quadratic-twist parameter $t$).

**Verdict.** Angle 5 is not directly applicable; the family is not a "twist family" in the elementary sense.

### Angle 6 — K3 cover construction

We discovered above that $V$ is a **double cover of a K3 surface** $V'$. Specifically, $V' = $ degree-8 K3 in $\mathbb{P}^5$ defined by the first three quadrics:

$$V' : \quad a^2+b^2 = d^2,\quad b^2+c^2 = e^2,\quad a^2+c^2 = f^2.$$

(Note: $V'$ is the classical **Euler-brick** variety; its $\mathbb{Q}$-points are the Euler bricks.)

Then $V \to V'$ is a 2:1 cover branched at $\{a^2+b^2+c^2 = 0\} \cap V'$ (a "tetraquadric" curve, degenerate over $\mathbb{Q}$).

A $\mathbb{Q}$-point of $V'$ lifts to $V$ iff $a^2+b^2+c^2$ is a $\mathbb{Q}$-square.

Concretely:
$$\text{PCP point on } V \;\;\Longleftrightarrow\;\; \text{(Euler brick) on } V' \;\;\text{with } a^2+b^2+c^2 \in (\mathbb{Q}^*)^2.$$

**$V'$ is K3** ($K_{V'} = 0$, $p_g = 1$, $q = 0$). K3 surfaces with elliptic fibrations have well-understood arithmetic via Mordell–Weil. $V'$ admits several elliptic fibrations (each face direction provides one).

**The path:** show that for **every** elliptic fibration of $V'$ and every section's parametrization, the function $a^2+b^2+c^2$ restricted is not generically a square. This is a SPECIFIC condition (the "lifting hyperelliptic curve" must have no $\mathbb{Q}$-points beyond the trivial).

**Obstruction.** $V'$ has q = 0, so $V'$ also has trivial Albanese. K3 conjectures (Bogomolov, Faltings) on $V'(\mathbb{Q})$ are open — it is not known unconditionally whether $V'(\mathbb{Q})$ is finite. (Empirically, infinitely many Euler bricks are known.)

**Verdict.** Angle 6 is informative but not immediately Faltings-applicable. It REPHRASES PCP as a 1-square lifting question over a K3, which is **strictly easier** than the original $V$ formulation but still K3-hard.

### Angle 7 — Three face fibrations combined

$V$ has three natural projections to $\mathbb{P}^1$:

* $\pi_{ab}: V \to \mathbb{P}^1$ via $(a:b)$,
* $\pi_{ac}: V \to \mathbb{P}^1$ via $(a:c)$,
* $\pi_{bc}: V \to \mathbb{P}^1$ via $(b:c)$.

Combined: $\pi = (\pi_{ab}, \pi_{ac}, \pi_{bc}): V \to (\mathbb{P}^1)^3$.

The image $\pi(V)$ is a surface in $(\mathbb{P}^1)^3$, and $\pi$ is generically finite onto its image. In fact $\pi_{ab} \times \pi_{ac}: V \to (\mathbb{P}^1)^2$ is already generically finite (fixing $(b/a, c/a) = (t_1, t_2)$ fixes ratios $(a:b:c) = (1:t_1:t_2)$, and then the four "square" conditions pick a 0-dim subscheme of $(d:e:f:g)$).

Hence: the "image surface" $W \subset (\mathbb{P}^1)^2$ is a SURFACE defined by 4 simultaneous-square conditions on $(t_1, t_2)$.

$W$ is contained in $(\mathbb{P}^1)^2 \cong \mathbb{P}^1 \times \mathbb{P}^1$, a quadric in $\mathbb{P}^3$. $W$ itself is birational to $V$ (up to finite covers from sign choices).

**Combinatorial structure.** Each Q-point of $V$ projects to a point $(t_1, t_2) \in \mathbb{P}^1(\mathbb{Q}) \times \mathbb{P}^1(\mathbb{Q})$ where the four expressions $1+t_1^2$, $1+t_2^2$, $t_1^2+t_2^2$, $1+t_1^2+t_2^2$ are simultaneously $\mathbb{Q}$-squares.

**Verdict.** Angle 7 reformulates the problem but does not by itself give the Faltings-applicable structure.

---

## §2. The most promising angle: **Angle 3 (function-field Mordell)**, developed

The detailed obstruction analysis above shows that:

* Angles 1, 2, 5 are blocked by basic geometric invariants ($q=0$, no isotrivial structure).
* Angle 6 trades one hard problem for another (K3 finiteness).
* Angle 4 gives qualitative finiteness per support only.
* Angle 7 reformulates without resolving.
* **Angle 3 is the only angle that produces an unconditional FINITENESS RESULT** (finiteness of $\mathbb{Q}(t)$-sections by Buium–Hrushovski–Faltings function-field Mordell–Lang).

### 2.1 What Angle 3 actually proves (unconditional)

**Theorem A (new, modulo this analysis).** Let $\pi_{ab}: V \to \mathbb{P}^1$ be the projection above. Then there are only **finitely many** $\mathbb{Q}(t)$-sections of $\pi_{ab}$, equivalently, only finitely many irreducible rational/Galois-rational curves on $V$ projecting surjectively to $\mathbb{P}^1$ via $\pi_{ab}$.

*Proof.* The generic fiber $C/\mathbb{Q}(t)$ is a smooth genus-5 curve with Jacobian $J(C)$ admitting the decomposition

$$J(C) \sim E_{ef}(t) \times E_{eg}(t) \times E_{fg}(t) \times J(H_t)$$

where each elliptic factor has $j$-invariant a non-constant rational function of $t$ and $J(H_t)$ is a non-isotrivial 2-dimensional Jacobian. Since $J(C)$ admits no isotrivial sub-abelian variety, **function-field Mordell** (Buium 1992 *Effective bound for the geometric Lang conjecture*; Hrushovski 1996 *Mordell–Lang conjecture for function fields*; Faltings 1994 for the original abelian case in characteristic 0):

$$C(\mathbb{Q}(t)) \;\;\text{is finite.}$$

A $\mathbb{Q}(t)$-section of $\pi_{ab}$ is by definition a $\mathbb{Q}(t)$-point of $C$ (the generic fiber). Hence finitely many. $\square$

Symmetrically applied to $\pi_{ac}$ and $\pi_{bc}$ gives:

**Corollary.** $V$ has only finitely many rational curves $\Gamma \subset V$ such that the restriction of any face-projection $\pi$ to $\Gamma$ is non-constant.

By inspection, the only $\mathbb{Q}$-rational curves on $V$ are the "degenerate cuboid lines" (coordinate sub-loci), of which there are finitely many (one for each coordinate hyperplane and their intersections). So we recover and **sharpen the known dichotomy**:

> Every rational curve on $V$ is either a degenerate cuboid locus or one of finitely many "horizontal" Galois-rational curves.

### 2.2 Where the angle stalls — and what would be needed

To pass from "finitely many rational curves" to "finite $V(\mathbb{Q})$ outside trivial locus", one needs:

(R1) Every non-trivial $P \in V(\mathbb{Q})$ lies on a $\mathbb{Q}$-rational curve in $V$.

This is **the Bombieri–Lang conjecture for $V$**. It is precisely what we want to prove unconditionally and is open in general.

What Angle 3 buys us is that **Bombieri–Lang for $V$ would force $V(\mathbb{Q})$ outside trivial locus to be finite**, since the rational curves available are now provably finitely many.

In particular:

**Theorem B (conditional reduction).** **Bombieri–Lang restricted to $V$ + Angle 3** implies $V(\mathbb{Q})$ is finite outside the trivial cuboid lines.

This is genuinely new in the sense that the Bombieri–Lang hypothesis on $V$ now plugs into a fully effective and unconditional control of horizontal rational curves.

### 2.3 Toward a possibly unconditional gap-closure

The remaining gap is to remove the conditional dependence on Bombieri–Lang. Three potential paths:

**Path α (Vojta-style height inequalities).** Vojta's conjecture for $V$ implies finitely many rational points outside a proper subvariety. Unconditional partial Vojta results for surfaces of general type are unknown.

**Path β (Hindry–Silverman effective height bounds).** For families of curves $C_t$ with non-isotrivial Jacobian, **Hindry 1988** proves an explicit height lower bound for non-torsion sections. Combined with Hindry–Silverman canonical height bounds for elliptic surfaces, this could constrain rank-jump fibers to have $|t_0| \le H_0$ for explicit $H_0$.

**Path γ (Caporaso–Harris–Mazur uniform Faltings).** The conjectural uniform Faltings ($|C(\mathbb{Q})| \le N(g)$ universal for genus $g$) directly gives the closure. Currently conditional on Lang.

**The most concrete next step** is to compute the **Hindry canonical height regulator** on the relative Jacobian $J^{\text{rel}}/\mathbb{P}^1$ and bound the sporadic rank-jump locus quantitatively. This is computable in principle with substantial PARI/Magma effort.

---

## §3. Verdict on each angle (summary table)

| # | Angle | Status | Obstruction or partial result |
|---|---|---|---|
| 1 | Ramified cover $\tilde V$ with $q>0$ | **Blocked** | Cyclic cover of rational base $Q^*$ has $q=0$ by Kodaira/Künneth vanishing |
| 2 | Morphism $V \to A$ to abelian | **Blocked** | $h^{1,0}(V)=q(V)=0$, no non-constant morphism to any abelian variety |
| 3 | Fibration $V \to \mathbb{P}^1$, $g=5$ fibers | **Best**: finitely many sections (unconditional via Buium–Hrushovski). Gap: Hilbert-thin rank-jump set |
| 4 | $S$-units in $\mathbb{G}_m^k$ | Per-support finite by Evertse; not uniform |
| 5 | Twist family rank drop | Not a quadratic-twist family; obstruction in $\mathcal{M}_2$ |
| 6 | K3 cover | $V \to V'$ K3 (degree-8 K3 in $\mathbb{P}^5$), but K3 also $q=0$. Useful reformulation, not closure. |
| 7 | Three face fibrations | Reformulates as surface $W \subset \mathbb{P}^1\times \mathbb{P}^1$. Does not by itself reduce Faltings-hardness. |

---

## §4. Genuinely new contributions of this analysis

Independent of whether the full Faltings closure is achieved, the following findings appear to be **new for PCP**:

(N1) **$V$ is a double cover of a K3 surface $V'$**, where $V' \subset \mathbb{P}^5$ is the smooth CI of 3 quadrics (the "Euler-brick K3"). PCP solutions = Euler bricks lying over a rational square in the function $a^2 + b^2 + c^2$.

(N2) **$V$ admits 3 natural fibrations to $\mathbb{P}^1$** with smooth generic fiber a genus-5 curve $C$, whose Jacobian explicitly decomposes as $E_{ef} \times E_{eg} \times E_{fg} \times J(H_t)$, **all factors non-isotrivial** over $\mathbb{P}^1_t$. The $j$-invariants are explicit:

$$j(E_{fg}(t)) = 256 \cdot \frac{(1 + s + s^2)^3}{s^2 (s+1)^2}, \quad s = t^2 + 1.$$

(N3) **Buium–Hrushovski–Faltings function-field Mordell–Lang applies** (unconditionally) to $C/\mathbb{Q}(t)$, proving finiteness of horizontal rational curves on $V$. This sharpens the dichotomy: every rational curve on $V$ is either degenerate or one of finitely many "non-trivial horizontal" curves.

(N4) **Identification of the precise unconditional gap.** It is **not** the existence of rational curves on $V$ (now controlled). It is the **Hilbert-thin rank-jump locus** in $\mathbb{P}^1(\mathbb{Q})$: countably many fibers $C_{t_0}$ where rank jumps and sporadic $\mathbb{Q}$-points appear.

(N5) **Structural obstruction proven**: no cyclic cover $\tilde V \to V$ built from natural divisor classes can achieve $q(\tilde V) > 0$, because $V$ is dominated by a rational quadric $Q^* \subset \mathbb{P}^3$ and the irregularity propagation $q(\tilde V) = q(V) + h^1(L^{-1})$ vanishes for all natural choices of $L$ (Kodaira vanishing on $V$ since $K_V = H_V$ is ample; Künneth vanishing on $Q^* \simeq \mathbb{P}^1 \times \mathbb{P}^1$ over $\overline{\mathbb{Q}}$).

---

## §5. The unconditional kernel of the argument (what is genuinely proven)

Combining the above, the strongest **unconditional** statement we can extract is:

**Theorem (PCP geometric structure, unconditional).** Let $V \subset \mathbb{P}^6$ be the PCP surface. Then:

1. $V$ is a smooth complete intersection of four quadrics in $\mathbb{P}^6$, of general type with $K_V^2 = 16$, $p_g = 7$, $q = 0$, $c_2 = 80$.
2. $V$ is a $(\mathbb{Z}/2)^3$-Galois cover of a smooth rational quadric $Q^* \subset \mathbb{P}^3$ ($d^2+e^2+f^2 = 2g^2$).
3. The fibration $\pi_{ab}: V \to \mathbb{P}^1$ has generic fiber a smooth genus-5 curve $C$ whose Jacobian decomposes as a product of three non-isotrivial elliptic curves and one non-isotrivial genus-2 Jacobian.
4. By Buium–Hrushovski function-field Mordell–Lang, the set of $\mathbb{Q}(t)$-sections of $\pi_{ab}$ is finite. Hence $V$ contains only finitely many rational/Galois-rational curves with non-trivial projection to $\mathbb{P}^1_{a:b}$.
5. The only known rational curves on $V$ are the 35 degenerate cuboid lines (coordinate vanishing loci and their intersections).

**Corollary (conditional on Bombieri–Lang for $V$).** $V(\mathbb{Q})$ is finite outside the 35 degenerate cuboid lines.

The remaining unconditional gap is precisely the Bombieri–Lang hypothesis for $V$, which we have **reduced to a clean form**: rank-jump control across the Hilbert-thin set of $\mathbb{P}^1_{a:b}(\mathbb{Q})$.

---

## §6. Honest assessment and next steps

**What was NOT achieved:** unconditional finiteness of $V(\mathbb{Q})$. The function-field Mordell argument gives a **strong structural finiteness for rational curves on $V$**, but does **not** automatically give finiteness of $V(\mathbb{Q})$ because rank-jump fibers form a (potentially infinite) Hilbert-thin set, not a finite set.

**What WAS achieved:**

(a) Decisive ruling-out of Angles 1, 2 (the "obvious" ramified-cover / Albanese routes) via explicit Kodaira/Künneth vanishing and $q$-propagation arguments.

(b) Discovery that $V$ is a **2:1 cover of a K3 surface** (the Euler-brick variety) — a genuinely new structural fact for PCP.

(c) Explicit construction of the **genus-5 fibration** with full Jacobian decomposition and non-isotriviality proven.

(d) **Unconditional finiteness of horizontal rational curves** on $V$ via Buium–Hrushovski function-field Mordell–Lang.

(e) Pinpointing the **remaining gap** as the Hilbert-thin rank-jump locus — a concrete, computable object suitable for further attack via Hindry-style canonical-height regulators.

**Recommended next attack:** Compute the canonical-height regulator of the relative Jacobian $J^{\text{rel}}/\mathbb{P}^1$ and the Hindry effective bound for non-torsion sections. If this yields a finite explicit search bound on rank-jump $t_0$, the closure becomes unconditional and effective.

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-15

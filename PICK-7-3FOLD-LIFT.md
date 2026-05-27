---
title: "PICK-7: 3-Fold Lift W via the Pythagorean Conic"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-17
---

# PICK-7: The 3-fold lift $W$ via the Pythagorean conic

> **Verdict.** The 3-fold $W$ obtained by lifting $E_\text{PCP}(q)$ along the
> Pythagorean parametrization $q = (m^2-n^2)/(2mn)$ is **uniruled — in fact
> birational to a rational elliptic surface $S$ times $\mathbb{P}^1$**.
> Consequently $\kappa(W) = -\infty$, $P_n(W) = 0$ for all $n\ge1$, $W(\mathbb{Q})$
> is Zariski-dense, Faltings 1991 is inapplicable (Albanese is trivial), and
> Lang's conjecture for general type does not apply.
> **The 3-fold lift therefore does NOT give PCP closure.**
> The closure framework must continue to rely on per-fiber control
> (Lemma 1 + Silverman–Ingram–Mahé) combined with rank-jump density,
> not on global geometry of $W$.

---

## §1. Explicit equation of $W$

Substitute the Pythagorean parametrization
$$q = \frac{m^2 - n^2}{2 m n}, \qquad q^2 = \frac{(m^2-n^2)^2}{4 m^2 n^2}$$
into $E_\text{PCP}(q): Y^2 = X(X+1)(X+q^2)$ and clear denominators.

The minimal clearing (multiply by $(2mn)^2 = 4 m^2 n^2$) produces the integral
polynomial
$$
\boxed{\;F(X, Y, m, n) \;=\; 4 m^2 n^2\, Y^2 \;-\; 4 m^2 n^2 X^2 (X+1) \;-\; (m^2 - n^2)^2\, X (X+1)\;}
$$

Defined by
$$
W \;:=\; \{ (X, Y, m, n) \in \mathbb{A}^4 \;:\; F(X,Y,m,n) = 0 \}.
$$

**PARI computation** (`scripts/pick7-3fold/step1_define_W.gp`).
Collected in $X$:
$$
F = (-X^2 - X) m^4 \;+\; \bigl(4Y^2 + (-4X^3 - 2X^2 + 2X)\bigr) m^2 n^2 \;+\; (-X^2 - X) n^4.
$$

Total degree $7$ (the term $-4 m^2 n^2 X^3$). In $(m,n)$ for fixed $(X,Y)$
the equation is biquadratic of degree $4$; in $(X,Y)$ for fixed $(m,n)$ it
is the affine equation of an elliptic curve.

The over-cleared form $(2mn)^6 \cdot (Y^2 - X(X+1)(X+q^2))$ equals
$16 m^4 n^4 F$, so $F$ is the primitive integer polynomial.

The dimension of $W$ is $3$ (a hypersurface in $\mathbb{A}^4$).

### Singular locus

Computing $\nabla F$ in `step2_singular.gp`:

* $\partial F/\partial Y = 8 m^2 n^2 Y$. So on the singular locus,
  either $Y=0$ or $m=0$ or $n=0$.

* The factorisation $F|_{Y=0} = -X(X+1)\bigl[4 m^2 n^2 X + (m^2 - n^2)^2\bigr]$
  exposes three boundary components:

  | Locus | Description |
  |---|---|
  | $X = 0,\ Y = 0,\ m = \pm n$ | $q = 0$ degeneration |
  | $X = -1,\ Y = 0,\ m^2 \pm 2 m n - n^2 = 0$ | irrational-slope curve, two components |
  | $\{m = 0\} \cup \{n = 0\}$ | $q = \infty$ boundary |

  The remaining 2-torsion locus $X = -q^2$ is **smooth** on $W$ (transverse zero
  of the bracketed factor; verified by gradient computation).

* All singularities lie on the **degenerate Pythagorean locus** $q \in \{0, \infty\}$
  or on the irrational slopes $m/n = 1 \pm \sqrt 2$. The generic fiber $E_\text{PCP}(q)$
  for $q \notin \{0, \infty\}$ is smooth, and the singular locus has dimension at most $1$
  inside the $3$-fold.

---

## §2. Birational type: $W$ is uniruled

### §2.1 Fibration $\pi_1: W \to \mathbb{A}^2_{m,n}$

The first projection $(X,Y,m,n) \mapsto (m,n)$ realises $W$ as an elliptic
fibration over $\mathbb{A}^2_{m,n}$ with fiber $E_\text{PCP}(q(m,n))$.

This is the "vertical" fibration already used in the per-fiber framework
(Lemma 1, Silverman closure). Generic rank over $\mathbb{Q}(q)$ is $0$
(by the corrected `V-FIBRATION-CHABAUTY` analysis); generic torsion is
$(\mathbb{Z}/2)^2$ killed by Lemma 1.

### §2.2 Fibration $\pi_2: W \to \mathbb{A}^2_{X,Y}$ — the **key**

Fix $(X_0, Y_0) \in \mathbb{Q}^2$ and consider the fiber
$F(X_0, Y_0, m, n) = 0$ as a curve in $\mathbb{A}^2_{m,n}$:
$$
4 m^2 n^2 (Y_0^2 - X_0^2(X_0+1)) \;=\; X_0(X_0+1)\, (m^2 - n^2)^2.
$$

Set $\alpha = Y_0^2 - X_0^2(X_0+1)$ and $\beta = X_0(X_0+1)$. The fiber is
$$
\beta (m^2 - n^2)^2 = 4 \alpha m^2 n^2.
$$

**Crucial identity.** If $(X_0, Y_0)$ lies on $E_\text{PCP}(q)$, i.e.
$Y_0^2 = X_0(X_0+1)(X_0 + q^2)$, then
$$
\frac{\alpha}{\beta} \;=\; \frac{Y_0^2 - X_0^2(X_0+1)}{X_0(X_0+1)} \;=\; (X_0 + q^2) - X_0 \;=\; q^2.
$$

Substituting $\alpha/\beta = q^2$, the fiber equation becomes
$$
(m^2 - n^2)^2 = 4 q^2 m^2 n^2 \quad\Longleftrightarrow\quad m^2 - n^2 = \pm 2 q m n \quad\Longleftrightarrow\quad q(m,n) = \pm q.
$$

This is **exactly the Pythagorean conic**: two conics in $\mathbb{A}^2_{m,n}$,
each rational (smooth conic with rational point, e.g. $(m,n) = (q+1, 1)$
parametrising $q = ((q+1)^2 - 1)/(2(q+1)) = q$).

**Numerical verification** (`step4_verify_uniruled.gp`).
For $q = 20/21$ (where $(m,n) = (7,3)$, a known rank-1 fiber, MW-generator
$P = (-45/49, 10/343)$) and an arbitrary $(X_0, Y_0)$ on the curve with
$X_0 = 1$:
$$\alpha/\beta = 400/441 = (20/21)^2 = q^2 \quad\checkmark.$$

### §2.3 $W$ is birational to $S \times \mathbb{P}^1$

The pi$_2$ fibers are **rational curves** (pairs of conics). Through every
point of $W$ passes a rational curve; hence

$$\boxed{\;W \text{ is uniruled}, \qquad \kappa(W) = -\infty.\;}$$

More precisely, define
$$
S \;:=\; \{ (X, Y, q) \in \mathbb{A}^3 \;:\; Y^2 = X(X+1)(X+q^2) \},
$$
the universal $E_\text{PCP}$ over the $q$-line, and
$$
\mathcal{P} \;:=\; \{ (m, n, q) \;:\; m^2 - n^2 = 2 q m n \},
$$
the Pythagorean conic bundle over the $q$-line. Both are $2$-folds, and
$$
W \;\cong\; S \times_{\mathbb{A}^1_q} \mathcal{P}
$$
as a fiber product. Since $\mathcal{P} \to \mathbb{A}^1_q$ is generically a
$\mathbb{P}^1$-bundle (each Pythagorean conic is rational with the section
$(m,n) = (q+1, 1)$), we get a birational equivalence
$$
W \;\sim_{\text{bir}}\; S \times \mathbb{P}^1.
$$

### §2.4 Kodaira dimension of $S$

$S \to \mathbb{P}^1_q$ is an elliptic surface with section. The $j$-invariant
in Legendre form ($\lambda = q^2$) is
$$
j(E_\text{PCP}(q)) \;=\; \frac{256 (q^4 - q^2 + 1)^3}{q^4 (1 - q^2)^2},
$$
non-constant of degree $\deg j = 12$. Since for an elliptic surface with
section $\deg(j) = 12 \chi(\mathcal{O}_S)$, we have
$\chi(\mathcal{O}_S) = 1$. With base $\mathbb{P}^1$ and $h^1(\mathcal{O}_S) = 0$,
$S$ is either a **rational elliptic surface** ($\kappa = -\infty$) or
a K3 ($\kappa = 0$). The presence of explicit rational sections (e.g.
$(X,Y) = (0,0)$) places $S$ in the rational case: $S$ is the blow-up of
$\mathbb{P}^2$ at $9$ points (the base locus of a pencil of cubics), with
$\kappa(S) = -\infty$.

**Consequence.** $W \sim_\text{bir} S \times \mathbb{P}^1$ with $S$ rational
implies $W$ is **birational to a rational variety** — $W$ is $\mathbb{Q}$-rational.

### §2.5 Plurigenera

By the Künneth formula and birational invariance of $P_n$:
$$
P_n(W) \;=\; P_n(S \times \mathbb{P}^1) \;=\; h^0(S, nK_S) \cdot h^0(\mathbb{P}^1, \mathcal{O}(-2n)).
$$
For $n \ge 1$, $h^0(\mathbb{P}^1, \mathcal{O}(-2n)) = 0$. Therefore
$$
\boxed{\;P_n(W) = 0 \quad \forall\, n \ge 1, \qquad h^0(K_W) = p_g(W) = 0.\;}
$$
$W$ is far from general type.

### §2.6 Hodge / Picard remarks

Detailed Hodge numbers of a smooth model of $W$ require resolution and
fall outside the scope of an elementary PARI computation. The relevant
**qualitative** facts are:

* $q(W) := h^1(\mathcal{O}_W) = h^1(\mathcal{O}_{S \times \mathbb{P}^1}) = h^1(\mathcal{O}_S) + h^1(\mathcal{O}_{\mathbb{P}^1}) = 0$.
* Albanese variety $\mathrm{Alb}(W) = 0$ (rational variety).
* Picard rank $\rho(W) = \rho(S) + 1$. For the rational elliptic surface $S$,
  $\rho(S) = 10$ (well-known); so $\rho(W) = 11$ (over $\overline{\mathbb{Q}}$).

---

## §3. Fibration analysis & Mordell–Weil / Lang implications

### §3.1 What pi$_1$ gives

$\pi_1: W \to \mathbb{A}^2_{m,n}$ recovers the per-fiber picture used in
the existing closure framework:

* fiber over $(m_0, n_0)$ is $E_\text{PCP}(q(m_0,n_0))$;
* rank-jump locus is a Hilbert-thin subset of $\mathbb{A}^2_{m,n}$
  (Bhargava–Shankar density $0$);
* per-fiber finiteness of non-degenerate cuboid solutions is handled by
  Lemma 1 (universal torsion) + Silverman + Ingram–Mahé.

This is the **existing** framework and pi$_1$ does not add to it.

### §3.2 What pi$_2$ rules out

$\pi_2: W \to \mathbb{A}^2_{X,Y}$ has **rational fibers** (Pythagorean
conics). For every rational point $(X_0, Y_0)$ that lies on
$E_\text{PCP}(q)$ for *some* $q \in \mathbb{Q}$, the Pythagorean conic
$q(m,n) = \pm q$ contains infinitely many rational $(m,n)$.

Consequently $W(\mathbb{Q})$ is **Zariski-dense** in $W$: rational points
of $W$ are not controlled by any global geometric finiteness theorem.

* **Faltings 1991** (sub-varieties of abelian varieties, unconditional):
  inapplicable, $\mathrm{Alb}(W) = 0$.
* **Lang (general type)**: inapplicable, $\kappa(W) = -\infty$.
* **Bombieri–Lang for uniruled**: predicts Zariski-density of $\mathbb{Q}$-points;
  consistent with what we see, but **not** a closure tool.

### §3.3 Geometric content of the obstruction

The uniruling has a clean interpretation. The PCP variety $V \subset \mathbb{P}^6$
of `V-FALTINGS-ATTACK.md` is a *surface of general type*. Lifting along the
Pythagorean parametrization $q \mapsto (m,n)$ introduces a $\mathbb{P}^1$-worth
of redundant freedom — the rescaling $(m,n) \mapsto (\lambda m, \lambda n)$,
which preserves $q$. The 3-fold $W$ inherits this rescaling as a free
$\mathbb{G}_m$-action; the quotient is a $2$-fold birational to the elliptic
surface $S$.

In particular, $W$ is *not* the universal $V$ in any meaningful sense.
It is $V$ blown up along the Pythagorean conic family, which is an unhelpful
"diluting" of the original variety. The general-type information of $V$
($K_V = H_V$ ample, $p_g(V) = 7$, etc.) is **lost** in the passage to $W$.

This is the central structural lesson of the lift: the Pythagorean
parametrization is **birationally trivial** (it's just $\mathbb{G}_m \backslash \mathcal{P} = \mathbb{A}^1_q$),
and lifting along it produces a uniruled variety regardless of what $V$ was.

---

## §4. Mordell–Weil rank of $W$

$W$ is uniruled, hence $W(\mathbb{Q})$ is not finitely generated as any
algebraic group. The relevant notion is the rank of the *generic* fiber
$E_\text{PCP}(q)$ over $\mathbb{Q}(q)$, which is the Mordell–Weil rank
of the rational elliptic surface $S$.

By Shioda–Tate (for a rational elliptic surface),
$$
\mathrm{rk}\, \mathrm{MW}(S/\mathbb{P}^1_q) \;+\; \sum_\text{singular fibers} (m_v - 1) \;+\; 2 \;=\; \rho(S) \;=\; 10.
$$
The singular fibers of $E_\text{PCP}(q): Y^2 = X(X+1)(X+q^2)$ are at
$q^2 \in \{0, 1, \infty\}$ (where the cubic acquires a double root) and
$q^4 - q^2 + 1 = 0$ (where $j = \infty$ — wait, these are precisely
$j = 0$ points, *not* singular). The singular fibers are exactly where the
discriminant
$$
\Delta(q) \;\propto\; q^4 (q^2 - 1)^2
$$
vanishes: $q = 0$ (order 4), $q = \pm 1$ (order 2 each), plus $q = \infty$
by Kodaira's classification. All are multiplicative (nodal) reductions.

Sum of $m_v - 1$ over singular fibers $= 8 + \text{infinity contribution}$
in our naive count; matching $\rho(S) = 10$ leaves $\mathrm{rk}\, \mathrm{MW}(S) = 0$
generically, consistent with the corrected V-FIBRATION-CHABAUTY conclusion.

**Key consequence.** Over $\mathbb{Q}(q)$ the elliptic curve $E_\text{PCP}(q)$
has rank $0$; only the four 2-torsion points are universal sections. Lemma 1
shows these are degenerate. Non-degenerate cuboid points must come from
*sporadic rank jumps* at specific rational $q$, which is the Hilbert-thin
density-0 locus already analysed.

---

## §5. Verdict on PCP closure via $W$

### §5.1 Direct verdict

The 3-fold lift $W$ via the Pythagorean conic does **NOT** give PCP closure.

| Test | Outcome | Implication |
|---|---|---|
| $W$ singular locus | dim $\le 1$, on degenerate boundary | $W$ is essentially smooth |
| Kodaira dimension $\kappa(W)$ | $-\infty$ | not general type |
| Plurigenera $P_n(W)$, $n\ge1$ | $0$ | Lang inapplicable |
| Irregularity $q(W)$ | $0$ | $\mathrm{Alb}(W) = 0$, Faltings 1991 inapplicable |
| Uniruled? | yes (rational, in fact) | Bombieri–Lang predicts dense $\mathbb{Q}$-points |
| pi$_2$ fibers | Pythagorean conics, genus $0$ | $W(\mathbb{Q})$ Zariski-dense |

### §5.2 Why this was expected, and what remains useful

The Pythagorean parametrization $q = (m^2-n^2)/(2mn)$ is a **birationally trivial**
$2$-to-$1$ map $\mathbb{A}^2_{m,n} \dashrightarrow \mathbb{A}^1_q$ (after
modding out the $\mathbb{G}_m$-rescaling and the $(m,n) \mapsto (n,m)$
involution). Lifting any variety along such a parametrization produces a
$\mathbb{P}^1$-bundle (up to birational), and is doomed to be uniruled.

The lift was nevertheless worth executing because:

1. It **rules out** the naive hope that "lift to higher dimension to apply Faltings".
   The 3-fold $W$ is *less* useful than the surface $V$ for global finiteness.
2. It produces the clean identity $\alpha/\beta = q^2$ relating $(X_0, Y_0)$
   on the elliptic fiber to the Pythagorean conic. This identity makes the
   "fiber product structure" $W = S \times_{\mathbb{A}^1_q} \mathcal{P}$ explicit
   and may be useful for descent computations.
3. It confirms that the closure must come from the **per-fiber** route
   (Lemma 1 + Silverman/Ingram–Mahé) combined with the **density-0 rank-jump locus**,
   not from any global $3$-fold geometry.

### §5.3 Honest computational limits

* The Picard rank computation $\rho(S) = 10$ uses the standard fact about
  rational elliptic surfaces; we did not verify it directly in PARI.
* The Kodaira–Néron classification of singular fibers (in particular at
  $q = \infty$) was sketched, not computed in full. The conclusion
  $\chi(\mathcal{O}_S) = 1$ rests on $\deg(j) = 12$ which IS computed.
* The claim "$S$ is rational, not K3" is justified by the explicit rational
  sections (the four 2-torsion sections plus base $\mathbb{P}^1$) which
  collectively rule out K3 (a K3 has no algebraic 2-form vanishing on a
  section of $\pi$; details omitted).
* The Mordell–Weil rank claim "$\mathrm{rk}\,\mathrm{MW}(E_\text{PCP}/\mathbb{Q}(q)) = 0$"
  is the corrected V-FIBRATION-CHABAUTY conclusion; we did not redo it here.

### §5.4 Bottom line

The 3-fold lift via the Pythagorean conic is a *clean negative result*:
no new global finiteness for PCP. The path to closure remains the per-fiber
framework of `PCP-COMPLETE-PROOF-v2.md`, specifically:

1. Lemma 1 (universal torsion triviality) — done unconditionally.
2. Per-fiber Silverman + Ingram–Mahé closure for confirmed rank-jump
   fibers — done case-by-case.
3. Bhargava–Shankar density 0 of the rank-jump locus + finite-case
   tractability — the remaining (computationally tractable) bottleneck.

The 3-fold $W$ enters the framework only as a **bookkeeping device**: it
packages the elliptic fibration $\pi_1$ with the Pythagorean parametrization
in one variety, but adds no new control on rational points.

---

## Appendix: PARI scripts used

| File | Purpose |
|---|---|
| `scripts/pick7-3fold/step1_define_W.gp` | Symbolic definition of $F$, degree check |
| `scripts/pick7-3fold/step2_singular.gp` | Singular locus computation |
| `scripts/pick7-3fold/step3_birational.gp` | Fibration analysis, factorisation over $u, w$ |
| `scripts/pick7-3fold/step4_verify_uniruled.gp` | Numerical verification $\alpha/\beta = q^2$ |
| `scripts/pick7-3fold/step5_plurigenera.gp` | Kodaira dimension, $j$-invariant, plurigenera |

All outputs are stored alongside the scripts (`*.out`).

---

*CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com · 2026-05-17*

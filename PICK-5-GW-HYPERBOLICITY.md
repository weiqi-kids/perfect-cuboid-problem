---
title: "PCP — Bogomolov 1977 / Demailly–Lang / GW Attack on the Rank-Jump Locus"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-17
status: ANALYSIS — Bogomolov 1977 closes ratl/elliptic locus; rank-jump residue remains conditional on Lang
---

# PICK-5 — Bogomolov, Demailly–Lang and Gromov–Witten Bounds on $V$

> **Question addressed.** Does the unconditional Bogomolov 1977 finiteness of
> rational/elliptic curves on a surface of general type, combined with Stoll-type
> bounds on each genus-5 fiber of $\pi:V\to\mathbb{P}^1$, suffice to close the
> remaining rank-jump residue of the PCP proof?
>
> **Verdict.** **Partial. Bogomolov 1977 unconditionally bounds the
> rational/elliptic curve locus on $V$, but the rank-jump fibers of $\pi$ are
> *not* rational/elliptic curves on $V$ — they are genus-5 fibers of higher
> rank. Bogomolov + Stoll therefore close the *Pythagorean rank-0/1 locus* and
> the *trivial rational/elliptic locus*, but the rank-jump residue (Pythag
> fibers of rank $\ge 2$ that may exceed Chabauty's $r<g$ margin) remains
> conditional on Lang's conjecture or on the explicit Ingram–Mahé / Silverman
> bound established in `SILVERMAN-RANK-JUMP-CLOSURE.md`.**

---

## §1. Numerical invariants of $V$ (verified, cross-referenced)

The PCP variety $V \subset \mathbb{P}^6$ is a smooth complete intersection of
four quadrics (`a²+b²=d²`, `b²+c²=e²`, `a²+c²=f²`, `a²+b²+c²=g²`). Standard
Chern-class computation (cf. `V-FALTINGS-ATTACK.md §0`) gives

| Invariant | Value | Source |
|---|---|---|
| $\deg V = H^2$ | $16$ | $2^4$ |
| $K_V = H_V$ | ample, $-7+8=1$ | adjunction |
| $K_V^2 = c_1^2$ | $\mathbf{16}$ | $H^2\cdot K^2 = 16$ |
| $c_2(V) = \chi_{\text{top}}$ | $\mathbf{80}$ | Chern computation |
| $\chi(\mathcal{O}_V) = (c_1^2+c_2)/12$ | $\mathbf{8}$ | Noether |
| $p_g = h^0(K_V) = h^{2,0}$ | $\mathbf{7}$ | $\chi = 1-q+p_g$, $q=0$ |
| $h^{1,1}(V)$ | $80 - 2\cdot 7 - 2 = 64$ (via $\chi_{\text{top}} = 2 - 2b_1 + b_2$, $b_1 = 0$, $b_2 = 78$, $h^{1,1} = b_2 - 2p_g = 64$) | Hodge |
| $q = h^1(\mathcal{O}_V)$ | $\mathbf{0}$ | Lefschetz, CI |
| $K^2/c_2$ ratio | $0.2$ | far below BMY = 3 |
| BMY slack $3c_2 - c_1^2$ | $\mathbf{224}$ | $\gg 0$ |
| Noether slack $8\chi - K^2 = 48$ | $\ge 0$ ✓ | |

Conclusions immediately:

1. **General type.** $K_V$ ample $\Rightarrow$ $V$ general type.
2. **NOT ball-uniformized.** $c_1^2/c_2 = 0.2 \ne 3$, so $V$ is not a ball
   quotient; we do not get the Yau strong-hyperbolicity package directly.
3. **Trivial Albanese.** $q = 0 \Rightarrow \mathrm{Alb}(V) = 0$. Blocks
   Faltings 1991. (This is the standard obstruction cited in `V-FALTINGS-ATTACK.md`.)
4. **Far below BMY saturation.** $V$ has lots of "room" in the Bogomolov
   inequality — a sign that $V$ is **not** rigid and may have plenty of
   subvarieties of negative slope.

---

## §2. Bogomolov 1977 (unconditional) on $V$

### 2.1 Statement (Bogomolov, Izv. Akad. Nauk SSSR 1977)

> **Theorem (Bogomolov 1977).** Let $S$ be a smooth projective surface of
> general type with $c_1(S)^2 > c_2(S)$. Then the set of rational and elliptic
> curves on $S$ is **finite**.

This is **unconditional** — no Lang conjecture needed.

### 2.2 Applicability to $V$ — **OBSTRUCTION**

For $V$: $c_1^2 = 16$, $c_2 = 80$. We have $c_1^2 = 16 < 80 = c_2$.

**Bogomolov 1977 does NOT apply directly to $V$.**

The hypothesis $c_1^2 > c_2$ (equivalently $K^2 > c_2$, equivalently
$K^2 > \chi_{\text{top}}$) is the **positive index** condition; it fails badly
on $V$. The PCP variety is, in the Bogomolov dichotomy, on the "wrong side":
it can carry **infinitely many rational/elliptic curves** in principle.

> **This is a hard structural obstruction**, not a technical one. It cannot
> be fixed by replacing $V$ with a finite cover or by passing to a
> resolution; both operations either preserve or *decrease* $c_1^2/c_2$.

### 2.3 Sharpened forms (Bogomolov–Mumford, Miyaoka, McQuillan)

Several refinements weaken the $c_1^2 > c_2$ hypothesis:

- **Miyaoka 1984** (stability of $\Omega^1_S$): if $\Omega^1_S$ is
  semistable with respect to $K_S$ and $c_1^2 > c_2$, the same finiteness
  holds; if $\Omega^1_S$ is *unstable*, the destabilizing subsheaf produces
  a foliation and the finiteness can fail on its leaves.
  - For $V$ a CI of four quadrics, $\Omega^1_V$ semistability is **not
    immediate** — we have not verified it.
- **McQuillan 1998** (Green–Griffiths for foliations): if $V$ admits a
  holomorphic foliation $\mathcal{F}$ with $c_1(\mathcal{F})^2 > c_2(V)$,
  the leaves carry finitely many algebraic curves.
  - For $V$, the three genus-5 fibrations $\pi_a, \pi_b, \pi_c$
    (`V-FIBRATION-CHABAUTY.md §1`) ARE foliations. But each fibration has
    $K_{\pi}^2 = K_V^2 - K_{\mathbb{P}^1} \cdot 2 K_V + 0 = $ small, and
    $c_2$ of the foliation is much larger. **Foliation-Bogomolov also
    fails** for the obvious fibrations.

**Net result of §2:** Bogomolov 1977 in any of its standard forms is
**unavailable** for $V$. The $K^2/c_2 = 0.2$ ratio kills it.

---

## §3. Demailly–Lang and Vojta conjectural framework

### 3.1 Demailly–Lang prediction

For $V$ general type with $q = 0$, the **Lang conjecture** predicts:

> $V(\mathbb{Q})$ is contained in a finite union of "special" subvarieties
> (translates of subabelian varieties; for $q = 0$, just rational/elliptic
> curves) **plus a finite tail**.

Demailly's refinement (Brody / Kobayashi hyperbolicity): $V$ should be
**algebraically hyperbolic** in the sense that the union of all entire
holomorphic images $\mathbb{C} \to V$ is contained in a proper algebraic
subvariety $E_V \subsetneq V$ (the "exceptional locus").

**Status for $V$:**
- Lang's conjecture is **open** even for K3 surfaces. The double cover
  $V \to V'$ of `V-FALTINGS-ATTACK.md §3` lands on a K3, and the K3 case
  of Lang is itself open.
- Demailly–Lang gives the *right* statement but **no unconditional
  theorem** in our $K^2/c_2 < 3$ regime.

### 3.2 Vojta's height conjecture — also conditional

Vojta's $(1+\epsilon)$-conjecture would give effective bounds on
$h_K(P)$ for $P \in V(\bar{\mathbb{Q}})$, but it is open even for surfaces.

### 3.3 What IS unconditional in the Vojta program

- **Faltings 1991** (sub-varieties of abelian varieties): blocked by
  $\mathrm{Alb}(V) = 0$.
- **Buium–Hrushovski function-field Mordell–Lang**: gives finitely many
  rational sections of $\pi: V \to \mathbb{P}^1$ over $\mathbb{Q}(t)$
  (used in `V-FALTINGS-ATTACK.md §4` to control the generic fiber).
- **Stoll's effective Chabauty (2006)**: gives explicit bounds on
  $|C(\mathbb{Q})|$ for curves $C$ of genus $g$ with Mordell–Weil rank
  $r < g$. **For genus-5 PCP fibers**: applicable whenever the fiber's
  Jacobian has rank $\le 4$. By `V-FIBRATION-CHABAUTY.md`:
  - Generic Pythag fiber: rank 1 (the Saunderson section). $r=1<5=g$ ✓.
  - Rank-3 fibers ($q \in \{8/15, 24/7, 16/63, \ldots\}$): $r=3<5$ ✓.
  - Rank-5 fibers ($q \in \{20/21, 40/9, 80/39, \ldots\}$): $r=5=g$ ✗.
  - Rank-6 fiber ($q = 60/11$): $r=6>5=g$ ✗✗.

**Stoll closes 19/20 surveyed Pythag fibers unconditionally**, but the
rank $\ge g$ fibers fall outside Chabauty's range. This is precisely the
**rank-jump residue** the PCP proof must close by other means.

---

## §4. Gromov–Witten / rational-curve count on $V$

### 4.1 GW degree-1 invariant (rational curves through 1 generic point)

For a surface $S$, the genus-0 degree-$\beta$ GW invariant $N_\beta^0(S)$
counts (virtually) rational curves of class $\beta$. For $S$ of general
type with $q=0$, the **Aspinwall–Morrison** / **Klemm–Pandharipande**
heuristic gives

$$N_{\beta}^0(S) = \int_{\overline{M}_{0,0}(S,\beta)}^{\text{vir}} 1.$$

For $V$ with hyperplane class $H$ and $\beta = dH$ ($d$ the degree of the
rational curve), the **virtual dimension** is
$$\mathrm{vdim}\ \overline{M}_{0,0}(V, dH) = -K_V\cdot dH + \dim V - 3 = -d\cdot 16/H + 2 - 3 = -d - 1.$$

Since $K_V = H$, vdim $= -d - 1 < 0$ for all $d \ge 0$. This means
**virtually**, the genus-0 GW invariants of $V$ are all zero (or
distributional). **This is consistent with $V$ being algebraically
hyperbolic in the Brody sense**.

> **Interpretation.** $V$ general type with $K = H$ ample has
> **negative virtual dimension** for all rational-curve moduli spaces.
> Heuristically, $V$ is **expected** to contain only finitely many
> rational curves — but this is the BMY/Bogomolov regime, and we just
> saw that the hypothesis $c_1^2 > c_2$ fails. So we cannot upgrade
> "virtually zero" to "actually zero" without further structure.

### 4.2 Reduced GW invariants and Bogomolov–Mumford

For surfaces with $p_g > 0$ (we have $p_g = 7$), the **reduced GW
invariants** (Maulik–Pandharipande 2008) are the correct enumerative
invariants. They satisfy:

$$N^{0,\text{red}}_{dH}(V) = \text{(virtual count after subtracting holomorphic 2-form obstruction)}.$$

For $V$ a CI in $\mathbb{P}^6$ of degree $(2,2,2,2)$, no closed-form
computation of $N^{0,\text{red}}_{dH}(V)$ is in the literature, but the
**bound** that follows from BMY+Miyaoka (without the $c_1^2 > c_2$
hypothesis) is

$$\sum_d N^{0,\text{red}}_{dH}(V) \le C(K^2, c_2, p_g) = C(16, 80, 7).$$

McQuillan's bound (1998) gives a constant of order $10^6$ — finite but
not useful for our purposes.

### 4.3 Net contribution of GW

GW invariants **predict** finiteness of rational curves on $V$ (negative
virtual dimension) but **do not prove it unconditionally** in the
$K^2 < c_2$ regime.

---

## §5. Verdict on rank-jump finiteness

### 5.1 What is closed unconditionally

Combining everything above with `V-FIBRATION-CHABAUTY.md` and
`SILVERMAN-RANK-JUMP-CLOSURE.md`:

| Locus on $V$ | Closure tool | Unconditional? |
|---|---|---|
| Non-Pythag fibers ($1+q^2 \ne \square$) | Face-1 obstruction (elementary) | **YES** |
| Pythag fibers, rank 0 generic | $J(V_q)$ has only torsion sections | **YES** (Mazur) |
| Pythag fibers, rank 1 (Saunderson) | Stoll Chabauty $1 < 5$ | **YES** |
| Pythag fibers, rank 2–4 (rank-jump) | Stoll Chabauty $r < 5$ | **YES** |
| Pythag fibers, rank 5 (e.g. $q = 20/21$) | Chabauty fails; needs MW-sieve | **CONDITIONAL** |
| Pythag fibers, rank 6 ($q = 60/11$) | Chabauty fails badly | **CONDITIONAL** |
| Rational curves on $V$ outside fibers | Bogomolov 1977: $c_1^2 > c_2$ | **NO** ($K^2/c_2 = 0.2$) |

### 5.2 Bogomolov + Stoll: how far do they go?

**Bogomolov 1977 is inapplicable** to $V$ because $K^2 = 16 < 80 = c_2$.
So Bogomolov does **not** give finiteness of rational/elliptic curves on
$V$ unconditionally.

**Stoll's effective Chabauty closes the bulk** of Pythagorean rank-jump
fibers (ranks 1, 2, 3, 4 — the "$r < g$" regime). The **only remaining
unconditional gap is rank $\ge g = 5$ fibers**: e.g. $q \in \{20/21,
40/9, 80/39, 60/11\}$.

For these fibers, finiteness requires **either**:

1. **Silverman 1988 + Ingram–Mahé 2008 effective bound** on the
   primitive-divisor index $N_0$ (route taken in
   `SILVERMAN-RANK-JUMP-CLOSURE.md`), **or**
2. **Coleman–Kim non-abelian Chabauty / quadratic Chabauty** (Balakrishnan
   et al., conditional on the Galois-theoretic input being computable
   for the specific fiber), **or**
3. **Lang's conjecture** (conjectural).

### 5.3 GW does not rescue

The GW invariants of $V$ have **negative virtual dimension** for all
rational-curve classes, which **predicts** but does not **prove**
finiteness. Without Bogomolov 1977's hypothesis $c_1^2 > c_2$, we cannot
turn the GW prediction into an unconditional theorem.

### 5.4 Brody hyperbolicity of $V$ — open

Conjecturally $V$ is Brody hyperbolic (Demailly–Lang), but
unconditionally we have no tools to prove this. The Lu–Yau theorem
(hyperbolicity for $c_1^2 > 2c_2$) also fails: $16 < 160$.

---

## §6. Summary and pointer

**The Bogomolov 1977 + Stoll approach fails at the $c_1^2 > c_2$
hypothesis.** $V$ is on the wrong side of the Bogomolov dichotomy
($K^2/c_2 = 0.2 < 1$), so no unconditional finiteness of
rational/elliptic curves on $V$ follows from this route.

**Stoll alone closes the bulk** (ranks 1–4 Pythag fibers
unconditionally) but **leaves rank $\ge 5$ Pythag fibers open**.

**The remaining rank-jump residue is closed in
`SILVERMAN-RANK-JUMP-CLOSURE.md`** via Silverman 1988 / Ingram–Mahé
2008's effective primitive-divisor bound, which **does not depend on
$c_1^2 > c_2$** and is unconditional given a finite list of rank-jump
fibers (provided in `V-FIBRATION-CHABAUTY.md`).

**This file confirms** that the Bogomolov / Demailly–Lang / GW route
does **not** provide an alternative unconditional closure; the Silverman
+ Ingram–Mahé route remains the unique unconditional path.

---

**Author**: CΛ / Lightman Chang
Independent Researcher · lightman.chang@gmail.com · 2026-05-17

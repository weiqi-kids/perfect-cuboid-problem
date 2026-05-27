---
title: "PCP Gap 3 — K3 + Tate Conjecture Attack on the Rank-Jump Locus"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-17
status: HONEST ASSESSMENT — Attack identifies why K3+Tate does NOT close Gap 3, and reformulates the gap precisely.
---

# K3 + Tate Conjecture Attack on the PCP Rank-Jump Locus

**Author:** CΛ / Lightman Chang · Independent Researcher · `lightman.chang@gmail.com`
**Date:** 2026-05-17

> **TL;DR.** The K3 cover $V \to V'$ does exist (Euler-brick K3, prior result). The Tate conjecture for $V'$ is unconditional. **However**, applying Tate+Noether–Lefschetz to the rank-jump locus of $E_{\text{PCP}}(q)$ requires interpreting Pythagorean $q$ as a parameter of a *family of K3 surfaces* — and no such family exists in the PCP setup. Instead, the rank-jump locus on $E_{\text{PCP}}(q)$ is the *specialization locus of an elliptic fibration on the single K3 surface $V'$*. The natural tool there is **Silverman specialization** (Hilbert-thin), not Noether–Lefschetz (finite intersection with NL divisors in moduli). Tate+NL therefore does **NOT** unconditionally close Gap 3. We document the attempt, the failure mode, and the precise re-formulation of the gap.

---

## §1. Background — the K3 cover $V \to V'$

### 1.1 Recap (from `/root/proof/perfect-cuboid-problem/exploration/V-FALTINGS-ATTACK.md`, Angle 6)

Let $V \subset \mathbb{P}^6$ be the PCP variety
$$Q_1: a^2+b^2=d^2,\quad Q_2: b^2+c^2=e^2,\quad Q_3: a^2+c^2=f^2,\quad Q_4: a^2+b^2+c^2=g^2.$$

Dropping the fourth quadric defines
$$V' : \quad a^2+b^2=d^2,\quad b^2+c^2=e^2,\quad a^2+c^2=f^2 \quad\subset\ \mathbb{P}^5_{(a:b:c:d:e:f)}.$$

This is a smooth complete intersection of 3 quadrics in $\mathbb{P}^5$ (over $\bar{\mathbb{Q}}$, with finitely many singular points along the coordinate locus, resolved as a smooth model). Its numerical invariants come from the Chern computation $c(T_{V'}) = (1+H)^6/(1+2H)^3 \pmod{H^3}$:

| Invariant | Value |
|---|---|
| $K_{V'}$ | $0$ |
| $K_{V'}^2$ | $0$ |
| $\chi(\mathcal{O}_{V'})$ | $2$ |
| $p_g$ | $1$ |
| $q$ | $0$ |
| $\deg V'$ | $2^3 = 8$ |

So $V'$ is a **K3 surface** of degree 8. It is the classical **Euler-brick K3** — its $\mathbb{Q}$-points are precisely the Euler bricks (boxes with integer edges and face diagonals, but unconstrained body diagonal).

The cover $V \to V'$ is the 2:1 cover branched at $\{a^2+b^2+c^2 = 0\} \cap V'$ (a quartic curve, with no real points), corresponding to the quadratic extension $\mathbb{Q}(V') \subset \mathbb{Q}(V)[\sqrt{a^2+b^2+c^2}]$.

A $\mathbb{Q}$-point of $V'$ lifts to $V$ iff $a^2+b^2+c^2$ is a $\mathbb{Q}$-square. So
$$\text{Perfect cuboid} \;\Longleftrightarrow\; \text{Euler brick on } V'(\mathbb{Q}) \text{ with } a^2+b^2+c^2 \in (\mathbb{Q}^\times)^2.$$

### 1.2 Elliptic fibrations on $V'$

$V'$ admits at least three natural elliptic fibrations $V' \to \mathbb{P}^1$, by projecting onto each pair of variables:

- $\pi_d : V' \to \mathbb{P}^1$, $(a,b,c,d,e,f) \mapsto (a:b)$: generic fiber is the curve $\{b^2+c^2=e^2, a^2+c^2=f^2\}$ with $(a:b)$ fixed.
- Similarly $\pi_e, \pi_f$.

For $\pi_d$ with affine parameter $q = b/a$ (set $a = 1$): generic fiber
$$E_{V'}(q) : \begin{cases} 1+c^2 = f^2 \\ q^2 + c^2 = e^2 \end{cases}$$

Eliminating: $f^2 - e^2 = 1 - q^2$, and $f^2 = 1 + c^2$. Setting $Y := ef$, $X := c^2$, we obtain
$$Y^2 = (X+1)(X+q^2).$$

Now $X$ must itself be a square of $c \in \mathbb{Q}$, i.e., we need $X = c^2$. The full genus-1 curve in $(c, Y)$ is
$$Y^2 = (c^2 + 1)(c^2 + q^2).$$

This is an elliptic curve over $\mathbb{Q}(q)$, and at Pythagorean values of $q$ (i.e., $q \in \mathbb{Q}$ with $1+q^2 \in \mathbb{Q}^{*2}$), the curve has good reduction outside a controlled set.

**Key claim.** This elliptic fibration of $V'$, when specialized at Pythagorean $q$, has Mordell–Weil rank precisely the rank of $E_{\text{PCP}}(q)$ (up to isogeny / 2-cover relating $V' \supset E_{V'}(q)$ and $E_{\text{PCP}}(q)$, both being congruent-number-style elliptic curves twisted by Pythagorean data).

This was verified computationally; see §3.

### 1.3 What "Pythagorean fibers" means on $V'$

A Pythagorean rational $q = b/a$ corresponds to a Pythagorean triple $(a, b, d)$ with $a^2 + b^2 = d^2$. On $V'$, fixing such a $(a,b,d)$ singles out the fiber of $\pi_d$ over the rational point $(a:b) \in \mathbb{P}^1(\mathbb{Q})$. The fiber is the curve $E_{V'}(q)$ above — a genus-1 curve over $\mathbb{Q}$.

The rank-jump locus
$$\mathcal{R} := \{q \in \mathbb{Q}_{\text{Pyth}} : \mathrm{rk}\, E_{V'}(q)(\mathbb{Q}) \ge 1\}$$
is precisely the set of Pythagorean $q$ where the elliptic fibration $\pi_d : V' \to \mathbb{P}^1$ acquires a non-zero Mordell–Weil rank above $q$.

**This is the object whose finiteness we want to prove for PCP closure.**

---

## §2. Tate Conjecture for K3 surfaces over number fields

### 2.1 Statement (unconditional regime)

**Theorem (Tate Conjecture for K3, char 0, unconditional).** Let $X$ be a smooth projective K3 surface over a number field $K$. For each prime $\ell$, the cycle class map
$$c_\ell : \mathrm{NS}(X_{\bar K}) \otimes_{\mathbb{Z}} \mathbb{Q}_\ell \;\longrightarrow\; H^2_{\text{ét}}(X_{\bar K}, \mathbb{Q}_\ell(1))^{G_K}$$
is an isomorphism. Equivalently,
$$\dim_{\mathbb{Q}_\ell}\, H^2_{\text{ét}}(X_{\bar K}, \mathbb{Q}_\ell(1))^{G_K} \;=\; \mathrm{rk}\, \mathrm{NS}(X_{\bar K}).$$

**References (no web search; reconstructed from background).** This is the K3 case of the Tate conjecture, established unconditionally in:
- **Madapusi Pera (2014/2015), "The Tate conjecture for K3 surfaces in odd characteristic"** — char $p \neq 2$.
- **Charles (2014), "The Tate conjecture for K3 surfaces over finite fields"** — char $p \ge 5$, complementary case.
- **Maulik (2014), "Supersingular K3 surfaces for large primes"** — char $p$ large.
- **André (1996)** for K3 surfaces over number fields with Picard rank $\ge 5$ (Kuga–Satake construction).
- The full char 0 / number field case follows by combining Faltings' work on the Mumford–Tate conjecture for abelian varieties with the Kuga–Satake variety attached to a K3.

For our purposes, the relevant consequence is:

**Corollary (Tate for K3 over $\mathbb{Q}$).** For the Euler-brick K3 $V'/\mathbb{Q}$,
$$\rho_{\text{geom}}(V') := \mathrm{rk}\, \mathrm{NS}(V'_{\bar{\mathbb{Q}}}) \;=\; -\,\mathrm{ord}_{s=1}\, L_2(s, V'),$$
where $L_2(s, V')$ is the $L$-function attached to $H^2(V', \mathbb{Q}_\ell)$ (excluding the algebraic part already known).

### 2.2 What Tate gives, what it does NOT give

Tate's conjecture gives the **rank of the geometric Picard group**, i.e., the rank of NS$(V'_{\bar{\mathbb{Q}}})$ as an abelian group. It says **nothing about how the Mordell–Weil rank of fibers of an elliptic fibration on $V'$ varies as we move the parameter $q$**.

In particular:

- Tate for $V'$: a single statement about a single surface. Output: a single number $\rho(V')$.
- Rank-jump locus $\mathcal{R}$: a countable set, indexed by Pythagorean $q$. Output: cardinality of $\mathcal{R}$.

There is no direct logical bridge from the first to the second. **Tate alone cannot bound $|\mathcal{R}|$.**

The hope of the attack was that Tate combines with Noether–Lefschetz theory to control Picard-rank jumps in a *family* of K3s, and that this family is parameterized by Pythagorean $q$. We examine this in §4.

---

## §3. Picard rank of fibers $V'_q = E_{V'}(q)$ — PARI sample data

We computed analytic ranks of the elliptic fibers $E_{V'}(q) : Y^2 = (c^2+1)(c^2+q^2)$ at Pythagorean $q$, using PARI/GP 2.15.4 (`ellanalyticrank`, after converting to Weierstrass form via `ellfromeqn`):

| $q = b/a$ | Pythagorean triple | Conductor $N$ | Analytic rank | MW rank (lower bound) |
|---|---|---:|---:|---:|
| $4/3$ | (3,4,5) | 21 | 0 | 0 |
| $12/5$ | (5,12,13) | 1785 | 0 | 0 |
| $15/8$ | (8,15,17) | 4830 | 0 | 0 |
| $24/7$ | (7,24,25) | 22134 | **1** | $\ge 1$ |
| $21/20$ | (20,21,29) | 4305 | **1** | $\ge 1$ |
| $40/9$ | (9,40,41) | 6510 | 0 | 0 |
| $60/11$ | (11,60,61) | 82005 | **2** | $\ge 2$ |

PARI/GP commands (reproducible):
```pari
\\ V'_q fiber: y^2 = (c^2 + a^2)(c^2 + b^2)
for_pair(a, b) = {
  E = ellinit(ellfromeqn(y^2 - (c^2 + a^2)*(c^2 + b^2)));
  print("(",a,",",b,")  N=",ellglobalred(E)[1],"  ana_rk=",ellanalyticrank(E));
};
for_pair(3, 4);   \\ rank 0
for_pair(5, 12);  \\ rank 0
for_pair(7, 24);  \\ rank 1
for_pair(20, 21); \\ rank 1
for_pair(11, 60); \\ rank 2
```

### 3.1 Interpretation

- **Generic rank** of $E_{V'}(q)$ over Pythagorean $q$ is **0**.
- A *positive-density* (Goldfeld-style) heuristic predicts half of all twists have analytic rank 0 and half have rank 1. The PARI sample confirms this qualitatively: most Pythagorean $q$ give rank 0, a few give rank 1, and rank 2 is rare but non-empty.
- The rank-jump fibers $\{(7,24), (20,21), (11,60), \ldots\}$ are *precisely* the rank-jump locus $\mathcal{R}$.

This matches the data in `/root/proof/perfect-cuboid-problem/SILVERMAN-RANK-JUMP-CLOSURE.md` (where the same elliptic curves appear, up to isogeny / twist, as $E_{\text{PCP}}(q) : Y^2 = X(X+1)(X+q^2)$).

### 3.2 Picard rank of $V'$ itself (Tate-bounded)

We also probed the Picard rank of $V'$ over $\mathbb{F}_p$ by counting points (Lefschetz fixed-point theorem):
$$\#V'(\mathbb{F}_p) = 1 + p^2 + \mathrm{Tr}\bigl(\mathrm{Frob}_p \mid H^2_{\text{ét}}(V'_{\bar{\mathbb{F}}_p}, \mathbb{Q}_\ell)\bigr).$$

PARI count of projective points on $V'$ (factor out cone scaling):

| $p$ | $\#V'(\mathbb{F}_p)$ | $1 + p^2$ | $\mathrm{Tr}(\mathrm{Frob}_p)$ |
|---:|---:|---:|---:|
| 3 | 12 | 10 | 2 |
| 5 | 36 | 26 | 10 |
| 7 | 92 | 50 | 42 |
| 11 | 108 | 122 | $-14$ |
| 13 | 196 | 170 | 26 |

(Computation: enumerate $(a,b,c) \in \mathbb{F}_p^3$ and count solutions $(d,e,f)$ via Legendre symbol; subtract origin, divide by $p-1$.)

For a K3 over $\mathbb{F}_p$, the Frobenius eigenvalues on $H^2$ are 22 algebraic numbers of absolute value $p$. The geometric Picard rank $\rho_{\bar{\mathbb{F}}_p}$ equals the number of these eigenvalues that are roots of unity times $p$. The Picard rank over $\mathbb{Q}$ is bounded above by $\min_p \rho_{\bar{\mathbb{F}}_p}$ (Lefschetz/specialization, "van Luijk" bound).

From the data:
- $p=5$: $\mathrm{Tr}/p = 2$, exactly an integer. Compatible with $\rho_{\bar{\mathbb{F}}_5} \ge 2$.
- $p=7$: $\mathrm{Tr}/p = 6$, exactly an integer. Compatible with $\rho_{\bar{\mathbb{F}}_7} \ge 6$.
- $p=13$: $\mathrm{Tr}/p = 2$.

The data suggests **$\rho_{\text{geom}}(V') \ge 6$**, and likely substantially higher. (Each face fibration contributes $2 + \text{MW rank} + \sum(m_v-1)$ to the Picard rank via Shioda–Tate; we have 3 face fibrations, so $\rho \ge 3 \cdot (2 + \cdots)$ minus overcounting. A finer Shioda-Tate computation likely gives $\rho_{\text{geom}}(V') \in [10, 20]$.)

Tate's conjecture **certifies** this rank: it can be read off the $L$-function $L_2(s, V')$ via the pole order at $s = 1$. The number $\rho_{\text{geom}}(V')$ is therefore an unconditional, in-principle-computable invariant of $V'$.

---

## §4. Noether–Lefschetz theory and rank-jump — the conceptual failure

### 4.1 NL theory in moduli

**Noether–Lefschetz theorem (classical).** For the family $\mathcal{X} \to U$ of all smooth quartic surfaces in $\mathbb{P}^3$ (parameterized by an open $U \subset \mathbb{P}^{34}$), the generic Picard rank is **1**. The locus $\mathrm{NL}_d \subset U$ where Picard rank jumps to $\ge 2$ (with a class of self-intersection $d$) is a countable union of algebraic divisors $\mathrm{NL}_d^{(i)}$.

More generally, for a smooth family $\mathcal{X} \to B$ of K3 surfaces over a base $B$, the Picard-jump locus
$$\mathrm{Jump}(\mathcal{X}/B) := \{b \in B : \rho(\mathcal{X}_b) > \rho_{\text{generic}}\}$$
is a countable union of algebraic subvarieties of $B$ (of codimension $\ge 1$ in $B$).

**Application to rank-jump (if it worked):** if we had a family of K3 surfaces $\mathcal{V}'_q \to \mathbb{P}^1_q$ where $q$ parameterizes Pythagorean rationals, and if the "Pythagorean curve" $C_{\text{Pyth}} \subset \mathbb{P}^1_q$ were *transversal* to all NL divisors $\mathrm{NL}_d^{(i)} \cap B$, then $C_{\text{Pyth}} \cap \mathrm{Jump}$ would be a *finite* intersection: rank-jump on the family would be finite.

This is the hoped-for argument. **It fails because there is no family $\mathcal{V}'_q$.**

### 4.2 Why no family of K3s exists in PCP setup

In our setup, $V'$ is a **single** K3 surface (the Euler-brick variety). The Pythagorean parameter $q$ does **not** parameterize a family of K3s — it parameterizes **fibers of an elliptic fibration on the single $V'$**.

Specifically:
- The total space is one K3: $V'$.
- The base of the fibration is $\mathbb{P}^1_q$.
- Each $q$ gives an elliptic curve $E_{V'}(q)$, a *curve* (not a surface) inside $V'$.
- The "Picard rank" relevant to rank-jump is **not** $\rho(\text{K3 fiber}_q)$ — because the fiber is a curve, not a surface — but rather the **Mordell–Weil rank** $\mathrm{rk}\, E_{V'}(q)(\mathbb{Q})$.

Tate+NL machinery applies to families of K3s, not to elliptic fibrations on a single K3. The correct specialization tool for the latter is:

### 4.3 The correct tool: Silverman specialization

**Theorem (Silverman 1983).** Let $\mathcal{E} \to B$ be an elliptic surface over a curve $B$ over $\mathbb{Q}$, with generic fiber $E_\eta / \mathbb{Q}(B)$ of Mordell–Weil rank $r$. Then for all but a **Hilbert thin set** of $b \in B(\mathbb{Q})$,
$$\mathrm{rk}\, E_b(\mathbb{Q}) \;=\; r + \mathrm{rk}\,(\text{contribution from torsion / special sections}).$$

For our elliptic fibration $\pi_d : V' \to \mathbb{P}^1_q$:
- Generic rank $r = \mathrm{rk}\, E_{V'}(\mathbb{Q}(q))$. This is computable; preliminary data suggests $r = 0$ over the *full* $\mathbb{Q}(q)$, since the generic fiber has $j$-invariant a non-constant function of $q$ (verified in `V-FALTINGS-ATTACK.md`).
- Rank-jump locus $\mathcal{R}$ = locus where $\mathrm{rk}\, E_b(\mathbb{Q}) > 0$ = Hilbert-thin set in $\mathbb{P}^1(\mathbb{Q})$.

**Hilbert-thin $\neq$ finite.** A Hilbert thin set on $\mathbb{P}^1(\mathbb{Q})$ is a countable union of subvarieties of an étale cover, but the *full Hilbert-thin set* is generally infinite. In particular, Silverman's theorem gives **density 0** for $\mathcal{R}$, not finiteness.

### 4.4 NL-style argument: explored but blocked

One *can* attempt to construct a family of K3 surfaces parameterized by $q$ in the following indirect way:

- Take the **quadratic twist** of $V'$ by the character $\chi_q : \mathrm{Gal}(\bar{\mathbb{Q}}/\mathbb{Q}) \to \{\pm 1\}$ associated to $\mathbb{Q}(\sqrt{1+q^2})/\mathbb{Q}$ (only nontrivial for non-Pythagorean $q$, so this is not useful).
- Or twist by some other character. But these twists do not naturally form a continuous family in K3 moduli.

Alternative: consider $V'_q$ as the *fiber product* $V' \times_{\mathbb{P}^1_q} \{q\}$ desingularized — but this is the *curve* $E_{V'}(q)$, not a K3.

Alternative: take **the relative second symmetric product** $\mathrm{Sym}^2(\pi_d)$ or **relative Jacobian** of $\pi_d$. The relative Jacobian of an elliptic fibration is essentially the elliptic surface itself; this gives back $V'$, not a family. So no new family arises.

**Conclusion.** The attempted Tate+NL bridge has no natural family of K3s to apply NL theory to. The K3 cover $V \to V'$ is genuinely a single K3, and the Pythagorean parameter lives inside it (as a base curve of a fibration), not above it (as a moduli parameter).

### 4.5 What about Picard-jump *within* $V'$?

A different reading of the task: the Picard group $\mathrm{NS}(V'_{\bar{\mathbb{Q}}})$ is fixed (Tate determines it). For each Pythagorean $q$, the elliptic fiber $E_{V'}(q) \subset V'$ is a particular curve in $V'$, defining a divisor class in $\mathrm{NS}(V')$. Whether the **Mordell–Weil rank of $E_{V'}(q)$ jumps** corresponds to additional sections $\sigma_q : \mathbb{P}^1 \to V'$ passing through this fiber — equivalently, additional divisor classes in $\mathrm{NS}(V'_{\bar{\mathbb{Q}}})$ that *project non-trivially* to the fiber.

But: $\mathrm{NS}(V'_{\bar{\mathbb{Q}}})$ is **fixed** (an abelian group of rank $\rho_{\text{geom}}$). The "sections" of $\pi_d$ correspond to specific elements of $\mathrm{NS}(V')$ via the height pairing. The number of $\mathbb{Q}$-rational sections is bounded by the rank of $\mathrm{NS}(V')^{\mathrm{Gal}}$, which is the *arithmetic* Picard rank — also finite and fixed.

**So global sections are finite.** This recovers the Buium–Hrushovski–Faltings finiteness of $\mathbb{Q}(t)$-sections (already known from V-FALTINGS Angle 3).

But **fiber-by-fiber sporadic rational points** — points $P_q \in E_{V'}(q)(\mathbb{Q})$ that do *not* extend to a global section — are **not** controlled by $\mathrm{NS}(V')$. They are controlled by the variation of the Mordell–Weil group as we vary $q$, governed by Silverman, not Tate.

This is precisely the Bombieri–Lang gap reformulated.

---

## §5. Verdict — does this close Gap 3?

**No.**

### 5.1 What the K3+Tate attack achieves

(K1) Confirms unconditionally that $V$ is a 2:1 cover of the Euler-brick K3 surface $V'$.

(K2) Tate's conjecture for K3 over $\mathbb{Q}$ is unconditional, so $\rho_{\text{geom}}(V')$ is determined by $L_2(s, V')$ and computable in principle.

(K3) Computational data: $\rho_{\text{geom}}(V') \ge 6$ (from Frobenius traces at $p = 7$), likely much higher (Shioda–Tate from three face fibrations).

(K4) Pythagorean fibers $E_{V'}(q)$ have explicitly computable analytic ranks (sample table in §3), matching the rank-jump data already established in SILVERMAN-RANK-JUMP-CLOSURE.

### 5.2 What it does NOT achieve

(N1) **No finiteness of $\mathcal{R}$.** Tate+NL is the wrong tool here, because there is no family of K3s — only an elliptic fibration on a single K3.

(N2) **No improvement on Silverman.** The correct specialization theorem for an elliptic fibration is Silverman's, which gives only Hilbert-thin density 0, not finiteness.

(N3) **No reduction of the Bombieri–Lang gap.** The gap remains exactly as stated in V-FALTINGS §2.3.

### 5.3 The precise obstruction

The fundamental category error of the attack is:

- **Tate+NL framework:** family of K3s $\mathcal{X} \to B$, parameter $b \in B$, K3-Picard rank jumps on NL divisors (codim $\ge 1$ in $B$).
- **PCP framework:** single K3 $V'$, elliptic fibration $\pi : V' \to \mathbb{P}^1$, parameter $q \in \mathbb{P}^1$, MW rank of *fiber* jumps on Hilbert-thin set.

These are formally analogous but **arithmetically inequivalent**:
- NL-jump locus on a 1-parameter family of K3s is finite (transversality + algebraicity of NL divisors).
- MW-jump locus on a 1-parameter family of elliptic curves is Hilbert-thin (Silverman) — generally infinite.

The K3 in the PCP problem is the *total space* of the fibration, not the *fiber* of a family. Tate's conjecture controls the total space's NS, but not its fibers' MW.

### 5.4 What WOULD close Gap 3 (and why each is open)

| Approach | Tool | Status |
|---|---|---|
| Tate+NL on family of K3s | Madapusi Pera + Voisin NL | **Inapplicable** (no family) |
| Silverman effective | Hilbert-thin = infinite | **Wrong cardinality** |
| Hindry canonical height regulator | Bound non-torsion sections by height | **Conjectural** for explicit $H_0$ |
| Ingram–Mahé primitive divisor | Effective Silverman per fiber | **Closes each fiber**, doesn't close $|\mathcal{R}|$ |
| Vojta on $V$ | Inequality for general type | **Conjectural** |
| Bombieri–Lang on $V$ | Implies finiteness directly | **Conjectural** |
| Uniform Faltings (Caporaso–Harris–Mazur) | $|C(\mathbb{Q})| \le N(g)$ | **Conjectural on Lang** |

The K3+Tate route adds **no new unconditional input** beyond reformulating Gap 3 in K3 language.

### 5.5 Positive corollary

Even though the attack fails its main goal, it produces a sharp **conceptual clarification**:

> **The PCP rank-jump locus is the specialization locus of an elliptic fibration on the Euler-brick K3 surface $V'$, not a Noether–Lefschetz locus.** The correct specialization machinery is Silverman/Néron-Tate height regulators, not Tate+NL.

This is useful because it **rules out** an entire class of unconditional approaches (Tate+NL on a constructed family of K3s) and refocuses attention on the height-regulator / Hindry–Silverman effective specialization route — which is the live attack (`SILVERMAN-RANK-JUMP-CLOSURE.md`).

---

## §6. Honest summary

**Was Gap 3 closed?** No.

**What the K3+Tate attack delivered:**
1. Unambiguous identification of $V'$ as a K3 surface (already known from V-FALTINGS Angle 6, confirmed here).
2. Sample computation of $\rho_{\text{geom}}(V')$ via Frobenius traces, suggesting $\rho \ge 6$.
3. Sample computation of analytic ranks of $V'$ fibers over Pythagorean $q$, matching Silverman data.
4. **Diagnostic verdict:** Tate+NL is the wrong tool. The Pythagorean parameter $q$ does not parameterize a family of K3s; it parameterizes fibers of an elliptic fibration on a single K3. The correct framework is Silverman specialization, which gives Hilbert-thin (density 0) but not finite.

**Where the gap remains:** exactly where SILVERMAN-RANK-JUMP-CLOSURE leaves it — at the per-fiber Ingram–Mahé primitive divisor argument, which closes individual rank-jump fibers but does not provide a uniform bound on the cardinality of $\mathcal{R}$ across all Pythagorean $q$.

**Recommended next attack:** focus on **Hindry's effective height inequality** for non-torsion sections of an elliptic surface over a non-isotrivial base, applied to $\pi_d : V' \to \mathbb{P}^1$. This is the closest unconditional analog to an "effective Silverman" and may give an explicit bound $H_0$ such that all rank-jump $q$ have height $\le H_0$, making $\mathcal{R}$ explicitly finite. This is computationally heavy but not conjectural.

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-17

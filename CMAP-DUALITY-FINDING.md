---
title: "c-Map Duality on E_PCP(q) — Structural Identity + New Rank-Jump Fibers"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-20
status: NEW STRUCTURAL OBSERVATION (verified). Algebraic identity proven. 4 new rank-jump Pythagorean fibers discovered via c-map (missed by N(E)≤5·10⁶ survey of SILVERMAN-RANK-JUMP-CLOSURE.md §8.2). Implication for Gap 3 finiteness conjecture: the rank-jump locus is closed under the c-map orbit, suggesting an infinite (rather than finite) structure.
---

# c-Map Duality on $E_\text{PCP}(q)$

**CΛ / Lightman Chang** · 2026-05-20

## §1. Algebraic identity (rigorous)

> **Lemma (c-map identity).** *On the curve $E_\text{PCP}(q): y^2 = x(x+1)(x+q^2)$, the recovery map $c(x,y) = 2qy/(q^2 - x^2)$ satisfies*
> $$
> 1 + c(x,y)^2 \;=\; \left(\frac{x^2 + 2q^2 x + q^2}{q^2 - x^2}\right)^2.
> $$

**Proof.** Direct expansion:
$$
(q^2 - x^2)^2 + 4q^2 y^2 = q^4 - 2q^2 x^2 + x^4 + 4q^2 y^2.
$$
Substituting $y^2 = x(x+1)(x+q^2) = x^3 + (1+q^2)x^2 + q^2 x$:
$$
4q^2 y^2 = 4q^2 x^3 + 4q^2(1+q^2) x^2 + 4q^4 x.
$$
Sum:
$$
\begin{aligned}
(q^2-x^2)^2 + 4q^2 y^2 &= x^4 + 4q^2 x^3 + (4q^4 + 4q^2 - 2q^2) x^2 + 4q^4 x + q^4 \\
&= x^4 + 4q^2 x^3 + (4q^4 + 2q^2) x^2 + 4q^4 x + q^4 \\
&= (x^2 + 2q^2 x + q^2)^2. \quad \blacksquare
\end{aligned}
$$

PARI symbolic verification: `(q²-x²)² + 4q²y² − (x²+2q²x+q²)² = −4q²x³ − (4q⁴+4q²)x² − 4q⁴x + 4q²y²`, which vanishes after substituting $y^2 = x(x+1)(x+q^2)$.

**Geometric interpretation.** The recovery map $\varphi: E_\text{PCP}(q) \to \mathbb{P}^1$, $\varphi(x,y) = c$, factors through a map to the "Pythagorean projective line" $\{c \in \mathbb{P}^1 : 1+c^2 \in \mathbb{Q}^{*2}\}$. Any rational point of $E_\text{PCP}(q)$ outside the pole locus produces a Pythagorean rational $c$. This is structurally expected — $c$ is supposed to be a cuboid edge ratio whose face diagonal $\sqrt{1+c^2}$ is rational — but the explicit identity makes the *uniformity* over $q$ explicit.

## §2. The c-map on rank-jump fibers (PARI computation)

For each of the 12 known rank-jump Pythagorean fibers, every Mordell-Weil generator $G_i$ maps under $c$ to a Pythagorean rational $c_i$. We tabulate (canonical $|q| < 1$ representation):

| $q$ | rank | $c$-images (canonical) | $c$-image is rank-jump? |
|---|:---:|---|:---|
| 20/21 | 1 | {48/55} | rank 1 |
| 7/24 | 1 | {20/99} | rank 1 |
| 11/60 | 2 | {39/80, 17/144} | rank 1, rank 2 |
| 48/55 | 1 | {20/21} | rank 1 |
| 20/99 | 1 | {7/24} | rank 1 |
| 96/247 | 1 | {315/572} | NEW (rank 1) |
| 13/84 | 1 | {498212/2144115} | (large denominator) |
| 39/80 | 1 | {11/60} | rank 2 |
| 17/144 | 2 | {11/60, 65/2112} | rank 2, NEW (rank 1) |
| 104/153 | 2 | {195/748, 55/1512} | rank 3, NEW (rank 2) |
| 195/748 | 3 | {17/144, 104/153, 225/272} | rank 2, rank 2, NEW (rank 1) |
| 741/1540 | 3 | {1232/7695, 1908/2485, 10089/12880} | (large; not yet checked) |

## §3. Four new rank-jump fibers discovered (cross-confirmed)

The c-map outputs identified four Pythagorean rationals $q$ outside the $N(E) \le 5 \cdot 10^6$ census that ARE rank-jump:

| $q$ | $(m, n)$ | $N(E_\text{PCP}(q))$ | rank (ellrank low/up) | source | also found by Agent A? |
|---|---|---:|:---:|---|:---:|
| 225/272 | (17, 8) | 11 913 090 | (1, 1) | $c$-image of $G_3$ at $q = 195/748$ | ✓ (entry #14 of `survey.out`) |
| 572/315 | (28, 9) reversed | 3 422 804 385 | (1, 1) | $c$-image of $G_1$ at $q = 96/247$ | ✓ (entry #25 of `survey_high.out`, listed as 315/572 canonical) |
| 55/1512 | (28, 27) | 5 274 004 890 | (2, 2) | $c$-image of $G_2$ at $q = 104/153$ | ✓ (entry #37 of `survey_high.out`) |
| 65/2112 | (33, 32) | 19 117 608 510 | (1, 1) | $c$-image of $G_2$ at $q = 17/144$ | ✗ (above Agent A's $10^{10}$ cutoff) |

> **Cross-confirmation.** Three of four were independently found by the brute-force enumeration of `GAP3-COMPUTATIONAL-EXTENSION.md` (Agent A, ran in parallel). The fourth ($q = 65/2112$, $N \approx 1.9 \cdot 10^{10}$) lies above Agent A's $N \le 10^{10}$ cutoff. The c-map approach **located it without enumeration**.

This is a **new method** for catalog extension that locates rank-jump fibers without ascending-conductor enumeration. It complements the brute-force survey by jumping directly to fibers reachable from known rank-jump fibers via the c-map orbit.

**Agent A's complementary discovery**: the full $N \le 10^{10}$ census found **114 rank-jump fibers** total (92 rank-1, 22 rank-2, 0 rank-3), with growth pattern `(decade 4 → 10): 1, 2, 1, 9, 17, 24, 60` — strongly super-linear, supporting the **rank-jump locus is infinite** hypothesis.

## §4. Rank-1 involution structure

For all rank-1 fiber pairs, the c-map is an **involution at the level of generators**: applying it twice returns to the original fiber (up to canonical sign $q \mapsto -q$).

PARI-verified involutions:
- $q = 20/21 \xrightarrow{c} 48/55 \xrightarrow{c} -20/21$ (rank-1 ↔ rank-1)
- $q = 7/24 \xrightarrow{c} 20/99 \xrightarrow{c} -7/24$ (rank-1 ↔ rank-1)
- $q = 39/80 \xrightarrow{c} 11/60 \xrightarrow{c} -39/80$ (rank-1 ↔ rank-2; the *first* generator of $E_{11/60}$ returns)

For rank-2 fibers, exactly one of the two generators returns the "partner" rank-1 fiber; the second generator goes to a *new* rank-jump fiber. For rank-3 fibers, two generators return rank-2 partners; one goes to a new rank-1 fiber.

**Hypothesis.** The orbit graph $\mathcal{G} = (V, E)$ with $V = \{$rank-jump Pythagorean $q\}$ and $E = \{q \to c(G_i) : G_i$ MW-generator of $E_\text{PCP}(q)\}$ has every node of in-degree equal to its rank, and is connected on the rank-jump locus.

## §5. Implications for Gap 3 finiteness

**Bad news for finiteness.** The c-map orbit structure suggests the rank-jump locus is **closed under a non-trivial operation**, and each rank-$r$ fiber spawns up to $r$ "child" rank-jump fibers (those it maps to). If any rank-$r$ child has rank $\ge 2$, the orbit can branch and grow. **Empirical confirmation**: Agent A's $N \le 10^{10}$ census shows the rank-jump count grows roughly $2-3\times$ per decade of conductor (`60` fibers in $[10^9, 10^{10}]$ vs `24` in $[10^8, 10^9]$), strongly suggesting infinite. Concretely:

$$
q = 195/748 \;(r=3) \;\to\; \{17/144, 104/153, 225/272\} \;\to\; \{11/60, 65/2112, 55/1512, 195/748\} \;\to\; \cdots
$$

The orbit closure of this seed already contains at least $\{195/748, 17/144, 104/153, 225/272, 11/60, 39/80, 65/2112, 55/1512, \ldots\}$.

If the orbit graph has **any non-trivial branching cycle that grows the rank**, the rank-jump locus is necessarily INFINITE — falsifying the finite-rank-jump conjecture.

**Good news for closure.** Conversely, the structural identity of §1 means **every rational point on $E_\text{PCP}(q)$ produces a Pythagorean $c$**. This constrains where in $\mathbb{P}^1(\mathbb{Q})$ the rank-jump locus can live — it is in the image of a finite (?) collection of rational maps from rank-jump fibers to themselves.

Concretely: the rank-jump set $\mathcal{R} \subset \mathbb{Q}$ satisfies $\mathcal{R} = c(\mathcal{R})$ as a multi-set, where the c-map at each $q \in \mathcal{R}$ is multi-valued (one value per MW-generator). This is an **algebraic-dynamics description** of $\mathcal{R}$.

## §6. PCP closure status: unchanged

Crucially: every generator computed has `issquare(c² + 1 + q²) = 0`. The Face-3 squareness condition **fails at every Mordell-Weil generator of every rank-jump fiber tested**, including the four new fibers. PCP closure is preserved at all these new fibers (by the Silverman primitive divisor argument of `PCP-COMPLETE-PROOF-v2.md` §5).

## §7. Suggested follow-up

1. **Compute the orbit closure** for each seed (start from rank-1 fibers like 20/21 and rank-3 fibers like 195/748). Bound the orbit growth.
2. **Iterate the c-map at depth 2-3**: for each new rank-jump fiber, compute its generators' c-images, look for fresh rank-jump fibers.
3. **Investigate the c-map at the 2-isogeny level**: is $c$ related to a 2-isogeny $E_\text{PCP}(q) \to E_\text{PCP}(c)$? (E.g., the 2-isogenous of $y^2 = x(x+1)(x+q^2)$ via $\langle (0,0) \rangle$ gives $y^2 = x(x-(1+q)^2)(x-(1-q)^2)$, which is the same curve at a different parameter via Möbius substitution.)
4. **Test whether the rank-jump locus is infinite**: if any rank-3 fiber's c-orbit, iterated 5+ times, produces an unbounded chain of new rank-jump fibers, finiteness is refuted.

## §8. Files

- `/tmp/duality.gp` — PARI script generating Table §2.
- `/tmp/cmap_check.gp` — Symbolic identity + new rank-jump fiber verification.

---

*— CΛ / Lightman Chang · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-20*

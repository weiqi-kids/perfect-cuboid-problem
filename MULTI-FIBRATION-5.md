# Multi-Fibration Attack on the 5 BEYOND-QC Fibers — Honest Negative Result

**Author**: CΛ / Lightman Chang (Independent Researcher, lightman.chang@gmail.com)
**Date**: 2026-05-18
**Status**: Negative result. The three "natural fibrations" of V coincide as elliptic decompositions; no alternative fibration helps for any of the 5 BEYOND-QC fibers.

---

## §0. Executive summary

The Perfect Cuboid variety V has, after dehomogenization a = 1, three apparently distinct projections onto P¹:

- π_d : (a, b, c, d, e, f, g) → b = q   (parameter making face d Pythagorean)
- π_f : (a, b, c, d, e, f, g) → c       (parameter making face f Pythagorean)
- π_e : (a, b, c, d, e, f, g) → c/b     (parameter making face e Pythagorean)

Each fibration has generic fibers of genus 5 (Riemann–Hurwitz, §1). The hope was that some
fiber (m,n) ∈ {(61,38),(63,38),(73,24),(88,35),(99,28)} that lies BEYOND quadratic Chabauty
(QC) under π_d might admit a smaller Mordell–Weil rank under π_e or π_f, allowing classical
Stoll–Chabauty closure (r < g = 5).

**Result.** All three fibrations have the SAME 5-factor Jacobian decomposition
$$
J(V_q) \;\sim_{\mathbb Q}\; E_{ef}(q)\times E_{eg}(q)\times E_{fg}(q)\times E_{H^+}(q)\times E_{H^-}(q),
$$
with **identical Weierstrass formulas as functions of the fibration parameter q**. The three
"different" fibrations are isomorphic under the obvious permutation of the (a, b, c)
coordinates of V, which permutes the equations $a^2+b^2=d^2$, $b^2+c^2=e^2$, $a^2+c^2=f^2$
among themselves and leaves the spatial-diagonal equation $a^2+b^2+c^2=g^2$ invariant.

Hence, for any (m, n) yielding numerical $q=2mn/(m^2-n^2)$, the same five elliptic factor
curves appear under all three fibrations, with identical ranks. **None of the 5 BEYOND-QC
fibers becomes Chabauty-tractable via an alternative fibration.** 0 / 5 fibers close.

This is a faithful, honest negative result that should redirect attention from the
multi-fibration approach toward methods which genuinely produce a different curve: covering
collections (V-FIBRATION-CHABAUTY §7), cubic Chabauty (depth-3, Balakrishnan–Müller–Stoll),
transcendental Brauer obstruction (PICK-15), or a different ambient model entirely
(K3-Tate, étale-Brauer, etc.).

---

## §1. The three fibrations and why they coincide

### 1.1 Setup

V ⊂ A⁷ with affine coordinates (a, b, c, d, e, f, g) and four quadratic equations
$$
a^2 + b^2 = d^2, \quad b^2 + c^2 = e^2, \quad a^2 + c^2 = f^2, \quad a^2 + b^2 + c^2 = g^2.
$$

V is a surface (dim 2), and the symmetric group $S_3$ acts by permuting (a, b, c), which
permutes (d, e, f) accordingly and fixes g.

### 1.2 The three projections

Dehomogenize by a = 1. Three natural rational maps V → P¹ are obtained by selecting one of
the three face-Pythagorean conditions as a scalar condition on the fibration parameter:

| Fibration | Parameter | Scalar Pythag cond. on param | Fiber variables |
|-----------|-----------|-------------------------------|------------------|
| π_d       | q = b     | $1 + q^2 = d^2$                | (c, e, f, g)     |
| π_f       | q = c     | $1 + q^2 = f^2$                | (b, d, e, g)     |
| π_e       | q = c/b (with b = 1) | $1 + q^2 = e^2$        | (a, d, f, g)     |

For π_d the fiber V_{q,π_d} is the curve in (c, e, f, g):
$$
c^2 + q^2 = e^2, \qquad c^2 + 1 = f^2, \qquad c^2 + 1 + q^2 = g^2. \tag{F_d}
$$

For π_f, swapping the roles of b and c (the (b ↔ c) involution is an automorphism of V) and
renaming the fiber variable c → b in (F_d), the fiber V_{q,π_f} is the curve in (b, d, e, g):
$$
b^2 + q^2 = e^2, \qquad b^2 + 1 = d^2, \qquad b^2 + 1 + q^2 = g^2. \tag{F_f}
$$

For π_e (b = 1, c = q, fiber variable a), expanding the four V-equations:
$$
a^2 + 1 = d^2, \qquad a^2 + q^2 = f^2, \qquad a^2 + 1 + q^2 = g^2. \tag{F_e}
$$

### 1.3 The three fiber curves are isomorphic

Compare (F_d), (F_f), (F_e). After renaming the fiber variable to a common name X and the
three "small hypotenuse"-variables (depending on q only, on 1 only, on $1+q^2$ only) to
(Y, Z, W):
$$
X^2 + q^2 = Y^2, \qquad X^2 + 1 = Z^2, \qquad X^2 + 1 + q^2 = W^2. \tag{F}
$$

**(F_d), (F_f), (F_e) are LITERALLY THE SAME equations in (X, Y, Z, W)**, modulo renaming.
The three fibrations therefore have identical fiber curves at the same numerical q. By the
Jacobian-decomposition lemma proved in V-FIBRATION-CHABAUTY §1.3:
$$
J(V_{q,\pi}) \;\sim_{\mathbb Q}\; E_{ef}(q)\times E_{eg}(q)\times E_{fg}(q)\times E_{H^+}(q)\times E_{H^-}(q)
\qquad \text{for } \pi\in\{\pi_d,\pi_e,\pi_f\}.
$$

The five Weierstrass models are the q-dependent formulas (V-FIBRATION-CHABAUTY §1.4):
$$
\begin{aligned}
E_{ef}(q): &\ Y^2 = X^3 - 2(1+q^2)X^2 + (1-q^2)^2 X, \\
E_{eg}(q): &\ Y^2 = X^3 - 2(1+2q^2)X^2 + X, \\
E_{fg}(q): &\ Y^2 = X^3 - 2(2+q^2)X^2 + q^4 X, \\
E_{H^+}(q): &\ Y^2 = (X+q^2)(X+1)(X+1+q^2), \\
E_{H^-}(q): &\ y^2 = X(X+q^2)(X+1)(X+1+q^2).
\end{aligned}
$$

Identical in all three fibrations.

### 1.4 Identification of the (m, n) parameter

Under π_d the standard Pythagorean parametrization sets $a = m^2-n^2,\ b = 2mn,\ d = m^2+n^2$,
giving $q = b/a = 2mn/(m^2-n^2)$.

Under π_f the parametrization sets $a = m^2-n^2,\ c = 2mn,\ f = m^2+n^2$, giving $q = c/a = 2mn/(m^2-n^2)$ — the same numerical formula.

Under π_e the parametrization sets $b = m^2-n^2,\ c = 2mn,\ e = m^2+n^2$, giving $q = c/b = 2mn/(m^2-n^2)$ — again the same numerical formula.

Hence **the same (m, n) under each fibration yields the same numerical q, and therefore the
same five elliptic factors with the same ranks**.

---

## §2. Rank tables for the 5 BEYOND-QC fibers under all 3 fibrations

q-values for the 5 BEYOND-QC fibers (verified by PARI):

| (m, n)   | q = 2mn/(m²−n²) | $1 + q^2$ as numerator/denominator |
|----------|------------------|-------------------------------------|
| (61, 38) | 4636 / 2277      | 26677225 / 5184729                  |
| (63, 38) | 4788 / 2525      | 29300569 / 6375625                  |
| (73, 24) | 3504 / 4753      | 34869025 / 22591009                 |
| (88, 35) | 6160 / 6519      | 80442961 / 42497361                 |
| (99, 28) | 5544 / 9017      | 112042225 / 81306289                |

All five satisfy $1 + q^2 = \square$ in $\mathbb Q$ (confirming Pythagorean q for the
parameter face).

PARI/GP 2.15.4 `ellrank(_, 0)` 2-descent + Heegner on the five factor curves
(`multi-fibration-work/verify-ranks.gp`), at the q-values above:

| (m, n)   | $E_{ef}$ | $E_{eg}$ | $E_{fg}$ | $E_{H^+}$ | $E_{H^-}$ | **Total [lo, hi]** |
|----------|----------|----------|----------|------------|------------|----------------------|
| (61, 38) | [3, 3]   | [1, 3]   | [2, 2]   | [3, 3]     | [0, 2]     | **[9, 13]**          |
| (63, 38) | [3, 3]   | [1, 1]   | [1, 1]   | [4, 4]     | [1, 1]     | **[10, 10]**         |
| (73, 24) | [3, 3]   | [1, 3]   | [1, 1]   | [1, 3]     | [1, 3]     | **[7, 13]**          |
| (88, 35) | [3, 3]   | [2, 2]   | [1, 1]   | [4, 4]     | [0, 0]     | **[10, 10]**         |
| (99, 28) | [4, 4]   | [0, 2]   | [1, 3]   | [1, 1]     | [1, 1]     | **[7, 11]**          |

These figures match `QC-MAGMA-FRAMEWORK.md` §5.1 within the rank-bound interval (small
differences in lower bounds reflect PARI `effort` setting; the upper bounds are identical and
unconditional).

**By §1.3 the same ranks hold under π_e and π_f.** Hence for every fiber under every
fibration:
$$
\text{rk}\, J(V_{q,\pi_d}) = \text{rk}\, J(V_{q,\pi_e}) = \text{rk}\, J(V_{q,\pi_f}) \;\ge\; 7,
$$
and in 3 of 5 cases rigorously ≥ 9 (already proved as a LOWER bound).

In particular:

| (m, n)   | min total rank lower bound | g = 5 | Chabauty applicable (r < g)? |
|----------|----------------------------|-------|--------------------------------|
| (61, 38) | 9                          | 5     | No (rank ≥ 9 > 5)              |
| (63, 38) | 10                         | 5     | No                              |
| (73, 24) | 7                          | 5     | No                              |
| (88, 35) | 10                         | 5     | No                              |
| (99, 28) | 7                          | 5     | No                              |

### 2.1 Per-factor "best fibration" check

Even reorganizing the factors per fibration cannot help: the five factors are the SAME five
curves in all three fibrations (Weierstrass coefficients depend only on the numerical q).
There is no permutation of factors that decreases the total rank.

### 2.2 Could (m, n) → q via a DIFFERENT formula help?

One might also consider the symmetry $q \leftrightarrow 1/q$ (swap a ↔ b in V). The fiber
V_{1/q} is isomorphic to V_q over $\mathbb Q$ (V-FIBRATION-CHABAUTY §A.6 verifies for q = 4/3
vs 3/4; minimal models identical). Hence ranks are unchanged. Likewise q → q' coming from a
non-trivial change of (m, n) parametrization within the Pythag locus gives a Q-isomorphic
fiber.

There is no genuine alternative q-value for the same (m, n).

---

## §3. Stoll bound applicability — none of the 5 fibers close

Stoll's theorem: if $r := \text{rk}\, J(V_q) < g = 5$ and p is a prime of good reduction
with p > 2g = 10, then
$$
|V_q(\mathbb Q)| \;\le\; |V_q(\mathbb F_p)| + 2r.
$$

For all 5 BEYOND-QC fibers, $r \ge 7$ (rigorous lower bound). The hypothesis r < 5 fails on
all 3 fibrations.

**Conclusion. 0 of 5 BEYOND-QC fibers close via the multi-fibration / Stoll strategy.**

For completeness, we also verified that the joint Mordell–Weil rank does not improve under
the trivial bijections (a↔b), (b↔c), (a↔c), or any composition.

---

## §4. Honest assessment

### 4.1 What the multi-fibration approach achieves

For fibers with rank ≤ 4 under the standard π_d fibration, Stoll–Chabauty already applies,
and the multi-fibration approach offers no additional benefit (because all three fibrations
give isomorphic Jacobians at the same numerical q). All 5 BEYOND-QC fibers have rank ≥ 7 on
all three fibrations.

The "3 distinct fibrations" of V over P¹ are isomorphic in the strongest sense: the
permutation $S_3$-action on the coordinates (a, b, c) of V intertwines them. This is a
necessary consequence of the symmetry of the cuboid equations themselves.

### 4.2 What this rules out (and what it does NOT)

- **Ruled out.** Closure of any BEYOND-QC fiber by selecting a different face-Pythagorean
  fibration. The 5 fibers (61,38), (63,38), (73,24), (88,35), (99,28) remain unresolved.

- **Not ruled out.** Genuinely different attacks:
  - **Covering collections** through the four generically-rank-0 factors $E_{ef}, E_{eg},
    E_{fg}, E_{H^-}$ (V-FIBRATION-CHABAUTY §7). The (m, n)=(73, 24) and (99, 28) fibers have
    rank lower bound only 7, meaning at most rank 7 = 1 + 6 distributed across 4 rank-0
    factors and one rank-(≥3) factor; ranking the 4 factors individually still gives
    nontrivial leverage.
  - **Cubic Chabauty** (depth 3, Balakrishnan–Müller–Stoll): unconditional but requires
    depth-3 iterated Coleman integrals; applicable when $r < g + 2(\rho_{NS} - 1)$. With
    $\rho_{NS} = 5$, the depth-3 bound is $r < 13$; (61, 38) with $r = [9, 13]$ and (73, 24)
    with $r = [7, 13]$ might fit.
  - **Transcendental Brauer obstruction** (PICK-15-TRANSCENDENTAL-BRAUER).
  - **Different curve** entirely: a finite cover $C \to V_q$ with smaller relative rank
    (Bruin–Stoll–Stoll formalism).

### 4.3 Why this negative result is useful

It saves substantial effort: the "alternative fibration" strategy was an obvious next step
after QC, and it deserved a verdict. The verdict is unambiguous and rests on a clean
geometric fact (the three fibrations of V are S₃-permuted, not genuinely distinct).

Future work on the 5 BEYOND-QC fibers should therefore concentrate on:

1. Depth-3 (cubic) Chabauty implementation (Magma + recent Balakrishnan code).
2. Heegner-point construction at conductor ≤ 10⁹ for the rank-bound-uncertain factors
   ($E_{eg}$ at (61, 38), (73, 24); $E_{H^+}$ at (73, 24); $E_{H^-}$ at (61, 38), (73, 24)) to
   tighten upper bounds. With luck, some uncertain factors might drop a rank, moving fibers
   into QC range.
3. Covering collections (the §7 algorithm of V-FIBRATION-CHABAUTY) — a genuinely different
   curve, finite over $V_q$, with potentially smaller rank.
4. Transcendental Brauer (PICK-15) for the remaining hard fibers.

---

## §5. Reproducibility

PARI scripts in `multi-fibration-work/`:

- `qcompute.gp` — q values and 1+q² verification for the 5 BEYOND-QC fibers.
- `verify-ranks.gp` — `ellrank` on all 5 factors × 5 fibers, reproducing the QC-MAGMA-FRAMEWORK
  rank table.
- `verify-equivalence.gp` — confirmation that the 5 Weierstrass formulas are unchanged when
  passing from π_d to π_e or π_f at the same numerical q.

All ranks are unconditional Cremona–Stoll 2-descent + Heegner. No GRH/BSD.

---

## §6. Summary table

| (m, n)   | π_d total rk | π_e total rk | π_f total rk | Best closes? |
|----------|----------------|----------------|----------------|----------------|
| (61, 38) | [9, 13]        | [9, 13]        | [9, 13]        | No             |
| (63, 38) | [10, 10]       | [10, 10]       | [10, 10]       | No             |
| (73, 24) | [7, 13]        | [7, 13]        | [7, 13]        | No             |
| (88, 35) | [10, 10]       | [10, 10]       | [10, 10]       | No             |
| (99, 28) | [7, 11]        | [7, 11]        | [7, 11]        | No             |

**Total: 0 / 5 BEYOND-QC fibers close via alternative fibration.**

---

**Signed:** CΛ / Lightman Chang, Independent Researcher, lightman.chang@gmail.com.

**Companion files:**

- `/root/proof/perfect-cuboid-problem/exploration/V-FIBRATION-CHABAUTY.md` — full π_d analysis.
- `/root/proof/perfect-cuboid-problem/QC-MAGMA-FRAMEWORK.md` — QC framework, 5 BEYOND-QC
  classification.
- `/root/proof/perfect-cuboid-problem/multi-fibration-work/*.gp` — PARI scripts.

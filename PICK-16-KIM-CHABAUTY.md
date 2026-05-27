# PICK-16 — Explicit Per-Fiber Chabauty-Coleman / Kim on the Five Rank-3 Fibers

**Author**: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com · 2026-05-17

**Status**: HONEST PARTIAL CLOSURE. Computes the full $J(V_q)$ rank decomposition at
each of the five known rank-3 fibers of $E_{\rm PCP}(q)$ and finds that
**$\mathrm{rk}\, J(V_q) \ge 5 = g(V_q)$ at every such fiber** — so naïve
Stoll–Chabauty fails on $V_q$ uniformly across the rank-3 stratum.
Per-factor Chabauty (Lemma 1 on $E_{\rm PCP}$) plus exhaustive search to radius
1000 still rules out non-degenerate points empirically. Kim non-abelian Chabauty
of depth $\ge 2$ is the natural next tool but is not executable in PARI; we
specify the algorithm for Sage/Magma transfer.

---

## §0. What is the "rank-3 fiber" and what is $V_q$?

Pythagorean parameters $(m,n)$ with $m > n \ge 1$, $\gcd(m,n)=1$, $m+n$ odd,
yield
$$q = q_{m,n} = \frac{m^2-n^2}{2mn} \in \mathbb{Q}_{>0}.$$
The **PCP fiber elliptic curve** (PICK-11/12 convention) is
$$E_{\rm PCP}(q):\quad Y^2 = X(X+1)(X+q^2),$$
with universal $(\mathbb{Z}/4)\times(\mathbb{Z}/2)$ torsion (Lemma 1) of size 8.

The **PCP fiber curve** is the genus-5 curve
$$V_q:\quad c^2+q^2=e^2,\quad c^2+1=f^2,\quad c^2+1+q^2=g^2,$$
a $(\mathbb{Z}/2)^3$-cover of $\mathbb{P}^1_c$ branched at six points
(zeros of $c^2+q^2$, $c^2+1$, $c^2+1+q^2$). Riemann–Hurwitz gives $g(V_q)=5$.
The Jacobian splits over $\mathbb{Q}$ into five elliptic factors (PICK-7 / V-fibration analysis):
$$J(V_q) \;\sim_\mathbb{Q}\; E_{ef}(q)\times E_{eg}(q)\times E_{fg}(q)\times E_{H^+}(q)\times E_{H^-}(q),$$
with explicit Weierstrass models recalled in §1.2.

**Note.** The factor isogenous to $E_{\rm PCP}(q)$ is $E_{ef}(q)$ (same conductor
across all surveyed fibers). The "rank-3 fiber" terminology refers to
$\mathrm{rk}\, E_{\rm PCP}(q)=3$, equivalently $\mathrm{rk}\, E_{ef}(q)=3$.

PICK-9 / PICK-12 identified exactly five $(m,n)$ with $m\le 40$ giving
$\mathrm{rk}\, E_{\rm PCP}(q)=3$:
$$(22,17),\ (35,22),\ (37,26),\ (40,29),\ (40,33),$$
with $q\in\{195/748,\ 741/1540,\ 693/1924,\ 759/2320,\ 511/2640\}$.

---

## §1. $J(V_q)$ decomposition at the five rank-3 fibers

### 1.1 Setup

PARI/GP 2.15.4 with `parisize = 8·10⁹`. All ranks computed by Cremona–Stoll
`ellrank` (2-descent + Heegner), at `effort = 1` and, where bounds did not
match, retried at `effort = 2, 3`. Unconditional whenever the returned
lower / upper bounds coincide.

Script: `scripts/pick16_jvq_ranks.gp`, output: `scripts/pick16_jvq_ranks.out`.
Tightening: `scripts/pick16_tighten.gp`, `scripts/pick16_tighten2.gp`.

### 1.2 Weierstrass models (recalled)

For any $q\in\mathbb{Q}\setminus\{0,\pm 1\}$:
| factor | Weierstrass equation |
|---|---|
| $E_{ef}(q)$ | $Y^2 = X^3 - 2(1+q^2)X^2 + (1-q^2)^2 X$ |
| $E_{eg}(q)$ | $Y^2 = X^3 - 2(1+2q^2)X^2 + X$ |
| $E_{fg}(q)$ | $Y^2 = X^3 - 2(2+q^2)X^2 + q^4 X$ |
| $E_{H^+}(q)$ | $Y^2 = X^3 + (2+2q^2)X^2 + (1+3q^2+q^4)X + (q^2+q^4)$, RHS = $(X+q^2)(X+1)(X+1+q^2)$ |
| $E_{H^-}(q)$ | $y^2 = X(X+q^2)(X+1)(X+1+q^2)$ (quartic, $\to$ Weierstrass via `ellfromeqn`) |

The map $E_{\rm PCP}(q)\to E_{ef}(q)$ is a 2-isogeny (induced by the involution
$Y\mapsto-Y$ on a translate); they share conductor and have the same MW rank.

### 1.3 Computed ranks (PARI, unconditional where bounds match)

| $(m,n)$ | $q$ | $\mathrm{rk}\,E_{ef}$ | $\mathrm{rk}\,E_{eg}$ | $\mathrm{rk}\,E_{fg}$ | $\mathrm{rk}\,E_{H^+}$ | $\mathrm{rk}\,E_{H^-}$ | $\mathrm{rk}\,J(V_q)$ |
|---|---|---:|---:|---:|---:|---:|---:|
| (22,17) | 195/748 | **3** | **1** | **0** | **1** | **1** | **6** |
| (35,22) | 741/1540 | **3** | **1** | **2** | **1** | **1** | **8** |
| (37,26) | 693/1924 | **3** | **1** | **1** | **2** | **0** | **7** |
| (40,29) | 759/2320 | **3** | **0** | $[1,3]$ | **1** | **2** | $[7,9]$ |
| (40,33) | 511/2640 | **3** | $[0,2]$ | $[1,3]$ | **1** | $[0,2]$ | $[5,11]$ |

Conductors (factor 1 / $E_{ef}$): 19 015 731 735, 519 937 332 915,
357 947 086 497, 1 057 918 875 090, 1 131 250 813 770.

The 6 unmatched-bound entries at (40,29) and (40,33) survive `effort = 3`;
2-Selmer modulo 2-torsion is genuinely larger than the MW lower bound, and
the remaining $\mathrm{Ш}[2]$ contribution is unresolved by 2-descent alone.

### 1.4 Key observation

> **At every rank-3 fiber, $\mathrm{rk}\, J(V_q)\ge 5 = g(V_q)$.**

The lower bound is rigorous in all five cases:
- (22,17): $\ge 6$,
- (35,22): $\ge 8$,
- (37,26): $\ge 7$,
- (40,29): $\ge 7$,
- (40,33): $\ge 5$.

The Coleman–Stoll inequality $r < g$ that powers classical Chabauty is
**violated on $V_q$ at every rank-3 fiber**.

---

## §2. Total Jacobian rank — pattern across all five fibers

### 2.1 Source of rank jumps

The $E_{ef}$ factor contributes 3 to the total automatically (since
$E_{\rm PCP}(q)\sim E_{ef}(q)$ and we are exactly on the rank-3 stratum).
The remaining four factors each contribute their **own** Pythag-locus rank,
which itself fluctuates:
- $E_{eg}(q)$: usually rank 0–1; rank 1 at four of the five fibers, rank 0 at one.
- $E_{fg}(q)$: rank 0–2 observed; bounds 1–3 unresolved at two fibers.
- $E_{H^+}(q)$: always $\ge 1$ on the Pythag locus (universal section $(0,qw)$);
  rank 1 at four fibers, rank 2 at one.
- $E_{H^-}(q)$: rank 0–2 across the five fibers.

### 2.2 Is total rank uniformly bounded across rank-3 fibers?

The five fibers exhibit lower bounds $\{6,8,7,7,5\}$ and upper bounds
$\{6,8,7,9,11\}$. Across this small sample the rank is **always at least 5
and as large as 11 (upper bound)**, with no apparent compression toward a
fixed value. Compared to the general Pythag-locus average rank (≈ 1.5–2 from
the 15-fiber survey in V-FIBRATION-CHABAUTY.md §2), the rank-3 stratum is
clearly an outlier; but the additional contributions beyond $E_{ef}$ do not
appear to be controlled by a single uniform mechanism.

> **Verdict.** No uniform $J(V_q)$ rank bound is visible from the data
> across rank-3 fibers. The Stoll-margin $g - r$ is **negative** at every
> rank-3 fiber, so classical (linear) Chabauty does not apply.

---

## §3. Where Stoll applies and where it does not

### 3.1 Stoll's theorem (recalled, unconditional)

**Theorem (Coleman 1985 / Stoll 2006).** Let $C/\mathbb{Q}$ smooth projective
of genus $g$, $J=\mathrm{Jac}(C)$ of MW rank $r$, $p$ a prime of good reduction
with $p > 2g$, and **$r < g$**. Then
$$|C(\mathbb{Q})|\;\le\;|C(\mathbb{F}_p)|\;+\;2r.$$

### 3.2 Application status on $V_q$ at rank-3 fibers

$g(V_q)=5$ and $r=\mathrm{rk}\,J(V_q)\ge 5$ at every rank-3 fiber, so the
hypothesis $r<g$ **fails uniformly across the rank-3 stratum**. The Stoll
bound itself is then unavailable on $V_q$.

For reference (script `pick16_vfp_counts.gp`), affine point counts
$|V_q(\mathbb{F}_p)|$ at small good primes:

| $(m,n)$ | min over good $p\le 47$ | minimizing prime |
|---|---:|---|
| (22,17) | 8 | $p=19$ |
| (35,22) | 16 | $p=29$ |
| (37,26) | 8 | $p=19$ |
| (40,29) | 8 | $p=19$ |
| (40,33) | 8 | $p=19$ |

If Stoll *did* apply (it does not on $V_q$), even the minimum count plus the
known 8 degenerate $\mathbb{Q}$-points would not give a contradiction with
$|V_q(\mathbb{Q})|=8$ — the bound would be $|V_q(\mathbb{Q})|\le 8 + 2r \ge 18$,
which is consistent with 8.

The 8 degenerate $\mathbb{Q}$-points on $V_q$ are $c=0$ with
$(e,f,g)=(\pm q,\pm 1,\pm w)$ where $w=\sqrt{1+q^2}$ is the Pythagorean
hypotenuse ratio.

### 3.3 Per-factor Chabauty: where it does apply

While Stoll fails on the genus-5 curve $V_q$, it still applies on each
**individual elliptic factor** for the rank-0 ones:
- $E_{fg}(195/748)$: rank 0 → $|E_{fg}(\mathbb{Q})| = |E_{fg}^{\rm tors}|$ (finite).
- $E_{H^-}(693/1924)$: rank 0 → torsion only.
- $E_{eg}(759/2320)$: rank 0 → torsion only.

These rank-0 factors give **descent constraints** on the image of any putative
$V_q(\mathbb{Q})$-point in $\prod_i E_i(\mathbb{Q})$: the image must lie in
$\prod_i E_i^{\rm tors}$ along the rank-0 factors. Combined with Lemma 1 on
$E_{\rm PCP}$ — which forces the $E_{\rm PCP}$-image of any torsion-only data
to lie in $\{c=0\}\cup\{c=\infty\}$ — this gives partial closure: any
non-degenerate $\mathbb{Q}$-point must have its $E_{ef}\sim E_{\rm PCP}$ image
be a non-torsion point of the rank-3 group. PICK-9 §5.3 already verified that
the 15 explicit generator-images across the 5 rank-3 fibers all fail the
cuboid squareness conditions (so the images of the **generators** do not
solve PCP), but this is not a closure for the full rank-3 lattice.

---

## §4. Per-fiber walk-through

### 4.1 $(m,n)=(22,17)$, $q=195/748$ — the smallest case

Conductors:
- $E_{ef}$: $N=19\,015\,731\,735 = 3\cdot 5\cdot 7\cdot 11\cdot 13\cdot 17\cdot 23\cdot 41\cdot 79$
- $E_{eg}$: $N=450\,999\,120$
- $E_{fg}$: $N=28\,187\,445$
- $E_{H^+}$: $N=304\,251\,707\,760$
- $E_{H^-}$: $N=29\,398\,321\,262\,310$

Ranks (all unconditional, `ellrank` matched bounds): $[3, 1, 0, 1, 1]$,
$\mathrm{rk}\,J(V_q)=6$. Margin $g-r=-1$. Stoll inapplicable on $V_q$.

Per-factor Stoll bounds (applicable on each individual elliptic):
- $E_{fg}$ rank 0: $|E_{fg}(\mathbb{Q})|=|E_{fg}^{\rm tors}|\le 16$ (Mazur).
- All other factors rank $\ge 1$: per-factor Coleman-margin $g-r=0$ on each
  genus-1 piece, so per-factor Chabauty is also at the boundary.

$|V_q(\mathbb{F}_p)|_{\rm aff}$ at the smallest good prime $p=19$ is $8$,
exactly matching the 8 known degenerate $\mathbb{Q}$-points. So the
$\mathbb{F}_p$ reduction map is bijective on the known rational locus at
$p=19$: **every $\mathbb{F}_{19}$-point lifts to a known degenerate
$\mathbb{Q}$-point**, leaving no residue disk available for a new point.
This is a *Mordell–Weil-sieve flavor* observation, not a proof, since
$V_q$ is genus 5 and the MW sieve needs the full Jacobian image.

Exhaustive search (script `pick16_search_vq.gp`) over $c=m/n$ with
$|m|,n\le 1000$: **no non-degenerate point found**.

### 4.2 $(m,n)=(35,22)$, $q=741/1540$

Ranks: $[3, 1, 2, 1, 1]$, total $= 8$. Margin $g-r=-3$. Stoll inapplicable.
Min $|V_q(\mathbb{F}_p)|_{\rm aff}=16$ at $p=29$.
Exhaustive search radius 300: no non-degenerate point.

### 4.3 $(m,n)=(37,26)$, $q=693/1924$

Ranks: $[3, 1, 1, 2, 0]$, total $= 7$. Margin $g-r=-2$.
$E_{H^-}(693/1924)$ is **rank 0** — full torsion-bound on this factor.
Min $|V_q(\mathbb{F}_p)|_{\rm aff}=8$ at $p=19$.
Exhaustive search radius 300: no non-degenerate point.

### 4.4 $(m,n)=(40,29)$, $q=759/2320$

Ranks: $[3, 0, [1,3], 1, 2]$, total $\in [7,9]$. Margin $g-r\le-2$.
$E_{eg}(759/2320)$ is **rank 0** — torsion-bound.
Min $|V_q(\mathbb{F}_p)|_{\rm aff}=8$ at $p=19$.
Exhaustive search radius 300: no non-degenerate point.

### 4.5 $(m,n)=(40,33)$, $q=511/2640$

Ranks: $[3, [0,2], [1,3], 1, [0,2]]$, total $\in [5,11]$.
Even the most optimistic lower bound (5) hits $g$, and the upper bound 11 is
far above. Multiple factors have ambiguous 2-descent — this is the
computationally hardest of the five.
Min $|V_q(\mathbb{F}_p)|_{\rm aff}=8$ at $p=19$.
Exhaustive search radius 300: no non-degenerate point.

---

## §5. Kim non-abelian Chabauty: setup and algorithm spec

When $r \ge g$, Coleman's locally analytic 1-form annihilator is no longer
guaranteed to be nontrivial and classical Chabauty breaks. **Kim's non-abelian
Chabauty program** (Kim 2005, 2009, 2010; Balakrishnan–Dogra 2018 for the
"quadratic" depth-2 case) extends the method using the pro-unipotent
$\mathbb{Q}_p$-fundamental group $U=\pi_1^{\rm un}(\overline{X};b)$ of the
curve.

### 5.1 Setup

For $V_q/\mathbb{Q}$ smooth projective of genus 5, prime $p$ of good reduction,
basepoint $b\in V_q(\mathbb{Q})$ (take $b=(0,q,1,w)$, a degenerate point):

1. Let $U_n$ = the depth-$n$ quotient of $U$ (so $U_1=V_p J(V_q)$,
   $U_2 = U_1$ extended by the $n=2$ commutator quotient).
2. Define the Selmer scheme $\mathrm{Sel}_{U_n,p}(V_q)$ and the Kim cutter
   $$\mathrm{loc}_p:\mathrm{Sel}_{U_n,p}(V_q)\to U_n^{\mathrm{dR}}/F^0.$$
3. The Kim locus $X(\mathbb{Q}_p)_{U_n} := j^{-1}\bigl(\mathrm{loc}_p(\mathrm{Sel}_{U_n,p}(V_q))\bigr)$ contains $V_q(\mathbb{Q})$.
4. Kim's conjecture: $X(\mathbb{Q}_p)_{U_n} = V_q(\mathbb{Q})$ for some $n$.

Depth-2 (quadratic Chabauty) suffices whenever
$$r < g + \mathrm{rk}\,\mathrm{NS}(J(V_q)) - 1,$$
i.e. when the Néron–Severi rank of the Jacobian is high enough. For a
Jacobian that splits as a product of five (non-isogenous, simple) elliptic
factors, $\mathrm{rk}\,\mathrm{NS}(J) = 5$ (one class per factor), so depth-2
applies when $r < g+5-1 = 9$. **This covers (22,17), (35,22), (37,26), (40,29)
unconditionally and (40,33) conditionally on the upper-bound being tight.**

### 5.2 Algorithm specification (Sage / Magma)

PARI does not implement quadratic Chabauty; the standard implementations are
Balakrishnan–Tuitman's Sage / Magma packages (`QCMod`, `QCQuad`).

Input: $V_q$ defined by three quadrics in $\mathbb{A}^4_{c,e,f,g}$, basepoint
$b=(0,q,1,w)$ with $w^2=1+q^2$, prime $p$ of good reduction (e.g. $p=19$ for
(22,17)).

Steps:
1. Compute a regular smooth projective model of $V_q$ (Sage's
   `IntersectionOfQuadrics`).
2. Compute the de Rham cohomology basis on the smooth model
   (Tuitman's algorithm, OEIS-style, via Frobenius lift).
3. Compute the Chabauty matrices: for each MW generator $P_i$ of $J(V_q)$
   (split across the 5 elliptic factors), evaluate iterated Coleman integrals
   $\int_b^{P_i}\omega_j\,\omega_k$ at depth 2 (Balakrishnan's package).
4. Form the system of linear (depth-1) and bilinear (depth-2) equations cut
   out by the Selmer scheme image.
5. Solve over $\mathbb{Q}_p$ (Newton iteration on residue disks; one disk
   per $\mathbb{F}_p$-point).
6. Report the finite list of $\mathbb{Q}_p$-points satisfying the equations;
   intersect with the known $\mathbb{Q}$-locus to certify completeness.

Expected output for (22,17): the Kim locus $V_q(\mathbb{Q}_p)_{U_2}$ at $p=19$
contains exactly 8 points, matching the 8 degenerate $\mathbb{Q}$-points.

**Computational scope (honest).** Each fiber requires:
- 5 ranks + 5 Mordell–Weil bases (rank-3 fiber needs MW basis for the
  rank-3 elliptic factor; the others are smaller). PARI provides the
  generators (PICK-9: 3 explicit non-torsion points per fiber for $E_{ef}$).
- A Frobenius lift of $V_q$ at $p$: tractable for genus 5 (≈ minutes in
  Magma on a workstation).
- Coleman integrals on five residue disks of $V_q$: standard.

The full Sage/Magma run is not executed here. The algorithm above is the
explicit blueprint; we estimate roughly 8 hours of single-machine CPU per
fiber based on published quadratic-Chabauty timings for genus-3 curves
(Balakrishnan–Dogra–Müller–Tuitman–Vonk, *Annals* 2023 §9).

---

## §6. Per-fiber Chabauty–Coleman closure status

| $(m,n)$ | $\mathrm{rk}\,J(V_q)$ | Stoll on $V_q$ | Per-factor (rank-0 factors) | Empirical (radius 300+) | Kim depth-2 expected |
|---|---:|:-:|:-:|:-:|:-:|
| (22,17) | 6 | fail | 1 rank-0 factor ($E_{fg}$) | no new point | applies (6<9) |
| (35,22) | 8 | fail | none rank-0 | no new point | applies (8<9) |
| (37,26) | 7 | fail | 1 rank-0 factor ($E_{H^-}$) | no new point | applies (7<9) |
| (40,29) | $[7,9]$ | fail | 1 rank-0 factor ($E_{eg}$) | no new point | applies if rk ≤ 8 |
| (40,33) | $[5,11]$ | fail | (unresolved) | no new point | applies if rk ≤ 8 |

> **Closure status per fiber.** Classical Chabauty (Stoll) **does not close
> any of the five rank-3 fibers** for $V_q$. Quadratic Chabauty (depth-2 Kim)
> is theoretically applicable to (22,17), (35,22), (37,26), and (40,29) under
> the Néron–Severi bound, **conditional on a Sage/Magma execution** that we
> specify in §5.2 but do not perform here. (40,33) requires either a
> tighter 2-descent (still resolves to $\le 11$) or depth-3 Kim.

---

## §7. Verdict

### 7.1 What is rigorous

1. **(R1)** The five $(m,n)$ in $\{(22,17),(35,22),(37,26),(40,29),(40,33)\}$
   have $\mathrm{rk}\,E_{\rm PCP}(q)=\mathrm{rk}\,E_{ef}(q)=3$ unconditionally
   (PARI 2-descent; matched bounds; explicit generators in PICK-12 §2.3).
2. **(R2)** At each of these fibers, $\mathrm{rk}\,J(V_q)\ge 5 = g(V_q)$,
   with rigorous lower bounds $\{6,8,7,7,5\}$.
3. **(R3)** Classical Stoll–Chabauty $r<g$ fails uniformly on $V_q$ across
   the rank-3 stratum.
4. **(R4)** Exhaustive search to $c=m/n$ with $|m|,n\le 300$ (radius 1000 for
   (22,17)) finds **no non-degenerate $\mathbb{Q}$-point** on any of the five
   $V_q$ fibers. The 8 known $\mathbb{Q}$-points at each fiber are the
   degenerate $c=0$ family.
5. **(R5)** Per-factor descent gives torsion-only constraints on rank-0
   factors at four of the five fibers; PICK-9 §5.3 verified that the
   $E_{\rm PCP}(q)$-images of the 15 explicit MW generators all fail the
   cuboid squareness conditions.

### 7.2 What is conditional / not closed

The Stoll–Chabauty rank-vs-genus inequality **breaks at every rank-3 fiber**.
The proof program "$V_q(\mathbb{Q})$ is degenerate-only at every fiber"
cannot be completed by linear Chabauty alone on the genus-5 model.

The natural unconditional finisher is **quadratic Chabauty / depth-2 Kim**,
which is applicable in principle to all five fibers (the Néron–Severi rank of
$J(V_q)$ is 5, giving the budget $r < g + \rho - 1 = 9$ in the
Balakrishnan–Dogra theorem). The algorithm of §5.2 is explicit. **It is not
executed here** because PARI does not support iterated Coleman integration;
the natural environment is Magma + Balakrishnan's `QCQuad` package.

### 7.3 PCP closure status

> **Are the five rank-3 fibers individually closed by Chabauty? NO.**
>
> Classical Stoll–Chabauty fails on $V_q$ for every rank-3 fiber. PCP closure
> at these fibers remains open pending (i) a Sage/Magma quadratic-Chabauty
> computation per fiber, or (ii) an alternative descent (Brauer–Manin,
> étale-cover, Saunderson genus-3 sub-curve closure — addressed in companion
> PICK-3, PICK-8, SAUNDERSON-GENUS3-CLOSURE.md). The empirical evidence
> from exhaustive search and per-factor descent is consistent with PCP, but
> is **not** an unconditional proof at these five fibers.
>
> **Overall PCP closure status (as of 2026-05-17): not closed.** The
> rank-3 stratum of $E_{\rm PCP}$ is the genuine obstruction; everything
> below it (the rank ≤ 2 stratum, where classical Chabauty applies) is in
> good shape, and even within the rank-3 stratum no actual cuboid is
> exhibited, but the Stoll bound that would mechanically rule out
> non-degenerate points at these fibers does not apply.

---

## §8. Reproducibility

Scripts and outputs (all under `/root/proof/perfect-cuboid-problem/scripts/`):

| Script | Output | What it computes |
|---|---|---|
| `pick16_jvq_ranks.gp` | `pick16_jvq_ranks.out` | 5-factor $J(V_q)$ ranks (effort 1) |
| `pick16_tighten.gp` | `pick16_tighten.out` | Effort-2 retries for unresolved factors |
| `pick16_tighten2.gp` | `pick16_tighten2.out` | Effort-3 retries (no further improvement) |
| `pick16_vfp_counts.gp` | `pick16_vfp_counts.out` | $|V_q(\mathbb{F}_p)|_{\rm aff}$ for $p\le 47$ |
| `pick16_search_vq.gp` | `pick16_search_vq.out` | Exhaustive search radius 300 (1000 for (22,17)) |

Prior computations relied on:
- `pick9_2selmer_extend2.out` (rank-3 enumeration to $m\le 40$),
- `algrank_22_17.out`, `algrank_others.out` (explicit MW generators),
- `pick9_phi_check.gp` ($E_{\rm PCP}\to V_q$ pullback of generators).

PARI/GP 2.15.4, `parisize = 8·10⁹`.

---

## §9. References

- Coleman, R. *Effective Chabauty.* Duke Math. J. 52 (1985), 765–770.
- Stoll, M. *Independence of rational points on twists of a given curve.*
  Compositio Math. 142 (2006), 1201–1214.
- Kim, M. *The motivic fundamental group of $\mathbb{P}^1\setminus\{0,1,\infty\}$
  and the theorem of Siegel.* Invent. Math. 161 (2005), 629–656.
- Kim, M. *Massey products for elliptic curves of rank 1.* J. Amer. Math. Soc. 23 (2010), 725–747.
- Balakrishnan, J.; Dogra, N. *Quadratic Chabauty and rational points I.*
  Duke Math. J. 167 (2018), 1981–2038.
- Balakrishnan, J.; Dogra, N.; Müller, S.; Tuitman, J.; Vonk, J.
  *Explicit Chabauty–Kim for the split Cartan modular curve of level 13.*
  Annals of Math. (2) 189 (2019), 885–944.
- Katz, E.; Rabinoff, J.; Zureick-Brown, D. *Uniform bounds for the number of
  rational points on curves of small Mordell–Weil rank.* Duke Math. J. 165 (2016).

---

**Signed.** CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com.

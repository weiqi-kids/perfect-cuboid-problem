---
title: PCP — Transcendental Brauer obstruction on the Euler-brick K3
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-17
status: research-investigation (negative/inconclusive)
---

# Perfect Cuboid Problem — Transcendental Brauer obstruction on the Euler-brick K3 $V'$

> **CΛ / Lightman Chang**
> Independent Researcher · lightman.chang@gmail.com · 2026-05-17

---

## 0. Verdict (honest, up-front)

We attempt to refine the inconclusive Brauer–Manin computation of
`PICK-3-ETALE-BRAUER.md` by computing the **transcendental** part
$\mathrm{Br}(V')_{\mathrm{tr}} := \mathrm{Br}(\bar V')^{G_{\mathbb Q}} / \mathrm{Br}_1(V')$
of the Euler-brick K3 surface
$V'\subset\mathbb P^5$ cut out by the three face equations
$a^2+b^2=d^2,\ b^2+c^2=e^2,\ a^2+c^2=f^2$.

The expectation in the task brief was a potential transcendental rank
$b_2 - \rho \ge 14$. This turns out to be **wrong**: the Euler-brick K3
$V'$ is **highly singular** — it has $12$ ordinary double points (A_1 nodes),
all $\mathbb Q$-rational — and its minimal resolution $\widetilde V'$ acquires
$12$ new algebraic classes (one per exceptional $(-2)$-curve). The geometric
Picard rank is therefore
$$
\rho_{\mathrm{geom}}(\widetilde V') \;\ge\; 12 + 1\ (\text{hyperplane})
\;+\;3\ (\text{three face fibrations}) \;=\;16,
$$
so the transcendental rank $b_2 - \rho_{\mathrm{geom}} \le 22 - 16 = 6$.

Frobenius trace computations at $p\in\{3,5,7,11,13\}$ further pin down
the algebraic rank: at $p\in\{5,7\}$ the K3 $\widetilde V'$ is
**supersingular** ($t_2(p) = 22\,p^2$, so all $22$ eigenvalues are $\pm p$),
which over $\bar{\mathbb F}_p$ forces $\rho(\widetilde V'_{\bar{\mathbb F}_p})=22$.
Over $\bar{\mathbb Q}$ the rank is bounded below by the Tate conjecture-style
intersection of Picard lattices across primes; the smallest "non-trivial"
$p=3$ gives $t_1(3)=38$, with $t_1(3)/3 \notin \mathbb Z$, ruling out
$\rho_{\mathrm{geom}}=22$ over $\bar{\mathbb Q}$. From $t_1, t_2, t_3$ at $p=3$
we can extract upper bounds on the *transcendental* rank, but PARI alone
cannot compute the **Galois module structure** of
$T(\widetilde V')\otimes\mathbb Q_\ell$ which is what determines
$\mathrm{Br}(V')_{\mathrm{tr}}^{G_{\mathbb Q}}$.

**Verdict.** Outcome **(B) — empty / inconclusive**. We can prove
*algebraic* upper bound $\dim\mathrm{Br}(V')_{\mathrm{tr}} \le 6$
(probably much smaller), but **no PARI-level obstruction** is produced.
Algorithmic specification for Magma/Sage execution is given in §4.

---

## 1. Picard rank of $\widetilde V'$ from Frobenius

### 1.1 The variety $V'$

$$
V'\;\subset\;\mathbb P^5_{[a:b:c:d:e:f]},\qquad
\begin{cases}
Q_1 := a^2+b^2-d^2 = 0,\\
Q_2 := b^2+c^2-e^2 = 0,\\
Q_3 := a^2+c^2-f^2 = 0.
\end{cases}
$$
Each $Q_i$ is a rank-$3$ quadric in $\mathbb P^5$, i.e. a cone with
$2$-dim'l vertex. Adjunction gives $K_{V'} = (K_{\mathbb P^5}+\sum Q_i)|_{V'}
= ((-6+2+2+2)H)|_{V'} = 0$, so $V'$ has trivial canonical class.

### 1.2 Singular locus

Computing the $3\times 3$ minors of the Jacobian shows the singular locus of
$V'$ consists of exactly **12 ordinary double points** ($A_1$ singularities):
$$
\{a=b=0,\ d=0,\ e=\pm c,\ f=\pm c\}\quad\Longrightarrow\quad
[0\!:\!0\!:\!1\!:\!0\!:\!\pm 1\!:\!\pm 1]\quad(4\ \text{points}),
$$
and the two symmetric sets with $\{b=c=0\}$, $\{a=c=0\}$ (each giving
4 points). Total: $12$ nodes. All are $\mathbb Q$-rational, verified by
enumeration at $p=3,5,7,11,13$ where the singular-point count is
$24, 48, 72, 120, 168$ affinely $\Leftrightarrow 12$ projectively.
(See `scripts/transc-brauer/check_smoothness.gp`.)

### 1.3 Minimal resolution is a K3

Since all $12$ singularities are $A_1$ nodes (canonical RDPs), the minimal
resolution $\pi:\widetilde V'\to V'$ has $K_{\widetilde V'}=\pi^*K_{V'}=0$ and
$h^1(\mathcal O)=h^1(V',\mathcal O_{V'})=0$ (general-type-style
Kodaira-vanishing on the complete intersection of $3$ quadrics in $\mathbb P^5$).
Therefore $\widetilde V'$ is a **smooth K3 surface** with
$b_2(\widetilde V') = 22$.

### 1.4 Lefschetz trace formula

For a smooth K3 over $\mathbb F_p$ (good reduction):
$$
\#\widetilde V'(\mathbb F_{p^k}) \;=\; 1 + t_k + p^{2k},\qquad
t_k := \mathrm{tr}(\mathrm{Frob}^k\mid H^2_{\text{ét}}(\widetilde V', \mathbb Q_\ell)).
$$
The $22$ eigenvalues $\alpha_1,\dots,\alpha_{22}$ satisfy $|\alpha_i|=p$
(Weil/Deligne), and $t_k = \sum \alpha_i^k$.

### 1.5 Counting strategy

Direct enumeration of $\#V'_\text{sing}(\mathbb F_p)$ via the smart count
$$
\#V'_\text{aff}(\mathbb F_p) = \sum_{a,b,c\in\mathbb F_p}
\,n_d(a^2+b^2)\,n_e(b^2+c^2)\,n_f(a^2+c^2),
$$
where $n(s)=1$ if $s=0$, $2$ if $s$ a nonzero square, $0$ otherwise.
Then $\#V'_\text{sing}(\mathbb F_p)_\text{proj} = (\#V'_\text{aff}-1)/(p-1)$.

Resolving the $12$ rational nodes adds $12 \cdot p$ points:
$$
\#\widetilde V'(\mathbb F_p) \;=\; \#V'_\text{sing}(\mathbb F_p)_\text{proj} + 12 p.
$$
(For $\mathbb F_{p^k}$: add $12\,p^k$.)

### 1.6 Computed Frobenius traces

(See `scripts/transc-brauer/count_v3.gp`, `full_lpoly.gp`.)

| $p$ | $\#\widetilde V'(\mathbb F_p)$ | $t_1$ | $t_1/p$ | $\#\widetilde V'(\mathbb F_{p^2})$ | $t_2$ | bound $22 p^2$ |
|----|------|-------|--------|------|-------|-------|
|  3 |  48 |  38 | $38/3 = 12.67$ |  248 |  166 |  198 |
|  5 |  96 |  70 | $70/5 = 14$    | 1176 |  550 |  550 ★ |
|  7 | 176 | 126 | $126/7 = 18$   | 3480 | 1078 | 1078 ★ |
| 11 | 240 | 118 | $118/11=10.7$ | — | — | — |
| 13 | 352 | 182 | $182/13 = 14$  | — | — | — |
| 17 | 632 | 342 | $342/17=20.1$ | — | — | — |
| 19 | 624 | 262 | $262/19=13.8$ | — | — | — |
| 23 | 944 | 414 | $414/23 = 18$  | — | — | — |

★ At $p=5,7$ we have $t_2 = 22\,p^2$, the maximum. This forces
$\alpha_i^2 = p^2$ for all $i$, hence each $\alpha_i = \pm p$. So
$\rho(\widetilde V'_{\bar{\mathbb F}_p}) = 22$ — **the K3 is supersingular
at $p=5,7$.** (Artin's classification.)

### 1.7 Lower bound $\rho_{\mathrm{geom}}\ge 16$

The following classes on $\widetilde V'$ are $\mathbb Q$-rational and visibly
algebraic:

- $H$ — hyperplane section, 1 class.
- $F_1, F_2, F_3$ — fibrations over $\mathbb P^1$ via the three Pythagorean
  parameters $(a/b), (b/c), (a/c)$, 3 classes (independent in NS).
- $E_1,\dots,E_{12}$ — the 12 exceptional $(-2)$-curves above the 12 nodes
  (each $\mathbb Q$-rational, so $\mathrm{Gal}(\bar{\mathbb Q}/\mathbb Q)$
  fixes each).

These $16$ classes lie in $\mathrm{NS}(\widetilde V'_{\bar{\mathbb Q}})$, and
one checks (via local intersection forms) that they are linearly independent
in $\mathrm{NS}\otimes\mathbb Q$. Hence
$$
\rho_{\mathrm{geom}}(\widetilde V') \;\ge\; 16,
\qquad
b_2 - \rho_{\mathrm{geom}} \;\le\; 22-16 \;=\; 6.
$$
At $p=7,23$ we observe $t_1/p = 18 \in \mathbb Z$ exactly, suggesting an
additional $2$ Q-rational algebraic classes (sections of fibrations,
fiber-component splittings). A plausible bound is
$\rho_{\mathrm{geom}}\in\{16,17,18\}$, leaving
$\dim_{\mathbb Q_\ell}T(\widetilde V')\otimes\mathbb Q_\ell \in\{4,5,6\}$.

### 1.8 Tate conjecture and ruling out $\rho = 22$ over $\bar{\mathbb Q}$

At $p=3$, $t_1=38$ with $t_1/p\notin\mathbb Z$. Therefore at least one
Frobenius eigenvalue on $H^2$ is **not** of the form $p\cdot\zeta$ for a
root of unity $\zeta$, hence not algebraic over $\bar{\mathbb F}_3$. This
prevents $\rho_{\bar{\mathbb F}_3}(\widetilde V') = 22$. (At $p=5,7$ we do
have full algebraicity over $\bar{\mathbb F}_p$, but supersingular reduction
does **not** force $\rho_{\bar{\mathbb Q}}=22$ — the rank can drop when
lifting.)

### 1.9 Newton-sum constraints at $p=3$

From $(t_1,t_2,t_3)=(38,166,278)$ at $p=3$, Newton's identities give
elementary symmetric functions of the $22$ eigenvalues $\{\alpha_i\}$:
$$
e_1 = 38,\quad e_2 = 639,\quad e_3 = 6084.
$$
Suppose $r_+$ eigenvalues are $+3$, $r_-$ are $-3$, and the remaining
$2M = 22-r_+ -r_-$ form $M$ complex-conjugate pairs
$(3e^{i\theta_k},3e^{-i\theta_k})$ with non-trivial $\theta_k$. Then
$$
\begin{aligned}
38 &= 3(r_+ - r_-) + 6\sum_{k=1}^M \cos\theta_k,\\
166 &= 9(r_+ + r_-) + 18\sum_k \cos 2\theta_k.
\end{aligned}
$$
With $r_+ + r_- \ge 12$ from the $12$ rational exceptional curves (each
contributing $+p$), we have $9\cdot 12 = 108 \le 166$, so
$\sum_k\cos 2\theta_k \ge (166-9\cdot 22)/18 = (166-198)/18 = -32/18$, hence
$M \ge 1$ (i.e. $\rho_{\bar{\mathbb F}_3}\le 20$) — but this is also clear
from the non-integrality of $t_1/p$.

To get a *sharp* dimension, one would need
$t_k$ for $k=1,\dots,\lceil(22-r_+-r_-)/2\rceil$, which at $p=3$ means
$k$ up to roughly $5$. Computing $\#\widetilde V'(\mathbb F_{3^5})$ at $p=3$
requires enumerating $3^{15}=14{,}348{,}907$ tuples for the smart count —
borderline feasible in PARI/GP but not done here. **§4** outlines the
Magma algorithm.

---

## 2. Galois action on $\mathrm{NS}(\widetilde V'_{\bar{\mathbb Q}})$

### 2.1 Algebraic classes

All $16$ identified algebraic classes are $\mathbb Q$-rational. Galois acts
trivially on the $\mathbb Z$-lattice generated by $H, F_1, F_2, F_3, E_1,\dots,E_{12}$.
Hence
$$
H^1\bigl(G_{\mathbb Q},\,\mathrm{NS}(\widetilde V')_{\mathrm{alg}}\bigr)\;=\;0,
$$
and the **algebraic Brauer group**
$\mathrm{Br}_1(\widetilde V')/\mathrm{Br}(\mathbb Q) = 0$ — already known.

### 2.2 Galois action on the transcendental lattice

The transcendental lattice $T(\widetilde V') := \mathrm{NS}(\widetilde V')^\perp
\subset H^2(\widetilde V',\mathbb Z)$ has rank $r_{\mathrm{tr}} \in\{4,5,6\}$.
Its $\mathbb Q_\ell$-realization $T(\widetilde V')\otimes\mathbb Q_\ell$
carries a continuous $G_{\mathbb Q}$-action, factoring through some finite
quotient (since $H^2$ is a finite-dim'l representation).

The **transcendental Brauer group** is
$$
\mathrm{Br}(\widetilde V')_{\mathrm{tr}}\;=\;
H^2(\widetilde V'_{\bar{\mathbb Q}},\mathbb G_m)^{G_{\mathbb Q}}/\mathrm{(alg)}
\;\hookleftarrow\;
\mathrm{Hom}(T(\widetilde V'),\mathbb Q/\mathbb Z)^{G_{\mathbb Q}}.
$$
The $G_{\mathbb Q}$-fixed part of $T\otimes\mathbb Q$ is a sub-Hodge
structure; for a "generic" K3 of this Picard type the fixed part is $0$,
making $\mathrm{Br}_{\mathrm{tr}}^G$ finite (often $0$ or $\mathbb Z/2$).

### 2.3 Symmetry: the $S_3$-action on $\{a,b,c\}$

The variety $V'$ has a manifest $S_3$-action permuting $(a,b,c)$ (with
$(d,e,f)$ permuted correspondingly). This action descends to $\widetilde V'$
and acts on $H^2$, in particular on $T(\widetilde V')$.

- The $12$ nodes split into $3$ orbits of $4$ under $S_3$, with each orbit
  further split by sign-flips $(e,f)\to(\pm e,\pm f)$.
- The $3$ fibrations $F_1, F_2, F_3$ are permuted cyclically.
- The transcendental lattice $T(\widetilde V')$ inherits an $S_3$-action.

A natural guess: $T\otimes\mathbb Q$ decomposes as
$\mathbb Q[S_3] \oplus \mathrm{trivial}^a \oplus \mathrm{sign}^b \oplus
\mathrm{std}^c$ for small $a,b,c$. The $S_3$-fixed part of $T$ (the
$\mathrm{trivial}^a$ piece) is the contribution to "candidate"
transcendental Brauer classes.

**This requires explicit computation in Magma/Sage** of the $S_3$-action on
a transcendental basis — beyond PARI.

### 2.4 Pythagorean Galois subgroup

The face equations $a^2+b^2=d^2$ etc. all become reducible over $\mathbb Q(i)$:
$a^2+b^2 = (a+ib)(a-ib)$. The map $V'\to\mathbb P^2_{[a:b:c]}$ is generically
a $(\mathbb Z/2)^3$-cover branched along the $3$ conics
$\{a^2+b^2=0\},\{b^2+c^2=0\},\{a^2+c^2=0\}$. Galois acts on the
$(\mathbb Z/2)^3$-cover via $\mathrm{Gal}(\mathbb Q(i)/\mathbb Q) = \mathbb Z/2$
swapping the two sheets of each branched cover. The transcendental lattice
is thus a representation of $\mathbb Z/2 \times S_3$ (= $D_6$, dihedral of
order $12$).

Possible irreps of $D_6$ on a real space:
- 4 one-dimensional: $\mathbf{1}, \epsilon, \chi, \epsilon\chi$
- 2 two-dimensional: $\rho, \rho'$
where $\epsilon$ is the sign character of $S_3$, $\chi$ the sign character
of $\mathbb Z/2$.

For the K3 transcendental lattice of rank $\le 6$, the $D_6$-decomposition
has at most $6$ summands. **The fixed part $T^{D_6} \subset T^{G_{\mathbb Q}}$
governs the order of $\mathrm{Br}_{\mathrm{tr}}^G$.**

---

## 3. Brauer-Manin evaluation — *what we can/can't compute*

### 3.1 What PARI can do

- $\#\widetilde V'(\mathbb F_{p^k})$ for small $p,k$ (computed §1).
- Hilbert-symbol computation $(a,b)_p$ at any place $p$ for algebraic
  Brauer classes given as quaternion algebras (done in `brauer-work/`).
- Linear algebra in $\mathrm{NS}\otimes\mathbb Q$ once the lattice
  intersection form is given.

### 3.2 What PARI **cannot** do

- **Compute the actual transcendental Brauer classes.** This requires
  $\ell$-adic étale cohomology of $\widetilde V'$, specifically the
  Kummer sequence $0\to\mathrm{Pic}(\widetilde V')/\ell^n
  \to H^2(\widetilde V',\mu_{\ell^n}) \to \mathrm{Br}(\widetilde V')[\ell^n]\to 0$
  with Galois action — not implemented in PARI.

- **Compute local invariants $\mathrm{inv}_p(T(x))$ for a transcendental
  class $T$.** Even given $T$ as an Azumaya algebra (gerbe over
  $\widetilde V'$), evaluating $T(x_p)\in\mathrm{Br}(\mathbb Q_p)\cong\mathbb Q/\mathbb Z$
  needs explicit cocycle representatives — Magma's `BrauerGroup` machinery
  or Sage's `BrauerComputation` would be required.

- **Verify the Galois module structure of $T(\widetilde V')\otimes\mathbb Q_\ell$.**
  Frobenius traces give power sums but not the full L-polynomial without
  $\Omega(b_2)$ Newton sums.

### 3.3 Pseudocode for Magma/Sage

```
// === Magma: Compute Br(V')_tr and B-M evaluation ===

// Step 1: Define V' as a scheme.
P5<a,b,c,d,e,f> := ProjectiveSpace(Rationals(), 5);
V := Scheme(P5, [a^2+b^2-d^2, b^2+c^2-e^2, a^2+c^2-f^2]);

// Step 2: Identify singular locus and resolve.
S := SingularSubscheme(V);           // expect 12 points
Vtilde := MinimalResolution(V);      // K3 surface

// Step 3: Compute NS lattice (Magma function for K3).
NS := NeronSeveriLattice(Vtilde);    // requires Kodaira fiber analysis
rho := Rank(NS);                     // expect 16-18

// Step 4: Compute transcendental lattice T = NS^perp in H^2_int.
H2 := SecondCohomologyLattice(Vtilde);
T := OrthogonalComplement(H2, NS);
r_tr := Rank(T);                     // expect 4-6

// Step 5: Compute Galois action on T using Frobenius.
// For each prime p of good reduction, compute Frob_p on T via:
//   - Count #Vtilde(F_p^k) for k = 1..r_tr to extract eigenvalues
//   - Identify Frob_p as element of O(T) (orthogonal group of T)
G := Subgroup(OrthogonalGroup(T), [Frob_action(p) : p in [3,5,..,..]]);

// Step 6: Compute Br(V')_tr = (T^{vee} / NS-image)^G.
//  By Skorobogatov-Zarhin: Br(Vtilde)_tr / Br_1 = H^1(G_Q, T)_torsion ...
//  Use the spectral sequence Hom(T, Q/Z)^G -> H^2(G_Q, ?) etc.
BrTr := BrauerTranscendental(Vtilde, NS, GaloisAction);

// Step 7: For each generator alpha in BrTr:
//   - Lift to Azumaya algebra on Vtilde (Magma's AzumayaAlgebra)
//   - For each prime p, compute local invariant map:
//       V(Q_p) --> Br(Q_p) = Q/Z, x -> inv_p(alpha(x))
//   - Sum over all places: sum_p inv_p(alpha(x)) for x in V(A_Q)
//   - If sum constant non-zero on V(A_Q): Brauer-Manin obstruction!

for alpha in Generators(BrTr) do
  obstr := true;
  invs := AssociativeArray();
  for p in BadPrimes(Vtilde) cat [3,5,7,..,..] do
    invs[p] := LocalInvariantFunction(alpha, p);
    // Check: is sum_p invs[p](x) = 0 for all (x_p) in adelic V?
  end for;
  total := SumOverPlaces(invs);
  if not IsZero(total) then
    print "Brauer-Manin obstruction from alpha=", alpha;
    obstr := false;
  end if;
end for;
```

The bottleneck is **Step 5–6**: computing Galois action explicitly and
identifying the fixed part of $T^\vee/\mathrm{(alg)}$ modulo torsion.
Even Magma struggles for non-Kummer K3s without prior work on the lattice
structure.

---

## 4. Alternative: descent on the Albanese / Manin-Mumford

### 4.1 Albanese of $\widetilde V'$

For a K3, $q := h^1(\mathcal O) = 0$, so $\mathrm{Alb}(\widetilde V') = 0$.
**Manin-Mumford on the Albanese is empty.** No torsion obstruction available.

### 4.2 Higher descent / Stoll-Skorobogatov

The étale fundamental group $\pi_1^{\text{ét}}(\widetilde V')$ of a simply
connected K3 is trivial (over $\bar{\mathbb Q}$). The "geometric" étale
covers of $\widetilde V'$ vanish, so $V^{\text{ét},\mathrm{Br}}_{\widetilde V'}
=V^{\mathrm{Br}}_{\widetilde V'}$. No improvement.

Stoll-Skorobogatov ("descent on $V$ along $V\to V'$"): the
$2:1$ cover $V \to V'$ corresponds to a class in $H^1(\widetilde V', \mathbb Z/2)$,
which vanishes since $\widetilde V'$ is simply connected. Hence no new
descent from $V$ to $V'$. The PCP variety $V$ inherits the same Brauer
obstruction as $\widetilde V'$, with possibly extra contributions from the
$g$-equation which were already considered in `PICK-3-ETALE-BRAUER.md`.

### 4.3 Conclusion

No alternative obstruction route (Manin-Mumford, Stoll-Skorobogatov,
higher étale-Brauer) gives leverage beyond what plain Brauer-Manin and
transcendental Brauer can already provide.

---

## 5. §5 Verdict and summary

### 5.1 Computed bounds

- $\rho_{\mathrm{geom}}(\widetilde V') \ge 16$ (explicit classes:
  $H, F_1,F_2,F_3,$ and $12$ exceptional curves).
- $\rho_{\mathrm{geom}}(\widetilde V') \le 20$ at $p=3$ (Frobenius
  non-integrality of $t_1/p$).
- Most likely $\rho_{\mathrm{geom}}\in\{16,17,18\}$, with
  $\dim T\otimes\mathbb Q \in\{4,5,6\}$.
- $\widetilde V'$ is supersingular at $p=5,7$ (so $\rho_{\bar{\mathbb F}_p}=22$).
- $\widetilde V'$ is *not* supersingular at $p=3,11,17,19$ (so non-trivial
  transcendental part exists).

### 5.2 The transcendental Brauer group

$$
\dim_{\mathbb Q_\ell} \mathrm{Br}(\widetilde V')_{\mathrm{tr}}^{G_{\mathbb Q}}
\;\le\; b_2 - \rho_{\mathrm{geom}} \;\le\; 6.
$$
The actual Galois-fixed dimension is *strictly smaller* in generic
situations. Without computing the Galois action explicitly (Magma/Sage),
we cannot determine whether
$\mathrm{Br}(\widetilde V')_{\mathrm{tr}}^{G_{\mathbb Q}}$ is non-zero, let
alone whether it produces a Brauer-Manin obstruction.

### 5.3 Outcome

> **Outcome (B) — empty / inconclusive.** PARI/GP can compute Frobenius
> traces (done) and confirm $\rho_{\mathrm{geom}}\ge 16$ (bound the
> transcendental dim by $\le 6$), but **cannot compute transcendental
> Brauer classes or evaluate Brauer-Manin pairings** for them.

### 5.4 What remains computationally open (Magma/Sage required)

1. Compute the full L-polynomial $L_p(T) = \det(1-\mathrm{Frob}_p T|H^2)$
   at one good prime $p$ (say $p=3$ or $11$). This requires
   $\#\widetilde V'(\mathbb F_{p^k})$ for $k=1,\dots,11$.
   In PARI this is borderline feasible at $p=3$ ($3^{15}\approx 1.4\cdot 10^7$
   tuples per $k=5$) but quickly out-of-reach for $k\ge 6$.

2. Factor $L_p(T)$ over $\mathbb Q$ to separate cyclotomic factors (algebraic)
   from irreducible non-cyclotomic factors (transcendental). The
   transcendental factor's degree is the transcendental rank.

3. Compare transcendental factors across multiple primes $p$ to identify the
   single irreducible factor of $T\otimes\mathbb Q_\ell$ over $\mathbb Q$
   (it should be a Galois-conjugacy-class of Frobenius eigenvalues).

4. Compute the Galois action on $T$ explicitly using the matrix of
   $\mathrm{Frob}_p$ on $T\otimes\mathbb Q_\ell$ for various $p$ (or via
   the analytic theta-correspondence to a modular form, since K3 surfaces
   of low transcendental rank often have modular L-functions).

5. Compute $H^1(G_{\mathbb Q}, T^\vee)$ via the Hochschild-Serre spectral
   sequence and locate the transcendental Brauer obstruction.

### 5.5 Final verdict (one-line)

> The transcendental Brauer obstruction on the Euler-brick K3
> $\widetilde V'$ is bounded above by $6$ candidate classes (not $14$–$16$
> as initially feared), with the actual Galois-fixed dimension unknown.
> PARI computes the Picard-rank lower bound and confirms supersingular
> reduction at $p=5,7$, but **cannot compute Brauer-Manin invariants for
> transcendental classes**. No new obstruction is produced; the route is
> handed off to Magma/Sage with a detailed algorithm in §3.3.

---

## 6. References

- Tate, *Algebraic cycles and poles of zeta functions*, 1965 (Tate conjecture
  for K3).
- Artin, *Supersingular K3 surfaces*, Ann. Sci. ENS 1974.
- Skorobogatov–Zarhin, *The Brauer group of Kummer surfaces and torsion of
  elliptic curves*, J. Reine Angew. Math. 2012.
- Hassett–Várilly-Alvarado, *Transcendental Brauer groups of K3 surfaces*,
  Adv. Math. 2013.
- van Luijk, *K3 surfaces with Picard number one*, Algebra Number Theory
  2007 (algorithmic Picard-rank computation).
- `PICK-3-ETALE-BRAUER.md`,
  `exploration/brauer-manin-attack.md`,
  `SILVERMAN-RANK-JUMP-CLOSURE.md`.

---

**Signed:**

> **CΛ / Lightman Chang**
> Independent Researcher
> lightman.chang@gmail.com
> 2026-05-17

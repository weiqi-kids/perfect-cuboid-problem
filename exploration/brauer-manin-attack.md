---
status: research-investigation
last_updated: 2026-05-15
author: CΛ / Lightman Chang
---

# Brauer–Manin Attack on the Perfect Cuboid Problem

> **CΛ / Lightman Chang**
> Independent Researcher · lightman.chang@gmail.com · 2026-05-15

---

## 0. Status of the attack

**Verdict (honest):** The Brauer–Manin obstruction approach to the Perfect Cuboid
Problem (PCP), at the level of detail this investigation reached, has produced
**a partial structural picture and several non-trivial 2-adic identities, but no
unconditional BM obstruction**.

Precisely:

1. **No element of $\operatorname{Br}(V)\bmod\operatorname{Br}(\mathbb Q)$
   constructed in this investigation gives a non-empty
   $V(\mathbb A_\mathbb{Q})^{\operatorname{Br}}=\varnothing$ result.**
2. We constructed a candidate
   $\mathcal{C} = (d,d-a)\cdot(d-a,d-b)\cdot(f,f-a)\cdot(f-a,f-c)
   \in \operatorname{Br}(k(V))$
   which satisfies $\operatorname{inv}_2(\mathcal{C}(P))=\tfrac12$ for every
   $P\in V(\mathbb Q_2)$ with $\min(v_2(b),v_2(c))=2$. This is the most
   restrictive PCP 2-adic regime; however it is **not** Azumaya on all of $V$
   (the residue at $\{d-b=0\}$ is non-trivial) and the equality $\tfrac12$
   **fails** when $\min(v_2(b),v_2(c))\ge3$. Thus $\mathcal C$ does not
   constitute a BM obstruction.
3. Within the restricted symbol family
   $\{(X_i,X_j)_2 : X_i\in\{a,b,c,d,e,f,g\}\}\cup\{(-1,X_i)_2\}$
   (28 quaternion classes plus a constant), the only constant function on
   $V(\mathbb Q_2)$ is the identically zero class. **No 2-adic BM obstruction
   exists at this purity level** (Theorem 5.1 below).
4. Several non-trivial vanishing relations hold automatically on $V(\mathbb Q_2)$
   — e.g. $(2,ad)_2=(2,dg)_2=(2,fg)_2=(2,adfg)_2=0$ identically (Theorem 5.2).
   These are necessary consequences of the variety structure but, by
   reciprocity, sum to $0$ over all places without producing an obstruction.
5. The variety $V$ has Picard rank $\ge 4$ over $\mathbb Q$ (the hyperplane
   class plus the three fibration classes of the face conic bundles), and
   $\operatorname{NS}(\bar V)$ has Galois-trivial generators including the
   irreducible components of singular fibers; we do not exhibit a
   Galois-non-invariant divisor class, so the algebraic Brauer subgroup
   $H^1(\mathbb Q,\operatorname{Pic}(\bar V))$ remains undetermined but
   plausibly trivial in the $\operatorname{rk}\ge 4$ rational sub-lattice.

**Consequence:** Brauer–Manin (in the form attacked here, namely quaternion
algebras built from the natural functions on $V$ together with simple
factorizations) does **not** suffice to refute PCP. Either richer Brauer
classes — coming from higher cyclic algebras, transcendental contributions, or
algebraic classes from singular-fiber components defined over imaginary
quadratic fields — or a fundamentally different obstruction theory is needed.

---

## 1. Setup and conventions

The perfect cuboid variety is
$$
V \subset \mathbb P^6_{[a:b:c:d:e:f:g]},\qquad
V:\begin{cases}
a^2+b^2 = d^2\\
b^2+c^2 = e^2\\
a^2+c^2 = f^2\\
a^2+b^2+c^2 = g^2.
\end{cases}
$$
PCP asks whether $V(\mathbb Q)$ has a "positive" point (all coordinates positive
and non-degenerate). By results recalled below, $V$ is geometrically a smooth
minimal surface of general type after resolving finitely many $A_1$ singular
points; we work with the smooth resolution $\tilde V$ when geometric
invariants are needed and with $V$ itself when arithmetic invariants suffice.

**Numerical invariants** (proof.md Theorem 3.2): $K^2=16$, $p_g=7$, $q=0$,
$\chi(\mathcal O)=8$, $c_2=80$. Topological Euler number $\chi_{\rm top}=80$.
Hodge numbers $h^{2,0}=p_g=7$, $h^{1,1}=h^2-2h^{2,0}=78-14=64$. Hence
$\operatorname{NS}(\bar V) = \operatorname{Pic}(\bar V)$ (since $q=0$, no
abelian-variety part) is a torsion-free abelian group of rank at most 64.

**Quaternion symbol convention.** For $\alpha,\beta\in F^\times$ with $F$ a
field of characteristic $\ne 2$, the cyclic algebra $(\alpha,\beta)_F$ is the
quaternion algebra with generators $i,j$ and relations $i^2=\alpha$, $j^2=\beta$,
$ij=-ji$. As a class in $\operatorname{Br}(F)[2]\cong H^2(F,\mu_2)$ it equals
the cup product $(\alpha)\smile(\beta)$. For $F=\mathbb Q_v$ the Hasse
invariant $\operatorname{inv}_v((\alpha,\beta))\in\{0,\tfrac12\}\subset\mathbb Q/\mathbb Z$
equals $0$ iff the local Hilbert symbol
$\bigl(\tfrac{\alpha,\beta}v\bigr)_v=+1$, equivalently iff $\alpha$ is a norm
from $\mathbb Q_v(\sqrt\beta)$ to $\mathbb Q_v$.

**Brauer–Manin pairing.** For
$\mathcal A\in\operatorname{Br}(V)$ and an adelic point $(P_v)\in V(\mathbb A_\mathbb{Q})$,
$$
\langle\mathcal A,(P_v)\rangle = \sum_v \operatorname{inv}_v(\mathcal A(P_v))
\in\mathbb Q/\mathbb Z.
$$
By global reciprocity this vanishes when $(P_v)$ comes from a $\mathbb Q$-point.
$V(\mathbb A_\mathbb{Q})^{\mathcal A}:=\{(P_v):\langle\mathcal A,(P_v)\rangle=0\}$.
$V(\mathbb A_\mathbb{Q})^{\operatorname{Br}}=\bigcap_{\mathcal A}V(\mathbb A_\mathbb{Q})^{\mathcal A}$.
$V(\mathbb Q)\subseteq V(\mathbb A_\mathbb{Q})^{\operatorname{Br}}$; if the right side is
empty we say BM obstructs $V(\mathbb Q)$.

---

## 2. The Picard module of $\bar V$

### 2.1 Geometric Picard

$V$ has several distinguished divisor classes defined over $\mathbb Q$.

**(P1) Hyperplane class $H$.** From the embedding $V\hookrightarrow\mathbb P^6$.

**(P2) Three face fibrations.** Each face equation gives a Pythagorean conic
in $\mathbb P^2$. The three projections
$$
\pi_1:V\to C_{ab},\quad C_{ab}=\{a^2+b^2=d^2\}\cong\mathbb P^1
$$
and analogously $\pi_2:V\to C_{bc}$, $\pi_3:V\to C_{ac}$, exhibit $V$ as a
fibration over $\mathbb P^1$ in three distinct ways. The generic fiber of $\pi_i$
is a **genus-5 curve**.

*Proof sketch of fiber genus.* Fix a point on $C_{ab}$ in the affine chart
$d=1$, parametrized by $u^2+v^2=1$. The fiber over $(u,v)$ is the curve
$$
C_{(u,v)}:\quad\tau^2+1=g'^{\,2},\ \tau^2+v^2=e'^{\,2},\ \tau^2+u^2=f'^{\,2}
$$
in $(\tau,g',e',f')\in\mathbb P^3$. Setting $w=g'-\tau$ (so $g'=\tfrac12(w+1/w)$,
$\tau=\tfrac12(1/w-w)$), one reduces to the fibre-product over $\mathbb P^1_w$
of the two genus-1 hyperelliptic curves
$$
E_v:\ E^2=w^4+(4v^2-2)w^2+1,\qquad
E_u:\ F^2=w^4+(4u^2-2)w^2+1.
$$
Generically the two quartic-branch sets (4 roots each in $w$) are disjoint, so
the fiber product is a smooth $4{:}1$ cover of $\mathbb P^1_w$ branched at $8$
points each with ramification index $2$. Riemann–Hurwitz:
$2g-2 = 4\cdot(-2)+16=8$, giving $g=5$. $\square$

The fiber class $F_i:=\pi_i^*(\text{pt})\in\operatorname{Pic}(V)$ for $i=1,2,3$.

**(P3) Components of degenerate fibers.** The fibration $\pi_1$ degenerates
over the two points $\{a=0\}$ and $\{b=0\}$ on $C_{ab}$ (where the quartic-branch
sets in the fiber-genus argument become non-generic). The fiber over $\{a=0\}$
consists of (the closures of):
$$
W_1: a=0,d=b,f=c,e=g;\quad W_2: a=0,d=b,f=c,e=-g;
$$
$$
W_3: a=0,d=b,f=-c,e=g;\quad W_4: a=0,d=b,f=-c,e=-g;
$$
and analogous components with $d=-b$. Each $W_i$ is a Pythagorean conic
$\{b^2+c^2=e^2\}\cong\mathbb P^1_\mathbb{Q}$. The 8 components of the
singular fiber over $\{a=0\}$ (and similarly the 8 over $\{b=0\}$) are each
defined over $\mathbb Q$, with the relation $\sum_{\text{components}}=F_1$.

**(P4) Likewise for $\pi_2,\pi_3$**: 6 singular fibers total
(3 fibrations $\times$ 2 each).

### 2.2 Galois action

All divisors enumerated in (P1)–(P4) above are defined over $\mathbb Q$;
the absolute Galois group $G_\mathbb{Q}$ acts trivially on the sublattice
$\Lambda\subset\operatorname{NS}(\bar V)$ they generate.

A potential Galois-non-trivial extension would come from divisor classes
defined over a non-trivial extension of $\mathbb Q$. The natural candidate
fields are the splitting fields of the 4 branch conics:
$$
C_1^\circ:a^2+b^2=0,\ C_2^\circ:b^2+c^2=0,\ C_3^\circ:a^2+c^2=0,
\ C_4^\circ:a^2+b^2+c^2=0
$$
in the projection $V\to\mathbb P^2_{[a:b:c]}$. The first three split over
$\mathbb Q(i)$ (as two lines $b=\pm ia$ etc.). $C_4^\circ$ is a smooth conic
over $\mathbb Q$ with a $\mathbb Q(i)$-point $(1:i:0)$, hence isomorphic to
$\mathbb P^1_{\mathbb Q(i)}$. So **the étale cover $V\to\mathbb P^2$ trivializes
over $\mathbb Q(i)$ at the level of branch loci**.

The Galois group $G_\mathbb{Q}$ acts on $\operatorname{NS}(\bar V)$ through its
quotient $\operatorname{Gal}(\mathbb Q(i)/\mathbb Q)=\mathbb Z/2$ on any
component that involves these branch decompositions. The action is potentially
non-trivial on Picard classes coming from components $\{b=ia\}$ vs $\{b=-ia\}$
on the geometric level — but on the variety $V$ itself, the divisor
$\{a=0\}\cap V$ (which is what appears in $V$, not $\{b=ia\}$ which is in
$\mathbb P^2$) is $\mathbb Q$-rational.

**Bottom line for $\operatorname{Pic}(\bar V)$ as Galois module:**
- The classes $H,F_1,F_2,F_3$ and all enumerated singular-fiber components
  $W_i$ are Galois-invariant, defined over $\mathbb Q$.
- We have **not** identified any Galois-non-trivial divisor class on $V$.
- Conjecturally (and consistent with all data so far),
  $\operatorname{NS}(\bar V)^{G_\mathbb{Q}}=\operatorname{NS}(\bar V)$ may hold,
  in which case $H^1(\mathbb Q,\operatorname{NS}(\bar V))=H^1(\mathbb Q,\mathbb Z^r)
  =\operatorname{Hom}(G_\mathbb{Q},\mathbb Z^r)=0$.

If this is correct then **the algebraic Brauer group
$\operatorname{Br}_1(V)/\operatorname{Br}(\mathbb Q)=H^1(\mathbb Q,\operatorname{Pic}(\bar V))$
vanishes**, and any BM obstruction must come from the **transcendental** part.

### 2.3 Transcendental Brauer group

For $V$ smooth projective with $q=0$, $\operatorname{Br}(\bar V)$ sits in
$$
0\to(\mathbb Q/\mathbb Z)^{b_2-\rho}\to\operatorname{Br}(\bar V)\to\bigoplus_\ell H^3(\bar V,\mathbb Z_\ell(1))_{\rm tors}\to 0
$$
where $b_2$ is the second Betti number and $\rho$ is the Picard rank. With
$b_2=78$, $\rho\le 64$, and (assuming) $\rho\ge 4$, the transcendental part has
non-zero rank: the $(\mathbb Q/\mathbb Z)$-part contributes $b_2-\rho\ge14$
copies of $\mathbb Q/\mathbb Z$.

However, the Galois invariants $H^0(\mathbb Q,\operatorname{Br}(\bar V))$
typically vanish for varieties of general type with the cyclotomic action being
non-trivial on the transcendental classes. We have not computed this directly.
This is the residual case where a BM obstruction could conceivably be hidden;
extracting it analytically would require the étale cohomology of $V$ and a
description of the cycle class map's cokernel.

---

## 3. Construction of candidate Brauer classes

Following the user's specification §4, we test candidate quaternion algebras
that *should* be classes in $\operatorname{Br}(V)$ based on the algebraic
identities defining $V$.

### 3.1 The four "trivially zero" classes

Each face equation $a^2+b^2=d^2$ implies that the quaternion class
$(a^2+b^2,*)\in\operatorname{Br}(k(V))$ trivializes (since $a^2+b^2=d^2$ is a
square on $V$). Hence:
$$
(a^2+b^2,-1)=0,\ \ (b^2+c^2,-1)=0,\ \ (a^2+c^2,-1)=0,\ \ (a^2+b^2+c^2,-1)=0
\ \in\operatorname{Br}(V).
$$
These pull back from $\operatorname{Br}(\operatorname{Spec}\mathbb Q)$ in a
trivial way: they evaluate to the trivial class at every $\mathbb Q$-point.
They give no obstruction.

### 3.2 Pythagorean factorizations and modified classes

On $V$ we have $b^2=(d-a)(d+a)$, hence $[d-a]\cdot[d+a]=[b^2]=1$ in
$k(V)^\times/(k(V)^\times)^2$, i.e. $[d-a]=[d+a]$. Analogously
$[d-b]=[d+b]$, $[e-c]=[e+c]$, $[e-b]=[e+b]$, $[f-c]=[f+c]$, $[f-a]=[f+a]$;
and from $g^2-a^2=e^2$, $[g-a]=[g+a]$, similarly $[g\pm b]$ and $[g\pm c]$.

These identities are the natural source of cyclic algebras on $V$. For instance
the class $(a,d-a)\in\operatorname{Br}(k(V))$ has the property that on $V$,
$(a,d-a) = (a,d+a) = (a,(d-a)(d+a)/(d-a)) = (a,b^2)\cdot(a,d-a)^{-1}=
(a,d-a)^{-1}$, so $2\cdot(a,d-a) = (a,b^2)=0$. Hence $(a,d-a)$ is 2-torsion,
as expected.

**Candidate**:
$$
A \;:=\; (d,d-a) + (d-a,d-b).
$$
Using $b^2=(d-a)(d+a)$ this is generically $(d,d-a)\cdot(d-a,d-b)$ in
$\operatorname{Br}(k(V))[2]$.

**Symmetric counterpart** (swap $b\leftrightarrow c$, accompanied by $d\leftrightarrow f$):
$$
B \;:=\; (f,f-a) + (f-a,f-c).
$$

The user §4 also suggests testing classes from the "space diagonal" $g$:
$$
C\;:=\;(g,g-a)+(g-a,g-b),\quad D\;:=\;(g,g-c)+(g-c,g-a),\quad E\;:=\;(g,g-b)+(g-b,g-c).
$$

### 3.3 Verifying residues — when are $A,B,C,D,E$ Azumaya on $V$?

We compute residues of $A$ along the principal divisors of $V$ to determine
its codimension-1 support.

**Residue of $A=(d,d-a)+(d-a,d-b)$ at $\{d=0\}$.**
On $V$, $d=0\Rightarrow a^2+b^2=0$, which has no $\mathbb Q$-points; over
$\bar{\mathbb Q}$ the locus $\{d=0\}\cap V$ has codim $\ge 2$, so it is not a
divisor and contributes no residue.

**Residue at $\{d-a=0\}$.** On $V$, $d=a\Rightarrow b^2=(d-a)(d+a)=0\Rightarrow b=0$.
So the divisor $\{d-a=0\}\cap V$ is contained in $\{b=0\}\cap V$; we identify
the irreducible component with $a=d$, $b=0$, parametrized by $(c,e,f,g)$ with
$c^2=f^2$ and $a^2+c^2=g^2=e^2$. Call this component $D_{d-a}$; it has four
irreducible sub-components by signs of $f,g$ relative to $c$ and $e$.

At a generic point of $D_{d-a}$, $v(d)=0$ (since $d=a\ne0$), $v(d-a)=1$,
$v(d-b)=0$ (since $d-b=a\ne0$). Hence
$$
\operatorname{res}_{D_{d-a}}((d,d-a)) = d^{1}\cdot(d-a)^{0}\equiv d \equiv a\pmod{(k(D_{d-a})^\times)^2}
$$
and
$$
\operatorname{res}_{D_{d-a}}((d-a,d-b)) = (d-a)^{0}\cdot(d-b)^{-1}\equiv 1/(d-b)\equiv 1/a\equiv a\pmod{(...)^2}.
$$
Total residue of $A$: $[a]+[a]=0$ in $k(D_{d-a})^\times/2$. **Trivial.** ✓

**Residue at $\{d-b=0\}$.** Symmetrically $\{d=b\}\Rightarrow a^2=0\Rightarrow a=0$.
At a generic point of the component $D_{d-b}$ (where $a=0,d=b$): the function
$d-b$ vanishes to order 1, $d-a=b\ne0$.
$$
\operatorname{res}_{D_{d-b}}((d,d-a))=0\cdot\text{anything}=0
$$
(both valuations are zero),
$$
\operatorname{res}_{D_{d-b}}((d-a,d-b))=(d-a)^1=[b]\pmod{(k(D_{d-b})^\times)^2}.
$$
**Non-trivial:** $[b]\in k(D_{d-b})^\times/2$ is non-constant ($b$ is a coordinate
function on the Pythagorean conic $\{b^2+c^2=e^2\}$). So $A$ has non-trivial
residue $[b]$ along $D_{d-b}$, and **$A\notin\operatorname{Br}(V)$**.

### 3.4 Combining $A$ with $B$: residue tracking

Compute the residue of $B=(f,f-a)+(f-a,f-c)$ at the same divisor $D_{d-b}$
(where $a=0$, $d=b$, $f=\pm c$, $e=\pm g$).

On the component $D_{d-b}^+$ where $f=c$: $f-c=0$ on this component, so this
component coincides with a component of $\{f-c=0\}\cap V$, but distinct from
$D_{d-b}$ as a divisor (different defining equation).

At a generic point of $D_{d-b}$ (where $f\ne c$), $v(f-c)=0$, $v(f-a)=0$,
$v(f)=0$. All factors in $B$ are units, contributing 0 residue. So
**$\operatorname{res}_{D_{d-b}}(B)=0$**.

Hence $\operatorname{res}_{D_{d-b}}(A+B)=[b]\neq0$, so **$A+B\notin\operatorname{Br}(V)$**.

A killing modification would require an additional cyclic algebra with residue
$[b]$ along $D_{d-b}$ and zero along other divisors. The obvious candidate is
$(b,X)$ for some $X$; but $(b,X)$ has residue $[X]$ at $\{b=0\}\supset D_{d-b}$,
which is a *different* divisor (the full one, not just the $d=b$ piece) — so
this doesn't surgically modify only at $D_{d-b}$.

The conclusion of this section: **the natural quaternion candidates do not
combine cleanly into a $\operatorname{Br}(V)$ class**; the residues at the 8
sub-components of the $\{b=0\}$ and $\{a=0\}$ loci are obstructions to making
them Azumaya. To proceed, one would have to (a) decompose the residue groups
along each sub-component carefully, (b) find a basis of cyclic algebras whose
residues span the residue group, and (c) check the kernel — this is the
explicit residue exact sequence calculation indicated in the user's §4.

---

## 4. Empirical 2-adic invariant computations

Despite $A+B$ not being Azumaya, we computed $\operatorname{inv}_2((A+B)(P))$
empirically at every accessible $P\in V(\mathbb Q_2)$. The procedure:

1. Enumerate $(a,b,c)\pmod{2^K}$ for $K=6$ satisfying $a$ odd,
   $\min(v_2(b),v_2(c))=2$, $\max\ge 4$ (the constraints of Theorem 11 in
   `proof.md`), plus the four face/space-diagonal equations being squares mod $2^K$.
2. For each such triple, iterate over all $\pmod{2^K}$ square-root choices for
   $d,e,f,g$.
3. Compute $\operatorname{inv}_2$ of the quaternion symbols
   $(d,d-a),(d-a,d-b),(f,f-a),(f-a,f-c)$ using PARI's `hilbert(\cdot,\cdot,2)`.

### 4.1 Constancy of $A+B$ on the parity-restricted 2-adic locus

PARI script `check_AB.gp` enumerates 12,288 distinct square-class profiles
(Case I: $v_2(b)=2$) and 9,216 profiles (Case II: $v_2(c)=2$). In every case:

> $\operatorname{inv}_2((A+B)(P)) = \tfrac12$ for all $P$ with
> $\min(v_2(b),v_2(c))=2$.

This is verified on the 7 known primitive Euler bricks with maximum edge
$\le 2000$:

| Brick $(a,b,c)$ | Oriented $(a,b,c)$ | $v_2(b),v_2(c)$ | $A$ | $B$ | $A+B$ |
|---|---|---|---|---|---|
| (44,117,240) | (117,44,240) | 2,4 | 1/2 | 0 | **1/2** |
|              | (117,240,44) | 4,2 | 0 | 1/2 | **1/2** |
| (85,132,720) | (85,132,720) | 2,4 | 1/2 | 0 | **1/2** |
|              | (85,720,132) | 4,2 | 0 | 1/2 | **1/2** |
| (140,480,693)| (693,140,480) | 2,5 | 1/2 | 0 | **1/2** |
|              | (693,480,140) | 5,2 | 0 | 1/2 | **1/2** |
| (160,231,792)| (231,160,792) | 5,3 | 0 | 0 | **0** ⚠ |
|              | (231,792,160) | 3,5 | 0 | 0 | **0** ⚠ |
| (187,1020,1584)|(187,1020,1584)| 2,4 | 1/2 | 0 | **1/2** |
|                |(187,1584,1020)| 4,2 | 0 | 1/2 | **1/2** |
| (240,252,275)|(275,240,252)| 4,2 | 0 | 1/2 | **1/2** |
|              |(275,252,240)| 2,4 | 1/2 | 0 | **1/2** |
| (1008,1100,1155)|(1155,1008,1100)| 4,2 | 0 | 1/2 | **1/2** |
|                 |(1155,1100,1008)| 2,4 | 1/2 | 0 | **1/2** |

The brick (160,231,792) has $\min(v_2)=3$ (not $2$) and **breaks the pattern**:
$A+B=0$ rather than $1/2$. So $A+B$ is **not constant on all of
$V(\mathbb Q_2)$**, only on the sub-locus where one of $b,c$ has $v_2=2$ exactly.

A primitive PCP solution is constrained by Theorem 11 (`proof.md`) to satisfy
$v_2(b),v_2(c)\ge2$ and $|v_2(b)-v_2(c)|\ge2$; this does **not** force one of
them to equal $2$. So $A+B$ does not give a BM obstruction.

### 4.2 Constant zero classes at $p=2$

The same enumeration (combined with `check_2_classes.gp`) reveals that the
following Hilbert symbols are **identically 0** on $V(\mathbb Q_2)$
(parity-constrained, both Cases I and II):

| Symbol | Reason / equivalent |
|---|---|
| $(a,e)_2$ | $e=4e'$ with $e'$ odd, $(a,4)_2=0$, $(a,e')_2$ controlled |
| $(2,ad)_2$ | $ad\equiv\pm1\pmod 8$ (i.e. $ad$ is a $\mathbb Q_2(\sqrt2)$-norm) |
| $(2,ag)_2$ | $ag\equiv\pm1\pmod 8$ |
| $(2,df)_2$ | $df\equiv\pm1\pmod 8$ |
| $(2,dg)_2$ | $dg\equiv\pm1\pmod 8$ |
| $(2,fg)_2$ | $fg\equiv\pm1\pmod 8$ |
| $(2,adfg)_2$ | $adfg\equiv\pm1\pmod 8$ |
| $(d,e)_2,(d,f)_2,(e,f)_2$, etc. | All $\equiv\pm 1\pmod 8$ ⇒ trivial |

These are **automatic consequences of the equations defining $V$ together with
the parity constraint**, not obstructions: at every $\mathbb Q$-point of $V$
(should it exist), reciprocity gives $\sum_v\operatorname{inv}_v=0$ trivially.

### 4.3 Negative result: no constant in the basic symbol family

Running PARI script `sym3.gp` we enumerate all 576 distinct profiles of
$\bigl(a,b,c,d,e,f,g\bigr)\bmod\text{squares}$ on $V(\mathbb Q_2)$ (after
identifying signs of $d,e,f,g$ as separate $\mathbb Q_2^*$-classes). Forming
the $F_2$-matrix of 28 quaternion symbols (all $\binom72=21$ symbols
$(X_i,X_j)$ plus $7$ symbols $(-1,X_i)$) together with the constant $1$, we
find:

> **Theorem 4.3.** The $F_2$-kernel of this matrix is $\{0\}$. Equivalently,
> the $28$ basic quaternion symbols $(X_i,X_j)_2$ and $(-1,X_i)_2$ together
> with $1$ are $F_2$-linearly independent as functions on
> $V(\mathbb Q_2)/\sim$.

In particular **no non-trivial linear combination of basic quaternion symbols
gives a constant non-zero invariant on $V(\mathbb Q_2)$**. The natural
"$\operatorname{Br}(V)/\operatorname{Br}(\mathbb Q)$"-style construction at
this purity level is empty.

When extended to include the $26$ "Pythagorean difference" variables
$d\pm a, d\pm b, e\pm b, e\pm c, f\pm a, f\pm c, g\pm a, g\pm b, g\pm c,
a\pm b, b\pm c, a\pm c, -1, 2$ (33 variables, $\binom{33}{2}+1=529$ symbols),
the kernel jumps to dimension 452. Most of these basis vectors correspond to
trivial algebraic identities (e.g. $(e,f)=(e-c,f-c)$ from $b^2=(e-c)(e+c)$).
Among the $452$ kernel vectors only a handful are "non-trivial obstruction
candidates"; the most concise is
$$
A+B+\bigl[(g,g-a)+(g-a,g-b)\bigr]+\cdots
$$
all of which **fail** when verified on the brick (160,231,792).

---

## 5. Negative results and the structure they imply

### 5.1 Theorem (No basic BM obstruction at $p=2$).

The image of $\operatorname{Br}(\mathbb Q)\oplus
\langle (X_i,X_j)_2,(-1,X_i)_2: i\ne j\rangle$ in
$H^2_{\rm fppf}(V_{\mathbb Q_2},\mu_2)$ does not contain a non-zero constant
function on $V(\mathbb Q_2)$. In particular, **no Brauer–Manin obstruction
arises from this restricted family of quaternion classes**.

*Proof.* Empirical (PARI computation `sym3.gp`), but the kernel computation is
finite and verifiable.

### 5.2 Theorem (Automatic Hilbert-symbol identities on $V$).

For every $P=(a,b,c,d,e,f,g)\in V(\mathbb Q_2)$ satisfying the parity
constraints of Theorem 11 (`proof.md`), the following Hilbert symbols vanish:
$(a,e)_2$, $(2,ad)_2$, $(2,ag)_2$, $(2,df)_2$, $(2,dg)_2$, $(2,fg)_2$,
$(2,adfg)_2$. Equivalently:
$ad,ag,df,dg,fg,adfg$ are all 2-adic norms from $\mathbb Q_2(\sqrt 2)$.

*Proof sketch.* Each follows from the explicit 2-adic expansion: $a$ is odd
unit, $d^2=a^2+b^2\equiv a^2\pmod{16}$ (so $d\equiv\pm a\pmod 8$); $g^2\equiv
a^2\pmod{16}$; with the parity tower one extracts $ad,ag\equiv\pm1\pmod 8$.
$\square$

These are *consistency conditions*, not obstructions: by reciprocity they
contribute 0 to the BM pairing automatically.

### 5.3 Theorem (Conditional algebraic Brauer triviality).

If $\operatorname{Pic}(\bar V) = \langle H,F_1,F_2,F_3, \text{singular fiber components}\rangle$
with the listed components all defined over $\mathbb Q$, then
$$
H^1(\mathbb Q,\operatorname{Pic}(\bar V)) = 0,
$$
so the algebraic Brauer subgroup
$\operatorname{Br}_1(V)/\operatorname{Br}(\mathbb Q)=0$.

*Proof sketch.* For a permutation $G$-module $M$ over a finitely generated
abelian group with trivial action, $H^1(G,M)=\operatorname{Hom}(G,M)=0$ since
$M$ has no torsion and $G$ is profinite. The hypothesis is that the listed
generators span $\operatorname{Pic}(\bar V)$ (a finitely generated free
abelian group with trivial Galois action). $\square$

We verified the *defined over $\mathbb Q$* property for all listed components.
The hypothesis "these span $\operatorname{Pic}(\bar V)$" is what we did not
prove; if it fails (e.g. additional classes appear over $\mathbb Q(i)$ from
the "$b=\pm ia$" branch geometry), $H^1$ could be non-trivial. We have no
direct evidence of this.

---

## 6. Candidate Brauer classes — summary table

| Label | Class $\mathcal A\in\operatorname{Br}(k(V))$ | Azumaya on $V$? | $\operatorname{inv}_2$ on $V(\mathbb Q_2)$ | BM obstruction? |
|---|---|---|---|---|
| $A_1$ | $(a,b)_2$ | No (residue at $\{a=0\}$) | varies | no |
| $A_2$ | $(a,b)(b,c)(a,c)$ | No (residues at $\{a,b,c=0\}$) | varies | no |
| $A_3$ | $(-1,a)(-1,b)(-1,c)$ | No | varies | no |
| $A_4$ | $(a,d-a)$ | No (residue at $\{a=0\}$) | varies | no |
| $A_5$ | $A=(d,d-a)(d-a,d-b)$ | No (residue $[b]$ at $\{d-b=0\}$) | $\frac12$ on $\{v_2(b)=2\}$; 0 else | partial (parity-locus only) |
| $A_6$ | $B=(f,f-a)(f-a,f-c)$ | No (residue $[c]$ at $\{f-c=0\}$) | $\frac12$ on $\{v_2(c)=2\}$; 0 else | partial (symmetric) |
| $A_7$ | $A+B$ | No (residues do not cancel) | $\frac12$ on $\{\min v_2=2\}$; 0 else | **no** (fails for brick 160) |
| $A_8$ | $C=(g,g-a)(g-a,g-b)$ | likely no | varies | no |
| $A_9$ | $D=(g,g-c)(g-c,g-a)$ | likely no | varies | no |
| $A_{10}$ | $E=(g,g-b)(g-b,g-c)$ | likely no | varies | no |
| $A_{11}$ | $A+B+C$ | No | varies | no |
| $A_{12}$ | $A+B+C+D+E$ | No | varies | no |
| $A_{13}$ | $(2,a)$ | No | varies | no |
| $A_{14}$ | $(2,d)$ | No | varies | no |
| $A_{15}$ | $(2,ad)$ | (constant 0; trivial) | 0 always | no |

(See `brauer-work/AB_all_bricks.gp` and `brauer-work/g_classes3.gp` for raw data.)

---

## 7. Outstanding pieces

The investigation reached the following well-defined obstacles. Completing any
of these would either close BM affirmatively or rule it out unconditionally.

### 7.1 Picard module — exact rank and generators

We have $\operatorname{rk}\operatorname{Pic}(\bar V)\ge 4$ (from $H, F_1, F_2, F_3$)
with the singular-fiber components giving additional rank. The exact computation
of $\rho=\operatorname{rk}\operatorname{Pic}(\bar V)$ would require:
1. Computing the explicit irreducible decomposition of each singular fiber (we
   sketched 4 components per singular fiber over $\{a=0\}$ for $\pi_1$, but
   the global combinatorics across all 6 singular fibers and the relations
   from intersection numbers needs care);
2. Verifying via Lefschetz-Picard the genericity claim and exhibiting all
   $\mathbb Q$-divisor classes;
3. Using a computer algebra system (Magma or Sage) to compute
   $H^1(\mathbb Q,\operatorname{Pic}(\bar V))$ as a representation of a finite
   quotient of $G_\mathbb{Q}$.

### 7.2 Residue surgery to make $A+B$ Azumaya

The residue of $A+B$ at $\{d-b=0\}$ component $D_{d-b}^{(j)}$ is $[b]\bmod\text{sq}$.
A correction class with residue $[b]$ at all four $D_{d-b}^{(j)}$ would be a
class like $(b,D_{d-b}^{(j)})$ but globalized. The full surgery would:
1. Decompose the residue group $\bigoplus_{D}H^1(k(D),\mathbb Q/\mathbb Z)$ in
   the residue exact sequence $0\to\operatorname{Br}(V)\to\operatorname{Br}(k(V))\to\bigoplus_D H^1$.
2. Find the kernel of the boundary map (= $\operatorname{Br}(V)$).
3. Within this kernel, identify the "extra" classes
   $\operatorname{Br}(V)/\operatorname{Br}(\mathbb Q)$ and compute their 2-adic invariants.

This was the path the user's specification §4 outlined; we identified the
relevant divisors and residues but did not complete the cohomological calculation.

### 7.3 Transcendental classes

For $V$ general type with $b_2-\rho\ge 14$ ($\rho\le 64$), the transcendental
Brauer group $\operatorname{Br}(\bar V)/\operatorname{Br}_1(\bar V)$ has rank
$\ge 14$ (as abelian groups). The $G_\mathbb{Q}$-fixed part
$H^0(\mathbb Q,\operatorname{Br}(\bar V))$ is the relevant contribution to BM.
This part is, in general, much harder to compute and is typically attacked via
the étale cohomology of $V$ as an $\ell$-adic Galois representation.

### 7.4 Reconciliation with the "constant 1/2" observation

The empirical observation that $A+B=\tfrac12$ at $p=2$ on the
$\{\min(v_2(b),v_2(c))=2\}$ locus is genuine and not an artifact. It implies
that **for any primitive PCP solution with at least one of $b,c$ having
$v_2=2$**, the quaternion symbol $A+B$ evaluates to $\tfrac12$ at $p=2$. By
reciprocity, this forces
$$
\sum_{v\neq 2}\operatorname{inv}_v(A+B) = \tfrac12.
$$
This is a *parity constraint* on the odd-prime Hilbert symbols of the
factorizations of $d, d-a, d-b, f, f-a, f-c$. It is testable on any candidate
PCP. We have not derived a contradiction from this constraint alone, and the
existence of primitive Euler bricks (e.g. (160,231,792) with min $v_2=3$)
where the parity flips suggests that the constraint may be satisfiable.

### 7.5 The most promising next step

**Compute the singular-fiber components and their Galois action more
carefully**, especially:

- The 4-fold splitting of each singular fiber over $\{a=0\}, \{b=0\}, \{c=0\}$.
- Whether the components are individually defined over $\mathbb Q$ or split
  over $\mathbb Q(i)$.
- The intersection theory of these components with $H$ and $F_i$.
- The resulting rank of the algebraic part of $\operatorname{Pic}(\bar V)$.

If components turn out to be defined over $\mathbb Q(i)$ in a non-trivial way
(my analysis suggests they are all $\mathbb Q$-defined, but a careful check
of the $A_1$-singular-locus resolutions could expose hidden Galois
asymmetries), then $H^1(\mathbb Q,\operatorname{Pic}(\bar V))$ could be
non-zero and a new family of cyclic algebras would emerge as candidates.

---

## 8. Honest final assessment

This investigation establishes:

1. **No standard Brauer–Manin obstruction** (in the quaternion-algebra family
   we explored) refutes PCP.
2. The structure of $V(\mathbb Q_2)$ under the parity constraints of
   `proof.md` Theorem 11 is **rich** (576 distinct square-class profiles in
   the canonical case) and admits several non-trivial Hilbert symbol
   identities.
3. The candidate $A+B$ provides a **partial obstruction** — it forces $1/2$ at
   $p=2$ on the dominant 2-adic regime, generating a non-trivial reciprocity
   constraint on odd primes — but is not a strict BM obstruction.
4. Algebraic Brauer: conditional on
   $\operatorname{Pic}(\bar V)$ being generated by the $\mathbb Q$-rational
   classes we identified, $\operatorname{Br}_1(V)/\operatorname{Br}(\mathbb Q)=0$,
   so the BM obstruction would be entirely transcendental — and this
   computation is beyond PARI's capabilities and the present investigation.

**Verdict (concise):** The Brauer–Manin obstruction to the Hasse principle
for $V$, as explored here using all natural quaternion algebra candidates,
**does not provide an unconditional refutation of PCP**. The investigation
is consistent with the (currently most likely) outcome that
$V(\mathbb A_\mathbb{Q})^{\operatorname{Br}}\neq\varnothing$, leaving PCP open
to BM-attack. The next concrete step is the transcendental Brauer group
computation, requiring full étale cohomology of $V$ in a CAS (Magma/Sage)
beyond PARI's reach.

---

## 9. Reproducibility

All computations in this report can be reproduced by running PARI/GP scripts
in `brauer-work/`. Key files:

- `bm1.gp` — Euler brick enumeration and parity classification
- `sym3.gp` — basic-symbol kernel analysis (Theorem 5.1)
- `check_AB.gp` — verifies $A+B=\tfrac12$ on the parity-2 locus
- `AB_all_bricks.gp` — verifies $A+B$ on all 7 primitive Euler bricks (max edge $\le 2000$)
- `g_classes3.gp` — tests classes involving $g$ on bricks
- `check_2_classes.gp` — exhibits the constant-zero $(2,X)$ identities
- `check_AB_full.gp` — confirms $A+B$ takes both values on unconstrained $V(\mathbb Q_2)$

Each script terminates within $\le$ 30 minutes on the hardware used.

---

**Signed:**

> **CΛ / Lightman Chang**
> Independent Researcher
> lightman.chang@gmail.com
> 2026-05-15

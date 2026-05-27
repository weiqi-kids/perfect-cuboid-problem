---
title: PCP — étale-Brauer and Descent Obstructions
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-17
status: research-investigation (negative/inconclusive)
---

# Perfect Cuboid Problem — étale-Brauer and Descent Obstructions

> **CΛ / Lightman Chang**
> Independent Researcher · lightman.chang@gmail.com · 2026-05-17

---

## 0. Verdict (honest, up-front)

The étale-Brauer obstruction $V(\mathbb A_{\mathbb Q})^{\text{ét},\mathrm{Br}}$,
when assembled from the natural torsors on the PCP variety $V$ (the
$(\mathbb Z/2)^4$ "sign-flip" torsor and the $(\mathbb Z/2)^3$ Pythagorean
descent torsors associated to the three face fibrations), **does not produce
a new global obstruction to PCP** beyond what the plain Brauer–Manin set
already captures. The descent step does refine the local set
$V(\mathbb A_{\mathbb Q})$ — it splits it into $2^k$ "type" components — but
on each component the Brauer pairing computation reduces to the one carried
out in `brauer-manin-attack.md`, which is inconclusive.

Concretely:

- $\pi_1^{\text{ét}}(\bar V) \otimes \mathbb Z/2$ is **at most**
  $(\mathbb Z/2)^4$ (one $\mathbb Z/2$ from each of the four face equations
  $a^2+b^2=d^2,\dots, a^2+b^2+c^2=g^2$ giving a sign-choice torsor).
- The corresponding finite étale $(\mathbb Z/2)^k$-covers $W\to V$ are
  geometrically connected components of the *oriented* cuboid variety; they
  do not introduce new arithmetic information because the sign of each
  diagonal is already arbitrarily chosen at each $\mathbb Q$-point.
- The non-abelian descent (Harari–Wittenberg) under
  $\mathrm{SL}_2(\mathbb F_2) = S_3$ acting on $\{a,b,c\}$ also yields nothing
  new: PCP is symmetric in $\{a,b,c\}$ by construction.
- For the *fibration*-descent (2-isogeny on the K3 cover $V'\to\mathbb P^1$),
  rank-jump on every fiber would be required to make the descent compute
  anything global. We have no such control.

So étale-Brauer **does not close Gap 3**. The honest assessment is outcome
(B): the obstruction is empty / no stronger than BM.

---

## 1. Recap of prior Brauer–Manin work

From `/root/proof/perfect-cuboid-problem/exploration/brauer-manin-attack.md`:

### 1.1 Picard / Brauer of $V$

- $V \subset \mathbb P^6$ is cut out by 4 quadrics; smooth resolution
  $\tilde V$ is a surface of general type with $K^2=16$, $p_g=7$, $q=0$,
  $\chi(\mathcal O)=8$, $c_2=80$, $b_2=78$.
- Geometric Picard rank $\rho \ge 4$ (hyperplane $H$, three face-fibration
  classes $F_1,F_2,F_3$) plus singular-fiber components; all candidate
  generators identified are $\mathbb Q$-rational, so plausibly
  $H^1(\mathbb Q,\mathrm{Pic}(\bar V))=0$ and
  $\mathrm{Br}_1(V)/\mathrm{Br}(\mathbb Q)=0$.
- Transcendental part has potential rank $\ge b_2-\rho \ge 14$; the
  $G_{\mathbb Q}$-fixed part was **not** computed.

### 1.2 Constructed quaternion candidates

- $A=(d,d-a)+(d-a,d-b)$ and $B=(f,f-a)+(f-a,f-c)$ are 2-torsion in
  $\mathrm{Br}(k(V))$, not Azumaya on $V$ (residue $[b]$ at $D_{d-b}$).
- $A+B$ has $\mathrm{inv}_2=\tfrac12$ on $\{\min(v_2(b),v_2(c))=2\}$, and $0$
  on brick $(160,231,792)$ where $\min v_2=3$ — not a BM obstruction.

### 1.3 Local conditions

$V(\mathbb Q_2)$ contains 576 square-class profiles; identities $(2,ad)_2=
(2,dg)_2=(2,fg)_2=(2,adfg)_2=0$ are automatic. $F_2$-kernel of the 28-symbol
matrix on $V(\mathbb Q_2)/\sim$ is trivial.

### 1.4 Result

> No element of $\mathrm{Br}(V)\bmod\mathrm{Br}(\mathbb Q)$ constructed gives
> $V(\mathbb A_{\mathbb Q})^{\mathrm{Br}}=\varnothing$. Plain BM is
> inconclusive (Gap 3 open).

---

## 2. étale-Brauer obstruction — definition and applicability

### 2.1 Skorobogatov (1999)

For a smooth projective variety $X/k$, write $T(X)$ for the set of pairs
$(f:W\to X,\,\sigma)$ where $f$ is a torsor under a finite étale group scheme
$G$ over $X$ and $\sigma\in H^1(k,G)$ is a class. Each twist $W^\sigma\to X$
is a torsor; let $V^\sigma=W^\sigma$, and
$$
X(\mathbb A_k)^{\text{ét},\mathrm{Br}}
\;:=\;\bigcap_{(f,G)\ \text{finite étale}}\ \bigcup_{\sigma\in H^1(k,G)}\
f^\sigma\bigl(V^\sigma(\mathbb A_k)^{\mathrm{Br}}\bigr).
$$
Then $X(k)\subseteq X(\mathbb A_k)^{\text{ét},\mathrm{Br}}$, and this set can
be strictly smaller than $X(\mathbb A_k)^{\mathrm{Br}}$ (Skorobogatov's
bielliptic-surface example).

### 2.2 Finite étale covers of $V$

The PCP variety $V$ is simply connected as a topological space (general-type
surfaces with $q=0$ have $\pi_1^{\text{top}}$ depending on geometry; for $V$
specifically we have a direct construction:

**Sign torsor.** The map $\sigma:V\to V'$ to the quotient
$V/(\mathbb Z/2)^7$ identifying all sign-flips $(a,b,c,d,e,f,g)\mapsto
(\pm a,\pm b,\pm c,\pm d,\pm e,\pm f,\pm g)$ — equivalently the projective
quotient — exhibits $V$ as a $(\mathbb Z/2)^4$-cover of its projection to
$\mathbb P^2_{[a:b:c]}$ (after fixing signs of $a,b,c$, the four quantities
$d,e,f,g$ each have a $\pm$ ambiguity; only the relative signs of $a,b,c$
matter projectively).

Precisely, the projection
$$
\Pi: V \longrightarrow \mathbb P^2_{[a:b:c]},\qquad
(a,b,c,d,e,f,g)\mapsto (a,b,c),
$$
is generically a $(\mathbb Z/2)^4$-cover branched along the 4 conics
$\{a^2+b^2=0\},\{b^2+c^2=0\},\{a^2+c^2=0\},\{a^2+b^2+c^2=0\}$.
After removing the branch divisor, $V\to\mathbb P^2$ is an étale
$(\mathbb Z/2)^4$-cover.

This is the **only** natural source of finite étale covers of $V$:

> **Observation.** $\pi_1^{\text{ét}}(V_{\bar{\mathbb Q}})$ is generated, as
> a quotient of $\pi_1^{\text{ét}}(\mathbb P^2\setminus\text{4 conics})$, by
> the local monodromies around the 4 branch conics, which together generate
> $(\mathbb Z/2)^4$. There is no torsion-free part by general-type +
> Bogomolov–Miyaoka–Yau considerations on the abelianization. Higher étale
> coverings (degree $>2^4$) factor through this.

### 2.3 The $(\mathbb Z/2)^4$-torsor

Let $W \to V$ be the étale $(\mathbb Z/2)^4$-cover dual to the sign-choice
data $(\epsilon_d,\epsilon_e,\epsilon_f,\epsilon_g)\in(\mathbb Z/2)^4$. A
twist $W^\sigma$ corresponds to a class
$\sigma=(\sigma_d,\sigma_e,\sigma_f,\sigma_g)\in H^1(\mathbb Q,(\mathbb Z/2)^4)
=(\mathbb Q^\times/\mathbb Q^{\times 2})^4$.

The twisted variety $W^\sigma$ is then:
$$
W^\sigma:\quad
\begin{cases}
a^2+b^2 = \sigma_d\,d'^2,\\
b^2+c^2 = \sigma_e\,e'^2,\\
a^2+c^2 = \sigma_f\,f'^2,\\
a^2+b^2+c^2 = \sigma_g\,g'^2.
\end{cases}
$$
**Local solvability of $W^\sigma$ forces** each of $\sigma_d,\sigma_e,
\sigma_f,\sigma_g$ to be a sum of two squares (and three, for $\sigma_g$) at
each place $p$. By Gauss's three-square theorem and the structure of sums of
two squares, this means in $\mathbb Q^\times/\mathbb Q^{\times 2}$ that
$\sigma_d,\sigma_e,\sigma_f$ are products of primes $\equiv 1\pmod 4$ (and
possibly $2$), with $-1$ allowed; and $\sigma_g$ is more permissive.

Only **finitely many** $\sigma$ give $W^\sigma(\mathbb A_{\mathbb Q})\ne
\varnothing$. The étale-Brauer set is then
$$
V(\mathbb A)^{\text{ét},\mathrm{Br}} = \bigcup_\sigma f^\sigma
\bigl(W^\sigma(\mathbb A)^{\mathrm{Br}}\bigr).
$$

### 2.4 Why this does not refine BM here

Each twist $W^\sigma$ is geometrically isomorphic to $V$ over
$\bar{\mathbb Q}$ (sign-twists). So $\mathrm{Br}(W^\sigma)\cong\mathrm{Br}(V)$
and the BM pairing on $W^\sigma$ is the pull-back of that on $V$, shifted by
$(\sigma_\bullet,\star)$-terms from residues. If
$\mathrm{Br}(V)/\mathrm{Br}(\mathbb Q)$ has trivial image on
$V(\mathbb A)$ (§1), same for each $W^\sigma$. The union
$\bigcup_\sigma f^\sigma(W^\sigma(\mathbb A)^{\mathrm{Br}})$ recovers
$V(\mathbb A)^{\mathrm{Br}}$ — no refinement.

### 2.5 The branch-locus / Galois-twist subtlety

A potentially non-trivial cover comes from $a^2+b^2=0$ splitting over
$\mathbb Q(i)$ as $(b-ia)(b+ia)=0$; the associated double cover branched over
$\{a=0\}\cup\{b=0\}$ is not geometrically connected. This $\mathbb Z/2$-
torsor reduces to choosing $\sqrt{-1}$ on the K3 cover $V'$, already
incorporated in the standard 2-descent on $E_{\text{PCP}}(q)$ via its full
2-torsion. **Not new** — covered by `SILVERMAN-RANK-JUMP-CLOSURE.md`.

---

## 3. Concrete computation — descent on the elliptic fibration

### 3.1 The K3 cover and its 2-isogenies

For each Pythagorean parameter $q$, the fiber $V_q\subset V$ is governed by
$E_q:=E_{\text{PCP}}(q): Y^2=X(X+1)(X+q^2)$, with full $\mathbb Q$-rational
2-torsion $\{O,(0,0),(-1,0),(-q^2,0)\}$. The three 2-isogenies realize the
standard 2-descents; the descent map
$(X,Y)\mapsto(X,X+1,X+q^2)\bmod\square\in(\mathbb Q^\times/\mathbb Q^{\times 2})^3$
has image constrained to primes dividing $2q(q^2-1)$.

### 3.2 The PCP face-3 condition as a torsor obstruction

A perfect cuboid at parameter $q$ corresponds to a rational point $(X,Y)\in
E_q(\mathbb Q)$ such that, with $T=X$,
$$
c := \frac{2Yq}{q^2-T^2} \in \mathbb Q,\qquad
a_n := c^2+1+q^2 \in (\mathbb Q^\times)^2.
$$
The condition $a_n\in\mathbb Q^{\times 2}$ is exactly the statement that the
point $(X,Y)$ lifts through a $\mathbb Z/2$-torsor over $E_q$ — namely the
torsor classified by $c^2+1+q^2$ modulo squares.

In étale-Brauer language: take $W_q \to V_q$ to be the double cover
$$
W_q:\ w^2 = c^2+1+q^2
$$
where $c=2Yq/(q^2-T^2)$. Then $W_q(\mathbb Q)\ne\varnothing$ iff PCP has a
solution at $q$. The descent obstruction is non-empty iff $W_q$ has
$\mathbb A_{\mathbb Q}$-points but no $\mathbb Q$-point; the étale-Brauer
obstruction would close this if we could show
$W_q(\mathbb A)^{\mathrm{Br}}=\varnothing$ for **every** Pythagorean $q$.

### 3.3 Computational status

For each Pythagorean fiber $q$: Mordell–Weil of $E_q$ via 2-descent
(rank typically 1–3, per `SILVERMAN-RANK-JUMP-CLOSURE.md`); Brauer of $W_q$
classified by $\mathrm{Pic}^0(W_q)/2$; pairing reduces to Hilbert-symbol
computation as in `brauer-manin-attack.md` §4.

For $q=3/4$: $E_{3/4}$ rank 1, generator $P_0$; the orbit $\{nP_0\}$ gives a
sequence $\{a_n\}$ with $a_1,\dots,a_5$ all non-squares. By Silverman/
Ingram–Mahé, $\{a_n\}$ has a primitive prime divisor with odd multiplicity
for all $n\ge N_0$ — the étale-Brauer obstruction at this fiber is captured
by this same primitive-prime argument.

### 3.4 Aggregating over Pythagorean fibers

Summing over all primitive Pythagorean triples $(\alpha,\beta,\gamma)$
(parametrized by $(m,n)$ with $\gcd(m,n)=1$ and $m\not\equiv n\pmod 2$),
the "étale-Brauer aggregate" obstruction at parameter $q$ reduces to:

> *For every primitive Pythagorean triple $(\alpha,\beta,\gamma)$ and every
> non-torsion $P\in E_q(\mathbb Q)$, the sequence $a_n(P)$ is non-square.*

This is **exactly the content of the Silverman closure argument** in
`SILVERMAN-RANK-JUMP-CLOSURE.md`. The étale-Brauer machinery does not give
us new information — it re-derives, in cohomological language, the same
fibration descent we already have.

---

## 4. Descent obstruction extension (Harari–Wittenberg)

### 4.1 Non-abelian descent under $S_3$

The PCP variety has a natural $S_3$-action permuting $(a,b,c)$, and
correspondingly $(d,e,f)$ (with $g$ fixed). The associated quotient
$V/S_3$ is the "unordered cuboid" variety. The non-abelian torsor
$V\to V/S_3$ has classifying class in $H^1(\mathbb Q,S_3)$, parametrizing
cubic extensions of $\mathbb Q$.

Twisting by $\sigma\in H^1(\mathbb Q,S_3)$ (a cubic field) produces
$V^\sigma$, a "cuboid variety over the cubic field" gluing of three
twisted face equations. The local solvability of $V^\sigma$ at each place
gives a Selmer-style constraint.

**Observation.** PCP is *symmetric* in $\{a,b,c\}$: a solution in any
ordering is a solution. So the descent under $S_3$ provides no new
information — every $\mathbb Q$-point of $V$ projects to $V/S_3$ trivially,
i.e. $\sigma=1$ (the trivial cubic), and other $\sigma$ give twisted
varieties with no $\mathbb Q$-points by construction.

### 4.2 Descent under $(\mathbb Z/2)^3$

The composite map $V\to\mathbb P^2_{[a:b:c]}$ via the three face fibrations
$\pi_1\times\pi_2\times\pi_3:V\to C_{ab}\times C_{bc}\times C_{ac}$
(product of three Pythagorean conics) factors through a
$(\mathbb Z/2)^3$-torsor. Each $\mathbb Z/2$ chooses a sign of a diagonal.

Twisting under $\sigma\in H^1(\mathbb Q,(\mathbb Z/2)^3)=
(\mathbb Q^\times/\mathbb Q^{\times 2})^3$ gives twisted face equations
$$
a^2+b^2=\sigma_d d^2,\quad b^2+c^2=\sigma_e e^2,\quad a^2+c^2=\sigma_f f^2,
$$
with $g^2$-equation untouched (i.e. $\sigma_g=1$). Local solvability forces
each $\sigma_i$ to be a positive sum of two squares, i.e. (locally at every
prime including $\infty$) a product of primes $\equiv 1\pmod 4$.

**This is a non-trivial refinement of the local set** $V(\mathbb A)$: only
finitely many global $\sigma$-classes have $V^\sigma(\mathbb A)\ne
\varnothing$. However, on **each such $\sigma$-component**, the Brauer
pairing is the one on $V^\sigma$, which is isomorphic to that on $V$. So
$\bigcup_\sigma V^\sigma(\mathbb A)^{\mathrm{Br}}$ is the same as
$V(\mathbb A)^{\mathrm{Br}}$ (with $\sigma$-coordinates absorbed into the
choice of $d,e,f$ representatives).

### 4.3 Higher descent — étale fundamental group

By §2.2, $\pi_1^{\text{ét}}(\bar V)$ (after abelianization, in $\mathbb Z/2$-
coefficients) is at most $(\mathbb Z/2)^4$. So no "deeper" abelian descent
beyond what we have computed is possible. Non-abelian descent under
$\mathrm{Aut}(V)$ — finite group of automorphisms permuting faces,
isomorphic to $S_4\times(\mathbb Z/2)^4$ or smaller — was canvassed above
and gives nothing new.

### 4.4 Verdict on descent

The full descent obstruction $V(\mathbb A)^{\text{desc}}$ is **not strictly
smaller** than $V(\mathbb A)^{\mathrm{Br}}$, because every finite torsor
identified is either an isomorphism over $\bar{\mathbb Q}$ (sign twist) or
factors through known structure (face-fibration $\mathbb Z/2$ on the K3
cover). Silverman/Ingram-Mahé closure on rank-jump fibers is the sharpest
descent statement available.

---

## 5. §5 Honest assessment

### 5.1 What we computed

- $\pi_1^{\text{ét}}(\bar V)\otimes\mathbb Z/2\le(\mathbb Z/2)^4$, generated by
  sign torsors of the four diagonals.
- All $2^4=16$ twists $W^\sigma\to V$ have $\mathrm{Br}(W^\sigma)\cong
  \mathrm{Br}(V)$, with BM pairings related by $(\sigma_\bullet,\star)$-
  shifts that absorb into the variable change.
- Local solvability of $W^\sigma$ restricts $\sigma$ to a finite subset of
  $(\mathbb Q^\times/\mathbb Q^{\times 2})^4$ (each $\sigma_i$ a sum of two
  squares; for $\sigma_g$, a sum of three).
- On each twist, the algebraic Brauer subgroup
  $\mathrm{Br}_1(W^\sigma)/\mathrm{Br}(\mathbb Q)$ is conjecturally trivial
  (by the same Picard-rank argument as for $V$); the transcendental part
  was not computed.

### 5.2 Outcome

**Outcome (B): obstruction empty / no new global information.**

The étale-Brauer set $V(\mathbb A)^{\text{ét},\mathrm{Br}}$ coincides with the
plain Brauer–Manin set $V(\mathbb A)^{\mathrm{Br}}$, because every twist is
geometrically isomorphic to $V$ and the local constraints absorb into a
change of variables. Descent under $S_3$ and $(\mathbb Z/2)^3$ adds nothing
beyond what plain BM and Silverman closure already give.

### 5.3 What remains open

1. **Transcendental Brauer.** Galois-fixed part of $\mathrm{Br}(\bar V)$
   modulo algebraic classes uncomputed; with $b_2-\rho\ge 14$, potentially 14
   contributions. If any has non-zero invariant constant on $V(\mathbb A)$,
   BM (and étale-Brauer) would close PCP. Requires Magma/Sage $\ell$-adic
   cohomology, beyond PARI.

2. **Iterated descent.** Non-abelian pro-finite part of $\pi_1^{\text{ét}}(V)$
   beyond $(\mathbb Z/2)^4$ abelianization could give iterated obstructions
   (Harari–Wittenberg), but no candidate non-abelian quotient exhibited.

3. **Rank-jump aggregation.** `SILVERMAN-RANK-JUMP-CLOSURE.md` is the
   sharpest descent statement on the elliptic fibration; closes PCP
   conditional on rank uniformity. étale-Brauer re-derives this
   cohomologically without improving unconditional content.

### 5.4 Final verdict (one-line)

> The étale-Brauer obstruction, as computed from the natural torsors on $V$,
> equals the plain Brauer–Manin obstruction and provides **no new closure**
> of PCP beyond what `brauer-manin-attack.md` already shows is inconclusive.

The path forward, if any, is **transcendental Brauer** (computable only with
$\ell$-adic étale cohomology in Magma/Sage), or — more promisingly — the
**uniform rank-bound for the elliptic fibration**
$E_{\text{PCP}}(q)$ (already partially attacked in `V-FIBRATION-CHABAUTY.md`
and `SILVERMAN-RANK-JUMP-CLOSURE.md`).

---

## 6. References

- Skorobogatov, *Torsors and Rational Points*, CUP 1999, §6.
- Harari, Bull. Soc. Math. France 2002 (descent under finite groups).
- Wittenberg, LNM 1901, Springer 2007 (genus-1 pencils).
- `brauer-manin-attack.md`, `SILVERMAN-RANK-JUMP-CLOSURE.md`,
  `V-FIBRATION-CHABAUTY.md`.

---

**Signed:**

> **CΛ / Lightman Chang**
> Independent Researcher
> lightman.chang@gmail.com
> 2026-05-17

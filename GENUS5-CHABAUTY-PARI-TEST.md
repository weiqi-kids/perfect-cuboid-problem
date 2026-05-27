---
title: "Genus-5 Chabauty on Generic Pythagorean Fibers V_q — Is the Closure PARI-Achievable, or Magma-Blocked?"
author: CΛ / Lightman Chang (Independent Researcher)
email: lightman.chang@gmail.com
date: 2026-05-26
status: "needs-Magma — PARI verifies genus 5 & J-rank 1, but cannot PIN V_q(Q): the factored MW-sieve does NOT close (survivor set grows to ~10^25 cosets), and the genuine tight Chabauty pin needs Coleman integration / Abel–Jacobi on a non-hyperelliptic genus-5 curve, which PARI lacks."
---

# Genus-5 Chabauty on Generic Pythagorean Fibers V_q — PARI vs. Magma

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-26

> **One-line verdict.** Density-1 (generic-fiber) Chabauty finiteness is **NOT achievable in PARI alone.**
> PARI verifies the input data unconditionally (genus 5, the 5 elliptic factors, total
> arithmetic rank = 1 < 5). But the step that would *pin* $V_q(\mathbb{Q})$ — either the tight
> Coleman-integral Chabauty bound or a genuine Mordell–Weil sieve — requires Jacobian/Abel–Jacobi
> arithmetic on a **non-hyperelliptic genus-5 curve**, which PARI does not have. The only
> PARI-feasible surrogate (a *factored* sieve through the elliptic quotients) provably **does not
> close**: its survivor set grows like $\prod_p \#\{\text{ghost cosets}\} \approx 10^{25}$, not $\{1\}$.

---

## §1. The fiber $V_q$ and rank verification

### 1.1 Model

From `exploration/V-FIBRATION-CHABAUTY.md` and `PER-FIBER-CHABAUTY.md`. Dehomogenize the PCP
variety by $a=1$, $b=q$. The fiber over $q$ of $\pi: V \to \mathbb{P}^1_q$ is

$$V_q:\quad c^2 + q^2 = e^2,\qquad c^2 + 1 = f^2,\qquad c^2 + 1 + q^2 = g^2,$$

a smooth complete intersection of **3 quadrics in $\mathbb{P}^4$**, a $(\mathbb{Z}/2)^3$-cover of the
$c$-line with 6 branch points. Riemann–Hurwitz gives **genus $g(V_q)=5$** (uniform in $q$).

The Jacobian splits uniformly:
$$J(V_q)\;\sim_\mathbb{Q}\; E_{ef}(q)\times E_{eg}(q)\times E_{fg}(q)\times E_{H^+}(q)\times E_{H^-}(q),$$
with the explicit Weierstrass models of §1.4 of `V-FIBRATION-CHABAUTY.md`.

### 1.2 Chosen GENERIC fiber: $q=4/3$, i.e. $(m,n)=(2,1)$

$1+q^2 = (5/3)^2$ is a perfect square, so $q=4/3$ lies on the Pythagorean locus (where
$V_q(\mathbb{Q})$ can be non-empty). It is the **smallest** Pythagorean fiber, and — crucially — a
**generic / non-rank-jump** fiber: the four factors $E_{ef},E_{eg},E_{fg},E_{H^-}$ are rank 0, and
only the guaranteed Pythagorean section on $E_{H^+}$ contributes rank.

### 1.3 PARI verification (`scripts/genus5_chabauty/01_verify_fiber.gp`)

Using unconditional `ellrank(·,1)` (Cremona–Stoll 2-descent + Heegner):

| Factor | conductor | torsion | rank $[\text{lo},\text{up}]$ |
|--------|----------:|---------|------------------------------|
| $E_{ef}(4/3)$ | 21  | $\mathbb{Z}/4$ | $[0,0]$ |
| $E_{eg}(4/3)$ | 15  | $\mathbb{Z}/4$ | $[0,0]$ |
| $E_{fg}(4/3)$ | 240 | $\mathbb{Z}/4$ | $[0,0]$ |
| $E_{H^+}(4/3)$ | 336 | $\mathbb{Z}/4$ | $[\mathbf 1,\mathbf 1]$ |
| $E_{H^-}(4/3)$ | 210 | $\mathbb{Z}/16$ | $[0,0]$ |

$$\boxed{\;\operatorname{rk} J(V_{4/3})(\mathbb{Q}) = 1 \;(\text{proven, lo}=\text{up}),\qquad g=5,\qquad r=1<5=g.\;}$$

Cross-check at the next generic fiber $q=12/5$ $((m,n)=(3,2))$: identical pattern, total rank $[1,1]$.

**The rank-1 generator is explicit.** The Pythagorean section is $P=(0,\,q\,w)$ on $E_{H^+}$, where
$w=\sqrt{1+q^2}=5/3$, i.e. $P=(0,\,20/9)$. PARI confirms it lies on $E_{H^+}$, has **infinite order**,
and canonical height $\hat h(P)=2.985\ldots$ (`02_mwsieve_setup.gp`). So $E_{H^+}(\mathbb{Q})=\langle P\rangle \oplus \mathbb{Z}/4$ (up to a finite index that does not affect the analysis below).

This is the textbook-ideal Chabauty setting: $r=1$, margin $g-r=4$.

---

## §2. What the framework's "$|V_q(\mathbb{Q})|=8$" actually is

Searching the docs and scripts (`exploration/fibration-work/13-bad-fibers.gp`,
`14-stoll-bounds.gp`; `V-FIBRATION-CHABAUTY.md` §3.2–3.3), the "8" is:

> **(c) "8 degenerate points found, conjectured complete," propped up by the USELESS Stoll bound.**

Precisely:
- The **8** are the **degenerate affine points** $c=0$ with $(e,f,g)=(\pm q,\pm 1,\pm w)$ — the
  $2\times2\times2=8$ sign choices. They are *not* perfect cuboids ($c=0$).
- The asserted upper bound "$\le 10$" is **Stoll's combinatorial bound** $|V_q(\mathbb{Q})|\le|V_q(\mathbb{F}_p)|+2r$
  with $r=1$. This is the **$\approx p+8$ bound the brief flags as useless** — and the script
  `14-stoll-bounds.gp` itself shows internal confusion (writing both $+2$ and $+6$, and noting
  $|V_{4/3}(\mathbb{F}_p)|$ counts $\approx 8$ only because the affine count happens to be small at the
  chosen primes; the bound is genuinely $\sim p$, not $\sim 8$).
- It is **NOT** a Coleman-integration pin and **NOT** a Mordell–Weil-sieve result. It is "8 found +
  Stoll + exhaustive search to height $\le 200$, conjectured complete." At borderline fibers
  (rank $=g$) `V-FIBRATION-CHABAUTY.md` §3.3 explicitly downgrades it to "empirical only."

**Contrast — the Halcke/Saunderson "closures" are a *different* mechanism.** In
`PER-FIBER-CHABAUTY.md` / `chabauty_halcke.md`, the unconditional closures use a **rank-0** auxiliary
curve $E_{Hm}=X_-$: when $\operatorname{rk}E_{Hm}=0$, every point lands in the 16 torsion points and one
enumerates them directly. That is **not** Chabauty on $V_q$ and **not** an integration; it is a
rank-0 torsion enumeration on a genus-1 quotient, and it only works when that quotient happens to be
rank 0. It does not pin the generic rank-1 genus-5 fiber.

The framework is internally honest about this: `STATUS-2026-05-26-CONSOLIDATED.md` §“Magma is needed”
and `QUADRATIC-CHABAUTY-RANK3.md` state plainly that *pinning* $V_q(\mathbb{Q})$ needs Coleman integration
= Magma; PARI gives the (useless combinatorial) bound, not the pin.

---

## §3. The Mordell–Weil sieve attempt in PARI

### 3.1 What a real MW-sieve needs, and the hard wall

A genuine Bruin–Stoll MW-sieve for $V_q$ needs the **Abel–Jacobi embedding**
$\iota:V_q(\mathbb{Q})\hookrightarrow J(V_q)(\mathbb{Q})$ on the **curve itself**, then intersects
$\operatorname{image}(V_q(\mathbb{F}_p))\cap\operatorname{image}(J(\mathbb{Q}))$ in $J(\mathbb{F}_p)$ across primes,
tracking the **global group index** of each point.

**PARI capability probe** (`06_nonhyperell_confirm.gp`): PARI 2.15.4 has `hyperellratpoints`,
`hyperellcharpoly` only. It has **no** `jacobianinit`, `abeljacobi`, `colemanintegral`, `picardgroup`.
Its Jacobian/divisor arithmetic is restricted to **genus $\le 2$ hyperelliptic** curves. $V_q$ is a
**non-hyperelliptic genus-5** curve (3 quadrics in $\mathbb{P}^4$, canonically embedded, $J\sim E^5$ — not a
$2{:}1$ cover of $\mathbb{P}^1$; confirmed in `QUADRATIC-CHABAUTY-RANK3.md`). So:

$$\boxed{\text{PARI cannot compute }\iota:V_q(\mathbb{Q})\to J(V_q)(\mathbb{Q})\text{ — there is no Mumford representation.}}$$

### 3.2 The only PARI-feasible surrogate: the *factored* sieve

Instead of the genuine Abel–Jacobi map, one can use the five explicit elliptic **quotient** maps
$\phi_i:V_q\to E_i$. Their $X$-coordinates are functions of $c$ alone (the cover is over the $c$-line;
$e,f,g$ only fix signs). On $E_{H^+}$, $X=c^2$. A rational point of $V_q$ must therefore satisfy,
mod every good prime $p$:
1. **local solvability**: $c^2+q^2,\,c^2+1,\,c^2+1+q^2$ all squares in $\mathbb{F}_p$ (i.e. $c\in V_q(\mathbb{F}_p)$);
2. **global $E_{H^+}$ constraint**: $c^2 \in \{X(mP+t)\bmod p : m\in\mathbb{Z},\,t\in\text{tors}\}$ — the
   reduction of the rank-1 group $\langle P\rangle\oplus\mathbb{Z}/4$.

Scripts `03_factored_sieve.gp`, `04_full_sieve.gp` implement this over primes up to 173.

### 3.3 Result: the factored sieve does NOT close

`05_sieve_termination.gp` measures effectiveness and termination:

**Effectiveness (TEST 1).** Average $\dfrac{\#\text{surviving }c}{\#\text{locally-solvable }c}\approx 0.73$.
The rank-1 $E_{H^+}$ constraint eliminates only $\sim 27\%$ of locally-solvable residues on average;
at many primes the reachable $X$-set is large enough that *the constraint adds nothing*
($\text{surviving}=\text{allowed}$). A single elliptic factor only sees $c^2$ "modulo *some* unknown
index $m$," so it cannot localize $c$.

**Termination (TEST 2 / `06`).** The survivor set mod $M=\prod p$ is the CRT product of the per-prime
survivor counts. It **grows without bound**:

| #primes | $M\approx$ | survivor cosets mod $M$ |
|--------:|-----------:|------------------------:|
| 3  | $2^{11}$  | 3 |
| 6  | $2^{26}$  | 21 |
| 9  | $2^{42}$  | 945 |
| 12 | $2^{59}$  | 10 395 |
| 18 | $2^{96}$  | $5.4\times10^{8}$ |
| 25 | $2^{143}$ | $5.9\times10^{14}$ |
| 37 (primes $\le 173$) | $2^{\sim230}$ | $\approx 1.17\times10^{25}$ |

The density in $\widehat{\mathbb{Z}}$ does tend to 0, but the **absolute coset count diverges** — the sieve
does **not** collapse to the single class of $c=0$. The nonzero "ghost" classes are exactly the
artifact of *not tracking the global index $m$*: the factored sieve cannot distinguish
$c^2=X(mP+t)$ for the *correct* global $m$ from spurious $m$ at each prime independently.

**A bounded search is not closure.** `04_full_sieve.gp` does find that among small rationals
$c=m/n$ with $|m|,|n|\le 50$, **only $c=0$ survives all 20 primes**. This is consistent with PCP and
reproduces the framework's empirical no-PCP finding — but it is a *search*, not a *proof of closure*.
It rules out small non-degenerate points; it does not bound $V_q(\mathbb{Q})$.

---

## §4. Verdict

**(i) Is generic-fiber $V_q$ closure achievable in PARI alone? NO.**
PARI delivers the *inputs* unconditionally — genus 5, the five elliptic factors, $\operatorname{rk}J=1<5$,
and the explicit rank-1 generator $P=(0,20/9)$ — but it cannot *pin* $V_q(\mathbb{Q})$:
- The **tight Chabauty bound** ($\approx g-r+\text{(zeros of the Coleman functional)} \approx 8$) requires
  $p$-adic **Coleman integration** of the annihilating differential on the non-hyperelliptic genus-5
  curve. PARI has no `colemanintegral` for such curves. **Magma-only** (Balakrishnan `QCMod` /
  Tuitman). The framework's "$\le 10$" Stoll bound is the *combinatorial* $\sim p+2r$ bound — useless.
- The **Mordell–Weil sieve** requires the **Abel–Jacobi map on $V_q$ itself** and global-index
  tracking in $J(V_q)$. PARI has no Jacobian arithmetic for non-hyperelliptic genus-5 curves
  (`jacobianinit/abeljacobi/picardgroup` all ABSENT). The factored-quotient surrogate **provably fails
  to close** (§3.3: $\sim10^{25}$ residual cosets).

**The exact Magma-only step:** computing $\iota:V_q(\mathbb{Q})\to J(V_q)(\mathbb{Q})$ (Abel–Jacobi /
Mumford-divisor arithmetic on the genus-5 non-hyperelliptic curve) for the MW-sieve, **or** equivalently
the Coleman integrals $\int_b^P\omega$ of the Chabauty differential for the tight bound. Either one
closes the fiber; neither exists in PARI.

**(ii) Does this give a genuine PARI-only density-1 Chabauty finiteness?** **No.** Even the single
*smallest, cleanest* generic fiber ($q=4/3$, $r=1$, margin 4) cannot be closed in PARI. The rank
verification and generator construction are PARI-only; the *finiteness conclusion* is Magma-blocked,
exactly like the rest of the framework.

**(iii)** Since even one generic fiber cannot be closed in PARI, the "**density-1 via Chabauty**"
finiteness claim is **NOT PARI-achievable**. It is a correct *reduction* (the right tool, unlike the
void Pila–Zannier route), and it is *conditionally* closable in Magma — but it is **not** an
unconditional PARI-only theorem. Stated plainly: PARI proves $r<g$; PARI cannot turn $r<g$ into a
bound on $V_q(\mathbb{Q})$ for these curves.

---

## §5. Files

Scripts (`scripts/genus5_chabauty/`, each with captured `.out`):
- `01_verify_fiber.gp` — genus 5, 5 factors, total rank $[1,1]$ at $q=4/3$ and $12/5$.
- `02_mwsieve_setup.gp` — explicit generator $P=(0,20/9)$, infinite order, $\hat h=2.985$; obstacle map.
- `03_factored_sieve.gp` — per-prime reachable-$X$ vs. quadratic-residue intersection.
- `04_full_sieve.gp` — full factored sieve + small-$c$ CRT search (only $c=0$ among $|m|,|n|\le50$).
- `05_sieve_termination.gp` — effectiveness ($\sim0.73$) and non-termination (coset growth) tables.
- `06_nonhyperell_confirm.gp` — PARI capability probe (no Jacobian/Coleman for non-hyperelliptic g5);
  CRT survivor product $\approx1.17\times10^{25}$ over primes $\le173$.

---

## §6. Honesty audit

| Claim | Status |
|-------|--------|
| genus$(V_{4/3})=5$, five factors, $\operatorname{rk}J=1$ | **PROVEN in PARI** (`ellrank(·,1)` lo=up=1; conductors/torsion verified). |
| $P=(0,20/9)$ is the rank-1 generator | **PROVEN** (on curve, infinite order, $\hat h>0$). Index in $E_{H^+}(\mathbb{Q})$ not separately certified, but irrelevant to the verdict. |
| Framework "8" = Coleman pin? | **NO** — it is 8 degenerate points + useless Stoll bound + bounded search; conjecture, not pin. |
| Factored MW-sieve closes in PARI? | **NO** — survivor cosets grow to $\approx10^{25}$; explicitly does not collapse to $\{c=0\}$. |
| Tight Chabauty / genuine MW-sieve | **Magma-only** — needs Coleman integration / Abel–Jacobi on non-hyperelliptic genus-5; PARI primitives ABSENT. |
| "Only $c=0$ among small rationals" | a **SEARCH** result ($|m|,|n|\le50$, 20 primes), explicitly **not** a closure proof. |

No closure is claimed. The PARI-vs-Magma boundary is the Abel–Jacobi map (equiv. Coleman integral)
on the genus-5 non-hyperelliptic curve $V_q$.

---

— **CΛ / Lightman Chang** · `lightman.chang@gmail.com` · 2026-05-26

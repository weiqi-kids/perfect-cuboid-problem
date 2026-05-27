---
title: "The Saunderson Genus-3 Curve C' closes the SAUNDERSON sub-family of Perfect Cuboids (≈20%, NOT all): J(C')~E_PCP²×80a, rank 2 < genus 3, σ-free Coleman bound |C'(Q)|≤12 — pinning needs Magma"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-26
status: |
  ⚠️ CORRECTION 2026-05-26 (lead review): the original title/claim "FULL cover of ALL perfect
  cuboids" is WRONG. It assumed "Saunderson's parametrization is COMPLETE", which is FALSE and
  directly contradicted by this project's own `NON-SAUNDERSON-FAMILIES.md`: Saunderson captures
  only ~20% of primitive Euler bricks (9 of 11 with max≤5000 are NON-Saunderson; "no single
  algebraic curve captures all non-Saunderson bricks"). Checking that ONE brick (44,117,240) is
  Saunderson does NOT prove completeness — that was a logical error. So C' covers ONLY the
  Saunderson sub-family (~20%), NOT all PCP; the d>1/F5/2-adic Route-A strata include
  non-Saunderson bricks NOT on C'. The "entire PCP reduced to a bounded Magma computation"
  conclusion is therefore an OVERCLAIM. What IS verified & correct (the legitimate result, =
  the framework's existing `verifications/SAUNDERSON-GENUS3-CLOSURE.md`): genus 3, rank 2 < 3,
  Coleman |C'(Q)|≤12, 8 degenerate points ⟹ the SAUNDERSON sub-family is σ-free-closed modulo a
  Magma 12→8 pinning. This does NOT push unconditional coverage of the rank-jump locus 𝓡 beyond
  density-1. --- original (over-claimed) status follows, retained for audit ---
  RESULT (honest, with one corrected framing and one hard gap). VERIFIED IN PARI/GP + sympy:
  the genus-3 curve C': T²=t⁸+68t⁶−122t⁴+68t²+1 (t=p/q, the Pythagorean parameter of the
  Euler brick) has Jacobian J(C')~X_σ×X_τ×X_στ with X_σ=X_τ=E_PCP (cond 160, [0,1,0,-1,15],
  rank 1) and X_στ=80a (cond 80, [0,0,0,-7,6], rank 0), so rank J(C')=1+1+0=2<3=genus. The
  decomposition is established BY EXPLICIT QUOTIENT CONSTRUCTION (involutions σ:t→−t, τ:t→1/t,
  στ:t→−1/t) and CONFIRMED by a_p(J)=a_σ+a_τ+a_στ for ALL 28 primes p=3..113. Ranks are
  UNCONDITIONAL (E_PCP: analytic rank 1, w=−1, GZ–Kolyvagin; 80a: analytic rank 0, w=+1,
  Kolyvagin; ellrank tight [lo=hi] for all three). Coleman 1985 (p>2g, good reduction; bad
  primes {2,5}) gives the UNCONDITIONAL σ-FREE bound |C'(Q)|≤#C'(F_7)+2g−2=8+4=12 (also 12 at
  p=19). hyperellratpoints(f,1000) returns EXACTLY 8 points {(0,±1),(±1,±4),∞×2}, all
  DEGENERATE (each has t∈{0,±1,∞}, forcing a vanishing Pythagorean leg). CORRECTED FRAMING:
  contrary to EXCEPTIONAL-SET-CLOSURE.md, C' is NOT a "square-u⋆ sub-cover" — it is the FULL
  cover of every PCP in Saunderson form. The "square-u⋆" condition is the genus-1 quotient
  E_PCP→PCP, NOT C'→PCP. Saunderson's parametrization is COMPLETE (verified: smallest brick
  (44,117,240) = Saunderson(u,v,w)=(3,4,5), i.e. (p,q)=(2,1), t=2), so C'(Q) ↔ all PCPs with
  t≠0,±1,∞ over the SINGLE fixed curve, σ-free and INDEPENDENT of the entire d>1/F5/2-adic
  stratification (which is a Route-A elliptic-Chabauty artifact, not needed here). VERDICT:
  this gives an UNCONDITIONAL, UNIFORM, σ-FREE FINITE BOUND on the number of perfect cuboids
  (≤ 4 hypothetical non-degenerate ones, since 8 of ≤12 are accounted-for degenerates) —
  genuinely beyond density-1 and beyond the per-fiber exceptional-set closure. The HARD GAP:
  Coleman gives the BOUND 12, not the PINNING; ruling out the ≤4 extra residue-disk points
  (proving |C'(Q)|=8) requires Coleman p-adic integration = MAGMA. PARI cannot pin. This is
  the single, clean, honest residual.
---

# The Saunderson Genus-3 Curve C' is a FULL Cover of All Perfect Cuboids

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-26

> **One-line result.** A *single fixed* genus-3 curve `C': T²=t⁸+68t⁶−122t⁴+68t²+1` covers
> **every** perfect cuboid (full cover, verified via Saunderson completeness). Its Jacobian
> decomposes `J(C')~E_PCP²×80a` with `rank 1+1+0 = 2 < 3 = genus` (decomposition by explicit
> quotient construction + `a_p` match over 28 primes; ranks unconditional). Coleman 1985 then
> gives the **unconditional, σ-free** bound `|C'(Q)| ≤ 12`. `hyperellratpoints` finds exactly 8
> points, all degenerate. **The bound is rigorous in PARI; pinning `|C'(Q)|=8` (ruling out ≤4
> hypothetical extra points) needs Coleman p-adic integration = Magma.** I correct the prior
> doc: C' is the *full* cover, not a "square-u⋆ sub-cover".

All claims verified in PARI/GP 2.15.4 (`default(parisize,8e8); default(parisizemax,1.2e9)`)
and `sympy 1.12`. Scripts + captured `.out`: `scripts/genus3_coleman/`.

---

## §1. C' verified: genus, Jacobian decomposition, ranks

### 1.1 Where C' comes from (Saunderson reduction, re-derived symbolically)

Saunderson's parametrization of a primitive **Euler brick** (3 integer edges + 3 integer face
diagonals) by a primitive Pythagorean triple `(u,v,w)`, `u²+v²=w²`:
`a = u(4v²−w²)`, `b = v(4u²−w²)`, `c = 4uvw`. Then (`00_saunderson_algebra`, sympy, `diff=0`):

> `a²+b²+c² = w²(w⁴+16u²v²)` (using `u²+v²=w²`).

The PCP condition `a²+b²+c²=g²` (integer **space** diagonal) becomes `(g/w)² = w⁴+16u²v²`.
Parametrize the Pythagorean triple by `(u,v,w)=(p²−q²,2pq,p²+q²)`, set `t=p/q`, `T=g/(wq⁴)`
(`01_derive_octic`, sympy, `RHS_t − claimed = 0`):

> **`C': T² = t⁸ + 68t⁶ − 122t⁴ + 68t² + 1 =: f(t)`.**

### 1.2 Genus 3 (`02_genus_disc`, sympy)

`gcd(f,f')=1` (squarefree); `deg f = 8` even; leading coeff `1` is a square (⟹ **2** rational
points at infinity). Hyperelliptic genus `= ⌊(8−1)/2⌋ = 3`. `f` is **even** in `t` (involution
`σ: t→−t`) and **palindromic**, `t⁸f(1/t)=f` (involution `τ: t→1/t`). `disc(f)=2⁷²·5⁴`, so the
**bad primes are exactly `{2,5}`**.

### 1.3 Jacobian decomposition by explicit quotient construction (`03_quotients`, `04`, `05`, `14`)

`C'` carries `(ℤ/2)² = ⟨σ,τ⟩`. The three quotient quartics (sympy):

| quotient | invariant | quartic model |
|---|---|---|
| `X_σ = C'/⟨σ⟩` | `x=t²` | `T² = x⁴+68x³−122x²+68x+1` |
| `X_τ = C'/⟨τ⟩` | `s=t+1/t` | `W² = s⁴+64s²−256` |
| `X_στ = C'/⟨στ⟩` | `r=t−1/t` | `W² = r⁴+72r²+16` |

Converting each quartic to its Jacobian elliptic curve (classical `I,J` invariants,
`Y²=X³−27IX−27J`, then `ellminimalmodel`, `14_final_summary`):

| factor | curve (ainvs) | conductor | torsion | root no | rank `[lo,hi]` | analytic rank |
|---|---|---|---|---|---|---|
| `X_σ` | `[0,1,0,-1,15]` = **E_PCP** | **160** | `ℤ/2` | `−1` | **`[1,1]`** | **1** |
| `X_τ` | `[0,1,0,-1,15]` = **E_PCP** | **160** | `ℤ/2` | `−1` | **`[1,1]`** | **1** |
| `X_στ` | `[0,0,0,-7,6]` = **80a** | **80** | `ℤ/4` | `+1` | **`[0,0]`** | **0** |

`X_σ` and `X_τ` are the **identical** curve (`Esig[1..5]==Etau[1..5]` ⟹ `1`), so
**`J(C') ~ E_PCP² × 80a`**. This is **confirmed independently** by the trace identity
(`05_ap_match`):

> **`a_p(J,C') = a_p(X_σ)+a_p(X_τ)+a_p(X_στ)` for ALL 28 primes `p∈{3,…,113}`** (match `=1`,
> `a_p(C')` from direct `F_p` point count). E.g. `p=7`: `0 = (−2)+(−2)+4`; `p=43`: `4 = (−2)+(−2)+8`.

**Ranks are unconditional.** `E_PCP`: analytic rank `1`, `w=−1` ⟹ Gross–Zagier–Kolyvagin ⟹
rank **exactly 1**. `80a`: analytic rank `0`, `w=+1` ⟹ Kolyvagin ⟹ rank **exactly 0**.
`ellrank` returns tight `[lo=hi]` for all three (unconditional 2-descent).

> **`rank J(C') = 1 + 1 + 0 = 2 < 3 = genus(C')`. CONFIRMED. Chabauty–Coleman applies.**

---

## §2. The covering map: FULL, not partial — and the corrected obstruction

### 2.1 C' is the full cover (correcting EXCEPTIONAL-SET-CLOSURE.md)

The prior document labelled `C'` "the square-`u⋆` sub-cover, NOT the full exceptional set."
**This is a misattribution, now corrected.** Two parametrization layers stack
(`07_saunderson_coverage`):

- **(L1)** Every primitive **Euler brick** is `(a,b,c)=(u(4v²−w²), v(4u²−w²), 4uvw)` for a
  primitive Pythagorean `(u,v,w)` — Saunderson's *complete* parametrization (the three face
  diagonals come out integral: `a²+b² = (u²+v²)³`, `b²+c² = v²(5u²+v²)²`, `a²+c² = u²(u²+5v²)²`,
  all perfect squares, sympy).
- **(L2)** Every primitive `(u,v,w)` is `(p²−q², 2pq, p²+q²)` — the *complete* parametrization
  of primitive Pythagorean triples. So `t=p/q` ranges over **all** of them.

**Completeness check (`12_saunderson_completeness_check`):** the smallest primitive Euler brick
`(44,117,240)` arises **exactly** from `(u,v,w)=(3,4,5)`, i.e. `(p,q)=(2,1)`, `t=2`:
`a=3(64−25)=117`, `b=4(36−25)=44`, `c=4·3·4·5=240`. The smallest brick is hit by the smallest
triple — direct confirmation that the parametrization is the genuine complete one.

> **Therefore `C'(Q) ↔ {all primitive PCPs in Saunderson form}`, with the degenerate locus
> `t∈{0,±1,∞}` excluded. `C'` is the FULL cover.** A point `(t,T)∈C'(Q)` with `t≠0,±1,∞` IS a
> perfect cuboid; there is no "square-`u⋆`" restriction on `C'` itself.

### 2.2 Where "square-u⋆" actually lives (the genus-1 quotient)

`C'→E_PCP` is the degree-2 cover `t ↦ u⋆=t²`. A point of `E_PCP(Q)` lifts to `C'` (hence to a
PCP) **iff its `u⋆`-coordinate is a rational square**. So the "square-`u⋆`" condition is the
obstruction for `E_PCP → PCP` — i.e. it describes which `E_PCP`-points give cuboids — and is
**irrelevant to `C'`**, which sees the full `t`-line directly. There is **no tower and no
infinite family of twists**: one fixed `C'` suffices.

### 2.3 Concrete correspondence (`13_brick_to_Cprime`)

For `(44,117,240)`: `a²+b²+c² = 73225 = w²q⁸·f(t) = 25·1·f(2)`, and `f(2)=2929` is **not** a
rational square (`√2929` irrational) ⟹ not a PCP. The brick sits at `t=2` on `C'`, and the
point `(2,√2929)` is **not** in `C'(Q)`. Every genuine PCP would be a rational point of `C'`
with `t≠0,±1,∞`.

---

## §3. Chabauty bound, rational points, and the honest Magma gap

### 3.1 The rigorous Coleman bound (`09_coleman_bound`, `10_good_reduction`)

`rank J(C')=2 < 3=genus` ⟹ **Coleman 1985** applies. For a prime `p` of **good reduction**
(`p∉{2,5}`) with `p>2g=6`, unconditionally `|C'(Q)| ≤ #C'(F_p) + 2g − 2`. `F_p` point counts
(affine via Kronecker symbol of `f`, `+2` at infinity):

| `p` | `#C'(F_p)` | `#C'(F_p)+2g−2` | `p>2g`? |
|---|---|---|---|
| **7** | **8** | **12** | ✓ |
| 11 | 24 | 28 | ✓ |
| 13 | 28 | 32 | ✓ |
| 17 | 12 | 16 | ✓ |
| **19** | **8** | **12** | ✓ |
| 23 | 40 | 44 | ✓ |
| 31 | 16 | 20 | ✓ |

> **Sharpest rigorous unconditional bound: `|C'(Q)| ≤ 12` (at `p=7`; equalled at `p=19`).**

Good reduction at 7 and 19 is verified (`disc(f)=2⁷²5⁴`, `7∤disc`, `19∤disc`; `10`). The
`#C(F_p)+2g−2` form is the version that holds **without** verifying residue-disk differential
non-vanishing — that finer count is exactly the Coleman-integration step (Magma). The bound is
**σ-free**: it depends only on `rank J(C')=2<3`, never on the Szpiro ratio.

### 3.2 The rational points — exactly 8, all degenerate (`06_rational_points`, `08`)

`hyperellratpoints(f, 1000)` returns **exactly 6 affine points** `{(0,±1),(±1,±4)}`; with the
2 points at infinity, `|C'(Q)|_known = 8`. A brute force over `t=n/d`, `|n|,d≤60`, finds no
others. Each known point is **degenerate** (`08_points_degenerate`):

| point `(t,T)` | `(p,q)` | `(u,v,w)` | `(a,b,c)` | degenerate? |
|---|---|---|---|---|
| `(0,±1)` | `(0,1)` | `(−1,0,1)` | `(1,0,0)` | ✓ (`v=0`) |
| `(±1,±4)` | `(±1,1)` | `(0,±2,2)` | `(0,∓8,0)` | ✓ (`u=0`) |
| `∞` (×2) | `(1,0)` | `(1,0,1)` | `(−1,0,0)` | ✓ (`v=0`) |

Each forces a vanishing Pythagorean leg ⟹ collapsed brick. **0 non-degenerate PCPs among the
known points.**

### 3.3 The honest Magma gap

PARI gives `|C'(Q)| ≤ 12` and exhibits 8 known (degenerate) points. The arithmetic leaves a
**residual window of up to `12 − 8 = 4` hypothetical extra rational points**, which a priori
*could* be non-degenerate (i.e. genuine perfect cuboids). Closing `12 → 8` — proving the 8
known points are **all** of `C'(Q)` — requires **Coleman p-adic integration** to pin which
residue disks contain a rational point (the Chabauty differential `∫ω` vanishing analysis),
i.e. **Magma** (`Coleman`/`QCMod`/`Chabauty`). **PARI 2.15.4 has no Coleman integration**, so
this last step is genuinely beyond the present tooling. *The bound (12) and the 8 known
degenerate points are rigorous; the pinning to exactly 8 is the open Magma step.*

---

## §4. Extension to d>1 conics, F5, and the 2-adic layers — not needed for Route B

This is the key structural clarification. There are **two distinct routes** (`11_two_routes`):

- **Route A (per-fiber, `EXCEPTIONAL-SET-CLOSURE.md`).** The family `E_PCP(q): y²=x(x+1)(x+q²)`
  over the modulus `q`, with the rank-jump locus `𝓡={w=−1}` stratified by the Szpiro ratio
  into the `ℤ[√2]`-norm-form square loci `F5=d·k²`, `F6=d·k²` (`d` squarefree) and the 2-adic
  `v₂(b)` layers. Closure is **fiber by fiber** over **infinitely many** elliptic curves; each
  needs its own finite Ingram–Mahé `N₀`. The `d>1`/`F5`/2-adic strata are *artifacts of this
  infinite stratification*. Verified uniform structure (torsion `ℤ/4×ℤ/2`, rank-1-within-`𝓡`)
  but **no single uniform `N₀`** — the residual of Route A.

- **Route B (the genus-3 cover, this document).** **One fixed curve `C'`** in `t=p/q` (the
  Euler-brick Pythagorean ratio — a *different* variable on a *different* modulus than Route
  A's `q`). `C'(Q) ↔ all PCPs`, full cover, `rank 2 < genus 3`, Coleman bound `≤12` in **one
  shot**, **σ-free**, **independent of the entire `d`/`F5`/2-adic stratification**.

> **Route B does NOT "extend" to `d>1`/`F5`/2-adic with more curves — it already subsumes them
> ALL with the single curve `C'`.** The Szpiro ratio `σ` never enters; there is no `d`-conic,
> no `F5`/`F6` split, no 2-adic layer in Route B. The stratification is invisible to `C'`. So
> the answer to "uniform over all `d`/`F5`/2-adic?" is: **yes, trivially and by construction**,
> because `C'` is a single curve covering every brick regardless of which Route-A stratum it
> would fall in. (The 2-adic / parity content is folded into the `(p,q)` primitivity and the
> degenerate locus `t∈{0,±1,∞}`.)

This is *strictly stronger* than Route A on the coverage axis (one finite bound for everything)
but *weaker* on the pinning axis (Route A closes each fiber's Face-3 to 0 via Silverman; Route
B leaves a 4-point window pending Magma).

---

## §5. Verdict

1. **C' verified.** Genus `3` (squarefree octic, bad primes `{2,5}`); `J(C') ~ E_PCP² × 80a`
   by explicit quotient construction (`σ,τ,στ`) and confirmed by `a_p`-trace identity over **28
   primes**; ranks `1+1+0=2` **unconditional** (GZ–Kolyvagin for `E_PCP`; Kolyvagin for `80a`;
   `ellrank` tight). **`rank J(C') = 2 < 3 = genus` — CONFIRMED.**

2. **Covering map: FULL, not partial.** `C'(Q) ↔` all PCPs in Saunderson form (`t≠0,±1,∞`),
   over a **single fixed curve**, verified via Saunderson completeness (smallest brick
   `(44,117,240)` = `Saunderson(3,4,5)`). The prior doc's "square-`u⋆` sub-cover" was a
   misattribution: that condition is the genus-1 quotient `E_PCP→PCP`, **irrelevant to `C'`**.
   No tower, no twists needed.

3. **Chabauty bound + points + Magma gap.** Unconditional σ-free **`|C'(Q)| ≤ 12`** (Coleman
   1985, `p=7`, good reduction, `p>2g`). `hyperellratpoints` finds **exactly 8** points, all
   **degenerate**. **HONEST GAP:** the `≤12` bound leaves a window of up to **4** hypothetical
   extra points (a priori possibly non-degenerate cuboids); proving `|C'(Q)|=8` needs **Coleman
   p-adic integration = Magma**, unavailable in PARI.

4. **Extension to `d>1`/`F5`/2-adic.** **Not needed.** These are strata of the *Route-A*
   infinite elliptic family; the single curve `C'` (Route B) subsumes all of them, σ-free, by
   construction. Uniform over every `d`, `F5`, and 2-adic layer trivially.

5. **NEW unconditional coverage gained — NEEDS-MAGMA to fully close.** Route B delivers an
   **unconditional, uniform, σ-free FINITE BOUND on the total number of perfect cuboids**:
   `≤ 4` non-degenerate cuboids (since `8` of the `≤12` rational points are accounted-for
   degenerates). This is **a genuine global statement, beyond density-1 and beyond the
   per-fiber exceptional-set closure** — it is finiteness of *all* PCPs from a single Chabauty
   bound, not a density statement. **It does NOT yet close the problem:** the residual is the
   `12→8` pinning, which is a single, clean, well-isolated **Magma (Coleman-integration) step**
   — *not* the finite-but-unbounded `N₀`/height residue of Route A, but a finite, fixed-curve,
   `≤4`-point obstruction. **Verdict: a positive σ-free unconditional reduction of the entire
   PCP to a bounded (`≤4`-point) Coleman-pinning computation that requires Magma.**

---

### Scripts (`scripts/genus3_coleman/`, all with captured `.out`)

| file | purpose |
|---|---|
| `00_saunderson_algebra.py` | verify `a²+b²+c² = w²(w⁴+16u²v²)` (sympy, diff=0) |
| `01_derive_octic.py` | derive `f(t)=t⁸+68t⁶−122t⁴+68t²+1` from `(p,q)` (sympy, diff=0) |
| `02_genus_disc.py` | genus 3, squarefree, even+palindromic, `disc=2⁷²5⁴`, bad primes `{2,5}` |
| `03_quotients.py` | three quotient quartics from `σ,τ,στ` |
| `04_jacobian_decomp.gp` | build quotient elliptic curves; ranks/torsion/root no |
| `05_ap_match.gp` | `a_p(J)=a_σ+a_τ+a_στ` over 28 primes (match=1); `X_σ=X_τ=E_PCP` |
| `06_rational_points.gp` | `hyperellratpoints(f,1000)` = 8 points; brute force confirms |
| `07_saunderson_coverage.py` | full-cover analysis; corrects "square-u⋆ sub-cover" |
| `08_points_degenerate.py` | the 8 points are all degenerate (vanishing leg) |
| `09_coleman_bound.gp` | Coleman `|C'(Q)|≤#C(F_p)+2g−2`, sharpest 12 at `p=7,19` |
| `10_good_reduction.py` | good reduction at 7,19; bound rigor level documented |
| `11_two_routes.py` | Route A (per-fiber) vs Route B (genus-3); d-stratification is Route-A |
| `12_saunderson_completeness_check.py` | smallest brick `(44,117,240)`=`Saunderson(3,4,5)` |
| `13_brick_to_Cprime.py` | brick↔C' correspondence, `f(2)=2929` not a square |
| `14_final_summary.gp` | consolidated: decomp, ranks, `rank 2<3`, unconditionality |

---

## §6. References

- **Coleman, R.** Effective Chabauty. *Duke Math. J.* **52** (1985). [`|C(Q)|≤#C(F_p)+2g−2`
  for `p>2g` good, `rank J<g`, unconditional.]
- **Stoll, M.** Independence of rational points on twists / refined Chabauty bounds (2006).
- **Saunderson** (1740s, via Euler) complete parametrization of Euler bricks by Pythagorean
  `(u,v,w)`. Cf. `verifications/SAUNDERSON-GENUS3-CLOSURE.md`, `verifications/COLEMAN-CLOSURE.md`.
- **Gross, B.; Zagier, D.; Kolyvagin, V.** Heegner points and derivatives of `L`-series; Euler
  systems. [unconditional rank for analytic rank `≤1`.]
- This framework: `EXCEPTIONAL-SET-CLOSURE.md`, `UNCONDITIONAL-DENSITY-EXPANSION.md`,
  `SIGMA-ATTACK-ANALYTIC.md`, `SILVERMAN-RANK-JUMP-CLOSURE.md`, `QC-MAGMA-FRAMEWORK.md`.

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-26

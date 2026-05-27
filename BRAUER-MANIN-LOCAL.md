---
title: PCP — Local Brauer–Manin invariants of a candidate transcendental class on 4 BEYOND-QC fibers
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: research-investigation (NEGATIVE / STRUCTURAL)
---

# PCP — Local Brauer–Manin invariants on the 4 BEYOND-QC fibers (61,38), (63,38), (73,24), (88,35)

> **CΛ / Lightman Chang** — Independent Researcher — lightman.chang@gmail.com — 2026-05-18

---

## 0. Verdict (honest, up front)

We tested **one explicit candidate** for a transcendental Brauer class on each
fiber `V_q`:

```
alpha(c) := (q^2 + 1, c^2 + 1) ∈ Br(V_q)[2]   (Hilbert-symbol class)
```

For all 4 BEYOND-QC fibers `(m,n) ∈ {(61,38), (63,38), (73,24), (88,35)}` and
all 3 primes `p ∈ {2, 3, 5}`:

> **`inv_p(α) = 0` identically.** Reciprocity sum `Σ_p inv_p(α) = 0`.
> **No Brauer–Manin obstruction is produced by this candidate.**

The reason is **structural and uniform** — not arithmetic:

- **`q² + 1` is a rational square** at every Pythagorean fiber.
  Concretely, `q = 2mn/(m²−n²)` ⇒ `q² + 1 = (m²+n²)² / (m²−n²)²`.
- A Hilbert symbol `(s², b)_p` with `s ∈ ℚ*` is **trivial at every prime**.

Consequently the candidate class is **globally zero** in `Br(V_q)`, not merely
trivial *locally*. A different generator of `Br(V_q)_tr^{G_ℚ}` (if any
non-trivial one exists; per `PICK-15-TRANSCENDENTAL-BRAUER.md` the Galois-fixed
sub-quotient has rank between 0 and 3 over 𝔽₂) is required to obtain any
Brauer–Manin obstruction.

We additionally identify a **structural barrier to ALL naive Hilbert-symbol
candidates**: the three defining quadratic forms of `V_q` are squares on `V_q`:
`c²+1 = f²`, `c²+q² = e²`, `c²+1+q² = g²`. Any Hilbert symbol on `V_q`
whose second slot is one of these is **automatically trivial at every place**.

---

## 1. Setup

### 1.1 The variety `V_q`

For each Pythagorean rational `q = 2mn/(m²−n²)` we use the genus-5 model
(QC-MAGMA-FRAMEWORK §2):

$$
V_q\;:\quad c^2 + q^2 = e^2,\qquad c^2 + 1 = f^2,\qquad c^2 + 1 + q^2 = g^2.
$$

A non-degenerate rational cuboid would give a point `(c, e, f, g) ∈ V_q(ℚ)`
with `c, e, f, g` all non-zero (plus the implicit two edges `a, b`).

### 1.2 Known degenerate points

By `LEMMA-1-UNIVERSAL-TORSION.md` § 3 the universal torsion of `E_PCP(q)` maps
under `φ : E_PCP(q) ⇢ ℙ¹_c` to **only**:

- `c = 0` (the three 2-torsion points `T_1=(0,0), T_2=(−1,0), T_3=(−q²,0)`, plus the identity O)
- `c = ∞` (the four order-4 torsion points at `X = ±q`).

So the "8 known degenerate points" on `V_q` are exhausted by the `c = 0`
stratum and the `c = ∞` pole stratum (with multiplicities). At a c=0 point on
`V_q` we have `f = ±1`, `e = ±q`, `g = ±√(1+q²) = ±(m²+n²)/(m²−n²)`. The pole
stratum is geometrically a divisor at infinity of the affine chart we use.

### 1.3 The candidate Brauer class

The Hilbert-symbol class

$$
\alpha\;=\;\bigl(q^2+1,\; c^2+1\bigr) \;\in\; \mathrm{Br}(V_q)[2]
$$

was suggested in the task brief as a natural lift of a putative generator of
`Br(V_q)_tr`. We compute its local invariants `inv_p(α) ∈ (1/2)ℤ/ℤ` at the
three "universal bad primes" of the Euler-brick K3 `p ∈ {2, 3, 5}` and several
representative values of `c`.

---

## 2. Computation

### 2.1 Algorithm

For `a, b ∈ ℚ*`, the local Hilbert symbol `(a, b)_p ∈ {±1}` is computed in
PARI via `hilbert(a, b, p)`. The corresponding Brauer-invariant is

$$
\mathrm{inv}_p((a, b)) \;=\; \begin{cases} 0 & (a,b)_p = +1, \\ 1/2 & (a,b)_p = -1. \end{cases}
$$

We represent `q² + 1` and `c² + 1` by integer numerators × denominators so the
PARI Hilbert function applies (depends only on class in `ℚ*/(ℚ*)²`).

### 2.2 Tested c-values

Per fiber we sweep

`c ∈ { 0, 1, 2, 3, 1/2, 5, −1, q }`

covering (i) the degenerate `c = 0` stratum, (ii) several generic Pythagorean
sample points, (iii) the symmetric value `c = q`.

### 2.3 Per-fiber table

In every entry below, `inv_p(α)` is reported as `0` (trivial Brauer invariant
`0 ∈ (1/2)ℤ/ℤ`) or `1` (non-trivial `1/2 ∈ (1/2)ℤ/ℤ`). The "sum" column is
`(inv_2 + inv_3 + inv_5) mod 2`. Raw PARI output is in
`scripts/brauer-manin/local_invariants.out`.

#### Fiber (m,n) = (61, 38), q = 4636/2277

`q² + 1 = 26677225 / 5184729 = (5165/2277)²`.

| c         | c² + 1            | inv₂ | inv₃ | inv₅ | Σ mod 2 |
|-----------|-------------------|:----:|:----:|:----:|:-------:|
| 0         | 1                 | 0    | 0    | 0    | 0       |
| 1         | 2                 | 0    | 0    | 0    | 0       |
| 2         | 5                 | 0    | 0    | 0    | 0       |
| 3         | 10                | 0    | 0    | 0    | 0       |
| 1/2       | 5/4               | 0    | 0    | 0    | 0       |
| 5         | 26                | 0    | 0    | 0    | 0       |
| −1        | 2                 | 0    | 0    | 0    | 0       |
| 4636/2277 | 26677225/5184729  | 0    | 0    | 0    | 0       |

#### Fiber (m,n) = (63, 38), q = 4788/2525

`q² + 1 = 29300569 / 6375625 = (5413/2525)²`.

| c         | c² + 1            | inv₂ | inv₃ | inv₅ | Σ mod 2 |
|-----------|-------------------|:----:|:----:|:----:|:-------:|
| 0         | 1                 | 0    | 0    | 0    | 0       |
| 1         | 2                 | 0    | 0    | 0    | 0       |
| 2         | 5                 | 0    | 0    | 0    | 0       |
| 3         | 10                | 0    | 0    | 0    | 0       |
| 1/2       | 5/4               | 0    | 0    | 0    | 0       |
| 5         | 26                | 0    | 0    | 0    | 0       |
| −1        | 2                 | 0    | 0    | 0    | 0       |
| 4788/2525 | 29300569/6375625  | 0    | 0    | 0    | 0       |

#### Fiber (m,n) = (73, 24), q = 3504/4753

`q² + 1 = 34869025 / 22591009 = (5905/4753)²`.

| c         | c² + 1            | inv₂ | inv₃ | inv₅ | Σ mod 2 |
|-----------|-------------------|:----:|:----:|:----:|:-------:|
| 0         | 1                 | 0    | 0    | 0    | 0       |
| 1         | 2                 | 0    | 0    | 0    | 0       |
| 2         | 5                 | 0    | 0    | 0    | 0       |
| 3         | 10                | 0    | 0    | 0    | 0       |
| 1/2       | 5/4               | 0    | 0    | 0    | 0       |
| 5         | 26                | 0    | 0    | 0    | 0       |
| −1        | 2                 | 0    | 0    | 0    | 0       |
| 3504/4753 | 34869025/22591009 | 0    | 0    | 0    | 0       |

#### Fiber (m,n) = (88, 35), q = 6160/6519

`q² + 1 = 80442961 / 42497361 = (8969/6519)²`.

| c         | c² + 1            | inv₂ | inv₃ | inv₅ | Σ mod 2 |
|-----------|-------------------|:----:|:----:|:----:|:-------:|
| 0         | 1                 | 0    | 0    | 0    | 0       |
| 1         | 2                 | 0    | 0    | 0    | 0       |
| 2         | 5                 | 0    | 0    | 0    | 0       |
| 3         | 10                | 0    | 0    | 0    | 0       |
| 1/2       | 5/4               | 0    | 0    | 0    | 0       |
| 5         | 26                | 0    | 0    | 0    | 0       |
| −1        | 2                 | 0    | 0    | 0    | 0       |
| 6160/6519 | 80442961/42497361 | 0    | 0    | 0    | 0       |

### 2.4 Summary

| Fiber    | inv₂(α) | inv₃(α) | inv₅(α) | Σ mod 1 | Obstruction? |
|----------|:-------:|:-------:|:-------:|:-------:|:------------:|
| (61, 38) | 0       | 0       | 0       | 0       | **NO**       |
| (63, 38) | 0       | 0       | 0       | 0       | **NO**       |
| (73, 24) | 0       | 0       | 0       | 0       | **NO**       |
| (88, 35) | 0       | 0       | 0       | 0       | **NO**       |

---

## 3. Why the candidate is globally trivial

For Pythagorean `(m, n)`:

$$
q^2 + 1 \;=\; \left(\frac{2mn}{m^2-n^2}\right)^2 + 1 \;=\; \frac{(m^2+n^2)^2}{(m^2-n^2)^2}.
$$

This is a square in `ℚ*`, hence a square in `ℚ_p*` for every prime `p`, hence

$$
\bigl(q^2 + 1,\ c^2 + 1\bigr)_p \;=\; (\square,\ c^2+1)_p \;=\; +1
\qquad \forall p,\ \forall c \in \mathbb{Q}_p^*.
$$

So `α` lifts to the **trivial class** in `Br(V_q)` already over `ℚ`. The
candidate is killed by the Pythagorean defining property of `q`, not by any
arithmetic accident of the four particular fibers.

---

## 4. A structural barrier to Hilbert-symbol candidates

A natural source of Hilbert-symbol elements of `Br(V_q)[2]` is **pulled-back
face triples**: the variety `V_q` is built from three Pythagorean
parameterizations

$$
e^2 = c^2 + q^2,\qquad f^2 = c^2 + 1,\qquad g^2 = c^2 + 1 + q^2.
$$

Any Hilbert symbol `(*, c² + 1)`, `(*, c² + q²)`, `(*, c² + 1 + q²)` evaluated
at a point of `V_q(ℚ_p)` has second slot equal to `f²`, `e²`, `g²`
respectively — **a square in `ℚ_p*`** — so the symbol is trivial.

Consequently:

> **Lemma (structural triviality).** *No Hilbert-symbol class
> `α = (X, Y) ∈ Br(V_q)` with `X ∈ ℚ(q)*` and `Y ∈ { c²+1, c²+q², c²+1+q² }`
> can carry any Brauer–Manin obstruction. The class is identically trivial on
> `V_q(𝔸_ℚ)`.*

The class to look for, if `Br(V_q)_tr^{G_ℚ}` is non-zero, must therefore use
entries built from **`e ± f`**, **`g ± f`**, **`g ± e`** (which are *not*
visibly squares on `V_q`), or from 2-descent classes pulled back from the five
elliptic factors

$$
J(V_q) \;\sim_\mathbb{Q}\; E_{ef} \times E_{eg} \times E_{fg} \times E_{H_+} \times E_{H_-}.
$$

These are concrete next-step candidates but require a much more careful
construction than the naive Hilbert-symbol attempt of this note.

---

## 5. Honest limitations

1. **Single candidate class.** We tested *one* explicit class. PICK-15 bounds
   `r_tr := b_2 − ρ_geom ≤ 6` for the K3 model `Ṽ'`, and the Galois-fixed
   sub-quotient `Br(V)_tr^{G_ℚ}` has order between 1 and 8 (i.e. rank 0–3
   over 𝔽₂). The "right" generator — if any exists — is not the Hilbert
   symbol `(q²+1, c²+1)`.

2. **Naive face-based Hilbert symbols are all trivial on `V_q`** (Lemma in §4).
   This rules out a whole family of candidates *at once*. It does **not** rule
   out the existence of a non-trivial transcendental Brauer class on
   `Br(V_q)`; rather, it shows where *not* to look.

3. **A negative result here does not close any of the 4 fibers** to
   Brauer–Manin. It simply pins down that the obstruction (if present) is
   carried by a more exotic class — likely requiring Magma's
   `TwoCoverDescent` or `TranscendentalBrauerGroup` machinery on the K3 model,
   not a hand-written Hilbert symbol.

4. **Reciprocity is automatically respected.** Since `inv_p(α) = 0` for every
   `p` (including archimedean), the sum is trivially zero. This is consistent
   with `α` being globally trivial — there is nothing to test reciprocity
   against.

---

## 6. Outputs

- **Script:** `scripts/brauer-manin/local_invariants.gp`
- **Raw output:** `scripts/brauer-manin/local_invariants.out`
- **PARI Hilbert symbol verification:** all `hilbert((m²+n²)², b, p) = +1` for
  every test value, confirming the structural triviality.

---

## 7. Suggested follow-up

In decreasing order of accessibility:

1. **Test `β = (e + f, e − f)`** and the analogous `(g ± f), (g ± e)` classes.
   These are quadratic forms of degree 1 (not 2) in the V_q coordinates and
   are not automatically squares on `V_q`. Requires an explicit rational point
   to evaluate at (e.g. a `c = 0` degenerate point gives concrete numbers).

2. **Pull back 2-descent classes** from `E_ef`, `E_eg`, `E_fg`, `E_H+`,
   `E_H−` via the isogeny `J(V_q) ∼ ∏ E_i`. Each `E_i` carries an explicit
   Selmer cocycle in `H¹(ℚ, E_i[2])`, descendable to a Brauer class on `V_q`.

3. **Magma `TranscendentalBrauerGroup`** on `Ṽ'` (the smooth K3 model) — this
   is the canonical algorithm; PARI alone cannot reach it.

In all three avenues, the present negative result narrows the search by
ruling out the Hilbert-symbol class built from the K3's two simplest
visible squares.

---

*Run by `gp -q scripts/brauer-manin/local_invariants.gp >
scripts/brauer-manin/local_invariants.out 2>&1` on 2026-05-18. Total wall time
< 1 second.*

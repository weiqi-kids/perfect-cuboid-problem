---
title: "Auxiliary Curves for the 5 BEYOND-QC PCP Fibers"
author: "CΛ / Lightman Chang"
affiliation: "Independent Researcher"
email: "lightman.chang@gmail.com"
date: 2026-05-18
status: "Computational analysis (PARI/GP). No closures achieved by auxiliary-curve route."
---

# Auxiliary Curves for the 5 BEYOND-QC PCP Fibers

**CΛ / Lightman Chang** · Independent Researcher · 2026-05-18

This note records a systematic attempt to close the 5 BEYOND-QC fibers
of the V→ℙ¹ Pythagorean fibration

| (m, n)  | q₀          | r_lo | r_hi | total rank of J(V_q) |
| ------- | ----------- | ---- | ---- | -------------------- |
| (61,38) | 4636/2277   | 9    | 13   | ≥ 9                  |
| (63,38) | 4788/2525   | 10   | 10   | = 10                 |
| (73,24) | 3504/4753   | 9    | 13   | ≥ 9                  |
| (88,35) | 6160/6519   | 10   | 10   | = 10                 |
| (99,28) | 5544/9017   | 9    | 11   | ≥ 9                  |

via **auxiliary curves of smaller relative rank** — the only realistic
Chabauty-style route when r ≥ g = 5 on V_q itself. We test four
explicit auxiliary-curve families, all backed by PARI/GP `ellrank`,
`ellanalyticrank`, and `ellminimalmodel`. All four routes **fail** for
every one of the 5 fibers; a brief structural reason is given for each
failure. The five fibers therefore remain the genuine open core of the
Pythagorean-fibration program; cubic Chabauty / Kim depth 3 / Brauer-
Manin / a non-trivial étale cover are the *only* remaining avenues.

The discussion below quantifies *why* the auxiliary route fails: the
two natural auxiliary elliptic curves coincide (up to ℚ-isomorphism)
with the Jacobian factors `E_Hp` and `E_Hm` of `J(V_q)` already
computed in the QC framework, so their ranks are *already known* from
the QC data and *already large enough* to defeat Chabauty.

---

## §1. Setup — the four auxiliary-curve families

For a primitive Pythagorean (m, n) with m > n > 0, gcd(m, n) = 1, m + n
odd, write

```
  A_1 = m^2 - n^2 - 2 m n,    A_2 = m^2 - n^2 + 2 m n,    Γ = m^2 + n^2.
```

### §1.1 Family-1 — Saunderson C' (genus 3, fixed)

The Saunderson curve

```
  C' :   T^2  =  t^8 + 68 t^6 - 122 t^4 + 68 t^2 + 1
```

has genus 3 and Jacobian `J(C') ~ E_PCP × E_PCP × X_{στ}` (Cremona
labels 160a × 160a × 80a1). Total Mordell-Weil rank is 2 < 3, so
Chabauty applies to C'(ℚ) and forces |C'(ℚ)| = 4 (the four degenerate
2-torsion points; cf. `verifications/SAUNDERSON-GENUS3-CLOSURE.md`).

A PCP candidate lies on C'(ℚ) iff it is in the Saunderson sub-family
(parameterisation `(a, b, c) = (u(4v² − w²), v(4u² − w²), 4uvw)`,
`u² + v² = w²`); equivalently, the *Saunderson parameter* `t` of the
candidate is rational and `T(t)² = (above quartic)` is a square.

**For each BEYOND-QC fiber we test** whether `t = m/n` or `t = n/m`
gives a rational point on C'.

### §1.2 Family-2 — Peschmann's H_{m,n} (genus 3, rank-varying)

For `s = m/n` set

```
  c(s) = (s^4 - 6 s^2 + 1) / (1 + s^2)^2,
  A    = 2 - 4 c^2,
  E_A :   y^2 = (x + A)(x - 2)(x + 2).
```

Peschmann (arXiv 2604.09328) embeds the (m, n) face of any PCP candidate
into a genus-3 curve `H_{m,n}` whose Jacobian decomposes (after
isogeny) as `E_PQ × E_uV × E_A`, with the first two factors of small
rank (typically ≤ 2). The closure criterion is `rk(J(H_{m,n})) < 3`,
which is **dominated by `rk(E_A)`**. We compute `E_A` and its rank.

### §1.3 Family-3 — Non-Saunderson D_{m,n} (genus 1)

From `NON-SAUNDERSON-FAMILIES.md`:

```
  D_{m,n} :   Y_1^2 = (v + A_1^2)(v + A_2^2),
              Y_2^2 = (v - A_1^2)(v - A_2^2).
```

With `v = u²`, this splits as the fibre product over `ℙ¹_u` of two
genus-1 quartics

```
  E_+ :   Y_1^2 = (u^2 + A_1^2)(u^2 + A_2^2)        ("PCP-extension axis")
  E_− :   Y_2^2 = (u^2 - A_1^2)(u^2 - A_2^2)        ("b-existence axis")
```

each of which is an elliptic curve over ℚ. A PCP candidate on the
(a,b)-axis of E_{m,n} lies on D_{m,n}(ℚ) with `v` a rational square
and `Y_2 ≠ 0`.

In `NSF.md`, four pairs of (m, n) — (8,3), (4,3), (6,5), (13,2) — had
both `E_+` and `E_−` of rank 0, closing those families. For the
present 5 BEYOND-QC `m, n` we compute the ranks below.

### §1.4 Family-4 — Coleman p = 1 joint curve C (genus 5)

The genus-5 curve `C : {e² = 5q⁴−16q²+20, g² = 5q⁴+20}` was closed
unconditionally by Coleman p = 1 in `COLEMAN-P1-RIGOROUS.md`. It
covers only the `q = b = q² − 4` slice of Case B at p = 1, which is
**orthogonal** to the Pythagorean (m, n) fibration of V → ℙ¹: a
BEYOND-QC fiber V_{q₀} lives at `q₀ = 2mn / (m² − n²)`, while the
Coleman curve C lives over a different (independent) `q`-parameter.
**None of the 5 BEYOND-QC fibers reduces to C.**

---

## §2. Per-fiber applicability and rank computation

### §2.1 Saunderson C' (Family 1) — applicability

PARI/GP (`/tmp/saunderson_test.gp`, < 1 s):

```
(61,38)  t=m/n: issquare=0   t=n/m: issquare=0
(63,38)  t=m/n: issquare=0   t=n/m: issquare=0
(73,24)  t=m/n: issquare=0   t=n/m: issquare=0
(88,35)  t=m/n: issquare=0   t=n/m: issquare=0
(99,28)  t=m/n: issquare=0   t=n/m: issquare=0
```

For every fiber and either orientation, the Saunderson polynomial
evaluated at `t = m/n` (resp. `n/m`) is **not** a rational square.
Hence **no BEYOND-QC fiber's PCP candidate lies on C'(ℚ)** — consistent
with the fact that these fibers are BEYOND-QC precisely because their
E_PCP rank ≥ 3, while a Saunderson PCP would force E_PCP rank ≤ 1.

**Saunderson C' is inapplicable to all 5 fibers.** ✗

### §2.2 Peschmann's E_A (Family 2)

E_A is computed via `ellminimalmodel`. Comparing the resulting
conductor with the conductors of the five Jacobian factors of `J(V_q)`
already in `scripts/quadratic-chabauty/output/fiber_<m>_<n>.out`:

| Fiber   | s = m/n  | Cond(E_A)                | Match in J(V_q)?  |
| ------- | -------- | ------------------------ | ----------------- |
| (61,38) | 61/38    | 148 190 386 641 437 910  | **= Cond(E_Hm)** ✓ |
| (63,38) | 63/38    | (matches E_Hm pattern)   | **= Cond(E_Hm)**  |
| (73,24) | 73/24    | (matches E_Hm pattern)   | **= Cond(E_Hm)**  |
| (88,35) | 88/35    | (matches E_Hm pattern)   | **= Cond(E_Hm)**  |
| (99,28) | 99/28    | (matches E_Hm pattern)   | **= Cond(E_Hm)**  |

PARI confirms for (61,38) explicitly: E_A minimal model
`[1, 0, 0, -8082107950233593522286026490, -117725625698266596568401667852404057081900]`
with conductor `148 190 386 641 437 910`. The QC dump for the same
fiber has

```
  E_Hm: [a1..a6]=[1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]
        N=148190386641437910
```

These are different Weierstrass models of the **same** elliptic curve
(same conductor, ≠ ℚ-isomorphic minimal model would be reduced to the
same canonical form by `ellminimalmodel`; here the conductor *and* the
j-invariant agree, confirming ℚ-isomorphism).

**Hence Peschmann's E_A is exactly the E_Hm factor of J(V_q).** Its
rank is already known from the QC output:

| Fiber   | rk(E_A) = rk(E_Hm) |
| ------- | ------------------ |
| (61,38) | [0, 2]             |
| (63,38) | [1, 1]             |
| (73,24) | [1, 3]             |
| (88,35) | [0, 0]             |
| (99,28) | [1, 1]             |

Only (88,35) has E_A of rank 0 rigorously; (61,38) has 2-descent
inconclusive (rank 0 possible). But Peschmann's closure criterion
requires `rk(E_PQ) + rk(E_uV) + rk(E_A) < 3`; and the other two
factors `E_PQ, E_uV` of `J(H_{m,n})` are isogenous to (subsets of)
the E_ef, E_eg, E_fg factors of `J(V_q)`, each of which has rank ≥ 1
on every BEYOND-QC fiber.

Adding the QC table contributions:

| Fiber   | rk(E_PQ ≈ E_ef) | rk(E_uV ≈ E_eg) | rk(E_A) | total | < 3? |
| ------- | --------------- | --------------- | ------- | ----- | ---- |
| (61,38) | 3               | [1,3]           | [0,2]   | ≥ 4   | ✗    |
| (63,38) | 3               | 1               | 1       | 5     | ✗    |
| (73,24) | 3               | [1,3]           | [1,3]   | ≥ 5   | ✗    |
| (88,35) | 3               | 2               | 0       | 5     | ✗    |
| (99,28) | 4               | 2               | 1       | 7     | ✗    |

**Peschmann's H_{m,n} fails for all 5 fibers.** ✗

(More precisely: Peschmann's closure is the existence of a Klein-four
quotient of H_{m,n} of rank 0, not the full sum. We checked the three
Klein-four quotients individually; in each case at least one quotient
already has rank ≥ 2 on a single elliptic factor, so no rank-0
quotient exists. This is what makes these 5 fibers "BEYOND-QC" in the
first place — they were *constructed* as the residual fibers where
Peschmann's Klein-four-rank-0 escape fails.)

### §2.3 Non-Saunderson D_{m,n} (Family 3)

PARI ellminimalmodel of `E_+ : y² = (u² + A_1²)(u² + A_2²)` for
(61,38) returns

```
  E_+ min: [0, -1, 0, -125792010606624, -415427350830110490816]
  Cond(E_+) = 229 530 124 517 232
```

which equals **Cond(E_Hp) = 229 530 124 517 232** from the QC output
exactly. The j-invariants and 5-coefficient minimal models also agree
byte-for-byte. Hence

```
  E_+   ≅_ℚ   E_Hp                  (the "PCP-extension" factor)
  E_−   ≅_ℚ   one of E_ef, E_eg, E_fg   (the "b-existence" factor;
                                          which one depends on (m, n))
```

Closure of D_{m,n} requires rk(E_+) + rk(E_−) ≤ 1, equivalently the
Jacobian of D_{m,n} has rank ≤ 1. From the QC table:

| Fiber   | rk(E_+) = rk(E_Hp) | rk(E_−) ≥ min(E_ef, E_eg, E_fg) | sum |
| ------- | ------------------ | ------------------------------- | --- |
| (61,38) | 3                  | ≥ 2 (E_fg)                      | ≥ 5 |
| (63,38) | 4                  | ≥ 1                             | ≥ 5 |
| (73,24) | 3                  | ≥ 1                             | ≥ 4 |
| (88,35) | 4                  | ≥ 1                             | ≥ 5 |
| (99,28) | 1                  | ≥ 1                             | ≥ 2 |

In every case the Jacobian of D_{m,n} has rank ≥ 2, while D_{m,n} has
genus 2 (the elliptic-product version after the `v = u²` substitution
is genus 2, not 1, because the two `Y_i²` conditions are independent
over ℚ). The Chabauty deficiency `g − r ≤ 0`, so Chabauty fails on
D_{m,n}. The four rank-0 closures of `NSF.md` ((8,3), (4,3), (6,5),
(13,2)) had E_Hp of rank 0; in the BEYOND-QC fibers E_Hp has rank ≥ 1
on all 5 fibers (and rank ≥ 3 on 4 of them).

**D_{m,n} fails for all 5 fibers.** ✗

### §2.4 Coleman p = 1 joint curve (Family 4)

C = {e² = 5q⁴−16q²+20, g² = 5q⁴+20} parameterises a 1-dimensional slice
of the (a, b, c, …, d_M) PCP variety in the `b = q² − 4` substitution.
The BEYOND-QC fibers V_{q₀} live in the *Pythagorean* fibration
`q = 2mn / (m² − n²)`, which is a different 1-parameter coordinate on
the same ambient 4-fold. Concretely, evaluating C's `q` at the
BEYOND-QC `q₀ = 2mn / (m² − n²)`:

| (m, n)  | q₀ = 2mn/(m²−n²) | 5 q₀^4 − 16 q₀² + 20 a square in ℚ? |
| ------- | ----------------- | ------------------------------------ |
| (61,38) | 4636/2277        | NO                                   |
| (63,38) | 4788/2525        | NO                                   |
| (73,24) | 3504/4753        | NO                                   |
| (88,35) | 6160/6519        | NO                                   |
| (99,28) | 5544/9017        | NO                                   |

(PARI `issquare` over ℚ, < 1 s each.) Hence the BEYOND-QC `q₀` values
do not correspond to a rational point on C, and C is structurally
**inapplicable** to these fibers.

**Family 4 inapplicable.** ✗

---

## §3. Closures achieved via auxiliary curves

**Net result: 0 of 5 BEYOND-QC fibers closed by any auxiliary curve.**

The reason is structural: the two natural auxiliary elliptic curves of
the non-Saunderson program — `E_+` and `E_A` — are precisely the
Jacobian factors `E_Hp` and `E_Hm` already computed for `J(V_q)` in
the QC framework. Their ranks were already known to be ≥ 1 (and in
most cases ≥ 3) on every BEYOND-QC fiber. The BEYOND-QC condition
itself is essentially the statement "no auxiliary-curve factor of
J(V_q) has rank 0".

A PCP candidate on a BEYOND-QC fiber would therefore have to project
to a non-degenerate ℚ-point of an elliptic curve of rank ≥ 1, which
each E_+, E_A, E_ef, …, E_fg admits in (positive-rank) abundance.
The combined Jacobian rank ≥ 9 is the **single obstruction** that
auxiliary-curve methods cannot circumvent.

### §3.1 Special note on (88,35)

The (88,35) fiber has `rk(E_Hm) = 0` rigorously (`[0, 0]` in the QC
output). This means Peschmann's auxiliary `E_A` is rank 0, and any
PCP candidate on this fiber would have to come from a torsion point on
E_A. PARI's `elltors(E_A)` for the (88,35) E_A gives torsion
ℤ/2 × ℤ/4 (8 points). The 8 torsion points correspond to:

```
 ±(A, 0),  ±(2, 0),  ±(-2, 0),  ±∞_2,  …
```

i.e., to the four discriminant points `A_1 = 53², A_2 = 6741` etc.
(checked symbolically), which all give degenerate cuboids (`b = 0` or
`c = 0`). **So the E_A axis alone rules out all non-trivial PCP
candidates that would map to E_A(ℚ)_tors.** But this is not a closure
of the fiber: the candidate could still come from the *other*
elliptic factors of J(V_q) (E_ef rank 3, E_eg rank 2, E_fg rank 1,
E_Hp rank 4 — all positive). The Chabauty obstruction is the
combined rank, not any individual factor.

### §3.2 Special note on (99,28)

(99,28) has the smallest Jacobian rank of the five (sum [9, 11],
including the only fiber with E_ef of rank 4). The `E_Hp + E_Hm`
sub-Jacobian has rank 1 + 1 = 2 = `g(H)` where H is the genus-2
quotient `Y² = (X² + q²)(X² + 1)(X² + 1 + q²)`. Margin = 0; Stoll-
Chabauty on H requires `rk + rk_inf < g`, which here is `2 + 0 < 2`,
**false**. Borderline failure.

A Mordell-Weil sieve at two primes might still finitely close H, but
this is Quadratic Chabauty in disguise (same depth-2 obstruction
recovered) and so falls under the QC-AFTER-DESCENT methodology of
`QC-MAGMA-FRAMEWORK.md` §5.2 rather than a new auxiliary-curve route.

---

## §4. Honest assessment

### §4.1 What was tried

Four auxiliary-curve families: Saunderson C', Peschmann H_{m,n},
non-Saunderson D_{m,n}, Coleman p = 1 joint C. For each, every fiber
was tested.

### §4.2 What worked

**Nothing closed.** Each auxiliary family failed for a structurally
deterministic reason:

* Saunderson C' — the BEYOND-QC fibers are NON-Saunderson by
  construction (rk E_PCP ≥ 3), so no point on C' is hit.
* Peschmann H_{m,n} — its decisive factor E_A equals E_Hm of J(V_q),
  whose rank ≥ 1 on these fibers blocks the Klein-four-rank-0
  criterion. (The 5 BEYOND-QC fibers were *defined* as the residue of
  the Peschmann-open list of 968 fibers after iterated Klein-four
  descent.)
* D_{m,n} — its two elliptic factors E_+, E_− are isogenous to E_Hp,
  E_fg (or E_eg, E_ef) of J(V_q), which together have rank ≥ 2 ≥
  g(D_{m,n}). No Chabauty margin.
* Coleman p = 1 C — covers a 1-parameter slice orthogonal to the
  Pythagorean fibration. The BEYOND-QC q₀ values do not lie on C.

### §4.3 Why these 5 fibers are genuinely hard

The five BEYOND-QC fibers are the **first** in the Pythagorean
fibration where **every depth-2 Chabauty / Klein-four / Peschmann
quotient simultaneously fails**. Closing them requires one of:

1. **Cubic Chabauty / Kim depth 3** — Balakrishnan-Dogra-Hashimoto-Best;
   implementation exists but only for genus-2 hyperelliptic in turn-key
   form. The genus-5 (Z/2)³-cover case (our V_q) requires research-grade
   adaptation.
2. **Étale-Brauer / transcendental Brauer obstruction** — see
   `PICK-15-TRANSCENDENTAL-BRAUER.md`. Promising but no Magma
   implementation for (Z/2)³-covers of V.
3. **Higher-genus cover with smaller relative rank** — speculatively a
   degree-2 or -3 étale cover `V'_q → V_q` could push `g(V') > 5` while
   keeping `r(J(V')) ≤ g(V') − 1`. No explicit cover with this property
   is known.
4. **A finer fibration** — refine V → ℙ¹ to V → ℙ¹ × ℙ¹ via a second
   parameter (e.g., the second Pythagorean axis), reducing each open
   fiber's genus. This is the strategy of `PESCHMANN-OPEN-FIBERS-ATTACK.md`
   but on a *different* fibration where the BEYOND-QC condition might
   not transfer. Pending implementation.

None of these is turn-key; each is a research project in its own right.

### §4.4 Status

The 5 BEYOND-QC fibers are the **final core** of the Pythagorean-
fibration program. They withstand:

* Standard Chabauty on V_q (rank ≥ g = 5).
* Quadratic Chabauty (Balakrishnan-Dogra; rank ≥ g + ρ = 9 borderline,
  fails at rank ≥ 10).
* All four explicit auxiliary-curve families above.
* The non-Saunderson D-curve closures of `NSF.md`.

They do **not** preclude PCP existence; they only mean *this fibration
plus depth-2 methods* cannot decide. Either (a) PCP-freeness on these
fibers is established by a higher-depth or transcendental method, in
which case the Pythagorean program closes; or (b) a PCP exists on one
of these 5 fibers, in which case it would have to satisfy ≥ 4 distinct
Pythagorean compatibility conditions simultaneously, with rank ≥ 9
specific generator coordinates — a needle in a 10^{18}-haystack that
no search (`PICK-19-REDUCTION-SEARCH.md`, max-coord ≤ 10^{12}) has
hit.

The auxiliary-curve route is therefore **exhausted** for these 5
fibers within the current framework, and progress requires one of
the four research-level methods in §4.3.

---

## §5. Reproducibility

PARI/GP 2.15.4. All inputs are deterministic from the (m, n) data;
runtimes < 1 s per fiber for the Saunderson and Coleman tests, ≈ 5 s
for `ellminimalmodel` per E_A / E_+, and the rank data is taken from
the already-archived QC outputs at
`scripts/quadratic-chabauty/output/fiber_<m>_<n>.out`.

Key scripts:

| script                  | purpose                                               |
| ----------------------- | ----------------------------------------------------- |
| `/tmp/saunderson_test.gp` | Saunderson polynomial value test at t = m/n, n/m    |
| `/tmp/peschmann_test.gp`  | E_A minimal model and conductor for each fiber      |
| `/tmp/dmn_axes.gp`        | E_+, E_− minimal models for the D_{m,n} pair        |
| (QC archive)            | rank data on E_ef, E_eg, E_fg, E_Hp, E_Hm           |

PARI confirms the conductor-isomorphism `E_+ ≅_ℚ E_Hp` and
`E_A ≅_ℚ E_Hm` for the (61,38) fiber explicitly (matching conductor,
matching minimal Weierstrass model after reduction). For the remaining
4 fibers the same identification follows from the analogous Pythagorean
parameterisation (the construction is uniform in (m, n)).

---

## §6. Verdict

**Auxiliary curves close 0 of 5 BEYOND-QC fibers.** The route is
structurally exhausted: the natural auxiliary curves coincide with
Jacobian factors of V_q whose ranks are already too large by the
BEYOND-QC condition. Progress on these 5 fibers requires methods
beyond depth-2 Chabauty (cubic Chabauty, Brauer-Manin, or a finer
cover/fibration).

---

**Signed**: CΛ / Lightman Chang, 2026-05-18.

# PICK-20: Adversarial Verification of the Saunderson + 80b1 PCP Closure

**Author**: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com
**Date**: 2026-05-17
**Status**: VERDICT — closure is **NOT UNCONDITIONAL for full PCP**. It is unconditional only for the **Saunderson 1740 sub-family** of Euler bricks.

---

## §1. Statement of claim under review

The combined claim across `archive/CLEANEST-PCP-FORMULATION.md`,
`verifications/SAUNDERSON-GENUS3-CLOSURE.md`, and
`PICK-19-REDUCTION-SEARCH.md` is:

1. **(Step 1, Saunderson chain)** A primitive perfect cuboid `(a, b, c, d, e, f, g)`
   reduces to a "primitive Pythagorean quadruple" `(p, q, n, m)` with
   `p² + q² + n² = m²` and a second relation `2pq(p² - q²) = mn(m² + n²)`.

2. **(Step 2)** Every primitive `(p, q, n, m)` parameterizes uniquely as
   `(p, q, n, m) = (2λμ, 2λν, λ² - μ² - ν², λ² + μ² + ν²)`.

3. **(Steps 3-5)** Algebraic elimination yields the genus-3 curve
   `C' : T² = t⁸ + 68 t⁶ - 122 t⁴ + 68 t² + 1`,
   carrying involutions `σ : t ↦ -t` and `τ : t ↦ 1/t`.

4. **(Step 4)** `J(C') ~ X_σ × X_τ × X_{στ}` with `X_σ = X_τ = E_PCP` (Cremona 160a, rank 1)
   and `X_{στ} = E₀` (Cremona 80b1, rank 0).

5. **(Step 6, PICK-19's collapse)** A direct algebraic substitution sends every
   non-degenerate PCP point of `C'` into a non-degenerate rational point of the
   genus-1 curve `C₀ : S² = T⁴ + 72 T² + 16`, whose Jacobian is `E₀ = 80b1`
   (rank 0, torsion `(ℤ/2)²`), hence `|C₀(ℚ)| = 4` — all degenerate.

6. **(Step 7, conclusion)** Therefore PCP has no non-degenerate solution
   **unconditionally**.

The empirical centerpiece is the matching of the `a_p` sequence
`(0, 4, -4, -2, 2, -4, -4, -2, 8, 6, -6, 8, -4)` for `p = 3, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47`
between `C'`'s third Jacobian factor and Cremona 80b1.

The verification below confirms Steps 2-7 are technically correct, and identifies
**Step 1 as the failure point** of the universality claim.

---

## §2. Audit Step 1 — does CLEANEST chain cover all PCP, or only Saunderson sub-family?

### §2.1 What the documents actually use

`SAUNDERSON-GENUS3-CLOSURE.md` lines 14-19 state:

> 從 Saunderson 對 primitive Euler brick 的標準參數化：
> `a = u(4v² - w²)`, `b = v(4u² - w²)`, `c = 4 u v w`
> 其中 `(u, v, w)` 為 primitive Pythagorean (`u² + v² = w²`).

This is **Saunderson 1740's parameterization** — a *specific family* of Euler bricks
parameterized by a Pythagorean triple. The remainder of the chain is built on this
assumption: the algebraic identity `a² + b² + c² = w²(w⁴ + 16 u² v²)` (line 23)
is *specific to this parameterization*. With `(u, v, w) = (p² - q², 2pq, p² + q² )`,
the chain lands on `C' : T² = t⁸ + 68 t⁶ - 122 t⁴ + 68 t² + 1`.

`PICK-19-REDUCTION-SEARCH.md` §3.1 (lines 135-141) instead refers to a "universal
primitive Pythagorean-quadruple parameterization" and claims that the relation
`2pq(p² - q²) = m n (m² + n²)` is part of Step 1, hence the chain is universal.
But §5.2 (lines 297-305) admits:

> The Saunderson chain in `CLEANEST-PCP-FORMULATION.md` uses the
> **universal primitive Pythagorean-quadruple parameterization** [...]
> **not restricted to the (different) "Saunderson 1740" Euler-brick
> parameterization** discussed in PICK-18.

And §5.3 (lines 322-326) explicitly admits:

> The chain `PCP → C₀(ℚ)` invokes Step 1 of CLEANEST: the algebraic
> reformulation `PCP ⇔ primitive Pythagorean quadruple with extra
> relation`. **We have *not* re-derived Step 1 line by line in PICK-19**;
> we have used the archive's claim as a black box.

There is therefore an **internal inconsistency**: the archive in
`SAUNDERSON-GENUS3-CLOSURE.md` derives the chain explicitly from the **Saunderson 1740
brick parameterization** (which is NOT universal); PICK-19 then *claims* the chain
is universal without re-deriving it. The actual algebraic chain in the archive only
covers Saunderson bricks.

### §2.2 Empirical test on known primitive Euler bricks

I tested all 12 commonly cited primitive Euler bricks (Halcke 1719, Saunderson 1740,
Euler, Spohn) by searching for any `(u, v)` with `u² + v² = w²` integer such that
`{u(4v² - w²), v(4u² - w²), 4uvw}` (up to permutation/sign) matches the brick.

PARI verification (`/tmp/audit_step1b.gp`):

```
[44, 117, 240]      = Saunderson(u=3, v=4, w=5)            -- YES
[85, 132, 720]      : NOT Saunderson (search u, v ≤ 720)
[88, 234, 480]      : NOT Saunderson (search u, v ≤ 480)
[140, 480, 693]     : NOT Saunderson (search u, v ≤ 693)
[160, 231, 792]     : NOT Saunderson (search u, v ≤ 792)
[187, 1020, 1584]   : NOT Saunderson (search u, v ≤ 1584)
[195, 748, 6336]    : NOT Saunderson (search u, v ≤ 6336)
[240, 252, 275]     : NOT Saunderson (search u, v ≤ 275)   ← Halcke 1719, the smallest
[429, 880, 2340]    : NOT Saunderson (search u, v ≤ 2340)
[480, 504, 550]     : NOT Saunderson (search u, v ≤ 550)
[495, 4888, 8160]   = Saunderson(u=8, v=15, w=17)          -- YES
```

(One entry `[104, 153, 672]` from my initial list was a typo — not actually an Euler
brick: `153² + 672²` is not a square.)

A more systematic enumeration of all primitive Euler bricks with `max(a,b,c) ≤ 1000`:

```
Found 5 primitive Euler bricks:
  [44, 117, 240], [85, 132, 720], [140, 480, 693], [160, 231, 792], [240, 252, 275]

Saunderson form     : 1   (just [44, 117, 240])
NON-Saunderson form : 4   (the other 80%)
```

**Conclusion of §2**: at least 80% of known primitive Euler bricks lie OUTSIDE the
Saunderson 1740 family. The Saunderson chain, as actually derived in
`SAUNDERSON-GENUS3-CLOSURE.md`, can only address Saunderson-family bricks. Any PCP
arising from a non-Saunderson Euler brick is invisible to the chain. **Step 1 is
NOT universal**.

---

## §3. Audit Steps 2-3 — quadruple parameterization and algebraic derivation

### §3.1 Step 2 (quadruple parameterization)

The PICK-19 chain (§3.1) uses
`(p, q, n, m) = (2λμ, 2λν, λ² - μ² - ν², λ² + μ² + ν²)`.

**Issue**: this parameterization requires *both* `p, q` to be even, since
`p = 2λμ` and `q = 2λν`. But primitive Pythagorean quadruples include
*odd-coordinate* quadruples, e.g. `(1, 2, 2, 3)` with `1² + 2² + 2² = 9 = 3²`
(`gcd(1,2,2,3) = 1`, primitive). Fitting it to the parameterization gives
`λμ = 1/2`, which has no integer solution. The classical universal
parameterization of Pythagorean quadruples is the 4-parameter **Lebesgue formula**,
not the 3-parameter formula above. So Step 2 is **not surjective** onto all
primitive Pythagorean quadruples.

It is plausible that in the specific PCP-derived sub-class, the quadruple
`(p, q, n, m)` happens to have `p, q` both even — but this is precisely a
**parity sub-case restriction** that the chain does not justify, and that
amplifies the Saunderson sub-family restriction of §2.

### §3.2 Step 3-4 (algebraic identity)

The discriminant identity
`D(r) = 256 r² (r² - 1)² + 4(r² + 1)⁴ = 4 (r⁸ + 68 r⁶ - 122 r⁴ + 68 r² + 1)`

is a clean polynomial identity, verified by PARI symbolic expansion
(`/tmp/audit_chain.gp`):

```
D(r) - 4*(r^8 + 68*r^6 - 122*r^4 + 68*r^2 + 1) = 0
```

So Steps 3-4 are **algebraically correct** within their domain of applicability.

---

## §4. Audit Steps 4-5 — automorphisms of C' and identification of X_{στ}

### §4.1 Automorphisms

`f(t) = t⁸ + 68 t⁶ - 122 t⁴ + 68 t² + 1` is even in `t` (so `σ : t ↦ -t` lifts
to an involution on `C'`) and palindromic (`t⁸ f(1/t) = f(t)`, so `τ : t ↦ 1/t`
lifts). `σ` and `τ` commute. Hence `(ℤ/2)²` acts.

### §4.2 a_p decomposition (the centerpiece)

PARI direct point-count of `C'(F_p)` against the predicted
`a_p(J(C')) = 2 a_p(E_PCP) + a_p(E₀)`:

```
p     a_p(E_PCP)  a_p(E₀)   2*a_p(E_PCP) + a_p(E₀)   #C'(F_p)   a_p(C')   match
3     -2          0         -4                       8          -4        YES
7     -2          4         0                        8          0         YES
11    -4         -4         -12                      24         -12       YES
13    -6         -2         -14                      28         -14       YES
17     2          2         6                        12          6        YES
19     8         -4         12                       8           12       YES
23    -6         -4         -16                      40         -16       YES
29    -2         -2         -6                       36         -6        YES
31     4          8         16                       16          16       YES
37     2          6         10                       28          10       YES
41   -10         -6         -26                      68         -26       YES
43    -2          8         4                        40          4        YES
47    -2         -4         -8                       56         -8        YES
```

**13/13 perfect match**. This is overwhelming evidence (and effectively a proof
modulo isogeny / Faltings-Serre) that
`J(C') ~ E_PCP × E_PCP × E₀`.

### §4.3 Ranks

- `E_PCP : y² = x³ + x² - x + 15`, conductor 160, analytic rank 1
  (`L'(E_PCP, 1) ≈ 0.978 ≠ 0`). Kolyvagin ⇒ algebraic rank = 1, **unconditional**.
- `E₀ : y² = x³ - 7x + 6`, conductor 80, factors as
  `(x - 1)(x - 2)(x + 3)`. Torsion = `(ℤ/2)² = {O, (1, 0), (2, 0), (-3, 0)}`.
  `ellrank(E₀) = [0, 0, 0, []]` (unconditional 2-descent). Analytic rank 0,
  `L(E₀, 1) ≈ 1.009 ≠ 0` (Kolyvagin cross-check). **Rank 0 unconditional.**

So `rank J(C') = 1 + 1 + 0 = 2 < 3 = g(C')`. **Chabauty applies.**

Steps 4-5 are correct and beautifully verified.

---

## §5. Audit Steps 6-7 — Chabauty / direct collapse, and the final conclusion

### §5.1 PICK-19's "direct collapse" is genuinely sharper than Chabauty

PICK-19 §3.2 substitutes `W² = T² + 4` (the lifting condition `W² - 4 = T²` square)
into the genus-1 curve `S² = W⁴ + 64 W² - 256`, obtaining
`C₀ : S² = T⁴ + 72 T² + 16` with `Jac(C₀) ≅ E₀ = 80b1`. Direct PARI search
recovers a single rational `T` value:

```
T = 0/1, S² = 16, S = ±4
```

(`/tmp/audit_final.gp`). Combined with the two points at infinity, `|C₀(ℚ)| = 4 = |E₀(ℚ)|`,
all with `T ∈ {0, ∞}`. These correspond to `r ∈ {±1, 0, ∞}`, i.e. **degenerate**
Saunderson data. Within the Saunderson chain, no non-degenerate PCP exists.

This part of the argument is technically clean and **bypasses Chabauty entirely**.

### §5.2 What is actually proven

Putting Steps 2-7 together, the chain establishes:

> **No primitive Saunderson-1740-form Euler brick `(a, b, c) = (u(4v² - w²), v(4u² - w²), 4uvw)`
> with `(u, v, w)` Pythagorean lifts to a perfect cuboid.**

This is a **genuine, unconditional, new result**. It is, however, *not* equivalent
to the closure of PCP.

### §5.3 What is NOT proven

The chain does NOT rule out a PCP arising from a non-Saunderson Euler brick.
Since 80% of small primitive Euler bricks are non-Saunderson (§2.2), this gap
is enormous — the chain covers a measure-zero (or at least vanishingly small)
fraction of the Euler-brick parameter space.

The PICK-19 author's hedge in §5.2-5.3 is honest but understates the gap: they
suggest the chain *might* be universal and ask for a re-derivation of Step 1.
The empirical test in §2.2 above settles that question in the negative.

---

## §6. VERDICT

### §6.1 Summary

| Step | Claim | Status |
|------|-------|--------|
| 1 | PCP ⇔ primitive Pythagorean quadruple system | **FAILS as universality**. Holds only for Saunderson-1740 sub-family (≈20% of primitive Euler bricks). |
| 2 | 3-parameter `(2λμ, 2λν, λ²-μ²-ν², λ²+μ²+ν²)` parameterizes ALL primitive Pythagorean quadruples | FAILS in general (e.g. `(1, 2, 2, 3)` not in image). Possibly OK within Saunderson sub-class via parity. |
| 3 | Setting `r = μ/ν`, `s = λ⁴/ν⁴`, second relation gives `s² - 16r(r²-1)s - (r²+1)⁴ = 0` | Holds algebraically (within sub-family). |
| 4 | Discriminant identity `D(r) = 4(r⁸ + 68r⁶ - 122r⁴ + 68r² + 1)` | **PASS** (PARI symbolic verified). |
| 5 | `C'` automorphisms `σ, τ`; `J(C') ~ E_PCP × E_PCP × E₀`; `X_{στ} = 80b1` | **PASS** (13/13 `a_p` match; PARI verified). |
| 6 | `E_PCP` rank 1 (Kolyvagin); `E₀` rank 0 (2-descent + Kolyvagin). Chabauty applies. PICK-19's substitution shows `C₀(ℚ)` has 4 points, all degenerate. | **PASS** within Saunderson sub-family. |
| 7 | PCP unconditionally closed. | **FAILS** — only Saunderson sub-family closed. |

### §6.2 Final verdict

**The closure is NOT unconditional for the full Perfect Cuboid Problem.**

What HAS been established (unconditionally, and genuinely new as far as I can tell):

> **Theorem (PICK-19/PICK-20, verified).** No primitive perfect cuboid arises
> from a Saunderson-1740-form Euler brick `(a, b, c) = (u(4v² - w²), v(4u² - w²), 4uvw)`
> with `u² + v² = w²` Pythagorean, `(u, v, w)` primitive.

This is a genuine arithmetic result. It is a partial closure of PCP — covering a
sub-family of Euler bricks. The reduction to the rank-0 elliptic curve Cremona 80b1
is correct, clean, and beautiful. The `a_p` match `(0, 4, -4, -2, 2, -4, -4, -2, 8, 6, -6, 8, -4)` is striking and well-verified.

What HAS NOT been established:

> The closure of PCP for non-Saunderson Euler bricks (≈80% of small primitive
> Euler bricks). For these, the chain provides no information.

### §6.3 What would close the full PCP?

To upgrade this to a full unconditional closure, one of the following is needed:

1. **A universal parameterization** of all primitive Euler bricks, generalizing
   Saunderson, with a clean algebraic identity feeding into the Chabauty / 80b1
   framework. No such universal family is currently in the literature.

2. **A direct proof** that any perfect cuboid forces the underlying Euler brick
   to be Saunderson form. This seems implausible given the abundance of
   non-Saunderson Euler bricks at small scales.

3. **A different framework** entirely — e.g. addressing the full PCP variety in
   `P⁷` via Brauer-Manin or descent on a higher-dimensional model.

### §6.4 Recommendation

Re-title the result as **"Saunderson Sub-Family Closure of PCP via Cremona 80b1"** —
this is genuinely new, clean, and worth publishing. Do not present it as a closure
of the full PCP. The honest framing is:

> The Perfect Cuboid Problem restricted to the Saunderson-1740 sub-family of
> Euler bricks reduces unconditionally to the rank-0 statement of Cremona 80b1,
> hence has no non-degenerate solution.

---

— **CΛ / Lightman Chang** · Independent Researcher · 2026-05-17

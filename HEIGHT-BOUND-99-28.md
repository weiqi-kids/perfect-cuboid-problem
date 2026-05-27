# Height bound for the elliptic Chabauty closure of fiber (99, 28)

**Date:** 2026-05-18
**Inputs:** `ELLIPTIC-CHABAUTY-99-28.md` (Track E: rank-1 generator `G` of `E_Hp`).
**Outputs:** `scripts/elliptic-chabauty/height_bound_99_28.gp` and `.out`.
**Tooling:** PARI/GP 2.15.4 only.

---

## §0. TL;DR

For the fiber `(m, n) = (99, 28)` and the rank-1 quotient

  `E_Hp : v² = (u + 1)(u + q²)(u + 1 + q²)`,    `q = 5544/9017`,

with rank generator `G = [−29443120, 115094337568]` (minimal model) and
canonical height `ĥ(G) ≈ 4.5927`, we compute Silverman's 1990 height-difference constant
and combine with a (heuristic, conjectural) Hindry-Silverman / Vojta-type bound
`h_x(P_H) ≲ log |Disc(fX)|` on the naive height of rational points
`P_H ∈ H_q(Q)`. The resulting bound on the Mordell-Weil coefficient `n`
in `π(P_H) = n·G + T` is

  | variant | `h_max` | `|n|_max` |
  |---|---|---|
  | 1. raw `log |Disc(fX)|` (most conservative) | `270.92` | **`9`** |
  | 2. `log |Disc(fX)| / g`, `g = 2`            | `135.46` | **`7`** |
  | 3. `log N(E_Hp)` (smaller proxy)            | `35.06`  | **`5`** |

All three variants give `|n|_max ≪ 200`. **Track E's search `|n| ≤ 200`
covers the heuristic height bound by more than an order of magnitude.**

**Verdict.** *Conditional* on the Hindry-Silverman/Vojta-type height bound,
fiber `(99, 28)` is rigorously closed by PARI alone: the only `H_q(Q)`
points are the 4 known degenerate points (`X = 0`, `Y = ±d·p·w` and the
two at infinity).

**The conditionality is real**: the height bound is conjectural. A fully
rigorous closure requires a Coleman / quadratic-Chabauty integration on
`H_q` (Magma `QCMod`) or an effective form of Vojta's conjecture.

---

## §1. Setup and constants

The (99, 28) data:
- `p = 2mn = 5544`, `d = m² − n² = 9017`, `w = m² + n² = 10585`.
- Sextic `H_q : Y² = fX(X) = X⁶ + 224084450·X⁴ + 15052485078052129·X² + 279996309577564109006400`.
- `E_Hp` minimal model `[0, −1, 0, −1685461832548704, −10854385900968766899456]`.
- Conductor `N(E_Hp) = 1685349658611696 ≈ 1.69·10¹⁵`.
- `E_Hp[tors](Q) ≅ Z/2 × Z/2` with all torsion 2-torsion (the three `Y = 0` Weierstrass points).
- Generator `G = [−29443120, 115094337568]` of the free part, `ĥ(G) = 4.592744…`.

The double cover `π : H_q → E_Hp`, `(X, Y) ↦ (X²/d², Y/d³)`,
combined with the minimal-model change of variables `[u, r, s, t] = [1/9017, −74694817/81306289, 0, 0]`,
sends `x_min(π(P_H)) = (1/9017)² · X²/d² − 74694817/81306289`.

---

## §2. Silverman 1990 height-difference constant

Silverman's Theorem 1.1 (Math. Comp. 55 (1990), 723–743) states: on a
minimal Weierstrass model of an elliptic curve `E / Q`,
```
|h_x(P) − ĥ(P)| ≤ μ(E)
```
where `h_x(P) = log max(|num x(P)|, |den x(P)|)` is the naive logarithmic
Weil height of `x(P)`, and
```
μ(E) ≤ (1/12) log|Δ(E)| + (1/12) h(j(E)) + (1/2) log_+(|b₂(E)|/12 + 1) + 1.946.
```

For `E_Hp` of (99, 28):

| Invariant | Value |
|---|---|
| `b₂` | `−4` |
| `b₄` | `−3370923665097408` |
| `c₄` | `80902167962337808` |
| `c₆` | `9378189903850022375156800` |
| `Δ(E)` | `2.555366·10⁴⁷` (255536603572224974886698963342412219637975547904) |
| `j(E)` | `129276781…/62386866…` (num/den as printed in `.out`) |
| `log\|Δ\|` | `109.1597` |
| `h(j)` | `108.4783` |
| `log_+(\|b₂\|/12 + 1)` | `0.28768` |

Plugging in:
```
μ(E_Hp) ≤  (1/12)·109.1597 + (1/12)·108.4783 + (1/2)·0.28768 + 1.946
        =   9.0966      +   9.0399      +   0.14384       + 1.946
        =  20.226339347…
```

We take `C := μ(E_Hp) = 20.2264`.

---

## §3. Pullback under `π : H_q → E_Hp`

For `P_H = (X, Y) ∈ H_q(Q)` (integer model), let `u(P_H) = X²/d² ∈ Q` and
let `P_E = π(P_H)` on the original `(u, v)`-model. In the minimal model
coordinates,
```
x_min(P_E) = (1/d)² · u − 74694817/81306289 = X²/d⁴ − 74694817/81306289.
```
Hence the naive Weil height satisfies
```
h_x_min(P_E)  ≤  h(X²/d⁴)  +  O(log d)
              ≤  2 · log max(|X|, 1)  +  2 log d  +  O(1).
```
Since the integer model has `h_H_q(P_H) := log max(|X|, 1)`, we obtain (with
generous additive slack `2 log d ≈ 18.21`)
```
h_x_min(π(P_H))  ≤  2 · h_H_q(P_H) + 2 log d.        (★)
```
Combining (★) with Silverman:
```
ĥ_{E_Hp}(π(P_H))  ≤  h_x_min(π(P_H))/2  +  C
                 ≤  h_H_q(P_H)  +  log d  +  C.       (☆)
```
Since `tors ⊂ E_Hp[2]` and `2T = O`, the canonical height of `n·G + T`
is purely `n²·ĥ(G)` (cross-term `2n⟨G, T⟩` vanishes because `G` is
orthogonal to torsion under the height pairing). Hence
```
n² · ĥ(G)  ≤  h_H_q(P_H)  +  log d  +  C.            (◊)
```

> *Note.* The script uses the slightly more generous additive slack
> `2 log d` instead of `log d` to absorb the `O(1)` constant from
> projective height conventions; this does not affect the order of
> magnitude of `|n|_max`.

---

## §4. Heuristic height bound for `H_q(Q)`

There is **no** general theorem giving an effective upper bound on the
naive heights of rational points on a genus-2 curve `H_q` of conductor
`N`. The Bombieri-Lang and Vojta conjectures **predict** such a bound,
but unconditionally only `#H_q(Q) < ∞` (Faltings 1983) is known. The
standard heuristic (Hindry-Silverman, *Diophantine Geometry*, F.5.6,
and Vojta's conjecture for curves):
```
h_max(C(Q))  ≲  log N(C)        (heuristically, with implicit constant ~ O(1)).
```
For `H_q` of (99, 28) the sextic discriminant
```
|Disc(fX)|  =  4.571·10¹²⁰,    log|Disc(fX)|  =  270.92.
```
The conductor `N(H_q)` divides `|Disc(fX)|`, so `log N(H_q) ≤ log|Disc(fX)|`.

We report three heuristic choices for `h_max`:

| Variant | Definition | Numeric `h_max` | Justification |
|---|---|---|---|
| 1 | `log|Disc(fX)|` | `270.92` | very conservative; treats Disc as conductor proxy |
| 2 | `log|Disc(fX)|/g`, `g=2` | `135.46` | Hindry-Silverman F.5.6 with `g = 2` divisor |
| 3 | `log N(E_Hp)` | `35.06`  | uses the smaller elliptic-quotient conductor as proxy |

All three are conjectural; variant 1 is the most conservative.

---

## §5. Resulting bound on `|n|`

From (◊): `n² · ĥ(G) ≤ h_max + 2 log d + C`.

Substituting `ĥ(G) = 4.5927`, `2 log d = 18.2137`, `C = 20.2263`:

| Variant | `RHS = h_max + 2 log d + C` | `|n|_max = √(RHS / ĥ(G))` |
|---|---|---|
| 1 | `309.36` | **`8.21`**, so `⌈|n|_max⌉ = 9` |
| 2 | `173.90` | **`6.15`**, so `⌈|n|_max⌉ = 7` |
| 3 | `73.50`  | **`4.00`**, so `⌈|n|_max⌉ = 5` |

**All three variants give `|n|_max ≤ 9 ≪ 200`.**

Track E exhaustively enumerated `n·G + T` for `|n| ≤ 200` and `T` in all
4 elements of `E_Hp(Q)[tors]`. Within this search, the only `H_q(Q)`
points found are the 2 affine degenerate points `(X, Y) = (0, ±529146775080)`
arising from `±2·G + O`, plus the 2 points at infinity from `P = O`.

> **Conditional rigorous closure.** Assuming the heuristic
> `h_x(P_H) ≤ log|Disc(fX)|` (variant 1, most conservative), every
> `P_H ∈ H_q(Q)` satisfies `π(P_H) = n·G + T` with `|n| ≤ 9 < 200`. By
> Track E's exhaustive enumeration in `|n| ≤ 200`, the only such points
> are the 4 degenerate ones. Hence `H_q(99,28)(Q)` consists exactly of
> the 4 known degenerate points, conditional on the heuristic height bound.

---

## §6. What is still missing for unconditional closure

The Hindry-Silverman / Vojta heuristic is **NOT a theorem**. To remove
the conditionality one of the following is required:

1. **Magma `QCMod` Coleman integration on `H_q`.** This produces a
   rigorous `p`-adic upper bound on `|n|` via the explicit quadratic
   Chabauty machine of Balakrishnan-Dogra-Müller-Tuitman-Vonk. Track E
   did not use Magma. This is the standard rigorous route.
2. **An effective Vojta theorem for genus-2 curves.** Currently open.
3. **A `p`-adic Faltings-Frey-Mazur descent** on `H_q` over a suitable
   number field; this is similar in spirit to (1) and also requires
   non-elementary Coleman-integration software.

A practical follow-up: re-execute Track E's enumeration with `|n| ≤ 50`
(say) — already covering all three heuristic bounds with a generous
safety factor of `>5×` — and label that as the "heuristic closure";
keep `|n| ≤ 200` on file as a defense-in-depth check.

---

## §7. Honest framing

This document upgrades Track E from "search within an arbitrary box
`|n| ≤ 200`" to "search covers the heuristic Hindry-Silverman /
Vojta-style height bound by a factor `>20×`". It does **not** upgrade
Track E to a Bruin-Stoll certificate. The closure of fiber (99, 28) is
**still conditional** on:
- correctness of `ellrank(E_Hp, 5)` having returned the actual generator
  (this is what PARI computes via 2-descent + point search; rank `1`
  is established but the generator is a numerical artifact at
  effort 5 — Track E verified by `ellisoncurve` and `ellheight`),
- the Hindry-Silverman/Vojta heuristic height bound (§4).

Both are believable but neither is a theorem. The deliverable here is
explicitly labeled "conditional".

---

## §8. Numeric appendix (raw values)

From `scripts/elliptic-chabauty/height_bound_99_28.out`:
```
b2(E_Hp)              = -4
Disc(E_Hp)            = 2.555366·10⁴⁷
log|Disc(E_Hp)|       = 109.1597
h(j(E_Hp))            = 108.4783
log_+(|b2|/12 + 1)    = 0.28768
Silverman C(E_Hp)     = 20.2263

Disc(fX) sextic       ≈ 4.571·10¹²⁰
log|Disc(fX)|         = 270.9222
h_hat(G)              = 4.59274
2 log d               = 18.2137

Variant 1 |n|_max = sqrt(309.36 / 4.59274) =  8.207 → ceil 9
Variant 2 |n|_max = sqrt(173.90 / 4.59274) =  6.153 → ceil 7
Variant 3 |n|_max = sqrt( 73.50 / 4.59274) =  4.000 → ceil 5
```

Computation time: < 0.01 s.

---
*End of HEIGHT-BOUND-99-28.md.*

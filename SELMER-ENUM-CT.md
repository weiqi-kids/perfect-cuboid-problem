---
title: PCP — Phase α + β on E_Hm for the (61, 38) Borderline Fiber
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-19
status: PARTIAL — Phase α (Direct Selmer enumeration) **complete**: dim_F2 S²(E_Hm/Q) = 4, with 16 explicit Selmer triples computed by bypassing `ell2cover` normalization. Validated on T1, T4. Phase β (Cassels–Tate matrix) **inconclusive in PARI 2.15.4**: the candidate Hilbert-symbol formulas `Σ_v (α_i, β_j)_v` evaluate to 0 by Hilbert reciprocity for any choice of `(i, j)` pairs — these are not the actual CT pairing, which requires local point representatives on each Selmer cover at each bad prime (true second descent). Rank gap `rk(E_Hm) ∈ {0, 2}` remains open in PARI; reaffirmed strong heuristic case for `rk = 0`.
---

# Direct 2-Selmer Enumeration + Cassels–Tate Attempt on E_Hm

**Author:** CΛ / Lightman Chang · 2026-05-19

## §1. Mission and setup

`E_Hm` is the short-Weierstrass elliptic curve attached to the (61, 38) borderline Pythagorean cuboid fiber:

```
Y² = X³ + X² − 67227419070207276256338598560·X
   + 6628115691375808745402467380840123868670208
```

Rational 2-torsion at `e₁ = −298991117938864`, `e₂ = 136054851567711`, `e₃ = 162936266371152` with

| difference | factorisation                              |
|------------|--------------------------------------------|
| e₂ − e₁    | 5²·7·31·223·337·1033²                      |
| e₃ − e₁    | 2⁸·19⁴·61⁴  (a perfect square)             |
| e₃ − e₂    | 3⁸·11⁴·23⁴  (a perfect square)             |

Bad primes: `BAD = {2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033}` (12 primes). Factor base with sign: `F = {−1} ∪ BAD` (13 elements).

PARI 2.15.4's `ell2cover(E_Hm)` returns 4 quartic covers, suggesting `dim_F2 S²(E_Hm/Q) = 4`. Prior phases (F, G, H) yield `rk(E_Hm) ∈ {0, 2}` rigorously but cannot distinguish. The decisive computation is the Cassels–Tate matrix on `S² / image(E(Q))`. The mission is to **bypass `ell2cover` normalization** by direct Selmer enumeration, then attempt the CT matrix.

## §2. Phase α — Direct Selmer enumeration

### §2.1 Algorithm

For each candidate triple `(d₁, d₂, d₃) ∈ (Q*/Q*²)³` with `d₁·d₂·d₃ ∈ Q*²` and each `dᵢ` represented by a squarefree integer supported on `F`:

1. **Sign condition** (R-solubility): with `e₁ < e₂ < e₃`, the only valid sign patterns are `(+, +, +)` and `(+, -, -)` (the other patterns give either `(X-e₁)(X-e₂)(X-e₃) < 0` or product not ±1 mod squares).
2. **p-adic local solubility** at each `p ∈ BAD`: there must exist `X ∈ Q_p` with `(X − eᵢ)/dᵢ ∈ Q_p^{*2}` for `i = 1, 2, 3`.

The local image `L_p ⊂ (Q_p^*/Q_p^{*2})³` is precomputed via **stratified enumeration**: for each prime p, enumerate `X` in two strata
- generic (`X mod p` avoiding `e_i mod p`)
- near-`e_i` (`X = e_i + p^k · u`, `k = 0..2M+2`, `u` a unit mod `p^{2M+3−k}`)

where `M = max_{i≠j} v_p(e_i − e_j)`. Each `X` contributes the class triple `(class(X−e_i, p))_{i=1,2,3}`. The three 2-torsion limit classes and the identity are added explicitly.

For p odd, square classes form `(Z/2)²` (val mod 2, NR-bit); for p=2, `(Z/2)³` (val mod 2, unit mod 8 in {0,1,2,3}). The CLASS encoding is bit-packed (6 bits for p odd, 9 bits for p=2). `L_p` is stored as a bitmap. Class of `d_i ∈ Q^*` is computed once via factor-base lookup; for any `d = ∏ F[k]^{ε_k}`, `class_p(d) = XOR_{ε_k=1} class_p(F[k])`. Per-candidate check is O(BAD) bit operations.

### §2.2 Validation

| Curve                    | rank | dim S² claimed | dim S² found | triples (in Phase α output) |
|--------------------------|------|---------------|--------------|------------------------------|
| T1: y²=x(x−1)(x−2)       | 0    | 2             | **2** (|S²|=4) | `(1,1,1), (1,-1,-1), (2,1,2), (2,-1,-2)` ✓ |
| T4: y²=x(x−7)(x+7)       | 1    | 3             | **3** (|S²|=8) | includes `(2,1,2) ↦ G=(25,120)` ✓ |

Both validations match expected.

### §2.3 E_Hm result

Wall time:
- Local images: ~14s (sum of per-p stratified enumeration).
- Triple enumeration over `(d₁, d₂) ∈ 2^13 × 2^13 = 67M` pairs: ~98s.

**Result:** `|S²(E_Hm/Q)| = 16`, hence `dim_F2 S²(E_Hm/Q) = 4`. This **confirms** the prior framework's claim (and CONTRADICTS the user-prompt's `dim S² = 6` figure, which appears to be a transcription error).

Combined with `dim_F2 E(Q)/2E(Q) = rk + dim_F2 (E(Q)_tors / 2 E(Q)_tors) = rk + 2` (since `E_Hm.tors = Z/8 × Z/2`, hence `T/2T = (Z/2)²`), the exact sequence

```
0 → E(Q)/2E(Q) → S²(E/Q) → Sha(E/Q)[2] → 0
```

gives `rk + 2 + dim_F2 Sha[2] = 4`, so **`rk + dim_F2 Sha[2] = 2`**.

With parity `w = +1` (rk even) and `dim Sha[2]` even (alternating CT pairing on Sha[2]):

- `(rk, Sha[2]) ∈ { (0, 2), (2, 0) }`.

### §2.4 Explicit 16 Selmer triples

```
S² = {
  (1, 1, 1),                                           ← δ(O) and δ((e₃,0)) (in 2E(Q))
  (1, -759, -759),
  (8012167, 6913, 1159),
  (8012167, -5246967, -879681),
  (2734081, -2359, -1159),
  (2734081, 1790481, 879681),
  (16307767, -16307767, -1),                           ← δ((e₁,0)) and δ((e₂,0))
  (16307767, 12377595153, 759),
  (10330, -15495, -6),
  (10330, 1306745, 506),
  (82765685110, -107116935, -6954),
  (82765685110, 9033528185, 586454),
  (28243056730, 36552705, 6954),
  (28243056730, -3082611455, -586454),                 ← S1 from prior phase G (δ of order-8 lift)
  (168459233110, 252688849665, 6),
  (168459233110, -21310092988415, -506)
}
```

**Torsion image identification:**

`E_Hm.tors = Z/8 × Z/2`, generated by an order-8 element `T₈` and the rational 2-torsion `T₂ = (e_i, 0)`. The 2-descent map δ gives:

- δ(O) = δ((e₃, 0)) = `(1, 1, 1)` — since `e₃ − e_i` are perfect squares for both `i ∈ {1, 2}`, so `(e₃, 0) ∈ 2 E(Q)`.
- δ((e₁, 0)) = δ((e₂, 0)) = `(16307767, -16307767, -1)` — these collapse to one class because `e₂ − e₁ = e₁ − e₂` mod sq and `e₃ − e₁ ≡ e₃ − e₂ ≡ 1 mod sq`.
- δ(T₈) = `(28243056730, -3082611455, -586454)` (the "S1" class from prior Phase G, recovered from cover #1 at x=0).

So the **image of δ on E_Hm(Q)_tors / 2 E(Q)_tors** has dim 2, generated by

```
β₁ := δ(T₂) = (16307767, -16307767, -1)
β₂ := δ(T₈) = (28243056730, -3082611455, -586454)
```

### §2.5 F₂-basis of S² / image(E(Q)_tors)

Choose any 2 triples linearly independent from {β₁, β₂} as completions; pick

```
β₃ = (1, -759, -759)        \\ supported on {3, 11, 23, -1}
β₄ = (8012167, 6913, 1159)  \\ supported on {19, 31, 61, 223}
```

`{β₁, β₂, β₃, β₄}` is an F₂-basis of `S²(E_Hm/Q)` (verified by `matrank` over F₂).

In `S²/image(E(Q)_tors)`, the quotient is 2-dim and the residue classes `[β₃], [β₄]` form a basis. The CT pairing restricted to this 2-d space is the decisive object.

## §3. Phase β — Cassels–Tate pairing attempt

### §3.1 Decision rule

`CT` is bilinear, alternating, and well-defined on `V := S²(E)/image(δ E(Q))`. Properties:

- `dim V = dim S² − dim image(δ E(Q)) = dim Sha[2]`.
- `CT` is **non-degenerate on Sha[2]**, so `rank(CT|_V) = dim Sha[2]`.

Computational route: compute `CT` on `V₀ := S²/image(δ E(Q)_tors)` (2-dim, basis `[β₃], [β₄]`). Then:

- `rank(CT|_{V₀}) = 2` ⟹ `V₀ ⊂ V`, `Sha[2] = (Z/2)²`, `rk(E_Hm) = 0`. **(61, 38) CLOSEABLE.**
- `rank(CT|_{V₀}) = 0` ⟹ the rank component of `E(Q)/E(Q)_tors` covers `V₀`, `rk(E_Hm) = 2`. **(61, 38) PERMANENTLY EXITS GENUS-2 TIER.**

The CT matrix on the 2-d basis has 1 independent entry: `c := CT([β₃], [β₄])` ∈ F₂. The 2×2 matrix is

```
[0  c]
[c  0]
```

with rank `2` if `c = 1`, rank `0` if `c = 0`.

### §3.2 Hilbert-symbol formulas all evaluate to 0 by reciprocity

Several "Schaefer-style" formulas were tried at the level of triples
`α = (a₁, a₂, a₃)`, `β = (b₁, b₂, b₃)`:

| Formula | Per-place expression | Σ_v? |
|---------|----------------------|------|
| A | `(a₁, b₂)_v + (a₂, b₃)_v + (a₃, b₁)_v` | Σ_v = 0 (Hilbert reciprocity for each term) |
| B | `(a_i, b_j)_v` for all 6 off-diagonal pairs | Σ_v = 0 |
| C | `(a₁, b₂)_v + (a₂, b₁)_v + (a₃, b₃)_v` | Σ_v = 0 |
| D | `(a₁, b₁b₂b₃)_v + (a₂, b₁b₂b₃)_v + (a₃, b₁b₂b₃)_v` | Σ_v = 0 (since `b₁b₂b₃` square) |

**Hilbert reciprocity:** `Σ_v (a, b)_v = 0` (in F₂) for any `a, b ∈ Q*`. Any formula consisting purely of a sum `Σ_v Σ_{(i,j)} (aᵢ, bⱼ)_v` over a fixed set of `(i, j)` pairs (each summed over all v) is **identically zero**, regardless of the choice of `(i, j)` pairs.

Hence all the "naive Schaefer" formulas give the zero matrix — they're not the actual CT pairing.

The **actual** CT pairing requires a local correction at each bad prime: a witness point `P_α(v) ∈ E(Q_v)` realizing `δ_v(P_α(v)) = α_v` such that `⟨α, β⟩_v = inv_v(α ∪ β)` is computed against `P_α(v)`, not against α's global representative alone. This is essentially **second 2-descent** at each bad prime, which is what `ell2cover` doesn't expose explicitly in PARI 2.15.4 (and what Magma's `CasselsTatePairing` implements).

### §3.3 Matrix (all four variants)

In our final basis `{β₁, β₂, β₃, β₄}` (with `β₁ = δ(T₂)`, `β₂ = δ(T₈)`):

```
M_CT = [[0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]]   (rank = 0)
```

— same matrix for variants A, B, C, D. This is **not informative** because the formulas are wrong; rank-0 here does NOT mean rk(E_Hm) = 2.

### §3.4 Verdict: Phase β fails in PARI 2.15.4

The Cassels–Tate matrix cannot be computed in PARI 2.15.4 without implementing local witness construction for each Selmer cover at each bad prime — the same obstruction noted in `4DESCENT-PHASE-FGH.md` §2.4. Phase α has produced the explicit Selmer triples that Magma's `CasselsTatePairing` would consume, but the actual pairing requires the second-descent infrastructure.

## §4. Status update for (61, 38)

### §4.1 What is rigorously established

- **`dim_F2 S²(E_Hm/Q) = 4`** (4 covers, 16 elements as explicit `(d₁, d₂, d₃) ∈ (Q*/Q*²)³`). This is computed **independently** of `ell2cover`'s normalization, by direct enumeration.
- **`rk(E_Hm) ∈ {0, 2}`** with `dim Sha[2] = 2 − rk`.
- Phase F (B=10⁸ search over integer x on all 4 covers): zero non-torsion lifts. Empirical canonical-height bound ~35. **STRONG HEURISTIC evidence for rk = 0**.

### §4.2 What is missing

- The decisive bit `c = CT([β₃], [β₄]) ∈ F₂` cannot be computed in PARI 2.15.4.
- Equivalent routes:
  - Construct an explicit Q_p-point on cover `C_{β₃}` and `C_{β₄}` at each bad p (12 + ∞ = 13 places), then pair via local Brauer invariants.
  - Run a true 4-descent on cover #3 or #4 (Magma `FourDescent`).
  - Run Magma `CasselsTatePairing(E_Hm)` directly.

### §4.3 (61, 38) closure status — UNCHANGED

Genus-2 closure of the (61, 38) borderline fiber **remains conditional** on `rk(E_Hm) ≤ 1`. Equivalent question: is the CT pairing on `S²/torsion-image` trivial (rk=2 case) or non-degenerate (rk=0 case)?

- **Strong heuristic case for closure (rk = 0)**: Phase F sees zero non-torsion lifts on all 4 covers up to `|x| ≤ 10⁸`.
- **Phase α delivers the input to Magma**: 16 explicit Selmer triples, basis-of-S²/torsion-image identified, ready for Magma's `CasselsTatePairing` to deliver the single decisive F₂ bit.

**Conclusion**: The (61, 38) fiber remains BORDERLINE in the rigorous sense, with strong heuristic evidence for `rk(E_Hm) = 0` and genus-2 closeability. The 16 explicit Selmer triples are now available — significantly reducing what Magma needs to do.

## §5. Files

| Path | Content |
|------|---------|
| `scripts/4-descent/selmer_enum.gp` (+`.out`) | Naive (slow) Selmer enumeration with T1, T4 validation |
| `scripts/4-descent/selmer_enum_fast.gp` (+`.out`) | Bit-packed-class enumeration, ~98s wall on E_Hm |
| `scripts/4-descent/EHm_selmer_results.txt` | The 16 explicit Selmer triples |
| `scripts/4-descent/cassels_tate_matrix.gp` (+`.out`) | Multi-variant Hilbert-symbol formulas, all identically 0 |

## §6. Open follow-ups

1. **Magma `CasselsTatePairing`** on E_Hm with our basis `{β₁, β₂, β₃, β₄}` — single decisive computation; rank gap closes in either direction.
2. **Local witness construction in PARI** — implementing for each (α, p) a `P_p ∈ E(Q_p)` with `δ_p(P_p) = α_p`. This is doable but requires careful Hensel lifting at bad primes; estimated ~500 lines of PARI code and ~1 day work.
3. **Heegner approach** — `ellL1` to high precision OR Heegner point construction. Conductor `~1.48·10¹⁷` is at the edge of PARI 2.15.4's L-function capability.

## §7. Honest summary

Phase α **succeeds**: 16 explicit Selmer triples for `E_Hm`, `dim S² = 4`. This is a strict refinement of prior work and directly enables Magma's CT pairing.

Phase β **fails in PARI 2.15.4**: the naive Hilbert-symbol formulas are all identically zero by reciprocity, and the proper formula requires local witness construction (second descent) not available in PARI.

The (61, 38) fiber remains BORDERLINE; the Phase α output puts us one Magma call away from rigorous closure (or rigorous exit) of this fiber.

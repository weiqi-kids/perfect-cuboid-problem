---
title: "PCP — Cassels–Tate Bit ⟨β₃, β₄⟩ for E_Hm (61, 38) — Two Formulas Tried; Decisive Bit OPEN in PARI 2.15.4"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-19
status: HONEST FAILURE REPORT — (i) The witness-based Hilbert-symbol formula (Stamminger 5.13 paraphrase) is PROVABLY identically 0 by Hilbert reciprocity, regardless of witness choice. (ii) An alternative "local solubility of the 4-cover D_{β₃, β₄}" gives 1 but fails 4 of 9 torsion-image sanity checks. Decisive bit ⟨β₃, β₄⟩ NOT determined; (61, 38) closure status UNCHANGED, strong heuristic case for rk(E_Hm) = 0 remains.
---

# Cassels-Tate Bit ⟨β₃, β₄⟩ — Computation Attempts and Honest Negative Result

**Author**: CΛ / Lightman Chang · Independent Researcher · 2026-05-19

## §1. Goal

`SELMER-ENUM-CT.md` reduced the (61, 38) borderline determination to a
single F₂ bit:
$$
\langle \beta_3, \beta_4 \rangle \in \mathbb{F}_2,
$$
where on the F₂-basis of `S²(E_Hm/Q) / δ(E_Hm(Q)_{\rm tors})`:

```
β₃ = (1, -759, -759)         supported on {-1, 3, 11, 23}
β₄ = (8012167, 6913, 1159)   supported on {19, 31, 61, 223}
```

Both products are perfect squares in Q* (verified — `d₁d₂d₃ = 759²` for β₃ and `= 8012167²` for β₄).

**Decision rule:**
- `⟨β₃, β₄⟩ = 0` → `rk(E_Hm) = 2`, (61, 38) PERMANENTLY exits genus-2 tier.
- `⟨β₃, β₄⟩ = 1` → `rk(E_Hm) = 0`, (61, 38) BECOMES CLOSEABLE.

E_Hm short Weierstrass with 2-torsion `e₁ = -298991117938864, e₂ = 136054851567711, e₃ = 162936266371152`. Bad primes `BAD = {2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033}`.

## §2. Approach A — Witness-based Hilbert-symbol formula (PROVABLY identically zero)

The prompt prescribes (paraphrasing Stamminger 5.13):

> For each place `v ∈ BAD ∪ {∞}`, find a local witness `X_v ∈ Q_v` with
> `(X_v - e_i)/d_i(α) ∈ (Q_v*)²` for `i = 1, 2, 3`.
> Local contribution: `c_v = Σ_i hilbert_F2(X_v - e_i, d_i(β), v) ∈ F_2`.
> Global pairing: `⟨α, β⟩ = Σ_v c_v mod 2`.

### §2.1 Theorem (negative)

The above formula is identically 0 mod 2 for any α, β ∈ Sel²(E/Q), regardless of which local witnesses X_v are chosen.

**Proof.** A witness `X_v` satisfies `(X_v − e_i)/d_i(α) ∈ (Q_v*)²`, i.e.
`X_v − e_i = d_i(α) · u_{i,v}²` for some `u_{i,v} ∈ Q_v*`.
The Hilbert symbol is invariant under squaring the first slot, hence:

```
(X_v − e_i, d_i(β))_v = (d_i(α) · u_{i,v}², d_i(β))_v = (d_i(α), d_i(β))_v.
```

So `c_v = Σ_i (d_i(α), d_i(β))_v` at each v. Summing over v:

```
⟨α, β⟩ = Σ_v Σ_i (d_i(α), d_i(β))_v
       = Σ_i Σ_v (d_i(α), d_i(β))_v
       = Σ_i 0                              (Hilbert reciprocity, each global pair)
       = 0   identically.   ∎
```

This generalises the §3.2 observation in `SELMER-ENUM-CT.md` ("all naive Schaefer formulas evaluate to 0 by reciprocity"). The local-witness adjustment doesn't break the reciprocity because the witness gets absorbed into the squares.

### §2.2 Concrete data — local witnesses for β₃

Script `scripts/4-descent/ct_bit_61_38.gp` implements the formula faithfully and computes explicit witnesses for β₃ at each place:

| Place v | Local witness X_v for β₃            |
|---------|-------------------------------------|
| ∞       | -162936266371153/2 ∈ (e₁, e₂)       |
| 2       | 136054851567712                     |
| 3       | -298991117938857                    |
| 5       | -298991117938848                    |
| 7       | -298991117938860                    |
| 11      | -298991117938855                    |
| 19      | -298991117938863                    |
| 23      | -298991117938846                    |
| 31      | -298991117938863                    |
| 61      | -298991117938860                    |
| 223     | -298991117938862                    |
| 337     | -298991117938863                    |
| 1033    | -298991117938862                    |

Each was verified by checking `(X_v − e_i)/d_i(β₃) ∈ (Q_v*)²` for all i = 1, 2, 3 in PARI.

### §2.3 Per-place witness-formula output

```
v       | h_1  h_2  h_3 | c_v
--------+---------------+----
∞       |  0    0    0  |  0
2       |  0    0    0  |  0
3       |  0    0    0  |  0
5       |  0    0    0  |  0
7       |  0    0    0  |  0
11      |  0    0    0  |  0
19      |  0    0    0  |  0
23      |  0    0    0  |  0
31      |  0    0    0  |  0
61      |  0    0    0  |  0
223     |  0    0    0  |  0
337     |  0    0    0  |  0
1033    |  0    0    0  |  0

Witness-formula ⟨β₃, β₄⟩ = 0   (identically by Hilbert reciprocity)
Cross-check ⟨β₄, β₃⟩       = 0   (matches; consistent within trivial answer)
```

The bit "0" produced by the witness formula is a TAUTOLOGY of the formula's reciprocity-degeneracy, not the genuine CT pairing.

### §2.4 Algebraic check (simplification)

For β₃ = (1, -759, -759), the formula collapses to `(-759, d_2(β_4) · d_3(β_4))_v` at each v (using `d_1(β_3) = 1`). And `d_2(β_4) · d_3(β_4) = 6913 · 1159 = 8012167 = d_1(β_4)` mod squares (a manifestation of the Selmer constraint `d_1 d_2 d_3 ∈ (Q*)²` for β_4). So:

```
c_v = hilbert(-759, 8012167, v)
```

and `Σ_v hilbert(-759, 8012167, v) = 0` by reciprocity. ⟨β_3, β_4⟩ ≡ 0 is forced.

## §3. Approach B — Local solubility of the 4-cover D_{β₃, β₄} (returns 1, but FAILS sanity)

Script `scripts/4-descent/ct_4cover_full.gp`.

### §3.1 Setup

The 4-cover encodes both β₃ and β₄ jointly:
```
v_1² = X - e_1
v_2² = -759 (X - e_2)
w_1² = 8012167 (X - e_1)
w_2² = 6913 (X - e_2)
```
At a "generic" Q_v-point (all v_i, w_i ≠ 0), combining gives
`(w_1/v_1)² = 8012167`, `(w_2/v_2)² = -6913/759`. So generic-Q_v existence requires
```
T = (T_1, T_2, T_3) := (d_i(β_3) · d_i(β_4))_i = (8012167, -5246967, -879681)
```
all to be Q_v-squares.

(`T` is the pull-back of β₄ to the cover C_{β₃}; explicit verification: `T` matches the Selmer triple `S²[4] = (8012167, -5246967, -879681)` from the explicit enumeration.)

Degenerate branches X = e_j (j ∈ {1, 2, 3}): require `(e_j - e_i)/d_i(β_3)` AND `(e_j - e_i)/d_i(β_4)` both Q_v-squares for each i ≠ j.

### §3.2 Per-place local solubility table

| v   | Generic | X=e₁ | X=e₂ | X=e₃ | Soluble | Obstruction |
|-----|---------|------|------|------|---------|-------------|
| ∞   | 0       | 0    | 0    | 0    | 0       | **1**       |
| 2   | 0       | 0    | 0    | 0    | 0       | **1**       |
| 3   | 0       | 0    | 0    | 0    | 0       | **1**       |
| 5   | 0       | 0    | 0    | 0    | 0       | **1**       |
| 7   | 1       | 0    | 0    | 1    | 1       | 0           |
| 11  | 0       | 0    | 0    | 0    | 0       | **1**       |
| 19  | 0       | 0    | 0    | 0    | 0       | **1**       |
| 23  | 0       | 0    | 0    | 0    | 0       | **1**       |
| 31  | 0       | 0    | 0    | 0    | 0       | **1**       |
| 61  | 0       | 0    | 0    | 0    | 0       | **1**       |
| 223 | 0       | 0    | 0    | 0    | 0       | **1**       |
| 337 | 1       | 0    | 0    | 1    | 1       | 0           |
| 1033| 0       | 0    | 0    | 0    | 0       | **1**       |

Sum of obstructions = 11 ≡ **1 mod 2**. The Approach-B "answer" is `⟨β₃, β₄⟩ = 1`.

### §3.3 Sanity check — torsion-image pairings (Approach B FAILS)

Let `β₁ = (16307767, -16307767, -1)` (image of `(e₁, 0)`) and `β₂ = (28243056730, -3082611455, -586454)` (image of order-8 generator). The CT pairing vanishes on the image of E(Q), so:

| Pair       | Approach-B output | Expected |
|------------|-------------------|----------|
| ⟨β₃, β₃⟩    | 0                 | 0 ✓ (alternating) |
| ⟨β₄, β₄⟩    | 0                 | 0 ✓ |
| ⟨β₁, β₁⟩    | 0                 | 0 ✓ |
| ⟨β₂, β₂⟩    | 0                 | 0 ✓ |
| ⟨β₁, β₃⟩    | 0                 | 0 ✓ |
| ⟨β₂, β₃⟩    | **1**             | 0 ✗ |
| ⟨β₁, β₄⟩    | **1**             | 0 ✗ |
| ⟨β₂, β₄⟩    | **1**             | 0 ✗ |
| ⟨β₁, β₂⟩    | **1**             | 0 ✗ |

**4 out of 9 sanity checks FAIL.** Approach B does NOT compute the true Cassels–Tate pairing.

### §3.4 Diagnosis of Approach B

The "local solubility of D_{α, β} at v" is NOT the same as the local CT invariant `inv_v(α ∪ β)`. The 4-cover D_{α, β} is locally soluble at v iff the pull-back of β to C_α (= the class `T` mod squares) is locally in the image of `C_α(Q_v) / 2 C_α(Q_v)` in `(Q_v*/Q_v*²)³`.

My "generic" branch requires `T` to be the IDENTITY class `(1, 1, 1)` in `(Q_v*/Q_v*²)³`, which is strictly stronger than `T` being in the local Selmer image. So Approach B over-counts obstructions at places where `T` is a non-identity element of the local Selmer image.

Approach B is computing some quantity related to (but not equal to) `dim_{F₂} (T mod local Selmer image at v)` summed over v, which doesn't have the right local-global properties to be CT.

## §4. What WOULD work

The correct formula for CT in the full 2-torsion case (Cassels 1998 *Invent. Math.* Theorem 1.2, Schaefer-Stoll 2004, Stamminger 2005 thesis §5):

`<α, β>_v = inv_v(α ∪ β) ∈ ½ Z / Z`

where `α ∪ β ∈ H²(K_v, Z/2) = Br(K_v)[2]` is the cup product in Galois cohomology. The cup product depends on EXPLICIT 1-cocycle representatives of α and β over Q_v — specifically, on the COVER STRUCTURE C_α (and not just its Selmer triple). PARI 2.15.4 exposes the cover quartic via `ell2cover` but NOT the cocycle, so the cup product cannot be assembled directly.

**Decisive routes:**

1. **Magma `CasselsTatePairing(E_Hm)`** — one command on the explicit basis `{β₁, β₂, β₃, β₄}` produces the 4×4 F₂ matrix; the (3, 4) entry is the bit.
2. **Explicit FourDescent in PARI** — implement `Cremona-Stoll FourDescent` from scratch (~500–2000 lines of careful number-theoretic code). Multi-week project.
3. **High-precision `ellL1`** — compute `L'(E_Hm, 1)` to ~50 digits; nonzero ⇒ rk = 0 (BSD-conditionally on rk ≤ 1, which would rule out rk = 2 since rk = 2 forces `L'(E,1) = 0`). Conductor `~1.48·10^17` puts this at the edge of PARI 2.15.4 capabilities; effort 3 at realprecision 50 timed out at 600s in prior session.

## §5. Empirical case (UNCHANGED from `SELMER-ENUM-CT.md`, `4DESCENT-PHASE-FGH.md`)

Independent of CT computation, the empirical evidence strongly favors `rk(E_Hm) = 0`:

- **Phase F**: 0 non-torsion lifts on any of the 4 Selmer covers, |x| ≤ 10⁸, ~35 min wall. Canonical-height coverage ~35.
- **Phase H**: Jac(C_k) ≅ E_Hm for each k; `ellrank(E_Hm) = [0, 2]` reaffirmed at effort up to 9.
- BSD parity: root number `w = +1`, analytic rank even, consistent with `rk = 0`.
- Heuristics: for conductor `~10^17` with full 2-torsion, generators of rank-2 curves typically have canonical height in [0.1, 30]; our search to 35 covered this range.

These strongly suggest `⟨β₃, β₄⟩ = 1` (Sha[2] = (Z/2)², rk = 0). But this is heuristic, not proof.

## §6. (61, 38) closure status — UNCHANGED

- **Rigorous**: `rk(E_Hm) ∈ {0, 2}`, `dim_F₂ Sha[2] ∈ {0, 2}`.
- **Strong heuristic**: `rk(E_Hm) = 0` (Phase F + heuristic distribution).
- **Decisive bit `⟨β₃, β₄⟩`**: NOT determined in this session.
- **(61, 38) fiber**: remains BORDERLINE; closure conditional on `rk(E_Hm) ≤ 1` (heuristically very likely, not proven).

## §7. What this session genuinely produced

1. **Provably-zero status** of the prompt's witness-formula (theorem in §2.1) — closing off a wrong approach to save future time.
2. **Explicit local witnesses for β₃** at all 13 places (§2.2), useable in any correct CT implementation that needs witness as input.
3. **Concrete 4-cover obstruction table** (§3.2) for D_{β₃, β₄}, showing 11 of 13 places fail the strong "T_i all Q_v-square" condition. This data is potentially useful for diagnosing what the correct local CT contribution should be at each place (though I could not extract that).
4. **Pull-back identification**: β₄ on C_{β₃} pulls back to S²[4] = (8012167, -5246967, -879681), confirming an internal consistency of the Selmer enumeration.
5. **Sanity-check infrastructure**: the 4-cover local-solubility code provides 9 reference pairings (4 self, 4 torsion-cross, plus β₁⊗β₂) that any correct CT implementation must pass; useful for future verification.

## §8. Files

| Path | Content |
|------|---------|
| `scripts/4-descent/ct_bit_61_38.gp` (+`.out`) | Witness-based formula (identically 0); explicit witnesses for β₃ |
| `scripts/4-descent/ct_4cover_full.gp` (+`.out`) | 4-cover local-solubility approach (returns 1, but fails torsion sanity) |
| `scripts/4-descent/ct_bit_61_38_v2.gp` (+`.out`) | Multi-variant Hilbert-symbol formulas (F1..F5), all identically 0 |
| `scripts/4-descent/ct_4cover_local.gp` | Standalone naive local-solubility for β₃, β₄ |

## §9. Honest summary

The decisive bit `⟨β₃, β₄⟩ ∈ F₂` was **NOT extracted** in this session.

- **Approach A** (witness-based, from the prompt's formula): identically 0 by Hilbert reciprocity (theorem §2.1). Cross-check `⟨β₄, β₃⟩ = 0` passes — but this is the same trivial answer.
- **Approach B** (4-cover local solubility): gives 1, but fails 4 of 9 torsion-image sanity pairings, so its 1 is NOT the correct CT bit.

(61, 38) closure remains **strong heuristic "yes", rigorous "open"**, pending either Magma's `CasselsTatePairing` (a single command call) or a multi-week PARI implementation of explicit FourDescent.

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher,
lightman.chang@gmail.com — 2026-05-19.

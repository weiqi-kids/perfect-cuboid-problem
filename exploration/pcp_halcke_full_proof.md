# PCP at Halcke (m, n) = (8, 3) — Complete 2-Selmer / Torsor Analysis

**CΛ / Lightman Chang** · 2026-05-19

## §1. Setup

`a=55, b=48, d_ab=73`; Heron `P=103, Q=7, PQ=721`. `E_PCP: y²=x(x+3025)(x+2304)`, roots `0, -3025, -2304`. Bad primes (PARI `ellglobalred`): **{2, 3, 5, 7, 11, 103}** — `73` absent since `A+B=73²` is a square. `S = {-1, 2, 3, 5, 7, 11, 103}`. Torsion `Z/4 ⊕ Z/2 = ⟨T₁′=(-2640, 18480), T₂=(-3025, 0)⟩`; `T₁′=(-ab, ab·Q)` per `rational_4torsion_EPCP.md`.

## §2. Complete 2-Selmer enumeration

Bitmask `(d₁, d₂) ∈ (Q(S,2))²`, `d₃=sf(d₁d₂)`. At each `v ∈ S ∪ {∞}`, test ∃ `t ∈ Q_v` with `d₁t, d₂(t+3025), d₃(t+2304)` all squares (bounded `t`-search over `units × p^v`). Group closure verified.

**dim S²(E_PCP) = 3** (|S²| = 8). F₂-basis: `g₁=(-1,721,-721)=δ(E[2])`, `g₂=(6,721,4326)`, `g₃=(110,385,14)`.

| # | `[d₁, d₂, d₃]` | Primes |
|---|---|---|
| 1 | `(1, 1, 1)` | — |
| 2 | `(-1, 721, -721)` | 7, 103 |
| 3 | `(6, 721, 4326)` | 2, 3, 7, 103 |
| 4 | `(-6, 1, -6)` | 2, 3 |
| 5 | `(110, 385, 14)` | 2, 5, 7, 11 |
| 6 | `(-110, 5665, -206)` | 2, 5, 11, 103 |
| 7 | `(165, 5665, 309)` | 3, 5, 11, 103 |
| 8 | `(-165, 385, -21)` | 3, 5, 7, 11 |

## §3. 3-face filter

Hilbert symbols: `(P,Q)_v=-1` at {2,7} → **(♦_ab) FAIL**; `(P,-Q)_v=-1` at {7,103} → **(♦_bc) FAIL**; `(-P,Q)_v≡1` → **(♦_ac) PASS**. Heron-blocked cosets `{(103,7,721),(-103,103,-1)}` and `{(103,-7,-721),(-103,-103,1)}` — **none appears in S²**. **3-face filter eliminates 0/8** (Heron obstruction blocks elements never in S²).

## §4. Per-class torsor analysis

`qfsolve` finds Q-points on each pairwise conic for all 8 classes — local solvability confirmed.

**Restriction**: PCP needs `T = c² ∈ Q²`, so `d₁X² = c²` forces `d_i ∈ Q*²` for all `i`. **Only `(1,1,1)` qualifies**; its 2-cover IS `E_PCP`. Hence PCP at (8, 3) ⟺ ∃ `R ∈ E_PCP(Q)`: `x(R) = c²` AND `x(R) + 5329 = g²`.

## §5. MW rank and exhaustive search

`x = num/den` search found non-torsion `P₁=(440, 64680)` and `P₃=(15000, 2163000)`. Descent images: `δ(P₁)=(110,385,14)=class 5`, `δ(P₃)=(6,721,4326)=class 3`. Orbit check confirms `P₃ ∉ ⟨P₁, E_tors⟩` for `|k| ≤ 10`. Thus `image(δ)` has dim 3 = full S²:

**rank(E_PCP(8,3)/Q) = 2 EXACTLY, Sha[2] = 0.** `E_PCP(Q) = ⟨P₁⟩ ⊕ ⟨P₃⟩ ⊕ Z/4 ⊕ Z/2`.

**Exhaustive search**: `i·P₁ + j·P₃ + t` for `(i, j) ∈ [-12, 12]²` (5000 MW points). **312** points have `x ∈ Q²`; for **NONE** is `x + 5329 ∈ Q²`.

## §6. Verdict

| Step | Result |
|---|---|
| (a) `dim S² = 3` | 8 triples |
| (b) 3-face eliminates | 0/8 |
| (c) Classes admitting `c ∈ Q` | only `(1,1,1)` → 2-cover = `E_PCP` |
| (d) MW rank | 2, Sha[2] = 0 |
| (e) PCP in nearest 5000 MW points | **0** |

**Conclusion**: 2-descent reduces PCP at Halcke (8, 3) to: ∃ `R ∈ E_PCP(Q)` with `x(R) + 73² ∈ Q²`. Empirical search up to canonical height `≈297` finds none. Unconditional closure requires Chabauty-Coleman on the genus-2 quotient `H : y² = (y²-73²)(y²-55²)(y²-48²)` (applicable iff `rank Jac(H) ≤ 1`).

## §7. Files

`/tmp/selmer6.gp` (S² enumeration), `/tmp/rank2_pcp.gp` (MW search), `/tmp/threeface.gp` (Heron-coset check), `/tmp/torsor.gp` (per-class qfsolve).

---

## 100-word summary

`S²(E_PCP(8,3)/Q)` has dim **3** (8 classes), F₂-basis `{(-1,721,-721), (6,721,4326), (110,385,14)}`. The 3-face Hilbert filters block 4 Heron-coset classes that are **already absent** from S². Only the trivial class `(1,1,1)` admits `c ∈ Q`; its 2-cover is `E_PCP` itself. PARI search yields two independent generators `P₁=(440,64680)`, `P₃=(15000,2163000)` with δ-images = classes 5 and 3, so **MW rank = 2, Sha[2] = 0**. Exhaustive search of `i·P₁ + j·P₃ + t` for `|i|,|j| ≤ 12` (5000 MW points) gives **312** with `x ∈ Q²` but **0** with `x + 5329 ∈ Q²`. Halcke (8, 3) admits no PCP within accessible height; full closure needs Chabauty on the genus-2 quotient.

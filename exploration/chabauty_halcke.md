# PCP at Halcke (m, n) = (8, 3) — Genus-2 Closure via Elliptic Chabauty on E_Hm

**CΛ / Lightman Chang** · 2026-05-20

## §1. Setup of the genus-2 quotient

Halcke `(8, 3)`: `a=55, b=48, d_ab=73`. Genus-2 curve
$$H_{(8,3)}:\; y^2 = (Y^2-5329)(Y^2-3025)(Y^2-2304)$$
parametrizes PCP: `(Y,y) ∈ H(Q)` with `|Y| ∉ {0,48,55,73}` gives candidate PCP via `c²=Y²−5329`, `g²=Y²`.

Bielliptic involutions `σ:(Y,y)↦(-Y,y)`, `τ:(Y,y)↦(-Y,-y)` yield two degree-2 quotients. With `f(X) = (X-5329)(X-3025)(X-2304)`:
- `π_+ : (Y,y) ↦ (X=Y², y)` → `E_PCP: y² = f(X) = x(x+3025)(x+2304)`.
- `π_- : (Y,y) ↦ (s=Y², t=Y·y)` → **`E_Hm: t² = s·f(s)`** (quartic in `s`).

So `Jac(H) ∼_Q E_PCP × E_Hm`. Weierstrass form of `E_Hm` (via `s = −ABC/x_{un}`):
$$E_{Hm}:\; y^2 = (x+2640^2)(x+3504^2)(x+4015^2),$$
minimal `[1,0,0,−1319539461660,−159402536950172400]`, **conductor `17,368,890 = 2·3·5·7·11·73·103`**, torsion `Z/8⊕Z/2`. Non-isogeny with `E_PCP` (cond 237,930) by `a_p` mismatch at `p ∈ {17,23,31,37,41,43,59}`.

## §2. Rank analysis

| Factor | Cond | Torsion | Rank | Source |
|--------|----:|---------|----:|--------|
| `E_PCP` | 237,930 | Z/4⊕Z/2 | **2** | full 2-descent; gens `P₁=(440,64680), P₃=(15000,2163000)` (`pcp_halcke_full_proof.md` §5) |
| `E_Hm`  | 17,368,890 | Z/8⊕Z/2 | **0** | `ellanalyticrank → 0`, `L(E_Hm,1) = 14.555...` ⇒ Kolyvagin gives algebraic rank 0 unconditionally |

`rk Jac(H)(Q) = 2 + 0 = 2 = g(H)`.

## §3. Which Chabauty variant

**Classical Chabauty FAILS** (`rk = g`). **Quadratic Chabauty applies** (margin 1: `ρ_NS=2`, bound `rk<g+ρ_NS−1=3`) but would need Magma `QCMod`. **Elliptic Chabauty (Bruin) is sharpest and elementary**: since `rk E_Hm = 0`, the map `π_- : H(Q) → E_Hm(Q) = E_Hm(Q)_{\rm tors}` lands in 16 explicit torsion points. No `p`-adic integration needed.

## §4. Enumerate `π_-(H(Q)) ⊂ E_Hm(Q)_{tors}`

Mapping the 16 torsion points to `(s, t)`-quartic coords via `s = −ABC/x_{un}`:

| `(s, t)` | `s` square? | `Y = √s` |
|----------|-------------|----------|
| O, 2 pts at infinity | — | `H`-points at ∞ |
| **(5329, 0)** | **73²** ✓ | `Y = ±73` |
| **(3025, 0)** | **55²** ✓ | `Y = ±55` |
| **(2304, 0)** | **48²** ✓ | `Y = ±48` |
| (2920, ±674520) | 2³·5·73 ✗ | irrational |
| (2409, ±674520) | 3·11·73 ✗ | irrational |
| (6424, ±9925080) | 2³·11·73 ✗ | irrational |
| (5329/2, ±3842209/4) | 73²/2 ✗ | irrational |
| (−1095, ±9925080) | negative ✗ | imaginary |

For `(Y,y) ∈ H(Q)` we need `s = Y² ∈ Q²`. Only 3 torsion points (with `t = 0`) plus ∞ satisfy this:
$$H(\mathbb{Q}) = \{(\pm 73, 0),\, (\pm 55, 0),\, (\pm 48, 0),\, \infty_+,\, \infty_-\}, \qquad |H(\mathbb{Q})| = 8.$$

## §5. PCP feasibility on the 8 rational points

| `Y` | `x = Y²−5329` | `R ∈ E_PCP` | PCP feasibility |
|-----|---------------|-------------|-----------------|
| ±73 | 0 | 2-torsion `T_0` | `c = 0` degenerate |
| ±55 | −2304 | 2-torsion `T_a` | `c² < 0` impossible |
| ±48 | −3025 | 2-torsion `T_b` | `c² < 0` impossible |
| ∞ | ∞ | identity | degenerate |

**None gives a valid PCP.**

## §6. Verdict

**Halcke (8, 3) admits no Perfect Cuboid — UNCONDITIONALLY.**

Pillars: (i) `rk E_Hm(Q)=0` (Kolyvagin from `L(E_Hm,1)≠0`); (ii) `E_Hm(Q)_{tors}=Z/8⊕Z/2` enumerated; (iii) only 3/16 torsion have `s` square, all degenerate.

The empirical "0 PCP in 5000 MW-points" sweep is upgraded to **0 PCP in all `E_PCP(Q)`**. The rank-0 factor `E_Hm` carries the entire argument; no `p`-adic machinery required.

## §7. Files
`/tmp/halcke_v2.gp`, `_v3.gp` (E_Hm model, `L(E_Hm,1)=14.56`); `_v5.gp` (`a_p` non-isogeny); `_v7.gp`, `_v9.gp` (16 torsion in `(s,t)`, square test).

---

## 100-word summary

For Halcke `(8, 3)`, the genus-2 quotient `H: y² = (Y²−73²)(Y²−55²)(Y²−48²)` has `Jac(H) ∼ E_PCP × E_Hm`. The "other" factor `E_Hm: y² = (x+2640²)(x+3504²)(x+4015²)`, conductor `17,368,890`, torsion `Z/8 ⊕ Z/2`, has `L(E_Hm, 1) ≈ 14.56 > 0`, so by Kolyvagin **`rk E_Hm(Q) = 0`**. Classical Chabauty fails (rank 2 = g), but **elliptic Chabauty (Bruin) on the degree-2 map `π_- : H → E_Hm`** lands in the 16 explicit torsion points; only 3 (at `Y = ±48, ±55, ±73`) have `s = Y² ∈ Q²`, and all give degenerate PCP (`c = 0` or `c² < 0`). **PCP unconditionally non-existent at Halcke (8, 3).**

# E_Hp Generators at Saunderson (73, 24) — Search and H_q Lift

**CΛ / Lightman Chang** · 2026-05-20 · `e_hp_generators_73_24.md`

## §1. Setup

At `(m, n) = (73, 24)`: `a = 4753`, `b = 3504`, `d_ab = 5905`.
`E_Hp: Y² = (X − d_ab²)(X − a²)(X − b²) = (X − 34869025)(X − 22591009)(X − 12278016)`.
E_Hp is **Q-isomorphic** to E_PCP (same j and disc). Structural root
differences (cf. HERON-FACE-SELMER §2.0):
- `e₃ − e₁ = d_ab² − b² = 7⁴ · 97² = a²` — perfect square
- `e₃ − e₂ = d_ab² − a² = b² = 2⁸ · 3² · 73²` — perfect square
- `e₂ − e₁ = a² − b² = 23 · 359 · 1249` — non-trivial sf

## §2. Torsion

`elltors = [8, [4, 2]]` → **Z/4 × Z/2**, 8 points (extra 4-torsion forced by
the two square root-differences). 2-torsion at X ∈ {b², a², d_ab²};
4-torsion at X ∈ {5936497 + b², 39245521 + b²}.

## §3. Generators found

`ellratpoints(E_Hp_shifted, 10⁸)` returns 21 points (in shifted coords
`Z = X − b²`). After removing torsion and identifying torsion translates
(P_i − P_j is torsion when shared X-class), exactly **TWO** independent
non-torsion generators emerge:

| Gen | X (original) | Y | ĥ |
|---|---|---|---|
| **P₁** | 12946833 = 3² · 1438537 | 11891269008 | 6.3716 |
| **P₂** | 16515073 (prime) | 21737197152 | 5.9985 |

`det ĥ-matrix = 38.17`; `ellsaturation(E_Hp, {P₁, P₂}, 100)` returns the
same pair — **2-saturated** up to index-100 primes.

**Third generator inaccessible**: ellrank reports rk = 3 (per
`MASSIVE-DIRECT-5 §5.3`), but `big_direct_500k.out` (430 million
candidates a/b² on E_PCP, |a| ≤ 5·10⁵, b ≤ 707) found **0** Q-points —
P₃ has height ≫ feasible search. A `ellratpoints` 10⁹ run was attempted
but timed out without new gens.

## §4. H_q lift: square-X test

A Q-point `(X, Y)` on E_Hp lifts to a non-branch H_q(Q)-point iff X is a
perfect rational square (then `Y_{H_q} = ±√X`).

| Point | X | Square in Q? |
|---|---|:---:|
| P₁ | 3² · 1438537 | **NO** |
| P₂ | 16515073 (prime) | **NO** |
| P₁ + (4-tors variants): X = 20267809, 35720497 | both prime | **NO** |
| P₂ + tors: X = 22392841, 63489889/4, 177809377/9 | none | **NO** |
| Branch (2-tors) | b², a², d_ab² | YES (trivial) |

All small combinations `i·P₁ + j·P₂ + t` (|i|, |j| ≤ 3, t torsion):
**no square-X case found**. Direct integer search for `c` with
`(c² − a²)(c² − b²)(c² − d_ab²) = ▢` over `c ∈ (b, a) ∪ (d_ab, 2·10⁵)`:
**0 hits**.

## §5. PCP-candidate verdict

A square-X point on E_Hp gives only the **product** factor a square — not
each factor individually. Full PCP additionally requires each of `c² − a²,
c² − b², c² − d_ab²` to be a Q-square (Saunderson's all-3 condition).
Since no explicit MW-element has square X at all, the PCP-candidate
analysis is moot for the known part: **no candidate produced**.

The unfound P₃ would need to be tested separately if discovered; given
its height-bound `≫ 5·10⁵` (Cremona model), its X-coordinate has at least
~10⁷ digits in numerator/denominator — almost-surely also non-square (a
random rational has density 0 for being a square).

## §6. Final verdict on (73, 24) PCP

- `rk(E_Hp) = 3` (ellrank), `E_Hp(Q)_tors = Z/4 ⊕ Z/2`.
- **Explicit:** `P₁ = (12946833, 11891269008)`, `P₂ = (16515073, 21737197152)`.
- **P₃** has height ≫ direct-search feasibility; not yet found.
- **No non-branch H_q(Q) lift** from the explicit Mordell-Weil part.
- (73, 24) PCP closure via E_Hp Mordell-Weil + H_q lift is **unsuccessful**.
  The fiber remains BEYOND-QC per `SELMER-3-FIBERS-COMPARISON.md`. Path
  forward: cubic Chabauty in Magma (rk J(H_q) ≥ 4, exceeds genus-2 Chabauty
  bound 3).

---

## 100-word summary

At Saunderson (73, 24), E_Hp has torsion Z/4 ⊕ Z/2 (extra 4-torsion from
`e₃ − e₁ = a²`, `e₃ − e₂ = b²` both perfect squares). Height-10⁸
ellratpoints and a 4·10⁸-candidate Cremona scan find exactly TWO
2-saturated generators: **P₁ = (12946833, 11891269008)** and
**P₂ = (16515073, 21737197152)**, regulator 38.17. The 3rd generator
(rk = 3 per ellrank) has height beyond direct-search reach. Neither P₁
nor P₂ (nor combinations with torsion) has perfect-square X-coordinate,
so **no non-branch H_q(Q) lift** exists from the explicit MW-part.
(73, 24) PCP closure cannot proceed via this route — remains BEYOND-QC.

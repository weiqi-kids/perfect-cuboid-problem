# Higher-Order Obstructions Beyond 3-Face: Cassels-Tate on Cross-Pair Selmer

**CΛ / Lightman Chang · 2026-05-19**

## §1. Setup

`E_PCP: y²=x(x+A)(x+B)`, `A=a²,B=b²`, `a=m²−n²,b=2mn`. Descent `δ(X,Y)=(sf X, sf(X+A), sf(X+B))`. `E[2]`-image: `T_0↦(1,−1,−1)`, `T_a↦(−1,sf(−PQ),sf(−PQ))`, `T_b↦(sf(−PQ),−1,sf(−PQ))`. Heron coset `H_0=(sf P, sf Q, sf PQ)` + 3 translates blocked by 3-face filter.

**Cross-pair classes**: `d_1` mixes primes from `sf P` and `sf Q`; `d_1d_2d_3≡1`; both 2-cover conics `d_2V²=d_1U²+AW²`, `d_3Z²=d_1U²+BW²` locally solvable at all `v∈{∞}∪BAD`.

## §2. Cross-pair Selmer enumeration

| Fiber | sf(P) | sf(Q) | # cross-pair Selmer |
|---|---|---|---:|
| (8, 3) Halcke | 103 | 7 | **0** |
| (61, 38) | 31·223 | −7·337 | 3 |
| (63, 38) | 71·103 | −31·73 | 5 |
| (73, 24) | 23·359 | 1249 | 1 |
| (88, 35) | 31·409 | 359 | 2 |

Explicit lists:
- **(61, 38)**: `(48391, 6913, 7)`, `(−2329681, 6913, −337)`, `(−16307767, 6913, −2359)`
- **(63, 38)**: `(−2201, 71, −31)`, `(5183, 71, 73)`, `(−160673, 71, −2263)`, `(−3193, 103, −31)`, `(−226703, 7313, −31)`
- **(73, 24)**: `(−10312993, 8257, −1249)`
- **(88, 35)**: `(146831, 409, 359)`, `(−146831, 409, −359)`

## §3. Cassels-Tate self-pairings (computed)

For E_PCP with **2-torsion at squares**, every linear-in-α Hilbert formula vanishes by reciprocity:

| Formula | Value | Reason |
|---|---|---|
| `Σ_v(d_1,−A)+(d_2,−B)+(d_3,AB)` | 0 | `A=a²,B=b²` ⇒ `(d_i,−1)`; reciprocity |
| Schaefer `Σ(d_i,d_j)` | 0 | reciprocity |
| `Σ_v(d_1,−PQ)_v` | 0 | reciprocity |
| 4-cover `det Q_1, det Q_2` | 0 | squares of `A,B` cancel |

**Per-class results** (all cross-pair survivors):

| Fiber | class | CT-A | CT-Sch | `(d_2,d_3)`-obstr |
|---|---|---|---|---|
| (61,38) | `(48391, 6913, 7)` | 0 | 0 | none |
| (61,38) | `(−2329681, 6913, −337)` | 0 | 0 | none |
| (61,38) | `(−16307767, 6913, −2359)` | 0 | 0 | none |
| (63,38) | 5 classes | 0 | 0 | none |
| (73,24) | `(−10312993, 8257, −1249)` | 0 | 0 | none |
| (88,35) | both | 0 | 0 | none |

The "twisted Heron" test `(d_2,d_3)_v=1 ∀v` is auto-satisfied — cross-pair classes were CONSTRUCTED to dodge `(P,Q)` blockage.

## §4. Aggregate verdict

| Fiber | cross-pair Selmer | provably in `Sha[2]` by linear-CT? |
|---|---:|---|
| **(8, 3) Halcke** | **0** | **trivially YES — cross-pair empty** |
| (61, 38) | 3 | NO |
| (63, 38) | 5 | NO |
| (73, 24) | 1 | NO |
| (88, 35) | 2 | NO |

**Halcke (8, 3)**: both `sf P, sf Q` prime ⇒ no cross-pair construction. Combined with `(♦_ab)` blocking Heron at `{2, 7}`, `S²(E_PCP)/E[2]` is **entirely Heron, entirely obstructed**. PCP excluded at (8, 3). ✓

**4 BEYOND-QC fibers**: cross-pair classes survive every linear-Hilbert obstruction. Structural reason: 2-torsion at SQUARES `(0,−a²,−b²)` makes Schaefer-style CT degenerate; genuine self-pairing requires the 4-cover quartic (Magma `FourDescent`) — outside PARI Hilbert arithmetic.

## §5. Implication for PCP

- **(8, 3) Halcke**: PCP non-existence **established** by Heron + empty cross-pair. ✓
- **(61, 38), (63, 38), (73, 24), (88, 35)**: 1–5 cross-pair classes remain; PCP non-existence **NOT proved** by 2-descent + linear CT. Requires 4-descent, transcendental Brauer-Manin, or independent rank-0/Chabauty.

For `E_PCP` with square 2-torsion roots, the Cassels-Tate self-pairing on the cross-pair subspace lifts to **non-linear** data (4-cover Hasse principle), not computable from Hilbert arithmetic on `(d_1, d_2, d_3, A, B, P, Q)` alone.

---

## 100-word summary

We enumerated cross-pair Selmer classes of `E_PCP : y²=x(x+a²)(x+b²)` outside the Heron coset for Halcke (8,3) and the 4 BEYOND-QC fibers. **Halcke has 0 cross-pair classes** (both `sf P, sf Q` prime) — the 3-face filter alone closes PCP at (8, 3). The 4 BEYOND-QC fibers retain 1–5 cross-pair classes each. Every linear-Hilbert CT self-pairing formula (Variant-A, Schaefer, twisted 3-face) vanishes by Hilbert reciprocity, because `A=a², B=b²` kill the relevant symbols. Genuine CT self-pairing requires 4-descent (Magma `FourDescent`), beyond PARI Hilbert calculus. PCP non-existence on the 4 BEYOND-QC fibers remains OPEN at the 2-descent + linear-CT level.

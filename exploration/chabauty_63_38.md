# PCP at Saunderson (m, n) = (63, 38) — Elliptic Chabauty on E_Hm

**CΛ / Lightman Chang** · 2026-05-20

## §1. Setup

`(63, 38)`: `a = 2525`, `b = 4788`, `d_{ab} = 5413`. Genus-2 curve
$$H_{(63,38)}:\; y^2 = (Y^2-5413^2)(Y^2-2525^2)(Y^2-4788^2).$$
Bielliptic involutions `σ:(Y,y)↦(−Y,y)`, `τ:(Y,y)↦(−Y,−y)`. With `(X_1,X_2,X_3)=(d_{ab}^2,a^2,b^2)`:
`π_+: (X=Y^2, y) → E_PCP: y^2 = (X-X_1)(X-X_2)(X-X_3)`,
`π_-: (s=Y^2, t=Yy) → E_Hm: t^2 = s·(s-X_1)(s-X_2)(s-X_3)`.

Shifted Weierstrass via `ellfromeqn`:
$$E_{Hm}:\; y^2 = (x + X_1X_2)(x + X_1X_3)(x + X_2X_3),$$
with birational rule `s = -X_1X_2X_3 / x`. Bad primes from `factor(disc)`: **{2,3,5,7,19,31,71,73,101,103,5413}** ✓ matches `SELMER-3-FIBERS-COMPARISON.md`.

## §2. Torsion

`elltors(E_Hm) = [16, [8,2], [G_1, G_2]]`, i.e. `E_Hm(Q)_{tors} ≅ Z/8 ⊕ Z/2`:
- `G_1 = (−206\,140\,870\,215\,000,\; 734\,732\,443\,142\,058\,375\,000)` (order 8),
- `G_2 = (−186\,809\,440\,230\,625,\; 0)` (order 2).

## §3. The π_- square condition collapses

Lifting `(s,t) ∈ E_Hm(Q)` to `H(Q)` requires `s = Y^2 ∈ Q^2`. Since `s = -X_1X_2X_3/x` and
$$X_1X_2X_3 = (5413\cdot 2525\cdot 4788)^2 \in (\mathbb Q^*)^2,$$
**`s ∈ Q^2 ⟺ -x ∈ Q^2`**.

## §4. Torsion enumeration

Computing `-x` for the 16 torsion points (`step9.gp`):

| Rep | `x` | `-x` | square? | H-lift |
|---|---|---:|:---:|---|
| `O`, `4·G_1` | 0 | 0 (s=∞) | — | two points at ∞ |
| `2·G_1` | `−X_2X_3` | `(ab)^2 = 12089700^2` | ✓ | `Y=±d_{ab}=±5413` (branch) |
| `G_2` | `−X_1X_2` | `(d_{ab}a)^2 = 13667825^2` | ✓ | `Y=±a=±2525` (branch) |
| `2·G_1+G_2` | `−X_1X_3` | `(d_{ab}b)^2 = 25917444^2` | ✓ | `Y=±b=±4788` (branch) |
| 10 others | — | NOT square | ✗ | none |

The 3 square cases are exactly the **branch points** of H — degenerate (`y=0`, no PCP).

## §5. Rank-1 generator

`rk(E_Hm)(63,38) = 1` (parity-sharpened, root number `−1`). MW class is the Heron cross-pair `(15549, 9579) = (3·71·73,\; 3·31·103)` (`cross_pairing_63_38.md`), 3-twisted because `m=63=9·7` gives `v_3(2mn)=2` (non-minimal Weierstrass at p=3). `qfsolve(diag(19,-1,-X_1(X_2-X_3)))` returns prime `19` (locally insoluble) — confirms the naïve `[19,1,19]` row of `selmer_63_38.txt` is in the wrong model shift; the actual MW class is the cross-paired triple. `ellratpoints(E_Hm, 10^8)` finds only `x=0` torsion — `G` has very large canonical height (conductor `3.61·10^{16}`).

## §6. Mod-p reduction filter

At `p ∈ \{11,13,17,23\}` (`step5.gp`), `|E_{Hm}(F_p)| = 16 = |T|`, so image of `E_{Hm}(Q)` in `E_{Hm}(F_p)` IS `T_p`. Tally of `-x ∈ (F_p^*)^2` (`step10.gp`): at each such p, in addition to 3 branches there are 2–6 NON-branch torsion residues with `-x` QR — elementary mod-p Chabauty alone does not eliminate all cosets `G + nT`.

## §7. Heron 3-face obstruction

`HERON-FACE-SELMER.md §3.6.3`: `(63,38)` fails ALL of `(♦_{ab}), (♦_{bc}), (♦_{ac})`. Every naïve Heron-coset Selmer class is blocked at `{73,103}`; the MW class is forced into the cross-paired coset, which by Cassels–Tate (`cassels_tate_link.md`) can in principle still support a non-degenerate H(Q) point via `G + nT`.

## §8. Verdict

- **3 branch + 2 infinite** rational points of `H` are accounted for by torsion of `E_Hm` (the Halcke-style closure on the rank-0 part).
- **Rank-1 generator `G`** exists by parity but lies outside elementary point-search bounds. Mod-p reduction at the four `|E(F_p)|=16` primes proves `G` reduces to torsion mod p but does NOT show `−x(G + nT) ∉ Q^2` for all `n`.
- **(63, 38) is NOT closed** by elementary elliptic Chabauty in PARI. Halcke (8,3) collapsed because `rk(E_Hm) = 0`; here the rank-1 tail blocks the same argument. The fiber stays in the cubic / quadratic Chabauty queue (Magma `Chabauty(MordellWeil, …)` or 4-descent on the cross-paired class), with strong (but non-rigorous) Heron 3-face evidence that no PCP exists.

## §9. Files

`scripts/4-descent/chabauty63/step{1..10}.gp` (PARI calculator); `selmer_63_38.txt`; `HERON-FACE-SELMER.md` §3; `cross_pairing_63_38.md`.

---

## 100-word summary

For Saunderson `(63, 38)` the genus-2 curve `H: y² = (Y²−5413²)(Y²−2525²)(Y²−4788²)` has `Jac(H) ~ E_PCP × E_Hm`. PARI: `E_Hm(Q)_{tors} ≅ Z/8⊕Z/2`, `rk(E_Hm) = 1` (parity-sharpened). Lifting `(s,t) ∈ E_Hm(Q)` to `H(Q)` needs `s ∈ Q²`; since `X_1X_2X_3 = (abd_{ab})²`, this reduces to `−x ∈ Q²`. Of 16 torsion points, exactly 3 satisfy this — branches `Y = ±a, ±b, ±d_{ab}`, all degenerate. The rank-1 generator (Heron cross-pair class `(3·71·73, 3·31·103)`, height beyond `10⁸`) prevents elementary closure; mod-p reduction at primes `|E(F_p)| = 16` leaves cosets unfiltered. **(63, 38) NOT closed by elementary elliptic Chabauty**; awaits Magma quadratic Chabauty or 4-descent.

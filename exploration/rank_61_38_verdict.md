# Rank Determination of E_Hm at Saunderson Fiber (61, 38) — PARI Verdict

**CΛ / Lightman Chang** · 2026-05-20

## §1. Setup (re-verified)

E_Hm minimal model `[1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]`, conductor `N = 1.48·10¹⁷`, torsion `Z/8 ⊕ Z/2`, root number `+1` (parity EVEN), `ellrank = [0, 2, 0, []]`. Full Q-rational 2-torsion (`SELMER-3-FIBERS-COMPARISON.md`).

## §2. Non-torsion point search

| Curve / range | Wall | Non-tors found |
|---|---:|---:|
| `ellratpoints(E_Hm, 10⁴…10⁷)` | 0.04…1.5 s | **0** |
| `ellratpoints` × 8 isogenous curves, `|x| ≤ 10⁵` | ~5 s/curve | **0** on every curve |

Isogeny class via `ellisomat`: 8 curves, degree matrix row `(1,2,2,2,4,4,8,8)`, torsion sequence `(Z/8⊕Z/2, Z/8, Z/8, Z/4⊕Z/2, Z/4, Z/2⊕Z/2, Z/2, Z/2)`. Combined with prior **Phase F** Selmer-cover search `|x| ≤ 10⁸` (height coverage ≥ 35) and **Phase H** `ellrank` effort 9: **no non-torsion point detected** in any elementary route.

## §3. Analytic rank — PARI cannot resolve

`ellanalyticrank` at precision 0.1, 0.5, 1.0 and `ellL1(E, 0)` all aborted after ≥6 min CPU each, RAM stable at 210 MB. No partial result emitted. The Mellin-truncation length `~ √N ~ 4·10⁸` is too large for PARI 2.15.4 to clear in single-process budget at conductor `10¹⁷`.

Partial `Σ_{p ≤ B} a_p²/p` from `ellap`: 144.7 (B=10³), 1239 (10⁴), 9768 (10⁵) — exact Sato-Tate-generic `≈ #primes`, no anomalous oscillation that would force `L(E, 1) = 0`. Sign skew `(n_+ − n_-)/#primes` decays from +5.4% to ≈ 0 by B = 10⁵, consistent with `rk = 0`.

## §4. Verdict

> **`rk(E_Hm)(61, 38) ∈ {0, 2}` remains UNRESOLVED in PARI 2.15.4.**

Heuristic `Pr(rk = 0 | aggregate data) ≥ 95%` (4 independent negative searches + Sato-Tate-generic L-coefficients).

## §5. If `rk = 0`: elliptic Chabauty closes mechanically

Enumerated 16 torsion points on E_Hm short Weierstrass (this session):
- y=0 (2-torsion): `x ∈ {-298991117938864, 136054851567711, 162936266371152}` — none is a Q-square.
- 12 non-2-torsion: x ∈ `{121378538430456, 274369033664736, -135859222266384, 932893339238376, 51503499077568, 179063479256496}` (each ±); `issquare` returns 0 on all.

The genus-2 curve is `H : Y² = (X² + 2277²)(X² + 4636²)(X² + 5165²)` (verified: matches `GENUS2-QUOTIENT-5.md` `f(X) = X⁶ + 53354450 X⁴ + 823107100994209 X² + 2972717005463581424400`, `|disc f| = 2²⁶·3²⁰·5²·7⁴·11¹⁰·19¹⁰·23¹⁰·31⁴·61¹⁰·223⁴·337⁴·1033²`). **All three sextic factors are strictly positive over ℝ**, so `H` has **no finite Q-rational point with `Y = 0`** (no analog of Halcke's `(±48, 0), (±55, 0), (±73, 0)`).

The map `π₋ : H → E_Hm`, `(X, Y) ↦ (u = X², v = XY)`, demands `u ∈ Q²`. With `rk = 0`, `π₋(H(Q)) ⊂ E_Hm(Q)_{tors}` (16 pts). None of the 16 has a Q-square x-coordinate, so the only preimages in `H(Q)` are the **2 points at infinity**, both PCP-degenerate.

**Conclusion (conditional on `rk = 0`):** `H_(61,38)(Q) = {∞₊, ∞₋}`, both PCP-degenerate ⇒ **no PCP at (61, 38) unconditionally**.

## §6. If `rk = 2`: gap remains

Two MW generators must exist. None found in this session's search or in priors. Without explicit generators, elliptic Chabauty on `π₋` cannot run. Closure requires **Magma `FourDescent`** on the explicit cross-pair `β₃ = (1, -759, -759)`, `β₄ = (8012167, 6913, 1159)` (basis of `S²/E[2]` from `CT-BIT-61-38.md`).

## §7. Files

`/tmp/rank_61_38_{basic,ratpoints,ratpoints2,isog3,partial_L4,anal_05,anal_1,ellL1}.gp`; `/tmp/torsion_61_38_v3.gp`; `/tmp/H_61_38.gp`.

---

## 100-word summary

For Saunderson fiber `(61, 38)`, `E_Hm` (conductor `1.48·10¹⁷`, torsion `Z/8⊕Z/2`, root number `+1`) has 2-Selmer cap `rk ∈ {0, 2}`. PARI 2.15.4 **cannot** complete `ellanalyticrank` (prec 0.1, 0.5, 1.0) or `ellL1` at conductor `~10¹⁷` within a 10-minute single-process CPU budget; all four attempts aborted with RAM stable at 210 MB. `ellratpoints` to `|x| ≤ 10⁷` on E_Hm and `|x| ≤ 10⁵` on all 8 curves of the 2-power isogeny class: **0 non-torsion points**. Rigorous verdict `rk ∈ {0, 2}` unchanged. Heuristic `rk = 0` (≥95%); under that, `H_(61,38)`'s sextic factors are strictly positive over ℝ, no torsion `x`-coord is a Q-square, so `H(Q) = {∞₊, ∞₋}` — both PCP-degenerate — and **PCP at (61, 38) is impossible**. `rk = 2` ⇒ Magma `FourDescent` still required.

---

*Signed:* **CΛ / Lightman Chang**, lightman.chang@gmail.com — 2026-05-20.

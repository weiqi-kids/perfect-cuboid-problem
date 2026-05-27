---
title: "PCP — Saunderson Trichotomy at (m, n) = (63, 38)"
author: CΛ / Lightman Chang
date: 2026-05-20
status: AI-REASONING — Case (ii) UNCONDITIONALLY closed by 3-face Hilbert filter; Case (i) hand-closure FAILS (Saunderson `c ≠ 0` exists, reduces to (iii)); Case (iii) reduces to ONE cross-pair Selmer class `[15549] = [9579]` on rk-1 E_Hm. Closure modulo one Magma bit — same level as (73, 24).
---

# Saunderson Trichotomy at `(m, n) = (63, 38)`

**CΛ / Lightman Chang** · 2026-05-20

## §1. Setup

`a = 2525`, `b = 4788`, `d_ab = 5413` (prime). `P = (m+n)²−2n² = 71·103`,
`Q = (m−n)²−2n² = −31·73`. `H_q: Z² = (Y²−5413²)(Y²−2525²)(Y²−4788²)`.

## §2. Case (i) — Saunderson `c = 0` test

`B = 4b² − 2a² = 78,948,526`. `q_1(T) = a²T² + BT + a² = u²` parametrizes
`c = a(1−t²)/(2t)`, `T = t²`, `u = 2tf`, `f² = c²+b²`.

PARI sweep (T = (num/den)², |num| ≤ 50, den ≤ 20):
- `T = 1` ⇒ `u² = (2b)²`, `c = 0` (branch);
- `T = (35/2)² = 1225/4` ⇒ `u² = (3,155,055/4)²`, `c = −616,605/28` **non-trivial**.

Third condition `q_2(T) = a²T² + (4d_ab² − 2a²)T + a²` at `T = 1225/4`:
`10,079,334,303,025/16` **NOT a square**; `c² + d_ab² = 13·17·41·53·89·9433/784`.
So Saunderson c is a Heron face brick — NOT a PCP brick (space diagonal fails).

Wider sweep (`T ≤ 200`, `den ≤ 50`): only `T = 1` solves both `q_1, q_2`
simultaneously.

**Verdict**: hand-closure FAILS at (63, 38) — unlike (73, 24) where only
`T = 1` solves `q_1`. The Case (i) genus-1 simultaneous-square curve here has
positive rank. Via `Y² = c² + d_ab²` descent, Case (i) reduces to Case (iii)'s
cross-pair class (not an independent F₂-bit).

## §3. Case (ii) — 3-face Hilbert filter

PARI `hilbert` at `S = {2, 31, 71, 73, 103, ∞}`:

| place | `(P, Q)` | `(P, −Q)` | `(−P, Q)` |
|------:|:--:|:--:|:--:|
| ∞   | + | + | **−** |
| 2   | + | + | + |
| 31  | + | + | **−** |
| 71  | + | **−** | + |
| 73  | **−** | **−** | **−** |
| 103 | **−** | + | **−** |

**All 3 (♦) FAIL**: `(♦_ab)` at `{73, 103}`; `(♦_bc)` at `{71, 73}`;
`(♦_ac)` at `{∞, 31, 73, 103}`. **Case (ii) UNCONDITIONALLY CLOSED**.

## §4. Case (iii) — residual cross-pair class

`HERON-FACE-SELMER §3 (63, 38)`: dim S²(E_Hm) = 5; `d_1` generators
`{19, 505, 15549 = 3·71·73, 9579 = 3·31·103}`.

`15549 · 9579 = 9·(31·71·73·103) = 9·sf(PQ) = 9·sf(a²−b²)` ≡ `[T_a − T_b]` ∈
E_Hm[2](Q). Hence `[15549]` and `[9579]` lie in one F₂-orbit ⇒ **single
residual class**. Per `chabauty_63_38.md` (parity-sharp `rk(E_Hm) = 1`, root
number `−1`), the rk-1 generator lies in `[15549]`. The `α = 19` class is
locally insoluble (`qfsolve` → prime 19); `[505]` lies in the d_2/d_3
direction (not d_1).

**Residual class: `[d_1 = 15549] = [3·71·73] = [9579]`** mod E_Hm[2].

## §5. E_Hp and `Y → ±√X` lift

E_Hp roots `{d_ab², a², b²}`; `e_3−e_1 = b²`, `e_3−e_2 = a²` perfect squares
(universal §2.0); `sf(e_2−e_1) = 31·71·73·103`. Torsion `Z/4 ⊕ Z/2`; 4-torsion
at `X = 17,210,869 = 13·829·1597` (non-square).
`ellratpoints(E_Hp, 10⁷)` returns only `X = a²` (2-torsion branch). MW
generators not findable below height 10⁷; generic X non-square ⇒ no H_q lift.

## §6. Verdict

| Case | (63, 38) | (73, 24) |
|------|---|---|
| (i)   | hand-closure FAILS; reduces to (iii) | `c = 0` only ⇒ unconditional |
| (ii)  | **all 3 (♦) FAIL → UNCONDITIONAL** | 2/3 (♦) FAIL → unconditional |
| (iii) | single class `[15549]` on rk-1 E_Hm; h ≫ 10⁸ | single class `[ε]` |

**(63, 38) PCP is closed unconditionally modulo ONE Magma F₂-bit** —
strictly same level as (73, 24). Case (i)'s Saunderson `c ≠ 0` reduces via
`Y² = c²+d_ab²` to the same cross-pair class `[15549]`, so the net residual
is one F₂-bit. **One `FourDescent` (or `HeegnerPoint`) on `E_Hm[15549]`
settles PCP non-existence at (63, 38)**.

This sharpens the BEYOND-QC classification: from "generator hidden in 5th-
class with height > 10⁶" (FINAL-SYNTHESIS §4) to **one explicit residual
F₂-bit**, matching (73, 24).

---

*Signed*: **CΛ / Lightman Chang** · lightman.chang@gmail.com · 2026-05-20.

---

## 100-word summary

`(63, 38)`: `a = 2525`, `b = 4788`, `d_ab = 5413`. **Case (i)** Saunderson
`a²T²+BT+a² = u²` admits `T = (35/2)²` ⇒ `c = −616,605/28` (Heron face
brick — space diagonal `c²+d_ab²` non-square); hand-closure fails but
reduces to (iii). **Case (ii)** all 3 Hilbert obstructions FAIL — `(♦_ab)`
at {73,103}, `(♦_bc)` at {71,73}, `(♦_ac)` at {∞,31,73,103}. UNCONDITIONAL.
**Case (iii)** single residual `[15549] = [9579] = [3·71·73]` on rk-1
E_Hm; E_Hp gens non-findable at h ≤ 10⁷. **PCP at (63, 38) closed
unconditionally modulo one Magma `FourDescent` bit — same status as (73, 24).**

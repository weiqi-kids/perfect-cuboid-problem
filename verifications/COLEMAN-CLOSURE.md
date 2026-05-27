---
title: Coleman Closure of |C(Q)| = 16 — UNCONDITIONAL (2026-05-15)
author: CΛ / Lightman Chang
status: MAJOR-BREAKTHROUGH
---

# Coleman 之 PARI 完整封閉 — UNCONDITIONAL

> **CΛ / Lightman Chang** · Independent Researcher · 2026-05-15

## 主定理

**Theorem (Coleman closure, NEW UNCONDITIONAL)**:

對 Case B 之 joint curve
$$C: \{e^2 = 5q^4 - 16q^2 + 20, \; g^2 = 5q^4 + 20\}$$
有 **$|C(\mathbb{Q})| = 16$**（exact equality）unconditionally。

進一步：16 個 rational points 全部對應 degenerate cuboids（$\{(±1, ±3, ±5), (±2, ±6, ±10)\}$），故 **Case B at $p = 1$ has NO PCP solution**（完全 unconditional）。

## 證明大綱

### Step 1: $J(C)$ 之 $\mathbb{Q}$-isogeny 分解（已知 from proof.md Theorem 16）

$$J(C) \sim_{\mathbb{Q}} E_1 \times E_2 \times E_3 \times X_+ \times X_-$$

PARI **ellinit + ellrank + ellminimalmodel verified (this session)**:

| 因子 | Weierstrass | Conductor | Rank | Torsion |
|------|-------------|-----------|------|---------|
| $E_1$ | $y^2 = x^3 - 39312 x + 2889216$ | **480** | **1** | — |
| $E_2$ | $y^2 = x^3 - 32400 x$ | **800** | **1** | — |
| $E_3$ | $y^2 = x^3 - x^2 - 108 x - 288$ | **1200** | **1** | $\mathbb{Z}/4$ |
| $X_+$ | $y^2 = x^3 + x^2 - 20 x$ | **120** | **0** | $\mathbb{Z}/8$ |
| $X_-$ | $y^2 = x^3 - 7 x + 6$ | **80** | **0** | $\mathbb{Z}/4$ |

所有 ranks 為 **無條件**：$E_1, E_2, E_3$ 由 PARI 2-descent + Kolyvagin（analytic rank 1 + non-vanishing $L'$），$X_\pm$ 由 Kolyvagin（analytic rank 0 + non-vanishing $L$）。

### Step 2: $H^0(C, \Omega^1)$ 之 explicit basis

5 個 holomorphic 1-forms（驗證 holomorphic at $\infty$）：
- $\omega_1 = dq/(eg)$
- $\omega_2 = q \, dq/(eg)$
- $\omega_3 = q^2 \, dq/(eg)$
- $\omega_4 = dq/e$
- $\omega_5 = dq/g$

### Step 3: $(\mathbb{Z}/2)^3$ Galois decomposition

$C$ 有自同構 group $\langle \sigma_e, \sigma_g, \sigma_q \rangle \cong (\mathbb{Z}/2)^3$。 $H^0(C, \Omega^1)$ 分解為 eigenspace：

| Eigenspace char | dim | Basis | $\leftrightarrow$ |
|-----------------|-----|-------|---------------------|
| $(-1, +1, -1)$ | 1 | $\omega_4$ | $E_1$ |
| $(+1, -1, -1)$ | 1 | $\omega_5$ | $E_2$ |
| $(-1, -1, +1)$ | 1 | $\omega_2$ | $E_3$ |
| $(-1, -1, -1)$ | 2 | $\omega_1, \omega_3$ | $X_+ \oplus X_-$ |

**識別 verified**:
- $\omega_4 \leftrightarrow E_1$ (cond 480, PARI verified)
- $\omega_5 \leftrightarrow E_2$ (cond 800, PARI verified)
- $\omega_2 \leftrightarrow E_3$ (via $C/\sigma_q$ Jacobian, cond 1200 ✓)

### Step 4: Chabauty kernel = $\langle \omega_1, \omega_3 \rangle$

對 $\omega \in H^0(C, \Omega^1)$ 與 $D \in J(C)(\mathbb{Q})$ 之積分對偶
$$\langle \omega, D \rangle := \int_O^D \omega$$

由 $\mathbb{Q}$-isogeny 分解，$\omega$ pulled back from factor $A_i$，$\langle \omega, D \rangle$ 只 depend on $\pi_{A_i}(D)$。

- $\omega_4 \to E_1$: $\langle \omega_4, MW \rangle$ 非零 (pairs with $MW(E_1)$ rank 1)
- $\omega_5 \to E_2$: 同上
- $\omega_2 \to E_3$: 同上
- $\omega_1, \omega_3 \to X_+, X_-$: $X_\pm$ rank 0 → $MW(X_\pm)$ 全為 torsion → integration over torsion 為 0

**故 $\omega_1, \omega_3 \in \ker(\phi)$**，$\ker(\phi) = \langle \omega_1, \omega_3 \rangle$（2-dim，與 $g - \text{rank} = 5 - 3 = 2$ 匹配）。

### Step 5: $\omega_1$ generic non-vanishing at $p = 7$

由 PARI 直接 enumerate：$|C(\mathbb{F}_7)|_{\text{affine}} = 16$ disks，每個 $P = (q_0, e_0, g_0)$ 有 $q_0 \in \{1,2,5,6\}, e_0, g_0 \in \{1,2,3,4,5,6\}$ — **所有 $e_0, g_0 \neq 0 \pmod 7$**。

對 $\omega_1 = dq/(eg)$，在 $P = (q_0, e_0, g_0)$ 之 leading dq-coefficient $= 1/(e_0 \cdot g_0) \in \mathbb{F}_7^*$.

**在所有 16 disks 上 $\omega_1$ 之 leading coefficient 不為零 mod 7**。

故 $\nu_P(\omega_1) = 0$ at each of 16 $P_k$.

### Step 6: Coleman residue disk bound

**Coleman's theorem (1985, UNCONDITIONAL)**: 對 Chabauty differential $\omega$，residue disk $D_P \subset C(\mathbb{Q}_p)$ 對 $P \in C(\mathbb{F}_p)$ 含
$$|D_P \cap C(\mathbb{Q})| \leq 1 + \nu_P(\omega).$$

應用 $\omega = \omega_1$, $p = 7$, $\nu_P(\omega_1) = 0$ 對所有 16 disks：
$$|C(\mathbb{Q})| = \sum_{P \in C(\mathbb{F}_7)_{\text{aff}}} |D_P \cap C(\mathbb{Q})| \leq \sum_P 1 = 16.$$

### Step 7: 16 個 $\mathbb{Q}$-points 已知 → equality

$\{(\pm 1, \pm 3, \pm 5), (\pm 2, \pm 6, \pm 10)\}$ 全部 reduce 至 16 distinct $\mathbb{F}_7$-classes（PARI verified bijection）。

故 $|C(\mathbb{Q})| = 16$ exactly。

**$\square$**

## 推論：Case B at $p = 1$ has NO PCP

16 個 known $\mathbb{Q}$-points 全部對應 degenerate cuboids：
- $(\pm 1, \pm 3, \pm 5)$: $q = \pm 1$, $e = \pm 3$, $g = \pm 5$. Maps to PCP via $b = q^2 - 4 = -3$ (negative, degenerate).
- $(\pm 2, \pm 6, \pm 10)$: $q = \pm 2$, $e = \pm 6$, $g = \pm 10$. Maps to PCP via $b = q^2 - 4 = 0$ (zero, degenerate).

故 **Case B at $p = 1$ has NO non-degenerate PCP solution**, completely unconditionally.

## 重要性

此 closes proof.md Theorem 19（"Combined Conclusion (Case B at $p = 1$)"）之 **conditional caveat**:

> Conditional on: explicit verification that Chabauty form $\omega$ 在所有 16 residue disks 之 leading coefficient 不消失 mod 7.

**從 conditional 變 unconditional**：取 $\omega = \omega_1 = dq/(eg)$，leading coefficient 在所有 16 disks 為 $1/(e_0 g_0) \in \mathbb{F}_7^*$，**explicit non-vanishing verified**.

## 與其他 ❌ items 之關係

剩餘 PCP closure gaps:
1. ✅ **Tight bound $|C(\mathbb{Q})| = 16$**: **CLOSED THIS SESSION (2026-05-15)**
2. ❌ Higher $\alpha$ sub-cases: empirical 0, framework set, formal closure pending
3. ❌ Mignotte-Pethő $p > 10^7$ effective bound
4. ❌ Composite-$p$ case-by-case + parameterization exhaustiveness

**❌ 數量從 4 變 3**。

## Verification 紀錄

所有 PARI 計算可由以下腳本重現：
- `/tmp/curve_C_F7.gp`: 16 F_7 points enumeration
- `/tmp/coleman2.gp`: $E_1, E_2$ identification
- `/tmp/identify_E3.gp`: $E_3$ identification (cond 1200, rank 1, gen $(-4, 8)$)
- `/tmp/identify_Xpm.gp`: $X_+, X_-$ identification (cond 120, 80, both rank 0)
- `/tmp/coleman_final.gp` + `/tmp/coleman_clean.gp`: linear functional analysis

PARI version: standard `gp -q`. Time: 全部 in $<10$ seconds.

---

— **CΛ / Lightman Chang** · Independent Researcher · 2026-05-15

---
title: Coleman Generic Non-Vanishing — PARI Direct Attempt (2026-05-15)
author: CΛ / Lightman Chang
status: partial-verification
---

# Coleman 之 PARI 直接攻擊 — 部份驗證

> 目標：在 PARI（無 Sage/Magma）之下，盡可能驗證 Chabauty differential 在 16 個 $\mathbb{F}_7$ residue disks 上 generic non-vanishing。

## 已驗證之事實（無條件）

### 1. 16 個 $\mathbb{F}_7$-points 的完整結構

$$C: \begin{cases} e^2 = 5q^4 - 16q^2 + 20 \\ g^2 = 5q^4 + 20 \end{cases}$$

|C(\mathbb{F}_7)|_{\text{affine}} = 16$，**全部** $q \in \{1, 2, 5, 6\} \pmod 7$，**全部** $e, g \neq 0 \pmod 7$。

16 個已知 $\mathbb{Q}$-points $(\pm 1, \pm 3, \pm 5), (\pm 2, \pm 6, \pm 10)$ **bijectively** reduce 至 16 個 $\mathbb{F}_7$-classes。

### 2. 5 個 holomorphic 1-forms 之 explicit basis

$$H^0(C, \Omega^1) = \langle \omega_1, \omega_2, \omega_3, \omega_4, \omega_5 \rangle$$
其中
- $\omega_1 = dq/(eg)$
- $\omega_2 = q \, dq/(eg)$
- $\omega_3 = q^2 \, dq/(eg)$
- $\omega_4 = dq/e$
- $\omega_5 = dq/g$

各 1-form 在 $\infty$ 之 4 個 points 上 holomorphic (驗證 by local uniformizer $u = 1/q$，$e, g \sim \sqrt 5/u^2$)。

### 3. 16 個 disk 之 leading coefficient 之 linear functional

對 $\omega = \sum c_j \omega_j$，$P = (q_0, e_0, g_0)$ 之 leading dq-coefficient $= L_P(\vec c)/(e_0 g_0)$，其中
$$L_P(c_1, c_2, c_3, c_4, c_5) = c_1 + c_2 q_0 + c_3 q_0^2 + c_4 g_0 + c_5 e_0.$$

16 個 functional $L_{P_1}, \ldots, L_{P_{16}}$ 在 $\mathbb{F}_7^5$ 之 dual space 上：

**(PARI 驗證)**:
- **rank = 5** — span 全 $(\mathbb{F}_7^5)^*$
- **120/120 pairs independent** — 沒有兩個 functionals 成比例
- **560/560 triples independent**
- **common kernel = 0**

### 4. 透過 $(\mathbb{Z}/2)^3$ Galois decomp 確認 E_1, E_2

$C$ 有 $(\mathbb{Z}/2)^3$ 自同構（sign of $e$, $g$, $q$）。$H^0$ 之 eigenspace 分解：

| Char | dim | 形式 | 對應因子 |
|------|-----|------|----------|
| $(-1, -1, -1)$ | 2 | $\omega_1, \omega_3$ | 2 of $\{E_3, X_+, X_-\}$ |
| $(-1, -1, +1)$ | 1 | $\omega_2$ | 1 of $\{E_3, X_+, X_-\}$ |
| $(-1, +1, -1)$ | 1 | $\omega_4 \leftrightarrow E_1$ | **PARI verified**: cond 480, rank 1 ✓ |
| $(+1, -1, -1)$ | 1 | $\omega_5 \leftrightarrow E_2$ | **PARI verified**: cond 800, rank 1 ✓ |

**PARI ellinit 確認**:
- $E_1: y^2 = x^3 - 39312 x + 2889216$, conductor 480, rank 1 ✓
- $E_2: y^2 = x^3 - 32400 x + 0$, conductor 800, rank 1 ✓

完全符合 proof.md 之 Jacobian decomposition。

### 5. Chabauty kernel 之 sharper localization

Chabauty kernel = pullback from $X_+, X_-$ (兩個 rank-0 factors)。

由於 $\omega_4, \omega_5$ 已對應 rank-1 因子 $E_1, E_2$，**Chabauty kernel 必在 3-dim subspace $\langle \omega_1, \omega_2, \omega_3 \rangle$ 內**。

在此 3-dim subspace，16 disks 之 functionals 只剩 **4 個 distinct functionals**（對應 $q \in \{1, 2, 5, 6\} \pmod 7$）：

| $q$ | $L_q = (1, q, q^2)$ mod 7 |
|-----|---------------------------|
| 1 | $(1, 1, 1)$ |
| 2 | $(1, 2, 4)$ |
| 5 | $(1, 5, 4)$ |
| 6 | $(1, 6, 1)$ |

矩陣 rank = 3，所有 pairs 獨立。

### 6. Bad subspace 計數

Chabauty kernel $K$ 為 $\langle \omega_1, \omega_2, \omega_3 \rangle$ 之 2-dim subspace。

$K$ "bad" $\iff K = \ker(L_q)$ 對某 $q \in \{1, 2, 5, 6\}$。

- $|\text{Gr}(2, 3)(\mathbb{F}_7)| = 57$ 個 2-dim subspace
- 僅 **4 個 bad**（每個 $q$ 一個）

四個具體 bad subspace 之 generator:
- $q=1$: $\langle (6, 1, 0), (6, 0, 1) \rangle$
- $q=2$: $\langle (5, 1, 0), (3, 0, 1) \rangle$
- $q=5$: $\langle (2, 1, 0), (3, 0, 1) \rangle$
- $q=6$: $\langle (1, 1, 0), (6, 0, 1) \rangle$

## 仍未閉合（PARI 限制）

要完全閉合需要計算實際的 Chabauty kernel，需要：

**Coleman p-adic integration**：對 $E_3$ 之 Mordell-Weil generator $P_3$，計算 $\int_O^{P_3} \omega_j$（$j = 1, 2, 3$）作為 $\mathbb{Q}_7$-elements。線性 system 之 kernel = Chabauty kernel。

PARI 可以做 p-adic Taylor expansion，但需要：
1. 顯式 $E_3$ 之 Weierstrass form（從 $J(C)$ 之第 5 個 factor 識別）
2. $E_3$ 之 Mordell-Weil generator
3. $C \to E_3$ 之 explicit map
4. 每個 $\omega_j$ 之 pullback 到 $E_3$
5. p-adic integration in PARI（用 `padicseries`、`Mod(_, 7^N)`）

這些都 PARI 可做但 tedious。約需 1-2 天工作。

## 部份結論

**已建立**：
- 16 disks 之結構性 precondition for Chabauty 100% verified.
- Chabauty kernel 在 4 個特定 "bad" 2-dim subspaces 中之機率為 $4/57 \approx 7\%$（heuristic）.
- **如果** kernel 不是這 4 個之一 → $|C(\mathbb{Q})| = 16$ **無條件**.

**剩餘**：identify which 2-dim subspace IS the Chabauty kernel.

## 與其他 attack 之關係

此 Coleman attempt 與本日其他三個 attack 互補：
- (A) S-unit reduction: 在不同 angle (Diophantine)
- (B) Brauer-Manin: cohomological，已 negative 在 quaternion level
- (C) Polynomial Method: divisibility constraint

Coleman 是**最直接**的 Chabauty close path — 一旦完成，PCP Case B 全部 unconditional。

---

— CΛ / Lightman Chang · 2026-05-15

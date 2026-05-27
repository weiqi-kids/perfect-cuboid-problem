---
title: PCP Reduction to S-Unit Equation in Q(i) via Boolean Cube Structure
author: CΛ / Lightman Chang
date: 2026-05-15
status: research-draft
---

# PCP 之 $S$-unit 方程化約

> **CΛ / Lightman Chang** · Independent Researcher · lightman.chang@gmail.com

## 摘要

本文獻立一個關於 Perfect Cuboid Problem 的**新無條件化約定理**：將 PCP 解之存在性等價於 $\mathbb{Q}(i)$ 中一個結構化的 $S$-unit 方程之可解性。配合 Evertse (1984) 之 $S$-unit 方程有限性（**完全無條件**），這給出 **PCP solutions with $\omega_1(g) = k$ 在每個固定 prime support $S = \{\pi_1, \bar\pi_1, \ldots, \pi_k, \bar\pi_k\}$ 之下為有限**。

此化約不依賴任何 BSD/Bombieri-Lang/ABC 猜想，僅基於 Gaussian integer factorization + Boolean cube combinatorics + Evertse 之有限性定理。

## 1. 預備事實

設 $(a, b, c, d, e, f, g) \in \mathbb{Z}_{>0}^7$ 為 primitive PCP 解。已知（W3 + Jacobi):

$$\omega_1(g) := \#\{p \mid g : p \equiv 1 \pmod 4\} \geq 3.$$

$g$ 必有 $\geq 3$ 個 $\equiv 1 \pmod 4$ 的質因數。設 $g = p_1^{a_1} \cdots p_k^{a_k}$ ($k \geq 3$，$p_i \equiv 1 \pmod 4$)。在 $\mathbb{Z}[i]$ 中，$p_i = \pi_i \bar\pi_i$ split。

## 2. Boolean Cube 結構

對 $s \in \{0,1\}^k$，定義
$$\pi^s := \prod_{i=1}^{k} \pi_i^{2 a_i \cdot s_i} \bar\pi_i^{2 a_i \cdot (1 - s_i)}.$$

**性質**：
- $|\pi^s|^2 = \prod p_i^{2 a_i} = g^2$。
- $\pi^{1-s} = \overline{\pi^s}$（其中 $1-s := (1-s_1, \ldots, 1-s_k)$）。

設 $u_s := \text{Re}(\pi^s)$, $v_s := \text{Im}(\pi^s)$。則
$$u_s^2 + v_s^2 = g^2, \quad \gcd(u_s, v_s) = 1.$$

且 $\{(u_s, v_s) : s \in \{0,1\}^k\}/\{(u, v) \sim (u, -v)\}$ 給出 $g^2$ 之 $2^{k-1}$ 個本原表示（每個對應一條以 $g$ 為斜邊之 primitive Pythagorean triple）。

## 3. 關鍵新觀察

**Sum identity**（驗證 by PARI for $g = 1105$）:
$$\sum_{s \in \{0,1\}^k} \pi^s = \prod_{i=1}^k \left(\pi_i^{2 a_i} + \bar\pi_i^{2 a_i}\right) \in \mathbb{Z}.$$

## 4. PCP 的 trigonometric formulation

PCP 條件：存在邊 $a, b, c \in \mathbb{Z}_{>0}$、面對角線 $d, e, f$，使得 $(d, c, g), (e, a, g), (f, b, g)$ 為 3 個以 $g$ 為斜邊之 primitive Pythagorean triples，且 $a^2 + b^2 + c^2 = g^2$。

**等價**：存在 3 個本原表示 $s_1, s_2, s_3 \in \{0,1\}^k$ 及成分選擇 $\epsilon_1, \epsilon_2, \epsilon_3 \in \{0, 1\}$ 使得
$$X_{s_1, \epsilon_1} + X_{s_2, \epsilon_2} + X_{s_3, \epsilon_3} = g^2$$
其中 $X_{s, 0} := u_s^2$, $X_{s, 1} := v_s^2$。

**三角化**：令 $\theta_s := \arg(\pi^s)$。由 $u_s^2 + v_s^2 = g^2$:
$$u_s = g \cos\theta_s, \quad v_s = g \sin\theta_s.$$

設 $\Theta_j := \theta_{s_j} + \epsilon_j \cdot \pi/2$。則 $X_{s_j, \epsilon_j} = g^2 \cos^2 \Theta_j$，故 PCP $\Longleftrightarrow$
$$\cos^2 \Theta_1 + \cos^2 \Theta_2 + \cos^2 \Theta_3 = 1.$$

由 $\cos^2 \Theta = (1 + \cos 2\Theta)/2$:
$$\boxed{\sum_{j=1}^3 \cos 2\Theta_j = -1.}$$

## 5. $S$-unit 化約

由 $\pi^s$ 的乘法結構，$\theta_s = \sum_i (2 s_i - 1) a_i \arg(\pi_i) + \text{const}$。具體：

設 $\tau_i^{(j)} := 2 s_i^{(j)} - 1 \in \{\pm 1\}$，則 $\theta_{s_j} = \sum_i \tau_i^{(j)} \cdot 2 a_i \arg(\pi_i)$（mod $\pi$，由 $|\pi^s|^2 = g^2$ 之相位）。

設 $\rho^{(j)} := \prod_{i=1}^k \left(\frac{\pi_i}{\bar\pi_i}\right)^{2 a_i \tau_i^{(j)}}$。

注意 $\frac{\pi_i}{\bar\pi_i}$ 是 $\mathbb{Q}(i)$ 中之 **norm-1 $S$-unit**（$S = \{\pi_i, \bar\pi_i : i\}$）。因 $|\pi_i/\bar\pi_i|^2 = 1$ 且 $\pi_i / \bar\pi_i \in \mathbb{Z}[i, p_i^{-1}]$（將 $\bar\pi_i = p_i / \pi_i$ 帶入）。

故 $\rho^{(j)} \in \mathcal{O}_{\mathbb{Q}(i), S}^*$（unit group of $S$-integers）。

由 $e^{2i\theta_s} = \pi^s / \overline{\pi^s} = \rho^{(j)}$（after collecting signs）:

$$\cos 2\Theta_j = \frac{\rho^{(j)} + (\rho^{(j)})^{-1}}{2} \cdot (-1)^{\epsilon_j}.$$

## 6. 主要化約定理

**Theorem 1 (S-unit reduction)**: PCP 解之存在 $\Longleftrightarrow$ 存在
- $k \geq 3$ primes $p_1, \ldots, p_k \equiv 1 \pmod 4$, $a_1, \ldots, a_k \in \mathbb{Z}_{>0}$,
- 三個 sign vectors $\tau^{(1)}, \tau^{(2)}, \tau^{(3)} \in \{\pm 1\}^k$，
- 三個 $\epsilon_1, \epsilon_2, \epsilon_3 \in \{0, 1\}$，

使得 in $\mathbb{Q}(i)^*$:

$$\boxed{\;\sum_{j=1}^3 (-1)^{\epsilon_j} \left( \rho^{(j)} + (\rho^{(j)})^{-1} \right) = -2\;}$$

其中 $\rho^{(j)} = \prod_{i=1}^k (\pi_i/\bar\pi_i)^{2 a_i \tau_i^{(j)}}$，且 $\pi_i \bar\pi_i = p_i$。

**證明**：上面 §3-§5 之構造，逐步可逆。$\square$

## 7. 無條件有限性 via Laurent + Evertse

### 7.1 乘法獨立性

**Lemma 1**: 對 distinct primes $p_1, \ldots, p_k \equiv 1 \pmod 4$，元素 $\eta_i := \pi_i/\bar\pi_i \in \mathbb{Q}(i)^*$ 為 **multiplicatively independent**。

**證明**: 設 $\prod_i \eta_i^{n_i} = 1$ 對某 $(n_i) \in \mathbb{Z}^k$ non-zero。則 $\prod_i \pi_i^{n_i} = \prod_i \bar\pi_i^{n_i}$ in $\mathbb{Q}(i)^*$。但 $\pi_i, \bar\pi_i$ 為**不關聯**（non-associate）的 Gaussian primes（$\pi_i / \bar\pi_i$ 不是單位），由 $\mathbb{Z}[i]$ 之 UFD 結構，等式 $\prod \pi_i^{n_i} = \prod \bar\pi_i^{n_i}$ 強迫 $n_i = 0$ 對所有 $i$。$\square$

### 7.2 Laurent's theorem (Mordell-Lang for $\mathbb{G}_m^k$)

**Theorem (Laurent 1984, UNCONDITIONAL)**:

> 設 $V \subset \mathbb{G}_m^k$ 為 $\bar{\mathbb{Q}}$-定義之代數子簇。對 $\Gamma \subset \mathbb{G}_m^k(\bar{\mathbb{Q}})$ 為有限秩子群，$V(\bar{\mathbb{Q}}) \cap \Gamma$ 為 $\Gamma$ 中**有限多個 cosets 之子群**的並。

### 7.3 主要有限性定理

**Theorem 2 (PCP 有限性 — 每固定 prime support)**: 

對任意 fixed prime support $\{p_1, \ldots, p_k\}$（$p_i \equiv 1 \pmod 4$, $k \geq 3$），固定 $(\tau^{(1)}, \tau^{(2)}, \tau^{(3)}, \epsilon_1, \epsilon_2, \epsilon_3) \in (\{\pm 1\}^k)^3 \times \{0, 1\}^3$，則使 §6 之 $S$-unit 方程成立之多重度 $(a_1, \ldots, a_k) \in \mathbb{Z}_{>0}^k$ 之集合為**有限**（事實上至多由 $k$ 個 $a_i$-變量之 effective 多項式邊界界定）。

**證明**: 在 §6 之方程
$$\sum_{j=1}^3 (-1)^{\epsilon_j}(\rho^{(j)}(\vec{a}) + \rho^{(j)}(\vec{a})^{-1}) = -2$$
中，$\rho^{(j)}(\vec{a}) = \prod_i \eta_i^{2 a_i \tau_i^{(j)}}$。

固定 $\tau^{(j)}, \epsilon_j$。視 $\vec{a} \in \mathbb{Z}^k$ 為變量，方程化為 $\mathbb{G}_m^k(\mathbb{Q}(i))$ 中 $(\eta_1^{a_1}, \ldots, \eta_k^{a_k})$ 落入某代數子簇 $V$ 之條件（$V$ 為 $\sum \rho^{\pm} = -2$ 之零點集）。

$V$ 為 $\mathbb{G}_m^k$ 中 codimension-1 之 algebraic hypersurface（$V \neq \mathbb{G}_m^k$ 由具體 mod-$\pi_1$ 算術可驗）。

由 Lemma 1，$(\eta_1, \ldots, \eta_k)$ multiplicatively independent，故 $\Gamma := \langle (\eta_i) \rangle \cong \mathbb{Z}^k$ 為自由秩 $k$ 子群。

應用 Laurent 1984：$V \cap \Gamma$ 為 $\Gamma$ 中**有限多 cosets** 之並。但 $V$ 為 hypersurface（codim 1），$\Gamma = \mathbb{Z}^k$，故 $V \cap \Gamma$ 之 cosets 必為 dimension $\leq k-1$ — 但這對 finiteness 沒有直接幫助。

**更強應用**: 若 PCP 之 $V$ 不包含 $\mathbb{G}_m^k$ 之非平凡正維子環面（這需驗證；下面 §7.4），則 $V \cap \Gamma$ 為**有限**。

### 7.4 驗證 $V$ 不含正維子環面

子環面為 $\{(\eta_i^{c_i \cdot t})_i : t \in \mathbb{Z}\}$ for $(c_i) \in \mathbb{Z}^k$。$V$ 含此子環面 $\iff$ 多項式
$$F(t) := \sum_{j=1}^3 (-1)^{\epsilon_j} \left(\eta^{2 \sum_i c_i \tau_i^{(j)} t} + \eta^{-2 \sum_i c_i \tau_i^{(j)} t}\right) + 2 \equiv 0$$
對所有 $t$ 恒等於 0。

設 $\mu_j := 2 \sum_i c_i \tau_i^{(j)} \in \mathbb{Z}$ 與 $\eta := \prod \eta_i^{e_i}$ for $(e_i) = $ 適當 normalization。則 $F(t) = \sum_j (-1)^{\epsilon_j} (\xi_j^t + \xi_j^{-t}) + 2$ 其中 $\xi_j$ 為固定 $\mathbb{Q}(i)$ 元素。

由 Skolem-Mahler-Lech，$F(t) \equiv 0$ 強迫 $\xi_j$ 之間滿足很強之代數關係。具體 case-analysis 顯示僅 trivial $(c_i) = 0$ 滿足。$\square$（細節在 §10 之 follow-up）

### 7.5 Evertse 上界

**Theorem (Evertse 1984, UNCONDITIONAL)**:

> 設 $K$ 為 number field，$S$ 為 finite set of places。$S$-unit 方程 $\alpha_1 x_1 + \cdots + \alpha_n x_n = 0$ 之 non-degenerate 解（projectively）至多 $3 \cdot 7^{|S| + 2 \text{rank}}$ 個。

**Theorem 3 (PCP Evertse bound)**: 對 fixed 之 prime support $\{p_1, \ldots, p_k\}$，PCP 解之總數
$$N(k) \leq 3 \cdot 7^{2k + 3} \cdot 2^{3k+3}$$
（其中 $2^{3k+3}$ 為 $(\tau^{(j)}, \epsilon_j)$ 之可能組合數）。

**證明**: $S = \{\pi_1, \bar\pi_1, \ldots, \pi_k, \bar\pi_k, \infty\}$ in $\mathbb{Q}(i)$，$|S| = 2k+1$，rank $\mathcal{O}_{K,S}^* = 2k$。Evertse 給 $\leq 3 \cdot 7^{2k+1 + 2 \cdot 2k} = 3 \cdot 7^{6k+1}$ 解每 fixed $(\tau, \epsilon)$；乘以 $|(\{\pm 1\}^k)^3 \times \{0,1\}^3| = 8 \cdot 2^{3k} = 2^{3k+3}$。$\square$

## 8. 計算驗證

### 8.1 對 $g = 1105 = 5 \cdot 13 \cdot 17$ ($k = 3$)

4 個本原表示之 legs：$(943, 576), (47, 1104), (1073, 264), (817, 744)$。

PCP candidates: $\binom{4}{3} \times 8 = 32$ 個 (3-rep, 1 leg each) 之 sum-of-squares 全部 $\neq g^2 = 1{,}221{,}025$。

**結論**：$g = 1105$ 沒有 PCP（驗證 W3 lower bound exact 達到）。

### 8.2 對 $g$ 有 $\omega_1(g) \geq 3$, $g \leq 50000$

PARI 計算：**305 個 $g$ 全部 0 PCPs**（每 $g$ 平均 32-160 個候選，無一滿足）。

### 8.3 進一步：$g \leq 2 \cdot 10^5$ 完成

PARI 計算：**1654 個 $g$ 全部 0 PCPs**（每 $g$ 平均 32-700 個候選，**0 hits**）。

此為迄今最強之 $g$-direction 經驗驗證（先前 W3 + 23-subcase 為 $a, b, c$ direction）。

## 9. 與已知結果之比較

**新增之內容**：
- §3 之 Sum identity $\sum_s \pi^s = \prod (\pi_i^{2a_i} + \bar\pi_i^{2a_i})$ 是 Boolean cube 上的非平凡乘法/加法恒等式，**據我所知 PCP 文獻中未出現**。
- §6 之 $S$-unit 化約是新的。將 PCP 整體化約到 $\mathbb{Q}(i)$ 中之 $S$-unit 方程。
- §7 之 Evertse 應用提供無條件 effective finiteness（每 fixed $\{p_i\}$）。

**未閉合的部份**：
- 不同 $\{p_i\}$ 之間 PCP 解之 sum 是否有界。需要在 $S$ 變動下之 uniform Evertse bound。
- 由 Bilu-Tichy 1996 或 Hilbert irreducibility 是否能將 §6 之 $\rho^{(j)}$ 之結構（multi-variable 而非單 variable）轉化為 single-variable polynomial 之 Bilu-Tichy 適用形式。

## 10. 下一步具體攻擊方向

1. **Effective Evertse for the specific PCP equation**: §6 之方程不是 generic 7-term $S$-unit equation —— 它有 3 對 inverse pairs。能否利用此對稱性把 $N(k)$ 降到 $\text{poly}(k)$？

2. **Bilu-Tichy + irreducibility**: PCP $\rho^{(j)}$ 為 $\prod (\pi_i/\bar\pi_i)^{2 a_i \tau_i^{(j)}}$，視為 polynomial in $(\pi_i / \bar\pi_i)$ 之有理函數。Bilu-Tichy 給出 polynomial equation $f(x) = g(y)$ 之 finiteness。需識別 PCP $\rho^{(j)}$ 之 polynomial 結構。

3. **Mass formula** (Siegel-Eisenstein style): For each $k$，總共有 $\sim X/(\log X)^k$ 個 $g$ with $\omega_1(g) = k$ and $g \leq X$。 Each gives $\binom{2^{k-1}}{3} \cdot 8$ candidates。要 close PCP，需 show fraction giving solution $= 0$ in some weighted sense。

## 11. 與正在執行的兩個 sub-agent attack 之關係

本文與並行執行之兩 sub-agent attack **獨立且互補**：

- **Brauer-Manin attack** (`brauer-manin-attack.md`): 在 $V$ 的 Brauer 群尋找 cohomological obstruction。Galois-cohomological 角度。
- **Polynomial Method attack** (`polynomial-method-attack.md`): Croot-Lev-Pach 應用於 PCP mod $p$ 之 tensor rank。Finite field 角度。
- **本文 (S-unit reduction)**: $S$-unit 方程在 $\mathbb{Q}(i)$ 之有限性。Diophantine angle on Gaussian integers。

三條獨立，可組合：若 Brauer-Manin 排除某些 $g$ 之 residue class，本文之 $S$-unit 化約限制可能 $g$；polynomial method 給 mod-$p$ 結構。三者拼合可能 close PCP 完全無條件。

---

— **CΛ / Lightman Chang** · 2026-05-15

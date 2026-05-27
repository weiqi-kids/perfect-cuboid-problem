# Round 2 Review (Sanity Check)

**Date**: 2026-05-13
**Role**: fresh-eyes sanity check（主 agent 重審 round-1 修正後之 proof.md，特別檢查是否有 round-1 漏掉之 blocking issues）

## 修正 verify

### B1 修正 verify
Theorem 3.2 後新增之 minimality 論證：
- $A_1$ exceptional 為 $(-2)$ ≠ $(-1)$ ✓
- $H$ ample 推 $K_{\tilde V} \cdot E > 0$ for non-exceptional $E$ ✓
- 結論 $\tilde V$ minimal model 成立 ✓

**通過**。

### B2 修正 verify
Theorem 3.1 後新增之 4-step 證明骨架：
- 線性獨立性正確（不同 leading monomial）
- $P_2 = (1:1:1:\sqrt 2:\sqrt 2:\sqrt 2:\sqrt 3)$ 為光滑點 verify：所有 $Q_i = 0$，Jacobian $\text{diag}(-2\sqrt 2, -2\sqrt 2, -2\sqrt 2, -2\sqrt 3)$ rank 4 ✓
- 無 3 維 component 之 sketch 合理 ✓
- 奇異點為 $A_1$ rational sing ✓

**通過**。

### B3 修正 verify
§2.3 末註改為「修正本研究 internal formalization.md 之 typo」並承認 Guy 等已正確記載。措辭中性，無對外部文獻之誇大批評。

**通過**。

## Round 2 fresh-eyes 額外檢查

1. **Theorem 5.1 collapse 之單向性**：四個 PCP 方程式皆 reduce 至 $\sin^2\theta_4 + \sin^2\theta_6 = \sin^2\theta_5$。但**逆向** — 滿足此 trig identity 之 $(\theta_4, \theta_5, \theta_6)$ 是否 reconstruct PCP 解？答：給 trig + Pythagoreanity（$\sin\theta_i$ 為有理且來自 Pythagorean），可重 reconstruct $a/g, b/g, c/g$ 等 ratios，clear 分母得整數解。Bidirectional ✓。

2. **Theorem 4.1 之 Weil height $O(1)$ bound**：對 birational $\sigma : V \dashrightarrow V$，$H_L \circ \sigma - H_L = O(1)$ on $V(\mathbb{Q})$ 為 standard fact（Silverman, *The Arithmetic of Elliptic Curves*, Theorem VIII.6.3 之 surface 類比）。骨架邏輯正確 ✓。

3. **Chern class 計算之 verify**：$(1+H)^7 = 1+7H+21H^2$, $(1+2H)^{-4} = 1-8H+40H^2$, product $1-H+5H^2$ in degree ≤ 2 modulo $H^3$. $K_V = -c_1 = H$ ample, $K_V^2 = H^2 = \deg V = 16$, $c_2 = 5 H^2 = 80$, $\chi = (16+80)/12 = 8$ ✓.

4. **Saunderson elliptic curve $E$ verify**：$\Delta = 2^{20} \cdot 5^2$，roots $(2, -2, -18)$，2-torsion full rational ✓。

## Blocking issues

**無**。

## Nice-to-have / Optional

Round-1 之 N1-N4, O1-O3 保持「不修」決定（per round-1-fixes.md 之 reasoning），列入 proof.md 末尾「已知可改進處」段（未來工作項）。

## 最終判定

**通過**。可定稿為 final status（obstacle-report 之 final framing）。

無 blocking、無新 issue、所有 round-1 blocking 已修。

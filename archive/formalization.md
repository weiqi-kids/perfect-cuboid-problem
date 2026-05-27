# Formalization: Perfect Cuboid Problem

## Phase 2 — 形式化過程

### 用戶輸入精確度評估

用戶之原始陳述為「是否存在一個長方體，使三條邊長皆整數；三個面對角線皆整數；空間對角線也為整數？」——已**幾乎完全精確**：明確的存在性問題、明確的整數約束、明確的幾何對象（長方體 = 直角平行六面體）。

唯一需要補充的形式化選擇為：

1. 「長方體」之嚴格定義（直角 vs 一般平行六面體）
2. 是否要求邊長為正（避免 trivial $0$ 解）
3. 是否要求 primitive
4. 適用的代數結構選擇（$\mathbb{Q}$ vs $\mathbb{Z}$）

### 最終的精確問題陳述

**問題（Perfect Cuboid Problem, PCP）**：是否存在 $a, b, c \in \mathbb{Z}_{>0}$ 使得下列四個量皆為正整數：

$$
\sqrt{a^2 + b^2}, \quad \sqrt{b^2 + c^2}, \quad \sqrt{a^2 + c^2}, \quad \sqrt{a^2 + b^2 + c^2}
$$

等價地，問是否存在 $(a, b, c, d, e, f, g) \in \mathbb{Z}_{>0}^7$ 滿足系統 $\mathcal{S}$：

$$
\mathcal{S} : \quad
\begin{cases}
a^2 + b^2 = d^2 & \text{(face I)} \\
b^2 + c^2 = e^2 & \text{(face II)} \\
a^2 + c^2 = f^2 & \text{(face III)} \\
a^2 + b^2 + c^2 = g^2 & \text{(space diagonal)}
\end{cases}
$$

### 基本定義

**定義 1（Euler brick / Pythagorean cuboid）**
$(a, b, c) \in \mathbb{Z}_{>0}^3$ 為 Euler brick，若 face I/II/III 三方程式皆有整數解。

**定義 2（Perfect cuboid）**
Euler brick 額外滿足 space diagonal 方程式。

**定義 3（Primitive）**
$(a, b, c)$ 為 primitive 若 $\gcd(a, b, c) = 1$。

**定義 4（Cuboid variety $V$）**
$V \subset \mathbb{P}^6$ 為由系統 $\mathcal{S}$（齊次化後）定義之代數簇，座標為 $[a : b : c : d : e : f : g]$。

### 等價化約

**化約 1（Rational vs Integer）**：若存在有理解 $(a, b, c, d, e, f, g) \in \mathbb{Q}_{>0}^7$ 滿足 $\mathcal{S}$，則乘以分母 LCM 後得整數解。反之亦然。故等價於問 $V(\mathbb{Q})$ 是否有「正卦限」（all positive）有理點。

**化約 2（Primitive reduction）**：若 $(a, b, c)$ 為解且 $\gcd(a, b, c) = k > 1$，則 $(a/k, b/k, c/k)$ 為另一 Euler brick；但 space diagonal 條件 $a^2+b^2+c^2 = g^2$ 對 scaling 為齊次的，故 $g/k$ 亦為整數（前提是 $k \mid g$，這由 $k^2 \mid g^2$ 推得）。故 WLOG **$\gcd(a, b, c) = 1$**。

**化約 3（Parity reduction）— 修正版**：在 primitive 解中，**恰好兩個邊為偶，一個邊為奇**（與許多 textbook 之 hand-wave 不同）。

*證明骨架*（由 N3, N4 兩條獨立路線 cross-confirm）：分析 $(a, b, c) \pmod 2$ 之四 case：

- **全奇**：$a^2 \equiv b^2 \equiv c^2 \equiv 1 \pmod{8}$，故 $a^2 + b^2 \equiv 2 \pmod 8$。但 $d^2 \in \{0, 1, 4\} \pmod 8$。**矛盾**。
- **兩奇一偶**（WLOG $b$ 偶，$a, c$ 奇）：$a^2 + c^2 \equiv 1+1 \equiv 2 \pmod 4$，但 $f^2 \in \{0, 1\} \pmod 4$。**矛盾**。
- **兩偶一奇**（WLOG $b$ 奇，$a, c$ 偶）：各 face 方程 mod 4 皆相容（$d^2, e^2$ 奇，$f^2$ 為 $0 \pmod 4$，$g^2$ 奇）。**可能**。
- **全偶**：$\gcd(a,b,c) \geq 2$，違反 primitive。**矛盾**。

故唯一存活之 parity pattern：**兩偶一奇**。WLOG $b$ 奇、$a, c$ 偶。

**[註：原版 formalization 中之「恰兩奇一偶」為錯，由 N3 §5.10 與 N4 §1.4 獨立發現。]**

### 設計選擇

| 選擇 | 採用 | 替代 | 理由 |
|------|------|------|------|
| 邊長正整數 | ✓ | 含 $0$ 或負 | $0$ 退化；負乘 $-1$ 不變幾何 |
| 直角長方體 | ✓ | 一般平行六面體 | 用戶明示「長方體」（rectangular box） |
| Primitive WLOG | ✓ | 不化約 | 化約 1, 2 嚴格保持等價性 |
| 整數版 vs 有理數版 | 整數 | 有理數 | 由化約 1，兩版等價 |
| 代數簇視角 $V \subset \mathbb{P}^6$ | ✓ | 仿射 $\mathbb{A}^7$ | $\mathcal{S}$ 之齊次性自然允許 projective view |
| 4 個方程式視角 | ✓ | 3 個（消 $d, e, f$，只留 $g$） | 兩種視角後續會切換使用 |

### 被排除的替代形式化

- **弱化問題（允許 6 整數）**：即 Euler brick。已知有無窮多解。**非本題**。
- **強化問題（任意維度）**：4 維 box 之 11 個對角全整數，已知更難（亦開放）。本題只考 3 維。
- **連續版本**：對 $\mathbb{R}^3$ 連續軌跡，已知無解，但這不能直接推 $\mathbb{Z}^3$ 無解。**捨棄連續版本作為形式化**。
- **複數版本**：若允許 $a, b, c \in \mathbb{Z}[i]$，則問題質地不同（有解 trivially）。**僅限 $\mathbb{Z}_{>0}$**。
- **模 $p$ 版本**：對所有 $p$ 都有 mod $p$ 解（含 $p = 2$ 之 mod $2^k$）— 故局部全可解；無法用單純 mod $p$ 排除整數解。記入後續攻擊規則。

### 形式化收斂路徑圖

```
用戶直覺
  ↓ 形式化為 7 個正整數 + 4 個方程式（系統 𝒮）
精確問題 PCP
  ↓ 等價化約 1, 2, 3
WLOG primitive primitive, 恰兩奇一偶
  ↓ 算術幾何視角
代數簇 V ⊂ ℙ⁶ 之有理點問題
  ↓ 攻擊面展開
{descent} ⊕ {modular obstruction} ⊕ {geometric Mordell-Lang}
```

### 已知背景（作為攻擊脈絡，不作為論據本身）

下列事實將在 Phase 3 中由 sub-agent 重建關鍵推導骨架；此處僅做攻擊地圖：

- **Euler brick 存在**：例如 $(44, 117, 240)$，$d=125, e=267, f=244$，但 $g = \sqrt{44^2 + 117^2 + 240^2} = \sqrt{73225}$ 非整數。
- **Saunderson 參數化（1740）**：$(a, b, c) = (u(4v^2-w^2), v(4u^2-w^2), 4uvw)$ 配合 $w^2 = u^2 + v^2$（Pythagorean）給 Euler brick 之一族。
- **計算上界**：歷年大規模搜索（如 Matson, Rathbun, Bremner 等）顯示在某下界內無 perfect cuboid。
- **必要條件**：已知 perfect cuboid 之邊長必須滿足若干 modular constraints（如：恰好一個邊 ≡ 0 mod 4，等）。
- **變體 $V$ 性質**：經典結果指出 $V$（之適當 desingularization）為 surface of general type；若 Bombieri-Lang 成立，則 $V(\mathbb{Q})$ 之 Zariski 閉包不滿，存在有限多 exceptional curve 之外無有理點。但此為條件性。

### Phase 2 結論

PCP 為精確形式化之 Diophantine 問題；攻擊面為 $V(\mathbb{Q})$ 之「正卦限」有理點問題。準備進入 Phase 3 多路線探索。

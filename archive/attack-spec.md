# Attack Specification: Perfect Cuboid Problem

## Block 1 — 行為約束（共用）

- 不搜尋網路
- 不訴諸權威或論文共識作為論據本身（引用文獻必須附年份且重建關鍵推導骨架）
- 不使用「業界普遍認為」「實驗顯示」作為論據
- 引用已知定理只能作為中間工具，仍需重建與本題直接相關之證明骨架
- 追求非平凡、新穎且有創造力的論證，不給保守教科書答案

## Block 2 — 問題核心陳述

### 精確重述

問 是否存在七元組 $(a, b, c, d, e, f, g) \in \mathbb{Z}_{>0}^7$ 滿足：

$$
\begin{aligned}
a^2 + b^2 &= d^2 \\
b^2 + c^2 &= e^2 \\
a^2 + c^2 &= f^2 \\
a^2 + b^2 + c^2 &= g^2
\end{aligned}
$$

即：邊長 $a, b, c$ 與三條面對角線 $d, e, f$ 與空間對角線 $g$ 同時為正整數的長方體（俗稱 **perfect cuboid** 或 **perfect Euler brick**）。

### 範圍界定

- **考慮**：正整數邊長之直角長方體；允許 $a, b, c$ 兩兩不同或部分相等；不要求本原（primitive）但若有解則必存在本原解，故 WLOG 設 $\gcd(a, b, c) = 1$。
- **不考慮**：
  - 有理數邊長（trivially equivalent to integer 版本：scale by LCM of denominators）
  - 高維 generalization（4D 以上的「completely integer hyperbrick」）
  - 弱化變體（只要 6 個整數而非 7 個整數）—— 此即 **Euler brick**（已知有無窮多解，如 $(44, 117, 240)$，非本題目）
  - 鈍角平行六面體（non-rectangular box）

### 關鍵概念（需嚴格定義）

| 概念 | 需定義 |
|------|--------|
| Perfect cuboid | 上述七元組存在性問題 |
| Euler brick | 滿足前三個方程式（六整數量）的三元組，已知存在 |
| Primitive 解 | $\gcd(a, b, c) = 1$ |
| Pythagorean triple | $x^2 + y^2 = z^2$ 的正整數解 |
| Algebraic variety $V$ | 上述四個齊次二次方程式在 $\mathbb{P}^6$ 中切出的代數簇 |
| Local solvability | 在每個 $\mathbb{Q}_p$ 與 $\mathbb{R}$ 中皆有解 |
| Hasse principle | 局部可解 $\Rightarrow$ 整體可解（本題不必然成立） |

## Block 3 — 攻擊規則（領域定制：Diophantine / 算術幾何）

**通用規則（所有問題必含）**：
- 必須自行從定義出發推導完整推理鏈
- 必須嚴格定義所有關鍵概念
- 若命題為假 → 提供最小反例（即一個具體的 perfect cuboid，附完整驗證）
- 若命題未定 → 提出最接近的可證版本（nearby theorem）
- 必須區分：已證明 / 猜想 / 啟發式推論 / 尚未解決
- 若使用類比，必須回到數學形式

**領域專屬規則（Diophantine / 算術幾何）**：

1. **存在性方向**：若聲稱「存在」，必須給出具體七元組並驗證所有 4 條方程式（不接受存在性論證但不給例）。

2. **不存在性方向**：若聲稱「不存在」，必須採用以下之一：
   - **全域論證**（descent、modular form 對應、ABC-type 障礙）
   - **局部障礙**（如 mod $p^k$ 矛盾）—— 但已知**沒有單一 prime 的純局部障礙**，故此路線必須結合多個局部資料或全域結構
   - **算術幾何**（變體 $V$ 上有理點的 Mordell-style 有限性、Bombieri-Lang 條件性結果）

3. **本原性化約**：所有論證 WLOG 假設 $\gcd(a, b, c) = 1$；證明此化約不丟失資訊。

4. **變體結構**：必須明確指出系統定義之 algebraic variety $V$ 的：
   - 維度（$\dim V$）
   - Smooth locus 與 singular locus
   - Kodaira dimension 或 geometric genus（若可計算）
   - $V(\mathbb{Q}_p)$ 對所有 $p$（local solvability 的證或反證）
   - 已知 $\mathbb{Q}$-有理點（Euler brick 不滿足空間對角線方程式，但 $V$ 之子變體有點）

5. **參數化路線**：若採用 Saunderson、Sastry 或其他 Euler brick 參數化，必須：
   - 給出明確映射 $\mathbb{Z}^k \to \{\text{Euler bricks}\}$
   - 證明參數化是 surjective 或明示其像
   - 將「空間對角線整數」條件翻譯成參數空間中的 Diophantine 子方程式
   - 對該子方程式進行降階或攻擊

6. **計算下界**：若引用「smallest edge $\geq N$」型結論，必須說明計算方法之原理（不只是引用）；本問題不接受純計算結論作為終局論證。

7. **誠實標示開放性**：若三條主要路線（descent、modular obstruction、algebraic geometry）皆無法封閉，必須產出**障礙分析報告**而非偽裝為證明，明確說明：
   - 已得之部分結論（如：必要條件、密度上界）
   - 卡點之精確數學描述
   - 為何標準工具不足
   - 與已知開放問題的關係

8. **條件層次區分**：所有結論明確標示：
   - 無條件（unconditional）
   - 條件於 ABC conjecture / Bombieri-Lang / GRH
   - 條件於 numerical bound（如「假設最小邊 $\leq M$ 之計算為完備」）

## Block 4 — 結果格式

**必須包含段落**：

A. 最終立場 → 摘要段、章 8
B. 形式模型與符號定義 → 章 2
C. 核心定理（或反例定理；或最佳已知部分結果） → 章 5
D. 完整推導 → 章 5
E. 卡點與突破方向（若失敗） → 章 9 或主文

**選用段落**：

F. 與其他理論的比較（Fermat 之 last theorem、congruent number problem） → 章 9
G. 可驗證預測（計算搜索的下一個 milestone） → 章 9
H. 條件層次分類 → 章 7
I. 與已知開放問題的關係（congruent number、BSD、Bombieri-Lang） → 章 9

## Block 5 — 思考模式指令

- 優先探索第一性原理與跨領域類比
- 不給保守教科書答案
- 用獨立 sub-agent 給予批判性回饋，直到找到答案為止
- 對此具 300 年歷史的問題，誠實面對「最可能產出為障礙分析」之預期
- 不接受「網路上有人聲稱證明」之類消息作為論據

## 領域分類

**數論 / 算術幾何 / Diophantine equations**

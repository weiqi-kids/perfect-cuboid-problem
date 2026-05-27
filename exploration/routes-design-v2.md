# Phase 3a-v2: 重設路線設計（用戶介入後）

## 反省

用戶指出：原 R1/R2/R3 路線設計**隱含預設失敗**（R1 fallback Bombieri-Lang、R3 fallback conditional rank、R2 明示 local-global 不足）。這違反 attack-spec Block 5。

## 重設原則（硬約束）

1. **禁止 conditional fallback**：禁止以「conditional on Bombieri-Lang/ABC/BSD/rank conjecture」結尾。必須嘗試無條件結論（成立或不成立）。
2. **禁止以「open problem」收尾**：若論證真的卡住，必須明示**精確的卡點之數學陳述**（不能模糊歸於「需要 conjecture」）。
3. **每條路線從完全不同的數學物件出發**：function field / descent / 四元數環 / 代數消去 — 四個不相關的領域。
4. **要求創造性新角度**：sub-agent 必須**自行發明**處理 PCP 的工具，不能直接套用已知 conditional 框架。

## 四條新路線

### N1：函數場類比 + Mahler-style lifting

**核心思路**：考慮函數場版本 PCP$_K$ over $K = \mathbb{F}_p(t)$ 或 $K = \mathbb{C}(t)$：
$$
\exists\, a, b, c \in K^*: \quad a^2+b^2, b^2+c^2, a^2+c^2, a^2+b^2+c^2 \in K^{*2}.
$$
- 函數場上之 effective Mordell-Lang/Manin's theorem of kernel 為**已證**定理（無 conjectural assumption）— Voloch、Buium、Hrushovski 之工作。
- 若 PCP$_{\mathbb{C}(t)}$ 之非常數解可分類為**有限多 family**（已證），則 PCP$_\mathbb{Z}$ 可透過 specialization / Mahler-Lech / Skolem-Mahler-Lech 推回有限多 candidate $(a, b, c) \in \mathbb{Z}^3$，再逐一檢驗。
- 這條路線**避開** Bombieri-Lang，因 function-field 版本完全無條件。

**預期攻擊深度**：若成功，**無條件**結論。若失敗，卡點為「function-field 版本之具體有限性是否成立」之精確問題。

### N2：Vieta jumping / 顯式 Fermat descent

**核心思路**：對 PCP 系統 $\mathcal{S}$ 之七元組 $(a,b,c,d,e,f,g)$，尋找 involution
$$
\sigma : (a,b,c,d,e,f,g) \mapsto (a', b', c', d', e', f', g')
$$
使得：
- $\sigma$ 之 image 仍滿足 $\mathcal{S}$（保結構）；
- 某 height function $H(\cdot)$ 嚴格遞減：$H(\sigma(P)) < H(P)$，**除非** $P$ 為退化點。

若能構造此 $\sigma$，則 PCP 解之最小高度反例下無更小解，矛盾，故無解（Fermat 風格）。

**參考類比**：
- Markov triples $x^2+y^2+z^2 = 3xyz$ 之 Vieta jumping
- Apollonian circle packings 之 Vieta involution
- Hurwitz' 方程 $x^2+y^2+z^2 = nxyz$ 之 descent

**關鍵之處**：PCP 有 7 個變量 + 4 個方程式，Vieta involution 可作用於四個 Pythagorean triple 之每一個（每個 triple 給一個 $\mathbb{Z}/2$ 作用 in $(x, y, z) \to (x, y, ?)$ where $? = $ 另一解）。

**預期攻擊深度**：若 height 真的單調，得無條件無解。卡點在「找對 height function 使 monotone」。

### N3：四元數 / Hurwitz 整數環 + norm form

**核心思路**：考慮 Hamilton 四元數 $\mathbb{H} = \mathbb{R} \oplus \mathbb{R}i \oplus \mathbb{R}j \oplus \mathbb{R}k$，及其 Hurwitz integer ring $\mathfrak{O} = \mathbb{Z}[i, j, k, (1+i+j+k)/2]$，此為左/右 Euclidean ring（具 norm-Euclidean 性質）。

對任意 $q = w + ai + bj + ck \in \mathbb{H}$，
$$N(q) = w^2 + a^2 + b^2 + c^2.$$

考慮 quaternion $q_g = g + ai + bj + ck$（將 PCP 之 $g, a, b, c$ 看成四元數 component）。則 $N(q_g) = g^2 + a^2+b^2+c^2 = g^2 + g^2 = 2g^2$（用 $a^2+b^2+c^2 = g^2$）。

更巧妙：用 $q = a + bi + cj + 0k$（純虛部 + 一實 component）— 但純虛 norm 即 $a^2+b^2+c^2$。考慮 $q' = ai + bj + ck \in \mathbb{H}$ 純虛部，$N(q') = a^2+b^2+c^2 = g^2$。故 $q'$ 之 norm 為 $\mathbb{Z}$ 中之完全平方。

在 Hurwitz 環 $\mathfrak{O}$ 中，norm $= g^2$ 之元素之 factorization 由 norm $= g$ 之元素之 ideal-theoretic 結構控制。聯合 face conditions $a^2+b^2 = d^2$ 等對應 sub-norm structures。

利用 $\mathfrak{O}$ 之 left/right ideal **non-commutative UFD** 結構，分析 PCP 解必須滿足的 ideal factorization condition，嘗試導致矛盾。

**新角度**：$\mathbb{Z}[i]$（Gauss）已被 R3 用過（face I 為 $\mathbb{Z}[i]$ norm），但 $\mathfrak{O}$（4 維 non-commutative）視角為**全新**。

**預期攻擊深度**：若 $\mathfrak{O}$ 中之 ideal structure 給出矛盾，無條件無解。卡點在「translating PCP into $\mathfrak{O}$-ideal language」。

### N4：超定系統之代數消去（Resultant / Gröbner）

**核心思路**：PCP 系統 $\mathcal{S}$ 為 4 方程式 in 7 變量，但加上「四個額外隱含的 Pythagorean triple」（$Q_4 - Q_i$ 之恆等式給 $(c, d, g), (a, e, g), (b, f, g)$ 為 Pythagorean — 由 R2 之 §4.3 發現）。

故實際 PCP 為 **7 個** Pythagorean triple 之 system：
- $(a, b, d), (b, c, e), (a, c, f), (c, d, g), (a, e, g), (b, f, g)$
- 加上隱含 $(d, e, f)$ 之某 relation（$d^2 + e^2 + f^2 = 2g^2$ 由 §1.1B）

7 個 Pythagorean triple 之顯式參數化（每個 by $(m_i, n_i)$）給 14 個參數，但只有 7 個基本變量，故 over-determined by 7 條 constraint。

**具體計畫**：對每個 Pythagorean triple 寫 $(x, y, z) = (m^2 - n^2, 2mn, m^2+n^2)$ 之變形，得 $a, b, c$ 各為 multiple polynomial identities。用 resultant 或 Gröbner basis 消去 $m_i, n_i$，得到關於 $a, b, c$ 之**單一**多項式約束 $F(a, b, c) = 0$。

若 $F$ 為非平凡，則 PCP 解 $\subseteq V(F) \cap \mathbb{Z}^3$。若 $V(F)$ 為**有限多 component**（如 finite union of curves），且 PCP solutions correspond to integer points on these components，問題大幅化約。

**新角度**：不走 elliptic curve（避 R3 路徑），不走 geometric Picard rank（避 R1），直接代數消去。

**預期攻擊深度**：若 $F$ 為非平凡（甚至為 single equation 之 surface in $\mathbb{A}^3$），直接分析 $V(F)$ 之整數點性質。可能反證之無條件結論可得。卡點在「resultant 算大」或「$F$ 退化為 0」。

## Sub-agent 共通約束

所有 N1-N4 sub-agent 之 prompt 將包含：

1. **禁止 conditional fallback**：不允許以 "conditional on X conjecture" 結尾；若卡住，明示精確 mathematical statement of obstruction（不模糊地說「needs Bombieri-Lang」）。
2. **無條件嘗試**：每條都認真嘗試 close PCP，不假設失敗。
3. **創造性要求**：sub-agent 應自行構造新工具，不直接套用已知 conditional 框架。
4. **充分展開**：每條至少 3000 字嚴謹數學論證。

## 模型選擇

四條 routes 全用 `model: opus`（最大推理深度，因要 push 真實邊界）。

## 互補性說明

四條路線之數學物件來自四個 disjoint 領域：

| 路線 | 數學物件 | 工具 |
|------|---------|------|
| N1 | $\mathbb{F}_p[t]$ 上 PCP | function-field Mordell-Lang (Voloch/Buium) |
| N2 | $\mathbb{Z}$ 上 PCP | Vieta involution + height descent |
| N3 | Hurwitz 環 $\mathfrak{O}$ | non-commutative ideal theory |
| N4 | $\mathbb{Z}[m_i, n_i]$ 多項式環 | resultant elimination |

若任一條成功，PCP 無條件 close。若全失敗，每條之**精確卡點**會 collectively 描繪「為何 PCP 抗拒已知方法」之全景圖。

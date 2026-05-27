# Phase 3a: Routes Design (Ex-ante)

## 設計總覽

對 Perfect Cuboid Problem 設計 **3 條互補路線**，型態為**結構互補**（structural complementarity）：每條覆蓋問題不同子面向，無從擇一。

| 路線 | 子問題 | 互補性貢獻 |
|------|--------|-----------|
| R1：算術幾何（Variety Geometry） | $V$ 之全域結構 | 提供「為何難」之內在解釋 |
| R2：Local-global / 模算術障礙 | 必要條件深度挖掘 | 提供無條件 partial necessary conditions |
| R3：參數化 + descent | 從已知 Euler bricks 出發試構造 / 反證 | 提供可計算的攻擊面 |

三路非冗餘：R1 給結構視角（最弱可達 obstacle 解釋），R2 給可驗證的必要條件，R3 給降至更小 Diophantine 系統的攻擊面。

## R1：算術幾何 — Variety Geometry

**核心思路**：將 $V \subset \mathbb{P}^6$ 視為 4 個齊次二次方程式之完備交（complete intersection 或退化），分析其：

- 維度與奇異性
- Smooth projective model 之 Kodaira dimension
- $V$ 之 Picard 群與 Jacobian
- 若 $V$ 含 dominant family of elliptic curves，分析 fibration
- Brauer-Manin obstruction（若 local-global 全可解）

**預期攻擊深度**：給出條件性結果（依賴 Bombieri-Lang 或 ABC）；無條件下不能封閉，但能給出「為何問題難」的內在數學解釋。

**失敗模式**：
- 若 $V$ 之 Kodaira dimension $\leq 1$（如 K3 或 elliptic surface），則 Bombieri-Lang 不適用，更難得有限性
- Brauer-Manin obstruction 可能消失（已知 local 全可解）

**Sub-agent 任務**：精確計算 $V$ 之幾何不變量；給出條件性的 PCP 無解結論；明示「條件於何」。

## R2：Local-global / 模算術障礙

**核心思路**：

- 在每個 $\mathbb{Q}_p$ 中分析 $V$ 之有理點，導出深度 mod $p^k$ 必要條件
- 對 $p = 2$（最重要，因二次型在 2-adic 最敏感）做 mod $2^k$ 完整分析至高 $k$（如 $k = 8$ 或更高）
- 對小奇素數 $p = 3, 5, 7, 11, 13$ 類似分析
- 嘗試從多素數聯合資訊（不是 Hasse 障礙，而是 fine-grained 必要條件）導出無解，或證明聯合條件相容
- 與 quadratic reciprocity / Brauer-Manin 對應

**預期攻擊深度**：產出無條件的必要條件集合（如：恰一邊被 16 整除、另兩邊滿足某 mod 7 條件）；不太可能直接證無解（因為已知 local 全可解，Hasse 障礙不存在）。

**失敗模式**：
- Local 全可解 → 純局部障礙無法 close
- 必要條件雖深但不矛盾 → 仍可有解
- Brauer 群可能 trivial（無 Brauer-Manin 障礙）

**Sub-agent 任務**：建立至少 mod $2^7$ 與 mod $p$ 對小奇 $p$ 之完整必要條件列；判斷 Brauer-Manin obstruction 是否存在。

## R3：參數化 + descent

**核心思路**：

- 採用 Saunderson 參數化或更新的 Euler brick 完整參數化
- 將「space diagonal $g$ 整數」條件翻譯為參數空間中的子方程式 $\Phi(u, v, \ldots) = \square$
- 對 $\Phi = \square$ 嘗試 Fermat-style 無窮下降
- 若參數化不 surjective，補充未覆蓋之 Euler brick 族
- 或：採用更新的「complete」rational parametrization（如 Sastry 1955，Bremner 之 elliptic curve 視角）

**預期攻擊深度**：可能將問題化約為較小 Diophantine 方程式（如 elliptic curve 上特定點之有理性問題）；最佳情形可給出條件性無解（如：條件於某 elliptic curve 之 rank = 0）。

**失敗模式**：
- 參數化不夠 surjective，論證僅覆蓋部分 Euler bricks
- 化約後方程式仍為 surface of general type 或高 genus curve，無 effective Mordell
- Descent 在 $\Phi = \square$ 上之 height 不單調

**Sub-agent 任務**：明示採用之參數化、其 surjectivity 範圍、化約後之方程式型態、可達結論。

## 互補性論證

- R1 處理「為何難」（結構解釋）— 無條件下不結束問題，但解釋無條件路徑為何難找
- R2 處理「必要條件」（直接限制解空間）— 純無條件結果，但不足以 close
- R3 處理「具體攻擊面」（化約至更小問題）— 可給出在某 sub-family 內之結論

三者組合是合理的全景圖：若三條都未能 close，則：
- 沒有局部障礙（R2 confirms local-global compatibility）
- 變體幾何提示問題深層困難（R1 explains why）
- 已知參數化下無 effective attack（R3 demonstrates）

→ 障礙報告之三大支柱完備。

## 模型選擇

三條路線皆使用 `opus`（批判性數學論證需高推理品質）。

## Sub-agent prompt 模板

每條路線將收到：
- 攻擊規約全文（`attack-spec.md`）
- 形式化全文（`formalization.md`）
- 路線專屬指示
- 偏離規則：若需偏離 Phase 2 形式化，必須在輸出開頭明示
- 輸出格式：論證主體 + 卡點清單 + 自評（0-10 量化）

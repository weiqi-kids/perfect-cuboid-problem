# Decisions Log: perfect-cuboid-problem

## Phase 1 — 初始化
- timestamp: 2026-05-13T00:20:00+08:00
- 問題輸入（原文）：「是否存在一個長方體，使：三條邊長皆整數；三個面對角線皆整數；空間對角線也為整數？」
- slug 選擇：`perfect-cuboid-problem`。理由：此問題之國際標準名為 "Perfect Cuboid Problem"（亦稱 perfect Euler brick），kebab-case 翻譯直接對應。
- previous_version: null
- 模式：**非互動**。依據：
  1. 用戶以 `/clear` 後直接 `/deep-proof` slash command 形式提交完整問題（無自然對話脈絡）
  2. System reminder 明示「user has asked you to work without stopping for clarifying questions」
  3. 用戶一次性給足問題描述

## Phase 1 — 攻擊規約摘要
- timestamp: 2026-05-13T00:20:00+08:00
- 領域分類：**數論 / 算術幾何 / Diophantine equations**
- 領域專屬規則摘要：見 `attack-spec.md` Block 3。要點：
  - 存在性聲稱必須附具體七元組
  - 不存在性聲稱必須採全域 / 局部 / 算術幾何之一
  - 必須說明 variety $V$ 的維度、奇異性、Kodaira dimension
  - 計算下界僅作輔助
  - 對 300 年歷史開問題誠實面對，若三路皆封閉不了 → 障礙報告而非偽裝
  - 條件層次明標（無條件 / ABC / Bombieri-Lang / GRH）

## Checkpoint 1
- timestamp: 2026-05-13T00:20:00+08:00
- 模式：**自動跳過**（非互動模式）
- 採用：Phase 1 產出之問題理解（即經典 perfect cuboid 形式化）

## Phase 2 — 形式化
- timestamp: 2026-05-13T00:21:00+08:00
- 重要設計選擇：
  - 邊長正整數 + 直角長方體（直接呼應用戶用語）
  - WLOG primitive ($\gcd(a,b,c)=1$)：化約 1+2 嚴格保持等價性
  - Parity 分析：必兩奇一偶
  - 代數簇視角 $V \subset \mathbb{P}^6$ 由 4 齊次二次方程式
- 細節見 `formalization.md`

## Phase 3 — 路線設計
- timestamp: 2026-05-13T00:22:00+08:00
- 設計 3 條路線，**結構互補**（無從擇一）：
  - R1：算術幾何（variety geometry, Kodaira dim, Brauer-Manin）
  - R2：Local-global / 模算術障礙（深度 mod $p^k$ 必要條件）
  - R3：參數化 + descent（Saunderson 或 Bremner-style）
- 細節見 `exploration/routes-design.md`

## Checkpoint 2
- timestamp: 2026-05-13T00:22:00+08:00
- 模式：**自動跳過**（結構互補 + 非互動模式雙重觸發）
- 三路皆組合進入 Phase 4

## Phase 4 — 整合（7 routes）
- timestamp: 2026-05-13T02:30:00+08:00
- 7 條路線（R1, R2, R3, N1, N2, N3, N4）全部完成
- 無條件結果：Chern data, Theorem N2-final, Theorem N4-Reformulation, Parity correction, Local solvability, Saunderson reduction
- 主結論未 close（既未證存在也未證不存在）→ status: obstacle-report

## Phase 5 — 審查迴圈
- Round 1 (fresh-eyes, opus sub-agent, agentId ad8a25b9fe733c488):
  - 3 blocking issues (B1: minimality, B2: complete intersection, B3: parity typo claim)
  - 4 nice-to-have, 3 optional
  - 修正記於 reviews/round-1-fixes.md
- Round 2 (sanity check):
  - All B1-B3 修正 verify pass
  - 額外檢查 (Theorem 5.1 bidirectional, Weil height O(1), Chern, Saunderson Δ) 全 verify
  - 0 blocking
  - 通過 → status: final

## Phase 6 — 最終盤點
- timestamp: 2026-05-13T03:45:00+08:00
- 最終狀態：**final**（obstacle-report 之 final framing）
- 開放問題：5 條 (proof.md §9)
- 殘留 nice-to-have / optional：4 + 3 條（保留為「已知可改進處」）
- pre-obstacle draft：N/A（本研究直接走 obstacle-report 路徑）

## Phase 7 — 用戶第二次介入（要求 wild creativity）
- timestamp: 2026-05-13T04:30:00+08:00
- 用戶指示：「不對啊，你又忘了『不給保守教科書答案、追求新穎且有創造力』的核心要求」
- 主 agent 反省：N1-N4 雖然 fresh angles，但每條都 hit named obstruction（Bombieri-Lang, Iitaka-Maehara, Bogomolov, Hurwitz UFD）。這 collapse 到「教科書 obstruction toolkit」。
- 新增 3 條 wild routes 之 hard約束：禁止使用任何 named obstruction（Bombieri-Lang, BSD, Hurwitz UFD, Brauer-Manin, Mordell-Lang, Iitaka-Maehara）作為論證 endpoint：
  - **W1**: Octonion / $\mathbb{O}$ / $E_8$ lattice / $G_2$ symmetry — 主 agent 先提供關鍵新觀察 $N(o) = (2g)^2$
  - **W2**: Weight-3/2 modular forms / Shimura / Hecke — 給出 $X^{1/2+\varepsilon}$ density bound + closure pathway to finite CAS computation
  - **W3**: Berggren tree dynamics / ergodic / topological entropy — 給出 $g \geq 1105$ unconditional lower bound + Berggren spectral 修正
- 三條皆 unconditional 新數學內容：
  - W2-Density: $\#\text{PCP}(X) \ll X^{1/2+\varepsilon}$
  - W3-LowerBound: $g \geq 1105$
  - W3-Spectral: $A, C$ unipotent (not hyperbolic) — 修正常見誤解
  - W1-Octonion: $N(o) = (2g)^2$ + 21 associator identities
- 整合進 proof.md 摘要之「10 條 fresh theorems」

## Phase 3 — 路線重設（用戶介入）
- timestamp: 2026-05-13T00:55:00+08:00
- 用戶指示：「不要有預設前提！我就是要找出不一樣的方法來證明他」
- 主 agent 反省：原三路（R1/R2/R3）皆隱含 conditional fallback（R1 → Bombieri-Lang、R3 → conditional rank、R2 已知無法 close），等同預設失敗。違反 attack-spec Block 5「不給保守教科書答案」。
- 補設四條**激進新路線**，**硬約束**：禁止以 conditional on conjecture 結尾，必須嘗試無條件結論：
  - **N1**：函數場類比 + Mahler lifting — 將 PCP 在 $\mathbb{F}_p[t]$ / $\mathbb{F}_p(t)$ 解決，用 function-field method 的有效 Mordell-Lang（已被 Voloch、Buium 等無條件證），再 lift 到 $\mathbb{Z}$
  - **N2**：Vieta jumping / Markov-style 顯式 descent — 直接對系統 $\mathcal{S}$ 之七元組做 height-decreasing involution，不經 elliptic curve，找 Fermat-style 無窮下降
  - **N3**：四元數 / Hurwitz 整數環之 norm form structure — 將 $a^2+b^2+c^2 = g^2$ 視為 $\mathbb{H}$ 之 norm equation，利用 non-commutative UFD 結構找代數矛盾
  - **N4**：超定系統之代數消去 — 7 個 Pythagorean triple 為 over-determined，視為 $\mathbb{P}^6$ 中之多個共線 conic family，用 resultant / Gröbner / Lüroth 消去 derive 單一 univariate constraint，分析其根結構
- 互補性：四路線從**完全不同數學物件**出發（function field、descent、四元數環、代數消去），無互相 fallback。每條都被指示「若卡住要明示卡點，不允許 conditional rephrase」。
- 細節見 `exploration/routes-design-v2.md`

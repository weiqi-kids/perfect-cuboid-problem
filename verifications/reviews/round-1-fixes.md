# Round 1 Fixes

## Issue B1 (blocking): Theorem 3.2 minimality 未驗證

**修正方式**：補一段 minimality 驗證於 Theorem 3.2 後。論證：
- $A_1$-blowup 之 exceptional curve 為 $(-2)$-curve，不是 $(-1)$-curve
- 非 exceptional curve $E$：$K_{\tilde V} \cdot E = \pi^* H \cdot E = H \cdot \pi(E) > 0$（$H$ ample），故非 $(-1)$-curve
- 故 $\tilde V$ 不含 $(-1)$-curve，為 minimal model

**驗證**：修正後 Theorem 3.2 之 minimality claim 嚴格成立，Theorem 4.1 之 Iitaka-Maehara 應用合法。

## Issue B2 (blocking): Theorem 3.1 regular sequence 未驗證

**修正方式**：補 4-step 證明骨架於 Theorem 3.1 後：
1. 4 quadrics 線性獨立（不同 leading monomial）
2. 顯式 smooth point $P_2 = (1:1:1:\sqrt 2:\sqrt 2:\sqrt 2:\sqrt 3)$，Jacobian rank 4
3. 無 3 維 component（用 $Q_4 = Q_1 + c^2$ 非平凡）
4. 奇異點限於 finite $A_1$ set

**驗證**：修正後 complete intersection claim 有 explicit witness + 維度上界 + 奇異性分類。

## Issue B3 (blocking): §2.3 "textbook typo" 聲稱過強

**修正方式**：更改 §2.3 末註，明示「修正本研究 internal formalization.md 之 typo」，並承認 Guy 等主流文獻已正確記載。

**驗證**：避免對外部文獻之誇大批評，措辭中性化。

## Nice-to-have / Optional 處理

決定**不**修：

- N1-N4, O1-O3 為補強建議。考慮 obstacle report 之 framing 已誠實標示 limitations，不需進一步雕琢。**保留理由**：N1 之 bidirectional equivalence 細節已在 N4 sub-agent 之 polished 中；O1-O3 為 stylistic refinement，不影響 unconditional claims 之正確性。

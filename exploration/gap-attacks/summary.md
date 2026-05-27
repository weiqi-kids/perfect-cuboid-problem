# Gap Attacks Summary

## 結構說明

由於本研究 Phase 4 採取「7 條完全不同 attack routes」之策略而非「single proof skeleton + gap」之 structure，傳統意義下之「gap attacks」並未出現。每條 route 之 sub-agent 已自行處理其內部 sub-obstructions。

各 route 之**主要 obstruction** 已在 `proof.md` §8 「unified obstruction」段整合。

## 全 route 索引

| ID | Route | Polished 檔 | 主要 unconditional 結果 | 主要 obstruction |
|----|-------|------------|----------------------|----------------|
| R1 | Arithmetic geometry | route-N1-function-field.md (含 R1 Chern data) | $V$ 之 geometry, Chern classes | Bombieri-Lang conjectural |
| R2 | Local-global | (inline in proof.md §6.1) | Local solvability, modular conditions | 純局部不足 |
| R3 | Saunderson + descent | (inline in proof.md §7) | Sub-family ↔ elliptic curve $E$ | $E$ rank 計算未做 |
| N1 | Function field | route-N1-function-field.md | Chern data, fixed loci | Bogomolov $c_1^2 \leq c_2$ 失敗 |
| N2 | Vieta descent | route-N2-vieta-descent.md | **Theorem N2-final (unconditional)** | Bir(V) 有限 → no descent |
| N3 | Hurwitz quaternion | route-N3-hurwitz-quaternion.md | Parity correction confirm | Meta-commutation freedom |
| N4 | Algebraic elimination | route-N4-algebraic-elimination.md | **Theorem N4-Reformulation (unconditional)** | Trivial linear reduce |

## Trivial 自處理紀錄

- **Parity correction**: 原 formalization.md 之「兩奇一偶」改為「兩偶一奇」，由 N3+N4 cross-confirm，主 agent 已修正 formalization.md。
- **Theorem 5.1 collapse 之全四方程式 verify**: round-2 review 額外驗證四個 PCP 方程式皆 reduce 至同一 trig identity。

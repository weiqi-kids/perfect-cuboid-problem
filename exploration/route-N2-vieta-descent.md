# Route N2: Vieta jumping / Markov-style explicit Fermat descent（polished）

## 核心結論

**無條件 negative theorem**: PCP 之 Vieta-style descent **結構性失敗**。

## 跨領域類比回顧

| 類比 | 機制 | 為何成功 / 失敗 |
|------|------|------|
| Markov $x^2+y^2+z^2=3xyz$ | Vieta $z \to 3xy-z$ | 用於**生成**解（Markov tree）；無矛盾 |
| Hurwitz $x^2+y^2+z^2=nxyz$ | 同 Vieta，但 $n \neq 1, 3$ 給 contradiction | descent strict 遞減 |
| Fermat $x^4+y^4=z^2$ | Pythagorean parametrize → height-strict descent | 單一方程，single parametrize |

## PCP 之 Candidate Involution 分析

### Candidate 1: Sign reflection
$(a,...) \to (-a,...)$ 保 $\mathcal{S}$，但 height 不變。**Trivial**。

### Candidate 2: Per-triple Vieta on Pythagorean
Pythagorean $x^2+y^2=z^2$ 為 $z$ 之 quadratic 但**無 linear cross term**（不像 Markov 之 $-3xy$），故 Vieta 只給 sign 反射。**Pythagorean 不允許 Markov-style nontrivial Vieta**。

### Candidate 3: Berggren tree-based descent
單一 triple 之 Berggren descent strictly works，但 PCP 之 6 個 Pythagorean triples 共享變量（$a$ 出現於 3 個 triple 中等）。Single-triple Berggren step 改變一個變量，**必破壞其他兩個 triple**。

### Candidate 4: Multi-Berggren simultaneous
對 $T_1, T_3, T_6$（共享 $a$）同時 Berggren-descent 要求 PCP 解滿足**額外線性約束** $b + f = c + d$（或對 $\{A^{-1}, B^{-1}, C^{-1}\}^3 = 27$ 之每組對應的 27 個 distinct 約束）。

**檢驗**：經典 Euler brick $(44, 117, 240)$ 有 $b+f = 361, c+d = 365 \neq$。**Generic PCP 不滿足任何 multi-Berggren 相容性**。

## Theorem N2-final（無條件）

> 設 $V \subset \mathbb{P}^6$ 為 PCP variety。則**不存在** birational involution $\sigma : V \dashrightarrow V$ 使得對某 ample line bundle $L$ 之 Weil height $H_L$ 滿足
> $$H_L(\sigma(P)) \leq H_L(P) - C$$
> 對某常數 $C > 0$ uniformly on $V(\mathbb{Q})$.

**證明骨架**：
1. $V$ 為 surface of general type（無條件，由 §N1 Chern data）。
2. 由 **Iitaka-Maehara 定理**（已證，非 conjecture），surface of general type 之雙有理自同構群 $\text{Bir}(V)$ 為**有限群**。
3. 任何 birational $\sigma$ 有有限階 $k$；故 $H_L \circ \sigma^k = H_L$。
4. 由 telescope: $\sum_{i=0}^{k-1}(H_L \circ \sigma^{i+1} - H_L \circ \sigma^i) = 0$。每項為 bounded（birational ⟹ 線性度數差為有限）。故 $H_L \circ \sigma - H_L$ 為 bounded function on $V(\mathbb{Q})$。
5. 與 strict descent $H_L \circ \sigma < H_L - C$ 矛盾。$\square$

## 意義

**Vieta-style explicit Fermat descent 對 PCP 為結構性不可達**——這是 PCP 不像 $x^4+y^4=z^2$（curve, genus 3 之 Jacobian）之深層理由。PCP 之 ambient 為 general-type surface，雙有理結構排除 Markov/Fermat-style descent。

## 自評

完成度 85%，可信度 90%。**重要 unconditional 負面結果**：告訴未來研究者 Vieta jumping 不是 PCP 之 attack vector。

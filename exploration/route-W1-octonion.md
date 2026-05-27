# Wild Route W1: Octonion / $E_8$ / Spin(7) (polished)

## 新 unconditional 結果

1. **Octonion encoding identity**: PCP 解 → 純虛 octonion $o = ae_1+\cdots+ge_7$ with
   $$N(o) = a^2+b^2+c^2+d^2+e^2+f^2+g^2 = (2g)^2$$
   即 $o$ 為 $E_8$ lattice 中 length-$2g$ 之 vector。

2. **21 個 associator norm identities**:
   - $N([o, e_1, e_2]) = N([o, e_1, e_3]) = N([o, e_2, e_3]) = 12 g^2$
   - $N([o, e_4, e_7]) = 8 g^2$
   - 其餘 17 個 quartet sums 之 explicit formulas

3. **PCP 之 Pythagorean star reformulation**:
   - 三個 Pythagorean triple $(a, e, g), (b, f, g), (c, d, g)$ 共享 hypotenuse $g$
   - 等價於 $a^2 = g^2 - e^2$ 等

4. **Diagonal quadric**: $(d, e, f, g)$ 落於 $\mathbb{P}^3$ 中 smooth rational quadric $Q: d^2 + e^2 + f^2 = 2g^2$

5. **重新確認** $V$ 之 invariants: $K^2 = 16, c_2 = 80, \chi(\mathcal{O}) = 8, p_g = 7, q = 0$（與 R1, N1 一致）

## 為何 octonion 角度 forced（非 ad-hoc）

PCP 之 7 個 integer 變量恰填滿 $\text{Im}(\mathbb{O})$ 之 7 維。**任何 quaternion subalgebra 對應 Fano line（3 維），不能容納 PCP 全部 7 變量**。故 octonion 為**最小**自然 algebraic embedding，非 ad-hoc。

## 卡點

- $G_2$ symmetry on $W \subset S^6$ 之 stabilizer 為 finite，但 $G_2(\mathbb{Q})$ 不保 $W$
- Octonion non-associativity 之 alternative law $o(oy) = (oo)y$ 給 $-4g^2 y$（trivial，無新 info）
- $E_8$ lattice 之 norm-$4g^2$ vector 數為 $240 \sigma_3(2g^2)$（Eisenstein），但 PCP 之 codim-4 sub-locus 為 well-defined surface（同 R1 結論）

## 自評

完成度 70%，可信度 85%。提供 PCP 之**最自然代數封裝**並產生 unconditional structural data，但 octonion 結構 alone 不 close PCP。

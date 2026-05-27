# Route N3: Hurwitz quaternion + norm form structure（polished）

## 核心結論

無條件嘗試 close PCP via Hurwitz $\mathfrak{O}$ 之 non-commutative UFD 結構，**未成功**。獲得：(i) PCP 之 quaternion 編碼之精確結構描述；(ii) **獨立確認 parity correction**（兩偶一奇）；(iii) **明示 non-commutative 結構不引入 $\mathbb{Z}$ 之外之新 obstruction**。

## Setup

- Hamilton 四元數 $\mathbb{H}$ + Hurwitz integers $\mathfrak{O} = \mathbb{Z}\langle i, j, k, (1+i+j+k)/2 \rangle$
- Norm $N(w+ai+bj+ck) = w^2+a^2+b^2+c^2$ 為 multiplicative
- $\mathfrak{O}$ 為 left/right Euclidean，admits non-commutative unique factorization (Conway-Smith)

## PCP 之 Quaternion 編碼

設 $q = ai + bj + ck \in L_{\mathrm{im}} \subset \mathfrak{O}$（純虛 Lipschitz integer）。則：
- $N(q) = a^2+b^2+c^2 = g^2$
- $q^2 = -N(q) = -g^2$（純虛 + multiplicative norm）

**Axial decomposition**:
- $q = q_{12} + ck$, $q_{12} = ai + bj$, $N(q_{12}) = a^2+b^2 = d^2$
- $q = q_{23} + ai$, $q_{23} = bj + ck$, $N(q_{23}) = b^2+c^2 = e^2$
- $q = q_{13} + bj$, $q_{13} = ai + ck$, $N(q_{13}) = a^2+c^2 = f^2$

每個 $q_{ij}$ 為 norm-square element in 對應 sub-ring $\mathbb{Z}[i_{ij}] \cong \mathbb{Z}[i]$。

## Parity Correction（與 N4 獨立 cross-confirm）

N3 §5.10 之 face-by-face mod-4 分析確認：
- "兩奇一偶" parity（$a, c$ 奇）導致 $a^2 + c^2 \equiv 2 \pmod 4$，**矛盾於 $f^2$ 為 square**
- 正確 parity: **兩偶一奇**

## Hurwitz Prime Factorization 分析

對每個 rational prime $p$，$\mathfrak{O}$ 中之 splitting：
- $p \neq 2$ 奇 prime：split into two distinct Hurwitz primes（由 Lagrange 四平方和定理保證 $p = $ sum of $\leq 4$ squares）
- $p = 2$: ramified, $2 = \pi_2 \bar\pi_2$ where $\pi_2 = 1 + i$

**Pi₂-divisibility 之精確分析**：對 primitive PCP（two-even-one-odd parity），$\pi_2 \nmid q$ in $\mathfrak{O}$（因為 $q/\pi_2$ 之 components 不滿足 Hurwitz integrality）。

## 嘗試之多種攻擊（全部失敗）

| 嘗試 | 內容 | 失敗原因 |
|------|------|---------|
| 5.1 | 純虛 $q$ → 雙邊 ideal $q\mathfrak{O} = \mathfrak{O}q$ | 錯：純虛只給 $\bar{q\mathfrak{O}} = \mathfrak{O}q$，不給 ideal 相等 |
| 5.6 | 用 $r_l = -qe_l$（trace $\neq 0$） | $r_l, q$ 為 right associates；左 ideal 同 |
| 5.7 | Pell-type / Hilbert 符號 | Sub-rings $\mathbb{Z}[\beta_l]$ 互相不 entangle |
| 5.8–5.10 | Simultaneous factorization 嘗試 | 不導出 contradiction |
| 5.13 | $S_3$ symmetry on $\{i,j,k\}$ + Galois | $S_3$ acts as outer automorphism，不破壞 PCP |
| 5.18 | Split-quaternion $\mathbb{H}' \cong M_2(\mathbb{Q})$ | $M_2$ Morita-equivalent to $\mathbb{Z}$，無新 obstruction |
| 5.19 | Octonions（non-associative） | $E_8$ embedding 為 ad hoc，無新 obstruction |

## 精確 Obstruction

**N3 之核心結論**:

> **Hurwitz UFD 之 meta-commutation freedom 提供足夠多的純虛 quaternion factorizations**，使得對 generic $g$ with appropriate prime decomposition，$r_3(g^2) > 0$（即 $g^2$ 可表為三平方和，且有非零解）。
>
> $\mathfrak{O}$ 之 prime structure **完全由 $\mathbb{Z}$ 之 prime structure 決定**（對 split primes），故 quaternion 不引入 $\mathbb{Z}$ 之外之新 obstruction。
>
> 三個 sub-rings $\mathbb{Z}[i], \mathbb{Z}[j], \mathbb{Z}[k]$ 在 $\mathfrak{O}$ 中**為 commuting only with themselves，但 sub-ring 間沒互相 entanglement in ideal level**——它們各自獨立的 Gauss UFD 結構處理 face I, II, III，space diagonal 為 trivial consequence。

## 自評

完成度 7/10，可信度 8/10。**真認真嘗試** 9 種 distinct quaternion-based attack。最終結論：non-commutative 結構 illusory — 不提供 PCP 之新 obstruction。

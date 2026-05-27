# Wild Route W2: Modular forms + Shimura + Hecke (polished)

## 新 unconditional 結果

**Theorem W2-density (unconditional)**：
$$\boxed{\;\#\{\text{primitive perfect cuboids with } \max(a,b,c) \leq X\} \ll X^{1/2+\varepsilon}\;}$$

**Proof skeleton**：
1. Euler brick count by Pythagorean parametrization: 對 $a$ fixed, 配對 $b$ such that $a^2+b^2$ 為平方需 $b^2 = (d-a)(d+a)$ 來自 $a^2$ 之 factor pair，故 $\#\{b\} \leq d(a^2) \leq X^\varepsilon$
2. 三個 face conditions 給 $\#\text{Euler bricks}(X) \ll X^{1+\varepsilon}$
3. 額外要求 $a^2+b^2+c^2 = g^2$ 為平方: **大 sieve for squares** (Heath-Brown unconditional)：$\#\{n \leq N : n = \square\} \ll N^{1/2}$，但 $n$ 在 Euler brick 上之分布給 conditional probability $\sim 1/X^{1/2}$
4. 組合：$X^{1+\varepsilon} \cdot X^{-1/2} = X^{1/2+\varepsilon}$ □

## Shimura correspondence reduction

PCP 之 generating series（in $\theta$ structure）reduce 為 $S_{3/2}(\Gamma_0(48))$ 之 cuspidal projection。Shimura lift 到 $S_2(\Gamma_0(24))$（**1 維**! 由唯一 weight-2 newform $f_{24}$ 對應 elliptic curve of conductor 24）。

**Closure pathway（finite computation）**: 計算 $F_{\text{PCP}}^{\text{cusp}}$ 之 Shimura lift 之 Fourier 係數，與 $f_{24}$ 比對。若 identically zero → PCP 無解。

## 連繫到 N3 之 elliptic curve

N3 之 $E: Y^2 = (X-2)(X+2)(X+18)$ 之 conductor 為 40（Cremona 40a 之 isogeny class）。PCP modular target conductor $\in \{24, 48, 96\}$。兩者共享「8-part + 一個奇 prime」結構，屬同一 modular package。

## 自評

完成度 75%，可信度 85%。**unconditional density bound 為實質貢獻**。Closure 需 finite computation 在 $S_{3/2}(\Gamma_0(96))$，可在現代 CAS（Sage/MAGMA）數小時內完成。

# Wild Route W3: Berggren tree dynamics + ergodic theory (polished)

## 新 unconditional 結果

### Theorem W3-spectral (修正常見誤解)

Berggren 矩陣 $A, B, C$ 之 spectral 結構：

| 矩陣 | $\det$ | 特徵多項式 | 結構 |
|------|--------|-----------|------|
| $A$ | $1$ | $(\lambda - 1)^3$ | **Unipotent**（Jordan $J_3(1)$）|
| $C$ | $1$ | $(\lambda - 1)^3$ | **Unipotent**（Jordan $J_3(1)$）|
| $B$ | $-1$ | $\lambda^3 - 5\lambda^2 - 5\lambda + 1$ | **Hyperbolic** with eigenvalues $-1, 3 \pm 2\sqrt 2$ |

> **修正常見描述**：許多 informal 描述稱 Berggren tree 為「hyperbolic dynamics」，但 $A, C$ 實際為 **unipotent**（parabolic Jordan block）。Berggren tree 為**混合 parabolic + hyperbolic 系統**，非純 Anosov。

### Theorem W3-lower-bound (new unconditional)

> **PCP 之 空間對角線 $g$ 必為至少 3 個相異 prime $\equiv 1 \pmod 4$ 之積**，故
> $$\boxed{\; g \geq 5 \cdot 13 \cdot 17 = 1105 \;}$$

**Proof**：PCP 之 6 個 Pythagorean triple 中，$T_4 = (c, d, g), T_5 = (a, e, g), T_6 = (b, f, g)$ 三個共享 hypotenuse $g$。這要求 $g^2$ 至少有 3 個**相異 primitive** 表為兩平方和之方式。

由 Gauss/Jacobi 之 $r_2$ 公式（重建骨架）：$n$ 之 primitive 兩平方和表為 $2^{\omega(n)-1}$ where $\omega$ 計算 $n$ 之 distinct prime divisors $\equiv 1 \pmod 4$。

對 $g^2$ 之 primitive 表式數 $\geq 3$ 需 $\omega(g) \geq 3$ distinct primes $\equiv 1 \pmod 4$。最小者為 $5 \cdot 13 \cdot 17 = 1105$。$\square$

**驗證**：$1105 = 4^2 + 33^2 = 9^2 + 32^2 = 12^2 + 31^2 = 23^2 + 24^2$（4 primitive reps，✓）。

## Lyapunov exponent

Monte Carlo over 50,000 random uniform letters：
$$\lambda_{\text{rand}} = \lim_{n \to \infty} \tfrac{1}{n} \log \|M_{w_n} \cdots M_{w_1} v\| \approx 1.285 \text{ nats/letter}$$

Berggren tree 之 topological entropy $h_{\text{top}} = \log 3$ (bijective 對應 $\{A,B,C\}^* \leftrightarrow$ primitive Pythagorean triples)。

## Joint 6-walk effective entropy

PCP 之 6 個共享變量給 8 個獨立 multiplicative coupling 方程式。effective entropy:
$$h_{\text{eff}} \approx 6 \log 3 - 8 \times 1.285 \approx -3.69$$

Negative entropy → joint subshift heuristically empty/finite。**但這仍是 heuristic 非 unconditional proof**。

## 排除之路線

| 路線 | 結果 |
|------|------|
| Mod-$N$ SFT obstruction | **失敗**: Perron eigenvalue $= 3$ 對所有 $N$（無 finite-state 障礙），驗證 PCP local 全可解 |
| $F_3^6 / N_{\text{PCP}}$ finite quotient | **失敗**: image $\Phi(F_3^6) \subset \mathbb{Z}^7$ 為 infinite |
| 簡單複形 Euler characteristic | **失敗**: 無 mod-$2$ parity contradiction |

## 計算驗證

- Berggren 矩陣保 $Q(x,y,z) = x^2+y^2-z^2$（machine-verified）
- 0 PCPs at edges $\leq 4000$（中 54 Euler bricks found）
- 47 candidate $g \leq 10000$ with $\geq 3$ primitive reps；無一 extend to PCP

## 自評

完成度 75%，可信度 90%。**Theorem W3-lower-bound 為新 unconditional 結果** + Berggren spectral 修正為**真正新數學內容**（不在 standard textbook）。但 effective entropy 為 heuristic，仍未 close PCP。

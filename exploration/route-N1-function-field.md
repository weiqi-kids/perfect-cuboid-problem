# Route N1: 函數場類比 + Mahler lifting（polished）

## 核心結論

無條件嘗試 close PCP，**未成功**，但獲得多項 unconditional 結構結果。

## Unconditional 結果

1. **Chern class 計算**：對 $V$ 之 smooth (2,2,2,2) complete intersection model：
   - $c(T_V) = (1+H)^7 / (1+2H)^4 \pmod{H^3} = 1 - H + 5 H^2$
   - $c_1(T_V) = -H$ ⟹ $K_V = H$（ample，故 surface of general type）
   - $K_V^2 = H^2 \cdot [V] = 16$
   - $c_2(V) = 5 H^2 = 80$
   - $\chi(\mathcal{O}_V) = (K^2 + c_2)/12 = 8$（Noether's formula）

2. **Polynomial ansatz 完整窮舉**：
   - Ansatz 0–6（常數、線性、二次、三變量同次）全部 trivial 或退化
   - 證明：低度 polynomial $\mathbb{C}[t]$ 解只能對應 constant rational point

3. **Fixed loci 顯式分類**：
   - $\sigma_{ab}$（$a \leftrightarrow b$）之 fixed locus：elliptic curve $C^{(ab)}: Y^2 = w^4 - 6w^2 + 1$，genus 1
   - 對稱地 $\sigma_{bc}, \sigma_{ac}$ 各給 elliptic curve（皆為常數 elliptic curve over $\mathbb{C}$）
   - $C^{(ab)}(\mathbb{C}(t)) = C^{(ab)}(\mathbb{C})$（無非常數 $\mathbb{C}(t)$-點，由 Manin-Grauert）
   - 對角 $a = b = c$ 為 $V$ 上**唯一 obvious** rational curve，但對應之 $\mathbb{C}(t)$-points 全為常數 $[1:1:1:\sqrt 2:\sqrt 2:\sqrt 2:\sqrt 3]$

## 精確 Obstruction

**N1 obstruction**：

> 對 surface $V$，**Bogomolov 1977 之定理要求 $c_1^2 > c_2$**（即 $K_V^2 > c_2$）才能無條件保證「rational/elliptic curves 為有限集」。我們有 $K^2 = 16$ 與 $c_2 = 80$，$\boxed{16 < 80}$，**Bogomolov 不適用**。
>
> 換言之：證明 $V$ 上沒有 fixed-loci 之外的 rational curves 為 **open mathematical question**，對應 specific surface 之 Lang property — 不是 Bombieri-Lang conjecture（後者更 general），而是這特定 surface 之 effective bound。

**第二 obstruction**：**函數場無解 不可逆 推回 $\mathbb{Z}$ 無解**：
- $\mathbb{C}(t)$ 為 $C_1$-field (Tsen)，$\mathbb{Q}$ 不是
- specialization Hilbert irreducibility-style 只 one-way works
- Mahler-Lech 不適用（針對 linear recurrence 而非 algebraic variety）

## 自評

完成度 6/10，可信度 8/10。**真認真嘗試**，無 conditional fallback。Bogomolov 失敗為 unconditional 之精確 obstruction（不是「conditional on conjecture」式說辭）。

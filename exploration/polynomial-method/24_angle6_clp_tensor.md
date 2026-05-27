# Angle 6: CLP slice-rank on the PCP constraint tensor — full analysis

## The construction

Define the tensor $T: \mathbb F_p^p \otimes \mathbb F_p^p \otimes \mathbb F_p^p \to \mathbb F_p$ by
$$T_{a, b, c} = \mathbb 1[(a, b, c) \in A_p]$$
where $A_p = \{(a, b, c) : a^2+b^2, b^2+c^2, a^2+c^2, a^2+b^2+c^2 \text{ all squares in } \mathbb F_p\}$.

This is a $\{0, 1\}$-valued 3-tensor of shape $p \times p \times p$.

## Flattening rank

We computed:
$$\boxed{\text{rank}(\text{flatten}_a T) = \text{rank}(\text{flatten}_b T) = \text{rank}(\text{flatten}_c T) = \frac{p+1}{2}}$$
for all primes $p \in \{3, 5, 7, 11, 13, 17, 19\}$ tested.

### Why the rank is exactly $(p+1)/2$

**Upper bound**: The condition $(a, b, c) \in A_p$ depends only on $(a^2, b^2, c^2)$. Hence $T_{a, b, c} = T_{-a, b, c} = T_{a, -b, c} = T_{a, b, -c}$. The map $a \mapsto a^2$ on $\mathbb F_p$ has $(p+1)/2$ distinct values $\{0, 1^2, 2^2, \ldots, ((p-1)/2)^2\}$. So the rows of the flattening (indexed by $a \in \mathbb F_p$) take at most $(p+1)/2$ distinct values, giving rank $\leq (p+1)/2$.

**Lower bound (numerical)**: We verified the matrix rank is exactly $(p+1)/2$. So the distinct rows are linearly independent.

### Slice-rank bound

Slice-rank satisfies $\text{sr}(T) \leq \min_{\text{axis}} \text{rank}(\text{flatten}_{\text{axis}} T) = (p+1)/2$.

So $\text{sr}(T) \leq (p+1)/2$.

## What this gives us

### Tao's slice-rank theorem (recap)

**Theorem (Tao 2016).** Let $V$ be a finite-dim vector space over a field $k$, and let $T: V^{\otimes 3} \to k$ be a tensor. Suppose $T = \sum_{i=1}^r T_i$ where each $T_i$ factors as $T_i = u_i \otimes M_i$ for some axis (i.e., $T_i$ is rank-1 along at least one axis). Then $r$ is the slice-rank.

**Corollary (diagonal).** If $T(x, y, z) = c(x) \cdot \delta_{x=y=z}$ for some function $c: D \to k^*$, then $\text{sr}(T) = |D|$.

### Application to PCP — naive attempt

We want to use $T$ to bound $|A_p|$. The naive identification $T(x, x, x) = T_{x, x, x}$ where $x = (a, b, c) \in \mathbb F_p^3$... but $T$ is a 3-tensor on $\mathbb F_p$, not on $\mathbb F_p^3$. So this doesn't directly apply.

### Proper setup

To apply Tao's diagonal theorem, we need a 3-tensor whose **input axes are $V = \mathbb F_p^3$**. Define:
$$T'_{(a_1,b_1,c_1), (a_2,b_2,c_2), (a_3,b_3,c_3)} := \mathbb 1[(a_1, b_2, c_3) \in A_p]$$
or similar "skew" indicator. But this won't have the diagonal-vanishing property required by Tao.

For a successful CLP attack, we'd need to find a 3-tensor $T'$ on $V^3$ where:
1. $T'(x, x, x) = \mathbb 1[x \in A_p]$ (diagonal recovers $A_p$).
2. $T'(x, y, z) = 0$ for "most" off-diagonal $(x, y, z) \in A_p^3$.
3. $\text{sr}(T')$ can be bounded.

**Showstopper**: The standard CLP/cap-set construction uses an additive structure (e.g., $x + y + z = 0$ in cap-set). PCP has no natural additive structure on $A_p$ — the constraints are quadratic equations, not additive ones.

### Modified attempt: tensor with quadratic constraint

Define $T'_{x, y, z} := \mathbb 1[x, y, z \in A_p] \cdot Q(x, y, z)$ where $Q$ is some 6-variable polynomial that vanishes off the diagonal. The issue: any $Q$ that vanishes on the diagonal $x = y = z$ has total degree $\geq 3 \cdot \dim V = 9$.

By the standard polynomial slice-rank bound:
$$\text{sr}(T') \leq 3 \binom{D/3 + n}{n}$$
where $n = 3$ (input dim) and $D$ is the total degree. For $D = 9$, this gives $\text{sr}(T') \leq 3 \binom{6}{3} = 60$. Compared to $|A_p| \approx p^3$, this is much smaller, so it WOULD give a strong bound — IF we could ensure $T'$ has the right structure.

**The issue**: We need $T'(x, x, x) \neq 0$ for $x \in A_p$ AND $T'(x, y, z) = 0$ for off-diagonal $(x, y, z) \in A_p^3$. But the natural $T'(x, y, z) = \mathbb 1[x = y = z] \cdot \mathbb 1[x \in A_p]$ has slice-rank exactly $|A_p|$, with no bound from polynomial degree.

The CLP miracle relies on a special algebraic identity (like $x_1 + x_2 + x_3 = 0 \iff x_1 = x_2 = x_3$ for the $\mathbb F_3$ cap-set case, via the Frobenius identity). For PCP, no such identity is available.

## Conclusion of Angle 6

**Slice-rank for the PCP constraint tensor gives no nontrivial bound.** The reason: PCP's combinatorial structure is "equation system to satisfy," not "pattern to avoid." CLP / slice-rank machinery is designed for the latter.

The observed flattening rank $(p+1)/2$ is a structural fact (squaring-invariance) but doesn't translate to a useful PCP bound.

## What we DID gain

The empirical observation that $V(\mathbb F_p) = V_{\text{trivial}}(\mathbb F_p)$ exactly for $p \in \{3, 5, 7, 11, 19\}$ is, in spirit, a **polynomial-method result** — it's the statement that the polynomial $\prod_i (1 + \chi(Q_i))/2$, viewed as a polynomial in $\mathbb F_p[a, b, c]$, vanishes identically on $(\mathbb F_p^*)^3$. This is exactly the kind of "identical vanishing of a polynomial on a configuration" that polynomial method exploits.

For larger $p$, the polynomial is nonzero somewhere, so the obstruction breaks. But the result for small $p$ is unconditional and gives a real divisibility constraint on PCP.

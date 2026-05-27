# Slice-rank attack on PCP: setup

## Definitions

**Slice-rank** (Tao 2016). For a tensor $T \in V_1 \otimes V_2 \otimes V_3$ over a field $k$, the **slice-rank** $\text{sr}(T)$ is the smallest integer $r$ such that $T = \sum_{i=1}^r v_i \otimes M_i$ where each summand has at least one **rank-1 slice**: i.e., one of $v_i \in V_j$ is a vector and $M_i$ is a tensor in the other two factors (not constrained).

More precisely: $\text{sr}(T)$ is the smallest $r$ s.t. $T = \sum_{i=1}^r T_i$ where each $T_i$ has the form $T_i = u_i \otimes_{j_i} M_i$ for some index $j_i \in \{1,2,3\}$ — i.e., $T_i$ factors with at least one "axis-aligned" rank-1 factor.

**Lemma (Tao).** If $D \subset V$ is a set and $T_D : V^3 \to k$ is the "diagonal tensor" $T_D(x,y,z) = \delta_{x=y=z} \cdot f(x)$ for any nonzero $f: D \to k$, then $\text{sr}(T_D) = |\{x \in D : f(x) \neq 0\}|$.

**Application strategy**. Pick a configuration $A \subset V^n$ and a polynomial / tensor $T$ such that:
1. On the "diagonal" $\{(a, a, a) : a \in A\}$, $T(a,a,a) = c \neq 0$.
2. Off the diagonal, $T(x,y,z) = 0$ for $x, y, z \in A$ unless some collinearity.
3. Bound $\text{sr}(T)$ by an algebraic computation (typically via polynomial degree).

Then $|A| \leq \text{sr}(T)$.

## PCP setup

Let $p$ be an odd prime. Let
$$A_p = \{(a, b, c) \in \mathbb{F}_p^3 : a^2+b^2, \, b^2+c^2, \, a^2+c^2, \, a^2+b^2+c^2 \text{ are all squares in } \mathbb{F}_p\}.$$

We want to bound $|A_p|$ via slice-rank.

**Key observation**: The "is-square in $\mathbb{F}_p$" predicate is given by the polynomial
$$\sigma(x) = \frac{1}{2}\left(1 + x^{(p-1)/2}\right) \quad \text{for } x \neq 0$$
and $\sigma(0) = 1$ (zero is a square). More usefully:
$$\sigma_+(x) := \frac{1 + x^{(p-1)/2}}{2} + \delta_0(x) \cdot \frac{1}{2}$$
gives $\sigma_+(x) = 1$ iff $x$ is a square.

A cleaner approach: use $\sigma^*(x) = 1 - (1 - x^{(p-1)/2})^2 / 4$... Actually for our purposes the cleanest is:

$$\mathbb{1}_{x \text{ is square}} = \sigma(x) := \begin{cases} 1 & x \text{ is a square, including 0} \\ 0 & x \text{ is a non-square} \end{cases}$$

In $\mathbb{F}_p[x]$ of degree $< p$, $\sigma(x)$ is uniquely interpolated by:
$$\sigma(x) = \frac{x^{(p-1)/2} + 1}{2} + \text{correction at }x=0$$
The expression $\frac{x^{p-1}+1}{2} \cdot \frac{x^{(p-1)/2}+1}{2}$ has degree $(3p-3)/2$... too high.

Use Lagrange interpolation directly: $\sigma(x) = \sum_{s \text{ square}} L_s(x)$ where $L_s$ are Lagrange basis polynomials. As a polynomial of degree $\leq p-1$, this is well-defined.

## Direct slice-rank computation

For a tensor $T: \mathbb{F}_p^3 \times \mathbb{F}_p^3 \times \mathbb{F}_p^3 \to \mathbb{F}_p$ (here $V_j = \mathbb{F}_p^{p^3}$, "function of $(a_j, b_j, c_j)$"), define
$$T((a_1,b_1,c_1), (a_2,b_2,c_2), (a_3,b_3,c_3)) = \prod_{i=1}^4 \mathbb{1}_{Q_i((a,b,c)_1, (a,b,c)_2, (a,b,c)_3) \text{ is a square}}$$
for some carefully chosen quadratic forms $Q_i$ in the 9 input variables.

**Diagonal property** (required): When $(a,b,c)_1 = (a,b,c)_2 = (a,b,c)_3 = (a,b,c)$, the value is $\prod_i \mathbb{1}[Q_i(a,b,c,a,b,c,a,b,c) \text{ square}]$, which we want to equal $\mathbb{1}_{(a,b,c) \in A_p}$.

The simplest choice: $Q_1 = a_1^2 + b_2^2$, $Q_2 = b_1^2 + c_2^2$, etc. — "diagonalizes" the constraints across the three copies.

**Issue**: The Croot-Lev-Pach trick requires the tensor to vanish off the diagonal under additional structural constraints (like avoiding 3-APs). PCP has only an *equation system*, not a "no-AP" structure.

## Reformulation: PCP as a "cap-set" problem

Try: Define $A \subset \mathbb{F}_p^3$ as the set of $(a,b,c)$ for which all four sums are squares.

**Cap-set analog**: a set $A \subset \mathbb{F}_p^3$ has **no 3-term progression structure** if there are no nontrivial $(x, y, z) \in A^3$ with $x + y + z = 0$ (i.e., $y = -(x+z)/2$ for some "midpoint" structure).

For PCP, we want to associate a "forbidden 3-tuple" structure to PCP itself.

**Direct attempt**: Consider tuples $((a_1, b_1, c_1), (a_2, b_2, c_2), (a_3, b_3, c_3)) \in A_p^3$ with
$$a_1^2 + a_2^2 = a_3^2, \quad b_1^2 + b_2^2 = b_3^2, \quad c_1^2 + c_2^2 = c_3^2.$$
This is a "Pythagorean tripartite" structure.

But there's no natural CLP-style indicator polynomial of low degree for this.

## Honest conclusion of setup

The CLP/slice-rank framework is fundamentally about **bounding configurations that AVOID a pattern**. PCP is about **finding a solution to an equation system**. These are dual problems but not directly interchangeable.

The applicable angle is: **bound $|A_p|$** where $A_p$ is the small set satisfying all four square conditions. But the empirical data shows $|A_p| \asymp p^3$ (it's a 3-dim variety), so any slice-rank bound at the obvious level cannot give nontrivial information.

The next move: introduce a **non-trivial cohomological / character-sum** angle.

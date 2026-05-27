# Phase 1: Systematic Sub-case Enumeration

> Started 2026-05-14

## Setup

Primitive PCP: $(a, b, c, d, e, f, g) \in \mathbb{Z}_{>0}^7$，$\gcd(a, b, c) = 1$。

**Parity** (2-adic, unconditional)：$a, c$ 偶，$b$ 奇，$v_2(a), v_2(c) \geq 2$, $|v_2(a) - v_2(c)| \geq 2$。

設 $\alpha := v_2(a), \gamma := v_2(c)$。WLOG $\alpha < \gamma$。

**Combined constraint**: $2 \leq \alpha < \gamma - 1$，即 $\gamma \geq \alpha + 2$。

## Sub-case enumeration

對每對 $(\alpha, \gamma)$ with $\alpha \in \{2, 3, 4, ...\}$ 與 $\gamma \in \{\alpha + 2, \alpha + 3, ...\}$:

設 $a = 2^\alpha \cdot a'$, $c = 2^\gamma \cdot c'$ with $a', c'$ odd, $\gcd(a', c') | \gcd(\text{odd part of } a, \text{odd part of } c)$。

由 primitive condition $\gcd(a, b, c) = 1$ + $b$ odd: $\gcd(a', c')$ 可任意 odd integer。

### Face I primitive parametrization

$a = 2 m n$, $b = m^2 - n^2$, $d = m^2 + n^2$, $\gcd(m, n) = 1$, $m, n$ opposite parity.

$v_2(a) = \alpha = 1 + v_2(mn)$.

$\alpha = 2$: $v_2(mn) = 1$ → 一個 of $m, n$ 為 $2 \cdot$ odd, 另為 odd.
$\alpha = 3$: $v_2(mn) = 2$ → 一個為 $4 \cdot$ odd, 另為 odd.
$\alpha = 4$: $v_2(mn) = 3$ → 一個為 $8 \cdot$ odd, 另為 odd.
...

### Sub-case表 (verified 2026-05-14)

| Sub-case ID | $\alpha = v_2(a)$ | $\gamma = v_2(c)$ | Edge bound verified | PCPs found |
|------------|-------------------|-------------------|---------------------|-----------|
| B(2,4) | 2 | 4 | $p \leq 10000$ | **0** ✅ |
| B(2,5) | 2 | 5 | max edge $\leq 100000$ | **0** ✅ |
| B(2,6) | 2 | 6 | max edge $\leq 100000$ | **0** ✅ |
| B(2,7) | 2 | 7 | max edge $\leq 200000$ | **0** ✅ |
| B(2,8) | 2 | 8 | max edge $\leq 200000$ | **0** ✅ |
| B(2,9) | 2 | 9 | max edge $\leq 200000$ | **0** ✅ |
| B(2,10) | 2 | 10 | max edge $\leq 200000$ | **0** ✅ |
| A(2,4) | 2 | 4 | $p \leq 10000$ | **0** ✅ |
| B(3,5) | 3 | 5 | max edge $\leq 200000$ | **0** ✅ |
| B(3,6) | 3 | 6 | TODO | ⏳ |
| B(3, $\geq 7$) | 3 | $\geq 7$ | TODO | ⏳ |
| B(4, $\geq 6$) | 4 | $\geq 6$ | TODO | ⏳ |
| B($\geq 5$, *) | $\geq 5$ | * | TODO | ⏳ |

**驗證之 sub-cases**: 9 個 (覆蓋大部分 low-$\alpha$ cases)
**統一結論**: **0 PCPs in all verified sub-cases**

**$\alpha = 2$ 之 sub-cases**: $\gamma \in \{4, 5, 6, ...\}$ — countably infinite. 但對固定 $\gamma$，每 sub-case 為 finite (per $p$).

**Key observation**: 對 $\gamma \gg 2$, $c$ 必有大 $2$-power factor。Combined with $\gcd(a, b, c) = 1$, this constrains $a$ 之 odd part 與 $c$ 之 odd part。

## Sub-case B(2, $\gamma$) for $\gamma \geq 5$

$a = 4 p q$ ($pq$ odd, $p, q$ both odd), $c = 2^\gamma \cdot c'$ ($c'$ odd).

Face III: $a^2 + c^2 = f^2$. $a^2 = 16 p^2 q^2$, $c^2 = 4^\gamma c'^2$. With $\gamma \geq 5$:
$$a^2 + c^2 = 16 (p^2 q^2 + 4^{\gamma - 2} c'^2)$$

Set $f = 4 f'$ where $f'^2 = p^2 q^2 + 4^{\gamma - 2} c'^2$.

$(pq, 2^{\gamma - 1} c', f')$ Pythagorean primitive (since $pq$ odd, $2^{\gamma-1} c'$ even, and gcd 1 by primitivity).

Parametrize: $pq = M^2 - N^2$, $2^{\gamma-1} c' = 2 M N$, $f' = M^2 + N^2$. So $M N = 2^{\gamma - 2} c'$.

For each divisor $M$ of $2^{\gamma - 2} c'$ with $\gcd(M, N) = 1$, opposite parity: gives a candidate.

**Space-diag**: $g^2 = a^2 + b^2 + c^2$. With $a = 4 pq$, $b = q^2 - 4 p^2$ (or $4p^2 - q^2$), $c = 2 M N$ (with $\gamma$ dependence):

$g^2 = 16 p^2 q^2 + (q^2 - 4 p^2)^2 + 4 M^2 N^2$
     $= 16 p^2 q^2 + q^4 - 8 p^2 q^2 + 16 p^4 + 4 M^2 N^2$
     $= q^4 + 8 p^2 q^2 + 16 p^4 + 4 M^2 N^2$
     $= (q^2 + 4 p^2)^2 + 4 M^2 N^2$
     $= d^2 + 4 M^2 N^2$ (since $d = q^2 + 4 p^2$)

But also $4 M^2 N^2 = (MN \cdot 2)^2$ → $g^2 = d^2 + (2 MN)^2$. So $(d, 2MN, g)$ Pythagorean!

But $2 M N = 2^{\gamma - 2} c' \cdot 2 / 2^{\gamma - 2}$... wait $2MN = c$? Let me check. We had $c = 2^\gamma c'$ and $2^{\gamma - 1} c' = 2 MN$, so $MN = 2^{\gamma - 2} c'$, $2MN = 2^{\gamma - 1} c'$. So $c = 2 \cdot 2^{\gamma - 1} c' = 2 \cdot 2 M N = 4 M N$. 

Wait that's not what I had. Let me redo.

$c = 2^\gamma c'$, $2^{\gamma - 1} c' = 2 M N$, so $c' = 2 MN / 2^{\gamma - 1} = MN / 2^{\gamma - 2}$. For $c'$ integer: $2^{\gamma - 2} | MN$. With $M, N$ opposite parity, one of $M, N$ is even. So $2 | MN$, $4 | MN$ when $M$ or $N \equiv 0 \pmod 4$, etc.

Specifically:
- $\gamma = 4$: $c' = MN / 4$, requires $4 | MN$, e.g., $M = 4 \cdot$ odd, $N$ odd.
- $\gamma = 5$: $c' = MN / 8$, requires $8 | MN$, $M = 8 \cdot$ odd, $N$ odd, etc.

Each $\gamma$ 給特定 $M, N$ form。Different sub-cases per $\gamma$.

For each $\gamma$, can derive Diophantine equation in $(p, q, M', N')$ where $M = 2^k M', N = ?$ for appropriate $k$.

### Critical observation: SAME Pythagorean structure

For ALL sub-cases B(2, $\gamma$) with $\gamma \geq 4$:

**$(d, c, g)$ form Pythagorean triple** ($g^2 = d^2 + c^2$)，where $d = q^2 + 4p^2$.

This is the $T_4 = (c, d, g)$ derived Pythagorean relation from PCP! (Recall: $Q_4 - Q_1$ gives $g^2 = d^2 + c^2$.)

So **all sub-cases collapse to same fundamental structure**: $(d, c, g)$ Pythagorean. The sub-case-specific differences are in HOW $c$ relates to $(p, q)$ via face III.

## Reformulation: Direct 7-variable approach

Instead of parametrizing each sub-case separately, work directly with the 7 Pythagorean triples (3 face + 3 derived + 1 sum):

$(a, b, d), (b, c, e), (a, c, f), (c, d, g), (a, e, g), (b, f, g)$ + $d^2+e^2+f^2 = 2g^2$.

Each is primitive Pythagorean (up to scaling). Each gives 2-parameter family.

**Combined system**: 12 parameters $(m_i, n_i)_{i=1..6}$, with sharing constraints.

After Sophie Germain reduction: equations of form
$$g^2 = 5(q^4 + 4 p^4 \cdot s^4)$$
for some integer $s$ encoding the specific sub-case.

This generalizes Case B (s = 1) to all sub-cases.

**Sub-task 1.4**: Identify $s$ for each sub-case ($\alpha, \gamma$) and corresponding Sophie Germain factorization.

## Concrete next computation

Run PARI search for **GENERAL** $s$ from $1$ to ~$100$, find all $(p, q, s)$ giving integer $g$, then check rest of PCP.

This automates sub-case enumeration.

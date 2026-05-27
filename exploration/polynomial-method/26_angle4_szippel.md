# Angle 4: Schwartz-Zippel-style CRT obstruction

## Setup

A PCP solution $(a, b, c) \in \mathbb Z^3$ reduces to $V(\mathbb F_p)$-points for every prime $p$. If we can find a CRT-incompatibility, then no integer solution exists.

For the trivial primes $\{3, 5, 7, 11, 19\}$, any solution must have $abc \equiv 0$ mod each $p$. So:
- $3 \mid abc$ (i.e., $3 \mid a$ or $3 \mid b$ or $3 \mid c$, 3 cases)
- $5 \mid abc$ (3 cases)
- $7 \mid abc$ (3 cases)
- $11 \mid abc$ (3 cases)
- $19 \mid abc$ (3 cases)

Total: $3^5 = 243$ "divisor pattern" combinations. Each is allowable a priori; we'd need to show **every one of these patterns leads to a contradiction** to close PCP.

## Schwartz-Zippel idea

Suppose $f(a, b, c)$ is a polynomial such that $f$ vanishes on every PCP solution. Then $f$ must satisfy:
- $f$ vanishes on the integer locus.
- Mod each prime $p$, $f$ vanishes on $V(\mathbb F_p)$.

If $f$ has degree $d$ and is not identically zero, then by Schwartz-Zippel, the number of $\mathbb F_p$-points where $f$ vanishes is $\leq d \cdot p^2$ (for a 3-dim variety in 3 variables). So if $|V(\mathbb F_p) \cap \{f = 0\}| < |V(\mathbb F_p)|$, contradiction.

**Issue**: We don't have a candidate $f$.

## More direct angle: "polynomial method on $V$ itself"

The variety $V \subset \mathbb P^6$ has $\dim V = 2$. By Bezout, $\deg V \leq 16$ (it's a complete intersection of 4 quadrics). 

By Lang-Weil (UNCONDITIONAL): $|V(\mathbb F_p)|$ (smooth points) $= p^2 + O(p^{3/2})$ for smooth surfaces of general type. The error term has explicit dependence on the geometry.

For a PCP solution to exist over $\mathbb Z$, we'd need a $\mathbb Z$-point on $V$ with all positive coordinates. The question: do the **explicit Lang-Weil constants** force enough constraints?

## Counting modulo $p$: the affine "open" subset

Let $A_p^* \subset (\mathbb F_p^*)^7$ be the set of $\mathbb F_p$-points of $V$ with all coordinates nonzero. Our computation gives:

| $p$ | $|A_p^*|$ |
|-----|-----------|
| 3   | 0         |
| 5   | 0         |
| 7   | 0         |
| 11  | 0         |
| 13  | 768       |
| 17  | 2304      |
| 19  | 0         |
| 23  | 5632      |
| 29  | 16128     |
| 31  | 17280     |
| 37  | 23040     |
| 41  | 51840     |

Asymptotic: $|A_p^*| \approx c \cdot p^3$ for some constant $c$.

This is a "fat" set in $\mathbb F_p^3$, so no Schwartz-Zippel angle gives further obstructions.

## Conclusion of Angle 4

The polynomial method **does** give the trivial-prime obstruction $\{3, 5, 7, 11, 19\}$, which translates to:
$$\boxed{3 \cdot 5 \cdot 7 \cdot 11 \cdot 19 = 21945 \mid abc}$$
for any PCP solution.

Beyond this, Schwartz-Zippel doesn't give a CRT-incompatibility — there are too many residue patterns satisfying all local constraints.

## What further angles might yield

For each "divisor pattern" (e.g., $3 | a, 5 | a, 7 | a, 11 | b, 19 | c$), we could substitute $a = 3 \cdot 5 \cdot 7 \cdot a'$, etc., and study the **descent** problem. This is closely related to the existing W3-Density bound $X^{1/2+\varepsilon}$ from the proof.md.

In particular, the divisibility constraint $21945 \mid abc$ combined with the W3-Density bound:
$$\#\{\text{primitive PCPs with edges} \leq X\} \ll X^{1/2+\varepsilon}$$
gives effectively no PCPs of bounded height, but cannot close PCP unconditionally without further input (e.g., Coleman saturation, Bombieri-Lang, etc.).

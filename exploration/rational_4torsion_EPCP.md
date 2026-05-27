---
title: PCP — E_PCP always has rational 4-torsion; the 4-torsion y-coord is `ab · Q`
author: CΛ / Lightman Chang
date: 2026-05-19
---

# E_PCP(Q)_tors ⊇ Z/4 ⊕ Z/2 — Hand-Computed Structural Fact

**CΛ / Lightman Chang** · 2026-05-19

## §1. Statement

Let `E_PCP : y² = x(x + a²)(x + b²)` be the Saunderson PCP curve at
parameter `(m, n)`, with `a = m² - n²` and `b = 2mn`. Then `E_PCP(Q)`
always contains the rational 4-torsion point
$$
T_1' = (-ab,\ \pm ab(a-b)) = (-ab,\ \pm ab \cdot Q)
$$
where `Q = (m-n)² - 2n²` is the lower Heron form. In particular,
`E_PCP(Q)_{tors}` contains a subgroup isomorphic to `Z/4 ⊕ Z/2`.

## §2. Hand proof

**Verify `T_1'` is on `E_PCP`**:
$$
y² = (-ab) \cdot (-ab + a²) \cdot (-ab + b²)
     = (-ab) \cdot a(a-b) \cdot b(b-a)
     = ab \cdot ab \cdot (a-b)^2
     = a^2 b^2 (a-b)^2.
$$
So `y = ± ab(a-b)` rational. ✓

**Verify `2 T_1' = T_1 = (0, 0)`** by computing the tangent line at `T_1'`:

Tangent slope at `(x_0, y_0) = (-ab, ab(a-b))`:
$$
\lambda = \frac{f'(x_0)}{2 y_0}, \quad f(x) = x³ + (a²+b²) x² + a²b² x.
$$
At `x_0 = -ab`:
$$
f'(-ab) = 3 a²b² - 2(a²+b²)·ab + a²b²
        = 4 a²b² - 2ab(a²+b²)
        = -2 ab \big[(a²+b²) - 2ab\big]
        = -2 ab (a-b)^2.
$$
So $\lambda = -2ab(a-b)^2 / (2 \cdot ab(a-b)) = -(a-b)$.

Tangent line: $y - ab(a-b) = -(a-b)(x + ab)$. At `x = 0`:
$$
y = ab(a-b) - (a-b)(ab) = 0.
$$
So the tangent passes through `(0, 0) = T_1`, i.e., `2 T_1' = T_1`. ✓

## §3. Consequences

### (i) PCP point's "half" is structured

If a PCP point `P_PCP = (c², ⋯)` exists, then `δ(P_PCP) = (1, 1, 1)`
(since `c² + a² = f²`, `c² + b² = g²` are squares). So `P_PCP ∈ 2 E_PCP(Q)`.

Solving `2 R = P_PCP` over Q: the four solutions differ by elements
of `E_PCP[2](Q) = ⟨T_1, T_2, T_3⟩`. But thanks to the 4-torsion `T_1'`,
the solutions `R, R + T_1, R + T_2, R + T_3` are RATIONAL points.

**Each of these 4 rational `R`'s has a distinct descent class** `δ(R)`,
related to the corresponding `(sf(x_R - e_i))` 2-Selmer images. The
relationship to `(sf P, sf Q)` of the Heron conic is the content of
the Cassels-Tate gap (Agent 4).

### (ii) The 4-torsion y-coordinate IS the Heron form Q

`ab · Q` is the y-coordinate of `T_1'`. This is the **same Q** as in
the Heron conic `V_{P, Q}: x² = Py² + Qz²` (Agent 4). The Heron form
`Q = (m-n)² - 2n²` thus appears in **two distinct geometric roles**:
1. As one of the two squareclasses defining the 2-Selmer torsor V_{P, Q}.
2. As (a factor of) the y-coordinate of the canonical rational 4-torsion.

This dual appearance is unlikely to be coincidence — suggests a deeper
isogeny-structure tying together (♦) and the 4-torsion behaviour.

### (iii) Possible Mazur torsion subgroup of E_PCP

By Mazur's classification, `E_PCP(Q)_tors ∈ {Z/n (n ≤ 10, n=12), Z/2 ⊕ Z/2m (m ≤ 4)}`.
We've established `Z/4 ⊕ Z/2 ⊆ E_PCP(Q)_tors`, which forces
`E_PCP(Q)_tors ∈ {Z/4 ⊕ Z/2, Z/4 ⊕ Z/4, Z/8 ⊕ Z/2}` (up to Mazur).

The `Z/4 ⊕ Z/4` option requires *another* independent 4-torsion above
`T_2` (at `e_2 = -a²`). Repeating the tangent calculation, 4-torsion
above `T_2` exists rationally iff `a² - b² = PQ` is a square. So:
$$
E_{PCP}(\mathbb{Q})_{tors} \supseteq \mathbb{Z}/4 \oplus \mathbb{Z}/4
\quad \iff \quad
PQ \text{ is a perfect square}.
$$
Since `PQ = a² - b² = (m² + 2mn - n²)(m² - 2mn - n²)`, this is rarely
the case for primitive `(m, n)` — but worth flagging.

## §4. Open

- Compute `δ(R)` explicitly for each of the 4 rational 2-preimages of `P_PCP`.
- Tie to Agent 4's Cassels-Tate gap analysis.
- Verify on the BEYOND-QC fibers: e.g., does `T_1'` reside in any
  ellrank-discovered point lists?

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher, 2026-05-19.

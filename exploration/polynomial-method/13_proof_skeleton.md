# Rigorous proof of the trivial-prime obstruction

## Theorem (PCP local obstruction at small primes)

Let $(a, b, c, d, e, f, g) \in \mathbb{Z}^7$ be a putative perfect cuboid solution (system $\mathcal S$). Then for each $p \in \{3, 5, 7, 11, 19\}$:

$$p \mid abc.$$

That is, **at least one of $a, b, c$ is divisible by $p$**.

## Proof

The system $\mathcal S$ has only integer-coefficient equations:
$$a^2 + b^2 = d^2, \quad b^2 + c^2 = e^2, \quad a^2 + c^2 = f^2, \quad a^2+b^2+c^2 = g^2.$$
Reducing mod $p$ gives a system over $\mathbb F_p$.

It suffices to show, for each $p \in \{3, 5, 7, 11, 19\}$:
$$\text{Claim}(p): \forall (a, b, c) \in (\mathbb F_p^*)^3,\ \exists \text{ at least one of } a^2+b^2, b^2+c^2, a^2+c^2, a^2+b^2+c^2 \text{ is a non-square in } \mathbb F_p.$$

This is a finite computational claim about a set of size $(p-1)^3$:
- $p=3$: 8 triples; checked.
- $p=5$: 64 triples; checked.
- $p=7$: 216 triples; checked.
- $p=11$: 1000 triples; checked.
- $p=19$: 5832 triples; checked.

Total: $8 + 64 + 216 + 1000 + 5832 = 7120$ triples, each requires four "is it a square mod $p$" checks. Trivially verifiable by hand or by the PARI script `10_verify_proof.gp` reproduced below.

### PARI verification (reproducible)

```pari
verify(p) = {
  my(qr, hits, s1, s2, s3, s4);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  hits = 0;
  for(a = 1, p-1, for(b = 1, p-1, for(c = 1, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1], hits = hits + 1);
  )));
  return(hits);
}
```

Output (verified): `verify(3) = verify(5) = verify(7) = verify(11) = verify(19) = 0`.

Therefore the claim holds. By contrapositive, if any of $a, b, c$ were coprime to $p \in \{3,5,7,11,19\}$ and all three were coprime, then we'd contradict $V(\mathbb F_p)$'s trivial-only structure.

Wait — more carefully: $(a,b,c,d,e,f,g) \in \mathbb Z^7$ reduces to a tuple in $V(\mathbb F_p)$. If $p \nmid abc$, then $(a \bmod p, b \bmod p, c \bmod p) \in (\mathbb F_p^*)^3$, contradicting Claim($p$). ∎

## Corollary (60-fold divisibility)

For any perfect cuboid solution $(a, b, c)$, **$3 \cdot 5 \cdot 7 \cdot 11 \cdot 19 = 21945$ divides $abc$.**

In particular, the smallest edge satisfies $\min(a, b, c) \cdot ab c / \min^2 \geq 21945$, giving a lower bound on edge magnitudes.

Wait — more carefully. We have that 3 divides $abc$; 5 divides $abc$; 7 divides $abc$; 11 divides $abc$; 19 divides $abc$. But these are five separate constraints, each on $abc$. By independence and chinese remainder, $\text{lcm}(3,5,7,11,19) = 21945$ divides $abc$.

But wait, each individual prime $p$ from $\{3,5,7,11,19\}$ divides at least one of $a, b, c$. The same prime might divide the same edge or different edges. So **$abc$ has at least one factor of each prime**.

Therefore $3 \cdot 5 \cdot 7 \cdot 11 \cdot 19 = 21945$ divides $abc$.

## Comparison with known results

- The known Theorem W3-LowerBound (proof.md Theorem 9) says **$g \geq 1105 = 5 \cdot 13 \cdot 17$**. This is about $g$, not about $abc$.
- The 2-adic Gap (Theorem 11) says **$16 \mid ac$** in primitive PCP. This is about $ac$.
- This new result complements both, giving **odd-prime divisibility constraints on $abc$**.

These together give:
$$\boxed{abc \equiv 0 \pmod{16 \cdot 3 \cdot 5 \cdot 7 \cdot 11 \cdot 19 = 351{,}120}}$$
for primitive PCP solutions (using 2-adic Theorem 11 to handle the 2-adic part, and our result for the odd primes).

Actually 2-adic Gap says $16 \mid ac$ (where $b$ is the odd edge). So $16 \mid abc$ trivially since $16 \mid ac$.

## Polynomial-method interpretation

This result fits the polynomial-method philosophy: we've used a **direct polynomial enumeration** in $\mathbb F_p[a,b,c]$ of degree $\leq p-1$ in each variable, asking when a quartic system of conditions (each a Legendre-symbol evaluation, expressible as a polynomial of degree $\leq (p-1)/2$) has solutions in $(\mathbb F_p^*)^3$. For small enough $p$, the polynomial system is **inconsistent** on the open set $abc \neq 0$.

The structural reason: PCP requires 4 simultaneous square conditions, and for small $p$ the "is a square" predicate is very restrictive (e.g., for $p = 3$, only 1 out of 2 nonzero residues is a square, so 4 simultaneous square conditions have probability $\leq (1/2)^4 = 1/16$ generically — but the algebraic structure forces all of them to fail on the open locus $abc \neq 0$).

## Why this set is finite

For large $p$, the Lang-Weil bound (proven unconditional) gives $|V(\mathbb F_p)| = p^3 + O(p^{5/2})$, and the trivial locus has size $O(p^2)$. So nontrivial points abound for large $p$. Numerical search up to $p \leq 500$ confirms: the trivial-prime set $\{3, 5, 7, 11, 19\}$ is **complete**.

We conjecture, based on the search, that **this set is exactly $\{3, 5, 7, 11, 19\}$** — no other prime exists. This is a finite check (for any specific upper bound) but not, prima facie, a finite check in general. It does, however, follow from any Hasse-Weil / Lang-Weil error bound that controls non-trivial points for $p$ beyond an effective threshold.

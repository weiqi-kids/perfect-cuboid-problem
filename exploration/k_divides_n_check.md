# k | n Conjecture — Test Across BEYOND-QC Saunderson Fibers

**Author:** CΛ / Lightman Chang · 2026-05-19
**Status:** PARTIAL — original conjecture refined; pattern uniquely matches the only fiber with extra Selmer dim.

## §1 Correction to original premise

The original `HERON-FACE-SELMER.md` lists `(m+n)² − 2n² = 12679` as
*prime* for (88, 35). **This is wrong.** Direct factorisation:

```
12679 = 31 · 409.
```

Hence **both 31 and 409 are already in H(88, 35)** — neither is "outside"
the basic Heron-form prime set. Bad primes of `E_Hm` at every BEYOND-QC
fiber are explained by `H(m, n)` without exception. The "outlier" of
`HERON-FACE-SELMER.md` evaporates.

## §2 Reframed conjecture

For the 5 BEYOND-QC fibers, `dim S²(E_Hm/Q) ∈ {4, 5, 5, 5, 6}` with
(88, 35) being the unique fiber with `dim S² = 6`. The genuine question
is **why (88, 35) is anomalous**, given all five share the same
H(m, n)-prime structure.

**Refined conjecture (numerical observation):**
An extra 2-Selmer dimension at a Saunderson fiber `(m, n)` is associated
with the existence of a "cross-pairing identity"

  `p · q = m² + (m + n/k)²`,    `p, q ∈ BAD,  p ≡ q ≡ 1 (mod 4),
    k | n,  p, q originate in two DIFFERENT Heron-form classes`.

## §3 Numerical evidence

### (a) Among the 5 BEYOND-QC fibers — EXACTLY ONE hit

| Fiber | dim S² | `p·q` pairs ≡ 1 mod 4 with `p·q = m²+v²`, `v−m = n/k`? |
|------:|:------:|:-------------------------------------------------------|
| (61, 38) | 4 | NONE (5·1033 = m² + n² is trivial: v = n) |
| (63, 38) | 5 | NONE |
| (73, 24) | 5 | NONE (5·1181 = m² + n² trivial) |
| **(88, 35)** | **6** | **41·409 = 88² + 95²,  v = m + n/5  ✓** |
| (99, 28) | 5 | NONE |

The conjecture's matching pattern occurs **exactly once across the
5 BEYOND-QC fibers**, and on **exactly the fiber with the extra Selmer
dim**.  `41 | (m+n) = 123`, `409 | (m+n)² − 2n² = 12679` — different
Heron forms.

### (b) Testing k ∈ {3, 7, 11} for fibers with the required divisor

- (73, 24), k = 3 (only k from {3,5,7,11} dividing 24):
  `73² + 81² = 11890 = 2·5·29·41` — 29 and 41 are **not** bad primes
  of `E_Hm` at (73, 24). Conjecture predicts NO extra dim → consistent
  with `dim S² = 5`.

- (88, 35), k = 7: `88² + 93² = 16393 = 13² · 97`. 13, 97 ∉ BAD(88, 35).
  No extra dim contribution from k = 7. Consistent.

- (99, 28), k = 7: `99² + 103² = 20410 = 2·5·13·157`. 13, 157 ∉ BAD.
  No extra dim. Consistent.

- (61, 38), (63, 38): no `k ∈ {3, 7, 11}` divides n = 38. Vacuous.

### (c) Systematic Saunderson scan, `m ≤ 100, gcd(m,n)=1, m−n odd`

Hits with `p·q = m² + (m+n/k)²`, both `p, q` ∈ BAD, ≡ 1 (mod 4), from
**different** Heron forms:

| (m, n) | k | factorisation | which forms |
|:-------|:--|:--------------|:------------|
| (27, 10) | 10 | 17 · 89 = 1513 | m−n × (m−n)²−2n² |
| (38, 21) | 21 | 5 · 593 = 2965 | m²+n² × (m−n)²−2n² |
| (62, 3)  | 3  | 13 · 601 = 7813 | m+n × (m+n)²−2n² |
| (62, 35) | 5  | 5 · 1721 = 8605 | n × (m−n)²−2n² |
| (88, 35) | 5  | 41 · 409 = 16769 | m+n × (m+n)²−2n² |

(62, 35) is the closest analog to (88, 35): same n = 35, same k = 5,
cross-pair structure. Its `dim S²` is unknown (no Selmer file). **Testing
(62, 35) is the highest-leverage next step.**

## §4 Refined statement

> **Conj. (refined).** Let `E_Hm` be the Saunderson Heronian-cuboid
> elliptic fiber at primitive `(m, n)`. If there exist primes
> `p, q ∈ BAD(E_Hm)` with `p ≡ q ≡ 1 (mod 4)`, originating in two
> distinct Heron-form classes of `H(m, n)`, and an integer `k | n` with
> `p · q = m² + (m + n/k)²`, then `dim_F2 S²(E_Hm/Q)` exceeds the
> "naïve Heron count" by at least 1.

The original `p·q with p, q both bad` requirement plus the `5 | n`
restriction is too narrow; the actual structural ingredient is the
**Gaussian-integer cross-pairing of two Heron-form prime classes**. The
parameter `k` may be any divisor of n.

## §5 Open

- Compute `S²(E_Hm)` for (62, 35), (27, 10), (38, 21), (62, 3) — these
  4 small fibers either confirm or refute the conjecture cleanly. None
  is BEYOND-QC, but their Selmer is small enough to enumerate by hand
  in PARI factorbase.
- Identify which Gaussian-integer norm class in `Z[i]/(p·q)` actually
  provides the Selmer cocycle. For (88, 35), `41 · 409 = (4+5i)(20+3i) ⋯`
  and `−88 + 95i` is the witnessing Gaussian integer.
- Determine whether the cross-pairing comes from a 2-isogeny twist or
  from a 4-descent obstruction in `Sha[2]`.

---

*Signed:* CΛ / Lightman Chang, 2026-05-19.

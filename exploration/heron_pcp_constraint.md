# Heron-Conic PCP Constraint at Saunderson Parameters (m, n)

**CΛ / Lightman Chang** · 2026-05-19 · `heron_pcp_constraint.md`

## §1. The Heron identity

Set `a = m² − n²`, `b = 2mn`, `d_ab = m² + n²`, and
```
P := (m + n)² − 2n² = a + b,    Q := (m − n)² − 2n² = a − b.
```
Direct expansion gives
```
P · Q = a² − b² = m⁴ − 6 m² n² + n⁴,    P² + Q² = 2 d_ab².
```
Both `P, Q` are norms from `Q(√2)/Q`: `P = N((m+n) + n√2)`,
`Q = N((m−n) + n√2)`, and `PQ = N(d_ab + b√2) = d_ab² − 2 b²`.

## §2. The Heron conic as a 2-Selmer torsor

PCP at (m, n) requires `c, e, f, g ∈ Q` with `a² + c² = e²`,
`b² + c² = f²`, `a² + b² + c² = g²`; then `e² − f² = a² − b² = PQ`.
Define the **Heron conic**
```
V_{P,Q}:    x² = P y² + Q z².                                  (★)
```
Standard 2-descent on `E_PCP: y² = x(x + a²)(x + b²)` identifies (★)
with the 2-Selmer torsor of the class `(sf(P), sf(Q)) ∈ (Q*/Q*²)²` —
the image of the 2-torsion sum `T_a + T_b`, since the non-zero
2-torsion points `(−a², 0)`, `(−b², 0)` have descent images
differing by `(sf(P), sf(Q))`. By Hasse–Minkowski (★) has a
rational point iff
```
(P, Q)_v = 1   for every place v of Q.                          (♦)
```

## §3. Necessity of (♦) for MW-supported (P, Q)-class

**Proposition.** If the rank of `E_PCP(m, n)` is supported by a
generator whose 2-descent image is `(sf(P), sf(Q))`, then (♦) holds.

*Proof.* 2-Selmer consists of `(Q*/Q*²)²`-classes whose torsor is
everywhere locally solvable. The torsor of `(sf(P), sf(Q))` is
`V_{P,Q}`, whose local solvability is (♦). □

Failure of (♦) at any place forces the class into `Ш(E_PCP/Q)[2]`:
the rank-1 generator (if any) must live in a **different** Selmer
class. This pins `(sf(P), sf(Q))` to a coset of an index-2^k
subgroup of `(Q*/Q*²)²`.

## §4. Verification on the 4 BEYOND-QC fibers

Computed in PARI by `hilbert(P, Q, p)` for `p` in the prime support
of `2 P Q`:

| Fiber | sf(P) | sf(Q) | (P, Q)_v fails at | Class blocked |
|---|---|---|---|---|
| (61, 38) | 31·223 | −7·337 | — | NO |
| (63, 38) | 71·103 | −31·73 | 73, 103 | YES |
| (73, 24) | 23·359 | 1249 | 23, 359 | YES |
| (88, 35) | 31·409 | 359 | 2, 359 | YES |

For 3 of 4 fibers the (P, Q)-class sits in `Ш[2]`. This matches the
empirical **cross-pairing** in HERON-FACE-SELMER.md §3: at (63, 38)
the Selmer F_2-basis is `(71·73, 31·103)`, not the "naïve parallel"
`(71·103, −31·73)`. The cross-pairing is forced by (♦).

For (61, 38), (♦) passes — and `EHm_selmer_triples.txt` lists the
triple `(8012167, 6913, 1159)` with `6913 = sf(P)`, confirming the
(P, Q)-class is genuinely in 2-Selmer.

## §5. Search-space reduction

A scan of primitive (m, n) with `m + n` odd, `gcd = 1`, `2 ≤ m ≤ 9`
gives 17 fibers; 13 are blocked by (♦) — including Halcke (m, n)
= (8, 3) for the non-PCP brick (240, 252, 275). Only (5, 2), (5, 4),
(9, 2), (9, 4) pass — all with `Q = ±1` or `P/Q` a perfect square,
making Hilbert symbols automatically trivial. The (♦) test thus
prunes ~73% of small fiber candidates in a single Hilbert-symbol
scan (microseconds per fiber).

## §6. Open

(♦) is necessary for the (P, Q)-class to be MW-supported, hence
necessary for PCP **only if** the PCP point's descent image lies in
that class. The PCP class (trivial in `(Q*/Q*²)²` since `x = c²`
is a square) is conjecturally related to `(sf(P), sf(Q))` by
Cassels–Tate; a clean elementary necessary condition for PCP itself
remains open.

---

## 100-word summary

The Heron identity `(m² − n²)² − (2mn)² = ((m+n)² − 2n²)·((m − n)² − 2n²)`
yields `P · Q = a² − b²` for Saunderson sides `a, b`. The Heron conic
`V_{P,Q}: x² = Py² + Qz²` is the 2-Selmer torsor of `E_PCP(m, n)`
attached to `(sf(P), sf(Q))`. Its local solvability — all Hilbert
symbols `(P, Q)_v = 1` — is necessary for that Selmer class to lift
to a Mordell-Weil point. Of the 4 BEYOND-QC fibers this test **blocks**
(63, 38), (73, 24), (88, 35) and **passes** (61, 38), exactly matching
the cross-pairing observed in HERON-FACE-SELMER.md.

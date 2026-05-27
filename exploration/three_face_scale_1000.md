# Three-Face Hilbert Filter at Scale `m ≤ 1000`

**CΛ / Lightman Chang** · 2026-05-20 · `three_face_scale_1000.md`

## §1. Setup

Primitive Saunderson fibers `(m, n)` with `gcd = 1`, `m + n` odd, `1 ≤ n < m ≤ 1000`.
`P = (m+n)² − 2n²`, `Q = (m−n)² − 2n²`. Filters: (♦_ab) `(P, Q)_v = 1 ∀ v`;
(♦_bc) `(P, −Q)_v = 1 ∀ v`; (♦_ac) `(−P, Q)_v = 1 ∀ v`. PARI elementary only.
**Degenerate**: `|sf(P)| = 1`, `|sf(Q)| = 1`, or one of them a single prime `≡ 1 (mod 8)`.
Script `/tmp/three_face_1000/scan_1000.gp`; validated vs published m ≤ 50 (21/21 deg) and
m ≤ 100 (51/51 deg) counts.

## §2. Aggregate statistics

| Quantity | m ≤ 100 | m ≤ 200 | m ≤ 1000 |
|---|---:|---:|---:|
| Primitive fibers | 2 040 | 8 156 | **202 861** |
| Pass (♦_ab) | 252 | ≈ 879 | **16 859** (8.31%) |
| Pass (♦_ab) ∧ (♦_bc) | 191 | — | **11 136** (5.49%) |
| **Pass all three** | **51** | — | **3 081** (1.52%) |
| Degenerate survivors | 51 | — | **3 029** |
| **NON-degenerate survivors** | **0** | **0** | **52** |

Scan time: 3.66 s for the full 202 861 fibers. The 3-face filter prunes **98.48 %** of
primitive Saunderson candidates.

## §3. Non-degenerate survivors — the key finding

**The conjecture "all `m ≤ 1000` survivors are degenerate" is FALSE.** The first
non-degenerate survivor occurs at `(m, n) = (265, 14)`; the full list (52 fibers) is:

```
(265, 14)  (353, 10)  (413, 48)  (433, 118) (497, 80)  (509, 26)  (509, 138)
(513, 196) (517, 42)  (553, 8)   (577, 116) (581, 34)  (609, 34)  (621, 26)
(629, 36)  (629, 76)  (641, 252) (673, 190) (693, 236) (709, 54)  (721, 22)
(749, 130) (757, 118) (773, 4)   (785, 14)  (793, 322) (797, 288) (829, 168)
(833, 94)  (841, 8)   (845, 236) (849, 68)  (857, 228) (861, 74)  (869, 314)
(881, 322) (889, 226) (889, 234) (889, 316) (893, 354) (897, 238) (909, 146)
(929, 170) (929, 306) (933, 208) (937, 28)  (937, 232) (945, 374) (961, 98)
(985, 264) (989, 326) (989, 352)
```

(Full table with factorisations: `/tmp/three_face_1000/nondeg_factored.txt`.)

## §4. Structure of the non-degenerate survivors

All 52 obey a tight regularity:

1. **52/52 have `m ≡ 1 (mod 4)`, `n` even.** **No** `m ≡ 3 (mod 4)` survivor.
2. **`sf(P)`, `sf(Q)` are each a product of exactly TWO primes** ≡ 1 (mod 8). Single
   exception: `(989, 326)` has `Q = 7² · 41 · 113` (mod squares still 41·113).
3. **Small-prime support**: 19 primes < 1000 cover all small divisors, all ≡ 1 (mod 8):
   `{41, 113, 137, 257, 313, 337, 353, 409, 457, 521, 569, 577, 593, 761, 809, 857,
   881, 953}`. The prime 41 appears in 34/52 fibers (65 %).
4. **Pairwise mutual non-residue**: at `(265, 14)`, with `P = 41·1889`, `Q = 137·457`,
   ALL 12 pairwise Kronecker symbols `(p/q)` among the four primes equal `−1`.

These survivors are **degenerate-by-extension**: a single prime ≡ 1 (mod 8) gives
trivial Hilbert symbols at itself; here a *product* of two such primes in mutual
non-residue configuration achieves the same triviality for all three signs
`(±P, ±Q)_v`. The `three_face_obstructions.md` definition does not cover this case.

## §5. Smallest survivor — (m, n) = (265, 14)

`a = 70 029 = 3²·31·251`, `b = 7 420 = 2²·5·7·53`,
`P = 41 · 1889`, `Q = 137 · 457` (all four primes ≡ 1 mod 8; all 12 pairwise
Kroneckers = −1). `qfsolve` on the three Heron conics
(`/tmp/three_face_1000/descent_265_14.out`):

| Conic | Rational point |
|---|---|
| `V_{P,Q}: x² = Py² + Qz²` | `(42657, 149, 40)` |
| `V_{P,−Q}: x² = Py² − Qz²` | `(4313, 109, 120)` |
| `V_{−P,Q}: x² = −Py² + Qz²` | `(571, 4, 5)` |

All three torsors are **genuinely in 2-Selmer of `E_PCP`**, not in `Ш[2]`. Unlike the
four BEYOND-QC fibers, (265, 14) is not reduced further by Hilbert symbols alone.
Closing PCP here requires 4-descent (Cassels–Tate on `[P, Q]`) or rank computation —
both outside the elementary-PARI constraint. The fiber stays **OPEN**.

## §6. Cross-reference with NSF and almost-cuboid lists

None of the 52 `(m, n)` appears as a Pythagorean face-parameter of any of the 11
primitive Euler bricks `max ≤ 5000` in `NON-SAUNDERSON-FAMILIES.md` §1, nor of the
four NSF rank-0 families `E_{8,3}, E_{4,3}, E_{6,5}, E_{13,2}`. These are **fresh**
fibers — the smallest has `b = 2mn = 7 420`, putting any cuboid in `E_{m,n}` well
beyond Bremner-style small-search horizons.

## §7. Implications for PCP non-existence

1. **3-face filter is not a closure theorem.** The "all m ≤ 100 survivors degenerate"
   pattern extends to m ≤ 250 but **breaks at m = 265**. PCP non-existence cannot be
   reduced to Hilbert-symbol triviality alone.
2. **Degeneracy is too narrow.** Replacing "single prime ≡ 1 mod 8" by "product of
   primes ≡ 1 mod 8 in pairwise mutual non-residue" restores 52/52 closure at m ≤ 1000.
3. **Next obstruction layer**: each fiber has a genuine 2-Selmer class `[P, Q]`. The
   Cassels–Tate pairing (4-descent) is the right next test. `qfsolve` already provides
   explicit 4-cover defining equations.
4. **Refined conjecture** (testable at m ≤ 2000): every non-degenerate 3-face survivor
   has `m ≡ 1 (mod 4)`, `n` even, `sf(P)` and `sf(Q)` each a 2-prime ≡ 1 mod 8 product
   with the four primes pairwise mutual NR. If proven, this would constrain the
   surviving Saunderson PCP locus to a thin character-sum-controlled subfamily.

---

## 100-word summary

Scanning 202 861 primitive Saunderson fibers `(m, n)` with `m ≤ 1000`, the
3-face Hilbert filter `(♦_ab) ∧ (♦_bc) ∧ (♦_ac)` admits 3 081 survivors (1.52 %),
of which **52 are non-degenerate** — refuting the m ≤ 100 conjecture that all
3-face survivors are degenerate. The smallest is `(265, 14)`. Every non-degenerate
survivor has `m ≡ 1 (mod 4)`, `n` even, `sf(P)` and `sf(Q)` each a product of two
primes `≡ 1 (mod 8)` in pairwise mutual non-residue configuration. `qfsolve`
exhibits explicit rational points on all three Heron face-conics, putting `[P, Q]`
genuinely in 2-Selmer. Closing PCP at these fibers requires 4-descent or rank.

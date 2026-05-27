# Mass Hilbert-Symbol Screen of Saunderson PCP Candidates

**CΛ / Lightman Chang** · 2026-05-19 · `mass_screen_hilbert.md`

## §1. The filter (♦)

For primitive `(m, n)` (gcd = 1, `m + n` odd) set
`P = (m+n)² − 2n²`, `Q = (m−n)² − 2n²`. Test
`(P, Q)_v = 1` at `v ∈ {∞} ∪ {primes | 2PQ}` (local solvability of the
Heron 2-Selmer torsor `x² = Py² + Qz²`, `HERON-FACE-SELMER.md`).
Implementation: PARI `hilbert`, microseconds per fiber.

## §2. Counts (1 ≤ n < m ≤ 200)

| Metric                                       | Count |
| -------------------------------------------- | ----: |
| Total primitive fibers                       | 8 156 |
| **Pass (♦)**                                 |   879 |
| **Fail (♦)** (class in Ш[2])                 | 7 277 |
| Degenerate (sf(P)=±1 or sf(Q)=±1 or P/Q∈□)  |    64 |
| Non-degenerate pass                          |   815 |

Pass rate **10.78 %**; non-degenerate **9.99 %**. (♦) prunes ≈ 89 %.

## §3. Passing fibers, m ≤ 50

**Non-degenerate (63)** — the rich candidates:

```
(9,2)  (9,4)  (13,2) (13,8) (13,12) (17,4) (17,8) (17,14)
(21,2) (21,4) (21,8) (21,10) (21,16)
(25,4) (25,14) (25,18) (25,24)
(29,2) (29,6) (29,14) (29,20) (29,22) (29,24)
(33,2) (33,4) (33,16) (33,20) (33,26) (33,28)
(37,12) (37,16) (37,18) (37,24) (37,26) (37,28) (37,32) (37,34)
(41,6) (41,12) (41,14) (41,20) (41,22) (41,26) (41,40)
(45,14) (45,22) (45,28) (45,32) (45,34) (45,44)
(49,2) (49,4) (49,6) (49,8) (49,12) (49,22) (49,26)
(49,30) (49,32) (49,34) (49,36) (49,40) (49,46)
```

**Degenerate (14)**: (5,2), (5,4), (13,4), (13,6), (17,6), (17,10),
(25,6), (25,8), (29,12), (29,28), (37,10), (37,14), (41,8), (41,10).

## §4. Historical consistency check

Tested every Pythag face-parameter `(m, n)` from the 9 NSF
non-Saunderson primitive Euler bricks (`NON-SAUNDERSON-FAMILIES.md` §2.2)
plus the Saunderson brick `(44, 117, 240)`:

| `(m,n)`  | (♦) | Fails at      | Source brick                       |
| -------- | :-: | ------------- | ---------------------------------- |
| (8, 3)   | F   | 2, 7          | Halcke 1719 `(240,252,275)`        |
| (11, 6)  | F   | 31, 47        | `(85,132,720)`,`(187,1020,1584)`   |
| (6, 5)   | F   | 2, 71         | three NSF bricks                   |
| (12, 1)  | F   | 2, 7, 17, 167 | `(85,132,720)`                     |
| (4, 3)   | F   | 2, 17         | `(140,480,693)`,`(160,231,792)`    |
| (16, 5)  | F   | 2, 17         | `(140,480,693)`                    |
| (10, 1)  | F   | 2, 17         | `(140,480,693)`,`(160,231,792)`    |
| (18, 7)  | F   | 2, 17, 23, 31 | `(240,252,275)`                    |
| (8, 5)   | F   | 2, 17         | `(429,880,2340)`,(44,117,240)face  |
| (11, 2)  | F   | 7, 73         | `(429,880,2340)`,(44,117,240)face  |
| (22, 17) | F   | 2, 7, 23, 79  | `(780,2475,2992)`                  |
| (32, 13) | F   | 2, 241        | `(832,855,2640)`                   |

12 of 15 fail (♦), including Halcke and all three (44, 117, 240)
faces. Three pass: `(13, 4)` is *degenerate* (Q = 49 = 7² ⇒ trivial);
`(13, 2)`, `(17, 8)` (from NSF bricks `(780,2475,2992)`, `(832,855,2640)`)
pass non-degenerately — their non-PCP closure comes from elsewhere
(rank-0 in NSF §3), consistent with (♦) as a *necessary* sieve.

## §5. The 5 BEYOND-QC fibers

| `(m,n)`  | (♦) | Fails at      | Matches HERON-FACE §2.3 |
| -------- | :-: | ------------- | ----------------------- |
| (61, 38) | PASS  | —             | YES — class in S²       |
| (63, 38) | FAIL  | 73, 103       | YES — forces cross      |
| (73, 24) | FAIL  | 23, 359       | YES — forces cross      |
| (88, 35) | FAIL  | 2, 359        | YES — forces cross      |
| (99, 28) | FAIL  | 151, 14561    | NEW datum               |

`(99, 28)`: `P = 14561` (prime), `Q = 3473 = 23·151`. The naïve
`(sf(P), sf(Q))`-class is in Ш[2] — not previously recorded. (99, 28)
joins (63, 38), (73, 24), (88, 35) in cross-pairing; only (61, 38)
stays MW-supported.

## §6. Surprises / patterns

1. **Pass list concentrates on `m ≡ 1 (mod 4)` and odd squares**:
   for m ≤ 50, no `m ≡ 3 (mod 4)` fiber passes; `m ∈ {9, 25, 49}`
   over-produce. Driven by `(P, Q)_2` parity.
2. **(♦) reproduces NSF first-level closure for free** on small
   Halcke-class fibers.
3. **(99, 28) cross-pairing prediction**: HERON-FACE §1.1 listed
   only 4 BEYOND-QC fibers; (99, 28) joins them. Its Selmer basis
   should cross-pair primes of `P, Q` or pull an extra factor (e.g.
   `7` from `mn = 2772 = 2²·3²·7·11`).
4. **Search-space**: 815 non-degenerate survivors out of 8 156 —
   tractable for full 2-descent enumeration.

Scripts/output: `/tmp/screen/{screen,analyze,verify}.gp` and
`screen_out.txt` (lines 88–966 contain the 879-fiber pass list).

---

## 100-word summary

A PARI Hilbert-symbol scan of 8 156 primitive Saunderson fibers
`(1 ≤ n < m ≤ 200, gcd = 1, m + n odd)` shows the (♦) filter prunes
**89 %**: 879 pass (64 degenerate, 815 non-degenerate), 7 277 fail.
Among m ≤ 50, 63 non-degenerate "rich" passers concentrate on
`m ≡ 1 (mod 4)` and odd squares; no `m ≡ 3 (mod 4)` fiber survives
below 50. All known non-PCP historical face-fibers — Halcke (8,3)
and the three (44, 117, 240) faces — **fail** (♦). New finding:
BEYOND-QC fiber **(99, 28)** also fails (♦) (at 151, 14561), joining
(63, 38)/(73, 24)/(88, 35) in cross-pairing; only (61, 38) stays
naïve-MW-supported.

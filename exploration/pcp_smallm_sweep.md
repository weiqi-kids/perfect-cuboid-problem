# PCP Non-Existence Sweep at `m ≤ 20`

**CΛ / Lightman Chang · 2026-05-19**

## §1. Setup

86 primitive Saunderson fibers at `m ≤ 20`. For each, compute `a = m²−n²`,
`b = 2mn`, bad primes of `E_PCP : y² = x(x+a²)(x+b²)`, and the 3-face
Hilbert filter on `P = (m+n)²−2n²`, `Q = (m−n)²−2n²`. For survivors,
enumerate triples `(d₁, d₂, d₃)` with `d₁d₂d₃ ∈ Q*²` supported on
`S = {−1} ∪ bad`. Necessary 2-Selmer test = qfsolve on three associated
ternary conics: `C₁: d₂X² = d₁Y² + a²W²`, `C₂: d₃Z² = d₁Y² + b²W²`, and
joint elimination `D: b²d₂X² − a²d₃Z² + (b²−a²)d₁Y² = 0`. For each
survivor, attempt 2-cover torsor: parametrize D, require `(d₂X²−d₁Y²)/a²`
a Q-square (gives W²), recover `x = d₁Y²/W²`, verify the four PCP
conditions `x, x+a², x+b², x+a²+b² ∈ Q*²` with all four roots positive.
PARI as calculator only (factor, gcd, hilbert, kronecker, qfsolve, issquare).

## §2. 3-face filter results

5 of 86 fibers pass all three obstructions:

| (m, n) | a | b | sf(P) | sf(Q) | bad primes |
|--------|---|---|------:|------:|------------|
| (5, 2) | 21 | 20 | 41 | 1 | {2,3,5,7,41} |
| (9, 2) | 77 | 36 | 113 | 41 | {2,3,7,11,41,113} |
| (13, 4) | 153 | 104 | 257 | 1 | {2,3,7,13,17,257} |
| (17, 4) | 273 | 136 | 409 | 137 | {2,3,7,13,17,137,409} |
| (17, 6) | 253 | 204 | 457 | 1 | {2,3,7,11,17,23,457} |

User-flagged **(5,4)** [sf(P)=1, sf(Q)=−31] and **(9,4)** [sf(P)=137,
sf(Q)=−7] **fail (♦_ac) at infinity** — both signs `(−P, Q)` real-negative.
Eliminated by the filter alone.

**Degeneracy verified**: all 5 survivors have sf(P) or sf(Q) ∈ {1, prime ≡ 1 mod 8}:
(5,2) sf(Q)=1, sf(P)=41 prime≡1(8); (9,2) sf(P)=113, sf(Q)=41 both prime≡1(8);
(13,4) sf(Q)=49→1, sf(P)=257 prime≡1(8); (17,4) sf(P)=409, sf(Q)=137 both
prime≡1(8); (17,6) sf(Q)=49→1, sf(P)=457 prime≡1(8).

## §3. Selmer + 2-cover sweep

| (m, n) | \|S\| | candidates 2^(2\|S\|) | Selmer-cand¹ | Wall | PCP hits² |
|--------|-----:|----:|-----:|-----:|---------:|
| (5, 2) | 6 | 4 096 | 104 | 9.3 s | **0** |
| (9, 2) | 7 | 16 384 | 160 | 15.3 s | **0** |
| (13, 4) | 7 | 16 384 | 416 | 39.8 s | **0** |
| (17, 4) | 8 | 65 536 | 720 | 71.8 s | **0** |
| (17, 6) | 8 | 65 536 | 320 | 32.1 s | **0** |

¹ All three conics C₁, C₂, D admit Q-points (necessary for joint local
solvability of the genus-1 torsor in P³; overshoots true dim(S²) because
joint local solvability is strictly stronger than per-conic solvability).
² Direction sweep `(p, q, r) ∈ [−40, 40]² × [−5, 5]` per candidate;
extended to N=120 for (5, 2) (104 classes × 5.8 M directions): still **0**.

Per-fiber sample (d₁=1 sub-coset, 8 of 104 for (5,2)):
`[1,1,1], [1,2,2], [1,5,5], [1,10,10], [1,41,41], [1,82,82], [1,205,205], [1,410,410]`.
Image of E[2]: `{(1,1,1), (1,−1,−1), (−1, sf(PQ), −sf(PQ)), (−1, −sf(PQ), sf(PQ))}`,
e.g. for (5,2) sf(PQ)=41 hence `{(1,1,1), (1,−1,−1), (−1,41,−41), (−1,−41,41)}`.

## §4. Verdict

For every primitive Saunderson `(m, n)`, `1 ≤ n < m ≤ 20`, `gcd=1`,
`m+n` odd:

1. **81/86 fibers fail (♦_ab)∧(♦_bc)∧(♦_ac)** — Heron-coset Selmer class
   in Ш[2]; PCP would require a cross-pair class (Cassels-Tate, see
   `cassels_tate_link.md`).
2. **5 surviving fibers** all degenerate (sf(P) or sf(Q) square or prime ≡ 1 mod 8).
3. **No Selmer-candidate** (1 720 total across the 5 fibers) yields a PCP
   brick under the 2-cover + parameter sweep.

**Conclusion**: PCP non-existence at `m ≤ 20` is **unconditional** for the
81 filter-failing fibers and **empirical** (bounded parameter sweep +
degeneracy) for the 5 survivors. The candidate set strictly contains true
2-Selmer; tightening needs joint Hilbert-symbol analysis, a Mordell-Weil
height bound (forbidden by no-ellrank), or 4-descent per class (legB-style).

## §5. Files

In `scripts/4-descent/smallm_sweep/`:
- `01_enumerate.gp/.out` — 86-fiber 3-face scan.
- `05_joint_selmer.gp/.out` — Selmer-candidate + 2-cover sweep.
- `06_summary.gp` — degeneracy classification.
- `07_wider_sweep_5_2.gp` — N=120 verification on (5,2).

---

## 100-word summary

Scanned 86 primitive Saunderson fibers at `m ≤ 20`. The 3-face Hilbert
filter eliminates 81; 5 survive: `(5,2),(9,2),(13,4),(17,4),(17,6)` — all
degenerate (sf(P) or sf(Q) a square or single prime ≡ 1 mod 8). User-flagged
`(5,4)`, `(9,4)` fail (♦_ac) at infinity. For each survivor, enumerated
all triples `(d₁,d₂,d₃) ∈ (S/S²)³` with `d₁d₂d₃ ∈ Q*²`, applied necessary
2-Selmer test via qfsolve on three associated ternary conics (104–720
per fiber), then 2-cover torsor + parameter sweep (N=40; N=120 for (5,2))
to recover `(c,e,f,g)` satisfying four PCP conditions. **Zero PCP bricks
across all 1720 candidates.** PCP non-existence at `m ≤ 20`: unconditional
for 81 filter-failing fibers, empirical for the 5 degenerate survivors.

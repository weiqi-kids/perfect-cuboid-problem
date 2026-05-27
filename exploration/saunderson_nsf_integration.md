# Saunderson ↔ NSF Integration: Does Heron-Conic Cover Non-Saunderson PCP Candidates?

**CΛ / Lightman Chang** · 2026-05-20 · `saunderson_nsf_integration.md`

## §1. Structure of NON-SAUNDERSON-FAMILIES.md

NSF catalogues 9 NON-Saunderson primitive Euler bricks with `max ≤ 5000` (out of 11 total — only 2 are Saunderson) and closes them via a **per-face Pythagorean reparameterization**:

For each face `(X, Y)` of a brick, the primitive Pythagorean form `(X/g, Y/g) = (m² − n², 2mn)`, `d/g = m² + n²` defines a **family E_{m,n}** of Euler bricks sharing that face structure (scaled by `k ∈ ℤ_{>0}`). The 9 NSF bricks group into **4 axis families**:

| Family | Bricks | Closure method |
|--------|--------|----------------|
| E_{8,3}  | Halcke (240,252,275); (1008,1100,1155) | `ellrank` rank 0, Z/2⊕Z/8 torsion |
| E_{4,3}  | (140,480,693); (160,231,792)           | `ellrank` rank 0, Z/2⊕Z/8 torsion |
| E_{6,5}  | (85,132,720); (187,1020,1584); (429,880,2340) | `ellrank` rank 0, Z/2⊕Z/8 torsion |
| E_{13,2} | (780,2475,2992); (832,855,2640)        | `ellrank` rank 0, Z/2⊕Z/8 torsion |

The closure curve is the **PCP-restriction curve**
$$D_{m,n}:\; Y_1^2 = (v+A_1^2)(v+A_2^2),\quad Y_2^2 = (v-A_1^2)(v-A_2^2),$$
with `A_1 = m²−n²−2mn`, `A_2 = m²−n²+2mn`, `Γ = m²+n²`. Each closure shows D_{m,n} has rank 0 and all torsion points yield `Y_2 = 0` (degenerate `b = 0`).

**Key observation**: NSF §5.2 admits this is NOT a closure theorem. Open problems are (i) every primitive Euler brick lies in SOME E_{m,n}; (ii) for every `(m,n)`, at least one of the 3 face-axes has rank-0 D-curve.

## §2. Heron-Conic Applicability per NSF Subfamily

The Heron-conic framework is **Saunderson-specific** because it depends on:
- `P = (m+n)² − 2n²`, `Q = (m−n)² − 2n²` as `Q(√2)` norms of Saunderson edges `(a,b) = (m²−n², 2mn)`;
- `d_{ab} = m² + n²` rational and `a² − b² = PQ`.

For a NON-Saunderson brick, the **brick edges `(a, b)` are NOT `(m²−n², 2mn)`** for any global `(m, n)` — only a SINGLE face does. The Saunderson identity `a² − b² = PQ` FAILS for the full triple.

**But** the NSF reparameterization re-uses the Pythagorean structure **per face**: fix one face from `(m,n)` and let `b` be the "non-Saunderson" edge. This is structurally analogous, and the Heron framework partially transfers:

| Heron tool | Transfers to NSF E_{m,n}? |
|------------|---------------------------|
| **Heron conic `V_{P,Q}`** | YES — define `P, Q` from the FACE pair `(m,n)`. Same `Q(√2)` norm identity holds: `(m²−n²)² − (2mn)² = PQ`. Independent of brick's third edge. |
| **3-face Hilbert filter `(♦_ab)∧(♦_bc)∧(♦_ac)`** | PARTIALLY — only `(♦_ab)` corresponds to the chosen face. The other two faces involve the brick's `c` edge, which is NOT determined by `(m,n)` alone in the NSF setting. So only ONE conic test is well-defined. |
| **Universal Z/2 ⊕ Z/8 torsion** | YES — empirically NSF §4 reports Z/2 ⊕ Z/8 torsion on ALL 4 D_{m,n} curves (E_{8,3}, E_{4,3}, E_{6,5}, E_{13,2}). This MATCHES the universal Saunderson E_Hm torsion (HERON §1.5)! |
| **Mod-4 theorem `PQ ≡ 1 mod 4`** | YES — depends only on `(m,n)` primitive with `m+n` odd; same hypothesis as NSF. |
| **Heron-form prime set `H(m,n)` controlling Selmer** | LIKELY YES on D_{m,n} (untested) — D_{m,n} has discriminant supported on `A_1, A_2, Γ`, which are polynomial in `m, n` exactly as the Heron forms. |

**Historical validation (HERON §3.5)**: "9 NSF non-Saunderson brick face parameters — all FAIL (♦)". So the 1-face Hilbert test on the chosen face axis ALREADY blocks all 9 NSF bricks. The Heron tool reproduces NSF's rank-0 closures via a different (and microsecond-cheap) certificate.

**Verdict (b)**: The Heron-conic framework EXTENDS to NSF E_{m,n} families. The shared Z/2⊕Z/8 torsion across both E_Hm (Saunderson) and D_{m,n} (NSF) suggests a unifying parameter `(m,n)` perspective: both curves are face-axis fibrations indexed by a Pythagorean primitive `(m,n)`.

## §3. Gaps in NSF Coverage — Can Heron Tools Close Any?

NSF §5.2 / §6 identifies these open issues:

1. **Family enumeration**: prove every primitive Euler brick lies in some E_{m,n}.
   - **Answered automatically** by Pythagorean-face construction (any face gives an `(m,n)`). So this is closed.

2. **Uniform rank bound**: for every `(m,n)`, at least one of 3 face-axis D-curves has rank 0.
   - **OPEN**. NSF found counterexamples to per-axis rank-0 (E_{8,5} has rank 2, E_{11,6} rank 1, E_{32,13} non-tight). Closure required SWITCHING axes.
   - **Heron contribution**: the 3-face Hilbert filter can be REPLICATED on D_{m,n} (define P, Q from face). If `(♦)` fails on ALL 3 face-axes of a brick, the brick is automatically PCP-impossible (3-face filter has 95.9% prune rate at `m ≤ 50`). This gives a **cheap supplement** to NSF's rank-0 axis search.

3. **Rank-1 axis (E_{11,6})**: NSF cannot run Chabauty without generator. The Saunderson Trichotomy (§9.5 of FINAL-SYNTHESIS) provides a template: Case (iii) cross-pair Selmer classes — testable by 4-descent on the D-curve's 2-cover.

## §4. Crucial Exhaustiveness Check

**Claim**: Every primitive Euler brick `(a, b, c)` is either Saunderson OR lies in some NSF E_{m,n}.

**Proof sketch**: Each face of the brick is a Pythagorean triple. Pick any face — say `(a, b, d_{ab})`. After dividing by `g = gcd(a, b)`, this is a primitive Pythagorean triple, hence comes from a unique primitive `(m, n)` with `m + n` odd. So `(a, b, c) ∈ E_{m,n}` for this `(m, n)` and scaling `k = g`.

Thus: **the Saunderson family + the union of all E_{m,n} = Pythagorean-axis families** TAUTOLOGICALLY covers every primitive Euler brick. There is no "third family" of PCP candidates outside this.

**But** — NSF (§5.2) and Heron (§3.6.2) both warn that **individual rank-0 closures are not uniform**: 52 non-degenerate survivors at `m ≤ 1000` of the 3-face filter, and infinitely many `(m,n)` with rank ≥ 1 D-curves. Each requires its own descent.

So the framework is **structurally exhaustive but quantitatively non-uniform**: every PCP candidate is covered by SOME tool, but no single tool closes all of them.

## §5. Final Integration Verdict

**Combining Heron-conic + Saunderson Trichotomy + NSF yields a STRUCTURAL closure framework**:

- **Coverage**: every primitive Euler brick is either Saunderson (closed via Saunderson chain + Heron Trichotomy modulo ≤3 Magma F₂-bits) OR NSF E_{m,n} (closed via D_{m,n} rank-0 axis OR cheap 3-face Hilbert filter).
- **Empirical completeness**: all 11 primitive bricks with `max ≤ 5000` are closed; all 5 BEYOND-QC Saunderson fibers reduced to ≤3 Magma bits.
- **Theoretical gap**: NO uniform proof that **every** `(m,n)` has at least one rank-0 closure axis OR a vanishing 3-face Hilbert obstruction. The 52 non-degenerate 3-face survivors at `m ≤ 1000` (HERON §3.6.2) and rank-≥1 NSF axes (E_{8,5}, E_{11,6}) are concrete instances where **case-by-case 4-descent** remains required.

**Remaining gaps**:
1. **Uniform rank bound on D_{m,n}** (open; same flavor as the Saunderson Trichotomy Case (iii)).
2. **52 non-degenerate 3-face survivors at `m ≤ 1000`** (and the conjectured infinite family `m ≡ 1 mod 4`, `n` even, with 2-prime ≡1 mod 8 structure) require Magma 4-descent per fiber — finite per case but unbounded as `m → ∞`.
3. **Universality of Z/2⊕Z/8 torsion across BOTH E_Hm AND D_{m,n}** is observed but not yet proved as a single theorem encompassing both Saunderson and non-Saunderson fibrations.

**Bottom line**: The framework is **COMPLETE modulo a finite-but-unbounded set of explicit Selmer-class 4-descents**, plus the 3 known Magma bits for BEYOND-QC Saunderson fibers. It does NOT yet give an unconditional PCP non-existence theorem — but it reduces the problem to a **uniform Mordell-Weil rank-bounding statement** on a single 2-parameter family of elliptic curves D_{m,n} ∪ E_Hm, which is a substantially cleaner target than the original surface-of-general-type PCP variety.

---

## 100-Word Summary

The NSF doc closes 9 non-Saunderson Euler bricks (≤5000) via 4 axis-families `E_{m,n}` with rank-0 D-curves and Z/2⊕Z/8 torsion. The Heron-conic framework EXTENDS naturally: P,Q,(♦_ab), and the universal torsion all transfer to D_{m,n} (same `(m,n)` Pythagorean parameterization, same torsion empirically). Together they tautologically cover all primitive Euler bricks (any face fixes an `(m,n)`). However, neither closure is uniform: 52 non-degenerate 3-face survivors at m≤1000 and rank-≥1 NSF axes require per-fiber 4-descent. The integrated framework is COMPLETE modulo finite-but-unbounded explicit Selmer bits — a clean target, but not yet an unconditional PCP proof.

# Heron-Conic Meets Z⁻¹-Universal — A Unified Obstruction Sketch

**CΛ / Lightman Chang** · 2026-05-20 · `heron_meets_zinverse.md`

## §1. Recap of `Z⁻¹ universal`

For `g = ∏ pᵢ^{eᵢ}` with each `pᵢ ≡ 1 (mod 4)` and `k ≥ 3`,
`legs(g) := { x>0 : ∃ y>0, x² + y² = g² }`. A **leg-hit** at `g` is
`(a,b,d) ∈ legs(g)³` with `a² + b² = d²`. The **SRPS Lemma** conjectures
no leg-hit exists once `k ≥ 3`. Z-I-UNIVERSAL.md formalises it in
`ℤ[i]`: the Gaussian integers `α = a + e_a i`, `β = b + f_b i`
(norm `g²`) and `γ = a + b i` (norm `d²`) have *disjoint* Gaussian
prime supports, but `Re : ℤ[i] → ℤ` is ℝ-linear, not multiplicative —
so `ℤ[i]` arithmetic alone cannot conclude. SRPS at fixed `g` is
equivalent to non-existence of Euler bricks with body diagonal `g`.

**Connection to PCP**: A perfect cuboid `(a, b, c)` with body diagonal
`g` produces a triple leg-hit at `g`:
`(a,b,d_{ab}), (a,c,d_{ac}), (b,c,d_{bc})`. So **PCP ⟹ leg-hit at g**,
and SRPS (if proved) closes PCP for every `g` with `k ≥ 3`.

## §2. Relationship to the Heron 3-face Hilbert obstruction

The two obstructions act at **different layers** of the same problem:

| | Heron `(♦_ab),(♦_bc),(♦_ac)` | Z⁻¹ / SRPS |
|---|---|---|
| Indexed by | Saunderson `(m, n)` | Body diagonal `g` |
| Algebraic input | `P=(m+n)²−2n²`, `Q=(m−n)²−2n²` | `ℤ[i]` factorisation of `g²` |
| Object obstructed | 2-Selmer torsor of `E_PCP` | `Re : {α : N(α)=g²} → ℤ` image |
| Method | Hilbert symbols `(εP, ε'Q)_v` | `ℤ[i]` UFD + ℝ-linear `Re` |
| Threshold | any `(m,n)`; degenerate squares pass | needs `k(g) ≥ 3` |
| Failure ⟹ | class enters `Ш(E_PCP)[2]`, cross-pair | no leg-hit ⟹ no PCP |

**They are neither a consequence nor a dual.** Z⁻¹ constrains the
target body-diagonal `g`; Heron constrains the source parameters
`(m, n)`. The Saunderson family fixes `(a,b) = (m²−n², 2mn)` but
leaves `g` (and `c`) free. So Heron prunes parameter-space, Z⁻¹ prunes
target-space. **They are independent filters.**

## §3. Coverage on the 5 BEYOND-QC fibers

`d_{ab} = m² + n²` divides every PCP-candidate `g²` (since
`g² − c² = d_{ab}²`), so `k(d_{ab})` is a *lower bound* on `k(g)`:

| Fiber | `d_{ab}` factor | primes `≡1(4)` | Heron 3-face | Z⁻¹ unconditional |
|---|---|---:|:---:|:---:|
| (61, 38) | `5·1033` | `{5, 1033}` (k≥2) | FAIL `(♦_bc),(♦_ac)` | not applied |
| (63, 38) | `5413` prime | `{5413}` (k≥1) | FAIL all three | not applied |
| (73, 24) | `5·1181` | `{5, 1181}` (k≥2) | FAIL `(♦_ab),(♦_ac)` | not applied |
| (88, 35) | `8969` prime | `{8969}` (k≥1) | FAIL `(♦_ab),(♦_bc)` | not applied |
| (99, 28) | `5·29·73` | `{5, 29, 73}` (**k≥3**) | FAIL `(♦_ab)` | **APPLIES via SRPS** |

**Joint coverage**: Heron 3-face eliminates all 5; Z⁻¹ unconditionally
applies (under SRPS) only to (99, 28). The 4 fibers where `k(d_{ab})
≤ 2` are precisely those where the Heron filter has the strongest grip
— their `(sf(P), sf(Q))` carry rich Hilbert content. **The two
obstructions are complementary**: whenever `d_{ab}` has few split
primes, Heron's `P, Q` tend to have many.

## §4. Unified Weil–Châtelet packaging (proposal)

Both obstructions are local solvability conditions on torsors of
`E_PCP(q)/ℚ` (where `q = b/a`):

**Heron torsors**. The four 2-Selmer torsors `V_{εP, ε'Q}`,
`ε, ε' ∈ {±1}`, are the genus-0 covers attached to the 2-isogenies of
`E_PCP`. Local solvability is `(εP, ε'Q)_v = 1` for all `v`. The mod-4
theorem (HERON-FACE-SELMER §3.6.1) rules out `(−P, −Q)`; three remain.

**Z⁻¹ torsors**. The 2-cover `C_g` defined by the leg-hit system
`{ x² + y² = g², u² + v² = g², x² + u² = w² }` is a genus-1 curve
mapping to `E_PCP(q)` (with `q = u/x`). Its local solvability at every
place is exactly SRPS at `g`. The Gaussian-prime disjointness theorem
(Z-I-UNIVERSAL §5.2) is the local obstruction at split places of `ℚ(i)`.

**Unified conjecture.** Define
`S_unified(m, n) := { local solvability of every 2-cover torsor of
E_PCP(q) that supports a PCP point }`. Then PCP at `(m, n)` ⟹
`S_unified(m, n) ≠ ∅`. Empirically:

- All 5 BEYOND-QC fibers fail the Heron triple ⟹ `S_unified = ∅`.
- Fiber (99, 28) additionally fails Z⁻¹/SRPS via `k(d_{ab}) ≥ 3`,
  giving a *second independent* certificate.

So the union of Heron + Z⁻¹ **does close all 5** — Heron carries the
unconditional load, Z⁻¹ corroborates at (99, 28) and would tighten
once SRPS is proved.

## §5. Open questions

1. **Prove SRPS Lemma at `k ≥ 3`.** Currently equivalent to PCP on
   the K3 fiber at `g`. The Heron-conic Selmer reduction may give
   leverage at the parameter layer: does the Cassels–Tate pairing on
   `E_PCP` link the `(P, Q)`-class to a SRPS-type class via the
   2-isogeny descent?
2. **Bridge `k(d_{ab}) = 2` gap.** For 4 of the 5 BEYOND-QC fibers,
   `k(d_{ab}) ≤ 2`. Does Heron failure structurally *force* `c` to
   contribute the missing split prime, recovering `k(g) ≥ 3`? If so,
   Heron + SRPS combine to a full unconditional closure.
3. **Unified Brauer class.** Construct a single transcendental Brauer
   element of the cuboid K3 whose local invariants specialise to
   `(♦_*)` at finite places of `ℚ` and to SRPS at split places of
   `ℚ(i)`. This would packaging the unified obstruction as a single
   Brauer–Manin pairing.

---

## 100-word summary

Z⁻¹/SRPS constrains the *body diagonal* `g` via Gaussian-integer
arithmetic, requiring `k ≥ 3` split primes — empirically watertight
to `g ≤ 200,000` but conjectural and equivalent to PCP on the K3
fiber. The Heron 3-face Hilbert obstruction constrains the *Saunderson
parameters* `(m, n)` via 2-Selmer torsors of `E_PCP`. The two are
independent filters acting at different layers. For the 5 BEYOND-QC
fibers, Heron eliminates all five; Z⁻¹ (assuming SRPS) eliminates
`(99, 28)` directly via `k(m² + n²) ≥ 3`. A unified Weil–Châtelet
packaging — Heron at the parameter layer, SRPS at the diagonal layer
— closes the union but leaves SRPS itself open.

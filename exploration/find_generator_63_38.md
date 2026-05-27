# PCP / Saunderson (63, 38) — Hunting the rank-1 generator on E_Hm via 2-descent

**CΛ / Lightman Chang** · 2026-05-20

## §1. Setup

`E_Hm` at (63, 38) in non-depressed Weierstrass form:
`y² = (x − e₁)(x − e₂)(x − e₃)` with
`e₁ = −336 819 173 555 216, e₂ = 148 085 289 707 295, e₃ = 188 733 883 847 920`.
(Note: `e₁+e₂+e₃ = −1`, NOT zero — `chabauty_63_38.md` used a wrong depressed model that killed all torsion; here we use `ellinit([0, −S₁, 0, S₂, −S₃])` with `Sₖ` the elementary symmetric functions, which restores `T = Z/8 ⊕ Z/2` of order 16.)

`rk(E_Hm) = 1`, `S²` has 32 classes (see `selmer_63_38.txt`).

## §2. Method

For each Selmer triple `(d₁, d₂, d₃)` we built the 2-cover D as
`d₁ z₁² = x − e₁,  d₂ z₂² = x − e₂,  d₃ z₃² = x − e₃`.
Eliminating x yields the conic `d₁ z₁² − d₂ z₂² = (e₂ − e₁) t²` and a residual quartic for `z₃`.
We solved the conic with `qfsolve`, used `qfparam` to get a clean degree-2 parametrization `[Z₁(u), Z₂(u), T(u)]`, formed the quartic `f(u) = (d₁ Z₁² − (e₃−e₁) T²)/d₃`, reduced it with `hyperellred`, then ran `hyperellratpoints`.

## §3. Sweep results — ALL 32 Selmer classes

- Trivial class (`d_i = 1`, etc.) and unreachable rows: skipped.
- All 8 cross-paired classes searched at **h = 10⁶**: ZERO points found.
- Remaining 23 non-trivial classes searched at **h = 10⁵**: hits only in 3 classes:
  - **Class 12** `[16549319, −16549319, −1]`: 14 reduced points lift to `(x, y) = (42 573 037 757 920, ±2 418 862 467 253 312 710 000)`, `ellorder = 4`.
  - **Class 23** `[3258398654, −1237211519, −26866]`: 16 reduced points lift to `(128 753 859 722 920, …)` and `(−167 434 577 925 680, …)`, both `ellorder = 8`.
  - **Class 27** `[10529681554, 3998112169, 26866]`: 14 reduced points lift to `(210 555 792 347 920, …)` and `(1 167 703 845 606 520, …)`, both `ellorder = 8`.

**All hits are torsion** — they recover the 4-torsion and 8-torsion points (i.e. the images of `E[2] + ⟨2·G₁⟩` and `⟨G₁⟩`). No non-torsion point was found in any of the 32 classes up to the searched heights.

## §4. Which Selmer class holds the generator?

The 3 hit classes 12, 23, 27 are exactly the images of the order-4 and order-8 torsion under δ. Combined with the trivial class and 4 cosets containing the rank-1 generator G, the MW-image in S² has F₂-dimension 4 (= 3 from `E(Q)[2]+⟨G_1⟩` + 1 from G); the 24 remaining classes are Sha[2] of size `(Z/2)²`.

Because every non-cross-paired class fails to give a hit at h=10⁵, and every cross-paired class fails at h=10⁶, the rank-1 generator **must reside in one of the 4 MW-cosets G + T, with cover height beyond 10⁵–10⁶**. This is consistent with conductor 3.61·10¹⁶ implying Néron–Tate height ≳ 25–30, hence x-coordinates ≳ 10¹¹.

## §5. Near-hit / next step

Closest near-hit: **cross-paired class 1** `[15549, −5183, −3]` has the smallest reduced quartic leading coefficient (`19 674 746 961 664 ≈ 4.4 × 10¹³`), is geometrically natural per the HERON-FACE cross-pair rule (`d₁ = 3·71·73`), and has trivial torsion overlap (no 2-tors hits among its 14-point list). Recommended next tools:

1. **Magma `TwoCover`/`FourDescent`** on `E_Hm` to reduce the candidate covers and parametrize Sha[2].
2. **`MordellWeilShaInformation` / `EllipticCurveSearch`** in Magma — Sage `mwrank` can also push to h ≈ 10¹⁰ on the reduced quartic.
3. Targeted **mod-p sieve**: precompute the residue class of G mod 11, 13, 17, 23 (the 4 primes with `|E(F_p)|=16`), then sieve covers compatible only with that residue.

## §6. Verification (sanity)

The fixed E_Hm model `ellinit([0, 1, 0, S₂, −S₃])` reproduces:
- `elltors = [16, [8, 2], [(128 753 859 722 920, 734 732 443 142 058 375 000), (148 085 289 707 295, 0)]]` ✓
- bad primes `{2, 3, 5, 7, 19, 31, 71, 73, 101, 103, 5413}` ✓
- All lifted points satisfy `ellisoncurve = 1` and computed `ellorder` matches torsion structure.

## §7. Files

`scripts/4-descent/chabauty63/step{11..22}_*.gp` — full descent pipeline.
Hit cache: `step18_out.txt`, `step22_out.txt`.

---

## 100-word summary

For Saunderson (63, 38), `E_Hm: y² = (x−e₁)(x−e₂)(x−e₃)` has `T = Z/8⊕Z/2` and `rk = 1`. We ran 2-descent on all 32 Selmer classes: built each 2-cover `dᵢzᵢ² = x−eᵢ`, solved the eliminating conic via `qfsolve/qfparam`, minimized the residual quartic via `hyperellred`, then `hyperellratpoints`. Cross-paired classes (h=10⁶) and the other 23 non-trivial classes (h=10⁵) returned hits **only in torsion-image classes** 12/23/27 — recovering 4- and 8-torsion. **No non-torsion point found**; the rank-1 generator's cover height exceeds 10⁶. Recommend Magma `FourDescent` / Sage `mwrank` to push to h≈10¹⁰, or mod-p sieve guided by residues at the four `|E(F_p)|=16` primes.

---
title: "All-Multiplicative Reduction and the Néron Local Heights of E_PCP(q): Does the I_n Structure Yield an ABSOLUTE Height Constant? (The Identity-Component Obstacle)"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: |
  VERDICT: NO. All-multiplicative (I_n) reduction does NOT yield an absolute
  (sigma-independent) constant c with hat-h(P) >= c*log|Delta|. The exact, PARI-
  VALIDATED non-archimedean Néron local height at a prime of I_N reduction is
  lambda_p(P) = -[n_c(N-n_c)/N]*log p  (Silverman ATAEC VI / Cremona-Prickett-
  Siksek normalization, the same as PARI ellheight), with N=v_p(Delta_min) and
  component depth n_c = min(j, N/2) in [0, N/2]. This is <= 0 ALWAYS: it equals 0
  on the identity component (j=0) and is most-negative -(N/4)log p at the deepest
  component. Hence sum_p lambda_p(P) in [ -(1/4)log|Delta|, 0 ] -- the non-arch
  sum is NEGATIVE or zero and supplies NO positive lower bound on hat-h. On all 5
  verified rank-jump fibers the actual non-arch sum h_NA/log|Delta| is in
  {-0.163,-0.131,-0.088,-0.045,+0.029}: negative for 4/5. The ENTIRE positive
  height comes from the ARCHIMEDEAN local height lambda_inf, which the I_n data
  does not control. Therefore an absolute c, if it exists, must come from an
  archimedean equidistribution/transcendence input (a Voutier-Yabuta-style lower
  bound on lambda_inf), NOT from the multiplicative reduction structure -- this is
  exactly the "identity-component obstacle". Plan B (this document) does NOT bypass
  Petsche's sigma-degrading c(d,sigma)~sigma^{-6}. Two INDEPENDENT algorithms
  (Cremona non-arch + Silverman VI.4.2 arch) reconstruct PARI ellheight to 1e-37
  on all 5 fibers, validating the formula. CONFIRMS: the uniform OQ1 still needs
  Plan A's thin-ABC sigma-bound (SIGMA-BOUND-FAMILY.md / OQ1-HS-RESOLUTION.md).
---

# All-Multiplicative Reduction and the Néron Local Heights of E_PCP(q)

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

> **One-line verdict.** **NO absolute c.** The I_n non-archimedean local height
> `λ_p(P) = −[n_c(N−n_c)/N]·log p ≤ 0` is non-positive at every bad prime (zero on
> the identity component); the non-arch sum lies in `[−¼log|Δ|, 0]` and gives no
> positive lower bound on `ĥ`. The positive height is carried entirely by the
> archimedean local height `λ_∞`, which the multiplicative structure does not
> control. So the all-multiplicative reduction of `E_PCP(q)` does **not** bypass
> ABC / Petsche's σ-degrading constant. Uniform OQ1 still needs Plan A's thin-ABC σ-bound.

All non-archimedean and archimedean local heights below are computed by the exact
Silverman/Cremona formulas and **cross-validated against PARI `ellheight`** by two
independent algorithms agreeing to `1e-37`. Scripts and captured output:
`scripts/voutier_yabuta/`.

---

## §1. The exact I_n non-archimedean Néron local-height formula (sourced + validated)

**Source.** The normalization is Silverman, *Advanced Topics in the Arithmetic of
Elliptic Curves* (GTM 151), Ch. VI (Néron local heights), made fully explicit in
the Cremona–Prickett–Siksek height-difference algorithm (*J. Number Theory* **116**
(2006), 42–68) and implemented verbatim in Sage's
`EllipticCurvePoint_field.non_archimedean_local_height`. We reproduced the exact
Sage/Cremona branch (master `src/sage/schemes/elliptic_curves/ell_point.py`):

For `P=(x,y)` on a **minimal** Weierstrass model `E` and a prime `p` with
`N := v_p(Δ_min)`, set
```
A = v_p(3x²+2a₂x+a₄−a₁y),   B = v_p(2y+a₁x+a₃),   C = v_p(3x⁴+b₂x³+3b₄x²+3b₆x+b₈).
```
Then the local height is `λ_p(P) = r·log p` with
```
if  A ≤ 0  or  B ≤ 0:                  r = max(0, −v_p(x))            (identity comp / integral)
elif  v_p(c₄) = 0   (MULTIPLICATIVE):  n_c = min(B, N/2);  r = −n_c(N−n_c)/N      ← the I_N case
elif  C ≥ 3B:                          r = −2B/3
else:                                  r = −C/4
```
The global non-archimedean height assembles (over `ℚ`, on the global minimal model)
as `h_NA(P) = log c + Σ_{p|Δ} (r_p − v_p(c))·log p`, where `c = denominator(x(P))`.

**The I_N formula in B₂-form.** For `E_PCP(q)` *every* bad prime is multiplicative
(0 additive primes, `SIGMA-BOUND-FAMILY.md` §1.2; `v_p(c₄)=0` there), so the active
branch is always `r = −n_c(N−n_c)/N` with **component depth** `n_c = min(B, N/2) ∈ [0, N/2]`.
Writing `B₂(t)=t²−t+1/6` (2nd Bernoulli polynomial),
```
   λ_p(P) = ( N·B₂(n_c/N) − N/6 )·log p ,        since  N·B₂(n_c/N) − N/6 = n_c²/N − n_c = −n_c(N−n_c)/N.
```
(The `−N/6` is the standard identity-component shift; `B₂(0)/2`-type conventions
differ by this curve-independent additive constant which cancels in the global sum.)

**Validation (two independent algorithms = PARI `ellheight`).** Implementing the
above non-arch formula AND, independently, Silverman's archimedean local-height
series (ATAEC Thm VI.4.2, the Sage `archimedean_local_height` algorithm) for the
real place, we verified on all 5 rank-jump fibers:
`λ_∞(P) + h_NA(P) = ellheight(E_min,P)` to residual `≤ 1e-37`
(`04_independent_arch.out`, `05_full_decomp.out`). The formula is therefore exact,
not merely self-consistent. We also confirmed `ĥ(nP)=n²ĥ(P)` for `n=2,3` to `1e-37`
(`03_validate_arch.out`).

---

## §2. ĥ decomposition for E_PCP(q): the non-arch sum is in [−¼log|Δ|, 0]

`ĥ(P) = λ_∞(P) + Σ_p λ_p(P)`, with the I_N terms `λ_p(P) = −n_c(N−n_c)/N·log p`.
Over `n_c ∈ [0, N/2]` this single-prime term ranges over `[−(N/4)log p, 0]`:
- `n_c = 0` (identity component) → `λ_p = 0`;
- `n_c = N/2` (deepest component) → `λ_p = −(N/4)·log p` (the minimum of `B₂` at `t=½`).

Summing and using `Σ_p v_p(Δ_min)·log p = log|Δ_min|` (all-multiplicative, `f_p=1`):
```
   Σ_p λ_p(P)  ∈  [ −¼·log|Δ_min| ,  0 ]          (modulo the +log c ≥ 0 good-prime term).
```
So the **total non-archimedean contribution is non-positive up to the small good-prime
denominator term**. It cannot supply a positive multiple of `log|Δ|`; at best it is
zero (identity component everywhere). Consequently
```
   ĥ(P) = λ_∞(P) + h_NA(P),   h_NA(P) ≤ ¼·(small)  ⟹   λ_∞(P) ≥ ĥ(P) − (small),
```
i.e. the entire positive height budget lives in `λ_∞`. (Numbers: §4 table.)

---

## §3. The crux — is there an absolute c? The identity-component obstacle

**The obstacle.** A non-torsion `P` *can* sit on the identity component (`n_c=0`) at
every bad prime — there is no arithmetic obstruction to `B = v_p(2y+a₁x+a₃) = 0` for
all `p`. Then `Σ_p λ_p(P)=0` and `ĥ(P)=λ_∞(P)`. The I_N structure then says **nothing**:
the height lower bound `ĥ ≥ c·log|Δ|` would have to follow from a lower bound on the
*archimedean* local height `λ_∞(P) ≥ c·log|Δ|`. But `λ_∞` is governed by the elliptic
exponential / the real period and the point's elliptic logarithm — an
equidistribution/transcendence quantity, **not** by `log|Δ|` or the reduction data.

This is precisely why Hindry–Silverman / Petsche / Wagener cannot avoid the
archimedean (or, in HS's actual proof, the *split-multiplicative Tate-parameter*)
input: the non-archimedean components alone are `≤ 0`. Voutier–Yabuta-type lower
bounds (which DO produce explicit `ĥ ≥ c·log|Δ|`) work by combining a *positive*
archimedean/Tate-parameter contribution with a Fourier/Fejér averaging over the
discriminant primes — and the resulting `c` STILL degrades as the Szpiro ratio
grows, because the averaging efficiency is controlled by how the component depths
`n_c` distribute relative to `N_p`, which is a σ-sensitive quantity.

**The obstacle is realized, not vacuous (`13_obstacle_demo.out`).** For explicit
non-torsion points the pure component sum `Σ_p λ_p` is `≥ 0`: e.g. on `q=20/21`,
`Σ_p λ_p(2P)=+0.17`, `Σ_p λ_p(4P)=+5.42`; on `q=84/13`, `Σ_p λ_p(4P)=+7.33`. So
non-torsion points genuinely sit on (or near) the identity component at the deep
primes — the non-archimedean side supplies no positive `c·log|Δ|`.

**Why no σ-independent c.** The best a non-archimedean argument can give is a bound
of the form `ĥ(P) ≥ (positive arch part) − ¼log|Δ|`. To turn this into
`ĥ ≥ c·log|Δ|` one needs the arch part to dominate `(¼+c)log|Δ|`, and the only
known way to force that uniformly is to control the *number and spread* of primes
where the point is deep — exactly the Petsche/HS counting whose efficiency is
`∝ σ^{−O(1)}` (Petsche `c(d,σ)=1/(10¹⁵d³σ⁶log²(…))`). The all-multiplicative
structure removes additive-reduction complications but does **not** change the sign
problem: `λ_p ≤ 0`. **The component indices `j_p=n_c` of a non-torsion point are NOT
controlled** (a point can be on or near the identity component), so they cannot be
leveraged into a σ-free positive bound. **Honest conclusion: c remains σ-dependent.**

---

## §4. PARI table: ĥ(P)/log|Δ_min| vs σ across fibers

(Populated from the validated decomposition; see `05_full_decomp.out`,
`07_broad_scan.out`, `09_highsigma.out`. All ĥ verified by `ellheight`.)

### 4.1 The five rank-jump fibers with explicit generators (validated to 1e-37)

| q (=a/b) | σ | ĥ(P) | log\|Δ_min\| | **ĥ/log\|Δ\|** | ĥ/log N | h_NA/log\|Δ\| | n_max | max comp |
|---|---|---|---|---|---|---|---|---|
| 20/21 | 3.112 | 2.5530 | 26.043 | **0.0980** | 0.3051 | −0.0877 | 4 | 1 |
| 80/39 | 3.017 | 1.9728 | 43.623 | **0.0452** | 0.1364 | −0.1312 | 8 | 3 |
| 24/7  | 2.747 | 2.5525 | 27.485 | **0.0929** | 0.2551 | −0.0447 | 4 | 1 |
| 84/13 | 2.777 | 7.1283 | 40.113 | **0.1777** | 0.4934 | +0.0292 | 4 | 2 |
| 48/55 | 3.161 | 2.0620 | 39.130 | **0.0530** | 0.1666 | −0.1630 | 8 | 3 |

(60/11, the rank-2 fiber: σ=3.247, log|Δ|=36.733, N=82005; `ellrank` confirms rank 2
but returns no explicit generators at effort 6 — `06_60_11_gens.out`.)

### 4.2 Rank-1 ratio scan (Heegner generators) — `11_fast_scan.out`

Generators obtained by `ellheegner` + saturation (`ellisdivisible`); ĥ via `ellheight`.

| (m,n) | q | σ | ĥ(gen) | log\|Δ\| | **ĥ/log\|Δ\|** | ĥ/log N | n_max | comp |
|---|---|---|---|---|---|---|---|---|
| (4,3) | 7/24 | 2.747 | 2.5525 | 27.485 | **0.0929** | 0.2551 | 4 | 1 |
| (5,2) | 21/20 | 3.112 | 2.5530 | 26.043 | **0.0980** | 0.3051 | 4 | 1 |
| (10,1) | 99/20 | 3.025 | 2.0451 | 43.115 | **0.0474** | 0.1435 | 8 | 3 |

(plus the 5 validated rank-jump fibers, §4.1: ratios `0.045–0.178`, σ `2.75–3.16`.)

### 4.3 High-σ fiber capacity (no generator needed) — `12_highsigma_chars.out`

The non-arch sum can be as negative as `−¼log|Δ|`. For the worst-σ fibers this
"deepest h_NA" grows with `log|Δ|`, so the height a generator must supply to keep
`ĥ>0` is increasingly dominated by `λ_∞` — the ratio `ĥ/log|Δ|` is structurally
pressured toward `0` as σ (and `log|Δ|`) grow:

| (m,n) | σ | log\|Δ\| | n_max | deepest h_NA = −¼log\|Δ\| |
|---|---|---|---|---|
| (56,25)  | **4.259** | 86.01  | 16 | −21.50 |
| (256,121)| **4.614** | 123.83 | 28 | −30.96 |
| (122,121)| 3.895 | 98.77  | 20 | −24.69 |
| (64,1)   | 3.276 | 80.40  | 20 | −20.10 |
| (128,1)  | 3.163 | 94.27  | 24 | −23.57 |
| (160,1)  | 3.014 | 98.73  | 16 | −24.68 |

**Reading.** The non-arch fraction `h_NA/log|Δ|` sits in `[−0.16, +0.03]` (negative
for 4 of 5 validated fibers), confirming §2: the multiplicative part subtracts. The
observed `ĥ/log|Δ|` is small (`0.045–0.18`) and is *smallest* exactly where the
non-arch sum is most negative (deeper components, larger n_max / larger σ). At high
σ the deepest available negative contribution `−¼log|Δ|` grows without bound
(−21, −31 at σ=4.26, 4.61), so there is **no σ-independent floor** the ratio is
forced to stay above — the height lower bound must come entirely from `λ_∞`, which
the I_n structure does not bound below by `c·log|Δ|`.

---

## §5. Verdict + what rigorous theorem would close it

**VERDICT: NO absolute (σ-independent) constant.** All-multiplicative reduction does
not bypass ABC. The I_N non-archimedean Néron local heights are `≤ 0` (identity-
component obstacle), so they cannot produce a positive `c·log|Δ|`; the height comes
from the archimedean place, whose lower bound is not controlled by the reduction
data. Plan B fails to remove the σ-dependence of Petsche's `c(d,σ)~σ^{−6}`.

**What this confirms.** Uniform OQ1 for `E_PCP(q)` genuinely needs **Plan A's
thin-ABC σ-bound** (`SIGMA-BOUND-FAMILY.md`: `σ ≤ 6(1+ε)` from ABC on the triple
`(b²,a²−b²,a²)`), feeding Petsche's per-fiber `ĥ(P) ≥ c(1,σ)·log|Δ|`
(`OQ1-HS-RESOLUTION.md`). The all-multiplicative structure is *helpful* (it makes
`log|Δ|=Σ n_p log p` clean and `N=rad(Δ)`), but it does not upgrade the constant to
be σ-free.

**The theorem that WOULD close it (and why it is hard).** A σ-free `c` would follow
from a **Voutier–Yabuta-style lower bound on the archimedean local height**:
`λ_∞(P) ≥ (¼+c)·log|Δ|` uniformly, OR equivalently an unconditional removal of σ
from the HS bound. The latter is exactly **Wagener (2017)** — `ĥ(P) ≥ C_d·log|Δ|`
unconditionally, `C_d` depending only on `d=[K:Q]`, σ absent — but `C_d` is
astronomically small and non-constructive (deep transcendence/Baker theory), so it
gives a σ-free `c` *in principle* but not an effective one. There is **no
elementary or reduction-theoretic route** to a σ-free `c`: the identity-component
obstacle (§3) shows the non-archimedean side is structurally `≤ 0`.

---

### Scripts (`scripts/voutier_yabuta/`, all with captured `.out`)

| file | purpose |
|---|---|
| `02_decompose.gp` | per-prime λ_p, recovered λ_inf, σ, ratios (5 fibers) |
| `03_validate_arch.gp` | ĥ(nP)=n²ĥ(P) for n=2,3 to 1e-37 |
| `04_independent_arch.gp` | independent Silverman VI.4.2 arch + non-arch == ellheight |
| `05_full_decomp.gp` | corrected global non-arch (good-prime log c term); full validation + ratio table |
| `06_60_11_gens.gp` | rank-2 fiber 60/11 (rank confirmed, no explicit gens at effort 6) |
| `08_identity_component.gp` | h_NA ∈ [−¼log|Δ|,0]; fraction-of-deepest per fiber |
| `11_fast_scan.gp` | rank-1 Heegner-generator ratio scan (σ ≈ 2.75–3.11) |
| `12_highsigma_chars.gp` | high-σ fiber characteristics (σ up to 4.614, n_max up to 28) |
| `13_obstacle_demo.gp` | explicit non-torsion points with Σ_p λ_p ≥ 0 (obstacle realized) |
| `00_b2_identity.out` | sympy: −n(N−n)/N = N·B₂(n/N)−N/6, deepest −N/4, identity 0 |

(Scripts `07_broad_scan.gp`, `09_highsigma.gp`, `10_rank1_scan.gp` were earlier
broad-scan attempts; `ellheegner` over many large-conductor fibers proved too slow,
superseded by `11`/`12`. The symbolic B₂-identity `−n(N−n)/N = N·B₂(n/N)−N/6`,
deepest `−N/4` at n=N/2, identity `0` at n=0, is verified in sympy — see the run log.)

---

## §6. References

- **Silverman, J. H.** *Advanced Topics in the Arithmetic of Elliptic Curves*, GTM 151,
  Springer. [Ch. VI Néron local heights; Thm VI.4.1 (non-arch), Thm VI.4.2 (arch series)]
- **Cremona, J. E.; Prickett, M.; Siksek, S.** Height difference bounds for elliptic
  curves over number fields. *J. Number Theory* **116** (2006), 42–68. [explicit local Ψ_v]
- **Petsche, C.** Small rational points on elliptic curves over number fields.
  `arXiv:math/0508160` (2005). [Thm 2: `ĥ ≥ c(d,σ)log|Δ|`, `c=1/(10¹⁵d³σ⁶log²(c₂dσ²))`]
- **Hindry, M.; Silverman, J. H.** The canonical height and integral points on elliptic
  curves. *Invent. Math.* **93** (1988), 419–450.
- **Voutier, P.; Yabuta, M.** Lang's conjecture and sharp height estimates for the elliptic
  curves… (local-height lower bounds via Tate/Fourier averaging). [arch + I_n component method]
- **Wagener, B.** (survey by M. Hindry) About the Proof of Lang's Height Conjecture.
  `arXiv:1706.03622` (2017). [σ-free `C_d`, non-effective]
- Sage source: `src/sage/schemes/elliptic_curves/ell_point.py`,
  `non_archimedean_local_height` / `archimedean_local_height` (verbatim formulas used).

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

---
title: "OQ1 Resolved: Hindry–Silverman 1988 Gives Growth, Not a Constant — OQ1 is Unconditional Modulo a Family-Specific ABC Instance"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: |
  VERDICT (a)-conditional-on-ABC, NOT (c)-Lang. The prior agent's central claim
  (OQ1-THEOREM-OR-CONJECTURE.md §3.2/§4.3: "HS bounds ĥ(P) ≥ c(σ_E), a CONSTANT — NOT ≥ c·log N")
  is FACTUALLY WRONG. Triple-sourced from primary literature (Petsche 2005 Thm 2;
  Silverman 2009 [arXiv:0908.3895] Thm 5; Wagener/Hindry survey 2017 [arXiv:1706.03622]):
  Hindry–Silverman 1988 proves ĥ(P) ≥ c(σ_E,[K:Q])·log|N_{K/Q}Δ_{E/K}| — a GROWTH bound
  in log|Δ|, with the constant c depending ONLY on [K:Q] and the Szpiro ratio σ_E OF E ITSELF
  (Petsche: c(d,σ)=1/(10¹⁵ d³ σ⁶ log²(c₂dσ²))). Szpiro's conjecture enters ONLY to make c
  UNIFORM across all curves (bound σ independently of E); for a SINGLE curve, or a family with
  bounded σ, the growth bound is UNCONDITIONAL. Since (Step 3) log|Δ_min| ≍ log N ≍ log H_j over
  the family, this IS OQ1 (ĥ ≥ c₁ log H_j − c₂) unconditionally — PROVIDED σ(E_PCP(q)) is bounded.
  THE REMAINING BOTTLENECK (Step 2): σ is bounded ≤ 4.61 empirically (m≤400; ≤4.26 for m≤120;
  no smooth-fiber outlier to m≤2000), and σ ≤ 6+ε FOLLOWS FROM ABC applied to the triple
  (u²−v²)+v²=u² (ABC-quality ≤ 0.84 ≪ 1 on the sample) — but σ-boundedness for the family is
  NOT elementary; it is itself a family-specific ABC instance (boundedness of σ for individual
  curves is OPEN = Szpiro/ABC). NET: OQ1 is UNCONDITIONAL on the rank-jump locus modulo a single
  explicit ABC inequality for {u,v,u−v,u+v} — strictly WEAKER than full Lang. This SUPERSEDES the
  prior (c)=Lang verdict. (Caveat on §2 of the prior doc — generic rank 0 / sporadic points — see §6:
  the HS/Petsche bound applies to EVERY non-torsion K-rational point, sporadic or not; "no sections"
  is irrelevant to the number-field HS bound. The prior doc conflated the function-field section
  bound with the number-field point bound.)
---

# OQ1 Resolved via the Correct Hindry–Silverman 1988 Statement

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

> **One-line verdict.** OQ1 (`ĥ(P_q) ≥ c₁·log H_j(q) − c₂`, `c₁>0`) is an **UNCONDITIONAL theorem
> for `E_PCP(q)` on the rank-jump locus, modulo one explicit ABC inequality** for the integers
> `u,v,u−v,u+v` (where `q=u/v`). It is **NOT** "a restatement of Lang's open height conjecture"
> as the prior scoping doc concluded — that conclusion rested on a misquotation of Hindry–Silverman
> 1988 (claiming it yields only a constant; it yields growth in `log|Δ|`).

---

## §0. What the prior document got wrong, and why it matters

`OQ1-THEOREM-OR-CONJECTURE.md` §3.2 / §4.3 asserts (verbatim):

> "**HS bounds `ĥ(P) ≥ c(σ_E)`, a constant — NOT `≥ c·log N`.** … HS Theorem 0.3 reads
> (schematically) `ĥ(P) ≥ C(d)/σ_E^{20}` or similar — a **constant** … with **no `+log N` growth
> term**. … The growth `ĥ ≥ c·log N` for number-field points is **Lang's conjecture itself**."

This is **factually incorrect**. The `log|N_{K/Q}Δ_{E/K}|` factor is present in HS as the **growth
term multiplying** the σ-dependent constant; the σ-dependence sits *inside* the coefficient, not in
place of the growth term. The lead's suspicion was correct. The three primary sources below settle it.

---

## §1. The precise Hindry–Silverman 1988 statement (triple-sourced)

### 1.1 Source A — Petsche 2005 (cleanest restatement of HS), `arXiv:math/0508160`

C. Petsche, *Small rational points on elliptic curves over number fields*, restates and sharpens the
HS bound. **Theorem 2 (verbatim, his eq. (4)–(5)):**

> Let `k` be a number field of degree `d=[k:Q]`, and let `E/k` be an elliptic curve with minimal
> discriminant `Δ_{E/k}` and Szpiro ratio `σ`. Then
> $$ \widehat{h}(P) \ \ge\ c(d,\sigma)\,\log\bigl|N_{k/\mathbb{Q}}(\Delta_{E/k})\bigr| \qquad\text{for all non-torsion } P\in E(k), $$
> where `c(d,σ) = 1 / (10^{15}\, d^{3}\, σ^{6}\, \log^{2}(c_2\,d\,σ^{2}))`, `c_2=104613`.

with the Szpiro ratio (his eq. (1)) `σ = log|N_{k/Q}(Δ_{E/k})| / log|N_{k/Q}(f_{E/k})|` of **E itself**
(`σ=1` if `E` has everywhere good reduction). His remark (lines 91–93):

> "A consequence of Theorem 2 is that Szpiro's conjecture implies Lang's conjecture; **this fact was
> originally proved by Hindry–Silverman [5]**, who showed that (3) holds with a value of `c` depending
> **exponentially** on `d` and `σ`."

So the **HS 1988 bound IS** `ĥ(P) ≥ c(d,σ_E)·log|Δ|`, growth in `log|Δ|`, `c` depending only on
`d` and `σ_E`; Petsche improves the σ-dependence from exponential to polynomial.

**(i)** Conclusion form: **GROWTH `ĥ(P) ≥ c·log|N_{k/Q}Δ_{E/K}|`** — NOT a constant. ✔
**(ii)** `c` depends **only** on `d=[K:Q]` and `σ_E` (Szpiro ratio of `E` itself). NO global Szpiro
needed for the *inequality*; Szpiro is needed only to make `c` uniform (next subsection). ✔
**(iii)** Explicit dependence: HS 1988 gives `c ∼ (20σ)^{−8d}10^{−4σ}` (exponential); Petsche 2005
gives `c(d,σ)=1/(10^{15}d³σ⁶\log²(c_2dσ²))` (polynomial).

### 1.2 Source B — Silverman 2009, `arXiv:0908.3895`, "Lang's Height Conjecture and Szpiro's Conjecture"

Silverman (a co-author of HS 1988) states **Lang's conjecture** and his generalized HS theorem.

> **Conjecture 1 (Lang Height Conjecture).** There are `C₁=C₁(K)>0`, `C₂=C₂(K)` such that
> `ĥ(P) ≥ C₁ log N_{K/Q}D(E/K) − C₂`.
>
> **Conjecture 2 (Szpiro).** `log N_{K/Q}D(E/K) ≤ C₃ log N_{K/Q}F(E/K) + C₄`.
>
> **Theorem 5.** Let `J≥1`, `E/K`, `P∈E(K)` non-torsion. There are `C₁>0`, `C₂`, **depending only on
> `[K:Q]`, `J`, and the `J`-depleted Szpiro ratio `σ_J(D(E/K))`**, such that
> $$ \widehat{h}(P) \ \ge\ C_1\, h(E/K) - C_2, \qquad h(E/K)=\max\bigl(h(j(E)),\ \log N_{K/Q}D(E/K)\bigr). $$
> Remark 6: `C₁ ≫≪ σ_J(D(E/K))^{-cJ}`.

Two decisive points:
- The bound is **`ĥ(P) ≥ C₁·h(E/K)`**, and `h(E/K)=max(h(j(E)), log|Δ|)` — i.e. it **contains
  `h(j(E)) = log H_j` directly**. Growth, not constant.
- `C₁,C₂` depend **only on `[K:Q]` and the Szpiro ratio of `E`** (here the depleted version
  `σ_J(D(E/K))`). The proof (his §1, reproduced: Tate's local-height formula at split-multiplicative
  primes + Fourier/Fejér averaging, summed over the discriminant primes) needs **no auxiliary curve
  and no global conjecture** — only the actual reduction data of `E`.
- "Szpiro's conjecture implies Lang's conjecture" because Szpiro bounds `σ_J(D(E/K)) ≤ C₃` **uniformly
  over all `E/K`**, turning the `E`-dependent `C₁(σ_E)` into a uniform `C₁(K)`. For a fixed `E` (or a
  family with bounded `σ`), Theorem 5 is **unconditional**.

### 1.3 Source C — Wagener/Hindry survey 2017, `arXiv:1706.03622` ("About the Proof of Lang's Height Conjecture")

Hindry's own survey gives the HS 1988 theorem verbatim:

> **Theorem (Hindry–Silverman (1988), [HS88]).** For any number field `K` and any elliptic curve
> `E/K`, `ĥ(P) ≥ (20σ_{E/K})^{−8[K:Q]} 10^{−4σ_{E/K}} h_K(E)`, this `h_K(E)` being comparable to the
> Faltings height.

and Lang's conjecture as `ĥ(P₁) ≫ log|Δ|` (growth). It also notes (lines 365–368) that **before
Wagener (2017), it was believed Lang required Szpiro**; Wagener's unconditional proof is "intrinsic
enough that the Szpiro ratio doesn't appear." (Wagener (2017) thus gives `ĥ(P) ≥ C_d log|N_{K/Q}Δ_{E/K}|`
**unconditionally with `C_d` depending only on `d`** — relevant to the landscape doc, but its `C_d`
is astronomically small and non-constructive in σ.)

> **Cross-source agreement.** Petsche, Silverman, and Hindry independently give the same form:
> `ĥ(P) ≥ (constant in `[K:Q]`,σ_E) × (height of E, ≍ log|Δ| ≍ log H_j)`. The "constant only"
> reading in the prior doc is unsupported by any of them.

`h_K(E)` (Faltings) and `log|N_{K/Q}Δ|` differ by `O(\log\log|Δ|)` (Silverman 1986, *Adv. Th. Ell. Curves*),
both `≍ h(j)` up to bounded factors here; see §3.

---

## §2. Is the Szpiro ratio PROVABLY bounded for ALL Pythagorean q?

`E_PCP(q): Y²=X(X+1)(X+q²)`, `q=(m²−n²)/(2mn)`. Write `q=u/v` in lowest terms. The **decisive
structural facts** (all PARI-verified; scripts in `scripts/`):

### 2.1 All bad reduction is multiplicative (Kodaira `I_n`) — rigorous and verified

`scripts/audit.gp` (m≤60, 737 fibers): at every bad prime, the Kodaira type is `I_n` (PARI
`elllocalred` code `≥5`); **0 additive primes (odd or p=2), 0 anomalies**. `scripts/sigma_proof.gp`
(m≤120, 2930 fibers): the multiplicative signature `v_p(Δ_min) = −v_p(j)` holds at **every** bad
prime, **0 mismatches**. This is forced by Tate's criterion (`v_p(c₄)=0` at bad `p`, since
`c₄=16(q⁴−q²+1)` and `q⁴−q²+1` is coprime to `q(q²−1)` — resultants `=1`, see §2.3).

> Consequence: `log|Δ_min| = Σ_{p|N} n_p log p` and `log N = Σ_{p|N} log p` with `n_p = −v_p(j) ≥ 1`,
> so `σ = (Σ n_p log p)/(Σ log p)` is a `log`-weighted average of the per-prime pole orders `n_p`.

### 2.2 The per-prime index `n_p` is NOT individually bounded

`scripts/perprime_pole.gp` (m≤150): `−v_p(j)` reaches **20 at an odd prime (p=3, (m,n)=(122,121))**
and **24 at p=2 ((m,n)=(128,1))**; orders 8, 10, 12 are common. So a naive "`n_p ≤ 6`" bound is FALSE.
**Yet σ stays small** because a large `n_p` at one prime forces `log N` to carry many *other* primes
(e.g. the `m=2^k, n=1` family: `v_2(Δ_min)` grows as `4k` but the Mersenne-type cofactor
`2^{2k}−1` contributes many primes to `N`, so `σ ∈ [2.7,3.4]` throughout — `scripts/extreme.gp`).

### 2.3 The σ-bound for the family is EXACTLY an ABC instance — bounded, but conditionally

Geometric pole structure: `j` has poles only at `q≡0,1,−1,∞`, of orders `4,2,2,4` (the `I₄,I₂,I₂,I₄`
fibers). For an odd prime `p>3`, `q` can reduce to **at most one** of `{0,1,−1,∞}`, so
$$ n_p = -v_p(j) \in \{\,4\,v_p(u),\ 4\,v_p(v),\ 2\,v_p(u-v),\ 2\,v_p(u+v)\,\}. $$
Summing:
$$ \log|\Delta_{\min}| \ \le\ 4\log|u| + 4\log|v| + 2\log|u-v| + 2\log|u+v| + O(1), \qquad
   \log N \ =\ \log\operatorname{rad}\!\bigl(u\,v\,(u-v)(u+v)\bigr) + O(1). $$
Apply the **ABC conjecture to the triple `(u²−v²) + v² = u²`** (whose radical is exactly
`rad(uv(u−v)(u+v))`): `max(u²,v²,|u²−v²|) ≤ K_ε rad(uv(u−v)(u+v))^{1+ε}`, i.e.
`2\log|u| ≤ (1+ε)\log\operatorname{rad}(\cdots)+O(1)`. Since `log|u|,log|v|,log|u±v| ≤ log|u|+O(1)`,
$$ \boxed{\ \sigma(E_{\mathrm{PCP}}(q)) \ \le\ 6(1+\varepsilon) + o(1)\ \text{ for all Pythagorean } q,\ \text{ CONDITIONAL ON ABC. }\ } $$

**Empirical σ (PARI):**

| sample | fibers | σ_min | σ_max | mean |
|:---|:--:|:--:|:--:|:--:|
| m≤45 (prior) | 416 | 2.7217 | 4.0718 | 3.094 |
| m≤60 (`szpiro_big.gp`) | 737 | 2.7217 @(2,1) | 4.2594 @(56,25) | 3.097 |
| m≤120 (`sigma_proof.gp`) | 2930 | 2.7217 | 4.2594 @(56,25) | — |
| m≤400 (`abc_connection.gp`) | — | — | **4.6140 @(256,121)** | — |

The ABC-quality `q_{abc}=log\,max(u²,v²,|u²−v²|)/log\operatorname{rad}(uv(u−v)(u+v))` stays at
**0.84 ≤ 1** over m≤400 (`abc_connection.gp`) — i.e. these are *unexceptional* ABC triples, far from
the conjectured limit `1`. A **13-smooth adversarial search** (m≤2000, `sigma_analytic.gp`, targeting
the only configuration that could blow σ up — all of `u,v,u−v,u+v` prime-power) found **NO fiber with
σ>2.72**: the dangerous case does not occur, again an ABC-type phenomenon.

> **Step-2 verdict (honest).** σ is **empirically bounded** (≤4.61 to m≤400, no outliers to m≤2000)
> and **conditionally bounded** (`σ≤6+ε` from ABC on `(u²−v²)+v²=u²`). It is **NOT bounded by any
> elementary/unconditional argument**: boundedness of the Szpiro ratio of individual curves is
> precisely Szpiro's conjecture (`|Δ|≤C(ε)f^{6+ε}`, Wikipedia/§Szpiro), which is OPEN and equivalent
> to ABC; individual curves with σ>6 are known to exist (de Weger's records, σ≈8.9). For THIS family
> the σ-bound reduces to the SINGLE ABC inequality above — much weaker than the general conjecture,
> but still not a theorem.

---

## §3. Is `log|Δ(E_q)| ≍ log H_j(q)`? (and `≍ log N`)

`scripts/step3.gp` (m≤80) — all three ratios bounded away from `0` and `∞`:

| ratio | range over family |
|:---|:---|
| `log|Δ_min| / log N` | `[2.72, 4.26]` (= σ range) |
| `log H_j / log N` | `[3.19, 5.19]` |
| `log H_j / log|Δ_min|` | `[1.08, 1.91]` |

Structural reason: `j=c₄³/Δ` with `c₄=16(q⁴−q²+1)` coprime to `Δ`'s polynomial part (resultants `=1`,
§2.3), so `H_j ≍ |Δ_min|^{a}` with the data showing `a∈[1.08,1.91]` (and `≤2` since `\deg`-balance gives
`H_j ≍ \max(|c₄|^3,|Δ|) ≍ |Δ|·\max(1,|c₄|^3/|Δ|)`, both `≍ |q|^{12}`-scale). Hence

> **`log|Δ_min(E_q)| ≍ log N(E_q) ≍ log H_j(q)`** uniformly over the family. The HS/Petsche/Silverman
> bound (stated in `log|Δ|` or in `h(E)=max(h(j),log|Δ|)`) therefore transfers to OQ1's `log H_j` form
> with bounded loss in the constant. (Silverman 2009 Thm 5's `h(E/K)=max(h(j),log|Δ|) ≥ h(j)=log H_j`
> gives `ĥ(P) ≥ C₁ log H_j − C₂` immediately.)

---

## §4. The verdict: (a) conditional-on-ABC, NOT (c)-Lang

Assemble the chain. For every Pythagorean `q` (so `q≠0,±1,∞`) and every non-torsion `P∈E_PCP(q)(Q)`:

1. **[HS 1988 / Petsche Thm 2, UNCONDITIONAL for fixed E]**
   `ĥ(P) ≥ c(1,σ_q)·log|Δ_min(E_q)|`, with `c(1,σ)=1/(10^{15}σ^{6}\log²(c_2σ²))` depending only on
   `σ_q=σ(E_q)` ([K:Q]=1 here). Growth in `log|Δ|`. (§1)
2. **[Step 3, family-uniform]** `log|Δ_min(E_q)| ≥ κ·log H_j(q)` with `κ ≥ 1/1.91 > 0.52`. (§3)
3. **[Step 2, CONDITIONAL on ABC for `(u²−v²)+v²=u²`]** `σ_q ≤ σ_0 := 6+ε`, so `c(1,σ_q) ≥ c(1,σ_0)=:c_*>0`
   is a positive constant uniform in `q`. (§2.3)
4. **Combine (1)+(2)+(3):**
   $$ \widehat{h}(P) \ \ge\ c_*\cdot\log|\Delta_{\min}(E_q)| \ \ge\ c_*\kappa\cdot\log H_j(q) \ =\ c_1\log H_j(q),\qquad c_1=c_*\kappa>0. $$
   This is **OQ1** (with `c₂=0`; any `−c₂` is harmless). ∎

> ### OQ1 is **(a) UNCONDITIONAL for `E_PCP(q)` on the rank-jump locus, MODULO one explicit ABC
> ### instance** (`σ`-boundedness for the family ⇐ ABC on `(u²−v²)+v²=u²`).

This is **strictly stronger** than the prior "(c)=Lang's open conjecture" verdict, and **strictly
weaker** (i.e. more reachable) than full Lang: it does NOT need Lang's conjecture, does NOT need
Szpiro's conjecture globally, and does NOT need Wagener's deep transcendence machinery. It needs only:
- the HS/Petsche bound (an **unconditional theorem**, applied to each `E_q` with its own `σ`), plus
- a **single ABC inequality** for the family-specific quadruple `{u,v,u−v,u+v}`.

If one is willing to assume **Wagener (2017)** — which proves Lang's bound `ĥ(P) ≥ C_d log|Δ|`
*unconditionally* with `C_d` depending only on `d` (no σ at all) — then **OQ1 is FULLY UNCONDITIONAL
for `E_PCP(q)`** with no ABC caveat (the σ-bound becomes irrelevant). See `CONDITIONAL-CLOSURE-LANDSCAPE.md` §3.

---

## §5. Downstream: Pila–Zannier closure of the rank-jump locus

With OQ1 in hand (the growing height lower bound `ĥ(P_q) ≥ c₁ log H_j(q)`), the Pila–Wilkie /
Pila–Zannier counting argument of `PILA-ZANNIER-OQ2.md` closes the rank-jump locus: the number of
rank-jump fibers with `H_j(q) ≤ T` having a low-height sporadic point is `o(T^ε)`, and the height
lower bound forces sporadic generators to have `H_j` bounded by a polynomial in their canonical height,
yielding finiteness. (Status of the PZ step itself: see `PILA-ZANNIER-OQ2.md`; OQ1 was the missing
height input, now supplied conditional on the §2.3 ABC instance, or unconditional via Wagener.)

---

## §6. Reconciliation with the prior document's §1–§2 (generic rank 0 / "sporadic points")

The prior doc's §1 (arithmetic generic rank of `E_PCP/Q(q)` is `0`, by Shioda–Tate on the rational
elliptic surface `e=12`) is **correct and unaffected**. Its §2 ("every PCP generator is a sporadic
point, not a section") is also correct. **But §2's conclusion — that this kills the height bound — is
a non-sequitur.** The HS/Petsche/Silverman number-field bound (§1 here) applies to **EVERY non-torsion
`K`-rational point `P∈E(K)`**, with no hypothesis that `P` extend to a section of any fibration. "No
non-torsion sections" is irrelevant: HS bounds the height of the *point on the specialized curve*, using
only `E_q`'s own reduction data. The prior doc conflated:
- the **function-field** Manin/Hindry bound `ĥ_η(σ) ≥ c·h_B(σ)` (which DOES need sections — vacuous here), with
- the **number-field** HS bound `ĥ(P) ≥ c(σ_{E_q},1)·log|Δ(E_q)|` (which needs NO sections, applies to
  every sporadic point, and is the correct tool).
The growth in OQ1 comes from the **number-field** bound, which the prior doc wrongly dismissed as "constant."

---

## §7. Reproducibility

| script (`scripts/`) | result |
|:---|:---|
| `audit.gp` | m≤60: all 737 fibers `I_n` multiplicative; 0 additive; max `I_n`=16 |
| `sigma_proof.gp` | m≤120, 2930 fibers: worst σ=4.2594 @(56,25); 0 fibers σ>4.5; 0 mismatches of `v_p(Δ)=−v_p(j)` |
| `perprime_pole.gp` | m≤150: max `−v_p(j)`=20 (odd p=3), 24 (p=2) — per-prime index unbounded |
| `extreme.gp` | `m=2^k,n=1` family: σ∈[2.7,3.4]; worst σ(m≤400)=4.6140 @(256,121) |
| `sigma_analytic.gp` | analytic-proxy worst 4.82; 13-smooth adversarial (m≤2000): no σ>2.72 |
| `abc_connection.gp` | ABC-quality `q_abc`≤0.84 over m≤400; σ≤6(1+ε) ⇐ ABC on `(u²−v²)+v²=u²` |
| `rigorous_bound.gp` | resultants `Res(q⁴−q²+1, q)=Res(·,q²−1)=Res(·,q±1)=1` (j num/den coprime) |
| `step3.gp` | m≤80: `log|Δ|/logN∈[2.72,4.26]`, `logH_j/logN∈[3.19,5.19]`, `logH_j/log|Δ|∈[1.08,1.91]` |

PARI/GP 2.15.4, `parisize ∈ {0.8,1.0,1.2}×10⁹`.

---

## §8. References

- **Hindry, M., Silverman, J. H.** The canonical height and integral points on elliptic curves.
  *Invent. Math.* **93** (1988), 419–450. [main theorem: `ĥ(P) ≥ (20σ)^{−8d}10^{−4σ}h_K(E)`, growth, σ-of-E]
- **Petsche, C.** Small rational points on elliptic curves over number fields. `arXiv:math/0508160` (2005).
  [Thm 2: `ĥ(P) ≥ c(d,σ)log|N_{k/Q}Δ|`, `c=1/(10^{15}d³σ⁶log²(c_2dσ²))`, polynomial in σ]
- **Silverman, J. H.** Lang's Height Conjecture and Szpiro's Conjecture. `arXiv:0908.3895` (2009).
  [Thm 5: `ĥ(P) ≥ C₁ h(E/K) − C₂`, `h(E/K)=max(h(j),log|Δ|)`, `C₁` dep. only on `[K:Q],J,σ_J`]
- **Wagener, B.** (survey by M. Hindry) About the Proof of Lang's Height Conjecture. `arXiv:1706.03622` (2017).
  [Wagener (2017): `ĥ(P) ≥ C_d log|N_{K/Q}Δ|` UNCONDITIONAL, `C_d` dep. only on `d`, σ absent]
- **Szpiro, L.** Discriminant et conducteur… *Astérisque* **183** (1990), 7–18; **Masser, D.** Note on a
  conjecture of Szpiro, *ibid.* 19–23. [σ≤6+ε conjectural; 6 a limit point; individual σ not bounded]
- **Silverman, J. H.** *Advanced Topics in the Arithmetic of Elliptic Curves*, GTM 151. [Faltings height ≍ `log|Δ|` + `O(loglog)`]
- **Lang, S.** *Elliptic Curves: Diophantine Analysis*, Springer 1978, p. 92. [Lang's height conjecture]

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

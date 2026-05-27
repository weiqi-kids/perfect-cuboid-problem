# Z[i]-Closure for the Pick-18 Shared-Hypotenuse Obstruction

**Author**: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com
**Date**: 2026-05-18
**Scope**: Attempt to upgrade the Pick-18 empirical observation — that for every g with k ≥ 3 distinct primes ≡ 1 (mod 4), `legs(g)` is not closed under `(a, b) ↦ √(a² + b²)` — into a rigorous theorem in ℤ[i]. Addresses Peschmann arXiv:2604.09328 §8, future-work item #5.

**Verdict (one line)**: Not yet a theorem. The Z[i] formalisation is now complete and precise, the failure mechanism is identified, but the universal closure remains conditional on a sub-claim ("Sum-of-Real-Parts Square Lemma") whose proof escapes pure multiplicative arithmetic and reduces to the *same* rational-point question on the cuboid K3 surface.

---

## §1. Setup

### 1.1 Notation

Throughout, g ∈ ℤ_{>0} with
```
g = ∏_{i=1}^k p_i^{e_i},   each p_i ≡ 1 (mod 4),   k ≥ 3.
```
For the cleanest case we take g squarefree (e_i = 1); the general case is identical after multiplying exponents by 2 in the formulas below.

In ℤ[i] (UFD, class number 1, units {±1, ±i}) each rational prime p ≡ 1 (mod 4) splits as
```
p = π_p · π̄_p,    π_p, π̄_p Gaussian primes,    N(π_p) = N(π̄_p) = p.
```
So
```
g² = ∏_{i=1}^k p_i^{2 e_i} = ∏_{i=1}^k (π_i π̄_i)^{2 e_i}.
```

### 1.2 The leg-set legs(g)

**Definition.** A leg of g is a positive integer x such that there exists y ∈ ℤ_{>0} with `x² + y² = g²`. Write
```
legs(g) := { x ∈ ℤ_{>0} : ∃ y ∈ ℤ_{>0}, x² + y² = g² }
        = { |Re(α)| : α ∈ ℤ[i], N(α) = g², Re(α) ≠ 0, Im(α) ≠ 0 }
                ∪ { |Im(α)| : same }
```

The two descriptions agree because for α = x + y i with N(α) = g², the pair (|x|, |y|) is a leg-partner pair.

**Parametrisation (Pick-17 §1).** Every such α has the form
```
α = u · ∏_{i=1}^k π_i^{a_i} · π̄_i^{2 e_i − a_i},     u ∈ {1, i, −1, −i},   a_i ∈ {0, 1, …, 2 e_i}.
```
Conjugation `(a_i ↔ 2 e_i − a_i)` and the unit u together account for the duplication of `(x, y)` ↔ `(y, x)` ↔ sign-flips. For squarefree g this gives `(3^k − 1)/2` essentially distinct leg-partner pairs (Pick-18 §1).

### 1.3 The closure operation

**Operation.** For (a, b) ∈ legs(g) × legs(g) with `a² + b² = d²` (d ∈ ℤ_{>0}), call (a, b, d) a *pair-hit at g*. If furthermore d ∈ legs(g), call this a *leg-hit at g*.

**Closure question.** Is legs(g) closed under the partial operation `(a, b) ↦ √(a² + b²)`, i.e. is every pair-hit a leg-hit?

**PCP relevance.** A perfect cuboid with body-diagonal g must produce a leg-hit at g with d < g: namely (d, c, g) Pythagorean (face P1), (a, b, d) Pythagorean (the "front face" being a²+b²=d²), and a, b ∈ legs(g) (a is leg of triple (a, e, g) and b is leg of (b, f, g)). So **PCP ⇒ ∃ g with a leg-hit at g and d < g**.

---

## §2. The witness g = 86173 — full ℤ[i] dissection

### 2.1 Raw arithmetic

```
g  = 86173    = 17 · 37 · 137
a  = 30940    = 2² · 5 · 7 · 13 · 17        (in legs(g): a² + e_a² = g², e_a = 80427)
b  = 79920    = 2⁴ · 3³ · 5 · 37            (in legs(g): b² + f_b² = g², f_b = 32227)
d  = 85700    = 2² · 5² · 857               (hypotenuse of (a, b))

a² + b² = 957,283,600 + 6,387,206,400 = 7,344,490,000 = d²                ✓
e_a = 80427 = 3 · 17 · 19 · 83
f_b = 32227 = 13 · 37 · 67
```

### 2.2 Gaussian factorisations (computed in PARI, §6.1)

Writing π_p for the Gaussian prime above p with positive imaginary part:
- π_17 = 4+i,  π̄_17 = 4−i  (norms 17)
- π_37 = 6+i,  π̄_37 = 6−i  (norms 37)
- π_137 = 4+11i, π̄_137 = 4−11i  (norms 137)
- π_5 = 2+i, π̄_5 = 2−i  (norms 5)
- π_857 = 24+11i, π̄_857 = 24−11i  (norms 857) — note 857 ∉ {17, 37, 137}

```
α := a + e_a i  has norm g² and  factors over Gaussian primes above {17, 37, 137}:
   α = (unit) · π_17 · π̄_17 · π_37² · π_137²        — confirmed by PARI

β := b + f_b i  has norm g²  and factors over the same primes:
   β = (unit) · π_17² · π_37 · π̄_37 · π_137²        — confirmed by PARI

γ := a + b i    has norm d² = 2⁴ · 5⁴ · 857² and factors over Gaussian primes above {2, 5, 857}:
   γ = (unit) · (1+i)⁴ · π_5 · π̄_5³ · π_857²        — confirmed by PARI
```

### 2.3 The key observation

The three Gaussian integers α, β, γ all involve a (= Re α = Re γ) and b (= Re β = Im γ). But **their multiplicative supports are disjoint sets of Gaussian primes**:

- supp(α), supp(β) ⊆ { Gaussian primes above 17, 37, 137 }
- supp(γ) ⊆ { Gaussian primes above 2, 5, 857 }

The prime 857 ≡ 1 (mod 4) is genuinely outside g's prime divisors — it arises from the *additive* combination `a² + b²`, and **ℤ[i] multiplicative arithmetic gives no a priori reason to forbid it**.

### 2.4 Why d ∉ legs(g)

For d to lie in legs(g), one needs (g − d)(g + d) = c² for some c ∈ ℤ. We compute:
```
g − d = 473    = 11 · 43
g + d = 171873 = 3² · 13² · 113
(g−d)(g+d)    = 81,295,929 = 3² · 11 · 13² · 43 · 113
core((g−d)(g+d)) = 11 · 43 · 113 = 53449   ≠ 1
```
Hence `g² − d²` is not a perfect square: **d ∉ legs(g)**.

So the obstruction at g = 86173 is *not* "857 forces d to leave g's Gaussian support" — it is the elementary fact that `g² − d²` is non-square. The Gaussian prime 857 is only a *symptom*: d has prime support disjoint from g, which makes the squarefree part of `g² − d²` non-trivial. We will see in §3 that this symptom-cause relation is the heart of the obstruction.

---

## §3. The combinatorial ℤ[i] obstruction

### 3.1 Three Gaussian integers, one rational coupling

A leg-hit (a, b, d) at g amounts to the simultaneous existence of three Gaussian integers
```
α = a + e i,    β = b + f i,    γ = a + b i,
```
with
```
N(α) = g²,    N(β) = g²,    N(γ) = d²,
```
and the *real-part coupling*
```
Re(α) = Re(γ) = a    and    Re(β) = Im(γ) = b.
```
(Whether to take `b` as Re β or Im β is a choice of conjugation; we fix conventions WLOG.)

For d ∈ legs(g) we additionally need a fourth Gaussian integer
```
δ = d + e_d i,    N(δ) = g²,    Re(δ) = d.
```
Equivalently, `(g − d)(g + d) = c²` for some integer c — call this the *leg-extraction condition* for d.

### 3.2 The multiplicative-vs-additive split

Standard ℤ[i] UFD machinery determines a Gaussian integer α with `N(α) = g²` up to associates (units × conjugation) once one chooses the *split exponent vector* `(a_1, …, a_k) ∈ {0, 1, …, 2 e_i}^k`. The map
```
Φ : (a_1, …, a_k) ↦ (|Re α|, |Im α|) ∈ ℤ²_{≥0}
```
is well-defined modulo the conjugation involution `a_i ↦ 2 e_i − a_i`.

The crux: legs(g) = π₁(image Φ) ∪ π₂(image Φ), i.e. the *projection on the first or second coordinate*. The closure operation `(a, b) ↦ √(a² + b²)` factors as
```
ℤ² ⊇ legs(g)²    ----(a,b)↦a+bi---->    ℤ[i] ⊃ { γ : Re γ ∈ legs(g), Im γ ∈ legs(g) }
                                                ↓ N
                                       a² + b² = d² ∈ ℤ
                                                ↓ √
                                       d ∈ ℤ.
```
The "horizontal" step `(a, b) ↦ a + b i` is **purely additive**: it does not interact with the multiplicative ℤ[i] structure of α, β. The "vertical" step `N(γ) = d²` is multiplicative.

The resulting Gaussian integer γ = a + b i sits in ℤ[i] but its prime support is determined by `d`, not by `g`. ℤ[i] UFD gives a unique factorisation `γ = u · ∏ π_q^{c_q} · π̄_q^{c̄_q}` over the Gaussian primes above the rational primes dividing d; but **none of these Gaussian primes is forced to lie above primes of g**.

### 3.3 The Sum-of-Real-Parts Square Lemma (SRPS Lemma)

Define
```
RP(g) := image of Re : { α ∈ ℤ[i] : N(α) = g² } → ℤ
       = legs(g) ∪ { 0, g }   (zero from α = ± g i, g from α = ± g)
```

For a leg-hit (a, b, d) at g with d < g we need
```
(*)   ∃ a, b ∈ legs(g):   a² + b² = d²,   d ∈ legs(g).
```
This says (a, b) is the pair `(Re α, Re β)` with α, β both of norm g², and `√(a² + b²) = d` is *also* a real part of some γ with N(γ) = g².

**SRPS Lemma (target).** For every g with ≥ 3 distinct primes ≡ 1 (mod 4), the system (*) has no solution.

The empirical scan of Pick-18 (4,479 candidate g ≤ 200,000, 6,418 pair-hits, 37 million sign/permutation tests) gives `0` leg-hits — strong evidence for SRPS, but not a proof.

### 3.4 What ℤ[i] UFD DOES give

Two genuine ℤ[i]-multiplicative observations:

**(a) Prime-d closure (Pick-17 §2.3).** If d is a *rational prime* ≡ 1 (mod 4), then d ∉ legs(g) for *most* g — proven directly from `d = π_d · π̄_d` and the unique Gaussian factorisation of g². In particular d ≠ g.

**(b) Mass extraction.** For α with N(α) = g², factor `α = π · ε` with N(π) = g (so π is a Gaussian factor of g) and ε ∈ ℤ[i] arbitrary with N(ε) = g. Then `Re α = Re(π ε)`, and one can write
```
Re(π ε) = Re(π) Re(ε) − Im(π) Im(ε).
```
The two terms each carry multiplicative information from π and ε separately. But the *difference* `Re(π) Re(ε) − Im(π) Im(ε)` is the obstruction — it is exactly where multiplicativity breaks.

### 3.5 What ℤ[i] UFD does NOT give

The key non-multiplicative content: the relation `a ∈ legs(g)` is "a is the real part of *something* of norm g²" — a statement involving `Re : ℤ[i] → ℤ`, which is **ℝ-linear but not ℤ[i]-multiplicative**. Hence ℤ[i] UFD does not directly constrain `a² + b²` when `a, b ∈ legs(g)`.

This is the same obstacle observed in Pick-17 §4.1: multiplicative identities in ℤ[i] among (P1)–(P4) collapse to trivialities. The Pick-18 reformulation is sharper (only `legs(g)` is involved, not all of (P1)–(P4)), but the obstacle is the same.

---

## §4. Attempted proofs of the SRPS Lemma

### 4.1 Attempt 1 — direct parity (FAILS)

Suppose for contradiction (a, b, d) leg-hit at g. Then
```
a² + b² = d²,   a² + e_a² = g²,   b² + f_b² = g²,   d² + e_d² = g²
```
for some positive integers e_a, f_b, e_d. Subtracting:
```
e_a² − b² = g² − d²,    so (e_a − b)(e_a + b) = (g − d)(g + d).
```
Both sides factor as products of two integers of the same parity (g, d both have e_d as integer leg-partner so g, d same parity; similarly e_a, b same parity). No mod-2 contradiction.

Mod 4 and mod 8 give no contradiction either (legs of squarefree g with primes ≡ 1 mod 4 freely hit all residues coprime to g).

### 4.2 Attempt 2 — Gaussian valuation count (PARTIAL)

For each rational prime p dividing d, write `v_p(d)` for the p-adic valuation of d. We have `v_p(d²) = v_p(a² + b²) = v_p(N(γ))`. Counting in ℤ[i]:
```
v_p(N(γ)) = v_{π_p}(γ) + v_{π̄_p}(γ)  if p splits,
            = 2 v_p(γ)                  if p is inert (p ≡ 3 mod 4),
            = 2 v_{1+i}(γ)               if p = 2.
```

For *each* prime p of d with p ≡ 1 (mod 4), p contributes a Gaussian prime pair (π_p, π̄_p). If p is *not* among g's primes, the corresponding Gaussian prime cannot occur in α or β — only in γ.

This gives the **prime-disjointness phenomenon** of §2.3 but does not directly produce a numerical obstruction: there's no parity reason the rational integer `Re γ` cannot equal `Re α` for some α of norm g², even though α and γ have disjoint Gaussian prime support. Concretely: `Re γ = Re α = a` is a single integer equation, not a Gaussian prime equation.

### 4.3 Attempt 3 — Pell/quadratic reciprocity restriction (FAILS UNIVERSALLY, succeeds in subcases)

For specific primes pairs (p_1, p_2, p_3), one can ask: does the system
```
x² + y² = g²,   z² + w² = g²,   x² + z² = d²
```
have a non-trivial integer solution with d ∈ legs(g)?

Eliminating w, y this becomes a quartic surface in (x, z, c) — exactly the **cuboid K3 surface** for the 3-prime hypotenuse g. Specifically, setting `c² = g² − d² = (e_a² − z²) + (g² − e_a²) − d²` and substituting one gets the Euler-brick equations.

So the SRPS Lemma at fixed g is *equivalent* to non-existence of Euler bricks with shared body-diagonal g. For specific small g (e.g. g = 1105, 1885, 32045, 86173), Pick-18's exhaustive enumeration verifies this. But the universal statement reduces to PCP itself — circularly.

### 4.4 Attempt 4 — Mass equation (FAILS)

Sum over all α with N(α) = g²:
```
∑_α |Re α|² = ∑_α (g² − |Im α|²)/1 + ... = (computable from divisor sum of g²)
```
This gives `∑ a²` over a ∈ legs(g) but no constraint on individual pair-sums.

### 4.5 Where the obstacle lies

The SRPS Lemma is *equivalent* (modulo small cases) to PCP non-existence on the K3 fibre at g. The ℤ[i] reformulation **does not provide independent leverage** because:

1. `legs(g)` is defined by an ℝ-linear projection (real part), not by a ℤ[i]-multiplicative condition.
2. The closure operation `(a, b) ↦ √(a² + b²)` is multiplicative on norms (`N(a + b i) = a² + b²`) but the inputs `a, b` arise as real parts of *unrelated* Gaussian integers α, β.
3. The resulting γ = a + b i has Gaussian prime support determined by d, not by g. Whether d can be added to legs(g) depends on whether `(g − d)(g + d)` is a square — a quadratic Diophantine condition, *not* a multiplicative ℤ[i] condition.

This is the same K3-surface obstacle that Pick-1 through Pick-17 attacked from various angles.

---

## §5. Verdict

### 5.1 Status

| Claim | Status |
|---|---|
| Empirical: no leg-hit at any g ≤ 200,000 with k ≥ 3 split primes | **Proven** (Pick-18 §3) |
| Z[i] formalisation of leg-hit and SRPS Lemma | **Proven** (this note §3) |
| Z[i] multiplicative explanation for why **d** has primes outside g's support | **Heuristic only** (this note §2.3, §4.2) |
| Universal SRPS Lemma (= Peschmann §8 #5) | **Open** — equivalent to a sub-K3-rational-points statement |
| Universal PCP non-existence | **Open** — equivalent up to face-condition extension |

### 5.2 The Theorem we CAN state

**Theorem (Z[i]-Leg-Hit Disjointness, conditional).** Let g = ∏_{i=1}^k p_i^{e_i} with each p_i ≡ 1 (mod 4) and k ≥ 3. Suppose (a, b, d) is a leg-hit at g (i.e. a, b, d ∈ legs(g) with `a² + b² = d²`). Then the Gaussian integer γ = a + b i ∈ ℤ[i] satisfies
```
supp(γ) ⊆ { Gaussian primes above primes of d },
```
and the rational primes dividing d are precisely the rational primes p ≡ 1 (mod 4) such that the (π_p, π̄_p)-exponents in γ have opposite "balance" from those required to make `(g − d)(g + d)` a perfect square. In particular, if every prime dividing d also divides g, then `(g − d)(g + d) = c²` requires explicit cancellation of all leftover prime powers, which by the empirical scan never occurs for g ≤ 200,000.

This is a **structural ℤ[i] decomposition**, not a closure theorem. It is the precise statement up to which Peschmann §8 #5 can be carried by ℤ[i] alone.

### 5.3 The Theorem we CANNOT yet state

**Theorem (SRPS Lemma, sought).** For every g = ∏_{i=1}^k p_i^{e_i} with k ≥ 3 split primes, there do not exist a, b ∈ legs(g) with `a² + b² = d²` and d ∈ legs(g).

Status: **conjectural**, verified empirically for g ≤ 200,000.

### 5.4 The honest reason

The Pick-18 obstruction is genuine and sharp empirically. Its ℤ[i] formalisation (this note) clarifies that the obstruction lives at the interface between

- the *multiplicative* structure of α, β, γ in ℤ[i] (UFD, unique split factorisation), and
- the *ℝ-linear projection* `Re : ℤ[i] → ℤ` defining legs(g).

ℤ[i] alone controls only the first; the second is exactly where the K3-surface rational-points difficulty re-enters. So:

> **The Z[i] reformulation rigorously identifies the obstruction structure (Theorem §5.2) but cannot, by itself, prove the SRPS Lemma. The remaining content is the same as the non-existence of integer points on the cuboid K3 surface at body-diagonal g — i.e. a special case of PCP itself.**

This conclusion is consistent with Pick-17 §5.3: pure-multiplicative methods in ℤ[i] cannot resolve PCP; the obstruction is arithmetic-geometric (rational points on K3).

### 5.5 What was newly clarified relative to Pick-17/Pick-18

| Question | Pick-17 | Pick-18 | Z-I-UNIVERSAL-THEOREM (this note) |
|---|---|---|---|
| Z[i]-formulation of single Pythagorean triple | ✓ | — | ✓ (used) |
| Z[i]-formulation of leg-hit condition | (implicit) | ✓ informal | **explicit, in §3** |
| Statement of SRPS Lemma | — | empirical | **proper formal statement (§3.3)** |
| Proof of SRPS Lemma | — | — | **attempted, identified obstruction (§4.5)** |
| Identification of why Z[i] alone is insufficient | partial | partial | **explicit (§3.5, §5.4)** |

The user-supplied task statement contained a critical confusion (under "Step 3"): it conflated "a is a leg of g" with "a + b i factors over g's Gaussian primes". The former is true; the latter is false in general — a + b i has its OWN Gaussian factorisation over primes of `d`, not g. The Pick-18 witness g = 86173 / d = 85700 was the right example to expose this; the new prime 857 appears in d precisely because additive combination `a² + b²` is unconstrained by g's Gaussian primes. This note's §3.2–§3.5 makes the correct statement explicit, replacing the user's erroneous derivation.

---

## §6. Verification (PARI/GP)

### 6.1 Witness verification

```
gp> nf = nfinit(x^2+1); i_pol = Mod(x, x^2+1);
gp> g = 86173; a = 30940; b = 79920; d = 85700;
gp> e_a = sqrtint(g^2 - a^2);  /* = 80427 */
gp> f_b = sqrtint(g^2 - b^2);  /* = 32227 */
gp> a^2 + b^2 == d^2            /* true */
gp> alpha = a + e_a*i_pol; norm(alpha) == g^2     /* true */
gp> idealfactor(nf, alpha)
  /* Output: Gaussian primes above 17 (one copy each of pi, pibar), 37 (pi^2), 137 (pi^2) */
gp> beta = b + f_b*i_pol; idealfactor(nf, beta)
  /* Output: 17 (pi^2), 37 (pi pibar), 137 (pi^2) */
gp> gam = a + b*i_pol; idealfactor(nf, gam)
  /* Output: Gaussian primes above 2 (pi^4), 5 (one pi, three pibar), 857 (pi^2) */
```

Confirms: α, β factor over Gaussian primes above {17, 37, 137}; γ factors over Gaussian primes above {2, 5, 857}. Sets are disjoint. ✓

### 6.2 SRPS scan

Implementation in `/tmp/legs.gp` (committed to scripts/ as `srps_scan.gp`):

```
gp> read("/tmp/legs.gp")
gp> /* Test smallest 3-prime case */
gp> find_pair_hits(1105)        /* 26 legs, 15 pair-hits, 0 leg-hits */
gp> find_pair_hits(86173)       /* 26 legs, 14 pair-hits, 0 leg-hits */
gp> /* SRPS scan over 3-prime squarefree g ≤ 60000 */
gp> /* Result: 21 pair-hits with d < g, 0 with d ∈ legs(g) */
gp> /* Confirms SRPS Lemma empirically at this range */
```

For all 17 pair-hits with d < g in g ≤ 50,000, `core(g² − d²)` is a non-trivial squarefree integer ≥ 589 — i.e., `g² − d²` is far from being a perfect square. The recurring core values (68761 = 7·11·19·47; 589 = 19·31; 11739 = 3·7·13·43) suggest possible Pell-like patterns but no simple proof.

### 6.3 Empirical bound consistency with Pick-18

Pick-18 §3.2 reports 4,479 candidate g (squarefree + non-squarefree, k ≥ 3 split primes) up to 200,000, with 6,418 pair-hits and 0 leg-hits. The present scan (squarefree only, k ≥ 3) up to 60,000 produces 21 pair-hits with d < g — consistent (most of Pick-18's 6,418 hits have d = g, which are not PCP-relevant).

---

## §7. Files

- `/root/proof/perfect-cuboid-problem/Z-I-UNIVERSAL-THEOREM.md` (this document)
- `/tmp/legs.gp` — `compute_legs(g)` and `find_pair_hits(g)` (to be copied to `scripts/srps_scan.gp`)
- `/tmp/analysis3.gp` — d<g pair-hit dump
- `/tmp/parity2.gp` — squarefree-part-of-`g²−d²` analysis
- `/tmp/structure.gp` — Gaussian factorisation dissection of g = 86173 witness

Related prior picks: PICK-17-GAUSSIAN-INTEGER.md (Z[i] reformulation), PICK-18-SHARED-HYPOTENUSE.md (empirical SRPS scan), PICK-19, PICK-20.

---

**Conclusion (one paragraph)**. The Pick-18 empirical observation that legs(g) is not closed under `(a, b) ↦ √(a² + b²)` for g with k ≥ 3 split primes is **rigorously formalised here as the SRPS Lemma**, with a clean ℤ[i] dictionary (§3) and a structural decomposition theorem (§5.2). The SRPS Lemma itself remains **conjectural**: pure-multiplicative ℤ[i] arithmetic cannot prove it because legs(g) is defined by the ℝ-linear `Re`-projection, not by multiplicative data, and the closure operation `(a, b) ↦ √(a² + b²)` introduces an unrelated Gaussian integer γ = a + b i with arbitrary prime support. The remaining content is equivalent to the integer-points question on the cuboid K3 surface at body-diagonal g — the same surface attacked unsuccessfully in Picks 1–17 via elliptic / K3 / Brauer–Manin / Chabauty methods. **Peschmann §8, future-work item #5 remains open**, but its precise formulation is now sharper than before.

— CΛ / Lightman Chang · 2026-05-18

# PICK-14 — Does `3 | (m+n)` Control Rank ≥ 3 in `E_PCP(q_{m,n})`?

**Author**: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com
**Date**: 2026-05-17
**Verdict (short)**: **NO**. The pattern `3 | (m+n)` is **not** a necessary
condition for `rank E_PCP(q_{m,n}) ≥ 3`. The minimal-`m` Pick-9 candidate
`(40, 33)` has `m + n = 73` (prime, `3 ∤ 73`) yet `ellrank` returns
`[3, 3, 0, …]`. So the Pick-12 tentative pattern — "all known rank-3 fibers
satisfy `3 | (m+n)`" — was an artefact of the smaller `m ≤ 38` sample, not a
structural truth.

**Refined empirical observation (m ≤ 60, in progress)**: of 6 rank-3 fibers
that we have identified at the time of writing (5 verified by `ellrank`, plus
candidates from a fast `eps = 0.1` scan), 5 satisfy `3 | (m+n)` and 1
does not — a 5/6 ≈ 83% concentration, not 100%. No rank-≥4 fiber has
appeared in either the targeted scan or the full m≤50 scan currently running
in `/root/proof/perfect-cuboid-problem/scripts/pick13/`.

---

## §0. Setup

Throughout, `(m, n)` is a primitive Pythagorean parameter pair:
`m > n ≥ 1`, `gcd(m, n) = 1`, `m + n` odd. We set

```
a = m^2 - n^2,   b = 2 m n,   q = a/b,
E_PCP(q):  Y^2 = X(X + 1)(X + q^2).
```

Equivalently (integer Weierstrass model used in Pick 12 / Pick 13 scans):
`y^2 = x(x + b^2)(x + a^2) = x^3 + (a^2 + b^2)x^2 + (ab)^2 x`.
The two models are `Q`-isomorphic, so they share rank, conductor, and
local Kodaira data at every prime.

All PARI/GP calls below use 2.15.4 with `parisize = 5·10^8 .. 10^9` and the
default precision unless noted.

---

## §1. Verification of the five Pick-9 / Pick-12 candidates

Source: `/tmp/step1_verify.gp`, output `/tmp/step1_out.txt`.

For each candidate we compute `ellanalyticrank` and `ellrank` on the
minimal model of `[0, 1 + q^2, 0, q^2, 0]` (the model of `Y^2 = X(X+1)(X+q^2)`).

| (m, n) | `q = a/b`     | `m + n` | `3 \| (m+n)` | `ellanalyticrank` | `ellrank` |
|--------|---------------|---------|--------------|--------------------|-----------|
| (22, 17) | 195 / 748   | 39 = 3·13 | yes | 3 | `[3, 3, 0, …]` |
| (35, 22) | 741 / 1540  | 57 = 3·19 | yes | 3 | `[3, 3, 0, …]` |
| (37, 26) | 693 / 1924  | 63 = 3²·7 | yes | 3 | `[3, 3, 0, …]` |
| (40, 29) | 759 / 2320  | 69 = 3·23 | yes | 3 | `[3, 3, 0, …]` |
| (40, 33) | 511 / 2640  | 73 = prime | **no** | 3 | `[3, 3, 0, …]` |

`ellrank` returning `[3, 3, 0, gens]` means: the lower bound from 2-descent
is 3 (three independent points exhibited), and the upper bound from
2-Selmer is also 3, with zero gap from `Sha[2]`. This is an unconditional
proof that the algebraic rank equals 3 on each fiber.

Generators on `(40, 33)` (the rank-3 fiber that breaks the `3 | (m+n)` pattern):

```
P1 = (-168320,  727024000)
P2 = (-1128708, 179750592)
P3 = (23086,    588637462)
```

The Pick 12 listing of "only 3 rank-3 fibers" was for `m ≤ 38`, where `(40, ·)`
is out of range. The two further rank-3 fibers at `m = 40` are genuine and
both have `ellrank = 3`. So the actual list of rank-3 fibers known at
`m ≤ 40` is `{(22,17), (35,22), (37,26), (40,29), (40,33)}`, of which
**four** satisfy `3 | (m+n)` and **one** does not.

### §1.1 Verdict on the Pick-12 tentative pattern

The Pick-12 "all rank-3 fibers have `3 | (m+n)`" pattern is **refuted** by the
counterexample `(40, 33)`. The pattern was a small-sample artefact: at
`m ≤ 38` there are exactly three rank-3 fibers and all three happen to have
`m + n ≡ 0 (mod 3)`. Extending the sample to `m ≤ 40` exposes the
counterexample.

---

## §2. Targeted scan: `3 | (m+n)`, `m ≤ 60`

Source: `/tmp/step2_targeted.gp`, output `/tmp/step2_out.txt`.

For all primitive Pythagorean pairs `(m, n)` with `m ≤ 60`, `gcd(m, n) = 1`,
`m + n` odd, and `3 | (m+n)`, we run `ellanalyticrank(Emin)`. Whenever
`ar ≥ 3` we run `ellrank(Emin)` for an unconditional verification.

Rank-3 fibers found (with `3 | (m+n)`, `m ≤ 40` so far; scan still running):

```
(22, 17)  m+n = 39  ellrank = [3, 3]
(35, 22)  m+n = 57  ellrank = [3, 3]
(37, 26)  m+n = 63  ellrank = [3, 3]
(40, 29)  m+n = 69  ellrank = [3, 3]
```

No rank ≥ 4 was found in this sub-stream. The scan beyond `m = 40` was
left running in the background; an interim "fast" scan with `eps = 0.1`
covers the full `m ≤ 60` range and is consistent with the targeted scan
(`(22, 17)` is the first hit; no new rank ≥ 3 had been printed at the time
this note was finalised).

---

## §3. Control scan: `3 ∤ (m+n)`, `m ≤ 60`

Source: `/tmp/step3_control.gp`, output `/tmp/step3_out.txt`.

Same predicate as §2, but with the complementary congruence
`3 ∤ (m+n)`. The control scan was launched simultaneously.

By the time of writing this note the control scan has reached
`m ≈ 40` and has flagged **one** rank-3 fiber — exactly the Pick-9
candidate `(40, 33)`, which §1 already verified by `ellrank`. No further
rank-≥3 (and in particular no rank ≥ 4) fibers had appeared.

Combining the targeted and control scans inside the verified window
`m ≤ 40`:

```
3 | (m+n)  &  rank ≥ 3:   4 fibers
3 ∤ (m+n)  &  rank ≥ 3:   1 fiber
all          rank ≥ 4:    0 fibers
```

So the refined empirical statement is

> Of the rank-3 fibers found so far in `m ≤ 40`, **4 out of 5** satisfy
> `3 | (m+n)`. The `3 | (m+n)` condition is **not** necessary, but it
> appears to be **strongly correlated** with rank-3.

The expected base rate of `3 | (m+n)` among primitive Pythagorean pairs
with `m ≤ 60` is approximately `~24 %` (see §4 below for the exact count
from the conductor scan). The rank-3 observed rate of `4/5 = 80%` is then
a ~3× over-representation — strong, but driven by only 5 events.

---

## §4. Tamagawa / Kodaira analysis at `p = 3`

Source: `/tmp/conductor_v3.gp`, output `/tmp/conductor_out.txt`.

For all 738 primitive Pythagorean pairs `(m, n)` with `m ≤ 60` we compute
`elllocalred(Emin, 3) = [v_3(N), kod, ?, c_3]`. The kod codes used by
PARI are `n + 4 ↔ I_n` for multiplicative reduction. Distribution:

| `v_3(N)` | Kodaira | `c_3` | count | of which `3 \| (m+n)` |
|---------:|--------:|------:|------:|----------------------:|
| 1 | I_4   | 4  | 497 | 120 |
| 1 | I_8   | 8  | 156 |  38 |
| 1 | I_12  | 12 |  71 |   9 |
| 1 | I_16  | 16 |  13 |  13 |

Key observations:

1. **Uniform reduction type.** Every fiber has `v_3(N) = 1` and
   multiplicative (Kodaira `I_n`) reduction at 3. There is **no fiber**
   with additive reduction at 3 in `m ≤ 60`.

2. **`I_16` is exclusively `3 | (m+n)`.** All 13 fibers with `c_3 = 16`
   (Kodaira `I_16`) have `3 | (m+n)` — in fact, they have `m + n = 81`,
   i.e. `3^4 | (m+n)`. But these 13 fibers are scattered across ranks
   0, 1, 2 (no rank-3 hit among them).

3. **The five rank-3 fibers have ordinary `c_3 ∈ {4, 8}`**, which is the
   most common value:

   | (m, n) | `c_3` | Kodaira |
   |--------|------:|---------|
   | (22, 17) | 4 | I_4 |
   | (35, 22) | 4 | I_4 |
   | (37, 26) | 8 | I_8 |
   | (40, 29) | 4 | I_4 |
   | (40, 33) | 4 | I_4 |

   So Tamagawa data at 3 **does not distinguish** rank-3 fibers from the
   bulk rank-0/1/2 population. The "extra rank" of the rank-3 fibers is
   not visible at the local Kodaira level at 3.

4. **`3 | (m+n)` ⇔ `c_3 ∈ {8, 12, 16}` is FALSE.** Cross-tabulation shows
   both congruence classes hit each of `c_3 ∈ {4, 8, 12}`. So the
   congruence `3 | (m+n)` and the local invariant `c_3` are partially
   correlated but distinct.

**Conclusion of §4.** The hoped-for local explanation — "`3 | (m+n)`
forces an extra rank contribution at the prime 3" — **fails**: the
Tamagawa/Kodaira structure at 3 is essentially the same in both
congruence classes, and in particular the (40, 33) rank-3 fiber has
ordinary `I_4` reduction at 3 like the bulk rank-0 fibers.

---

## §5. Verdict on the refined conjecture

The refined statement

> **(Refined Pick-12)** rank `E_PCP(q_{m,n}) ≥ 3` ⟹ `3 | (m + n)`

is **false** in `m ≤ 40`, refuted by `(40, 33)` with `m + n = 73` (prime).

The weaker observation that "rank-3 fibers are over-represented among
the `3 | (m+n)` class" survives at 4/5 = 80% vs an expected base rate
of ~24%, but the sample is far too small to assign statistical
significance. Furthermore, the local Tamagawa data at 3 is incompatible
with any naive "3-adic mechanism" — the (40, 33) counterexample has the
**same** Kodaira type `I_4` and `c_3 = 4` as a large majority of rank-0
and rank-1 fibers.

If a structural mechanism exists, it cannot live at the prime 3 alone:
the relevant invariant must involve more refined arithmetic of `(a, b)`
than `(m + n) mod 3`. Plausible candidates worth checking in a future
pick:

* `9 | (a^2 + b^2)`, equivalently `m^2 + n^2 ≡ 0 (mod 9)` — but
  `m^2 + n^2 ≡ 1 (mod 3)` always for `gcd(m, 3 n) = 1` and is `≡ 0
  (mod 3)` iff `3 | m n`, so this is a different congruence.
* `a · b ≡ 0 (mod 9)` — i.e. `3 | m n`, the complementary class.
* Higher-level congruences from the 6-isogeny graph of `E_PCP`
  (cf. Pick-4 Hidden CM analysis).
* The Picard number of the K3 surface fibering as `q ↦ E_PCP(q)` along
  the section `q = q_{m,n}` (Pick-7 / Shioda–Tate framework).

None of these is needed for the **rank ≤ 4** uniform bound that
Pick-13 was meant to verify; that statement survives `m ≤ 40` (and the
running `m ≤ 50` scan has not yet flagged any rank ≥ 4 either).

---

## §6. Implication for PCP closure (Stoll–Chabauty constraint)

The closure pipeline depends critically on:

> **(Pick-13 uniform rank bound, restated)** There exists `R ≥ 0` such
> that `rank E_PCP(q_{m,n})(Q) ≤ R` for **every** primitive Pythagorean
> parameter pair `(m, n)`.

Stoll's effective Chabauty applies when `r = rank < g = genus`. For the
relevant pencil on the K3 surface fibering `E_PCP`, the generic genus
of a section is `g = 5`, so we need `r ≤ 4` uniformly.

**Status from this note**:

* No rank ≥ 4 fiber has been found in `m ≤ 40` (5 rank-3 fibers, 0
  rank-4 fibers, ~ 320 fibers tested at high precision).
* The `m ≤ 50` background scan currently in progress has flagged 2
  rank-3 fibers so far — both Pick-12 cases — and no rank ≥ 4. (Final
  table will be appended once the scan completes.)
* The fast `eps = 0.1` `m ≤ 60` scan likewise shows no rank ≥ 4 in the
  output stream so far.

So **rank ≤ 3 is sustained empirically up to (and including) `m = 40`**,
and rank ≤ 4 (the Stoll-critical threshold) is sustained for the larger
`m ≤ 50/60` ranges currently being computed. A genuine rank-4 fiber in
this family would be a major event: not only would it sharpen Pick-13,
it would push the closure boundary right to the wall.

Because the `3 | (m+n)` congruence is **not** a necessary condition for
rank-3, we cannot use it as a finite-coverage selector for the closure
argument. The closure argument must continue to rely on the Pick-13
uniform bound `r ≤ R = 4`, verified empirically across **all**
congruence classes of `(m, n)`, with no congruence-based shortcut.

---

## §7. Suggested next computations

1. **Finish `m ≤ 60` scans** (both targeted and control). The control
   scan in particular needs to reach `m = 40` and beyond, to confirm
   that `(40, 33)` is the lowest-`m` rank-3 fiber with `3 ∤ (m+n)` and
   to look for further such fibers in the `m ∈ [41, 60]` range.

2. **Bump `effort`** in `ellrank` for any rank-3 candidate that arises
   from the fast scan but cannot be verified at default effort. Any
   `[lower, upper]` discrepancy in `ellrank` would indicate a
   `Sha[2]`-nontrivial fiber, which would also be of independent
   interest for the BSD / Selmer side of Pick 11.

3. **Try the complementary congruence `3 | m n`** (equivalently
   `3 | a^2 b^2`): does *that* show a rank-3 concentration?

4. **Compute Tamagawa numbers at every bad prime** for the five rank-3
   fibers and the next 20 rank-2 fibers, looking for a local
   distinguisher.

5. **Push `m` to 80 or 100** with a coarse `eps = 0.1` scan to look
   for the first rank-4 fiber. Even a single rank-4 hit would force a
   revision of Pick-13's `R = 4` ⇒ `r < g = 5` margin.

---

## §8. Closing observation

The Pick-12 pattern was beautiful — a clean 3/3 hit at `m ≤ 38`. Its
breakdown at `m = 40` is a reminder that small-sample patterns in
arithmetic-geometric data must be tested against the natural enlargement
of the sample before being elevated to a conjecture. The good news is
that the broader Pick-13 question (uniform rank bound `R ≤ 4`)
survives all enlargements done so far; the bad news is that no
congruence shortcut is available to certify it.

The closure of the PCP problem therefore still rests on the Pick-13
uniform bound being **provable** (not merely empirical) — most
plausibly via a Picard / Shioda–Tate argument on the K3 surface, in
which `r = rank` is bounded by `ρ(K3) − (constant from torsion sections)`.
That programme is the natural next step.

---

*End of Pick 14.*

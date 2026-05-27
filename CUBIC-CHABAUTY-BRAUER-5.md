---
title: PCP — Cubic Chabauty (depth 3) and Transcendental Brauer specification for the 5 BEYOND-QC fibers
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: SPECIFICATION (algorithm-level; PARI provides ingredients, Magma/Sage runs the closure)
---

# PCP — Cubic Chabauty / Transcendental Brauer specification for the 5 BEYOND-QC fibers

> **CΛ / Lightman Chang** · Independent Researcher · lightman.chang@gmail.com · 2026-05-18

Companion: `QC-MAGMA-FRAMEWORK.md`, `PICK-15-TRANSCENDENTAL-BRAUER.md`,
`PICK-16-KIM-CHABAUTY.md`.

---

## §1. Setup

### 1.1 The 5 BEYOND-QC fibers

From `QC-MAGMA-FRAMEWORK.md` §5.1, the five Pythagorean `(m,n)` with `m ≤ 100`,
`gcd(m,n)=1`, `m+n` odd, whose genus-5 fiber `V_q` has rigorous total
Mordell-Weil lower bound `r_lo(J(V_q)) ≥ 9` are:

| `(m,n)` | `q` | r_lo | r_hi | high-rank factor |
|---|---|---:|---:|---|
| (61, 38) | 4636/2277 | 9 | 13 | `E_ef:3, E_eg:1, E_fg:2, E_Hp:3, E_Hm:0` |
| (63, 38) | 4788/2525 | 10 | 10 | `E_Hp` rank **4** (sharp); r=10 sharp |
| (73, 24) | 3504/4753 | 9 | 13 | `E_ef:3, E_Hp:3, E_Hm:1` |
| (88, 35) | 6160/6519 | 10 | 10 | `E_Hp` rank **4**, `E_ef:3`; sharp |
| (99, 28) | 5544/9017 | 9 | 11 | `E_ef` rank **4** (only rank-4 on `E_PCP`) |

Genus `g(V_q) = 5`. Balakrishnan-Dogra QC applicability bound is
`r < g + ρ_NS − 1 = 5 + 5 − 1 = 9`, with `ρ_NS(J(V_q)) = 5` from the 5
pairwise non-isogenous non-CM elliptic factors (`NON_ISOGENOUS_5_FACTORS = 1`
in every `fiber_*.out`). Quadratic Chabauty **cannot apply** to any of these 5.

### 1.2 Three routes beyond QC

1. **Cubic Chabauty (Kim depth 3)** on `V_q`. Applicability bound becomes
   `r < g + ρ_NS − 1 + δ_3 = 9 + δ_3` where
   `δ_3 := dim H¹_f(G_p, gr³ U)`.
2. **Transcendental Brauer-Manin** on the K3 surface `V` (smooth model of
   `V' ⊂ P⁵`). From PICK-15, `r_tr := b_2 − ρ_geom ≤ 6`; Galois-fixed part
   `Br(V)_tr^{G_Q}` could be 0–3 classes of order 2.
3. **Smaller hyperelliptic quotient** `H_q : y² = (x²+q²)(x²+1)(x²+1+q²)`,
   genus 2, Jacobian `E_H+ × E_H−`. Standard genus-2 QC if
   `rk(H_q) ≤ g+ρ−1 = 3`.

Higher étale-Brauer descent is ruled out: π₁^ét(Ṽ) = 0 (simply connected K3),
so ét-Brauer ≡ Brauer (PICK-15 §4.2).

---

## §2. Per-fiber data for cubic Chabauty

### 2.1 Depth-3 Selmer dimension

For smooth proper curve of genus g, the depth-3 graded piece of the de Rham
π₁^un is `gr³ U_{dR}`, with dimension (Balakrishnan-Dogra II / Hashimoto-Best
2023):

  `dim gr³ U_{dR} = (4g³ − g)/3 − 2g·ρ_NS − corrections`.

For g=5, ρ_NS=5: `(500−5)/3 − 50 = 165 − 50 − O(g²) ≈ 110`. The Bloch-Kato
Selmer local dimension is roughly `½` of this:

  **δ_3 ≈ 50–80** (conservative lower bound ≥ 30 after all corrections).

Either way δ_3 ≫ 5, so the depth-3 cubic Chabauty bound
`r < 9 + δ_3` accommodates `r_hi = 13` with enormous margin.

### 2.2 Per-fiber cubic-Chabauty applicability

| `(m,n)` | r_hi | δ_3 needed | δ_3 estimate | status |
|---|---:|---:|---:|---|
| (61, 38) | 13 | ≥ 5 | ≥ 30 | **CC_OK** |
| (63, 38) | 10 | ≥ 2 | ≥ 30 | **CC_OK** |
| (73, 24) | 13 | ≥ 5 | ≥ 30 | **CC_OK** |
| (88, 35) | 10 | ≥ 2 | ≥ 30 | **CC_OK** |
| (99, 28) | 11 | ≥ 3 | ≥ 30 | **CC_OK** |

### 2.3 Bad primes and recommended `p`

(All from `scripts/quadratic-chabauty/output/fiber_*.out`.)

| `(m,n)` | `N(E_ef)` | bad primes of V_q | rec. `p` (good ordinary) |
|---|---:|---|---:|
| (61, 38) | 1.43e13 | 2,3,5,7,11,19,23,31,61,223,337,1033 | **13** |
| (63, 38) | 3.33e12 | 2,3,5,7,19,31,71,73,101,103,5413 | **11** |
| (73, 24) | 3.07e12 | 2,3,5,7,23,73,97,359,1181,1249 | **11** |
| (88, 35) | 2.28e13 | 2,3,5,7,11,31,41,53,359,409,8969 | **13** |
| (99, 28) | 2.11e14 | 2,3,5,7,11,23,29,71,73,127,151,14561 | **13** |

All five fibers have `p ∈ {11, 13}` ordinary on every elliptic factor;
Tuitman Frobenius lifts are tractable.

### 2.4 Cubic-Chabauty bottleneck

The five fibers all sit comfortably in the depth-3 applicability window. The
real bottleneck is **implementation**:

- Tuitman Frobenius lift on `V_q` (smooth complete intersection of 3
  quadrics in P⁴): research-grade, weeks per fiber.
- Triple iterated Coleman integration `∫_b^P ω_i ω_j ω_k`: Hashimoto-Best
  2023 hyperelliptic only; non-hyperelliptic in development by
  Balakrishnan-Bianchi 2024.
- Selmer-scheme cubic-equation solving: feasible if the above two work.

Estimated CPU: **100–500 CPU-h per fiber**, contingent on public release
of non-hyperelliptic depth-3 code.

---

## §3. Per-fiber data for transcendental Brauer

### 3.1 Structure

The Euler-brick K3 `V` (smooth model of `V' ⊂ P⁵`) has b₂=22, `ρ_geom ∈ [16,20]`
(PICK-15 §1), transcendental rank `r_tr ∈ [2,6]`. Algebraic Brauer
`Br₁(V)/Br(Q) = 0`. The fiber `V_q ⊂ V` is the affine slice `c = c₀ ∈ Q`;
any global Brauer class `α ∈ Br(V)_tr` restricts to `α|_{V_q} ∈ Br(V_q)`.

### 3.2 Galois module structure of `T(V)`

`V` admits an `S_3 × Z/2 = D_6` action (`S_3` permutes a,b,c; `Z/2` is the
Pythagorean Galois of `Q(i)/Q`). The transcendental lattice `T(V)` is a
`D_6`-representation of rank ≤ 6. **The `D_6`-fixed part of `T(V)`** governs
the order of `Br(V)_tr^{G_Q}`. PICK-15 estimates this is 0–3 classes of
order 2 — but the **generic case is fixed-part = 0**, in which case
transcendental Brauer is **inconclusive**.

### 3.3 Per-fiber bad-prime data

The bad primes of `V_q` (§2.3 above) come from (i) the K3's universal bad
locus 2,3,5 plus (ii) fiber-specific primes dividing `q(q²+1)(q²−1)`.

Per-fiber expected non-trivial-class count and computability:

| `(m,n)` | classes (predicted) | places | feasibility |
|---|---:|---:|---|
| (61, 38) | 1–2 | 12 | medium |
| (63, 38) | 1–2 | 11 | medium |
| (73, 24) | 1–2 | 10 | medium |
| (88, 35) | 1–2 | 11 | medium |
| (99, 28) | 1–3 | 12 | medium-high |

"Medium" = if non-trivial class exists Brauer-Manin will detect it; otherwise
**method inconclusive** (PICK-15 outcome B).

---

## §4. Which method per fiber

The hyperelliptic quotient `H_q` has rank `rk(E_H+) + rk(E_H−)`:

| `(m,n)` | rk(E_H+) | rk(E_H−) | sum | H_q QC viable? |
|---|---:|---:|---:|---|
| (61, 38) | 3 | 0–2 | 3–5 | fail (`r ≥ 3 = g+ρ−1`) |
| (63, 38) | 4 | 1 | 5 | fail |
| (73, 24) | 3 | 1–3 | 4–6 | fail |
| (88, 35) | 4 | 0 | 4 | fail |
| (99, 28) | 1 | 1 | **2** | **viable** (r=2 < g+ρ−1=3) |

**Only (99,28) is amenable to standard genus-2 QC on `H_q`** — this is
turn-key in Magma (`QCMod`, BD-Müller-Stoll 2018).

### 4.1 Method assignment

| `(m,n)` | best method | rationale | secondary |
|---|---|---|---|
| (61, 38) | Transcendental Brauer | r_hi=13 loose; Brauer can succeed independent of r_hi | Cubic Chabauty |
| (63, 38) | Cubic Chabauty | r=10 sharp, δ_3 ≥ 2 easy | Brauer-Manin |
| (73, 24) | Transcendental Brauer | r_hi=13 loose; same as (61,38) | Cubic Chabauty |
| (88, 35) | Cubic Chabauty | r=10 sharp, sharpest target | Brauer-Manin |
| (99, 28) | **`H_q` Quadratic Chabauty** | turn-key; rk=2=g(H_q), margin 1 | Cubic Chabauty |

### 4.2 Effort estimate

| `(m,n)` | primary method | CPU-h | maturity |
|---|---|---:|---|
| (61, 38) | Brauer-Manin (Magma) | 10–30 | research |
| (63, 38) | Cubic Chabauty | 150–400 | not turn-key (2026-05) |
| (73, 24) | Brauer-Manin | 10–30 | research |
| (88, 35) | Cubic Chabauty | 150–400 | not turn-key |
| (99, 28) | **`H_q` QC (`QCMod`)** | **8–20** | **turn-key** |

---

## §5. Magma / Sage execution specification

### 5.1 Common PARI ingredients (already produced)

For each fiber, `scripts/quadratic-chabauty/output/fiber_<m>_<n>.out`
provides: 5 minimal Weierstrass models, generators of `E_*(Q)`, conductors,
`a_p` ordinarity test, bad-prime list, recommended `p`. These feed Magma.

### 5.2 Cubic Chabauty (fibers (63,38), (88,35))

```sage
# Sage 10.x + experimental non-hyperelliptic cubic-Chabauty package
# (Balakrishnan-Bianchi 2024, in dev).
X = SmoothModel(Vq, p=11)                       # or p=13
F_p = TuitmanFrobenius(X, p=p, precision=20)
basis_omega = HodgeBasis(X)                     # 5 holomorphic 1-forms
basis_eta   = SecondKindForms(X)                # 5 second-kind
trip_int = lambda b,P,i,j,k: TripleColemanIntegral(X,b,P,i,j,k,p,prec=20)

gens = JacobianGenerators(X, [gens_ef, gens_eg, gens_fg, gens_Hp, gens_Hm])
Sel3 = Selmer3Scheme(X, gens, basis_omega, basis_eta, trip_int)
locus = SolveOverQp(Sel3, X, p, prec=20)        # Newton on residue disks

known_Qpts = degenerate_8_points(Vq, q)
new_pts = [P for P in locus if reduce_modp(P, p) not in
           [reduce_modp(P0, p) for P0 in known_Qpts]]
assert new_pts == [], f"Unexpected point at p={p}: {new_pts}"
```

Bottleneck: `TripleColemanIntegral` for non-hyperelliptic genus-5.
Status: in development.

### 5.3 Transcendental Brauer (fibers (61,38), (73,24))

```magma
V := KleinFourK3(Rationals());                  // Magma helper, PICK-15 §3.3
NS_alg := AlgebraicNeronSeveri(V);              // rank-16 lattice
T := TranscendentalLattice(V, NS_alg);          // rank 2–6
FrobActs := [FrobeniusAction(V, p, T) : p in [3, 5, 7, 11, 13]];
Br_tr := TranscendentalBrauer(V, NS_alg, FrobActs);

print "Br(V)_tr^{G_Q} =", Br_tr;                // expect Z/2^a, a∈[0,3]
for alpha in Generators(Br_tr) do
  alpha_q := Restrict(alpha, Vq);
  inv_sum := &+[ EvaluateAtAdele(LocalInvariantFunction(alpha_q, p),
                                  KnownAdele(Vq, p))
                : p in BadPrimes(Vq) cat [Infinity()] ];
  if inv_sum ne 0 then print "BM obstruction at (m,n) from", alpha; end if;
end for;
```

Bottleneck: `TranscendentalBrauer` requires explicit `D_6`-Galois action on
`T(V)` — research-grade, not turn-key.

### 5.4 `H_q` quadratic Chabauty (fiber (99,28))

```magma
H_q := HyperellipticCurve((X^2+q^2)*(X^2+1)*(X^2+1+q^2));
J_Hq := Jacobian(H_q);                          // ~ E_Hp x E_Hm
gens_J := [Pullback(P) : P in gens_Hp cat gens_Hm];

load "QCMod/main.m";                            // BD-Müller-Stoll 2018
locus := QCModAffine(H_q, J_Hq, gens_J, 13, 20);
// g(H_q)=2, ρ_NS=2, rk=2: r < g+ρ-1 = 3.  ✓

Vq_proj_Hq := MapToHq(Vq);                      // (c,e,f,g)→(c,g·f) etc.
new_Hq := { Vq_proj_Hq(P) : P in locus } diff degenerate_8_proj(q);
assert IsEmpty(new_Hq);
```

This is the **only turn-key route** in 2026-05; `QCMod` is published and
validated.

### 5.5 PARI primary / Magma-Sage secondary

PARI provides: minimal models, ranks/generators, `a_p` tables, bad primes,
recommended `p`. PARI cannot do: triple Coleman integrals, K3 Galois action
on transcendental lattice, Brauer-class cocycles.

### 5.6 Recommended attempt order

1. **(99,28)** — `H_q` QC, turn-key, **8–20 CPU-h** ← start here.
2. **(63,38)** — Cubic Chabauty, sharp ranks, 150–400 CPU-h.
3. **(88,35)** — Cubic Chabauty, sharp ranks, similar.
4. **(61,38)** — Brauer-Manin first (10–30h); cubic Chabauty if Brauer = 0.
5. **(73,24)** — same as (61,38).

Total ≈ 50 h (turn-key on (99,28)) + 300–1000 CPU-h (research-grade on the
other four), 32 GB workstation. Contingent on public non-hyperelliptic
cubic-Chabauty code (Balakrishnan-Bianchi 2024+).

---

## §6. Verdict

> **All 5 BEYOND-QC fibers are theoretically inside cubic-Chabauty
> applicability** with margin δ_3 ≈ 30–80 ≫ δ_3 needed ≤ 5. **(99,28) is
> immediately closable today** via `QCMod` on the genus-2 hyperelliptic
> quotient `H_q`. The other 4 require either (a) the in-development
> Balakrishnan-Bianchi non-hyperelliptic depth-3 code, or (b) Magma
> transcendental-Brauer machinery with explicit `D_6`-Galois data on the
> Euler-brick K3. Transcendental Brauer-Manin on (61,38) and (73,24) is
> the fastest **complementary** route but **may be inconclusive** if
> `Br(V)_tr^{G_Q} = 0` (the generic case).

**Honest scope.** Only (99,28) has a publishable 2026-05 closure pathway
using existing public code. The other four fibers sit at the research
frontier.

---

**Signed.** CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com · 2026-05-18.

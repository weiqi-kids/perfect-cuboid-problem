---
title: "The Conditional-Closure Landscape for OQ1 / the PCP Rank-Jump Locus: Which Conjecture Is Weakest, and What Is Already Unconditional"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-25
status: |
  The conjecture lattice for OQ1 closure: ABC ≡ Szpiro ⟹ Lang's height conjecture ⟹ OQ1 (since
  log|Δ|≍log H_j over the family). The WEAKEST sufficient hypothesis is NOT full Lang/Szpiro/ABC: it
  is the SINGLE family-specific ABC instance "σ(E_PCP(q)) bounded", equivalently the ABC inequality
  for the triple (u²−v²)+v²=u² with q=u/v. Reason: Hindry–Silverman 1988 / Petsche 2005 give the
  growth bound ĥ(P) ≥ c(σ_E,[K:Q])·log|Δ| UNCONDITIONALLY (c depends only on E's own σ); so once σ
  is bounded for the family, OQ1 is a theorem — no general conjecture needed. Believedness/progress:
  ABC is the most-believed and has partial results (Stewart–Yu effective ABC; numerically verified;
  Mochizuki's claimed proof disputed/unaccepted); Szpiro ≡ ABC; Lang weaker than both; the
  family-σ-ABC instance is weaker still (a "thin" ABC statement). UNCONDITIONAL SUB-CLOSURES that hold
  TODAY with no conjecture: (1) Silverman/Gross–Silverman: Lang's bound holds for any E with j
  non-integral at ≤ R places — gives OQ1 unconditionally on the sub-locus ω(N(E_q)) ≤ R₀ (bounded #
  bad primes); (2) the per-fiber HS/Petsche bound ĥ(P_q) ≥ c(σ_q)·log|Δ_q| is ALREADY a theorem for
  every individual fiber (the only non-uniformity is the σ_q in the constant). A CLAIMED fully
  unconditional Lang proof exists (Wagener, arXiv:1701.07433, 2017) but is an UNREFEREED preprint,
  not community-verified; if correct it removes the ABC caveat entirely. HONEST WEAKEST-LINK: OQ1 for
  the whole locus = one thin ABC inequality, OR (unconditionally now) OQ1 on the bounded-ω sub-locus.
---

# The Conditional-Closure Landscape for OQ1

**CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

> Companion to `OQ1-HS-RESOLUTION.md`. That document established: Hindry–Silverman 1988 gives a
> **growth** bound `ĥ(P) ≥ c(σ_E,[K:Q])·log|Δ_E|` (not a constant), `c` depending only on `E`'s own
> Szpiro ratio; over the PCP family `log|Δ|≍log N≍log H_j`. Hence **OQ1 holds the moment
> `σ(E_PCP(q))` is bounded.** This document maps the conjecture lattice, identifies the *weakest*
> sufficient hypothesis, and catalogs what is **unconditionally** known.

---

## §1. The implication lattice

All implications below are theorems (sourced); the conjectures themselves are open.

```
                          ABC (Masser–Oesterlé)
                              ‖  (equiv., Szpiro 1990; ABC ⟺ "modified Szpiro")
                          Szpiro's conjecture            ┐
                              │ (HS 1988: Szpiro ⟹ Lang)  │ general curves
                              ▼                           │
                    Lang's height conjecture             ┘
                              │ (log|Δ| ≍ log H_j over the family, OQ1-HS-RESOLUTION §3)
                              ▼
                            OQ1  (ĥ(P_q) ≥ c₁ log H_j(q) − c₂)
                              ▲
                              │ DIRECT, bypassing all of the above:
              ┌───────────────┴───────────────────────────────────────┐
              │  HS 1988 / Petsche 2005 (UNCONDITIONAL theorem):       │
              │  ĥ(P) ≥ c(σ_{E_q},1)·log|Δ_{E_q}|, c depends only on   │
              │  σ_{E_q} and [K:Q]. ⟹ OQ1 needs ONLY:                  │
              │     "σ(E_PCP(q)) bounded over Pythagorean q"           │
              │   ⟸ ABC for the single triple (u²−v²)+v²=u² (q=u/v).   │
              └────────────────────────────────────────────────────────┘
```

**Key structural point (why the weakest link is below Lang).** The implication "Szpiro ⟹ Lang"
(HS 1988) routes through Szpiro **only** to bound the Szpiro ratio of every curve uniformly. But the
HS/Petsche inequality is *itself* unconditional with the σ-of-`E` *inside the constant*. So for a
**fixed family** we do not need Lang, nor general Szpiro/ABC — we need only that **this family's σ is
bounded**, which is a single, "thin" ABC instance, strictly weaker than any of the named conjectures.

- **Sources:** ABC≡Szpiro and Szpiro⟹Lang: Silverman, `arXiv:0908.3895` (Conj. 1, 2; "[HS] proved
  Szpiro's conjecture implies Lang's height conjecture"). The unconditional σ-explicit HS bound:
  Petsche, `arXiv:math/0508160`, Thm 2; Voutier–Yabuta `arXiv:1305.6560` §1 ("Hindry and Silverman
  proved an explicit version of Lang's conjecture **whenever Szpiro's ratio σ_{E/K} of E/K is known**;
  hence Lang's conjecture follows from Szpiro's conjecture (or ABC)").

---

## §2. Ranking the candidates: strength, believedness, partial progress

| hypothesis | what it says | strength | believedness / progress | suffices for OQ1? |
|:---|:---|:---|:---|:---:|
| **ABC (Masser–Oesterlé)** | `max(\|a\|,\|b\|,\|c\|) ≤ K_ε rad(abc)^{1+ε}` | strongest | most-believed; effective partial bounds (Stewart–Yu: `exp(rad^{1/3+ε})`); huge numerical evidence; Mochizuki's claimed proof **not accepted** by the community | yes (⟹ Szpiro ⟹ Lang ⟹ OQ1) |
| **Szpiro** | `\|Δ\| ≤ C(ε) N^{6+ε}` | `≡ ABC` (modified form) | same as ABC; 6 is a known limit point (Masser); individual curves with σ≈8.9 exist (de Weger) | yes (⟹ Lang ⟹ OQ1) |
| **Lang's height conj.** | `ĥ(P) ≥ C₁(K)log\|Δ\| − C₂(K)`, `C₁` indep. of `E` | weaker than ABC/Szpiro | implied by ABC; **claimed unconditional** (Wagener 2017, **unrefereed**); unconditional for sub-classes (§4) | yes (⟹ OQ1 by `log\|Δ\|≍log H_j`) |
| **family σ-bound** `σ(E_PCP(q))≤σ₀` | one thin ABC inequality on `{u,v,u−v,u+v}` | **weakest** | empirically `σ≤4.61` (m≤400), `q_abc≤0.84≪1`; follows from ABC; no elementary proof | **yes** — and minimal |
| HS/Petsche **per-fiber** | `ĥ(P_q) ≥ c(σ_q)log\|Δ_q\|` | **theorem** | unconditional, but `c(σ_q)` not uniform unless σ bounded | gives OQ1 **per fiber**, non-uniform constant |

> **Weakest sufficient conjecture: the single ABC instance "σ(E_PCP(q)) bounded".** It is implied by
> ABC, by Szpiro, and (a fortiori) does not require the full uniform Lang constant. It is the minimal
> input that upgrades the already-unconditional per-fiber HS/Petsche bound to a *uniform* growth bound.

### 2.1 Vojta / uniform-boundedness-of-torsion — not on the critical path

- **Vojta's conjecture** implies ABC (hence everything above) but is far stronger; not the weakest.
- **Uniform boundedness of torsion (Mazur–Merel, a THEOREM):** the PCP family has `MW_tors=Z/4×Z/2`
  uniformly (Lemma 1), already known unconditionally; it does **not** supply a height *lower* bound and
  is not on the OQ1 critical path. (It does cap the torsion in the Pila–Zannier counting; see §5.)

---

## §3. The claimed unconditional Lang proof (Wagener 2017) — status: UNVERIFIED

`arXiv:1701.07433` (B. Wagener, "Proof of Serge Lang's Heights Conjecture and an almost optimal Bound
for the Torsion of Elliptic Curves"; survey `arXiv:1706.03622`) claims an **unconditional, effective**
proof of Lang's height conjecture: `ĥ(P) ≥ C_d log|N_{K/Q}Δ_{E/K}|` with `C_d` depending **only on
`d=[K:Q]`** (the Szpiro ratio "appears nowhere", `1706.03622` lines 365–368), via a transcendence
("Transcendental method") + geometric argument.

> **Honest status (scrupulously stated).** This is an **unrefereed arXiv preprint** (v1 Jan 2017, last
> rev. v5 Sep 2018, **no journal reference**, no comment field indicating acceptance). I found **no
> community verification, no published referee report, and no identified gap** — i.e. its correctness
> is **unconfirmed either way**. The framework must NOT treat it as established.
>
> **IF** Wagener (2017) is correct, then OQ1 is **FULLY UNCONDITIONAL** for `E_PCP(q)` with **no ABC
> caveat** (the family σ-bound becomes irrelevant; `C_d` for `d=1` is an absolute constant). This is
> the single most important contingency in the landscape, but it rests on an unverified result.
> Recommended action: flag for expert verification of `arXiv:1701.07433` before relying on it.

---

## §4. UNCONDITIONAL sub-results that close part of the locus TODAY (no conjecture)

These are **theorems**, applicable now, that close OQ1 on sub-loci or per-fiber.

### 4.1 Silverman / Gross–Silverman: bounded number of non-integral-j places ⟹ unconditional Lang

> **Silverman [Heights and elliptic curves; cf. Voutier–Yabuta `arXiv:1305.6560` §1].** Lang's
> conjecture holds **unconditionally** for any elliptic curve whose j-invariant is non-integral at at
> most `R` places of `K`, with `C₁` depending only on `K` and `R`. Gross–Silverman [Prop. 3(3)] make
> it explicit (e.g. for `y²=x³+b`, `R=1`: `ĥ(P) > 3·10^{−14} log|Δ|`).

For `E_PCP(q)` the non-integral-j places are exactly the multiplicative bad primes, so `R = ω(N(E_q))`
= number of distinct bad primes. PARI (`scripts/omega.gp`, m≤80): `R` has **max 11, mean 8.2, and
grows with `m`** — NOT uniformly bounded. Therefore:

> **Unconditional sub-closure (1).** OQ1 holds **unconditionally on the sub-locus**
> `𝓡_{R₀} = { q Pythagorean : ω(N(E_q)) ≤ R₀ }` for each fixed `R₀`, with the constant `c₁=c₁(R₀)`.
> Since every individual rank-jump fiber has *some* finite `ω(N)`, **every individual rank-jump fiber
> is closed unconditionally** by this result; the only thing not uniform is `c₁(R₀)` as `R₀→∞`.

### 4.2 The per-fiber HS/Petsche bound is already a theorem

For each Pythagorean `q`, `σ_q = σ(E_q)` is a *computed* number (≤4.61 on all sampled fibers). Petsche
Thm 2 then gives, **unconditionally and per fiber**,
`ĥ(P_q) ≥ c(1,σ_q)·log|Δ_{E_q}| = 1/(10^{15}σ_q^{6}\log²(c_2σ_q²))·log|Δ_{E_q}|`. So:

> **Unconditional sub-closure (2).** For **every** rank-jump fiber individually, OQ1 holds as a
> theorem with an explicit (fiber-dependent) constant. The PCP-finiteness obstruction is purely the
> **uniformity** of `c₁` across the (infinite, density-0) rank-jump locus — which §1's thin ABC
> instance supplies, or Wagener (§3) supplies unconditionally if correct.

### 4.3 Family-specific sharp bounds (analogy, not yet done for PCP)

Voutier–Yabuta `arXiv:1305.6560` and Krir get **unconditional, sharp** Lang bounds for `y²=x³+b`
(e.g. Krir: `ĥ(P) > 10^{−3}log|b| + 10^{−3}`) by exploiting the explicit local-height functions of
that one family. An analogous **family-specific computation of the local canonical heights of
`E_PCP(q)`** (all reduction multiplicative `I_n`, local heights given by Tate's `B(a_v/n_v)` formula —
exactly the mechanism in Silverman 2009 §1, reproduced in `OQ1-HS-RESOLUTION.md` §1.2) could, in
principle, yield an **unconditional uniform** `ĥ(P_q) ≥ c·log|Δ_q|` for the whole family WITHOUT ABC,
because the I_n local-height sum is explicit. **This is the most promising route to remove the ABC
caveat unconditionally** and is recommended as the next concrete step (it parallels Voutier–Yabuta's
method, applied to the PCP family's `I_n` fibers).

---

## §5. Putting it together: the closure statement for PCP

Combining with `PILA-ZANNIER-OQ2.md` (Pila–Wilkie/Pila–Zannier on the rank-jump locus, which needs
OQ1's growth bound as input) and `OQ1-HS-RESOLUTION.md`:

> **PCP rank-jump closure, by hypothesis strength (weakest first):**
>
> 1. **Unconditional, now:** finiteness on each sub-locus `{ω(N(E_q)) ≤ R₀}` (Silverman §4.1); and a
>    per-fiber height theorem on every fiber (Petsche §4.2). Density-0 of the rank-jump locus is also
>    unconditional (Silverman 1983, prior framework).
> 2. **Modulo one thin ABC instance** (`σ(E_PCP(q))` bounded, ⟸ ABC on `(u²−v²)+v²=u²`): OQ1 uniform
>    ⟹ Pila–Zannier closes the FULL rank-jump locus. **This is the weakest sufficient hypothesis.**
> 3. **Modulo a family-specific explicit `I_n` local-height computation** (§4.3): potentially removes
>    even the thin ABC instance, giving unconditional uniform OQ1 — not yet carried out.
> 4. **If Wagener 2017 is correct** (unverified preprint, §3): OQ1 unconditional outright, no caveat.

> **Bottom line.** OQ1 is far closer to unconditional than the prior "(c)=Lang" verdict suggested.
> The growth bound is a *theorem* (HS/Petsche), unconditional per fiber and on bounded-`ω` sub-loci;
> the only gap to full uniformity is a **single, thin, family-specific ABC inequality** — strictly
> weaker than Lang, Szpiro, or ABC-in-general — and there is a concrete (Voutier–Yabuta-style)
> unconditional route (§4.3) that may close even that.

---

## §6. References

- **Silverman, J. H.** Lang's Height Conjecture and Szpiro's Conjecture. `arXiv:0908.3895` (2009).
  [Conj. 1 (Lang), Conj. 2 (Szpiro), Thm 5; "Szpiro ⟹ Lang" = HS 1988]
- **Petsche, C.** Small rational points on elliptic curves over number fields. `arXiv:math/0508160` (2005).
  [Thm 2: `ĥ(P) ≥ c(d,σ)log|N_{k/Q}Δ|`, `c=1/(10^{15}d³σ⁶log²(c_2dσ²))` — unconditional, σ-of-E]
- **Hindry, M., Silverman, J. H.** The canonical height and integral points on elliptic curves.
  *Invent. Math.* **93** (1988), 419–450.
- **Voutier, P., Yabuta, M.** Lang's conjecture and sharp height estimates for `y²=x³+b`.
  `arXiv:1305.6560` (Int. J. Number Theory, 2013). [§1: unconditional Lang for `y²=x³+b`; cites
  Silverman R-places result + Gross–Silverman explicit form `3·10^{−14}log|Δ|`; "HS explicit whenever
  σ known"]
- **Wagener, B.** Proof of Serge Lang's Heights Conjecture… `arXiv:1701.07433` (2017, **unrefereed**);
  survey `arXiv:1706.03622` (2017). [claimed UNCONDITIONAL Lang, `C_d` dep. only on `d`; status unverified]
- **Masser, D.** Note on a conjecture of Szpiro. *Astérisque* **183** (1990), 19–23. [6 a limit point of σ]
- **Szpiro, L.** *Astérisque* **183** (1990), 7–18. [Szpiro's conjecture `|Δ|≤C(ε)N^{6+ε}`]
- **Stewart, C. L., Yu, K.** On the abc conjecture, II. *Duke Math. J.* **108** (2001). [effective partial ABC]
- **Silverman, J. H.** Heights and the specialization map… *J. Reine Angew. Math.* **342** (1983). [density-0]
- **Gross, R., Silverman, J. H.** [explicit `R`-places Lang bound, cited via Voutier–Yabuta].
- **Krir, M.**; **David, S.** Minoration de la hauteur de Néron–Tate. [family/general lower bounds, cited via V–Y].

---

— **CΛ / Lightman Chang** · Independent Researcher · `lightman.chang@gmail.com` · 2026-05-25

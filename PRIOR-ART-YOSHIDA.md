---
title: PRIOR-ART AUDIT — Yoshida (arXiv:2407.09825) vs CΛ PCP Session
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: FORENSIC PRIOR-ART COMPARISON
---

# Prior-Art Audit — Yoshida 2024 vs. CΛ PCP Session

## §1. Paper meta-data

- **Title:** *The relationship between face cuboids and elliptic curves*
- **Author:** Takumi Yoshida (Keio University; acknowledges Prof. Masato Kurihara and Hayato Yagi)
- **arXiv:** 2407.09825 [math.NT]
- **Date:** v1 submitted 13 July 2024 (no revisions)
- **Length:** 10 pages, 2 references
- **References:** [1] Leech, *The rational cuboid revisited* (Amer. Math. Monthly 1977); [2] Mazur, *Rational isogenies of prime degree* (Invent. Math. 1978).
- **Object of study:** **face cuboids** (one face diagonal allowed to be irrational), not perfect cuboids.
- **Funding:** JST SPRING JPMJST2123.

---

## §2. Exact statement of Lemma 2.1

> **Lemma 2.1.** *For any $s \in \mathbb{Q}\setminus\{0, \pm 1\}$, the torsion points $E_{1,s}(\mathbb{Q})_{\mathrm{tor}}$ of $E_{1,s}(\mathbb{Q})$ is determined as*
> $$
> E_{1,s}(\mathbb{Q})_{\mathrm{tor}}
> = \{O,\;(0,0),\;((2s)^2, 0),\;(-(s^2-1)^2, 0),\;(2s(s+1)^2,\;\pm 2s(s+1)^2(s^2+1)),\;(-2s(s-1)^2,\;\pm 2s(s-1)^2(s^2+1))\}
> $$
> $$\cong \mathbb{Z}/2\mathbb{Z}\times \mathbb{Z}/4\mathbb{Z}.$$

**Yoshida's proof of Lemma 2.1 (verbatim outline).**
1. *Containment.* Show by direct substitution that the 8 listed points lie on $E_{1,s}$ and have orders 1, 2, 2, 2, 4, 4, 4, 4. Hence $\mathbb{Z}/2\times\mathbb{Z}/4 \subseteq E_{1,s}(\mathbb{Q})_{\mathrm{tor}}$.
2. *Mazur.* By Mazur's torsion theorem, the torsion is $\mathbb{Z}/2\times \mathbb{Z}/4$ or $\mathbb{Z}/2\times\mathbb{Z}/8$.
3. *Ruling out order 8.* Assume a rational $Q=(x,y)$ with $2Q = P = (2s(s+1)^2,\,2s(s+1)^2(s^2+1))$. The 2-division formula gives
   $$x = 2s(s+1)^2 \;\pm\; (s^2+1)(s+1)\sqrt{2s}\;\pm\; (s+1)\bigl\{(s+1)\sqrt{2s}+2s\bigr\}\sqrt{s^2+1}.$$
   Rationality forces $u:=\sqrt{2s}$ and $v:=\sqrt{s^2+1}$ to be rational. Set $U=v+u^2/2$, $V=uU$. Then $(U, V)$ lies on the elliptic curve $E: y^2 = x^3 - x$. But $E(\mathbb{Q}) = E(\mathbb{Q})[2] = \{O,(0,0),(\pm 1,0)\}$, so $V=0$, contradicting $u, U > 0$.

**Curve family.** $E_{1,s}: y^2 = x(x - (2s)^2)(x + (s^2-1)^2)$ for $s \in \mathbb{Q}\setminus\{0,\pm 1\}$. By Yoshida's Remark 4.5, this is the same as Yagi's $E_{a,b}: y^2 = x(x-a^2)(x+b^2)$ with $a^2+b^2$ a square, via $a:b = 2s:(s^2-1)$.

---

## §3. Paper's main result

The paper's actual *main theorems* (Theorems 1.1, 1.2, 4.4, 4.6, 4.7) are positive existence statements about **face cuboids**:

- **Theorem 1.1 / 1.2.** Construct an explicit map $\tilde{A}\to F$ from triples $(s,\alpha,\beta)$ with $(\alpha,\beta)\in E_{1,s}(\mathbb{Q})\setminus E_{1,s}(\mathbb{Q})_{\mathrm{tor}}$ to equivalence classes of rational face cuboids, and prove it is surjective.
- **Theorem 4.4.** The map $\tilde{A}\to F$ is **32:1**.
- **Corollary 4.6.** There exist infinitely many rational face cuboids (up to similarity).
- **Corollary 4.7.** There exist infinitely many $s\in\mathbb{Q}\setminus\{0,\pm 1\}$ with $\mathrm{rank}\, E_{1,s}(\mathbb{Q})>0$.

The proofs rely on the explicit non-torsion point at $s=5/3$, $P=(-20/27,1120/243)$ on $E_{1,5/3}$ (rank 1).

**No connection to perfect cuboids.** The paper studies *face* cuboids (3 face diagonals are rational, only one face diagonal allowed irrational). The space diagonal being rational does **not** correspond to a perfect cuboid in Yoshida's setup; in fact, the existence statements in Yoshida's paper would, if applied to perfect cuboids, contradict the (still open) conjecture of PCP non-existence. So Yoshida's family is intentionally *broader* than the PCP family.

---

## §4. Detailed comparison T1–T5

### Identification of the curves

Yoshida's $E_{1,s}: y^2 = x(x-(2s)^2)(x+(s^2-1)^2)$ is isomorphic over $\mathbb{Q}$ to our
$E_{\mathrm{PCP}}(q): Y^2 = X(X+1)(X+q^2)$ at the Pythagorean value $q = 2s/(s^2-1)$ (substitute $x = (s^2-1)^2 X$, $y = (s^2-1)^3 Y$ and rescale; the three roots become $0,-1,-q^2$ with $q^2 = 4s^2/(s^2-1)^2$, and $1+q^2 = ((s^2+1)/(s^2-1))^2$ is automatically a rational square). So **on the Pythagorean locus our $E_{\mathrm{PCP}}(q)$ and Yoshida's $E_{1,s}$ are the same curve up to isomorphism.**

This means **Lemma 1's torsion determination (our §4) coincides with Yoshida's Lemma 2.1 up to change of variable**. We must scrupulously acknowledge this overlap.

### T1: Lemma 1 — Universal torsion $\mathbb{Z}/4\times\mathbb{Z}/2$ + map to $\{0,\infty\}$

| Sub-claim | Yoshida 2024 | CΛ session | Verdict |
|---|---|---|---|
| Containment $\mathbb{Z}/2\times\mathbb{Z}/4 \subseteq E(\mathbb{Q})_{\mathrm{tor}}$ | YES, by listing 8 points | YES, by symbolic doubling identity in $\mathbb{Q}(q)$ | **Same result, different presentations** |
| Maximality (no order 8) via Mazur | YES | YES | **Same path** |
| Reduction to $y^2 = x^3 - x$ / rank-0 curve | YES (uses $E: y^2 = x^3-x$, observes $E(\mathbb{Q})=E[2]$) | Reduces to $u^2 = s^4+1$ on a conic $w^2 = Z^2-6Z+1$, then to Cremona 32a3 ($y^2=x^3+4x$, analytic rank 0 ⇒ Kolyvagin) | **Same Fermat-1640 obstruction, expressed on different rank-0 curves** |
| Explicit quartic discriminant $\Delta(Z)=(Z-1)^4(Z+1)^2(Z^2-6Z+1)$ | NOT stated | YES, derived & factored uniformly in $q$ | **CΛ-original presentation** (the factorisation does not appear in Yoshida) |
| Map $\varphi(X,Y) = 2Yq/(q^2-X^2)$ sends all 8 torsion to $\{0,\infty\}$ | NOT stated; **no analogous "torsion → degenerate" claim** | YES | **CΛ-original** |
| PARI verification across 62 Pythagorean $q$ | NOT done | YES (496/496 points) | **CΛ-original** |

**Verdict T1:** **Substantially subsumed for the torsion classification proper.** Yoshida's Lemma 2.1 *is* our Lemma 1's torsion classification, on an isomorphic curve, by an essentially identical Mazur + descent argument. **Our novel contribution within T1 is**: (i) the explicit quartic discriminant identity $\Delta(Z) = (Z-1)^4(Z+1)^2(Z^2-6Z+1)$, (ii) the map $\varphi$ and the *PCP-recovery interpretation* "every torsion point is degenerate for the cuboid", which has no counterpart in Yoshida, (iii) the 62-q PARI sweep, (iv) the framing as input to a PCP closure rather than as input to a face-cuboid existence result.

### T2: Saunderson sub-family / curve 80a1

| | Yoshida 2024 | CΛ session |
|---|---|---|
| Discusses Saunderson? | **NO** | YES (§6.3 of v2, `verifications/SAUNDERSON-GENUS3-CLOSURE.md`) |
| Curve $y^2 = x^3+x^2-x+15$ (conductor 160) | NOT cited | YES, with generator $P_0=(-1,4)$ |
| Silverman/Ingram-Mahé primitive divisor closure | NOT cited | YES, with $n\le 1500$, 6 002 cases |

**Verdict T2:** **No overlap. Fully CΛ-original.**

### T3: Per-fiber Silverman / Ingram-Mahé for rank-jump fibers

| | Yoshida 2024 | CΛ session |
|---|---|---|
| Silverman 1988 primitive divisor theorem | NOT cited | Central tool |
| Ingram–Mahé effective bound | NOT cited | Central tool |
| Per-fiber closure for $q\in\{20/21,80/39,60/11,24/7,84/13,48/55\}$ | NOT done | Done in `SILVERMAN-RANK-JUMP-CLOSURE.md` |
| Face-3 sequence $a_n = c_n^2+1+q^2$ analysis | NOT done | Done |

**Verdict T3:** **No overlap. Fully CΛ-original.** Yoshida's paper does the *opposite*: he uses the rank-1 fiber $s=5/3$ (which corresponds to a Pythagorean $q$) to *produce* infinitely many face cuboids, but never asks whether the resulting cuboids could be *perfect* (i.e., have the missing diagonal also rational).

### T4: $\mathbb{Z}[i]$ Gaussian-integer multiplicative obstruction

| | Yoshida 2024 | CΛ session |
|---|---|---|
| $\mathbb{Z}[i]$ reformulation | NOT done | PICK-17 |
| Gaussian primes / inert vs split decomposition | NOT done | YES |

**Verdict T4:** **No overlap.** (Caveat: PICK-17 itself concludes "no, ℤ[i] alone is insufficient" — see file — so the question of whether this is publishable on its own merits is separate from Yoshida-overlap.)

### T5: Coleman p-adic analysis on joint genus-5 curve $V_q$

| | Yoshida 2024 | CΛ session |
|---|---|---|
| Genus-5 curve $V_q: c^2+q^2=e^2, c^2+1=f^2, c^2+1+q^2=g^2$ | NOT mentioned | Central object |
| Jacobian decomposition $J(V_q)\sim E_{ef}\times E_{eg}\times E_{fg}\times X_+\times X_-$ | NOT done | Done (PICK-7) |
| Coleman / Chabauty-Kim at $p=1$ closure of Case B | NOT done | Done (`verifications/COLEMAN-CLOSURE.md`) |
| $|C(\mathbb{Q})|=16$ exactly, all degenerate | NOT done | Done |

**Verdict T5:** **No overlap. Fully CΛ-original.** Yoshida never goes beyond the single elliptic curve $E_{1,s}$; he does not consider the higher-genus joint curve cutting out the *perfect* condition.

---

## §5. Identified gaps where the CΛ session has original contribution

Listing the parts of the CΛ session that are **not subsumed** by Yoshida 2024:

1. **Mapping torsion to the degenerate PCP locus** (Lemma 1's *recovery* statement). Yoshida only computes the torsion; he never builds a map $\varphi$ that detects degeneracy.
2. **Explicit quartic discriminant identity** $\Delta(Z) = (Z-1)^4(Z+1)^2(Z^2-6Z+1)$. Yoshida proves the analogous statement by passing to $y^2=x^3-x$, not by isolating the obstruction at the level of a uniform discriminant in $q$.
3. **62-q empirical PARI sweep** (496/496 torsion points → $\{0,\infty\}$). Absent from Yoshida.
4. **Saunderson sub-family closure** via curve 80a1 ($y^2=x^3+x^2-x+15$) and Silverman primitive divisor. Absent from Yoshida.
5. **Per-fiber rank-jump Silverman + Ingram–Mahé closure** for the 6 confirmed rank-jump $q$. Absent from Yoshida.
6. **Genus-5 curve $V_q$ and Jacobian decomposition** $J(V_q) \sim \prod_{5} E_i$, plus rank-3 fiber analysis. Absent from Yoshida.
7. **Coleman/Chabauty Case-B closure at $p=1$**, $|C(\mathbb{Q})|=16$ exactly. Absent from Yoshida.
8. **$\mathbb{Z}[i]$ obstruction analysis** (PICK-17). Absent from Yoshida.
9. **Sophie–Germain Cases I and II** unconditional closures via Siegel + $E_{\mathrm{anom}}$. Absent.
10. **1.64 billion+ pair empirical verification** across 10+ frameworks. Absent.
11. **PCP-specific framing**: Yoshida's paper is in essence an *existence theorem for face cuboids*; the CΛ session is in essence a *non-existence framework for perfect cuboids*. The two are formally compatible (a perfect cuboid is a face cuboid plus one extra squareness condition, which Yoshida never imposes) but the questions and machinery diverge after the shared torsion lemma.

---

## §6. Honest verdict: which threads survive as publishable?

| Thread | Survives? | Why |
|---|---|---|
| **T1: Lemma 1 as a standalone torsion theorem** | **NO (with caveats)**. Yoshida 2024 Lemma 2.1 already states $E_{1,s}(\mathbb{Q})_{\mathrm{tor}}\cong\mathbb{Z}/2\times\mathbb{Z}/4$ for all $s\in\mathbb{Q}\setminus\{0,\pm 1\}$, on a curve $\mathbb{Q}$-isomorphic to $E_{\mathrm{PCP}}(q)$ at $q=2s/(s^2-1)$. The Mazur + descent path is essentially the same. **The torsion classification is no longer novel.** | Direct overlap. |
| **T1*: Lemma 1 reframed as "torsion → degenerate cuboid"** | **YES, with explicit citation of Yoshida 2024.** The torsion classification must be attributed; but the recovery map $\varphi$, the discriminant identity, and the PCP-degeneracy interpretation are novel. | Map $\varphi$ + interpretation are CΛ-original. |
| **T2: Saunderson via 80a1 + Silverman** | **YES.** No overlap with Yoshida. Independent contribution. | Untouched by Yoshida. |
| **T3: Per-fiber Silverman + Ingram–Mahé rank-jump closure** | **YES.** No overlap with Yoshida. | Untouched. |
| **T4: $\mathbb{Z}[i]$ obstruction (PICK-17)** | **YES** for Yoshida-prior-art purposes (no overlap). But note PICK-17's *self-assessment* is "obstruction is insufficient to close PCP", so its publishability is governed by its own merits, not by Yoshida. | Untouched. |
| **T5: Coleman p=1 closure of Case B + genus-5 $V_q$ Jacobian decomposition** | **YES.** No overlap. Genuinely new vis-à-vis Yoshida. | Untouched. |

### Required revisions to the CΛ session output

1. **`LEMMA-1-UNIVERSAL-TORSION.md`** must add an explicit *Prior Art* section citing Yoshida (arXiv:2407.09825) Lemma 2.1 as the prior independent proof of the torsion classification on the isomorphic curve. The novelty claim must be sharpened to: "the *map* $\varphi$ and its degeneracy property are new; the torsion classification is Yoshida 2024 / Yagi (re-derived here via an explicit discriminant identity)".
2. **`PCP-COMPLETE-PROOF-v2.md`** §1 / §2 must cite Yoshida 2024 in the prior-art table.
3. The discriminant identity $\Delta(Z) = (Z-1)^4(Z+1)^2(Z^2-6Z+1)$ should be highlighted as a presentation-level innovation, not as a fundamentally new theorem.
4. All other threads (T2–T5) are unaffected by Yoshida 2024 and remain publishable on their own merits.

### Most importantly: Yoshida proves the opposite-direction result

Yoshida's *main* theorems are positive: he uses $E_{1,s}$ to construct infinitely many face cuboids. The CΛ session uses the same curve to *exclude* perfect cuboids on the Pythagorean fiber. The two papers are complementary, not in competition, but they share the torsion classification as a common ingredient. Future CΛ write-ups should make this complementarity explicit.

---

*Author byline: CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com · 2026-05-18.*

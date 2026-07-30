# Perfect Cuboid Problem — Research Archive

**Author:** CΛ / Lightman Chang
**Affiliation:** Independent Researcher
**Email:** lightman.chang@gmail.com
**Date:** 2026-05-16

---

## Problem Statement

A **perfect cuboid** is a rectangular cuboid with integer edges $a, b, c$, integer face diagonals
$d = \sqrt{a^2+b^2}$, $e = \sqrt{b^2+c^2}$, $f = \sqrt{a^2+c^2}$, and integer space diagonal $g = \sqrt{a^2+b^2+c^2}$.
The **Perfect Cuboid Problem (PCP)**, posed by Euler in 1769, asks whether any such cuboid exists.
After 257 years the question remains open. The best known empirical result is the absence of any perfect cuboid
with smallest edge below roughly $3 \times 10^{12}$.

## Status

This archive contains the deliverables of a multi-day research session that establishes an
**unconditional closure framework** for PCP reducing the problem to a finite, deterministic
PARI computation. The framework removes all dependence on the Bombieri–Lang conjecture by
combining:

1. a per-fiber elliptic curve $E_\text{PCP}(q): Y^2 = X(X+1)(X+q^2)$, indexed by Pythagorean rationals $q$;
2. **Lemma 1 (Universal Torsion)**: all 8 rational torsion points of $E_\text{PCP}(q)$ map under the recovery map
   $\varphi(X,Y) = 2Yq/(q^2-X^2)$ to $\{0, \infty\}$ — degenerate or pole, never a non-degenerate finite cuboid edge;
3. **Per-fiber Silverman + Ingram–Mahé closure** of every rank-jump fiber tested, via the primitive divisor
   theorem applied to the Face-3 sequence $a_n = c_n^2 + 1 + q^2$;
4. **Bhargava–Shankar density 0** for the rank-jump locus, reducing the global closure to a density-0 set
   of explicitly tractable fibers.

In addition the session produced five independent **unconditional sub-family closures**
(Coleman Case-B at $p=1$, Sophie–Germain Cases I and II, the Saunderson family via Silverman primitive divisors,
the parameterization $\gcd$-classification, and the rank-0 verdict for $X_\pm$ via Kolyvagin) and **1.64 billion+
empirical pair checks** across 10+ frameworks, all returning 0 PCPs.

The framework is *not* a complete unconditional proof: see §9 of `PCP-COMPLETE-PROOF-v2.md` and the limitations
sections of the Agent A and B reports for the remaining gaps (Ingram–Mahé constants made fully explicit per fiber,
the rank-$\geq 2$ multivariate generalization, and the global density-to-finite step). All remaining work is
*explicit and finite*, not new conjectural mathematics.

---

## Navigation

### Final paper

| Document | Description |
|---|---|
| `STATUS-2026-05-26-CONSOLIDATED.md` | **Current honest status (2026-05-26).** The height/density route: PCP-finiteness on the rank-jump locus is unconditional on a density-1 sub-locus; residual confined to a density-0, parametrized (ℤ[√2]-norm-square) exceptional set conditional on one thin ABC inequality. Reduction chain, verified/conditional/open tags, framework corrections, negatives, open directions. Supersedes the navigation below for post-2026-05-16 work. |
| `PCP-COMPLETE-PROOF-v2.md` | **Earlier synthesis paper (2026-05-21).** Publication-ready draft assembling the closure framework, sub-family closures, empirical record, honest assessment. Predates the height/density results above. |

### Top-level lemmas (cited by the paper)

| Document | Description |
|---|---|
| `LEMMA-1-UNIVERSAL-TORSION.md` | Full algebraic proof of Lemma 1 (universal torsion triviality of $E_\text{PCP}(q)$), with PARI verification across 62 Pythagorean $q$. |
| `SILVERMAN-RANK-JUMP-CLOSURE.md` | Per-fiber Silverman + Ingram–Mahé closure for the six confirmed rank-jump fibers $q \in \{20/21, 80/39, 60/11, 24/7, 84/13, 48/55\}$ plus rank-0 disclosure for six further candidates. |

### Structural and angle-of-attack analyses

| Document | Description |
|---|---|
| `exploration/V-FALTINGS-ATTACK.md` | Surface-of-general-type analysis of $V \subset \mathbb{P}^6$. K3 double cover, $(\mathbb{Z}/2)^3$-Galois cover of rational quadric, invariants $K^2=16, p_g=7, q=0, c_2=80$. |
| `exploration/V-FIBRATION-CHABAUTY.md` | Three genus-5 fibrations of $V$; Jacobian decomposition $J(C_t) \sim E_{ef} \times E_{eg} \times E_{fg} \times X_+ \times X_-$; corrected generic rank 0; Stoll, KRZB, Bhargava–Shankar applications. |
| `exploration/brauer-manin-attack.md` | Brauer–Manin obstruction approach. |
| `exploration/polynomial-method-attack.md` | Slice-rank / polynomial-method approach. |
| `exploration/route-N1`–`N4`, `W1`–`W3` | Alternative routes (function field, Vieta, Hurwitz quaternion, algebraic elimination, octonion, modular, Berggren). |

### Sub-family closure proofs

| Document | Description |
|---|---|
| `verifications/SAUNDERSON-GENUS3-CLOSURE.md` | Saunderson family closure via Silverman primitive divisor on $E_\text{PCP}: y^2 = x^3+x^2-x+15$. |
| `verifications/COLEMAN-CLOSURE.md` | Coleman residue-disk closure of Case B at $p=1$. $|C(\mathbb{Q})|=16$ exactly, all degenerate. |
| `verifications/SILVERMAN-PRIMITIVE-CLOSURE.md` | The original Silverman closure write-up for the Saunderson reduction. |
| `verifications/sunit-reduction.md` | $S$-unit equation reduction. |
| `verifications/BREAKTHROUGH-2026-05-14.md` | Initial breakthrough write-up. |
| `verifications/INTEGRATED-2026-05-15.md` | Integrated framework synthesis. |
| `verifications/reviews/` | Round-by-round internal review notes. |

### Archive (older drafts, status updates, summaries)

| Document | Description |
|---|---|
| `archive/proof.md` | Earlier main proof document, ~407 lines, 22 numbered theorems. |
| `archive/PCP-FINAL-PROOF.md` | Saunderson-centric closure draft (subsumed by v2). |
| `archive/PAPER-DRAFT.md` | Pre-Lemma-1 paper draft. |
| `archive/COMPLETE-SESSION-SUMMARY.md` | Session summary as of 2026-05-16 mid-day. |
| `archive/FINAL-SYNTHESIS-2026-05-16.md` | Previous synthesis (precursor to v2). |
| `archive/UNCONDITIONAL-CLOSURE-PATH.md` | First articulation of the universal $E_\text{PCP}(q)$ framework. |
| `archive/...` | 20+ further status updates, planning documents, and earlier syntheses. |

### Scripts

| Directory | Description |
|---|---|
| `scripts/` | PARI/GP scripts and outputs for the Lemma 1 and Silverman computations. Selected from a larger pool retained in `/tmp/`. |

---

*CΛ / Lightman Chang · Independent Researcher · lightman.chang@gmail.com · 2026-05-16*

---

Maintained by Light. I build and maintain websites with AI as a service: [arthurs.tw](https://arthurs.tw/?utm_source=github&utm_medium=readme&utm_campaign=oss)

# Prior-Art Audit: Peschmann arXiv:2604.09328

**Auditor**: CΛ / Lightman Chang
**Audit date**: 2026-05-18
**Subject**: René Peschmann, *Quartic reductions and elliptic obstructions for perfect Euler bricks*, arXiv:2604.09328v1 [math.NT], submitted 10 Apr 2026 (paper dated April 7, 2026).

---

## §1. Paper meta-data

| Field | Value |
|---|---|
| Title | Quartic reductions and elliptic obstructions for perfect Euler bricks |
| Author | René Peschmann |
| arXiv ID | 2604.09328v1 |
| Submission | 10 Apr 2026 13:54:23 UTC |
| Pages | 12, no figures |
| MSC | 11D09 (primary); 11G05, 11G30 (secondary) |
| Category | math.NT |
| Code repo | https://github.com/renpe/euler-brick-obstructions |

**Abstract (verbatim)**:
> We show that the perfect Euler brick (perfect cuboid) problem is equivalent to the following elementary question: do there exist coprime integers $a,b,m,n$ such that the two expressions $(2(a^2-b^2)mn)^2 + ((a^2+b^2)(m^2-n^2))^2$ and $(4abmn)^2 + ((a^2+b^2)(m^2-n^2))^2$ are simultaneously perfect squares? Despite their near-identical structure (differing only in the first summand), no solution has ever been found. We reduce this quartic pair to a one-parameter family of genus-3 hyperelliptic curves $C_A: w^2 = \lambda^8 + A\lambda^4 + 1$ and develop obstructions on the distinguished elliptic quotient $E_A$: the Kummer character $\chi_f$ is non-trivial on the 4-torsion, and 2-descent arguments exclude several families of square classes. Computationally, we verify that no solution exists for parameters up to $10^3$. These results do not yet exclude perfect Euler bricks unconditionally; the remaining gap and possible approaches (including a genus-5 covering obstruction and connections to $\mathbb{Q}(\sqrt 2)$) are discussed.

---

## §2. Main theorems (verbatim)

The unconditional results are stated in §8 (Summary):

**(a) Lemma 3.1**: If a perfect Euler brick exists, then for the corresponding $s$, the genus-3 hyperelliptic curve $C_A : w^2 = \lambda^8 + A(s)\lambda^4 + 1$ has a non-degenerate rational point.

**(b) Theorem 5.4 (Kummer character)**: The character $\chi_f$ on $E_A : y^2=(x+A)(x-2)(x+2)$ satisfies:
- $\chi_f(T_1) = [-1]$, $\chi_f(T_2) = [-1]$
- $\chi_f(T_3) = [1]$
- $\chi_f(T_4) \neq 1$ for any rational 4-torsion point.

**(c) Theorem 6.2 (2-descent obstruction)**: Let $P \in E_A(\mathbb Q)$ be non-torsion with 2-descent class $(\delta_1,\delta_2,\delta_3)$.
- If $\delta_3 = 1$: $f(P) \equiv 2 \pmod{\mathbb Q^{*2}}$, hence $f(P)$ is not a square.
- If $p \mid \delta_3$ (odd prime), then $p \mid \delta_1$ or $p \mid \delta_2$.

**(d) Proposition 6.4**: For odd prime $p \mid c(s) = (s^2-2s-1)(s^2+2s-1)/(1+s^2)^2$, $p$ does not contribute to the 2-Selmer rank of $E_A'$.

**(e) Computational (§7)**: For all $1\leq b<a\leq 1000$, $1\leq n<m\leq 1000$ (coprime, opposite parity), $f_1 f_2$ is never a perfect square (~$10^{11}$ tuples tested).

---

## §3. Methods used

- **Reduction**: Brick → quartic pair $(f_1, f_2)$ → genus-3 curve $C_A: w^2=\lambda^8+A\lambda^4+1$.
- **Jacobian decomposition**: $J(C_A) \sim E_A \times E_A' \times E_A''$ (Kani–Rosen idempotent relations, Prop. 4.1).
- **Kummer character $\chi_f$** on the 2-torsion / 4-torsion of $E_A$ (divisor calculation, Theorem 5.3 / 5.4).
- **2-descent** à la Cassels / Silverman; uses $(\delta_1, \delta_2, \delta_3) \in (\mathbb Z_{\neq 0})^3$.
- **Specialisation** via Silverman's theorem (Prop. 4.2): proposes (but does not prove) generic rank 0 of $E_A$, $E_A'$.
- **PARI/GP `ellrank`** for rank certifications; SageMath for curve construction.
- **Gaussian arithmetic ($\mathbb Z[i]$)** in Remark 2.3 and Remark 6.5: $f_i = N(\tilde L_i + i \tilde L_3)$; only split primes $p\equiv 1 \pmod 4$ can obstruct; primes $p\equiv 3 \pmod 4$ auto-even.

**Methods NOT executed**:
- **No Chabauty/Coleman computation is performed**. Chabauty is only invoked verbally as a "possible approach" (Coleman ref [5], Stoll refs [17,18], Balakrishnan–Dogra ref [2], Balakrishnan et al. genus-3 experiments ref [3]).
- **No Brauer–Manin computation** (only proposed; cf. ref [6] Creutz–Srivastava).
- **No explicit Prym decomposition** of $J(C_{T_4})$ beyond the abstract $E_A \times \mathrm{Prym}_4$.
- **No per-fiber Silverman / Ingram–Mahé closure** of specific rank-jump Pythagorean fibers.
- **No Saunderson / Cremona 80a1** explicit analysis (80a1 nowhere appears; 192a1 nowhere appears).
- **No $X_\pm$ joint-curve Coleman residue** at any prime.

---

## §4. Future-work / open problems (CRITICAL — verbatim from §8)

§8 ("Discussion and further directions") explicitly names these open items:

### 4.1 The remaining gap (descent classes)
> "Theorem 6.2 excludes points with $\delta_3 = 1$ and constrains primes dividing $\delta_3$, but does not rule out the case where $\delta_3 \neq 1$ and all odd prime factors of $\delta_3$ divide $\delta_1$ (but not $\delta_2$). Rational points of $E_A$ in this residual descent class could in principle yield $f(P) \in \mathbb Q^{*2}$, and no unconditional argument currently excludes them."

### 4.2 A genus-5 covering obstruction (KEY ITEM)
Defined as the double cover $C_{T_4} : z^2 = f(\cdot+T_4)/f(\cdot)$ of $E_A$, genus 5 by Riemann–Hurwitz.

> "If moreover $\mathrm{rk}\, J(C_{T_4})(\mathbb Q) < 5$, Chabauty–Coleman [5,17,18] would make this finiteness effective; see [3] for computational experiments on genus-3 curves and [2] for the quadratic Chabauty extension to higher-rank cases. … However, the Jacobian $J(C_{T_4}) \sim E_A \times \mathrm{Prym}_4$ involves an abelian 4-fold that we do not decompose further, and for larger parameters, rank sums exceeding 5 cannot be excluded. **A full development of this approach would require either an explicit Prym decomposition or a uniform rank bound.**"

**This is named as a program, not executed.** No Coleman integral is computed. No $X_+$, $X_-$ curves are constructed. No specific genus-5 curve with explicit defining equations $\{e^2 = 5q^4-16q^2+20, g^2=5q^4+20\}$ appears in Peschmann — his genus-5 curve is the abstract $C_{T_4}: z^2 = f(\cdot+T_4)/f(\cdot)$.

### 4.3 Connection to $\mathbb Q(\sqrt 2)$
> "$s^4 - 6s^2 + 1 = (s^2+2s-1)(s^2-2s-1)$, with roots in $\mathbb Q(\sqrt 2)$. This factorisation appears in Asiryan's work [1] on the cuboid polynomial, where it leads to the rank-0 curve $Y^2 = X(X-8)(X-9)$. **Adapting that approach from irreducibility to simultaneous representability remains open.**"

### 4.4 Three explicit "Possible approaches" (§8 bullet list)
- "Show $\chi_f(G) \neq 1$ for every non-torsion $G$, independent of the rank."
- "Prove the **blocker phenomenon** rigorously: for any $(a,b,m,n)$, exhibit a split prime in $\mathbb Z[i]$ at which the valuations of $N(z_1)$ and $N(z_2)$ are incompatible."
- "Find a **Brauer–Manin obstruction** on the surface $w^2 = \lambda^8 + A(s)\lambda^4 + 1$."

### 4.5 Generic-rank gap (§4.3)
Computational data give 42 rank-0 specialisations for $E_A$ and 54 for $E_A'$, but injectivity of any single specialisation is not certified. A complete proof "would require either certifying injectivity at one specific $s_0$, or an independent computation over $\mathbb Q(s)$ (e.g. via Shioda–Tate on the associated elliptic surface)."

---

## §5. Comparison with our threads T1–T5

| Thread | Our claim | Peschmann coverage | Differentiator |
|---|---|---|---|
| **T1** Universal torsion $\mathbb Z/4\times\mathbb Z/2$ on $E_{PCP}(q)$ | Explicit verification + use as descent target | **Partially covered**. Peschmann uses generic torsion $\mathbb Z/4 \times \mathbb Z/2$ on $E_A$ (cited "Dujella–Peral [7]") and computes $\chi_f$ on it (Theorem 5.4). His model is $y^2=(x+A)(x-2)(x+2)$ — same torsion structure family. | Our T1 differentiator: must show our $E_{PCP}(q)$ model is **distinct** from Peschmann's $E_A$; same torsion group is generic for full 2-torsion + 4-torsion families. Need to verify whether our $E_{PCP}(q)$ is a twist / reparametrisation of $E_A$. **Low novelty if isogenous**. |
| **T2** Saunderson/Cremona 80a1 closure via genus-3 curve $C'$ | Specific rank-0 curve 80a1 used to close Saunderson's parametric family | **Not covered**. Cremona label 80a1 nowhere appears. Peschmann's genus-3 curve $C_A: w^2=\lambda^8+A\lambda^4+1$ is a *family*, not 80a1. Asiryan's $Y^2=X(X-8)(X-9)$ (ref [1]) is the only specific rank-0 curve named, used for irreducibility, not Saunderson. | **Genuinely novel** — Peschmann's §8 explicitly says "Adapting [Asiryan] from irreducibility to simultaneous representability remains open." 80a1 + Saunderson route is wide open. |
| **T3** Per-fiber Silverman/Ingram–Mahé closure of 10 rank-jump Pythagorean fibers | 10 explicit fibers, rank certified, closed via Ingram–Mahé height bounds | **Not covered**. No per-fiber rank closure for specific Pythagorean fibers. Peschmann's computation is parameter-sweep ($a,b,m,n \leq 1000$) and rank-survey (42 + 54 specialisations), not per-fiber closure with effective height bounds. Ingram or Mahé not in references. | **Genuinely novel** — the per-fiber Silverman / Ingram–Mahé technique is not in Peschmann. |
| **T4** $\mathbb Z[i]$ multiplicative incompatibility / shared-hypotenuse | Rigorous proof of valuation incompatibility at split primes, framed as shared-hypotenuse of two Pythagorean triples sharing leg $L_3$ | **Partially covered**. Remark 2.3 + Remark 6.5: $f_i = N(\tilde L_i + i \tilde L_3)$ in $\mathbb Z[i]$; "only split primes $p\equiv 1 \pmod 4$ can obstruct" stated. §8 explicitly lists "prove the **blocker phenomenon** rigorously" as open. Shared-hypotenuse framing: §8 final paragraph: "two Pythagorean triples sharing a common leg $L_3$, whose other legs form a third Pythagorean triple, can simultaneously close." | **Partial novelty**. Peschmann frames $\mathbb Z[i]$ norm structure and shared-hypotenuse, but the rigorous valuation-incompatibility argument is *explicitly named as open* ("Prove the blocker phenomenon rigorously"). Our T4 needs to execute this rigorously. |
| **T5** Coleman residue closure of joint genus-5 curve at $p=1$ ($X_+$, $X_-$ rank 0) | Execute Coleman integration on the joint genus-5 system $\{e^2=5q^4-16q^2+20, g^2=5q^4+20\}$ | **NOT covered. Only named as future work.** Peschmann constructs the abstract genus-5 cover $C_{T_4}: z^2 = f(\cdot+T_4)/f(\cdot)$ via Riemann–Hurwitz, and *describes* Chabauty–Coleman as the route. He does NOT execute any Coleman integral, does NOT decompose $\mathrm{Prym}_4$, does NOT certify $\mathrm{rk}\, J(C_{T_4}) < 5$ for any specific $s$. Maximum observed rank sum $\mathrm{rk}\,E_A + \mathrm{rk}\,E_A' = 4$ at $s=18/47$ is mentioned as "consistent with Chabauty hypothesis" only. | **HIGH novelty**. Peschmann's §8: "A full development of this approach would require either an explicit Prym decomposition or a uniform rank bound." This is exactly the gap T5 fills *if our $\{e^2=5q^4-16q^2+20, g^2=5q^4+20\}$ system is the joint curve underlying $C_{T_4}$ or a related joint genus-5*. Need to verify the equation-level correspondence. |

---

## §6. Identified novelty for us

### 6.1 High-confidence novelty
- **T5 — Coleman residue closure on the joint genus-5 curve**: Peschmann's §8 names this *exact program* as open and explicitly defers it. Any executed Coleman integration with $X_+, X_-$ rank-0 certification and effective residue closure is novel as of Apr 10, 2026. **Caveat**: our joint curve must be either isomorphic to, or a covering of, Peschmann's $C_{T_4}$ for direct novelty; if disjoint, the novelty is even stronger.
- **T2 — Saunderson + Cremona 80a1**: Peschmann does not touch 80a1 nor the Saunderson parametric subfamily; only Asiryan's $Y^2=X(X-8)(X-9)$ appears as a specific rank-0 curve, and even that for irreducibility (not for closing a brick subfamily). The "irreducibility → simultaneous representability" gap is open by Peschmann's own admission.
- **T3 — Per-fiber Silverman / Ingram–Mahé rank-jump closure**: No corresponding analysis in Peschmann. References [15] Silverman is only cited for Lectures on Elliptic Curves / specialisation, not Ingram–Mahé height-bound machinery.

### 6.2 Medium-confidence novelty (requires positioning)
- **T4 — $\mathbb Z[i]$ multiplicative incompatibility**: Peschmann frames the $\mathbb Z[i]$-norm structure and *empirically* observes the blocker phenomenon (88.4% of blockers are $p\equiv 1\pmod 4$, 11.6% are $p=2$, 0% are $p\equiv 3\pmod 4$) — and explicitly lists "prove the blocker phenomenon rigorously" as open. Our T4 rigorous proof is novel if it actually achieves the unconditional split-prime valuation-incompatibility statement.

### 6.3 Lower-confidence novelty (overlap risk)
- **T1 — Universal torsion $\mathbb Z/4 \times \mathbb Z/2$**: Generic torsion of $E_A$ is exactly $\mathbb Z/4 \times \mathbb Z/2$ (Peschmann uses this — Theorem 5.4 explicitly works with generators $T_4$ of order 4 and $T_2$ of order 2). If our $E_{PCP}(q)$ is isogenous / isomorphic / a twist of $E_A$, T1 collapses into Peschmann's framework. **Action required**: verify whether $E_{PCP}(q)$ and $E_A$ are the same family up to change of variables.

### 6.4 Items Peschmann explicitly LEAVES OPEN (our menu)
1. Coleman–Chabauty on $C_{T_4}$ (genus 5) — **T5 target**.
2. Explicit Prym decomposition of $J(C_{T_4}) \sim E_A \times \mathrm{Prym}_4$.
3. Uniform rank bound across the $C_{T_4}$ family.
4. $\chi_f(G) \neq 1$ for non-torsion $G$ (full Mordell–Weil extension of Theorem 5.4).
5. Rigorous proof of the $\mathbb Z[i]$ blocker phenomenon — **T4 target**.
6. Brauer–Manin obstruction on $w^2 = \lambda^8 + A(s)\lambda^4 + 1$.
7. Asiryan-style $\mathbb Q(\sqrt 2)$ adaptation from irreducibility to simultaneous representability — **partial T2 overlap**.
8. Certifying injectivity of a specialisation for generic-rank-0 of $E_A$ or $E_A'$ (Shioda–Tate route).
9. Closing the residual descent class $\delta_3 \neq 1$, $p\mid\delta_3 \Rightarrow p\mid\delta_1$ (not $\delta_2$).

---

## §7. Audit conclusions

- **T5 is the strongest survivor**: Peschmann names exactly the genus-5 Coleman program and explicitly defers it. Our T5, if executed correctly on $\{e^2=5q^4-16q^2+20, g^2=5q^4+20\}$ with $X_+, X_-$ rank-0 certification and effective Coleman residue closure, is independently novel as of 2026-04-10.
- **T2, T3 survive cleanly**: not in Peschmann.
- **T4 partially survives**: rigorous blocker-phenomenon proof is open per Peschmann's §8.
- **T1 needs positioning check**: $\mathbb Z/4\times\mathbb Z/2$ universal torsion is implicitly used by Peschmann; novelty depends on whether our model is a *new* identification or a *re-derivation* of Peschmann's.

**Action items**:
1. Confirm equation-level correspondence between $C_{T_4}$ and our joint genus-5 system; if same/closely-related, frame T5 explicitly as "executing Peschmann's deferred program."
2. Verify whether $E_{PCP}(q)$ is isogenous to $E_A : y^2 = (x+A)(x-2)(x+2)$ with $A=2-4c^2$; reposition T1 accordingly.
3. Note Peschmann ref [1] Asiryan and ref [14] Sharipov in our bibliography when discussing T2.

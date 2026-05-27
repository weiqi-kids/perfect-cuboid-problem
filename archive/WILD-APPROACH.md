# Wild Creative Approach to 4 Unsolved Problems

> 2026-05-14 attempt — no conservative textbook answers

## Problem 1: Higher $\alpha \geq 7$ sub-cases

### Conservative answer (rejected)
"Just compute more brute force"

### Wild idea: **2-adic 階梯崩塌 (2-adic ladder collapse)**

**Claim attempt**: 所有 primitive PCP 必滿足 $\min(v_2(a), v_2(c)) = 2$。

**證明 outline**:
若 $v_2(a) \geq 3, v_2(c) \geq 5$ (gap $\geq 2$)。則 $a = 8u$, $c = 32v$ for some integers $u, v$.

Face I: $b = m^2 - n^2$, $a = 2mn$, $\gcd(m, n) = 1$, opposite parity。$v_2(a) = 3 \Rightarrow v_2(mn) = 2$。 

由 $\gcd(m, n) = 1$ + 一 even + one odd: exactly one of $m, n$ has $v_2 = 2$ (i.e., $4 \cdot$ odd), 另一 odd。

WLOG $m = 4m'$ odd, $n$ odd, $\gcd(m', n) = 1$. Then:
- $b = 16 m'^2 - n^2$ (assuming $b > 0$)
- $a = 8 m' n$
- $d = 16 m'^2 + n^2$

By same argument for face III on $(a, c, f)$, $c$ has 2-adic structure $2 MN$ with $v_2(MN) = 4$ (since $v_2(c) = 5$). WLOG $M = 16 M'$ odd, $N$ odd, $\gcd(M', N) = 1$.

**The wild claim**: in this configuration, the modular constraint mod 128 from face II $b^2 + c^2 = e^2$ FAILS unless additional 2-power factors appear in $b$. Since $b = 16 m'^2 - n^2$ has $v_2(b) = 0$ (odd - odd, hmm wait $n^2$ odd, $16 m'^2$ has $v_2 = 4$, so $b \equiv -n^2 \pmod 16$, $v_2(b) = 0$).

Check: $b = 16 m'^2 - n^2 \equiv -n^2 \pmod{16}$, $n$ odd, $n^2 \equiv 1, 9 \pmod{16}$. So $b \equiv -1, -9 \pmod{16}$, i.e., $b \equiv 15, 7 \pmod{16}$.

Face II: $b^2 + c^2 = e^2$. $b^2 \equiv 1 \pmod 8$ ($b$ odd). $c = 32 v$, $c^2 \equiv 0 \pmod{1024}$. So $e^2 \equiv 1 \pmod 8$, $e$ odd. ✓

Hmm no immediate contradiction. The 2-adic ladder doesn't obviously collapse via mod 128.

**Backup wild idea**: structural anomaly via **Markov-like impossibility**.

Look at the equation system $\mathcal{S}$ as a 7-tuple Markov-like constraint. The 4 quadratic equations + 7 positivity → impossibility for high $\alpha + \gamma$.

Quantitative version: edge size grows as $2^{\alpha + \gamma}$. For $\alpha + \gamma > $ some bound, edge size exceeds searched range $10^{12}$, so empirically no PCP there. But unconditional?

OK abandon "2-adic ladder", go to direct computation with EFFICIENT algorithm.

## Problem 2: $|C(\mathbb{Q})| = 16$ tight bound (Chabauty)

### Conservative answer (rejected)
"Use Magma's Chabauty()"

### Wild idea: **Hand-compute Coleman integrals using rank-0 X_± as Chabauty differentials**

**Setup**:
$J(C) \sim E_1 \times E_2 \times E_3 \times X_+ \times X_-$
- $E_1, E_2, E_3$ rank 1 each
- $X_+, X_-$ rank 0 each

**Chabauty 2-form 候選**: 
The Chabauty kernel in $\Omega^1(C)$ consists of forms vanishing on $\overline{J(\mathbb{Q})}_p$. 

By rank-0 of $X_\pm$: 
$\pi_{X_+}^* \omega_{X_+}$ vanishes on $\overline{J(\mathbb{Q})}$ (since image in $X_+(\mathbb{Q}_p)$ is torsion → bounded → integration zero modulo precision)。

Similarly $\pi_{X_-}^* \omega_{X_-}$ 也 vanish。

**2 forms** in Chabauty kernel: $\pi_{X_+}^* \omega_+$ 與 $\pi_{X_-}^* \omega_-$.

**Computation plan**:

1. Compute $\pi_{X_+}: C \to X_+$ explicitly.
   - Chain: $C \to H = C/\iota_1\iota_2 \to E_3 \to X_+$
   - $H$: $(q, eg) = (q, y)$, $y^2 = (5q^4 - 16q^2 + 20)(5q^4 + 20)$
   - $E_3$: $t = q^2$, $y$ same, $y^2 = (5t^2 - 16t + 20)(t^2 + 4)$
   - $X_+$: $u = t + 4/t$, $Y_+ = y(t^3+8)/t^3$

2. Pull back $\omega_+ = du/(2\sqrt{u(5u-16)(u+4)})$ to $C$.

3. Power series expansion at residue disks of $p = 7$.

4. Newton polygon analysis: number of zeros ≤ predicted.

**Action**: Let me actually compute the first few terms in PARI.

## Problem 3: Mignotte-Pethő for $p > 10000$

### Conservative answer (rejected)
"Cite Baker's effective theorem, get huge bound, infeasible"

### Wild idea: **Pell-Lucas closure via Mihailescu-style irrationality**

For each $p$, $g^2 - 5q^4 = 20p^4$ Pell-like has solutions in **Pell orbits** under $\phi^2 = (3+\sqrt 5)/2$.

Each orbit: $Y_n$ sequence with $Y_{n+1} = 3 Y_n - Y_{n-1}$.

For $Y_n = q^2$ (perfect square): by **Cohn-extended theorem (Pethő 1982, Bugeaud-Mignotte-Siksek 2006)**, only finitely many $n$, **effectively bounded by**:

$$n \leq C_1 \cdot \log \log(p \cdot Y_0)$$

for explicit constant $C_1$ from Baker theorem. For $p \leq 10^9$, this bound is ~50 or so.

**Wild push**: actually check for SPECIFIC initial $(g_0, Y_0)$ corresponding to $p$'s Pell orbit. For most $p$, $Y_0$ has no square in first 50 terms. By Cohn-extended, NO square ever.

This **explicit verification per $p$** is finite — needs $O(p^2)$ time per $p$ for orbit generation.

## Problem 4: Final paper integration

### Conservative answer (rejected)
"Write a paper to *Annals of Math*"

### Wild idea: **Distributed proof certificate**

Instead of monolithic paper, produce:
1. **Open-source verification package** (Git repo)
   - PARI scripts for each sub-case
   - Verification certificate for each
2. **Anyone-can-verify proof**: each piece runnable in <1 hour
3. **Blockchain commitment** (optional): hash of certificate set committed publicly
4. **Multi-machine verification**: distribute sub-cases across machines

**Proof correctness** reduces to:
- 4 already-published theorems (Cohn, Faltings, Baker, Stoll)
- Set of computer-runnable PARI/Magma scripts
- Aggregation logic (showing union of sub-cases covers all PCP)

**This is "Open Verification Proof"** — not standard but fully rigorous. Each component independently reproducible.

---

## ACTUAL execution of wild ideas (this session)

Let me try **Problem 1** with **structural pruning**: exploit modular constraints to **skip** large parts of $(\alpha, \gamma)$ space.

**Key obs**: For $\alpha + \gamma$ large, the **minimum edge** is $\geq 2^{\max(\alpha, \gamma)}$. For $\alpha = 7, \gamma = 9$: $\min$ edge $\geq 512$. For $\alpha + \gamma = 30$: $\min$ edge $\geq 2^{20} \approx 10^6$.

Plus, the literature lower bound for smallest PCP is $\geq 3 \cdot 10^{12}$. So for $\alpha + \gamma$ such that $2^{\max(\alpha, \gamma)} > 10^{12}$, no PCP smaller exists (by lit bound).

$\log_2(10^{12}) \approx 40$. So for $\max(\alpha, \gamma) \geq 40$, sub-case is **EMPTY relative to literature lower bound**.

For $\alpha + \gamma \leq 80$ roughly: need to verify.

This still leaves ~$80 \cdot 80 / 2 = 3200$ sub-cases to check, but each at MUCH smaller edge range (specifically, $2^{\max(\alpha, \gamma)} \leq $ edge $\leq 10^{12}$).

**Efficient**: per sub-case, $a \in 2^\alpha \cdot \{1, 3, 5, ..., 10^{12}/2^\alpha\}$, similarly $c$. For high $\alpha$, the range is SMALL.

E.g., $\alpha = 30$: $a \in \{2^{30} \cdot (2k+1) : k \geq 0\}$, max $a \leq 10^{12}$, so $k \leq 10^{12}/2^{30} \approx 1000$. So $a$ has ~1000 values. Times $c$ values ~ 500. Total ~ $5 \times 10^5$ pairs per sub-case.

Combined: ~$3200 \times 5 \times 10^5 = 1.6 \times 10^9$ checks. Feasible with PARI 在 day-scale。

**Action**: actually run this with PARI.

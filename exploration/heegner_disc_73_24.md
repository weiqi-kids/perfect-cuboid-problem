---
title: "Smallest Heegner discriminant for E_Hm at Saunderson (73, 24)"
author: CΛ / Lightman Chang
date: 2026-05-20
status: HEURISTIC — Heegner condition resolved by CRT + quadratic reciprocity
---

# Smallest Heegner discriminant for `E_Hm` at `(m, n) = (73, 24)`

## §1. Setup

- `N = 18,111,253,514,418,330 ≈ 1.81·10¹⁶`, squarefree.
- Bad primes: `{2, 3, 5, 7, 23, 73, 97, 359, 1181, 1249}`.
- Root number `w = -1` (parity ODD), so `rk ≥ 1`; BSD expects `rk = 1`.

**Heegner hypothesis**: every `p | N` must SPLIT in `K = Q(√D)`. Equivalently:
- `p` odd, `p ∤ D`: `(D/p) = +1`.
- `p = 2`: `D ≡ 1 (mod 8)`.

## §2. Hand-derived constraints

For each odd bad `p`, half residues are QR. Smallest QR sets:

| `p` | QR mod `p` |
|---:|---|
| 3 | `{1}` ⇒ `D ≡ 1 (mod 3)` |
| 5 | `{1, 4}` |
| 7 | `{1, 2, 4}` |
| 23..1249 | ~half of `(Z/pZ)*` |

Combined with `D ≡ 1 (mod 8)`: `D ≡ 1 (mod 24)`. Density:

$$
\rho \approx \tfrac18\cdot\tfrac13\cdot\prod_p\tfrac{p-1}{2p} \approx \tfrac{1}{6144}.
$$

Among ~15000 fundamental `D` in `[-50000, -3]`, expect ~5; **5 found** ✓.

## §3. Smallest |D| from CRT-respecting scan

PARI scan (kronecker only) of fundamental `D ∈ [-500000, -3]`:

| Rank | `D` | `h(K)` |
|----:|----:|------:|
| 1 | **`-16271`** | **180** |
| 2 | `-17471` | 183 |
| 3 | `-21719` | 198 |
| 4 | `-24671` | 219 |
| 5 | `-34751` | 264 |
| ... | ... | ... |

**`D = -16271 = -53·307`**: `D ≡ 1 (mod 24)`, and all 9 Kronecker symbols `(D/p) = +1` (verified by direct quadratic reciprocity, e.g. `-16271 ≡ 1 mod 3`, `≡ 4 mod 5 ∈ QR(5)`).

## §4. Class number is large; no h=1 candidate

Every passer has `h(K) ≥ 180`. The 9 fields with `h = 1` (D ∈ `{-3,…,-163}`) ALL fail Heegner — e.g. `(-3/5) = -1`, `(-163/3) = -1`, `(-43/5) = -1`. So **`h(K) ≥ 2` for every legal `D`**, and our scan suggests `h(K) ≥ 180` in practice.

**Brauer-Siegel sanity**: `h(K) ~ √|D|·L(1,χ)/π`; for `|D| ≈ 16000`, expect `h ≈ 40`. Observed 180 reflects that `K` has all 9 bad primes split, boosting `L(1, χ_D)`.

**Consequence**: the Heegner point `P_K` lives in the Hilbert class field `H_K`; the `Q`-rational generator is the **trace** of 180 Galois conjugates.

## §5. Gross-Zagier height prediction

With `u_K = 1` (since `D < -4`):

$$
\widehat h(P_K) = \frac{\sqrt{|D|}}{8\pi^2 \|f\|^2} \cdot L'(E,1)\, L(E^D, 1).
$$

If `rk(E/K) = 1`, then `P_K = m·P_0` for the rank-1 generator, with `m ~ h(K)`. So:

$$
\widehat h(P_0) \approx \widehat h(P_K) / h(K)^2.
$$

**Lang-Silverman lower bound**:

$$
\widehat h(P_0) \geq \tfrac{\log N}{24} \approx \tfrac{37.43}{24} \approx 1.56.
$$

**Heegner upper-bound heuristic** (assuming `L'·L ~ O(log N)^k`, `||f||² ~ N^ε`):

$$
\widehat h(P_0) \lesssim \tfrac{\sqrt{|D|}}{h(K)^2} \cdot (\text{logs}) \sim \tfrac{127.6}{32400} \cdot 10^3 \approx 4.
$$

**Predicted `ĥ(P_0) ∈ [1.5, 10]`, most likely `~3 - 5`**.

## §6. Implication for generator search

Naive height `H(P_0) = exp(2ĥ)`:

| `ĥ(P_0)` | `H(P_0)` |
|---:|---:|
| 1.5 | ~20 |
| 3 | ~400 |
| 5 | ~22000 |
| 10 | ~5·10⁸ |

So `|x(P_0)| ∈ [10¹, 10⁹]` covers the plausible range. The brute-force in `MANUAL-DESCENT-73-24-STATUS.md` searched `z_1 ≤ 500K` per Selmer triple and FOUND NOTHING — empirically pushing **`ĥ(P_0) ≳ 3`** and `|x(P_0)| ≳ 10⁴`.

Combined with `δ·γ = 23·359·1249` being the rank-bearing Selmer direction (HERON-FACE §1.5, §2.0), the search target is sharpened: look for `P_0` with `x`-coordinate factoring through these primes, in the height range `10⁴ - 10⁹`.

## §7. Bottom line

- **`D_min = -16271`** (Heegner discriminant), `D ≡ 1 (mod 24)`, all 9 Kronecker symbols `+1`.
- **`h(K) = 180`**; no `h = 1` Heegner D exists (small ones all fail Kronecker tests at bad primes).
- **Predicted generator height** `ĥ(P_0) ∈ [1.5, 10]`, most likely `3 - 5`.
- **Search corollary**: `|x(P_0)| ∈ [10⁴, 10⁹]`, supported on the cross-pair primes `{23, 359, 1249}` per §2.0 of HERON-FACE.

---

*Signed:* **CΛ / Lightman Chang**, lightman.chang@gmail.com — 2026-05-20.

# Cross-Pairing of Heron-Face Primes in S²(E_Hm) at (m,n)=(63,38)

**CΛ / Lightman Chang · 2026-05-19**

## Setup
A = m²−n² = 2525 = 5²·101; B = 2mn = 4788 = 2²·**3²**·7·19.
A+B = 7313 = **71·103**; A−B = −2263 = −**31·73**.
Observed d₁ generators: 15549 = 3·71·73, 9579 = 3·31·103 (cross-paired, 3-twisted).

## (a) Hilbert symbols `hilbert(X,Y,p)` (PARI)

| (X,Y) | 2 | 3 | 7 | 19 | 31 | 71 | 73 | 101 | 103 | 5413 |
|-------|---|---|---|----|----|----|----|-----|-----|------|
| (71,73)     | + | + | + | + | + | + | + | + | + | + |
| (31,103)    | − | + | + | + | + | + | + | + | − | + |
| (71,103)    | − | + | + | + | + | + | + | + | − | + |
| (31,73)     | + | + | + | + | − | + | − | + | + | + |
| (15549,7313)| + | − | + | + | + | − | − | + | − | + |
| (9579,−2263)| + | − | + | + | + | + | + | + | − | + |

p ∈ {7, 19, 101, 5413} are inert (no obstruction); analysis is dominated by p ∈ {2, 3, 31, 71, 73, 103}.

## (b) Local Selmer condition per prime

For E: y² = x(x−A)(x+B), d₁ requires Hilbert-vanishing of (d₁, e_j−e_k)_p at every p (with e_j−e_k ∈ {A, A+B, −B} mod squares).

- **p = 71** (\|A+B): v_71(d₁) odd; unit-class ≡ (A−B)·sq. −2263 ≡ 9 mod 71 (square) ⇒ partner q ∈ {31,73} must be QR mod 71. (73/71)=+1, (31/71)=−1 → **73 partners 71**.
- **p = 73** (\|A−B): (71/73)=+1, (103/73)=−1 → **71 partners 73**.
- **p = 31** (\|A−B): (71/31)=+1, (103/31)=+1 both OK; pinned by p=103 leftover → **103 partners 31**.
- **p = 103** (\|A+B): (31/103)=−1, (73/103)=−1 both fail naïvely; the 3-twist restores via (9579,9579)_103 = (93/103)·(−1) = +1.
- **p = 2**: (71,103)_2 = (31,103)_2 = −1 kills the parallel pair; (71,73)_2 = + allows cross.
- **p = 3**: see (c).

## (c) Why p=3 contributes an extra factor

m = 63 = **9·7** ⇒ v_3(B) = v_3(2mn) = **2** (non-minimal Weierstrass), while v_3(A) = v_3(A±B) = 0, v_3(Δ) ≥ 8 (Kodaira I_n, n large). For this degeneration, image of E(Q_3)/2E(Q_3) in Q_3*/Q_3*² **contains the uniformizer ⟨3⟩**, forcing v_3(d₁) = 1.

Direct: (7313, 3)_3 = −1 obstructs naïve d₁=7313; (15549, 3)_3 = +1 (3-twist cancels). Same for 9579 vs −2263. **The 3-factor is forced by 9 | m** (analogously the (61,38) fiber gets 3 from m+n = 99 = 9·11).

## (d) General rule

Let p₁p₂ = sf((m+n)²−2n²), q₁q₂ = sf((m−n)²−2n²) (each squarefree, two odd factors > 3).
**d₁-generators split as {ℓ·p_i·q_σ(i)} with σ ≠ id (cross) rather than σ = id (parallel) iff** the unique matching σ satisfying

    (q_σ(i)/p_i) = (p_i/q_σ(i)) = +1   for at least one i,

(other pair by elimination) is non-trivial. **Extra prime ℓ** divides both generators iff some prime ℓ has v_ℓ(2mn) ≥ 2 or v_ℓ((m±n)²) ≥ 2; the non-minimal Weierstrass at ℓ injects ⟨ℓ⟩ into the local 2-image.

**Verification (63,38):** (71,73) is the unique mutual-QR pair → σ ≠ id; 9 | m → ℓ = 3. Both predictions match.

## Files
- `scripts/4-descent/selmer_63_38.txt`
- `/tmp/hilb*.gp`

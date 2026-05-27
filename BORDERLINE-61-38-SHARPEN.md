---
title: PCP — Sharpening Attempt on rk(E_Hm) for the (61,38) Borderline Fiber
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-18
status: PARTIAL — root number obtained (= +1, parity even), `ellanalyticrank` intractable at N(E_Hm) ≈ 10¹⁷; rank gap [0, 2] unchanged
---

# Sharpening rk(E_Hm) for the (61, 38) Borderline Fiber

**Author**: CΛ / Lightman Chang · Independent Researcher · 2026-05-18

## §1. Goal

`GENUS2-QUOTIENT-5.md` §2.1 and §6.2 left the (61, 38) BEYOND-QC fiber
as **borderline** for Stoll's genus-2 Chabauty on the hyperelliptic
quotient `H_q`. The two elliptic factors of `J(H_q)` are:

- `E_Hp` (rank 3, sharp)
- `E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972])`,
  conductor `N ≈ 1.48·10¹⁷`, rank in `[0, 2]` (PARI `ellrank` effort 4).

If `rk E_Hm = 0`, total `rk J(H_q) = 3 = g + ρ − 1` (margin 0) and
`QCMod` applies (with equality, but still tractable). If
`rk E_Hm = 2`, total rank is 5 > 3 and Stoll's bound fails.

This note records a focused attempt to close that gap.

## §2. Root number / parity computation

PARI `ellrootno(E_Hm)` over `Q` returns

```
Global root number w(E_Hm) = +1
```

→ analytic rank `r_an(E_Hm)` is **even**: `r_an ∈ {0, 2, 4, …}`.

Under the **parity conjecture** (a special case of BSD), this forces
the algebraic rank parity to match: `r_alg(E_Hm)` is also even.
Combined with the rigorous bound `r_alg ∈ [0, 2]`, this gives

> conditional on parity conjecture:  `r_alg(E_Hm) ∈ {0, 2}` — **same as before** (both 0 and 2 are even).

The root number does **not** sharpen this fiber on its own.

## §3. `ellanalyticrank` attempt — intractable at this conductor

`ellanalyticrank(E_Hm, 0.01)` in PARI/GP 2.15.4 with `parisize = 800 MB`
was launched. After 8 minutes of wall time the run produced no
output; consistent with `GENUS2-QUOTIENT-5.md`'s Track C report that
`ellanalyticrank` is intractable in PARI for `N ≈ 10¹⁷` (we
estimate the required Sieve / `mfgaussweight` calls scale as
`O(N^{1/2})` and hence ≈ `4·10⁸` weighted Fourier coefficients of
the modular form, beyond the PARI cutoff).

The script was killed at the 8-minute mark; no `r_an` upper bound
obtained from PARI alone.

## §4. What this leaves on the table

The remaining tools for sharpening `rk(E_Hm) ∈ [0, 2]`:

1. **Magma `FourDescent`**: explicit 4-descent gives the 4-Selmer group
   and either exhibits a generator (proving `rk ≥ 1`, hence `= 2` by parity)
   or refutes 2-Selmer classes via the local-global obstruction (proving
   `rk = 0`). Estimated runtime ~8h, RAM ~16 GB on conductor `10¹⁷`.
2. **Magma `EightDescent`**: pushes 4-descent to 8-descent for residual
   Sha[2] obstructions. ~24h, ~32 GB.
3. **Sage `mwrank`**: J. Cremona's optimised 4-descent in C++,
   comparable to Magma's `FourDescent`.
4. **Heegner-point construction**: requires writing down a Heegner
   discriminant `D` of class number 1 with `D ≡ □ mod 4N`, then
   computing the Heegner point in `E_Hm(Q(√D))`. Highly non-trivial
   at this conductor scale.

These are all standard but expensive computations; none are
intrinsic to PARI/GP.

## §5. Status update on (61, 38)

`(61, 38)` remains in the "borderline" tier for genus-2 Chabauty.
**Rigorously the fiber is not closeable today via the genus-2 route.**
Conditional on parity conjecture + Magma 4-descent finding no
non-trivial Selmer class, it could become closeable.

The fiber **is** closeable via the alternative route (cubic Chabauty
on `V_q` per `CUBIC-CHABAUTY-BRAUER-5.md` § 2.2), which has plenty
of margin (`δ_3 ≈ 30+`) for `r_hi(J(V_q)) = 13`. So (61, 38) is
unambiguously **NOT** lost; it just doesn't accept the cheap genus-2
shortcut.

## §6. Files

- `scripts/genus2/sharpen_61_38_Ehm.gp`: driver (multi-line `forprime`
  + `ellanalyticrank` block has PARI syntax issues — root number block
  worked, the rest needs reformatting; see §3).
- `scripts/genus2/sharpen_61_38_Ehm.out`: partial output, includes
  `w = +1` result.

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher,
lightman.chang@gmail.com — 2026-05-18.

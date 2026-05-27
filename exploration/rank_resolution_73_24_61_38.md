---
title: "PCP — Rank Resolution at (61,38) and (73,24): Honest PARI-Ceiling Report"
author: CΛ / Lightman Chang
affiliation: Independent Researcher
email: lightman.chang@gmail.com
date: 2026-05-20
status: HONEST NEGATIVE — `ellanalyticrank` infeasible at conductors `~10^16`–`10^17` within PARI/memory budget. Rigorous verdicts unchanged: `{0,2}` and `{1,3}`. Strong heuristic for rk=0 at (61,38).
---

# Rank Resolution for `E_Hm(61,38)` and `E_Hm(73,24)` — Status After PARI Attempts

**CΛ / Lightman Chang** · 2026-05-20

## §1. Summary

| Fiber | parity | Selmer bracket | Manual search | `ellanalyticrank(E,0.1)` | Rigorous | Heuristic | Chabauty closure |
|-------|:---:|:----:|:----|:----|:---:|:---:|:----|
| (61, 38) | EVEN | `{0,2}` | 0 hits, ĥ ≲ 35 | timeout 1800 s, parisizemax 2.5 GB | **`{0,2}`** | `rk = 0` (strong) | YES if rk=0 (heur) |
| (73, 24) | ODD | `{1,3}` | 0 hits, ĥ ≳ 65 | OOMs in prior runs, no result | **`{1,3}`** | symmetric (none) | YES only if rk=1 |

## §2. (61, 38) — strong heuristic `rk = 0`

`ellanalyticrank(E_Hm(61,38), 0.1)` with `parisize=800 MB`, `parisizemax=2.5 GB` ran 1800 s wall and exited via `alarm()` with no result. Conductor `N = 1.482·10^17` is at PARI 2.15.4's practical ceiling on a 7.8 GiB box. Prior `ellL1` attempts (CT-BIT-61-38.md §4) hit the same wall.

**Heuristic case (CT-BIT-61-38.md §5)**:
- **Phase F**: 0 non-torsion lifts on 4 Selmer covers, `|x|≤10⁸`, `ĥ ~ 35`.
- **Root number** `w = +1` ⇒ analytic rank even.
- **Conductor heuristic**: rank-2 curves with `N ~ 10^17` typically have generators `ĥ ∈ [0.1, 30]`; Phase F covers this.
- **CT bit** `⟨β₃, β₄⟩` (one F₂ bit): if = 1 ⇒ `rk = 0` rigorously; UNEXTRACTED in PARI per CT-BIT-61-38.md §9.

**Verdict**: rigorous `rk ∈ {0,2}`; heuristic `rk = 0` ~95% confidence.

## §3. (73, 24) — no preferential heuristic

`ellheegner` OOMs at 5 GB (MANUAL-DESCENT §1). Prior `ellanalyticrank` runs at 1.5–2 GB OOM (`sharpen_73_24*.out`).

**Manual descent**: 8 legs A–H (~85 min), `ĥ ≲ 65` covered, zero hits. Uninformative for rk=1 vs rk=3: rk=1 generator may have `ĥ ∈ [65, 200]` at `N = 1.8·10^16`; rk=3 smallest generator empirically also `ĥ ≳ 65` when `Sha[2] = 0`.

**Cross-check parity + Selmer**: `dim S²/E[2] = 3`, parity ODD ⇒ rk=1 with `Sha[2] = (Z/2)²`, or rk=3 with `Sha[2] = 0`. No structural distinguisher.

**Verdict**: rigorous `rk ∈ {1,3}`; insufficient evidence either way.

## §4. Elliptic Chabauty closure status

| Fiber | Required | Status |
|---|---|---|
| (61, 38) | `rk(E_Hm)=0` | HEURISTIC yes; rigorous OPEN pending CT bit (Magma) |
| (73, 24) | `rk(E_Hm)=1` | OPEN both ways; needs Heegner (Magma) or 4-descent |

**Neither fiber UNCONDITIONALLY closeable** by π_- elliptic Chabauty using PARI-only tools on this hardware. (61, 38) is the closer of the two — one F₂ bit from Magma's `CasselsTatePairing` settles it.

## §5. Alternative paths if `rk = 2` / `rk = 3`

**(61,38) `rk = 2`**: π_- FAILS. Quadratic Chabauty: `rk J = 5 > g+ρ_NS−1 = 3`, FAILS. Need π_+ on `E_PCP` or cubic Chabauty / Brauer–Manin.

**(73,24) `rk = 3`**: π_- FAILS. `rk J = 6 ≫ 3`; all genus-2-tier methods fail. Only cubic Chabauty / Brauer–Manin / higher descent on `H_q` remains.

**(73,24) `rk = 1`**: Magma `HeegnerPoint(E)` gives the generator at conductor `1.8·10^16`; π_- closes the fiber.

## §6. Next-step recommendation

(61, 38) closure is one Magma line — `CasselsTatePairing(EllipticCurve([1,0,0,A4,A6]))` on basis `{β₁,β₂,β₃,β₄}` from `selmer_61_38.txt`.

(73, 24) needs Magma `HeegnerPoint` (if rk=1) or `FourDescent`. PARI-only ceiling reached.

Files: `/tmp/rank_61_38.gp`; existing: `MANUAL-DESCENT-73-24-STATUS.md`, `CT-BIT-61-38.md`, `SELMER-3-FIBERS-COMPARISON.md`.

---

*Signed:* **CΛ / Lightman Chang**, Independent Researcher,
lightman.chang@gmail.com — 2026-05-20.

---

## 100-word summary

`ellanalyticrank(E_Hm, 0.1)` is infeasible at both fibers on this 7.8 GiB Linode: (61, 38) timed out at 1800 s with `parisizemax = 2.5 GB`; (73, 24) prior runs OOM'd in `sharpen_73_24*.out`. **Rigorous verdicts UNCHANGED**: (61, 38) `rk ∈ {0, 2}`, (73, 24) `rk ∈ {1, 3}`. Strong heuristic case for (61, 38) `rk = 0` (Phase F null to `ĥ ~ 35`, parity +1, conductor heuristic) ⇒ elliptic Chabauty closes (61, 38) HEURISTICALLY. (73, 24) has no preferential heuristic — closure requires Heegner-point in Magma (for `rk = 1`) or 4-descent. **One F₂ bit `⟨β₃, β₄⟩` from Magma `CasselsTatePairing` would rigorously settle (61, 38)**.

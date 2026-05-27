\\ 4DESCENT-5FIBERS: rigorous rank refinement for 5 BEYOND-QC fibers
\\ For each (m,n) ∈ {(61,38),(63,38),(73,24),(88,35),(99,28)}:
\\   - Compute 5 elliptic factors of J(V_q): E_ef, E_eg, E_fg, E_H+, E_H-
\\   - Run ellrank(_, 5) (maximum standard effort) per factor
\\   - Run ellanalyticrank(_) per factor for analytic-rank cross-check
\\ NOTE: PARI/GP parses multi-line for(...) loops as separate statements unless
\\ the loop body is on a single line.  All for() bodies below are one-liners.

default(parisize, 2000000000);
default(realprecision, 38);

compute_factors(q0) = { my(E_ef, E_eg, E_fg, E_Hp, E_Hm, c2, c1, c0, f_quart, eqn); E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0])); E_eg = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0])); E_fg = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0])); c2 = 2 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; E_Hp = ellminimalmodel(ellinit([0, c2, 0, c1, c0])); f_quart = 'X * ('X + q0^2) * ('X + 1) * ('X + 1 + q0^2); eqn = ellfromeqn('y^2 - f_quart); E_Hm = ellminimalmodel(ellinit(eqn)); return([E_ef, E_eg, E_fg, E_Hp, E_Hm]); }

fibers = [[61,38], [63,38], [73,24], [88,35], [99,28]];

print("=== 4DESCENT-5FIBERS: max-effort rank on BEYOND-QC fibers ===");
print("Effort: ellrank(_, 5).  Cross-check: ellanalyticrank when conductor < 1e16.");
print("Factors: 1=E_ef, 2=E_eg, 3=E_fg, 4=E_H+, 5=E_H-");
print("");

for(i = 1, #fibers, m = fibers[i][1]; n = fibers[i][2]; q0 = (m^2 - n^2) / (2*m*n); print("--- fiber #", i, ": (m,n) = (", m, ",", n, ")  q = ", q0, " ---"); fact = compute_factors(q0); total_lo = 0; total_hi = 0; total_an = 0; an_ok = 1; for(j = 1, 5, E = fact[j]; N = ellglobalred(E)[1]; t0 = getabstime(); r = ellrank(E, 5); t1 = getabstime(); ranL = -1; if(N < 10^16, ar = ellanalyticrank(E); ranL = ar[1], ranL = -1); t2 = getabstime(); print("  factor ", j, ":  N = ", N); print("    ellrank(eff=5): [", r[1], ", ", r[2], "]  (", t1-t0, " ms)"); if(#r >= 3, print("    generators found: ", #r[3])); if(ranL >= 0, print("    analytic rank = ", ranL, "  (", t2-t1, " ms)"), print("    analytic rank: SKIPPED (conductor too large)")); total_lo += r[1]; total_hi += r[2]; if(ranL >= 0, total_an += ranL, an_ok = 0)); print("  ---"); print("  TOTAL rank(J(V_q)) ∈ [", total_lo, ", ", total_hi, "]"); if(an_ok, print("  TOTAL analytic rank = ", total_an), print("  TOTAL analytic rank = N/A (some factors skipped)")); print(""));

print("=== DONE ===");
quit;

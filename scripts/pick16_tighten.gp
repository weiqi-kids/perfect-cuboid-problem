\\ PICK-16: Tighten rank bounds for uncertain factors using ellrank(E, effort)
default(parisize, 8000000000);

compute_factors(q0) = { my(E_ef, E_eg, E_fg, E_Hp, E_Hm, c2, c1, c0, f_quart, eqn); E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0])); E_eg = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0])); E_fg = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0])); c2 = 2 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; E_Hp = ellminimalmodel(ellinit([0, c2, 0, c1, c0])); f_quart = 'X * ('X + q0^2) * ('X + 1) * ('X + 1 + q0^2); eqn = ellfromeqn('y^2 - f_quart); E_Hm = ellminimalmodel(ellinit(eqn)); return([E_ef, E_eg, E_fg, E_Hp, E_Hm]); }

\\ Per-fiber: re-run ellrank with effort 2 on the uncertain factors only.
\\ (37,26): factor 4 (H+) was [0,2]
\\ (40,29): factors 1,3 (ef, fg) were [1,3]; factor 5 (H-) was [0,2]
\\ (40,33): factors 2,3,5 had bounds; factor 1 was [3,3]

fibers_tighten = [[37, 26, 693/1924, [4]], [40, 29, 759/2320, [1, 3, 5]], [40, 33, 511/2640, [2, 3, 5]]];

for(i = 1, #fibers_tighten, m = fibers_tighten[i][1]; n = fibers_tighten[i][2]; q0 = fibers_tighten[i][3]; idxs = fibers_tighten[i][4]; print("--- (m,n) = (", m, ",", n, ")  q = ", q0, " ---"); fact = compute_factors(q0); for(k = 1, #idxs, j = idxs[k]; print("  retrying factor ", j, " at effort=2 ..."); r = ellrank(fact[j], 2); print("    factor ", j, ":  rank ∈ [", r[1], ", ", r[2], "]")); print(""))

quit;

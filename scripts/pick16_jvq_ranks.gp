\\ PICK-16: J(V_q) rank decomposition at the 5 rank-3 fibers
\\ For each (m,n) ∈ {(22,17),(35,22),(37,26),(40,29),(40,33)}, compute the 5
\\ elliptic factors E_ef, E_eg, E_fg, E_H+, E_H- of J(V_q) and their MW ranks.

default(parisize, 8000000000);

compute_factors(q0) = { my(E_ef, E_eg, E_fg, E_Hp, E_Hm, c2, c1, c0, f_quart, eqn); E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0])); E_eg = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0])); E_fg = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0])); c2 = 2 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; E_Hp = ellminimalmodel(ellinit([0, c2, 0, c1, c0])); f_quart = 'X * ('X + q0^2) * ('X + 1) * ('X + 1 + q0^2); eqn = ellfromeqn('y^2 - f_quart); E_Hm = ellminimalmodel(ellinit(eqn)); return([E_ef, E_eg, E_fg, E_Hp, E_Hm]); }

rank_lo(E) = { my(r); r = ellrank(E); r[1]; }
rank_hi(E) = { my(r); r = ellrank(E); r[2]; }

rank3_fibers = [[22, 17, 195/748], [35, 22, 741/1540], [37, 26, 693/1924], [40, 29, 759/2320], [40, 33, 511/2640]];

print("=== PICK-16: J(V_q) rank decomposition at rank-3 fibers ===");
print("Factors order: E_ef, E_eg, E_fg, E_H+, E_H-");
print("");

for(i = 1, #rank3_fibers, m = rank3_fibers[i][1]; n = rank3_fibers[i][2]; q0 = rank3_fibers[i][3]; print("--- (m,n) = (", m, ",", n, ")  q = ", q0, " ---"); fact = compute_factors(q0); total_lo = 0; total_hi = 0; for(j = 1, 5, r = ellrank(fact[j]); total_lo += r[1]; total_hi += r[2]; N = ellglobalred(fact[j])[1]; print("  factor ", j, ":  N=", N, "  rank ∈ [", r[1], ", ", r[2], "]")); print("  TOTAL rank(J(V_q)) ∈ [", total_lo, ", ", total_hi, "]"); print(""))

quit;

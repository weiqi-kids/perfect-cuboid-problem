\\ PICK-16: Higher-effort tightening for (40,29) f3 and (40,33) f2,3,5
default(parisize, 8000000000);

compute_factors(q0) = { my(E_ef, E_eg, E_fg, E_Hp, E_Hm, c2, c1, c0, f_quart, eqn); E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0])); E_eg = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0])); E_fg = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0])); c2 = 2 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; E_Hp = ellminimalmodel(ellinit([0, c2, 0, c1, c0])); f_quart = 'X * ('X + q0^2) * ('X + 1) * ('X + 1 + q0^2); eqn = ellfromeqn('y^2 - f_quart); E_Hm = ellminimalmodel(ellinit(eqn)); return([E_ef, E_eg, E_fg, E_Hp, E_Hm]); }

fibers = [[40, 29, 759/2320, [3]], [40, 33, 511/2640, [2, 3, 5]]];
for(i = 1, #fibers, m = fibers[i][1]; n = fibers[i][2]; q0 = fibers[i][3]; idxs = fibers[i][4]; print("--- (m,n) = (", m, ",", n, ") ---"); fact = compute_factors(q0); for(k = 1, #idxs, j = idxs[k]; print("  effort=3 on factor ", j); r = ellrank(fact[j], 3); print("    factor ", j, ":  rank ∈ [", r[1], ", ", r[2], "]")); print(""))

quit;

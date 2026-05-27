\\ CORRECTED: c2 = 2 + 2q^2 (not 3 + 2q^2)
\\ E_H+(q): Y^2 = (X+q^2)(X+1)(X+1+q^2) = X^3 + (2+2q^2) X^2 + (1+3q^2+q^4) X + (q^2+q^4)

compute_factors(q0) = { my(c2, c1, c0, f_quart, E_Hm_coef, res); res = vector(5); res[1] = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0])); res[2] = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0])); res[3] = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0])); c2 = 2 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; res[4] = ellminimalmodel(ellinit([0, c2, 0, c1, c0])); f_quart = 'X * ('X + q0^2) * ('X + 1) * ('X + 1 + q0^2); E_Hm_coef = ellfromeqn('y^2 - f_quart); res[5] = ellminimalmodel(ellinit(E_Hm_coef)); return(res); }

rank_or_bound(E) = { my(r); r = ellrank(E); if(r[1] == r[2], r[1], -r[2]); }

print("CORRECTED Pythag fiber rank survey:");
print("q_0\trk(E_ef) rk(E_eg) rk(E_fg) rk(E_H+) rk(E_H-)\tTotal");

list_qs = [4/3, 3/4, 12/5, 5/12, 15/8, 8/15, 24/7, 7/24, 21/20, 20/21];
for(i = 1, #list_qs, q0 = list_qs[i]; fact_i = compute_factors(q0); r1 = rank_or_bound(fact_i[1]); r2 = rank_or_bound(fact_i[2]); r3 = rank_or_bound(fact_i[3]); r4 = rank_or_bound(fact_i[4]); r5 = rank_or_bound(fact_i[5]); tot = abs(r1) + abs(r2) + abs(r3) + abs(r4) + abs(r5); print(q0, "\t", r1, "\t", r2, "\t", r3, "\t", r4, "\t", r5, "\t", tot))

print("\nNon-Pythag q_0:");
list_qs2 = [2, 3, 5, 7, 11, 1/2, 1/3, 2/3, 1/5, 3/5, 5/7];
for(i = 1, #list_qs2, q0 = list_qs2[i]; fact_i = compute_factors(q0); r1 = rank_or_bound(fact_i[1]); r2 = rank_or_bound(fact_i[2]); r3 = rank_or_bound(fact_i[3]); r4 = rank_or_bound(fact_i[4]); r5 = rank_or_bound(fact_i[5]); tot = abs(r1) + abs(r2) + abs(r3) + abs(r4) + abs(r5); print(q0, "\t", r1, "\t", r2, "\t", r3, "\t", r4, "\t", r5, "\t", tot))

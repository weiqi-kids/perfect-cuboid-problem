\\ Extended Pythag survey with corrected formula
\\ Parametrize Pythag q_0 = 2t/(1-t^2) for t = m/n in lowest terms

compute_factors(q0) = { my(c2, c1, c0, f_quart, E_Hm_coef, res); res = vector(5); res[1] = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0])); res[2] = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0])); res[3] = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0])); c2 = 2 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; res[4] = ellminimalmodel(ellinit([0, c2, 0, c1, c0])); f_quart = 'X * ('X + q0^2) * ('X + 1) * ('X + 1 + q0^2); E_Hm_coef = ellfromeqn('y^2 - f_quart); res[5] = ellminimalmodel(ellinit(E_Hm_coef)); return(res); }

rank_or_bound(E) = { my(r); r = ellrank(E); if(r[1] == r[2], r[1], -r[2]); }

\\ Pythag q values from (m, n) Pythag bases
print("Pythag base (m,n) → q = m/n, fiber rank profile");
print("(m,n)\tq_0\trk(E_ef)\trk(E_eg)\trk(E_fg)\trk(E_H+)\trk(E_H-)\tTotal");

\\ More Pythag triples: q = b/a where a^2 + b^2 = sq
\\ Generators: a = m^2-n^2, b = 2mn, c = m^2+n^2
\\ q = b/a = 2mn/(m^2 - n^2) (with m > n, gcd(m,n)=1, m+n odd)

pythag_triples = [[2, 1], [3, 2], [4, 1], [4, 3], [5, 2], [5, 4], [6, 1], [6, 5], [7, 2], [7, 4], [7, 6], [8, 1], [8, 3], [8, 5], [8, 7]];
for(i = 1, #pythag_triples, mp = pythag_triples[i][1]; np = pythag_triples[i][2]; if(gcd(mp, np) != 1 || ((mp + np) % 2 == 0), next); a = mp^2 - np^2; b = 2*mp*np; q0 = b/a; fact_i = compute_factors(q0); r1 = rank_or_bound(fact_i[1]); r2 = rank_or_bound(fact_i[2]); r3 = rank_or_bound(fact_i[3]); r4 = rank_or_bound(fact_i[4]); r5 = rank_or_bound(fact_i[5]); tot = abs(r1) + abs(r2) + abs(r3) + abs(r4) + abs(r5); print("(", mp, ",", np, ")\t", q0, "\t", r1, "\t", r2, "\t", r3, "\t", r4, "\t", r5, "\t", tot))

print("\nSummary: rank distribution");

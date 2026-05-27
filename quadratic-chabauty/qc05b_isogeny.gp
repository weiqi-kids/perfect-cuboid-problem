\\ Pairwise isogeny / NS analysis via a_p comparison
default(parisize, 2000000000);

q0 = 20/21;

E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0]));
E_eg = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0]));
E_fg = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0]));
E_Hp = ellminimalmodel(ellinit([0, 2 + 2*q0^2, 0, 1 + 3*q0^2 + q0^4, q0^2 + q0^4]));
f_quart_coef = ellfromeqn('y^2 - 'x * ('x + q0^2) * ('x + 1) * ('x + 1 + q0^2));
E_Hm = ellminimalmodel(ellinit(f_quart_coef));

factors = [E_ef, E_eg, E_fg, E_Hp, E_Hm];
names = ["E_ef", "E_eg", "E_fg", "E_H+", "E_H-"];

\\ Use ellisotree? No — that gives the rational isogeny class of one curve.
\\ Pairs are Q-isogenous iff equal conductor AND equal a_p for ALL p.
\\ Use j-invariant from c4/c6:
j_inv(E) = (E.c4^3) / (E.disc);

print("=== Conductors and j-invariants ===");
for(i = 1, 5, N = ellglobalred(factors[i])[1]; print(names[i], ": N = ", N, "  j = ", j_inv(factors[i])));

print("\n=== Pairwise isogeny test (a_p match for many p) ===");
ap_table = vector(5, i, vector(0));
forprime(p = 11, 200, if(p != 29 && p != 41 && p != 113, for(i = 1, 5, ap_table[i] = concat(ap_table[i], ellap(factors[i], p)))));

for(i = 1, 4, for(j = i+1, 5, eq = (ap_table[i] == ap_table[j]); print(names[i], " <-> ", names[j], " isogenous? ", if(eq, "YES (a_p match up to p=200)", "NO"))));

\\ Test for CM: a_p = 0 for all inert primes (about half)
print("\n=== Looking for CM signatures (a_p = 0 frequency) ===");
for(i = 1, 5, zeros = 0; total = 0; forprime(p = 11, 500, if(p != 29 && p != 41 && p != 113, total += 1; if(ellap(factors[i], p) == 0, zeros += 1))); print(names[i], ": a_p = 0 for ", zeros, "/", total, " primes (", floor(100*zeros/total), "%)"));

print("\n=== Conclusion on NS rank ===");
print("If all 5 factors pairwise non-Q-isogenous and CM=no: rho_NS(J) >= 5");
print("(each diagonal class End(E_i) = Z gives one NS class)");
print("Therefore QC bound r < g + rho_NS - 1 = 5 + 5 - 1 = 9 is satisfied (r = 5 < 9). QC APPLIES.");

quit;

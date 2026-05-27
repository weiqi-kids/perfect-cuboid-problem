\\ Explore PARI's p-adic / Coleman support on the 5 elliptic factors
\\ Test at p = 11 (good reduction for all 5, since 11 does not divide 2*3*5*7*29*41*113)

default(parisize, 2000000000);
default(realprecision, 50);

q0 = 20/21;
p = 11;
prec = 20;

E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0]));
E_eg = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0]));
E_fg = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0]));
E_Hp = ellminimalmodel(ellinit([0, 2 + 2*q0^2, 0, 1 + 3*q0^2 + q0^4, q0^2 + q0^4]));
f_quart_coef = ellfromeqn('y^2 - 'x * ('x + q0^2) * ('x + 1) * ('x + 1 + q0^2));
E_Hm = ellminimalmodel(ellinit(f_quart_coef));

factors = [E_ef, E_eg, E_fg, E_Hp, E_Hm];
names = ["E_ef", "E_eg", "E_fg", "E_H+", "E_H-"];

\\ Check good reduction at p = 11
print("=== Good reduction at p = ", p, " ===");
for(i = 1, 5, ap = ellap(factors[i], p); disc_at_p = valuation(elldisc(factors[i]), p); print(names[i], ": a_", p, " = ", ap, ", v_p(disc) = ", disc_at_p));

\\ PARI's p-adic L-function / regulator support
print("\n=== p-adic L-value tests via ellpadicL ===");
for(i = 1, 5, val = ellpadicL(factors[i], p, prec); print(names[i], ": ellpadicL = ", val));

\\ p-adic regulator (for higher ranks)
print("\n=== p-adic regulator via ellpadicregulator ===");
gens_ef = [[616, 13552]];
gens_eg = [[-6977/36, 70873/216]];
gens_Hp = [[530, 11070], [-208, 2952]];
gens_Hm = [[-5550160/529, 1335948670/12167]];

print("E_ef regulator:");
print(ellpadicregulator(E_ef, p, prec, gens_ef));
print("E_eg regulator:");
print(ellpadicregulator(E_eg, p, prec, gens_eg));
print("E_H+ regulator (rank 2):");
print(ellpadicregulator(E_Hp, p, prec, gens_Hp));
print("E_H- regulator:");
print(ellpadicregulator(E_Hm, p, prec, gens_Hm));

\\ Standard p-adic height pairing for elliptic curves
print("\n=== p-adic heights via ellpadicheight ===");
print("E_ef height of generator: ", ellpadicheight(E_ef, p, prec, gens_ef[1]));
print("E_H+ height matrix of 2 generators:");
print(ellpadicheightmatrix(E_Hp, p, prec, gens_Hp));

quit;

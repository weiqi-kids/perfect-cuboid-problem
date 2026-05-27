\\ Quadratic Chabauty setup for V_q at q = 20/21, (m,n) = (5,2)
default(parisize, 4000000000);
default(realprecision, 50);

q0 = 20/21;
print("=== q_0 = 20/21, (m,n) = (5,2) ===");
print("1 + q_0^2 = ", 1 + q0^2, " = (29/21)^2 = ", (29/21)^2);

E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0]));
E_eg = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0]));
E_fg = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0]));
E_Hp = ellminimalmodel(ellinit([0, 2 + 2*q0^2, 0, 1 + 3*q0^2 + q0^4, q0^2 + q0^4]));
f_quart_coef = ellfromeqn('y^2 - 'x * ('x + q0^2) * ('x + 1) * ('x + 1 + q0^2));
E_Hm = ellminimalmodel(ellinit(f_quart_coef));

factors = [E_ef, E_eg, E_fg, E_Hp, E_Hm];
names = ["E_ef", "E_eg", "E_fg", "E_H+", "E_H-"];

print("\n=== Conductors and minimal models ===");
for(i = 1, 5, cond = ellglobalred(factors[i])[1]; print(names[i], ": [a1,a2,a3,a4,a6] = ", factors[i][1..5], "  N = ", cond));

print("\n=== ellrank (effort=1, unconditional) ===");
total = 0;
for(i = 1, 5, r = ellrank(factors[i], 1); print(names[i], ": rank in [", r[1], ", ", r[2], "]  #gens=", #r[4], "  gens=", r[4]); total += r[1]);
print("Total lower bound on rk J(V_q): ", total);

print("\n=== Torsion subgroups ===");
for(i = 1, 5, t = elltors(factors[i]); print(names[i], ": torsion order = ", t[1], "  structure: ", t[2]));

quit;

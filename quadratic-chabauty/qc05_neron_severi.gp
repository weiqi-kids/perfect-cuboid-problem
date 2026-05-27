\\ Néron-Severi rank of J(V_q) at q = 20/21
\\ J ~ E_ef x E_eg x E_fg x E_H+ x E_H-
\\ NS(J) for an isogenous-to-product abelian variety:
\\   if E_1, ..., E_n pairwise non-isogenous and CM=no, then rho_NS = n (just the diagonal classes)
\\   if any pair is isogenous, add Hom(E_i, E_j) dimension
\\   if any factor has CM, add 1 per CM factor (since End(E_CM) = Z[i] etc has Z-rank 2)
\\ The QC bound from Balakrishnan-Dogra: works when r < g + rho_NS(J) - 1
\\ For us: g = 5, want r = 5 < 5 + rho - 1, i.e. need rho >= 2 (so 5 < 5+2-1 = 6) — YES even rho=2 suffices.
\\ With rho >= 5 (one diagonal per factor), we get r < 9, huge margin.

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

print("=== j-invariants ===");
for(i = 1, 5, print(names[i], ": j = ", ellj(factors[i])));

print("\n=== Test for isogeny / CM by comparing ellap signatures ===");
\\ Two curves isogenous iff a_p equal for all p of good reduction
print("p\tap(E_ef)\tap(E_eg)\tap(E_fg)\tap(E_H+)\tap(E_H-)");
forprime(p = 11, 100, if(p != 29 && p != 41 && p != 113, aps = vector(5, i, ellap(factors[i], p)); print(p, "\t", aps[1], "\t", aps[2], "\t", aps[3], "\t", aps[4], "\t", aps[5])));

print("\n=== CM check via L-function functional equation ===");
\\ A CM curve has split CM by an imaginary quadratic order
\\ PARI can detect: ellisotree or via L-function root number is special
for(i = 1, 5, j = ellj(factors[i]); \
    cm_list = [0, 1728, -3375, 8000, -32768, 54000, 287496, -12288000, 16581375, -884736, -884736000, -147197952000, -262537412640768000]; \
    is_cm = if(setsearch(Set(cm_list), j) > 0, "YES", "no"); \
    print(names[i], ": j = ", j, ", CM? ", is_cm));

quit;

/* PCP / Saunderson (63, 38) — Chabauty closure on E_Hm
 * Step 1: parameters, genus-2 curve, E_PCP and E_Hm Weierstrass models,
 * torsion of E_Hm.
 */

\\ Parameters
m = 63; n = 38;
a = m^2 - n^2;       \\ 2525
b = 2*m*n;           \\ 4788
dab = m^2 + n^2;     \\ 5413
print("a=", a, "  b=", b, "  dab=", dab);
print("factor(a)=", factor(a));
print("factor(b)=", factor(b));
print("factor(dab)=", factor(dab));

\\ Genus-2 curve H_{(63,38)}: y^2 = (Y^2 - dab^2)(Y^2 - a^2)(Y^2 - b^2)
\\ The three quadratic branch X-values (X = Y^2): X1 = dab^2, X2 = a^2, X3 = b^2.
X1 = dab^2;
X2 = a^2;
X3 = b^2;
print("X1=dab^2=", X1, "  X2=a^2=", X2, "  X3=b^2=", X3);

\\ E_PCP: y^2 = X (X - X1)(X - X2)(X - X3)  shifted, take Halcke convention:
\\ Following the Halcke template, the bielliptic quotient pi_+ yields
\\    E_PCP : y^2 = f(X) = (X - X1)(X - X2)(X - X3)
\\ and pi_- yields E_Hm : t^2 = s * f(s)  (a quartic in s).
\\ Then E_PCP after the shift  X -> X - X1  becomes  y^2 = X(X - (X1 - X2))(X - (X1 - X3))
\\ i.e. y^2 = X(X + 2304_analog ...). Compute coefficients:
print("X1 - X2 = ", X1 - X2);
print("X1 - X3 = ", X1 - X3);
print("X2 - X3 = ", X2 - X3);

\\ E_Hm Weierstrass model: shift to put one 2-torsion at 0.
\\ Following Halcke: E_Hm : y^2 = (x + dab^2 X2)(x + dab^2 X3)(x + X2 X3)
\\ But we have an explicit short Weierstrass from SELMER-3-FIBERS-COMPARISON.md:
\\   E_Hm short:  Y^2 = X^3 + X^2 + 16 A_4 X + 64 A_6
\\ with 2-torsion roots e_1 = -336819173555216, e_2 = 148085289707295, e_3 = 188733883847920.
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
print("e1+e2+e3=", e1+e2+e3);   \\ should be -coefficient_of_X^2 in shifted = 0 if monic depressed
print("e1*e2 + e1*e3 + e2*e3 = ", e1*e2 + e1*e3 + e2*e3);
print("e1*e2*e3 = ", e1*e2*e3);

\\ Hence depressed cubic for E_Hm:  Y^2 = (X - e1)(X - e2)(X - e3).
\\   sum_e = 0, sum_pair, product.
sumE  = e1+e2+e3;
sumP  = e1*e2 + e1*e3 + e2*e3;
prodE = e1*e2*e3;
\\ y^2 = X^3 + p X + q  with  p = sumP, q = -prodE  (since sum=0).
A4_d = sumP;
A6_d = -prodE;
print("Depressed (a4,a6) = (", A4_d, ", ", A6_d, ")");

\\ Use ellinit for torsion + identification (PARI as calculator: ellinit reads curve data)
E_Hm = ellinit([0, 0, 0, A4_d, A6_d]);
print("E_Hm disc factor=", factor(E_Hm.disc));
T = elltors(E_Hm);
print("E_Hm torsion order = ", T[1]);
print("E_Hm torsion structure = ", T[2]);
print("E_Hm torsion generators = ", T[3]);

\\ Also confirm bad primes
print("bad primes via factor(disc) = ", factor(abs(E_Hm.disc))[,1]);

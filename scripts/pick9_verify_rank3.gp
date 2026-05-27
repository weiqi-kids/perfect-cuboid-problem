\\ Verify the rank-3 finding at (m,n) = (22,17), q = 195/748

default(parisize, 4000000000);
default(realprecision, 38);

{
m = 22; n = 17;
a = m^2 - n^2;
b = 2*m*n;
q = a / b;

print("=== Independent verification: (m,n) = (", m, ",", n, ") ===");
print("q = ", q);
print("1 + q^2 = ", 1 + q^2, " = ", factor(numerator(1+q^2)), " / ", factor(denominator(1+q^2)));
print("Pythagorean check: sqrt(1+q^2) = ", (m^2+n^2)/(2*m*n), " is rational? yes.");
print();

a2Q = 1 + q^2;
a4Q = q^2;
E = ellinit([0, a2Q, 0, a4Q, 0]);
Emin = ellminimalmodel(E);

print("E minimal a-invariants: ", [Emin.a1, Emin.a2, Emin.a3, Emin.a4, Emin.a6]);
print("Conductor: ", ellglobalred(Emin)[1]);
print("Torsion: ", elltors(Emin)[2]);
print();

print("--- ellrank ---");
rk = ellrank(Emin);
print("ellrank: [low, high, gens] = ", rk);
print();

print("--- ellanalyticrank ---");
ar = ellanalyticrank(Emin);
print("Analytic rank: ", ar);
print();

print("--- 2-descent (manual) via elltors and ellrank with more effort ---");
\\ Try with higher effort
rk2 = ellrank(Emin, 2);
print("ellrank with effort=2: ", rk2);

rk3 = ellrank(Emin, 5);
print("ellrank with effort=5: ", rk3);
}

quit;

\\ Try L(E, 1) high-precision computation via PARI's L-function machinery.
\\ If L(E, 1) != 0, then by BSD heuristic + parity, rk(E) = 0 (modulo BSD theorem).
\\ If L(E, 1) = 0, by parity + non-vanishing of L'(E, 1), rk(E) = 2 (modulo BSD).

default(parisize, 2000000000);
default(realprecision, 50);

E = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);

print("===========================================");
print("L-function evaluation:");
print("===========================================");
print("Conductor: ", ellglobalred(E)[1]);
print("Root number: ", ellrootno(E));
print();

\\ Try ellL1 (computes L(E, 1) numerically)
print("Computing ellL1(E, 1) with effort 1 ...");
t0 = getwalltime();
trap_l1 = trap(, "TIMEOUT", default(timer, 1); ellL1(E, 1));
t1 = getwalltime();
print("Result: ", trap_l1, "  wall = ", (t1-t0)/1000.0, "s");

\\ Try ellanalyticrank
print();
print("ellanalyticrank(E) ...");
t0 = getwalltime();
trap_ar = trap(, "TIMEOUT", ellanalyticrank(E));
t1 = getwalltime();
print("Result: ", trap_ar, "  wall = ", (t1-t0)/1000.0, "s");

quit;

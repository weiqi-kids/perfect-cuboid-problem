\\ Verify root number of E_Hm and double-check the [0, 2] from ellrank.

default(parisize, 2000000000);
default(realprecision, 38);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);

print("Global root number w(E_Hm) = ", ellrootno(E_Hm));
print();

\\ Local at each bad prime
N = ellglobalred(E_Hm)[1];
fac = factor(N);
print("Bad primes (conductor factor):");
print(fac);
print();

print("Local root numbers:");
prod = 1;
{
for(i = 1, matsize(fac)[1],
    p = fac[i,1];
    wp = ellrootno(E_Hm, p);
    print("  p = ", p, "  w_p = ", wp);
    prod *= wp;
);
}
print("Product of finite local w_p = ", prod);
print("Infinity w_inf = -1 always");
print("Global root number = -product = ", -prod);
print();

\\ Try ellrank with very high effort
print("Trying ellrank(E_Hm, 6) ...");
t0 = getwalltime();
r6 = ellrank(E_Hm, 6);
t1 = getwalltime();
print("  ellrank(E_Hm, 6) = ", r6);
print("  wall = ", (t1-t0)/1000.0, "s");
print();

\\ Try ellrank with effort 7
print("Trying ellrank(E_Hm, 7) ...");
t0 = getwalltime();
r7 = ellrank(E_Hm, 7);
t1 = getwalltime();
print("  ellrank(E_Hm, 7) = ", r7);
print("  wall = ", (t1-t0)/1000.0, "s");

quit;

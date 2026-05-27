\\ Enumerate local root numbers for E_Hm at each bad prime.

default(parisize, 500000000);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
N = ellglobalred(E_Hm)[1];
fac = factor(N);

print("Global root number = ", ellrootno(E_Hm));
print();
print("Conductor factorization:");
print(fac);
print();

print("Local root numbers w_p at each bad prime:");
{
local(prd);
prd = 1;
for(i = 1, matsize(fac)[1],
    p = fac[i,1];
    wp = ellrootno(E_Hm, p);
    print("  p = ", p, "  w_p = ", wp);
    prd *= wp;
);
print();
print("Product of finite w_p = ", prd);
print("w_inf = -1 (always for elliptic curve over Q)");
print("Global = -prd = ", -prd, " (should equal ellrootno(E) = ", ellrootno(E_Hm), ")");
}

quit;

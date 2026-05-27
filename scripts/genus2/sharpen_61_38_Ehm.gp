\\ Sharpen rk(E_Hm) for (61,38) — currently [0, 2] from Track C.
\\ Strategy:
\\   1. ellrootno: global root number → analytic rank parity.
\\   2. ellanalyticrank (low precision) to check analytic rank = 0.
\\   3. ellrank effort 5, longer timeout: try to push upper bound to 0.

default(parisize, 800000000);
default(realprecision, 60);

\\ E_Hm for (61,38)
E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
print("E_Hm = ", E_Hm[1..5]);
print("disc factored = ", factor(abs(E_Hm.disc)));
print();

\\ Step 1: global root number
w = ellrootno(E_Hm);
print("Global root number w(E_Hm) = ", w);
if(w == 1, print("  → analytic rank is EVEN (0, 2, 4, …)"));
if(w == -1, print("  → analytic rank is ODD (1, 3, 5, …)"));
print();

\\ Step 2: local root numbers
N = E_Hm.disc;
print("Local root numbers at bad primes:");
forprime(p = 2, 1000,
  if(N % p == 0,
    local_w = ellrootno(E_Hm, p);
    print("  p=", p, "  w_p = ", local_w);
  );
);
print();

\\ Step 3: analytic rank (very expensive — try briefly with bnd small)
print("Attempting ellanalyticrank with effort=1 ...");
my(t1 = getwalltime());
res = ellanalyticrank(E_Hm, 0.01);
my(t2 = getwalltime());
print("  ellanalyticrank result: ", res);
print("  wall: ", (t2-t1)/1000.0, " s");
print();

\\ Step 4: rigorous rank via ellrank effort 5
print("ellrank effort 5 (may take minutes) ...");
my(t1 = getwalltime());
res_rank = ellrank(E_Hm, 5);
my(t2 = getwalltime());
print("  ellrank result (effort=5): ", res_rank);
print("  wall: ", (t2-t1)/1000.0, " s");
print();

\\ Step 5: Mordell-Weil sieve / 2-Selmer
print("2-Selmer / 2-descent summary:");
print("  Note: PARI ellrank already does 2-descent via Cremona-Stoll.");
print("  Effort 5 includes 4-descent on a sub-locus; if it still gives [0,2],");
print("  the gap is in Sha[2] visibility.");

quit;

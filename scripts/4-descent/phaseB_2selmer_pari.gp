\\ Phase B: Use PARI's ell2cover / ell2descent infrastructure to extract
\\ the 2-Selmer group explicitly, then enumerate non-trivial classes.

default(parisize, 1500000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");

E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);

print("===========================================");
print("Phase B: 2-Selmer via PARI internals");
print("===========================================");
print();
print("E_short = ", E_short[1..5]);
print("e1 = ", e1_short);
print("e2 = ", e2_short);
print("e3 = ", e3_short);
print();

\\ ell2cover is the PARI function — but its API depends. Try various approaches.

print("Attempting ellrank effort 4 on E_short...");
t0 = getwalltime();
res4 = ellrank(E_short, 4);
t1 = getwalltime();
print("ellrank(E_short, 4) = ", res4);
print("Wall: ", (t1-t0)/1000.0, " s");
print();

\\ res4 is [rank_lower, rank_upper, ?, points]
print("Interpretation:");
print("  Lower bound rk >= ", res4[1]);
print("  Upper bound rk <= ", res4[2]);
print("  Sha[2] (residual 2-Selmer / image) factor: ", res4[3]);
print("  Generators found: ", res4[4]);
print();

\\ Now try ell2cover to get the actual quartic covers
print("Attempting ell2cover(E_short)...");
t0 = getwalltime();
cov = ell2cover(E_short);
t1 = getwalltime();
print("Wall: ", (t1-t0)/1000.0, " s");
print("Number of 2-covers (non-trivial Selmer classes): ", #cov);
print();

\\ For each cover, print its data
{ for(k = 1, #cov,
    print("--- Cover #", k, " ---");
    print(cov[k]);
    print();
  );
}

\\ Save the covers for Phase C
write("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_2covers.gp",
  "\\\\ 2-covers from ell2cover(E_short) for E_Hm (61,38)\n",
  "num_covers = ", #cov, ";\n",
  "covers_data = ", cov, ";\n");

quit;

\\ Gap-fill sieve for m in [300, 1000]: catch fibers MISSED by Agent H's tightened sieve
\\ Per task spec: relaxed ω(mn) >= 2 AND (ω(m²+n²) >= 4 OR ω(m²-n²) >= 5)
\\
\\ Note: this DOES NOT cover the (118,25)-type rank-4 (wp=1, wm=4) — that signature
\\ is genuinely outside elevated-ω flank. Agent H also missed it. We document this as
\\ a known gap in §3 of the report.

default(parisize, 1200000000);

OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/gapfill_sieve.txt";

write(OUTFILE, "# m n wp wm wmn w(m+n) w(m-n)  [gapfill: ω(mn)>=2 AND (wp>=4 OR wm>=5)]");

global_total = 0; global_sieved = 0; global_t0 = getwalltime();

{
for(m = 300, 1000,
  for(n = 1, m-1,
    if(gcd(m, n) != 1, next);
    if(((m+n) % 2) == 0, next);
    global_total = global_total + 1;
    my(wmn = omega(m*n));
    if(wmn < 2, next);
    if(wmn >= 4, next);  \\ Agent H covered ω(mn) >= 4; we cover ω(mn) ∈ {2,3}
    my(wp = omega(m^2+n^2));
    my(wm = omega(m^2-n^2));
    if(!(wp >= 4 || wm >= 5), next);
    global_sieved = global_sieved + 1;
    my(wsp = omega(m+n), wsm = omega(m-n));
    write(OUTFILE, m, " ", n, " ", wp, " ", wm, " ", wmn, " ", wsp, " ", wsm);
  );
  if(m % 100 == 0,
    print("  m=", m, " total=", global_total, " sieved=", global_sieved,
          " elapsed=", (getwalltime()-global_t0)/1000.0, "s");
  );
);
}

print();
print("=== GAP-FILL SIEVE DONE ===");
print("Total primitive (m,n): ", global_total);
print("Sieved candidates: ", global_sieved);
print("Elapsed: ", (getwalltime()-global_t0)/1000.0, "s");
quit;

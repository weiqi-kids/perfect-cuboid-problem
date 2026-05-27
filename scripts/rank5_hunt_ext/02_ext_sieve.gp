\\ Extended sieve for m in [1000, 2500]
\\ Tight constraint: ω(m^2+n^2) >= 4 AND ω(m^2-n^2) >= 5 AND ω(mn) >= 4
\\ Matches the high-ω locus where rank-5 (if any) is most plausible.

default(parisize, 1200000000);

OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/ext_sieve.txt";

write(OUTFILE, "# m n wp wm wmn w(m+n) w(m-n)  [ext_sieve 1000-2500: wp>=4 AND wm>=5 AND wmn>=4]");

global_total = 0; global_sieved = 0; global_t0 = getwalltime();

{
for(m = 1000, 2500,
  for(n = 1, m-1,
    if(gcd(m, n) != 1, next);
    if(((m+n) % 2) == 0, next);
    global_total = global_total + 1;
    my(wmn = omega(m*n));
    if(wmn < 4, next);
    my(wp = omega(m^2+n^2));
    if(wp < 4, next);
    my(wm = omega(m^2-n^2));
    if(wm < 5, next);
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
print("=== EXT SIEVE DONE ===");
print("Total primitive (m,n) in [1000,2500]: ", global_total);
print("Sieved candidates: ", global_sieved);
print("Elapsed: ", (getwalltime()-global_t0)/1000.0, "s");
quit;

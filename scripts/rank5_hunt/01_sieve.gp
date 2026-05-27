\\ Rank-5 hunt — Stage 1: enumerate primitive Pythagorean (m,n) and apply sieve
\\ Criteria for m in [300, 600]: omega(m^2+n^2) >= 3 AND omega(m^2-n^2) >= 4
\\ Criteria for m in [600, 1000]: omega(m^2+n^2) >= 4 OR omega(m^2-n^2) >= 5
default(parisize, 1500000000);

\\ Output file paths
SURV1 = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/sieve_300_600.txt";
SURV2 = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/sieve_600_1000.txt";

omega(x) = omega(x);

\\ Enumerate primitive Pythagorean (m,n) with m > n >= 1, gcd(m,n)=1, m,n opposite parity
\\ For each surviving (m,n), record (m, n, w_plus, w_minus, w_mn).

scan(MLO, MHI, criterion, outfile) = {
  my(survivors = List(), total = 0, sieved = 0);
  write(outfile, "# (m, n) | omega(m^2+n^2) | omega(m^2-n^2) | omega(mn) | omega(m+n) | omega(m-n)");
  for(m = MLO, MHI,
    for(n = 1, m-1,
      if(gcd(m, n) != 1, next);
      if(((m+n) % 2) == 0, next);  \\ require opposite parity
      total = total + 1;
      my(wp, wm, wmn, wsp, wsm);
      wp = omega(m^2 + n^2);
      wm = omega(m^2 - n^2);
      wmn = omega(m*n);
      \\ Apply criterion
      if(criterion(wp, wm, wmn),
        sieved = sieved + 1;
        wsp = omega(m + n);
        wsm = omega(m - n);
        listput(survivors, [m, n, wp, wm, wmn, wsp, wsm]);
        write(outfile, m, " ", n, " ", wp, " ", wm, " ", wmn, " ", wsp, " ", wsm);
      );
    );
    if(m % 50 == 0,
      print("  m=", m, ": total=", total, " sieved=", sieved);
    );
  );
  print("Scan [", MLO, ", ", MHI, "]: total=", total, " sieved=", sieved);
  return([total, sieved]);
};

\\ Criterion 1: omega(m^2+n^2) >= 3 AND omega(m^2-n^2) >= 4
crit1(wp, wm, wmn) = (wp >= 3) && (wm >= 4);

\\ Criterion 2: omega(m^2+n^2) >= 4 OR omega(m^2-n^2) >= 5
crit2(wp, wm, wmn) = (wp >= 4) || (wm >= 5);

print("=== Stage 1a: m in [300, 600], crit1 (wp>=3 AND wm>=4) ===");
r1 = scan(300, 600, crit1, SURV1);
print();
print("=== Stage 1b: m in [600, 1000], crit2 (wp>=4 OR wm>=5) ===");
r2 = scan(600, 1000, crit2, SURV2);

print();
print("=== SUMMARY ===");
print("Range [300, 600]: ", r1[1], " total, ", r1[2], " survivors");
print("Range [600, 1000]: ", r2[1], " total, ", r2[2], " survivors");
quit;

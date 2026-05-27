\\ Rank-5 hunt — Stage 1 v2: stronger sieve to keep candidate count manageable
\\ For m in [300, 600]: wp>=3 AND wm>=4 AND wmn>=4   (extra wmn condition)
\\ For m in [600, 1000]: (wp>=4 AND wm>=4) OR (wp>=3 AND wm>=5)
default(parisize, 1500000000);

SURV1 = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/sieve2_300_600.txt";
SURV2 = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/sieve2_600_1000.txt";

scan(MLO, MHI, criterion, outfile) = {
  my(total = 0, sieved = 0);
  write(outfile, "# m n wp wm wmn w(m+n) w(m-n)");
  for(m = MLO, MHI,
    for(n = 1, m-1,
      if(gcd(m, n) != 1, next);
      if(((m+n) % 2) == 0, next);
      total = total + 1;
      my(wp, wm, wmn);
      wp = omega(m^2 + n^2);
      wm = omega(m^2 - n^2);
      wmn = omega(m*n);
      if(criterion(wp, wm, wmn),
        sieved = sieved + 1;
        my(wsp = omega(m+n), wsm = omega(m-n));
        write(outfile, m, " ", n, " ", wp, " ", wm, " ", wmn, " ", wsp, " ", wsm);
      );
    );
    if(m % 100 == 0, print("  m=", m, ": total=", total, " sieved=", sieved));
  );
  return([total, sieved]);
};

crit1(wp, wm, wmn) = (wp >= 3) && (wm >= 4) && (wmn >= 4);
crit2(wp, wm, wmn) = ((wp >= 4) && (wm >= 4) && (wmn >= 4)) || ((wp >= 3) && (wm >= 5) && (wmn >= 4));

print("=== Stage 1a: m in [300, 600], strict (wp>=3 AND wm>=4 AND wmn>=4) ===");
r1 = scan(300, 600, crit1, SURV1);
print("  total=", r1[1], " sieved=", r1[2]);
print();
print("=== Stage 1b: m in [600, 1000], strict (wp+wm+wmn elevated) ===");
r2 = scan(600, 1000, crit2, SURV2);
print("  total=", r2[1], " sieved=", r2[2]);
quit;

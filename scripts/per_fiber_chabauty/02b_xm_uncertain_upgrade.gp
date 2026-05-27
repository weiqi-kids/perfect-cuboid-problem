\\ 02b_xm_uncertain_upgrade.gp — Promote uncertain rank(E_Hm) bounds at higher effort.

default(parisize, 2*10^9);
default(realprecision, 38);
read("lib.gp");

\\ The 11 uncertain (Xm=[0,2]) fibers from 02_rank_survey output
uncertain = [[118,25],[216,185],[261,52],[273,86],[578,319],[391,248],[464,65],[581,362],[589,316],[892,551],[928,623]];

print("=== Upgrade ellrank effort on uncertain (X-, E_Hm) factors ===");
{
  for(k = 1, length(uncertain),
    mn = uncertain[k];
    m = mn[1]; n = mn[2];
    E = ellminimalmodel(make_EHm_halcke(m, n));
    cond = ellglobalred(E)[1];
    print1("(", m, ",", n, ") cond=", cond);
    t0 = getabstime();
    r6 = ellrank(E, 6);
    print(" → eff6: [", r6[1], ",", r6[2], "]  t=", (getabstime()-t0)/1000., "s");
  );
}
quit;

\\ 05_xm_promote.gp — Aggressive promotion of the 11 uncertain Xm=[0,2] fibers.
\\ Try effort 6, then effort 10, then 2-isogenous walking (per Halcke template trick).

default(parisize, 2*10^9);
default(realprecision, 38);
read("lib.gp");

\\ The 11 uncertain Xm=[0,2] fibers from effort-1 survey
uncertain = [[118,25],[216,185],[261,52],[273,86],[578,319],[391,248],[464,65],[581,362],[589,316],[892,551],[928,623]];

print("=== Promote uncertain X-/E_Hm ranks ===");
print();

results = vector(length(uncertain));
{
for(k = 1, length(uncertain),
  mn = uncertain[k];
  m = mn[1]; n = mn[2];
  E = ellminimalmodel(make_EHm_halcke(m, n));
  cond = ellglobalred(E)[1];
  print1("(", m, ",", n, ") cond=", cond, " log10(cond)=", round(log(cond*1.0)/log(10)));
  t0 = getabstime();
  r6 = ellrank(E, 6);
  print1(" eff6=[", r6[1], ",", r6[2], "] t6=", (getabstime()-t0)/1000., "s");
  if(r6[1] == r6[2],
    print(" PROVEN rank ", r6[1]);
    results[k] = [m, n, r6[1], r6[2], "eff6"];
    next;
  );
  \\ Try effort 10
  t1 = getabstime();
  r10 = ellrank(E, 10);
  print(" eff10=[", r10[1], ",", r10[2], "] t10=", (getabstime()-t1)/1000., "s");
  if(r10[1] == r10[2],
    results[k] = [m, n, r10[1], r10[2], "eff10"];
    next;
  );
  results[k] = [m, n, r10[1], r10[2], "AMBIG"];
);
}

print();
print("=== Summary ===");
{
for(k = 1, length(results),
  r = results[k];
  print("(", r[1], ",", r[2], ") rank=[", r[3], ",", r[4], "] (", r[5], ")");
);
}

\\ For ambig ones with up>=2 we can try ell2cover or check if the curve has a 2-isogeny
quit;

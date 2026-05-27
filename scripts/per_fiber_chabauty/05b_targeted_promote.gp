\\ 05b_targeted_promote.gp — Targeted effort-6 promotion on the highest-impact uncertain Xm fibers.
\\ One at a time. Save each as we go.

default(parisize, 2*10^9);
default(realprecision, 38);
read("lib.gp");

\\ argument: which fiber index (0-based)
\\ run from cli: gp -q -e 'fiber_idx=N;' 05b_targeted_promote.gp

uncertain = [[118,25],[216,185],[261,52],[273,86],[578,319],[391,248],[464,65],[581,362],[589,316],[892,551],[928,623]];

print("=== Targeted promotion ===");
{
for(k = 1, length(uncertain),
  mn = uncertain[k];
  m = mn[1]; n = mn[2];
  E = ellminimalmodel(make_EHm_halcke(m, n));
  cond = ellglobalred(E)[1];
  log10c = round(log(cond*1.0)/log(10));
  print1("(", m, ",", n, ") logN=", log10c);
  t0 = getabstime();
  \\ ellrank with low ratio b/a is fast usually
  r6 = ellrank(E, 4);   \\ effort 4 first
  print1(" eff4=[", r6[1], ",", r6[2], "] t=", (getabstime()-t0)/1000., "s");
  if(r6[1] == r6[2],
    print(" *PROVEN rank ", r6[1]);
    write("xm_targeted.txt", m, " ", n, " ", r6[1], " ", r6[2], " eff4");
    next;
  );
  write("xm_targeted.txt", m, " ", n, " ", r6[1], " ", r6[2], " AMBIG_eff4");
  print(" AMBIG");
);
}
quit;

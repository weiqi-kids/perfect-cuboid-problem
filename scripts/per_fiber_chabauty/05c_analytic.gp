\\ 05c_analytic.gp — Use ellanalyticrank to potentially close the 11 uncertain Xm fibers.
\\ Conductor up to ~10^22 — may be infeasible for some. Try.

default(parisize, 4*10^9);
default(realprecision, 38);
read("lib.gp");

uncertain = [[118,25],[216,185],[261,52],[273,86],[578,319],[391,248],[464,65],[581,362],[589,316],[892,551],[928,623]];

\\ Use root number first (parity). If w = +1, rank is even (could be 0).
\\ If w = -1, rank is odd → at least 1 (rules out rank 0).

print("=== Root number screen ===");
{
for(k = 1, length(uncertain),
  mn = uncertain[k];
  m = mn[1]; n = mn[2];
  E = ellminimalmodel(make_EHm_halcke(m, n));
  rn = ellrootno(E);
  parity = if(rn==1, "even", "odd");
  cond = ellglobalred(E)[1];
  log10c = round(log(cond*1.0)/log(10));
  print("(", m, ",", n, ") logN=", log10c, " w=", rn, " parity=", parity);
);
}
quit;

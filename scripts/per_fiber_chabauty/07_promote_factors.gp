\\ 07_promote_factors.gp — Promote uncertain factor ranks on fibers with promising sum bounds.
\\ Goal: tighten sum_up to < 5 for as many fibers as possible.

default(parisize, 2*10^9);
read("lib.gp");

\\ Each entry: [m, n, which_factor]  where factor ∈ {"Eef","Eeg","Efg","EHp","Xm"}
to_promote = [[359,138,"Eef"],[366,107,"Eeg"],[506,47,"Eef"],[538,279,"Eef"],[834,361,"Eef"],[834,361,"EHp"],[851,334,"Eef"],[851,334,"EHp"],[869,442,"Eef"],[988,321,"Eef"]];

mkE(which, m, n) = my(q = qof(m,n)); \
  if(which == "Eef", make_Eef(q), \
  if(which == "Eeg", make_Eeg(q), \
  if(which == "Efg", make_Efg(q), \
  if(which == "EHp", make_EHp(q), \
  if(which == "Xm",  make_EHm_halcke(m, n), \
  0)))));

print("=== Promote uncertain factors ===");
{
for(k = 1, length(to_promote), \
  tp = to_promote[k];
  m = tp[1]; n = tp[2]; w = tp[3];
  E = ellminimalmodel(mkE(w, m, n));
  cond = ellglobalred(E)[1];
  log10c = round(log(cond*1.0)/log(10));
  print1("(", m, ",", n, ") ", w, " logN=", log10c);
  t0 = getabstime();
  r6 = ellrank(E, 6);
  print(" eff6=[", r6[1], ",", r6[2], "] t=", (getabstime()-t0)/1000., "s");
);
}
quit;

\\ 06_rank_geq_1_check.gp — For fibers where rank(E_Hm) >= 1 PROVEN,
\\ check if rank = 1 with parity -1 (this means root number is -1, so rank is odd ≥ 1).
\\ If rank = 1 with parity = -1 (rank exactly 1), the Halcke template doesn't directly close,
\\ but the genus-2 H_(m,n) has Jac rank = rank E_PCP + 1 = (3 or 4) + 1, may apply Chabauty there.

default(parisize, 2*10^9);
read("lib.gp");

\\ Survey results loaded
\\ Filter rank(E_Hm) >= 1
fibers_xm_pos = [];
\\ from survey_results.txt: include those with $14 >= 1
\\ Reading file manually:
data = readstr("survey_results.txt");
{
for(k = 2, length(data),
  line = data[k];
  parts = strsplit(line, " ");
  if(length(parts) < 17, next);
  m = eval(parts[2]); n = eval(parts[3]);
  xm_lo = eval(parts[14]); xm_up = eval(parts[15]);
  if(xm_lo >= 1, fibers_xm_pos = concat(fibers_xm_pos, [[m, n, xm_lo, xm_up]]));
);
}
print("Fibers with proven rank(X-) >= 1: ", length(fibers_xm_pos));

\\ For each, check root number of E_Hm
print("\nRoot number check on rank-≥-1 X- fibers:");
{
for(k = 1, length(fibers_xm_pos),
  fp = fibers_xm_pos[k];
  m = fp[1]; n = fp[2];
  E = ellminimalmodel(make_EHm_halcke(m, n));
  rn = ellrootno(E);
  cond = ellglobalred(E)[1];
  log10c = round(log(cond*1.0)/log(10));
  print("(", m, ",", n, ") rank=[", fp[3], ",", fp[4], "] w=", rn, " logN=", log10c);
);
}
quit;

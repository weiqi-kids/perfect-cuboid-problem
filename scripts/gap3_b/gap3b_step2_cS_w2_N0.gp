\\ ====================================================================
\\ Gap 3 — Step 2: Compute c_S(E), w_2(E), N_0 for all rank-jump fibers
\\ ====================================================================
\\
\\ For each of the 12 known rank-jump fibers, compute:
\\   - c_S(E) upper bound (Silverman 1990 height-difference constant)
\\   - w_2(E) = max_{p | Delta} v_p(Delta)
\\   - K(E) = 8 (c_S + log(2 w_2) + 1)
\\   - N_0_thm = ceil( sqrt(K(E) / h_0_thm) ) (worst-case Hindry)
\\   - N_0_emp = ceil( sqrt(K(E) / lambda_min) ) (using empirical height)
\\
\\ The key question this step answers: does (c_S(E) + log(2 w_2(E))) grow
\\ in a controlled way with log N(E)?  If c_S/log N is bounded, we get
\\ N_0_unif(q) growing only polylog-ically.

default(parisize, 500000000);
default(realprecision, 30);

c_S_upper(E) = {
  my(Delta = E[12], j_inv = E[13], b2 = E[6], hj, term);
  hj = log(max(abs(numerator(j_inv)), abs(denominator(j_inv))));
  term = (1.0/12) * log(abs(Delta)) + hj/12.0;
  term += 0.5 * log(max(1, abs(b2)/12.0 + 1));
  term += 2.0;
  term;
};

w2_max(E) = {
  my(Delta = abs(E[12]), fac, m = 1);
  fac = factor(Delta);
  for(i = 1, matsize(fac)[1],
    if(fac[i, 2] > m, m = fac[i, 2]);
  );
  m;
};

{
print("================================================================");
print("Gap 3 / Step 2: c_S(E), w_2(E), N_0 across all rank-jump fibers");
print("================================================================");
print();

DEGJ = 12;
CHI = 24;
C1 = 1.0 / (DEGJ * CHI / 2);
H0_THM = C1 * log(2);

print("Hindry theoretical h_0_thm = c_1 * log 2 = ", H0_THM);
print();

\\ All known rank-jump fibers
fibers = [
  [20,  21,    1, 2.552972734218146075],
  [7,   24,    1, 2.552498195645667976],
  [11,  60,    2, 2.289269032391549823],
  [48,  55,    1, 2.061999138167725902],
  [20,  99,    1, 2.045110543886585365],
  [96,  247,   1, 3.949726968740864888],
  [13,  84,    1, 7.128252692244292061],
  [39,  80,    1, 1.9728436106756197985],
  [17,  144,   2, 1.8458161903416604383],
  [104, 153,   2, 3.144854200746687000],
  [195, 748,   3, 2.732879863386030678],
  [741, 1540,  3, 3.869237199872033159]
];

print("Column headings:");
print("  q=u/v | N(E) | rk | lambda_min | log|Delta_min| | c_S(E) | w_2 | log(2 w_2)");
print("    K   | N_0_emp (using lambda_min) | N_0_thm (using Hindry h_0_thm)");
print("    c_S / log N(E) (ratio test)");
print();

\\ Track ratios
ratio_cS_logN_list = vector(#fibers);
ratio_logw2_logN_list = vector(#fibers);
ratio_K_logN_list = vector(#fibers);

table_rows = vector(#fibers);

for(i = 1, #fibers,
  u = fibers[i][1];
  v = fibers[i][2];
  rk = fibers[i][3];
  lambda = fibers[i][4];

  q = u/v;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);
  Ncond = ellglobalred(Emin)[1];
  Dmin = Emin.disc;
  logD = log(abs(Dmin)*1.0);
  logN = log(Ncond * 1.0);

  cS = c_S_upper(Emin);
  w2 = w2_max(Emin);
  log2w2 = log(2.0 * w2);
  K = 8.0 * (cS + log2w2 + 1.0);

  N0_emp = ceil(sqrt(K / lambda));
  N0_thm = ceil(sqrt(K / H0_THM));

  rat_cS = cS / logN;
  rat_w2 = log2w2 / logN;
  rat_K = K / logN;

  print("--- ", u, "/", v, " (rank ", rk, ") ---");
  print("  N(E) = ", Ncond, "    log N(E) = ", precision(logN, 8));
  print("  |Delta_min| = ", abs(Dmin));
  print("  log|Delta_min| = ", precision(logD, 8));
  print("  lambda_min = ", precision(lambda, 8));
  print("  c_S(E) (upper) = ", precision(cS, 8));
  print("  w_2(E) = ", w2, "    log(2*w_2) = ", precision(log2w2, 8));
  print("  K = 8(c_S + log(2w_2) + 1) = ", precision(K, 8));
  print("  N_0_emp (using lambda_min) = ", N0_emp);
  print("  N_0_thm (using Hindry h_0_thm = ", precision(H0_THM, 5), ") = ", N0_thm);
  print("  c_S/log N(E) = ", precision(rat_cS, 6));
  print("  log(2 w_2)/log N(E) = ", precision(rat_w2, 6));
  print("  K/log N(E) = ", precision(rat_K, 6));
  print();

  ratio_cS_logN_list[i] = rat_cS;
  ratio_logw2_logN_list[i] = rat_w2;
  ratio_K_logN_list[i] = rat_K;
  table_rows[i] = [u, v, rk, Ncond, lambda, cS, w2, K, N0_emp, N0_thm, logN];
);

print("================================================================");
print("Summary: ratio analysis (key question — is K/log N bounded?)");
print("================================================================");
print();
print("Max c_S/log N = ", precision(vecmax(ratio_cS_logN_list), 6));
print("Min c_S/log N = ", precision(vecmin(ratio_cS_logN_list), 6));
print("Max log(2 w_2)/log N = ", precision(vecmax(ratio_logw2_logN_list), 6));
print("Min log(2 w_2)/log N = ", precision(vecmin(ratio_logw2_logN_list), 6));
print("Max K/log N = ", precision(vecmax(ratio_K_logN_list), 6));
print("Min K/log N = ", precision(vecmin(ratio_K_logN_list), 6));
print();
print("If max(K / log N) <= C* (a constant), then we have");
print("    K(E) <= C* * log N(E),");
print("hence N_0(q) <= ceil(sqrt(C* * log N(E) / h_0_thm))");
print(" = O(sqrt(log N(E)))  (polylog in conductor).");
print();

print("================================================================");
print("Compact summary table");
print("================================================================");
print();
print("  q      | log N   | lambda_min | c_S    | w_2 | K       | N_0_emp | N_0_thm");
print("---------+---------+------------+--------+-----+---------+---------+--------");
for(i = 1, #table_rows,
  r = table_rows[i];
  print("  ", r[1], "/", r[2], " | ",
        precision(r[11], 6), " | ",
        precision(r[5], 5), " | ",
        precision(r[6], 5), " | ",
        r[7], " | ",
        precision(r[8], 5), " | ",
        r[9], " | ",
        r[10]);
);

print();
print("=== End Step 2 ===");
}
quit;

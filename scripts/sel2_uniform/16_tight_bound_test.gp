\\ =====================================================================
\\ 16_tight_bound_test.gp -- Test bounds: dim Sel_2 vs various predictors
\\
\\ Hypothesis: dim Sel_2(E_PCP(q)/Q) ≤ 2 + ω(rad(2·m·n·sf(P*Q)))
\\ where rad is the radical (product of distinct primes).
\\
\\ This is the "support of all relevant Hilbert symbols" prediction.
\\ =====================================================================

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

print("===== Tight bound test: dim Sel_2 vs various Heron-based predictors =====");
print();
print("Define:");
print("  L1 = 2 + ω(sf(P*Q))");
print("  L2 = 2 + ω(2 * m * n * sf(P*Q))");
print("  L3 = 2 + ω(2 * (m^2-n^2) * sf(P*Q))");
print();
print("(m,n)  dim_Sel2  L1  L2  L3");

{
nfibers = 0;
viol_L1 = 0;
viol_L2 = 0;
viol_L3 = 0;
maxS2 = 0;
maxL1 = 0;
maxL2 = 0;
maxL3 = 0;
for(m = 2, 60,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    nfibers++;
    P = (m+n)^2 - 2*n^2;
    Q = (m-n)^2 - 2*n^2;
    sPQ = sf(P * Q);
    Em = build_E_min(m, n);
    rk = ellrank(Em, 1);
    s2 = rk[2] + 2;
    L1 = 2 + omega(abs(sPQ));
    L2 = 2 + omega(2 * m * n * abs(sPQ));
    L3 = 2 + omega(2 * (m^2 - n^2) * abs(sPQ));
    if(s2 > L1, viol_L1++);
    if(s2 > L2, viol_L2++);
    if(s2 > L3, viol_L3++);
    if(s2 > maxS2, maxS2 = s2);
    if(L1 > maxL1, maxL1 = L1);
    if(L2 > maxL2, maxL2 = L2);
    if(L3 > maxL3, maxL3 = L3);
  );
);
print();
print("Tested ", nfibers, " fibers m <= 60");
print("Max dim Sel_2 = ", maxS2);
print("Max L1 (= 2 + ω(sf(PQ))) = ", maxL1);
print("Max L2 (= 2 + ω(2mn·sf(PQ))) = ", maxL2);
print("Max L3 (= 2 + ω(2(m²-n²)·sf(PQ))) = ", maxL3);
print("Violations: L1: ", viol_L1, "/", nfibers, "  L2: ", viol_L2, "/", nfibers, "  L3: ", viol_L3, "/", nfibers);
}

\\ Now check the 26 known high-rank fibers
print();
print("===== Test on known rank-3 and rank-4 fibers =====");
{
known_fibers = [[22,17], [35,22], [37,26], [40,29], [40,33], [99,28], [118,25], [174,83], [176,63], [181,38], [205,66], [209,72], [216,185], [221,202], [261,52], [273,86], [578,319], [217,24]];
print("(m,n)   dim_Sel2  L1  L2  L3  L3-dim_Sel2");
for(i=1, #known_fibers,
  mn = known_fibers[i];
  m = mn[1]; n = mn[2];
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
  P = (m+n)^2 - 2*n^2;
  Q = (m-n)^2 - 2*n^2;
  sPQ = sf(P * Q);
  Em = build_E_min(m, n);
  rk = ellrank(Em, 1);
  s2 = rk[2] + 2;
  L1 = 2 + omega(abs(sPQ));
  L2 = 2 + omega(2 * m * n * abs(sPQ));
  L3 = 2 + omega(2 * (m^2 - n^2) * abs(sPQ));
  print(mn, "  ", s2, "       ", L1, "  ", L2, "  ", L3, "  ", L3 - s2);
);
}

quit;

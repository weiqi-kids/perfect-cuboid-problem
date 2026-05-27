/* OQ1 Lehmer-type empirical test for E_PCP(q): Y^2 = X(X+1)(X+q^2)
 * For each fiber q, compute:
 *   - minimal model, conductor N_q
 *   - canonical height hhat(P) of a generator (smallest-height non-torsion)
 *   - H_j(q) = naive height of j-invariant; logHj
 *   - log N_q
 *   - ratios R(q) = hhat / log H_j(q) and hhat / log N_q
 * Plus Face-3 verification of EVERY generator found.
 *
 * Run sequentially. parisize 800MB.
 */
default(parisize, 800000000);
\p 40

/* ---- Face-3 recovery + test ----
 * c = 2*q*Y/(q^2 - X^2); F3 = c^2 + 1 + q^2; test issquare(F3).
 * Returns [c, F3, issquare(F3)]. Guards q^2-X^2 = 0.
 */
face3(q, P) = {
  my(X, Y, den, c, F3);
  X = P[1]; Y = P[2];
  den = q^2 - X^2;
  if(den == 0, return([oo, oo, -1]));   /* undefined: torsion-like */
  c = 2*q*Y/den;
  F3 = c^2 + 1 + q^2;
  [c, F3, issquare(F3)];
}

/* curve from q (rational): Y^2 = X(X+1)(X+q^2) = X^3 + (1+q^2)X^2 + q^2 X */
Eofq(q) = ellinit([0, 1+q^2, 0, q^2, 0]);

/* Process one fiber. mlabel/nlabel just for printing. effort for ellrank. */
process(m, n, effort) = {
  my(q, E, N, jinv, Hj, logHj, logN, rk, gens, ng, hh, hmin, hmin_idx, i, P, f3, anyhit, R1, R2);
  q = (m^2 - n^2)/(2*m*n);
  print("================================================================");
  print("FIBER (m,n)=(", m, ",", n, ")  q = ", q, " = ", q*1.0);
  E = Eofq(q);
  /* minimal model conductor */
  N = ellglobalred(E)[1];
  jinv = E.j;
  /* height of j-invariant: naive multiplicative height of rational number */
  Hj = max(abs(numerator(jinv)), abs(denominator(jinv)));
  logHj = log(Hj * 1.0);
  logN  = log(N * 1.0);
  print("  conductor N = ", N, "   log10 N = ", log(N*1.0)/log(10));
  print("  j-invariant numer/denom heights -> H_j = ", Hj);
  print("  log N = ", logN, "   log H_j = ", logHj);

  /* rank + generators via ellrank */
  rk = ellrank(E, effort);
  print("  ellrank(E, ", effort, ") = ", rk[1], " .. ", rk[2], "   (#gens returned: ", #rk[4], ")");
  gens = rk[4];
  ng = #gens;
  if(ng == 0,
    print("  NO non-torsion generator returned by ellrank. Trying ellheegner...");
    if(rk[1] >= 1,
      iferr(P = ellheegner(E); gens = [P]; ng = 1,
            err, print("  ellheegner FAILED: ", err); ng = 0);
    );
  );
  if(ng == 0,
    print("  *** No generator resolved in budget -> SKIP height/Face-3 ***");
    print("FIBER_RESULT (", m, ",", n, ") q=", q, " N=", N, " logN=", logN, " logHj=", logHj, " RANK=", rk[1],"..",rk[2], " hhat=NA R1=NA R2=NA");
    return(0);
  );

  /* canonical heights of all returned generators */
  hmin = -1; hmin_idx = 0;
  anyhit = 0;
  print("  --- generators, canonical heights, Face-3 ---");
  for(i = 1, ng,
    P = gens[i];
    if(!ellisoncurve(E, P), print("  !!! gen ", i, " NOT on curve, skip"); next);
    hh = ellheight(E, P);
    f3 = face3(q, P);
    print("   gen ", i, ": P = ", P);
    print("        ellisoncurve = ", ellisoncurve(E,P), "   hhat = ", hh);
    print("        c = ", f3[1]);
    print("        F3 = ", f3[2]);
    print("        issquare(F3) = ", f3[3]);
    if(f3[3] == 1, anyhit = 1; print("   *** F3 IS A PERFECT SQUARE -- PCP CANDIDATE *** at gen ", i));
    if(hmin < 0 || hh < hmin, hmin = hh; hmin_idx = i);
  );

  R1 = hmin / logHj;
  R2 = hmin / logN;
  print("  --- summary ---");
  print("  smallest-height generator idx = ", hmin_idx, "   hhat_min = ", hmin);
  print("  R(q) = hhat_min / log H_j = ", R1);
  print("         hhat_min / log N   = ", R2);
  if(anyhit, print("  >>> PCP CANDIDATE FLAG SET FOR THIS FIBER <<<"));
  /* machine-parseable line */
  print("FIBER_RESULT (", m, ",", n, ") q=", q, " N=", N, " logN=", logN, " logHj=", logHj, " RANK=", rk[1],"..",rk[2], " hhat=", hmin, " R1=", R1, " R2=", R2, " PCPFLAG=", anyhit);
  anyhit;
}

print("######## OQ1 LEHMER-TYPE EMPIRICAL TEST ########");
print("E_PCP(q): Y^2 = X(X+1)(X+q^2),  q = (m^2-n^2)/(2mn)");
print("");

/* === Part A: the six confirmed RANK-JUMP fibers (rank 1 or 2) ===
 * q in {20/21, 80/39, 60/11, 24/7, 84/13, 48/55}
 * stored as (m,n): q=(m^2-n^2)/(2mn). Solve which (m,n) give these q.
 * Instead just pass q directly via a tiny wrapper.
 */
processq(qval, tag, effort) = {
  my(E, N, jinv, Hj, logHj, logN, rk, gens, ng, hh, hmin, hmin_idx, i, P, f3, anyhit, R1, R2, q);
  q = qval;
  print("================================================================");
  print("FIBER ", tag, "  q = ", q, " = ", q*1.0);
  E = Eofq(q);
  N = ellglobalred(E)[1];
  jinv = E.j;
  Hj = max(abs(numerator(jinv)), abs(denominator(jinv)));
  logHj = log(Hj * 1.0);
  logN  = log(N * 1.0);
  print("  conductor N = ", N, "   log10 N = ", log(N*1.0)/log(10));
  print("  H_j = ", Hj, "   log N = ", logN, "   log H_j = ", logHj);
  rk = ellrank(E, effort);
  print("  ellrank(E, ", effort, ") = ", rk[1], " .. ", rk[2], "   (#gens: ", #rk[4], ")");
  gens = rk[4]; ng = #gens;
  if(ng == 0 && rk[1] >= 1,
    iferr(P = ellheegner(E); gens = [P]; ng = 1, err, print("  ellheegner FAILED")); );
  if(ng == 0,
    print("  *** No generator resolved -> SKIP ***");
    print("FIBER_RESULT ", tag, " q=", q, " N=", N, " logN=", logN, " logHj=", logHj, " RANK=", rk[1],"..",rk[2], " hhat=NA R1=NA R2=NA");
    return(0); );
  hmin = -1; hmin_idx = 0; anyhit = 0;
  print("  --- generators, canonical heights, Face-3 ---");
  for(i = 1, ng,
    P = gens[i];
    if(!ellisoncurve(E, P), print("  !!! gen ", i, " NOT on curve"); next);
    hh = ellheight(E, P);
    f3 = face3(q, P);
    print("   gen ", i, ": P = ", P);
    print("        ellisoncurve = ", ellisoncurve(E,P), "   hhat = ", hh);
    print("        c = ", f3[1]);
    print("        F3 = ", f3[2]);
    print("        issquare(F3) = ", f3[3]);
    if(f3[3] == 1, anyhit = 1; print("   *** F3 PERFECT SQUARE -- PCP CANDIDATE *** gen ", i));
    if(hmin < 0 || hh < hmin, hmin = hh; hmin_idx = i);
  );
  R1 = hmin / logHj; R2 = hmin / logN;
  print("  smallest-height gen idx=", hmin_idx, " hhat_min=", hmin);
  print("  R(q)=hhat/logHj = ", R1, "   hhat/logN = ", R2);
  if(anyhit, print("  >>> PCP CANDIDATE FLAG <<<"));
  print("FIBER_RESULT ", tag, " q=", q, " N=", N, " logN=", logN, " logHj=", logHj, " RANK=", rk[1],"..",rk[2], " hhat=", hmin, " R1=", R1, " R2=", R2, " PCPFLAG=", anyhit);
  anyhit;
}

print("#### PART A: six confirmed rank-jump fibers ####");
processq(20/21, "RJ-20/21", 3);
processq(80/39, "RJ-80/39", 3);
processq(60/11, "RJ-60/11", 4);
processq(24/7,  "RJ-24/7",  3);
processq(84/13, "RJ-84/13", 4);
processq(48/55, "RJ-48/55", 3);

print("");
print("#### PART B: rank-4 fibers (m,n) across growing conductor ####");
/* prior m<=300 catalog: 11 rank-4 fibers */
process(99, 28, 3);
process(118, 25, 3);
process(174, 83, 3);
process(176, 63, 3);
process(181, 38, 3);
process(205, 66, 3);
process(209, 72, 3);
process(216, 185, 3);
process(221, 202, 3);
process(261, 52, 3);
process(273, 86, 3);

quit;

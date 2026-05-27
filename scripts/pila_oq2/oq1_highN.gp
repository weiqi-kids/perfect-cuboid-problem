/* OQ1 extension: highest-conductor rank-4 fibers (m,n in [300,1180]) to
 * stretch the log H_j range as far as feasible. Same machinery as oq1_lehmer.gp.
 * These need higher ellrank effort; budget: skip if >~3 min (handled by outer timeout per-fiber).
 */
default(parisize, 800000000);
\p 40

face3(q, P) = {my(X,Y,den,c,F3); X=P[1];Y=P[2];den=q^2-X^2; if(den==0,return([oo,oo,-1])); c=2*q*Y/den; F3=c^2+1+q^2; [c,F3,issquare(F3)];}
Eofq(q) = ellinit([0, 1+q^2, 0, q^2, 0]);

process(m, n, effort) = {
  my(q, E, N, jinv, Hj, logHj, logN, rk, gens, ng, hh, hmin, hmin_idx, i, P, f3, anyhit, R1, R2);
  q = (m^2 - n^2)/(2*m*n);
  print("================================================================");
  print("FIBER (m,n)=(", m, ",", n, ")  q = ", q);
  E = Eofq(q);
  N = ellglobalred(E)[1];
  jinv = E.j;
  Hj = max(abs(numerator(jinv)), abs(denominator(jinv)));
  logHj = log(Hj * 1.0); logN = log(N * 1.0);
  print("  conductor N = ", N, "   log10 N = ", log(N*1.0)/log(10));
  print("  H_j = ", Hj, "   log N = ", logN, "   log H_j = ", logHj);
  rk = ellrank(E, effort);
  print("  ellrank(E, ", effort, ") = ", rk[1], " .. ", rk[2], "   (#gens: ", #rk[4], ")");
  gens = rk[4]; ng = #gens;
  if(ng == 0,
    print("  *** No generator resolved in budget -> SKIP ***");
    print("FIBER_RESULT (", m, ",", n, ") q=", q, " N=", N, " logN=", logN, " logHj=", logHj, " RANK=", rk[1],"..",rk[2], " hhat=NA R1=NA R2=NA"); return(0); );
  hmin = -1; hmin_idx = 0; anyhit = 0;
  print("  --- generators, canonical heights, Face-3 ---");
  for(i = 1, ng,
    P = gens[i];
    if(!ellisoncurve(E, P), print("  !!! gen ", i, " NOT on curve"); next);
    hh = ellheight(E, P);
    f3 = face3(q, P);
    print("   gen ", i, ": ellisoncurve=", ellisoncurve(E,P), " hhat=", hh, " issquare(F3)=", f3[3]);
    print("        c  = ", f3[1]);
    print("        F3 = ", f3[2]);
    if(f3[3] == 1, anyhit = 1; print("   *** F3 PERFECT SQUARE -- PCP CANDIDATE *** gen ", i));
    if(hmin < 0 || hh < hmin, hmin = hh; hmin_idx = i);
  );
  R1 = hmin / logHj; R2 = hmin / logN;
  print("  smallest-height gen idx=", hmin_idx, " hhat_min=", hmin, " R1=", R1, " R2=", R2);
  if(anyhit, print("  >>> PCP CANDIDATE FLAG <<<"));
  print("FIBER_RESULT (", m, ",", n, ") q=", q, " N=", N, " logN=", logN, " logHj=", logHj, " RANK=", rk[1],"..",rk[2], " hhat=", hmin, " R1=", R1, " R2=", R2, " PCPFLAG=", anyhit);
  anyhit;
}

print("#### PART C: high-conductor rank-4 fibers (m in [300,1180]) ####");
/* 8 new in [300,1000] from RANK5-HUNT-EXTENDED */
process(421, 344, 2);
process(454, 131, 2);
process(488, 293, 2);
process(592, 59, 2);
process(640, 317, 2);
process(752, 353, 2);
process(797, 538, 2);
process(848, 617, 2);
/* 6 new in [1000,1180] */
process(1012, 223, 2);
process(1012, 301, 2);
process(1017, 512, 2);
process(1021, 328, 2);
process(1048, 707, 2);
process(1136, 343, 2);
/* the record fiber N~1.03e20 */
process(578, 319, 4);
quit;

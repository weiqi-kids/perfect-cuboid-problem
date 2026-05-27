\\ ============================================================
\\ Paper P3: Independent verification of Face-3 non-squareness
\\ for the rank-jump fibers of E_PCP(q): y^2 = x(x+1)(x+q^2)
\\
\\ Face-3 map: c = 2*y*q/(q^2 - x^2), a = c^2 + 1 + q^2.
\\ A perfect cuboid on fiber q would need a in (Q^*)^2.
\\ Author: CL / Lightman Chang
\\ ============================================================
default(parisize, 3000000000);
default(realprecision, 40);

\\ Face-3 squareness test for a point pt on E with parameter qq
face3sq(qq, pt) = {
  my(xx, yy, cc, aa);
  if(pt == [0], return(-1));        \\ point at infinity
  xx = pt[1]; yy = pt[2];
  if(qq^2 - xx^2 == 0, return(-2)); \\ map undefined
  cc = 2*yy*qq/(qq^2 - xx^2);
  aa = cc^2 + 1 + qq^2;
  if(aa <= 0, return(-3));
  issquare(aa);
};

\\ Enumerate the full torsion subgroup as a vector of points
torsion_points(E) = {
  my(to, g, ords, L, ng);
  to = elltors(E);
  ords = to[2];
  g = to[3];
  ng = #g;
  L = List([[0]]);   \\ identity
  if(ng == 1,
    for(i = 1, ords[1]-1, listput(L, ellmul(E, g[1], i)))
  );
  if(ng == 2,
    for(i = 0, ords[1]-1,
      for(j = 0, ords[2]-1,
        if(i == 0 && j == 0, next);
        listput(L, elladd(E, ellmul(E, g[1], i), ellmul(E, g[2], j)))
      )
    )
  );
  Vec(L);
};

\\ Rank-1 fiber check: nP + torsion, n = 1..NMAX
check_rank1(qq, P, NMAX) = {
  my(E, tp, cntsq, cntdef, k, pt, base, s);
  E = ellinit([0, 1+qq^2, 0, qq^2, 0]);
  if(!ellisoncurve(E, P), print("  FAIL: P not on E for q=", qq); return(0));
  if(ellorder(E, P) != 0, print("  FAIL: P torsion for q=", qq); return(0));
  tp = torsion_points(E);
  cntsq = 0; cntdef = 0;
  for(k = 1, NMAX,
    base = ellmul(E, P, k);
    for(t = 1, #tp,
      pt = elladd(E, base, tp[t]);
      s = face3sq(qq, pt);
      if(s == 1, cntsq++; print("  *** SQUARE q=", qq, " n=", k, " tors#", t));
    )
  );
  print("  q=", qq, "  rank 1  N=", NMAX, "  #torsion=", #tp,
        "  cosets checked=", NMAX*#tp, "  squares=", cntsq);
  cntsq;
};

\\ Rank-2 fiber check: a*G1 + b*G2 + torsion, |a|,|b| <= B
check_rank2(qq, G1, G2, B) = {
  my(E, tp, cntsq, pt, base, s, ncheck);
  E = ellinit([0, 1+qq^2, 0, qq^2, 0]);
  if(!ellisoncurve(E, G1) || !ellisoncurve(E, G2),
     print("  FAIL: gen not on E for q=", qq); return(0));
  tp = torsion_points(E);
  cntsq = 0; ncheck = 0;
  for(a = -B, B,
    for(b = -B, B,
      if(a == 0 && b == 0, next);
      base = elladd(E, ellmul(E, G1, a), ellmul(E, G2, b));
      for(t = 1, #tp,
        pt = elladd(E, base, tp[t]);
        s = face3sq(qq, pt);
        ncheck++;
        if(s == 1, cntsq++; print("  *** SQUARE q=", qq, " (a,b)=(", a, ",", b, ") tors#", t));
      )
    )
  );
  print("  q=", qq, "  rank 2  B=", B, "  #torsion=", #tp,
        "  cosets checked=", ncheck, "  squares=", cntsq);
  cntsq;
};

print("================================================================");
print("Face-3 non-squareness verification (Paper P3)");
print("================================================================");
print();

\\ ---- Rank-1 fibers (generator on original E_PCP model) ----
print("--- Rank-1 fibers, nP + full torsion, n = 1..50 ---");
check_rank1(20/21,  [-45/49, 10/343],                  50);
check_rank1(80/39,  [32/9, 1312/117],                  50);
check_rank1(24/7,   [3/28, 465/392],                   50);
check_rank1(84/13,  [56700/36517, 329627340/25160213], 50);
check_rank1(48/55,  [288/55, 42336/3025],              50);
print();

\\ ---- Rank-2 fiber q = 60/11 ----
print("--- Rank-2 fiber q = 60/11, aG1+bG2 + torsion, |a|,|b| <= 8 ---");
check_rank2(60/11, [-180/11, 7020/121], [-300/11, 5100/121], 8);
print();
print("=== End Face-3 verification ===");
quit;

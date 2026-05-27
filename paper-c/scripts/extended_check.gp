\\ ============================================================
\\ Paper P3: Extended direct verification window.
\\ Since the N_0 closure is NOT a clean theorem (downgraded),
\\ we push the rigorous finite verification window as far as
\\ is computationally cheap: rank-1 fibers nP+torsion to n=200;
\\ rank-2 fiber 60/11 to |a|,|b| <= 12.
\\ The honest theorem is: a_n non-square for ALL these checked
\\ multiples (rigorous), and conjecturally for all n (heuristic).
\\ Author: CL / Lightman Chang
\\ ============================================================
default(parisize, 6000000000);
default(realprecision, 40);

face3sq(qq, pt) = {
  my(xx, yy, cc, aa);
  if(pt == [0], return(-1));
  xx = pt[1]; yy = pt[2];
  if(qq^2 - xx^2 == 0, return(-2));
  cc = 2*yy*qq/(qq^2 - xx^2);
  aa = cc^2 + 1 + qq^2;
  if(aa <= 0, return(-3));
  issquare(aa);
};

torsion_points(E) = {
  my(to, g, ords, L, ng);
  to = elltors(E); ords = to[2]; g = to[3]; ng = #g;
  L = List([[0]]);
  if(ng == 1, for(i = 1, ords[1]-1, listput(L, ellmul(E, g[1], i))));
  if(ng == 2, for(i = 0, ords[1]-1, for(j = 0, ords[2]-1,
      if(i == 0 && j == 0, next);
      listput(L, elladd(E, ellmul(E, g[1], i), ellmul(E, g[2], j))))));
  Vec(L);
};

check_rank1(qq, P, NMAX) = {
  my(E, tp, cntsq, base, pt, s);
  E = ellinit([0, 1+qq^2, 0, qq^2, 0]);
  tp = torsion_points(E);
  cntsq = 0;
  for(k = 1, NMAX,
    base = ellmul(E, P, k);
    for(t = 1, #tp,
      pt = elladd(E, base, tp[t]);
      s = face3sq(qq, pt);
      if(s == 1, cntsq++; print("  *** SQUARE q=", qq, " n=", k, " t=", t))));
  print("  q=", qq, "  n=1..", NMAX, "  cosets=", NMAX*#tp, "  squares=", cntsq);
  cntsq;
};

check_rank2(qq, G1, G2, B) = {
  my(E, tp, cntsq, base, pt, s, nc);
  E = ellinit([0, 1+qq^2, 0, qq^2, 0]);
  tp = torsion_points(E);
  cntsq = 0; nc = 0;
  for(a = -B, B, for(b = -B, B,
    if(a == 0 && b == 0, next);
    base = elladd(E, ellmul(E, G1, a), ellmul(E, G2, b));
    for(t = 1, #tp,
      pt = elladd(E, base, tp[t]);
      s = face3sq(qq, pt); nc++;
      if(s == 1, cntsq++; print("  *** SQUARE q=", qq, " (", a, ",", b, ")")))));
  print("  q=", qq, "  |a|,|b|<=", B, "  cosets=", nc, "  squares=", cntsq);
  cntsq;
};

print("=== Extended direct verification (Paper P3) ===");
print();
print("Rank-1 fibers, nP + torsion, n = 1..200:");
check_rank1(20/21, [-45/49, 10/343],                  200);
check_rank1(80/39, [-160/39, 1760/1521],              200);
check_rank1(24/7,  [-75/7, 510/49],                   200);
check_rank1(84/13, [17787/169, 216678/169],           200);
check_rank1(48/55, [-24/25, 24/275],                  200);
check_rank1(20/99, [-20/27, 980/2673],                200);
print();
print("Rank-2 fiber 60/11, aG1+bG2 + torsion, |a|,|b| <= 12:");
check_rank2(60/11, [-180/11, 7020/121], [-300/11, 5100/121], 12);
print();
print("=== End extended verification ===");
quit;

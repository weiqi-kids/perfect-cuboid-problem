\\ ============================================================
\\ Paper P3: Independent rank re-verification of all listed
\\ rank-jump fibers of E_PCP(q): y^2 = x(x+1)(x+q^2).
\\ ellrank gives [low, high]; tight closure needs low==high.
\\ We also report conductor, torsion, generator height.
\\ Author: CL / Lightman Chang
\\ ============================================================
default(parisize, 4000000000);
default(realprecision, 40);

report(qq) = {
  my(E, cond, tor, r, lo, hi, pts, g, ht);
  E = ellinit([0, 1+qq^2, 0, qq^2, 0]);
  cond = ellglobalred(E)[1];
  tor = elltors(E)[2];
  r = ellrank(E);
  lo = r[1]; hi = r[2]; pts = r[4];
  print("--- q = ", qq, " ---");
  print("  conductor   = ", cond);
  print("  torsion     = ", tor);
  print("  ellrank     = [", lo, ", ", hi, "]  (tight? ", if(lo==hi,"YES","NO"), ")");
  if(#pts >= 1,
    for(i=1,#pts,
      g = pts[i];
      ht = ellheight(E, g);
      print("  gen[", i, "]      = ", g, "   hhat = ", precision(ht, 12));
    )
  );
  print();
};

print("================================================================");
print("Rank re-verification: rank-jump fibers (Paper P3)");
print("================================================================");
print();
\\ Six SILVERMAN-RANK-JUMP-CLOSURE fibers
report(20/21);   \\ Peschmann (5,2), Example 5.1 -- expect rank 1
report(80/39);   \\ (8,5) outside S100 -- expect rank 1
report(24/7);    \\ (4,3) -- expect rank 1
report(84/13);   \\ (7,6) -- expect rank 1
report(48/55);   \\ (8,3) -- expect rank 1
report(60/11);   \\ (6,5) -- expect rank 2
\\ The third fiber outside S100 from the audit
report(20/99);   \\ (10,1) outside S100 -- expect rank 1
quit;

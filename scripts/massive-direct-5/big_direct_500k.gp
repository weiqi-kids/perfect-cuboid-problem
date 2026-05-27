\\ Extended direct search on E_PCP for three BEYOND-QC fibers with no
\\ generator found at B=200000. Now scanning up to B=500000.
\\
\\ Memory budget: 500 MB (host has 2.2 GiB free RAM).
\\ Fibers: (73,24), (88,35), (99,28).
\\
\\ For each fiber:
\\   u = 2mn, v = m^2 - n^2
\\   Integer model E: y^2 = x(x + u^2)(x + v^2)
\\   For coprime (a,b), |a| <= B, 1 <= b <= sqrt(B):
\\     rhs = a (a + u^2 b^2) (a + v^2 b^2)
\\     If rhs is a square and X = a/b^2 is not in {0, -u^2, -v^2},
\\     record (X, Y/b^3), canonical height, and Face-3 verdict.

default(parisize, 500000000);
default(realprecision, 40);

big_search(mm, nn, B) = {
  my(uu, vv, qq, found, a, b, X, Y, rhs, ngood, xq, yq, cc, F3, sq,
     E, hcan, ncand, t_start, t_last, nb, n_a_per_b);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  qq = vv/uu;
  E  = ellinit([0, uu^2 + vv^2, 0, uu^2*vv^2, 0]);  \\ y^2 = x(x+u^2)(x+v^2)
  print("\n=========================================");
  print("Extended direct search (m,n)=(", mm, ",", nn, "), q=", vv, "/", uu, " B=", B);
  print("u=", uu, " v=", vv);
  print("=========================================");
  found = List();
  ngood = 0;
  ncand = 0;
  nb = sqrtint(B);
  print("  b ranges 1..", nb, "  a ranges -", B, "..", B);
  t_start = getwalltime();
  t_last  = t_start;
  for(b = 1, nb,
    n_a_per_b = 0;
    for(a = -B, B,
      if(a == 0, next);
      if(gcd(a, b) != 1, next);
      n_a_per_b += 1;
      rhs = a*(a + uu^2*b^2)*(a + vv^2*b^2);
      if(rhs < 0, next);
      if(issquare(rhs, &Y),
        ngood += 1;
        if(a/b^2 == 0 || a/b^2 == -uu^2 || a/b^2 == -vv^2, next);
        X  = a/b^2;
        \\ y_E coordinate on integer model is Y/b^3
        \\ Map to q-model: x_q = X/u^2, y_q = (Y/b^3)/u^3
        xq = X / uu^2;
        yq = (Y/b^3) / uu^3;
        cc = 2*qq*yq / (qq^2 - xq^2);
        F3 = cc^2 + 1 + qq^2;
        sq = issquare(F3);
        hcan = ellheight(E, [X, Y/b^3]);
        listput(found, [X, Y/b^3, cc, sq, hcan]);
        print("  *** SQUARE FOUND ***");
        print("      a=", a, "  b=", b);
        print("      P_int = [", X, ",", Y/b^3, "]");
        print("      canonical height = ", hcan);
        print("      q-model: x_q=", xq, "  y_q=", yq);
        print("      c(P) = ", cc);
        print("      F3 = c^2 + 1 + q^2 = ", F3);
        print("      F3 is a square? ", sq);
      );
    );
    ncand += n_a_per_b;
    if(b % 50 == 0 || b == nb,
      print("  progress: b=", b, "/", nb,
            "  cand so far=", ncand,
            "  squares so far=", #found,
            "  wall(s)=", (getwalltime() - t_start)/1000);
    );
  );
  print("  Total candidates scanned: ", ncand);
  print("  Total squares found: ", ngood);
  print("  Non-trivial squares (after excluding {0,-u^2,-v^2}): ", #found);
  print("  Wall time (s): ", (getwalltime() - t_start)/1000);
  return(found);
};

print("=== Extended direct search B=500000 on three open fibers ===");
print("=== parisize = 500 MB ===");
T0 = getwalltime();
print("=== started at wall-ms ", T0);

r73 = big_search(73, 24, 500000);
print("\n*** (73,24) summary: ", #r73, " non-trivial squares ***");

r88 = big_search(88, 35, 500000);
print("\n*** (88,35) summary: ", #r88, " non-trivial squares ***");

r99 = big_search(99, 28, 500000);
print("\n*** (99,28) summary: ", #r99, " non-trivial squares ***");

T1 = getwalltime();
print("\n=== DONE ===");
print("=== finished at wall-ms ", T1, "  total seconds: ", (T1 - T0)/1000);
quit;

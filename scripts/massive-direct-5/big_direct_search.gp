\\ BIG direct search on E_PCP for each fiber, B=200000

default(parisize, 12000000000);
default(realprecision, 40);

big_search(mm, nn, B) = {
  local(uu, vv, found, a, b, X, Y, rhs, ngood, idx, qq, cc, F3, sq, exclude_X);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  qq = vv/uu;
  exclude_X = [0, -uu^2, -vv^2];
  print("\n=========================================");
  print("BIG direct search (m,n)=(", mm, ",", nn, "), q=", vv, "/", uu, " B=", B);
  print("=========================================");
  found = List();
  ngood = 0;
  for(b = 1, sqrtint(B), for(a = -B, B,
    if(gcd(a, b) != 1, next);
    if(a == 0, next);
    rhs = a*(a + uu^2*b^2)*(a + vv^2*b^2);
    if(rhs < 0, next);
    if(issquare(rhs, &Y),
      ngood += 1;
      X = a/b^2;
      if(X == 0 || X == -uu^2 || X == -vv^2, next);
      \\ Check Face-3 in q-model: x_q = X/u^2, y_q = (Y/b^3)/u^3
      xq = X / uu^2;
      yq = (Y/b^3) / uu^3;
      cc = 2*qq*yq / (qq^2 - xq^2);
      F3 = cc^2 + 1 + qq^2;
      sq = issquare(F3);
      listput(found, [X, Y/b^3, cc, sq]);
      print("    P=[", X, ",", Y/b^3, "] c=", cc, " F3-square=", sq);
    );
  ));
  print("  Total squares: ", ngood, "  Candidates: ", #found);
  return(found);
};

print("=== Running BIG direct searches ===");
big_search(61, 38, 200000);
big_search(63, 38, 200000);
big_search(73, 24, 200000);
big_search(88, 35, 200000);
big_search(99, 28, 200000);

print("\n=== DONE ===");
quit;

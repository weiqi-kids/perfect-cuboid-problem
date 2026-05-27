\\ Direct point search on E_PCP(q): y^2 = x(x+u^2)(x+v^2)
\\ Try x = a/b for small a, b in numerator/denominator search,
\\ but smarter: x = -u^2 * t^2 / s^2 form, etc.
\\ Also try via isogeny: 2-isogenous curve to E_PCP

default(parisize, 12000000000);
default(realprecision, 38);

\\ E_PCP: y^2 = x(x+u^2)(x+v^2)
\\ Standard 2-isogenous curves at each 2-torsion point:
\\   E0: y^2 = x(x+u^2)(x+v^2)
\\ phi based at (0,0): E0' : Y^2 = X^3 - 2(u^2+v^2)X^2 + (u^2-v^2)^2 X
\\ phi based at (-u^2,0): translate first

\\ Let's just try direct rational search.

direct_search(mm, nn, Bx) =
{
  local(uu, vv, E0, EE, found, a, b, x, rhs, y, P);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  E0 = ellinit([0, uu^2+vv^2, 0, uu^2*vv^2, 0]);
  print("--- (m,n) = (", mm, ",", nn, ") ---");
  print("  Searching x = a/b^2, |a| <= ", Bx, ", b <= sqrt(Bx)");
  found = List();
  for(b = 1, sqrtint(Bx),
    for(a = -Bx, Bx,
      if(a == 0 && b == 1, next);
      \\ x = a/b^2  =>  b^4*y^2 = a(a+u^2 b^2)(a + v^2 b^2)
      rhs = a*(a + uu^2*b^2)*(a + vv^2*b^2);
      if(rhs < 0, next);
      if(issquare(rhs, &y),
        x = a/b^2;
        y = y/b^3;
        P = [x, y];
        if(ellisoncurve(E0, P),
          \\ Check non-torsion:
          if(ellorder(E0, P) == 0,
            listput(found, P);
            print("    FOUND non-torsion P = ", P, " h=", ellheight(E0, P));
          );
        );
      );
    );
  );
  print("  Total non-torsion points found: ", #found);
  return(found);
}

\\ Quick test on (61, 38) with small search
direct_search(61, 38, 200);
direct_search(63, 38, 200);
direct_search(73, 24, 200);
direct_search(88, 35, 200);
direct_search(99, 28, 200);

quit;

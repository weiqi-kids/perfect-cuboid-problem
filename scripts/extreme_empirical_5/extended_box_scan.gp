\\ Extended 1D box scan on E_PCP using known generators.
\\ For each fiber with explicit generator G, enumerate n*G for n in [-N, N],
\\ form the q-model image (x_q, y_q) = (X/u^2, Y/u^3) and test
\\   Face 3 closure: c^2 + 1 + q^2 in Q*^2,  c = 2*q*y_q / (q^2 - x_q^2)
\\
\\ Generator (61,38): G = (47196, 2306232540), h_can ~ 5.26
\\   n = N gives canonical height N^2 * 5.26 = 5.26e4 at N=100, 2.1e5 at N=200,
\\   8.4e5 at N=400 -- which dwarfs the direct B=200,000 height bound.
\\
\\ Generator (63,38): G = (74235, 3318452970), h_can ~ 4.50
\\   N=200 gives canonical height 1.8e5.

default(parisize, 12000000000);
default(realprecision, 60);

make_E_PCP(mm, nn) = {
  my(uu, vv);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  return(ellinit([0, uu^2 + vv^2, 0, uu^2 * vv^2, 0]));
};

scan_1d(mm, nn, G, Nmax) = {
  my(E, uu, vv, qq, P, X, Y, xq, yq, cc, F3, sqF3, h_can, hits, t0);
  uu = 2*mm*nn; vv = mm^2 - nn^2; qq = vv/uu;
  E = make_E_PCP(mm, nn);
  h_can = ellheight(E, G);
  print("\n--- 1D scan E_PCP for (m,n)=(", mm, ",", nn, ") ---");
  print("  G = ", G, "  h_can(G) = ", h_can);
  print("  Nmax = ", Nmax, "  range of n^2*h_can = up to ", Nmax^2 * h_can);
  hits = 0;
  t0 = gettime();
  for(n1 = 1, Nmax,
    P = ellmul(E, G, n1);
    if(P == [0], next);
    X = P[1]; Y = P[2];
    xq = X / uu^2;
    yq = Y / uu^3;
    if(qq^2 - xq^2 == 0, next);
    cc = 2*qq*yq / (qq^2 - xq^2);
    F3 = cc^2 + 1 + qq^2;
    sqF3 = issquare(F3);
    if(sqF3,
      hits += 1;
      print("    [HIT n1=", n1, "] P = ", P, "  c = ", cc, "  F3 square");
    );
    if(n1 % 50 == 0,
      print("    progress: n1=", n1, "  elapsed=", gettime() - t0, " ms, hits=", hits);
      t0 = gettime();
    );
  );
  print("  HITS up to N=", Nmax, ": ", hits);
  return(hits);
};

print("=== Extended 1D box scan along the known E_PCP generators ===");

G_61_38 = [47196, 2306232540];
G_63_38 = [74235, 3318452970];

\\ Push to canonical height ~ 10^7.
\\ For (61,38): h_can(G) ~ 5.26, so N ~ sqrt(10^7 / 5.26) ~ 1378.
\\ For (63,38): h_can(G) ~ 4.50, so N ~ sqrt(10^7 / 4.50) ~ 1491.
\\ Use N = 1500 for both to slightly exceed 10^7.

scan_1d(61, 38, G_61_38, 1500);
scan_1d(63, 38, G_63_38, 1500);

print("\n=== DONE EXTENDED BOX SCAN ===");
quit;

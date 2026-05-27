\\ ============================================================
\\ Rank survey for E_PCP(q_{m,n}) over all primitive Pythagorean
\\ parameter pairs with m <= 50.
\\
\\ E(m,n): y^2 = x (x + b^2)(x + a^2)
\\ where a = m^2 - n^2, b = 2 m n.
\\
\\ Tests Pick 13 prediction: rank <= 4 uniformly.
\\
\\ Output per fiber: m n m+n N analytic_rank
\\ Output summary: rank distribution, list of rank>=3 fibers.
\\ ============================================================

default(parisize, 4000000000);
default(realprecision, 38);

{
  total = 0;
  countrank = vector(8);   \\ index 1..8 -> ranks 0..7
  rank3plus_list = List();
  rank4plus_list = List();

  for(m = 2, 50,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        a = m^2 - n^2;
        b = 2*m*n;
        \\ integer Weierstrass model y^2 = x(x+b^2)(x+a^2)
        E = ellinit([0, a^2 + b^2, 0, a^2*b^2, 0]);
        Emin = ellminimalmodel(E);
        gr = ellglobalred(Emin);
        N = gr[1];
        ar = ellanalyticrank(Emin)[1];
        total++;
        if(ar+1 <= 8, countrank[ar+1]++);

        print(m, " ", n, " ", m+n, " ", N, " ", ar);

        if(ar >= 3, listput(rank3plus_list, [m, n, m+n, N, ar]));
        if(ar >= 4, listput(rank4plus_list, [m, n, m+n, N, ar]));
      );
    );
  );

  print("");
  print("=== SUMMARY ===");
  print("total fibers (m <= 50): ", total);
  for(k = 0, 7, print("rank ", k, ": ", countrank[k+1]));
  print("");
  print("=== RANK >= 3 LIST ===");
  if(#rank3plus_list == 0,
    print("NONE FOUND."),
    for(i = 1, #rank3plus_list, print(rank3plus_list[i]))
  );
  print("");
  print("=== RANK >= 4 LIST ===");
  if(#rank4plus_list == 0,
    print("NONE FOUND. Pick 13 conjecture rank <= 4 SURVIVES m<=50 scan."),
    for(i = 1, #rank4plus_list, print("PROBLEM: ", rank4plus_list[i]))
  );
  print("=== DONE ===");
}
quit;

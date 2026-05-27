\\ ============================================================
\\ Rank survey for E_PCP(q_{m,n}) over all primitive Pythagorean
\\ parameter pairs with m <= 100.
\\
\\ E(m,n): y^2 = x (x + b^2)(x + a^2)
\\ where a = m^2 - n^2, b = 2 m n  (q = a/b).
\\
\\ For each (m,n) with gcd(m,n)=1, m+n odd, 1<=n<m<=100:
\\ output: m n m+n N analytic_rank
\\ ============================================================

default(parisize, 2000000000);
default(realprecision, 38);

isprime_simple(p) = isprime(p);

{
  total = 0;
  countrank = vector(6);   \\ index 1..6 -> ranks 0..5
  rank2_list = List();
  rank3plus_list = List();
  jumps = List();   \\ rank >= 1 fibers

  for(m = 2, 100,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        a = m^2 - n^2;
        b = 2*m*n;
        \\ integer Weierstrass model E(m,n): y^2 = x(x+b^2)(x+a^2)
        E = ellinit([0, a^2 + b^2, 0, a^2*b^2, 0]);
        Emin = ellminimalmodel(E);
        gr = ellglobalred(Emin);
        N = gr[1];
        \\ analytic rank (fast)
        ar = ellanalyticrank(Emin)[1];
        total++;
        if(ar+1 <= 6, countrank[ar+1]++);
        mn_prime = isprime(m+n);
        m2n2_prime = isprime(m^2+n^2);
        mn_dist8 = [m % 8, n % 8];

        print(m, " ", n, " ", m+n, " ", N, " ", ar, " ",
              mn_prime, " ", m2n2_prime);

        if(ar >= 1, listput(jumps, [m, n, m+n, N, ar, mn_prime, m2n2_prime]));
        if(ar == 2, listput(rank2_list, [m, n, m+n, N]));
        if(ar >= 3, listput(rank3plus_list, [m, n, m+n, N, ar]));
      );
    );
  );

  print("");
  print("=== SUMMARY ===");
  print("total fibers: ", total);
  for(k = 0, 5, print("rank ", k, ": ", countrank[k+1]));
  print("");
  print("=== RANK 2 LIST ===");
  for(i = 1, #rank2_list, print(rank2_list[i]));
  print("");
  print("=== RANK >= 3 LIST ===");
  if(#rank3plus_list == 0,
    print("NONE FOUND. Rank <= 2 conjecture survives m<=100 scan."),
    for(i = 1, #rank3plus_list, print("COUNTEREXAMPLE: ", rank3plus_list[i]))
  );
  print("");
  print("=== M+N PRIME COUNTS (rank >= 1) ===");
  jump_total = #jumps;
  jump_mn_prime = 0;
  jump_mn_not_prime = List();
  for(i = 1, jump_total,
    if(jumps[i][6] == 1, jump_mn_prime++, listput(jump_mn_not_prime, jumps[i]))
  );
  print("rank>=1 fibers: ", jump_total);
  print("  m+n prime: ", jump_mn_prime);
  print("  m+n composite: ", jump_total - jump_mn_prime);
  print("=== rank>=1 with m+n composite ===");
  for(i = 1, #jump_mn_not_prime, print(jump_mn_not_prime[i]));

  print("");
  print("=== m = n+1 sub-family ===");
  for(m = 2, 100,
    n = m - 1;
    if(gcd(m,n) == 1 && (m+n) % 2 == 1,
      a = m^2 - n^2;
      b = 2*m*n;
      E = ellinit([0, a^2+b^2, 0, a^2*b^2, 0]);
      Emin = ellminimalmodel(E);
      ar = ellanalyticrank(Emin)[1];
      print("m=", m, " n=", n, " m+n=", m+n, " rank=", ar,
            " m+n prime?=", isprime(m+n));
    );
  );

  print("");
  print("=== mod-4 / mod-8 analysis of rank>=1 ===");
  c_m4 = vector(4); c_n4 = vector(4);
  c_m8 = vector(8); c_n8 = vector(8);
  for(i = 1, #jumps,
    mm = jumps[i][1]; nn = jumps[i][2];
    c_m4[mm%4 + 1]++; c_n4[nn%4 + 1]++;
    c_m8[mm%8 + 1]++; c_n8[nn%8 + 1]++;
  );
  print("m mod 4 counts (0..3): ", c_m4);
  print("n mod 4 counts (0..3): ", c_n4);
  print("m mod 8 counts (0..7): ", c_m8);
  print("n mod 8 counts (0..7): ", c_n8);

  print("");
  print("=== m^2+n^2 prime correlation (rank>=1) ===");
  jump_m2n2_prime = 0;
  for(i = 1, jump_total,
    if(jumps[i][7] == 1, jump_m2n2_prime++)
  );
  print("rank>=1 with m^2+n^2 prime: ", jump_m2n2_prime, " / ", jump_total);

  print("=== DONE ===");
}
quit;

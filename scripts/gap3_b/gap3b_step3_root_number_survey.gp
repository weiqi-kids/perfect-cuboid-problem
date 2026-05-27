\\ ====================================================================
\\ Gap 3 — Step 3: Root number survey and rank-jump fiber structure
\\ ====================================================================

default(parisize, 500000000);
default(realprecision, 20);

\\ Wrap entire script in ONE brace, since PARI doesn't allow nesting

go() = {
  my(fibers_all, m, n, u, v, g, f, q, E, Emin, w, ran_data, r_an, parity);
  my(nw_plus, nw_minus, nr0, nr1, nr2, nr3, parity_OK, parity_FAIL);
  my(rank_jump_list, Ncond);
  my(mm, nn, count_p, count_m);

  print("================================================================");
  print("Gap 3 / Step 3: Root number w(E_PCP(q)) and parity-forced");
  print("                rank-jump for Pythagorean q's");
  print("================================================================");
  print();

  fibers_all = List();
  for(m = 2, 25,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        u = m^2 - n^2;
        v = 2*m*n;
        g = gcd(u, v);
        u = u/g; v = v/g;
        listput(fibers_all, [m, n, u, v]);
      );
    );
  );

  print("Total Pythagorean (m,n) with 2 <= m <= 25, gcd=1, m+n odd: ", #fibers_all);
  print();

  nw_plus = 0; nw_minus = 0;
  nr0 = 0; nr1 = 0; nr2 = 0; nr3 = 0;
  parity_OK = 0; parity_FAIL = 0;
  rank_jump_list = List();

  \\ Precompute (m, n, u, v, w, r_an) for each fiber, store
  \\ in a single vector data_all
  data_all = vector(#fibers_all);

  for(i = 1, #fibers_all,
    f = fibers_all[i];
    m = f[1]; n = f[2]; u = f[3]; v = f[4];
    q = u/v;
    E = ellinit([0, 1+q^2, 0, q^2, 0]);
    Emin = ellminimalmodel(E);
    w = ellrootno(Emin);
    ran_data = ellanalyticrank(Emin, 0.001);
    r_an = ran_data[1];

    if(w == 1, nw_plus = nw_plus + 1, nw_minus = nw_minus + 1);
    if(r_an == 0, nr0 = nr0 + 1);
    if(r_an == 1, nr1 = nr1 + 1);
    if(r_an == 2, nr2 = nr2 + 1);
    if(r_an == 3, nr3 = nr3 + 1);

    parity = if(r_an % 2 == 0, 1, -1);
    if(w == parity, parity_OK = parity_OK + 1, parity_FAIL = parity_FAIL + 1);

    Ncond = ellglobalred(Emin)[1];
    data_all[i] = [m, n, u, v, Ncond, w, r_an];

    if(r_an >= 1,
      listput(rank_jump_list, [m, n, u, v, Ncond, w, r_an]);
    );
  );

  print("Root number distribution:");
  print("  w = +1: ", nw_plus, " (", precision(100.0 * nw_plus / #fibers_all, 4), "%)");
  print("  w = -1: ", nw_minus, " (", precision(100.0 * nw_minus / #fibers_all, 4), "%)");
  print();
  print("Analytic rank distribution:");
  print("  r_an = 0: ", nr0, " (", precision(100.0 * nr0 / #fibers_all, 4), "%)");
  print("  r_an = 1: ", nr1, " (", precision(100.0 * nr1 / #fibers_all, 4), "%)");
  print("  r_an = 2: ", nr2, " (", precision(100.0 * nr2 / #fibers_all, 4), "%)");
  print("  r_an = 3: ", nr3, " (", precision(100.0 * nr3 / #fibers_all, 4), "%)");
  print();
  print("BSD parity check: w == (-1)^{r_an}?");
  print("  OK:   ", parity_OK, " / ", #fibers_all);
  print("  FAIL: ", parity_FAIL);
  print();

  print("================================================================");
  print("Rank-jump fibers (r_an >= 1) in this survey:");
  print("================================================================");
  print();
  print("(m,n) | q=u/v | N(E) | w | r_an");
  print("------+--------+------+---+-----");
  for(i = 1, #rank_jump_list,
    rj = rank_jump_list[i];
    print("(", rj[1], ",", rj[2], ") | ", rj[3], "/", rj[4],
          " | ", rj[5], " | ", rj[6], " | ", rj[7]);
  );
  print();
  print("Total rank-jump fibers in m <= 25 survey: ", #rank_jump_list);
  print("Rank-jump density (analytic rank, m<=25): ",
        precision(100.0 * #rank_jump_list / #fibers_all, 4), "%");
  print();

  \\ How many with w=-1 (forced odd analytic rank, hence >= 1)?
  forced_odd = 0;
  for(i = 1, #data_all,
    if(data_all[i][6] == -1, forced_odd = forced_odd + 1);
  );
  print("Number of fibers with w = -1 (parity-forced odd rank >= 1): ", forced_odd);
  print("Density of forced odd-rank: ", precision(100.0 * forced_odd / #fibers_all, 4), "%");
  print();

  \\ Tabulate by (m mod 4, n mod 4)
  print("================================================================");
  print("Structural patterns in w(E) vs (m, n) mod 4 / 8");
  print("================================================================");
  print();
  print("Distribution of w by (m mod 4, n mod 4):");
  for(mm = 0, 3,
    for(nn = 0, 3,
      if((mm + nn) % 2 == 1,
        count_p = 0; count_m = 0;
        for(i = 1, #data_all,
          f = data_all[i];
          if(f[1] % 4 == mm && f[2] % 4 == nn,
            if(f[6] == 1, count_p = count_p + 1, count_m = count_m + 1);
          );
        );
        if(count_p + count_m > 0,
          print("  (m mod 4, n mod 4) = (", mm, ",", nn, "): w=+1: ", count_p,
                "  w=-1: ", count_m);
        );
      );
    );
  );

  print();
  print("Distribution of w by (m mod 8):");
  for(mm = 0, 7,
    count_p = 0; count_m = 0;
    for(i = 1, #data_all,
      f = data_all[i];
      if(f[1] % 8 == mm,
        if(f[6] == 1, count_p = count_p + 1, count_m = count_m + 1);
      );
    );
    if(count_p + count_m > 0,
      print("  m mod 8 = ", mm, ": w=+1: ", count_p, "  w=-1: ", count_m);
    );
  );

  print();
  print("Distribution of w by m parity and n parity:");
  for(mm = 0, 1,
    for(nn = 0, 1,
      count_p = 0; count_m = 0;
      for(i = 1, #data_all,
        f = data_all[i];
        if(f[1] % 2 == mm && f[2] % 2 == nn,
          if(f[6] == 1, count_p = count_p + 1, count_m = count_m + 1);
        );
      );
      if(count_p + count_m > 0,
        print("  (m mod 2, n mod 2) = (", mm, ",", nn, "): w=+1: ", count_p,
              "  w=-1: ", count_m);
      );
    );
  );

  print();
  print("=== End Step 3 ===");
};

go();

quit;

\\ Sharpen rk(E_Hm) for (73,24): try ellrank with effort 5, 6, 7, 8 directly + analytic rank.

default(parisize, 1500000000);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);
print("E_Hm of (73,24):");
print("  conductor = ", ellglobalred(E)[1]);
print();

print("=== Step 1: ellrank effort 5/6/7/8 directly on E_Hm ===");

{
  for(effort = 5, 8,
    print();
    print("  --- ellrank effort ", effort, " (30-min timeout) ---");
    t0 = getwalltime();
    res = 0;
    iferr(
      alarm(1800, res = ellrank(E, effort)),
      err, print("    ERROR: ", err));
    t1 = getwalltime();
    if(res != 0 && type(res) == "t_VEC",
      print("    rank [", res[1], ", ", res[2], "]  n_gens = ", #res[4], "  wall = ", (t1-t0)/1000.0, "s");
      for(g = 1, #res[4],
        gen_g = res[4][g];
        h = ellheight(E, gen_g);
        print("      gen[", g, "] = ", gen_g);
        print("        canonical height = ", h);
      );
      if(#res[4] >= 2,
        \\ Check independence
        print();
        print("    !!! TWO+ INDEPENDENT GENS !!!  rk(E_Hm) >= 2");
        print("    !!! With parity ODD and rk_hi=3, rk = 3 RIGOROUSLY !!!");
        return(0);
      );
      ,
      print("    no result, wall = ", (t1-t0)/1000.0, "s");
    );
  );
}

print();
print("=== Step 2: ellrank with high search bound (alternative effort interpretation) ===");

{
  print("  ellsearch on E using ellrootno+ellanalyticrank shortcut:");
  iferr(
    alarm(600,
      \\ ellanalyticrank with reasonable precision
      print("  Trying ellanalyticrank(E, 0.1):");
      t0 = getwalltime();
      AR = ellanalyticrank(E, 0.1);
      t1 = getwalltime();
      print("    result: ", AR);
      print("    wall: ", (t1-t0)/1000.0, "s");
      if(type(AR) == "t_VEC",
        if(AR[1] == 1, print("  ==> analytic rank = 1; combined with rk_lo=1, rk = 1 CONFIRMED"));
        if(AR[1] == 3, print("  ==> analytic rank = 3; rk(E_Hm) = 3 CONFIRMED"));
      );
    ),
    err, print("  ellanalyticrank ERROR / TIMEOUT: ", err);
  );
}

print();
print("=== Step 3: ellL1 attempt ===");

{
  iferr(
    alarm(900,
      print("  Trying ellL1(E, 1):");
      t0 = getwalltime();
      L1 = ellL1(E, 1);
      t1 = getwalltime();
      print("    L(E, 1) = ", L1, "   wall: ", (t1-t0)/1000.0, "s");
      print("  Trying ellL1(E, 2):");
      L2 = ellL1(E, 2);
      print("    L'(E, 1) = ", L2);
      print("  Trying ellL1(E, 3):");
      L3 = ellL1(E, 3);
      print("    L''(E, 1) = ", L3);
      \\ Order of vanishing
      if(abs(L1) > 1e-5, ro = 0,
        if(abs(L2) > 1e-5, ro = 1,
          if(abs(L3) > 1e-5, ro = 2, ro = ">=3")));
      print("  Apparent analytic rank: ", ro);
    ),
    err, print("  ellL1 ERROR / TIMEOUT: ", err);
  );
}

quit;

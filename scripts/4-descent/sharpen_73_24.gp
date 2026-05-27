\\ Sharpen rk(E_Hm) for (73,24) from {1, 3} to exact value.

default(parisize, 1500000000);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);
print("E_Hm of (73,24):");
print("  minimal model = ", E[1..5]);
print("  conductor N = ", ellglobalred(E)[1]);
print("  disc factored = ", factor(abs(E.disc)));
print();

print("=== Step 1: 2-isogeny class ===");
ISO = ellisomat(E, 2);
NCURV = #ISO[1];
print("Number of curves in 2-isogeny class: ", NCURV);

{
  for(k = 1, NCURV,
    Ek = ellinit(ISO[1][k]);
    print();
    print("  iso[", k, "]: ", Ek[1..5]);
    print("    log|disc| = ", log(abs(Ek.disc)*1.0));
  );
}

print();
print("=== Step 2: ellrank effort 5 on each isogenous curve (15-min timeout each) ===");

GENS_FOUND = vector(NCURV);

{
  for(k = 1, NCURV,
    print();
    print("  --- iso[", k, "] ellrank effort 5 ---");
    Ek = ellinit(ISO[1][k]);
    res = 0;
    iferr(
      alarm(900, res = ellrank(Ek, 5)),
      err, print("    ERROR / TIMEOUT: ", err));
    if(res != 0 && type(res) == "t_VEC",
      print("    rank in [", res[1], ", ", res[2], "]");
      print("    n_gens found = ", #res[4]);
      GENS_FOUND[k] = res[4];
      for(g = 1, min(#res[4], 5),
        print("      gen[", g, "] = ", res[4][g]);
      );
      if(#res[4] >= 2,
        print();
        print("    !!! TWO INDEPENDENT GENERATORS ON iso[", k, "] !!!");
        print("    !!! rk(E_Hm) >= 2; combined with parity ODD and rk_hi=3, rk = 3 RIGOROUSLY !!!");
      );
      ,
      print("    (no result returned)");
    );
  );
}

print();
print("=== Step 3: ellanalyticrank attempt (N = 1.8·10^16) ===");

{
  iferr(
    alarm(900,
      print("  Trying ellanalyticrank(E, 0.05) ...");
      t0 = getwalltime();
      AR = ellanalyticrank(E, 0.05);
      t1 = getwalltime();
      print("    result: ", AR);
      print("    wall: ", (t1-t0)/1000.0, " s");
    ),
    err, print("  TIMEOUT or ERROR: ", err);
  );
}

print();
print("=== Summary ===");
{
  best_count = 0;
  for(k = 1, NCURV,
    g = GENS_FOUND[k];
    if(type(g) == "t_VEC" || type(g) == "t_LIST",
      n = #g;
      best_count = max(best_count, n);
    );
  );
  print("  Best generator count across 2-isogeny class: ", best_count);
  if(best_count >= 2,
    print("  ==> rk(E_Hm) >= 2; with parity ODD and ellrank rk_hi = 3, rk = 3 RIGOROUSLY ✓"),
    print("  ==> rk(E_Hm) still in {1, 3}; need 4-descent or Magma");
  );
}

quit;

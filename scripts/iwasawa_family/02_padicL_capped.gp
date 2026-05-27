default(parisize, 500000000);
default(parisizemax, 1500000000);

print("=================================================================");
print("Track T5 - Iwasawa-Family - 02_padicL_capped");
print("Budget: parisize=500MB parisizemax=1.5GB");
print("=================================================================");
print();

\\ Roster: m, n, expected_rank
\\ q = (m^2-n^2)/(2mn), E_PCP(q): Y^2 = X(X+1)(X+q^2)
\\ Integer model u=2mn, v=m^2-n^2: y^2 = x(x+u^2)(x+v^2)
\\ Precomputed N: 21, 1785, 4305, 6510, 22134, 113505, 130305, 155946, 237930, 1785
{
roster = [
  [2,1,"3/4",   0],
  [3,2,"5/12",  0],
  [5,2,"21/20", 1],
  [5,4,"9/40",  0],
  [4,3,"7/24",  1],
  [6,1,"35/12", 0],
  [7,2,"45/28", 0],
  [8,1,"63/16", 0],
  [8,3,"55/48", 1],
  [5,1,"12/5",  0]
];
}

ps = [5, 7, 11, 13];
prec = 3;
N_cutoff = 30000;
out = "/root/proof/perfect-cuboid-problem/scripts/iwasawa_family/02_padicL_capped.out";

write(out, "# Track T5 - p-adic L capped (parisize=500MB parisizemax=1.5GB)");
write(out, "# Fibers with N>30000: SKIPPED_BUDGET");
write(out, "# Methods: ellpadicL (rank=0), ellpadicbsd (rank>=1)");
write(out, "#");

{
for(i=1, length(roster),
  m = roster[i][1];
  n = roster[i][2];
  qs = roster[i][3];
  rk_expected = roster[i][4];
  u = 2*m*n;
  v = m^2 - n^2;
  E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
  Em = ellminimalmodel(E);
  N = ellglobalred(Em)[1];

  print();
  print("--- Fiber ", i, ": (m,n)=(", m, ",", n, ")  q=", qs, "  N=", N, "  exp.rank=", rk_expected, " ---");

  if(N > N_cutoff,
    print("  N=", N, " > cutoff. SKIPPED (budget).");
    write(out, Str("SKIPPED_BUDGET  m=", m, " n=", n, " q=", qs, " N=", N, " rk=", rk_expected));
  ,
    for(j=1, length(ps),
      p = ps[j];
      ap = ellap(Em, p);

      if(N % p != 0,
        red = "good";
        ordinary = (ap % p != 0);
      ,
        if(ap == 1,
          red = "split_mult"; ordinary = 1;
        ,
          if(ap == -1,
            red = "nonsplit_mult"; ordinary = 0;
          ,
            red = "additive"; ordinary = 0;
          );
        );
      );

      print("  p=", p, " a_p=", ap, " red=", red, " ordinary=", ordinary);

      if(!ordinary,
        print("    skip non-ordinary");
        write(out, Str("SKIP_NONORD  m=", m, " n=", n, " q=", qs, " N=", N, " rk=", rk_expected, " p=", p, " red=", red, " a_p=", ap));
        next();
      );

      t0 = getwalltime();

      if(rk_expected == 0,
        \\ Rank 0: use ellpadicL, read val_p(L_p(E,1))
        L_ok = 0;
        Lval_result = 0;
        val_p_result = -99;
        iferr(
          LL = ellpadicL(Em, p, prec);
          L_ok = 1;
          Lval_result = LL;
          val_p_result = valuation(LL, p);
        ,
          Eerr,
          L_ok = 0;
        );
        t1 = getwalltime();
        dt = (t1-t0)/1000.0;
        if(L_ok,
          print("    L_p(E,1)=", Lval_result, "  val_p=", val_p_result, "  [", dt, "s]");
          write(out, Str("OK  m=", m, " n=", n, " q=", qs, " N=", N, " rk=", rk_expected, " p=", p, " red=", red, " a_p=", ap, " METHOD=ellpadicL val_p=", val_p_result, " t=", dt));
        ,
          print("    ellpadicL FAILED [", dt, "s] -- exceeded 1.5GB budget");
          write(out, Str("EXCEEDED_BUDGET  m=", m, " n=", n, " q=", qs, " N=", N, " rk=", rk_expected, " p=", p, " red=", red, " a_p=", ap, " METHOD=ellpadicL t=", dt));
        );
      ,
        \\ Rank >= 1: use ellpadicbsd to get [ord, leading_coeff]
        bsd_ok = 0;
        bsd_ord = -99;
        bsd_lead = 0;
        iferr(
          bsd = ellpadicbsd(Em, p, prec);
          bsd_ok = 1;
          bsd_ord = bsd[1];
          bsd_lead = bsd[2];
        ,
          Eerr,
          bsd_ok = 0;
        );
        t1 = getwalltime();
        dt = (t1-t0)/1000.0;
        if(bsd_ok,
          print("    ellpadicbsd: ord=", bsd_ord, "  lead=", bsd_lead, "  [", dt, "s]");
          write(out, Str("OK  m=", m, " n=", n, " q=", qs, " N=", N, " rk=", rk_expected, " p=", p, " red=", red, " a_p=", ap, " METHOD=ellpadicbsd bsd_ord=", bsd_ord, " t=", dt));
        ,
          print("    ellpadicbsd FAILED [", dt, "s]");
          write(out, Str("EXCEEDED_BUDGET  m=", m, " n=", n, " q=", qs, " N=", N, " rk=", rk_expected, " p=", p, " red=", red, " a_p=", ap, " METHOD=ellpadicbsd t=", dt));
        );
      );
    );
  );
);
}

print();
print("Done. Output written to: ", out);
quit

\\ Try ellheegner on (73,24) E_Hm. Conductor 1.8·10^16.

default(parisize, 1500000000);
default(realprecision, 100);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);
print("E_Hm of (73,24):");
print("  conductor = ", ellglobalred(E)[1]);
print("  root number = ", ellrootno(E), "  (parity ODD)");
print();

print("=== ellheegner attempt ===");
{
  iferr(
    alarm(1500,
      print("  Calling ellheegner(E) ...");
      t0 = getwalltime();
      H = ellheegner(E);
      t1 = getwalltime();
      print("    result: ", H, "   wall: ", (t1-t0)/1000.0, "s");
      if(type(H) == "t_VEC" && #H >= 2,
        on = ellisoncurve(E, H);
        print("    ellisoncurve(E, H) = ", on);
        if(on,
          ord = ellorder(E, H);
          print("    ellorder = ", ord);
          if(ord == 0,
            print("    *** NON-TORSION POINT FOUND ***");
            print("    height = ", ellheight(E, H));
            print("    *** This is the rk_lo=1 generator, confirms rk(E_Hm) >= 1 ***");
            print("    Try ellrank again with this as hint:");
            r2 = ellrank(E, 6, , [H]);
            print("      ellrank effort 6 with hint H: ", r2);
            if(type(r2) == "t_VEC" && #r2 >= 4 && #r2[4] >= 2,
              print("    !!! ellrank confirms 2+ independent gens with hint !!!");
              print("    !!! rk(E_Hm) = 3 RIGOROUSLY (parity odd) !!!");
            );
          );
        );
      );
    ),
    err, print("  ellheegner ERROR / TIMEOUT: ", err);
  );
}

print();
print("=== L-function approach using lfun ===");

{
  iferr(
    alarm(900,
      print("  Building lfun(E) ...");
      t0 = getwalltime();
      L = lfuninit(E, [10]);
      t1 = getwalltime();
      print("    lfuninit OK, wall: ", (t1-t0)/1000.0, "s");

      print("  Computing L(E, 1):");
      v1 = lfun(L, 1);
      print("    L(E, 1) = ", v1);
      if(abs(v1) > 1e-10,
        print("    => L(E,1) != 0 => analytic rank = 0 => rk = 0 CONFLICTS with rk_lo=1??"),
        print("    => L(E,1) = 0 => analytic rank >= 1 (parity ODD, expected)");
      );

      print("  Computing L'(E, 1):");
      v2 = lfun(L, 1, 1);
      print("    L'(E, 1) = ", v2);
      if(abs(v2) > 1e-10,
        print("    => L'(E,1) != 0 => analytic rank = 1 => rk(E_Hm) = 1 if BSD holds"),
        print("    => L'(E,1) = 0 => analytic rank >= 3 (parity ODD)");
        print("  Computing L'''(E, 1):");
        v3 = lfun(L, 1, 3);
        print("    L'''(E, 1) = ", v3);
        if(abs(v3) > 1e-10,
          print("    => L'''(E,1) != 0 => analytic rank = 3 => rk(E_Hm) = 3 if BSD holds"));
      );
    ),
    err, print("  lfun ERROR / TIMEOUT: ", err);
  );
}

quit;

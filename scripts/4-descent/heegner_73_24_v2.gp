\\ ellheegner attempt on (73,24) E_Hm — focused, no fancy hints.

default(parisize, 2000000000);
default(realprecision, 100);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);
print("E_Hm of (73,24):");
print("  conductor = ", ellglobalred(E)[1]);
print("  root number = ", ellrootno(E));
print();

print("=== ellheegner attempt (25-min timeout) ===");
{
  iferr(
    alarm(1500,
      print("  ellheegner(E):");
      t0 = getwalltime();
      H = ellheegner(E);
      t1 = getwalltime();
      print("    result: ", H);
      print("    wall: ", (t1-t0)/1000.0, "s");
      if(type(H) == "t_VEC" && #H >= 2,
        on = ellisoncurve(E, H);
        print("    ellisoncurve(E, H) = ", on);
        if(on,
          ord = ellorder(E, H);
          print("    ellorder = ", ord);
          if(ord == 0,
            h = ellheight(E, H);
            print("    canonical height = ", h);
            print("    *** NON-TORSION GENERATOR FOUND VIA HEEGNER ***");
          );
        );
      );
    ),
    err, print("  ERROR / TIMEOUT: ", err)
  );
}

quit;

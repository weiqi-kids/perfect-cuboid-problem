\\ ellheegner with parisizemax to allow dynamic stack growth.

default(parisize, 800000000);     \\ Start at 800MB
default(parisizemax, 5000000000); \\ Grow up to 5GB (will swap but try)
default(realprecision, 100);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);
print("E_Hm of (73,24):");
print("  conductor = ", ellglobalred(E)[1]);
print();

print("=== ellheegner with dynamic stack growth ===");
{
  iferr(
    alarm(2700,
      t0 = getwalltime();
      H = ellheegner(E);
      t1 = getwalltime();
      print("  result: ", H);
      print("  wall: ", (t1-t0)/1000.0, "s");
      if(type(H) == "t_VEC" && #H >= 2,
        print("  ellisoncurve = ", ellisoncurve(E, H));
        print("  ellorder = ", ellorder(E, H));
        if(ellorder(E, H) == 0,
          print("  *** NON-TORSION GENERATOR ***");
          print("  height = ", ellheight(E, H));
        );
      );
    ),
    err, print("  ERROR: ", err)
  );
}

quit;

default(parisize,800000000);
default(parisizemax,1200000000);

{
  print("=== Rational points on C': T^2 = t^8+68t^6-122t^4+68t^2+1 ===");
  f = t^8 + 68*t^6 - 122*t^4 + 68*t^2 + 1;
  print("f = ", f);
  print("disc factor: bad primes {2,5}");
  print("");
  \\ enumerate via hyperellratpoints if available
  iferr(
    my(pts = hyperellratpoints(f, 1000));
    print("hyperellratpoints(f, height bound 1000):");
    print("  number of affine points found = ", length(pts));
    for(i=1, length(pts), print("   ", pts[i]));
  , e, print("hyperellratpoints error/unavailable: ", e));
  print("");
  \\ Brute force small rational t = num/den, check f(t) square
  print("=== Brute force t=n/d, |n|<=60, 1<=d<=60, gcd=1: f(t) a square? ===");
  my(found = List());
  for(d=1, 60,
    for(n=-60, 60,
      if(gcd(n,d)==1,
        my(val = (n^8 + 68*n^6*d^2 - 122*n^4*d^4 + 68*n^2*d^6 + d^8));  \\ = f(n/d)*d^8
        if(val >= 0 && issquare(val),
          my(Tn = sqrtint(val));   \\ T = Tn / d^4
          listput(found, [n, d, Tn]);
        );
      );
    );
  );
  print("affine rational points (t=n/d, T=+-Tnum/d^4):");
  for(i=1, length(found), print("   t=",found[i][1],"/",found[i][2], "  T=+-",found[i][3],"/",found[i][2],"^4"));
  print("plus 2 points at infinity (leading coeff 1 = square).");
}

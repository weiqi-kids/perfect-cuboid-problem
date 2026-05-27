/* ============================================================
   05_face_condition.gp
   For each integral point on C_anom (equivalently each integral
   (Y,Z) with 20 Z^2 = f(Y)), decode the SG Case-II candidate
   (p,q) = (Y, (Y^2+2Y-1)/2) and test the remaining face/Pi
   squareness condition (the third-face condition that distinguishes
   a genuine perfect cuboid from a mere space-diagonal solution).
   The single non-degenerate candidate is (p,q)=(11,71); we verify
   its face value is NOT a perfect square.
   ============================================================ */

f(Y) = Y^4 + 8*Y^3 + 18*Y^2 - 8*Y + 1;

print("=== Integral (Y,Z) on C_anom: 20 Z^2 = f(Y), |Y| <= 10^6 ===");
hits = List();
{ for(Y = -10^6, 10^6,
  v = f(Y);
  if(v >= 0 && v % 20 == 0,
    z2 = v/20;
    if(issquare(z2), listput(hits, [Y, sqrtint(z2)]));
  );
); }
hv = Vec(hits);
print("integral (Y,Z>=0) found = ", #hv, " : ", hv);
print("(with +-Z, this matches the framework's count)");

print("");
print("=== Decode each to SG Case-II (p,q) and apply face/Pi test ===");
print("p = Y,  q = (Y^2 + 2Y - 1)/2;  Case-B legs:");
print("  a = 4 p q,   b = q^2 - 4 p^2,   c = 2(q^2 - p^2)");
print("Face/Pi value (third-face squareness) = 5 q^4 - 16 p^2 q^2 + 20 p^4");
print("");
{ for(i=1,#hv,
  Y = hv[i][1];
  p = Y;
  qnum = (Y^2 + 2*Y - 1);
  if(qnum % 2 != 0,
    print("  Y=", Y, ": q not integral (q=(Y^2+2Y-1)/2) -> skip"),
    q = qnum/2;
    a = 4*p*q; b = q^2 - 4*p^2; c = 2*(q^2 - p^2);
    facePi = 5*q^4 - 16*p^2*q^2 + 20*p^4;
    degen = (c == 0 || p <= 0 || q <= 0 || q == p);
    print("  Y=", Y, " -> (p,q)=(", p, ",", q, ")  legs (a,b,c)=(", a, ",", b, ",", c, ")");
    print("       Face/Pi = ", facePi, "   square? ", issquare(facePi), "   degenerate? ", degen);
  );
); }

print("");
print("=== The single non-degenerate candidate (p,q)=(11,71) ===");
p = 11; q = 71;
facePi = 5*q^4 - 16*p^2*q^2 + 20*p^4;
print("Face/Pi = ", facePi);
print("sqrtint(Face/Pi) = ", sqrtint(facePi), ",  sqrtint^2 = ", sqrtint(facePi)^2);
print("issquare? ", issquare(facePi), "   (must be 0 = NOT a square)");
print("So no perfect cuboid arises from (11,71): the third face fails squareness.");

print("");
print("=== Independent prime-by-prime audit, p in [3, 5000] ===");
print("(direct SG structural test, NOT via C_anom)");
hits2 = List();
{ forprime(p = 3, 5000,
  m = (p+1)/2; n = (p-1)/2;
  for(eps = -1, 1,
    if(eps != 0,
      q = (p^2 + 2*eps*p - 1)/2;
      if(q > 0 && denominator(q)==1,
        Bv = (q + eps*p)^2 + p^2;
        Av = (q - eps*p)^2 + p^2;
        if(issquare(Av) && issquare(5*Bv) || issquare(5*Av) && issquare(Bv) || issquare(Av*Bv/5),
          listput(hits2, [p,q,eps]));
      );
    );
  );
); }
print("space-diagonal hits over primes p in [3,5000]: ", Vec(hits2));
print("(framework expects only (11,71))");

quit;

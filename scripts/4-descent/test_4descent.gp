\\ Test framework: validate quartic point search on small curves with known rank
\\ via PARI's ell2cover.

default(parisize, 1500000000);
default(realprecision, 38);

\\ Search rational points (x, y) on quartic y^2 = q(x) where q is degree 4
\\ Search x = a/b with |a|, |b| <= H.
{
search_quartic(q, H) = my(hits = List(), a, b, x_val, val, y_sq, y, denom, num);
  for(b = 1, H,
    for(a = -H*b, H*b,
      if(gcd(a, b) != 1, next);
      \\ q(a/b) * b^(deg q) = polynomial in a, b
      \\ specifically y^2 = q(a/b) means (y * b^2)^2 = b^4 * q(a/b) for deg 4
      val = subst(q, x, a/b);
      \\ scale: (y b^2)^2 = b^4 q(a/b) which is integer
      num = numerator(val);
      denom = denominator(val);
      if(denom == 1,
         \\ val is integer; check if it's a square
         if(val >= 0 && issquare(val, &y),
           listput(hits, [a, b, y]);
           print("    [search_quartic HIT] x = ", a, "/", b, ", y = +-", y, ", q(x) = ", val);
         );
      ,
         \\ val = num/denom, want num*denom is a square? (y * sqrt(denom))^2 = num * denom
         \\ Actually: q(x) = num/denom; for y to be rational, denom must be a square times something matching.
         \\ Better: scale x = a/b directly: let X = a, Z = b. Then if q has leading coeff c_4:
         \\   Y^2 = b^4 * q(a/b) = c_4 a^4 + c_3 a^3 b + c_2 a^2 b^2 + c_1 a b^3 + c_0 b^4
         \\   Y = y * b^2  rational  iff (b^4 * q(a/b)) is an integer square.
         \\ Hmm but val = q(a/b) = num/denom with denom dividing b^(deg q) at worst.
         \\ Actually since coeffs of q are integer, q(a/b) = (integer) / b^4 = num/b^4 with num integer.
         \\ But PARI might reduce. Let's force:
         scaled = b^poldegree(q) * val;
         if(type(scaled) == "t_INT" && scaled >= 0 && issquare(scaled, &y),
           listput(hits, [a, b, y]);
           print("    [search_quartic HIT] x = ", a, "/", b, ", y = +-", y, ", b^4*q(a/b) = ", scaled);
         );
      );
    );
  );
  hits;
}

{ test_curve(label, ainvs, expected_rank) = my(E, T, r, covers, k, q, hits);
  print();
  print("=== ", label, " ===");
  E = ellinit(ainvs);
  print("E [a1..a6] = ", E[1..5]);
  T = elltors(E);
  print("Torsion: order=", T[1], " struct=", T[2]);
  r = ellrank(E, 4);
  print("ellrank(E, 4) = ", r);
  print("Expected rank: ", expected_rank);
  covers = ell2cover(E);
  print("Number of non-trivial 2-Selmer classes (mod E[2]): ", #covers);
  if(#covers > 0,
    for(k = 1, #covers,
      print("  --- Cover #", k, " ---");
      q = covers[k][1];
      print("    q(x) = ", q);
      print("    deg = ", poldegree(q), ", lead coeff = ", polcoeff(q, poldegree(q)));
      print("    searching x = a/b with |a|, b <= 50 ...");
      hits = search_quartic(q, 50);
      print("    hits found: ", #hits);
    );
  );
}

test_curve("Test 1: y^2 = x(x-1)(x-2), rk=0", [0,-3,0,2,0], 0);
test_curve("Test 2: y^2 = x(x-1)(x+1), rk=0", [0,0,0,-1,0], 0);
test_curve("Test 3: y^2 = x(x-4)(x+1)", [0,-3,0,-4,0], "?");
test_curve("Test 4: y^2 = x(x-7)(x+7), rk=1", [0,0,0,-49,0], 1);
test_curve("Test 5: y^2 = x^3 - x - 1, rk=1", [0,0,0,-1,-1], 1);

print();
print("=== Summary ===");
print("If ellrank reports rk = k and we find k generators via cover point-search,");
print("then framework matches PARI.");

quit;

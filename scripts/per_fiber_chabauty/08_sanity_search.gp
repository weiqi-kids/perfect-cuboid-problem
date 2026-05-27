\\ 08_sanity_search.gp — Direct search to sanity-check the closure on (205, 66).

default(parisize, 2*10^9);
default(realprecision, 38);

\\ For (m, n) = (205, 66): a = 37669, b = 27060, d = 46381, q = b/a.
\\ Direct rational search over c = c_num/c_den with bounded heights.
\\ Conditions (after clearing denominators):
\\   F1: a^2 c_num^2 + b^2 c_den^2 = square
\\   F2: c_num^2 + c_den^2 = square (Pythag at face 2)
\\   F3: a^2 c_num^2 + d^2 c_den^2 = square
\\ Non-degenerate requires c_num ≠ 0.

test_one(m, n, bound) = {
  my(a = m^2-n^2, b = 2*m*n, d = m^2+n^2);
  print("=== (", m, ",", n, ") a=", a, ", b=", b, ", d=", d, ", height bound = ", bound, " ===");
  my(found = 0);
  for(c_den = 1, bound,
    for(c_num = 1, bound,
      if(gcd(c_num, c_den) > 1, next);
      if(!issquare(c_num^2 + c_den^2), next);
      if(!issquare(a^2 * c_num^2 + b^2 * c_den^2), next);
      if(!issquare(a^2 * c_num^2 + d^2 * c_den^2), next);
      found = found + 1;
      print("  CANDIDATE c = ", c_num, "/", c_den);
    );
  );
  print("  Non-degenerate (c > 0) candidates found: ", found);
  found
};

print();
n1 = test_one(205, 66, 60);
print("(205,66) sanity:", n1, " non-degenerate candidates at height ≤ 60");
print();
n2 = test_one(8, 3, 60);
print("(8,3) sanity:", n2, " non-degenerate candidates at height ≤ 60");
print();
n3 = test_one(988, 321, 30);
print("(988,321) sanity:", n3, " non-degenerate candidates at height ≤ 30");
quit;

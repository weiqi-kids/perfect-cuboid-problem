\\ Tabulate arithmetic invariants of (m,n) for known rank-3 and rank-4 fibers.
\\ Goal: find common arithmetic conditions.
default(parisize, 800000000);

\\ Known rank-3 fibers (verified ellrank=[3,3])
rank3 = [[22,17], [35,22], [37,26], [40,29], [40,33], [161,48], [173,16], [197,20]];
\\ Known rank-4 fibers (verified ellrank=[4,4])
rank4 = [[99,28], [118,25], [174,83], [176,63], [181,38], [205,66], [209,72], [216,185], [221,202], [261,52], [273,86]];

print("=== TABLE 1: arithmetic invariants for rank-3 fibers ===");
print("(m,n) | m | n | m+n | m-n | mn | m^2+n^2 | m^2-n^2 | (m-n)^2-2n^2");

tabulate(L, label) = {
  print("=== ", label, " ===");
  for(i = 1, #L,
    my(m = L[i][1], n = L[i][2]);
    my(a = m^2 - n^2, b = 2*m*n);
    my(u = m^2 - 2*m*n - n^2, v = m^2 + 2*m*n - n^2);
    my(h = m^2 + n^2);   \\ hypotenuse
    my(Q = (m-n)^2 - 2*n^2);  \\ Heron-3-face indicator
    print("(", m, ",", n, "):");
    print("  m=", factor(m), "  n=", factor(n));
    print("  m+n=", m+n, " = ", factor(m+n), "  m-n=", m-n, " = ", factor(m-n));
    print("  m*n=", m*n, " = ", factor(m*n));
    print("  a=m^2-n^2=", a, " = ", factor(a));
    print("  b=2mn=", b, " = ", factor(b));
    print("  h=m^2+n^2=", h, " = ", factor(h));
    print("  u=m^2-2mn-n^2=", u, " = ", factor(u));
    print("  v=m^2+2mn-n^2=", v, " = ", factor(v));
    print("  Q=(m-n)^2-2n^2=", Q, " = ", factor(Q));
    print("  m mod 8 = ", m % 8, "  n mod 8 = ", n % 8, "  m+n mod 8 = ", (m+n) % 8);
    print("  m mod 12 = ", m % 12, "  n mod 12 = ", n % 12);
    print("  m mod 24 = ", m % 24, "  n mod 24 = ", n % 24);
  );
};

tabulate(rank3, "RANK 3");
print();
tabulate(rank4, "RANK 4");
print();

\\ Look at "rank-2 control" fibers to check non-uniqueness of any pattern
rank2_examples = [[3,2], [5,2], [7,2], [8,3], [9,4], [11,2], [13,4]];
tabulate(rank2_examples, "RANK 2 (sample - for contrast)");

quit();

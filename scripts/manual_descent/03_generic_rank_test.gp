\\ 03_generic_rank_test.gp — Verify generic rank E_PCP/Q(q) = 0

default(parisize, 1000000000);

print("=== Verifying generic rank E_PCP/Q(q) = 0 ===");
print();

\\ Search for non-torsion sections X(q) in Q[q] of low degree.
\\ A section (X(q), Y(q)) satisfies Y(q)^2 = X(q)(X(q)+1)(X(q)+q^2).
\\ Torsion sections: X = 0 (Y=0), X = -1 (Y=0), X = -q^2 (Y=0), and
\\                   X = +q (Y = ±q(q+1)), X = -q (Y = ±q(q-1)).
\\ These give the 8 torsion points Z/4 x Z/2.

print("--- Search for sections X(q) = a*q^2 + b*q + c with small (a, b, c) ---");
{
found = List();
for (a = -2, 2,
  for (b = -3, 3,
    for (c = -3, 3,
      \\ Skip known torsion: X = 0, -1, -q^2, ±q
      if ([a, b, c] == [0, 0, 0], next);
      if ([a, b, c] == [0, 0, -1], next);
      if ([a, b, c] == [-1, 0, 0], next);
      if ([a, b, c] == [0, 1, 0], next);
      if ([a, b, c] == [0, -1, 0], next);
      X = a*'q^2 + b*'q + c;
      RHS = X * (X+1) * (X + 'q^2);
      \\ Check if RHS is a perfect square polynomial in 'q.
      if (RHS == 0, next);
      d = poldegree(RHS, 'q);
      if (d % 2 != 0, next);
      \\ Use factor to check
      fac = factor(RHS);
      isSq = 1;
      for (i = 1, matsize(fac)[1],
        if (fac[i, 2] % 2 != 0, isSq = 0; break);
      );
      if (isSq,
        listput(found, [a, b, c, X]);
      );
    );
  );
);
print("Non-trivial sections of degree ≤ 2 found: ", length(found));
for (i = 1, length(found),
  print("  ", found[i]);
);
}

print();
print("--- Try degree ≤ 3 sections X(q) = a*q^3 + b*q^2 + c*q + d ---");
{
found = List();
for (a = -1, 1,
for (b = -2, 2,
for (c = -2, 2,
for (d = -2, 2,
  if ([a, b, c, d] == [0, 0, 0, 0], next);
  X = a*'q^3 + b*'q^2 + c*'q + d;
  RHS = X * (X+1) * (X + 'q^2);
  if (RHS == 0, next);
  deg_r = poldegree(RHS, 'q);
  if (deg_r % 2 != 0, next);
  fac = factor(RHS);
  isSq = 1;
  for (i = 1, matsize(fac)[1],
    if (fac[i, 2] % 2 != 0, isSq = 0; break);
  );
  if (isSq,
    \\ skip known torsion
    if ([a, b, c, d] == [0, 0, 0, 0] || [a, b, c, d] == [0, 0, 0, -1] ||
        [a, b, c, d] == [0, -1, 0, 0] || [a, b, c, d] == [0, 0, 1, 0] ||
        [a, b, c, d] == [0, 0, -1, 0], next);
    listput(found, [a, b, c, d]);
  );
))));
print("Non-trivial sections of degree ≤ 3 found: ", length(found));
for (i = 1, length(found),
  print("  ", found[i]);
);
}

\\ Now: rank of E_PCP at specific integer q values
print();
print("--- ellrank at small integer q values ---");
{
for (qv = 2, 8,
  if (qv == 1, next);
  E = ellinit([0, 1+qv^2, 0, qv^2, 0]);
  R = ellrank(E, 3);
  print("q = ", qv, ": ellrank = [r_low=", R[1], ", r_high=", R[2], "]");
);
}

\\ For q rational Pythagorean, check a few:
print();
print("--- ellrank at small Pythagorean q (m,n primitive) ---");
{
samples = [[3,2], [4,1], [5,2], [5,4], [7,2]];
for (i = 1, length(samples),
  mn = samples[i];
  m = mn[1]; n = mn[2];
  qnum = m^2 - n^2; qden = 2*m*n;
  \\ E: y^2 = x(x+1)(x + q^2) with q = qnum/qden
  \\ Multiply through to clear denominators: substitute x = X*qden^2, y = Y*qden^3
  \\ Get integral model.
  q2num = qnum^2; q2den = qden^2;
  \\ E: Y^2 = X(X + qden^2)(X + qnum^2) after scaling y -> Y*qden^3, x -> X*qden^2
  \\ Check: (X*qden^2)((X*qden^2)+1)(X*qden^2 + qnum^2/qden^2)
  \\        = X*qden^2 * (X*qden^2 + 1) * (X*qden^2 + qnum^2/qden^2)
  \\ Doesn't quite work. Let me just use the rational coefficient form directly.
  q = qnum/qden;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  R = ellrank(E, 3);
  print("(m,n) = ", mn, ", q = ", q, ": ellrank = [r_low=", R[1], ", r_high=", R[2], "]");
);
}

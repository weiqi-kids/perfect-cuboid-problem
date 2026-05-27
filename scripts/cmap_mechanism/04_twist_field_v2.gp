/* Twist test v2: use quadratic twist directly (not elltwist).
   E quadratic-twisted by d: replace (a2,a4,a6) -> (a2*d, a4*d^2, a6*d^3).
   Compute ap of the d-twist for various d, compare to ap of E2.
*/
default(parisize, 1500000000);

{
pairs = [
  [20/21, 48/55],
  [7/24, 20/99],
  [11/60, 39/80],
  [11/60, 17/144],
  [44/117, 11/60],
  [104/153, 195/748],
  [104/153, 55/1512],
  [195/748, 225/272],
  [96/247, 315/572],
  [27/364, 120/209]
];
}

\\ For E: y^2 = x^3 + a2*x^2 + a4*x + a6, d-twist Ed: y^2 = x^3 + a2*d*x^2 + a4*d^2*x + a6*d^3
qtwist(E, d) = ellinit([0, E.a2 * d, 0, E.a4 * d^2, E.a6 * d^3]);

\\ For each pair, scan d in squarefree small range and count ap matches.
twist_test(E1, E2, dlist, maxp) = {
  my(E1min, E2min, N1, N2, best_d = 0, best_score = -1, best_tested = 0);
  E1min = ellminimalmodel(E1);
  E2min = ellminimalmodel(E2);
  N1 = ellglobalred(E1min)[1];
  N2 = ellglobalred(E2min)[1];
  for(j=1, length(dlist),
    my(d = dlist[j], E1d, score = 0, tested = 0);
    E1d = qtwist(E1, d);
    if (E1d.disc == 0, next);
    forprime(p=3, maxp,
      if (N1 % p == 0 || N2 % p == 0 || d % p == 0, next);
      my(ad, a2c);
      ad = ellap(E1d, p);
      a2c = ellap(E2min, p);
      if (ad == a2c, score++);
      tested++;
    );
    if (tested > 0,
      if (score > best_score, best_score = score; best_d = d; best_tested = tested);
    );
  );
  [best_d, best_score, best_tested];
};

{
dlist = [];
\\ squarefree small d (sign + absolute val up to ~50)
for(da = -50, 50,
  if (da == 0, next);
  if (issquarefree(abs(da)),
    dlist = concat(dlist, [da])
  );
);
}

print("=== Twist-isogeny test (find d so that E1^d has ap matching E2) ===");
{
for(i=1, length(pairs),
  my(q1, q2, E1, E2, res);
  q1 = pairs[i][1];
  q2 = pairs[i][2];
  E1 = ellinit([0, 1+q1^2, 0, q1^2, 0]);
  E2 = ellinit([0, 1+q2^2, 0, q2^2, 0]);
  res = twist_test(E1, E2, dlist, 100);
  print("Pair ", i, ": ", q1, " -> ", q2, "   best d=", res[1], " score=", res[2], "/", res[3]);
);
}

\\ Now extend to d in wider range, including d that depend on q1, q2 (e.g. d = ratios of denominators).
\\ Special: try d = (q1^2 - q2^2), (1+q1*q2), (1-q1*q2), (q1*q2), etc.
print("\n=== Special d values from (q1, q2) ===");
{
for(i=1, length(pairs),
  my(q1, q2, E1, E2, candidates);
  q1 = pairs[i][1];
  q2 = pairs[i][2];
  E1 = ellinit([0, 1+q1^2, 0, q1^2, 0]);
  E2 = ellinit([0, 1+q2^2, 0, q2^2, 0]);
  \\ Candidate d values from q1, q2 structure
  candidates = [];
  \\ Note: q1, q2 are rational. We want squarefree integer d.
  \\ d = squarefree part of: (q1^2 - q2^2), 1 - q1*q2, 1 + q1*q2, q1*q2 numerators
  my(diff = q1^2 - q2^2, sum = q1^2 + q2^2, prod = q1*q2);
  my(squarefree_part = (v) -> if (v==0, 1, my(n=abs(numerator(v)), d=denominator(v)); my(sf = core(n)*core(d)); sign(v)*sf));
  candidates = [squarefree_part(diff), squarefree_part(1-prod), squarefree_part(1+prod), squarefree_part(prod), squarefree_part(1-q1^2), squarefree_part(1-q2^2), squarefree_part(sum)];
  \\ Test each
  my(N1, N2);
  N1 = ellglobalred(ellminimalmodel(E1))[1];
  N2 = ellglobalred(ellminimalmodel(E2))[1];
  print("Pair ", i, ": ", q1, " -> ", q2);
  for(k=1, length(candidates),
    my(d = candidates[k], E1d, score = 0, tested = 0);
    if (d == 0, next);
    E1d = qtwist(E1, d);
    if (E1d.disc == 0, next);
    forprime(p=3, 100,
      if (N1 % p == 0 || N2 % p == 0 || d % p == 0, next);
      if (ellap(E1d, p) == ellap(E2, p), score++);
      tested++;
    );
    print("  d=", d, "   matches: ", score, "/", tested);
  );
);
}

quit;

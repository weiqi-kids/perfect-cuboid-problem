/* Determine: for which c-map pairs do the curves become isogenous over a
   quadratic extension Q(sqrt(d))?
   Theorem: Curves E1, E2 over Q are Q(sqrt(d))-isogenous iff their twists
   E1^d and E2 are Q-isogenous, equivalently, j(E1^d) is related to j(E2) by
   a Q-isogeny.

   Practical test: For each pair, find d such that a_p(E1)*chi_d(p) == a_p(E2)
   for many primes p split in Q(sqrt(d)).

   Actually simpler: if E1 and E2 are Q(sqrt(d))-isogenous, the twists
   E1^{(d)} and E2 are Q-isogenous. So we compute the quadratic twist
   of E1 by various d, and check Q-isogeny by ellisomat (or conductor match).
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

\\ j-invariant of E_PCP(q): direct from a1=0, a2=1+q^2, a3=0, a4=q^2, a6=0
\\ Use ellj after we make sure E is valid (delta != 0).

print("=== j-invariants of c-map pairs ===");
{
for(i=1, length(pairs),
  my(q1, q2, E1, E2, j1, j2);
  q1 = pairs[i][1];
  q2 = pairs[i][2];
  E1 = ellinit([0, 1+q1^2, 0, q1^2, 0]);
  E2 = ellinit([0, 1+q2^2, 0, q2^2, 0]);
  j1 = E1.j;
  j2 = E2.j;
  print("Pair ", i, ": q=", q1, " -> ", q2);
  print("  j1=", j1, "  j2=", j2);
);
}

\\ Quadratic-twist test: try discriminants d in a small set (squarefree).
\\ For each pair (E1, E2), we compute twist conductors and ap signatures.

\\ Two curves E1, E2 over Q are isomorphic over Q(sqrt(d)) iff
\\ their j-invariants are equal AND E1 is the d-twist of E2.
\\ Isogenous over Q(sqrt(d)): there exists a Q-isogeny phi : E1^d -> E2.

\\ A simpler version: a_p(E^d) = chi_d(p) * a_p(E) for p odd, p nmid 2*disc(E)*d.
\\ So if E1 and E2 are Q(sqrt(d))-isogenous, then there is an isogeny class C
\\ of E1^d which has same L-series mod good primes as some curve in the isogeny
\\ class of E2.

\\ Direct test: for each squarefree d in small range, check if ap(E1^d) = ap(E2)
\\ for many good p. If so, E1^d and E2 are isogenous over Q (so E1 and E2 are
\\ Q(sqrt(d))-isogenous).

twist_test(E1, E2, dlist) = {
  my(E1min, E2min, N1, N2, best_d = 0, best_score = -1);
  E1min = ellminimalmodel(E1);
  E2min = ellminimalmodel(E2);
  N1 = ellglobalred(E1min)[1];
  N2 = ellglobalred(E2min)[1];
  \\ For each d, count primes p where ap(E1^d) = ap(E2)
  for(j=1, length(dlist),
    my(d = dlist[j], E1d, score = 0, tested = 0);
    \\ E1^d : y^2 = x^3 + a2*d*x^2 + a4*d^2*x + a6*d^3
    \\ But we need ellminimalmodel(quadtwist). Use elltwist? PARI does have it:
    E1d = ellinit(elltwist(E1, d));
    forprime(p=3, 200,
      if (N1 % p == 0 || N2 % p == 0 || d % p == 0, next);
      my(ad, a2c);
      ad = ellap(E1d, p);
      a2c = ellap(E2, p);
      if (ad == a2c, score++);
      tested++;
    );
    if (tested > 0,
      if (score > best_score, best_score = score; best_d = d);
    );
  );
  [best_d, best_score];
};

\\ Build list of candidate d: small squarefree, plus discriminants from j-difference.
{
dlist = [];
\\ small primes
dlist = concat(dlist, [-1, 2, -2, 3, -3, 5, -5, 6, -6, 7, -7, 10, -10, 11, -11, 13, -13, 14, -14, 15, -15, 17, -17, 19, -19, 21, -21, 22, -22, 23, -23, 26, -26, 29, -29, 30, -30, 31, -31, 33, -33, 34, -34, 35, -35, 37, -37, 38, -38, 39, -39, 41, -41, 42, -42]);
}

print("\n=== Twist-isogeny test (d that makes E1^d ~_Q E2) ===");
{
for(i=1, length(pairs),
  my(q1, q2, E1, E2, res);
  q1 = pairs[i][1];
  q2 = pairs[i][2];
  E1 = ellinit([0, 1+q1^2, 0, q1^2, 0]);
  E2 = ellinit([0, 1+q2^2, 0, q2^2, 0]);
  res = twist_test(E1, E2, dlist);
  print("Pair ", i, ": ", q1, " -> ", q2, "   best d=", res[1], " score=", res[2], "/~50");
);
}

\\ Also: are E1 and E2 themselves Q-isogenous (sanity, we expect no)?
print("\n=== Direct Q-isogeny test (ellisomat) ===");
{
for(i=1, length(pairs),
  my(q1, q2, E1, E2, M);
  q1 = pairs[i][1];
  q2 = pairs[i][2];
  E1 = ellminimalmodel(ellinit([0, 1+q1^2, 0, q1^2, 0]));
  E2 = ellminimalmodel(ellinit([0, 1+q2^2, 0, q2^2, 0]));
  M = ellisomat(E1, 0, 1);
  \\ M[1] = list of curves in the isogeny class.
  my(found = 0);
  for(k=1, length(M[1]),
    my(Ek = ellinit(M[1][k]));
    if (Ek.j == E2.j,
      \\ Same j: check if isomorphic
      found = 1;
    );
  );
  print("Pair ", i, ": ", q1, " -> ", q2, "   isog class size: ", length(M[1]), "   E2 in class? ", found);
);
}

quit;

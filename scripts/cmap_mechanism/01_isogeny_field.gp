/* Probe: are E_PCP(q) and E_PCP(c(G)) isogenous over a larger field?
   Strategy: compute j-invariants. For each c-map pair, check if there is a
   quadratic field K = Q(sqrt(d)) over which they share an isogeny.
   We use: two elliptic curves over Q are isogenous over K = Q(sqrt(d))
   iff their L-series factor compatibly mod good primes.
   Easier check: compute conductors over Q(sqrt(d)) via twists.
*/
default(parisize, 800000000);

E_PCP(q) = ellinit([0, 1+q^2, 0, q^2, 0]);
canonical_q(qv) = {
  my(n=abs(numerator(qv)), d=abs(denominator(qv)));
  if (n<=d, n/d, d/n);
};

\\ Get j-invariant in compact form
jinv(q) = ellj([0, 1+q^2, 0, q^2, 0]);

\\ Pairs known to be related by c-map (canonical form):
{
pairs = [
  [20/21, 48/55],
  [7/24, 20/99],
  [11/60, 39/80],
  [11/60, 17/144],
  [104/153, 195/748],
  [17/144, 65/2112],
  [195/748, 225/272],
  [96/247, 315/572],
  [44/117, 11/60],
  [27/364, 120/209]
];
}

print("=== Pair-wise j-invariants and conductor data ===");
{
for(i=1, length(pairs),
  my(q1, q2, E1, E2, j1, j2, N1, N2);
  q1 = pairs[i][1];
  q2 = pairs[i][2];
  E1 = ellinit([0, 1+q1^2, 0, q1^2, 0]);
  E2 = ellinit([0, 1+q2^2, 0, q2^2, 0]);
  j1 = ellj(E1);
  j2 = ellj(E2);
  N1 = ellglobalred(ellminimalmodel(E1))[1];
  N2 = ellglobalred(ellminimalmodel(E2))[1];
  print("--- Pair ", i, ": q1=", q1, " q2=", q2);
  print("  j1 = ", j1);
  print("  j2 = ", j2);
  print("  N(E1) = ", N1, "   N(E2) = ", N2);
  print("  j1 == j2? ", j1 == j2);
  print("  j1*j2 = ", j1*j2, "  j1+j2 = ", j1+j2);
);
}

print("\n=== Test: are j-invariants in same Hilbert class field? ===");
\\ For CM curves, j(E) generates the Hilbert class field of an imaginary quadratic order.
\\ Generic E_PCP(q) is NOT CM (j != 0, 1728, -3375 etc.)

\\ Try ap matching at small primes: if E1 and E2 are K-isogenous for K = Q(sqrt(d)),
\\ then for primes p inert in K of good reduction: a_p(E1) = a_p(E2)
\\ for primes p split in K of good reduction: a_p(E1) = a_p(E2) OR they are
\\ matched by a non-trivial Galois symmetry.
\\ Simplest test: a_p(E1)^2 = a_p(E2)^2 mod p (for some primes) and
\\ if a_p(E1) != a_p(E2), then they're related by a quadratic twist.

print("\n=== ap comparison (looking for quadratic twist relation) ===");
{
for(i=1, length(pairs),
  my(q1, q2, E1, E2, N1, N2, badN, sign_matches, sign_opposites, ratios);
  q1 = pairs[i][1];
  q2 = pairs[i][2];
  E1 = ellminimalmodel(ellinit([0, 1+q1^2, 0, q1^2, 0]));
  E2 = ellminimalmodel(ellinit([0, 1+q2^2, 0, q2^2, 0]));
  N1 = ellglobalred(E1)[1];
  N2 = ellglobalred(E2)[1];
  badN = N1*N2;
  print("Pair ", i, ": ", q1, " vs ", q2);
  ratios = List();
  sign_matches = 0;
  sign_opposites = 0;
  forprime(p=3, 100,
    if (badN % p == 0, next);
    my(a1, a2);
    a1 = ellap(E1, p);
    a2 = ellap(E2, p);
    if (a1 == a2, sign_matches++, if (a1 == -a2 && a1 != 0, sign_opposites++));
    if (a1 != 0 && a2 != 0,
      listput(ratios, [p, a1, a2, a1/a2])
    );
  );
  print("  primes p<=100 (good): a1==a2: ", sign_matches, "   a1==-a2 (nz): ", sign_opposites);
  print("  first 5 (p,a1,a2,ratio): ", vector(min(5, length(ratios)), j, ratios[j]));
);
}

quit;

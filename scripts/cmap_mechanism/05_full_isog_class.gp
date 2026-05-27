/* Investigate the full Q-isogeny class of E_PCP(q) for several pairs.
   Specifically: list all curves in the class, their j-invariants, conductors,
   and look for relationship to E_PCP(c).

   Also check if the c-map is a "rational point translation" by a fixed
   isogeny composition over an extension.
*/
default(parisize, 1500000000);

print("=== Isogeny class structure of E_PCP(q) ===");

{
qlist = [20/21, 48/55, 11/60, 39/80, 17/144, 7/24, 20/99, 104/153, 195/748, 225/272];
}

{
for(i=1, length(qlist),
  my(q, E, Emin, M, classlist);
  q = qlist[i];
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);
  M = ellisomat(Emin, 0, 1);
  classlist = M[1];
  print("--- q=", q, "  N=", ellglobalred(Emin)[1]);
  print("  isogeny class size: ", length(classlist));
  print("  isogeny degree matrix: ", M[2]);
  for(k=1, length(classlist),
    my(Ek = ellinit(classlist[k]));
    print("    [", k, "] N=", ellglobalred(Ek)[1], "  j=", Ek.j);
  );
);
}

\\ Now, check: is there a "structural map" between two isogeny CLASSES?
\\ Key idea: c-map operates on rational points, sending P |--> c(P).
\\ The image lies on E_PCP(c), not E_PCP(q). Whether the map is rational
\\ on the universal family (parameterized by q) is the question.

\\ Try: write c-map in coordinates, see what surface it cuts out.

print("\n=== Symbolic c-map as a map of pairs (q, x, y) -> (Q, X, Y) ===");
print("\nGiven: y^2 = x*(x+1)*(x+q^2).");
print("c-value: c = 2*q*y/(q^2 - x^2).");
print("Target curve E_PCP(c): Y^2 = X*(X+1)*(X+c^2).");
print("\nQuestion: is there a polynomial/rational map (q, x, y) -> (Q, X, Y) with Q=c?\n");

\\ Let's compute c on the generic point (q, x, y) and look at what (Q, X, Y) on the target might be.
\\ The c-map is not yet a (X, Y) prescription; it just gives Q = c.
\\ For this to be a map of curves, we need an associated (X, Y) on E_PCP(c).
\\
\\ Hypothesis: the recovery map sends the point (x, y) on E_PCP(q) to a "Pythagorean rational" c,
\\ and there is an INDUCED point on E_PCP(c). But which point?
\\
\\ Empirical: take q1=20/21 (rank 1), G1 = [-125/4, 395/8] on the minimal model.
\\ Pull back to E_PCP(20/21):

q1 = 20/21;
E1 = ellinit([0, 1+q1^2, 0, q1^2, 0]);
E1min = ellminimalmodel(E1, &v);
print("E1 model change: ", v);
G1min = [-125/4, 395/8];
G1 = ellchangepointinv(G1min, v);
print("G1 on E_PCP(20/21): ", G1);
c1 = 2*q1*G1[2]/(q1^2 - G1[1]^2);
print("c1 = ", c1, " (canonical |c| <= 1: ", if(abs(c1) <= 1, c1, 1/c1), ")");

\\ Now: E_PCP(48/55) has a rank-1 generator G2.
q2 = 48/55;
E2 = ellinit([0, 1+q2^2, 0, q2^2, 0]);
E2min = ellminimalmodel(E2, &v2);
print("E2 model change: ", v2);
G2min = [-282, 1956];
G2 = ellchangepointinv(G2min, v2);
print("G2 on E_PCP(48/55): ", G2);
c2 = 2*q2*G2[2]/(q2^2 - G2[1]^2);
print("c2 = ", c2);

\\ The c-map sends G1 on E1 -> c1 on P^1.  Does it ALSO produce a point on E2?
\\ The c-value c1 = 48/55 = q2. So G1 |--> q2 = 48/55. But this is just the parameter,
\\ not a point on E2.
\\ Conversely, c2 = ?
print("\nc1 = ", c1, "  (should equal q2 = 48/55? canonically: ", if(abs(c1)<=1, c1, 1/c1), ")");
print("c2 = ", c2, "  (should equal q1 = 20/21? canonically: ", if(abs(c2)<=1, c2, 1/c2), ")");

\\ KEY: the c-map is q |--> c, where c equals the q-value of the TARGET curve.
\\ Not a point-to-point map. It's a parameter-to-parameter map.
\\ So really, the question is: what map of moduli space P^1_q induces this?

print("\n=== Symbolic c-map as a function from q to c (using generic q,x) ===");
print("c(q, x, y) = 2qy/(q^2 - x^2)  where y^2 = x(x+1)(x+q^2).");
print("\nFor a 1-parameter family of points x = x(q), c becomes a function of q.");
print("For specific MW generators of rank-jump fibers, c specializes to specific values.");
print("These values seem to form a graph structure on the Pythagorean locus.");

\\ Try to detect: is the c-map related to a Hecke operator on the family L-function?
\\ For each pair, look at L-functions and Hecke action.

\\ First, the family of all rank-jump E_PCP(q), their conductors form a list.
\\ Is there a modular-curve interpretation?

\\ Actually let's investigate a different angle: c-map as Atkin-Lehner involution.
\\ For E_PCP(q), the conductor N has specific structure. The c-map target has another N'.
\\ Look at the prime factorization patterns.

print("\n=== Conductor factorizations ===");
{
data_full = [
  [20/21, 4305],
  [48/55, 237930],
  [7/24, 22134],
  [20/99, 1551165],
  [11/60, 82005],
  [39/80, 1902810],
  [17/144, 2085594],
  [44/117, 5042037],
  [104/153, 2385474],
  [195/748, 0],  \\ unknown, compute
  [225/272, 11913090],
  [96/247, 1566474],
  [315/572, 3422804385],
  [27/364, 35972391],
  [120/209, 183591870],
  [65/2112, 19117608510]
];
}

{
for(i=1, length(data_full),
  my(q, N);
  q = data_full[i][1];
  N = data_full[i][2];
  if (N == 0,
    my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
    N = ellglobalred(ellminimalmodel(E))[1];
  );
  print("q=", q, "  N=", N, "  N=", factor(N));
);
}

quit;

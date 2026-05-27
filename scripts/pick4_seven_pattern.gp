\\ Check the "7 always divides conductor" pattern, and also 3, 5
\\ Plus check the precise relation between u*v factorisation and rank

build(m, n) = {my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); return(ellinit([0, s^2, 0, (a*b)^2, 0]));};

print("=== Always-bad primes test ===");
fixed_primes = [2, 3, 5, 7, 11, 13];
counts = vector(#fixed_primes, i, 0);
total = 0;
for(m = 2, 16, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, total = total + 1; my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(N = ellglobalred(Em)[1]); for(i = 1, #fixed_primes, if(N % fixed_primes[i] == 0, counts[i] = counts[i] + 1))))));
for(i = 1, #fixed_primes, print("Prime ", fixed_primes[i], " divides cond in ", counts[i], "/", total, " fibers"));

\\ More targeted: do certain primes ALWAYS divide?
\\ from the data, 3 and 7 always appear, 5 most of the time. Verify.
\\ Note 21 = 3*7 is the conductor for (m,n)=(2,1) -- the curve 21a1 / X_0(21)/X_1(21)!
\\ This is the famous Mestre / Tunnel curve with 4-isogeny structure.

\\ Test: do all our curves share the isogeny class of 21a?
\\ No -- conductor varies. But they may all be CONGRUENT mod something, or
\\ related via quadratic twist.

print("\n=== Quadratic-twist test: is E(m,n) a twist of E(2,1)? ===");
E_base = build(2, 1);
Em_base = ellminimalmodel(E_base);
j_base = E_base.j;
print("j of E(2,1) = ", j_base);
print("conductor of E(2,1) = ", ellglobalred(Em_base)[1]);
for(m = 2, 12, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(E = build(m,n)); my(j = E.j); print("(m,n)=(", m, ",", n, ") j=", j, " same as 21a1? ", j == j_base))));

\\ j is different -- so not all twists of the same curve.
\\ But: do they all lie in a fixed isogeny class up to twist?

\\ Test all our curves for j-invariant collisions
print("\n=== j-invariant duplicates across fibers ===");
J_seen = List();
J_dupes = 0;
for(m = 2, 16, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(E = build(m,n)); my(j = E.j); my(found = 0); for(i = 1, #J_seen, if(J_seen[i][1] == j, found = i; break)); if(found != 0, J_dupes = J_dupes + 1; print("DUPE j: (", m, ",", n, ") matches (", J_seen[found][2], ",", J_seen[found][3], ")") , listput(J_seen, [j, m, n]) ) ) ) );
print("Distinct j-invariants: ", #J_seen, ", duplicates: ", J_dupes);

\\ Now: WHY is rank > 0 for so many fibers?
\\ Hypothesis: rank is high because the torsion subgroup is large (Z/4 x Z/2),
\\ which forces existing rational points via 4-descent. Heuristically, the
\\ regulator is smaller for larger torsion.
\\ Mazur/Cremona: curves with Z/4 x Z/2 are constrained. Let's check the
\\ Cremona-style "torsion + isogeny" classification: only finitely many j-invariant
\\ classes have BOTH torsion Z/4 x Z/2 AND isogeny class size 6.

\\ Actually for non-CM E with full 2-torsion, the 2-isogeny graph has 4 vertices
\\ (E, E/<T1>, E/<T2>, E/<T3>) when 2-torsion is (Z/2)^2 but no 4-torsion.
\\ With ALSO a 4-torsion point, you get up to 8 vertices. So size-6 means
\\ specifically Z/4 x Z/2 with a unique extra 2-isogeny on one branch.

\\ Verify isogeny degrees for (m,n)=(2,1)
E = build(2,1); Em = ellminimalmodel(E); cls = ellisomat(Em);
print("\n=== Isogeny degree matrix for (2,1) [Cremona class 21a] ===");
\\ cls[2] is a matrix in PARI
n_cls = #cls[1];
for(i = 1, n_cls, my(row = vector(n_cls, j, cls[2][i,j])); print("from curve ", i, " degrees: ", row));

\\ Rank closed-form attempt: rank correlates with sign of some Pythagorean expression?
print("\n=== Rank vs (m,n) parameter pattern ===");
\\ from earlier: rank=0 for (2,1), (3,2), (4,1), (5,4), (6,1), (7,2), (7,4), (8,1)
\\              rank=1 for (4,3), (5,2), (7,6)
\\              rank=2 for (6,5)
\\ Let's recompute analytic ranks systematically.
for(m = 2, 12, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(ar = ellanalyticrank(Em, 0.05)[1]); my(rs = ellrootno(Em)); print("(", m, ",", n, ")  ar=", ar, "  rootno=", rs, "  a-b=", m^2-n^2-2*m*n, "  a+b=", m^2-n^2+2*m*n))));

quit;

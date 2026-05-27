\\ PICK-4 follow-up: s^2 ± 2ab = perfect squares pattern
\\ We have a = m^2-n^2, b = 2mn, s = m^2+n^2 (Pythagorean triple a,b,s with a^2+b^2=s^2).
\\ Observed: s^2 - 2ab and s^2 + 2ab are always perfect squares.
\\ Theorem candidate: s^2 - 2ab = (m^2 - 2mn - n^2)^2  and  s^2 + 2ab = (m^2 + 2mn - n^2)^2
\\ Check algebraically.

print("=== Algebraic identity test (symbolic) ===");
\\ Treat m, n as polynomial variables
default(realprecision, 30);

\\ Just test numerically for many (m,n)
print("=== Numeric verification ===");
ok1 = 1; ok2 = 1;
for(m = 2, 30, for(n = 1, m-1, my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); my(t1 = s^2 - 2*a*b); my(t2 = s^2 + 2*a*b); my(u1 = (m^2 - 2*m*n - n^2)^2); my(u2 = (m^2 + 2*m*n - n^2)^2); if(t1 != u1, ok1 = 0; print("FAIL t1 (m,n)=(", m, ",", n, ")")); if(t2 != u2, ok2 = 0; print("FAIL t2 (m,n)=(", m, ",", n, ")"))));
print("Identity s^2 - 2ab == (m^2-2mn-n^2)^2 : ", if(ok1, "HOLDS for all (m,n) in 2..30", "FAILS"));
print("Identity s^2 + 2ab == (m^2+2mn-n^2)^2 : ", if(ok2, "HOLDS for all (m,n) in 2..30", "FAILS"));

\\ Note (m^2 - 2mn - n^2)^2 + (2mn)^2 ... interesting. Let's just see.
\\ Actually s^2 - 2ab = (m^2 + n^2)^2 - 4mn(m^2-n^2)
\\ Let u = m^2 - 2mn - n^2, then u^2 = m^4 - 4m^3n + 2m^2n^2(-1 + 2) + 4mn^3 + n^4 ... we trust the numeric test.

\\ Consequence: disc(E) = 16 a^4 b^4 (s^2-2ab)(s^2+2ab) = 16 a^4 b^4 u1 u2 where u1, u2 themselves squares!
\\ So disc(E) is 16 * (a^2 b^2 |u| |v|)^2 where u = m^2-2mn-n^2, v = m^2+2mn-n^2.
\\ This means c4^3/disc = j has denominator a SQUARE * (1/16). Let's confirm.

print("\n=== c4^3 vs disc structure ===");
for(m = 2, 8, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); my(u = m^2 - 2*m*n - n^2, v = m^2 + 2*m*n - n^2); my(c4 = 16*s^4 - 48*a^2*b^2); my(disc = 16*a^4*b^4*u^2*v^2); my(j = c4^3/disc); print("(m,n)=(", m, ",", n, ") u=", u, " v=", v, "  uv=", u*v, "  s^4-4a^2b^2=", s^4 - 4*a^2*b^2, "  uv^2 test=", (u*v)^2 == (s^4 - 4*a^2*b^2)))));

\\ So disc factors as a*b*u*v ... let's see u*v
\\ u*v = (m^2-n^2)^2 - (2mn)^2 = a^2 - b^2.  YES! u*v = a^2 - b^2 = (m^2-n^2)^2 - 4m^2 n^2

print("\n=== u*v = a^2 - b^2 test ===");
for(m = 2, 10, for(n = 1, m-1, if(gcd(m,n)==1, my(a = m^2-n^2, b = 2*m*n); my(u = m^2-2*m*n-n^2, v = m^2+2*m*n-n^2); print("(m,n)=(",m,",",n,") u*v=", u*v, " a^2-b^2=", a^2-b^2, " equal=", u*v == a^2-b^2))));

\\ So:  s^4 - 4 a^2 b^2 = (u v)^2 = (a^2 - b^2)^2
\\ Equivalently:  s^2 = m^4 + 2 m^2 n^2 + n^4, and (a-b)(a+b) ... well a^2-b^2 = (m^2-n^2)^2 - 4 m^2 n^2 = (m^2-n^2-2mn)(m^2-n^2+2mn) = u*v. CHECK.

print("\n=== Therefore disc(E) is 16 * (a^2 b^2 (a^2-b^2))^2  -- ALWAYS A SQUARE / 16 ===");
\\ Significance: E has discriminant of the form 16 * D^2 with D = a^2 b^2 (a^2-b^2).
\\ This forces specific 2-isogeny / torsion structure.

\\ Now: what's the isogeny class structure precisely? Each fiber has |isog| = 6.
\\ Standard interpretation: E has full 2-torsion (3 rational 2-torsion points), and the
\\ 2-isogeny graph is a 6-vertex graph with three 2-isogenies from E and from its
\\ partners. Let's compute the isogeny graph explicitly for a few.

print("\n=== Isogeny graph structure (sample) ===");
for(idx = 1, 4,
  my(mn = [[2,1], [3,2], [4,1], [4,3]][idx]);
  my(m = mn[1], n = mn[2]);
  my(a = m^2-n^2, b = 2*m*n);
  my(E = ellinit([0, m^2+n^2, 0, (a*b)^2, 0]));
  my(Emin = ellminimalmodel(E));
  print("--- (m,n)=(", m, ",", n, ") ---");
  print("Emin a-invs: ", Emin[1..5]);
  my(cls = ellisomat(Emin));
  print("Isogeny class size: ", #cls[1]);
  print("Isogeny degree matrix:");
  for(i = 1, #cls[2], print("  ", cls[2][i]));
  print("Conductors of isogenous curves:");
  for(i = 1, #cls[1], my(Ei = cls[1][i]); my(Ni = ellglobalred(Ei)[1]); print("  curve ", i, ": cond=", Ni, ", a-invs=", Ei[1..5]));
);

\\ Heegner-style: discriminant of the field of CM that would be required (if any).
\\ Since we already see no CM, just look at the conductor factorisations.
print("\n=== Conductor factorisation pattern (rank-1 candidates from survey) ===");
\\ from existing survey (silverman_task1_ranks.out):
\\ ranks: 20/21:1, 80/39:1, 60/11:2, 24/7:1, 8/15:0, 40/9:0, 16/63:0, 56/33:0, 84/13:1, 48/55:1, 112/15:0
\\ q = a/b => need to find (m,n) for each:
\\ 20/21: a/b reduced; raw: m=?, n=? such that (m^2-n^2)/(2mn) ratio simplifies.
\\ Direct from raw fibers: build (m,n) -> q and find which gave rank>=1
known_ranks = [[2,1,1], [3,2,0], [4,1,0], [4,3,1], [5,2,1], [5,4,0], [6,1,0], [6,5,2], [7,2,1], [7,4,0], [7,6,1], [8,1,0], [8,3,1], [8,5,1], [8,7,0]];
\\ rank values from survey -- approximate. Will recompute.
print("(m,n)  conductor   conductor_factor   uv_factor");
for(i = 1, #known_ranks, my(r = known_ranks[i]); my(m = r[1], n = r[2]); my(a = m^2-n^2, b = 2*m*n); my(u = m^2-2*m*n-n^2, v = m^2+2*m*n-n^2); my(E = ellinit([0, m^2+n^2, 0, (a*b)^2, 0])); my(Emin = ellminimalmodel(E)); my(N = ellglobalred(Emin)[1]); print("(", m, ",", n, ")  N=", N, " = ", factor(N), "  u=", u, "(", factor(abs(u)), ")  v=", v, "(", factor(v), ")"));

quit;

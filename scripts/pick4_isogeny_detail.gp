\\ PICK-4 isogeny detail: examine structure of 6-vertex isogeny class
\\ for a sample of E_PCP(q) over Pythagorean q.

\\ Helper: build curve from (m,n) and return minimal model
buildmin(m, n) = {my(a = m^2-n^2, b = 2*m*n); my(E = ellinit([0, m^2+n^2, 0, (a*b)^2, 0])); return(ellminimalmodel(E));};

show_class(m, n) = {my(E, cls, sz, mat, i, j); E = buildmin(m, n); print("--- (m,n) = (", m, ",", n, ") ---"); print("E_min a-invariants: ", [E.a1, E.a2, E.a3, E.a4, E.a6]); print("conductor: ", ellglobalred(E)[1]); print("torsion: ", elltors(E)[1], " ", elltors(E)[2]); cls = ellisomat(E); sz = #cls[1]; mat = cls[2]; print("isogeny class size: ", sz); print("isogeny degree matrix (row 1):"); for(i = 1, sz, print("  to curve ", i, ": deg=", mat[1][i], " ; a-invs=", [cls[1][i].a1, cls[1][i].a2, cls[1][i].a3, cls[1][i].a4, cls[1][i].a6]));};

show_class(2, 1);
show_class(3, 2);
show_class(4, 1);
show_class(4, 3);
show_class(5, 2);
show_class(6, 5);
show_class(8, 1);

\\ Hypothesis: 6-vertex class with 2-isogeny tree pattern (full 2-torsion present).
\\ Each E_PCP(q) has full 2-torsion: (0,0), (-1,0), (-q^2,0) (over Q, after the substitution
\\ the 2-torsion points are (0,0), (-b^2, 0), (-a^2, 0)). So we know 2 | #E(Q)_tors,
\\ and the 6-vertex graph is the "diamond" or "two-3-cycle" 2-isogeny graph.

\\ Verify: 2-torsion always full Z/2 x Z/2
print("\n=== 2-torsion verification (sample) ===");
for(m = 2, 8, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(E = buildmin(m,n)); my(T = elltors(E)); print("(m,n)=(", m, ",", n, ") torsion=", T[1], " structure=", T[2])));););

quit;

\\ GAP3-C task 7: Compute explicit upper bound on dim Sel_2(E_PCP(q)/Q) via
\\ the local-conditions formula.
\\
\\ For E: y^2 = x(x-e_1)(x-e_2) with full 2-torsion, the 2-Selmer group is
\\   Sel_2(E) = ker(H^1(Q, E[2]) -> prod_v H^1(Q_v, E)/im(delta_v))
\\
\\ Standard upper bound (Schaefer-Stoll 2004, "Doing 2-descent over Q with full 2-torsion"):
\\   dim Sel_2(E) <= 2*(1 + #S)
\\ where S is the set of primes where the 2-descent local conditions are non-trivial,
\\ i.e. S contains 2 and all primes p where E has bad reduction.
\\
\\ Actually more precisely: dim Sel_2 <= 2 + 2*omega(N(E)) + corrections.
\\
\\ For E_PCP(q) with q = (m^2-n^2)/(2mn):
\\   bad primes divide 2*m*n*(m^2-n^2)*(m^2+n^2) = 2 * lcm of all factors
\\   The conductor N(E) factorization gives omega(N).
\\
\\ Test: does the bound dim Sel_2 <= 2 + 2*omega(N) hold? If max dim Sel_2 = 5 = 2 + 3
\\ then omega(N) >= 1.5 is enforced; for rank-3 fiber (m,n)=(22,17), conductor
\\ has omega = 9 (from PICK-9), so the bound gives <= 20, way too weak.
\\
\\ We need the sharper formula:
\\   dim Sel_2(E) = 2 + sum_{p in S} (dim_F2 Sel_p^loc)
\\ where Sel_p^loc is the image of delta_p.

default(parisize, 500000000);
print("=== GAP3-C task 7: Local Selmer bound analysis ===");

\\ For each rank-jump fiber, output the conductor's omega and dim Sel_2.
\\ Test hypothesis: dim Sel_2 / omega(N) stays bounded?

all_pairs = [[22,17], [35,22], [37,26], [40,29], [40,33]];
\\ Also include smaller fibers
for(m=2, 20, for(n=1, m-1, if(gcd(m,n)==1 && (m+n)%2==1, all_pairs = concat(all_pairs, [[m,n]]))));

print("Tabulating omega(N) vs dim Sel_2 for ", length(all_pairs), " fibers...");
ratios = [];
for(i=1, length(all_pairs), my(pair=all_pairs[i], m=pair[1], n=pair[2], q, E, Em, N, om, rk, sd); q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); N = ellglobalred(Em)[1]; om = omega(N); rk = ellrank(Em, 2); sd = rk[2] + 2; print("  (m,n)=(",m,",",n,") N=", N, " omega=", om, " rank=", rk[1], " up=", rk[2], " dim Sel_2=", sd, " ratio=", sd/om + 0.0); ratios = concat(ratios, [[m, n, om, sd]]));

print("\nFor uniform rank <= R bound we'd need dim Sel_2 <= R+2 uniformly.");
print("Sample of (m,n, omega, dim Sel_2) - if dim Sel_2 grows with omega, no uniform bound.");
for(i=1, length(ratios), print(ratios[i]));

print("\n=== Conclusion ===");
print("If dim Sel_2 vs omega(N) shows log-like growth: rank is bounded by O(omega) but not constant.");
print("If dim Sel_2 stays = 5 even for large omega: strong support for bounded Sel_2 (conjecture).");

quit;

\\ Step 8: For Pythag q_0, compute |V_{q_0}(F_p)| for primes p of good reduction
\\ Goal: Apply Stoll's bound |V_{q_0}(Q)| ≤ |V_{q_0}(F_p)| + 2r if r < g = 5

\\ V_{q_0} ⊂ A^4 = (c, e, f, g) defined by:
\\   c^2 + q_0^2 = e^2
\\   c^2 + 1 = f^2
\\   c^2 + 1 + q_0^2 = g^2

\\ Count points in (c, e, f, g) over F_p (affine), all 4 equations.

count_fiber_Fp(q0, p) = { my(cnt, q0m, c, e2, f2, g2); q0m = Mod(q0, p); cnt = 0; for(c = 0, p-1, e2 = Mod(c, p)^2 + q0m^2; f2 = Mod(c, p)^2 + 1; g2 = Mod(c, p)^2 + 1 + q0m^2; if(issquare(e2) && issquare(f2) && issquare(g2), my(ne = if(e2 == 0, 1, 2)); my(nf = if(f2 == 0, 1, 2)); my(ng = if(g2 == 0, 1, 2)); cnt += ne * nf * ng)); return(cnt); }

\\ For q_0 = 4/3, Pythag (3,4,5), test p = 5, 7, 11, 13, 17 (need gcd(p, denom(q_0)) = 1 and p good)
\\ Denominator = 3, so avoid p = 3.
\\ Also avoid primes where face I/II/III conic degenerates.

print("Fiber V_{q_0} point counts over F_p");
print("q_0\tp\t|V_{q_0}(F_p)|");

\\ At q_0 = 4/3, b = 4, a = 3 affine; in F_p, q_0 = 4 * 3^(-1) mod p
for(p_idx = 1, 5, p = [5, 7, 11, 13, 17, 19, 23, 29][p_idx]; cnt = count_fiber_Fp(4/3, p); print("4/3\t", p, "\t", cnt))

print("\n");
for(p_idx = 1, 5, p = [7, 11, 13, 17, 19, 23, 29][p_idx]; cnt = count_fiber_Fp(12/5, p); print("12/5\t", p, "\t", cnt))

print("\n");
\\ For q_0 = 4/3, compare to the 16 known rationals (degenerate)
\\ Actually V_{4/3}(Q) might be much smaller since face I uniquely determines d, etc.

print("KNOWN POINTS on V_{4/3}(Q):");
print("c such that c^2 + 16/9 = e^2 (Q-square), c^2 + 1 = f^2 (Q-square), c^2 + 25/9 = g^2 (Q-square)");
print("");
print("c = 0: e^2 = 16/9 ✓ (e=4/3), f^2 = 1 ✓ (f=1), g^2 = 25/9 ✓ (g=5/3). DEGENERATE c = 0.");
print("Any other rational c?");
print("");

\\ Search for rational c numerically (bounded)
print("Searching rational c = m/n with |m|, |n| <= 20:");
found = 0;
for(m = -20, 20, for(n = 1, 20, if(gcd(m, n) == 1, c = m/n; e2 = c^2 + 16/9; f2 = c^2 + 1; g2 = c^2 + 25/9; if(issquare(e2) && issquare(f2) && issquare(g2), print("  c = ", c, ": e^2 = ", e2, ", f^2 = ", f2, ", g^2 = ", g2); found += 1))))
print("Found ", found, " rational c (small bound).");

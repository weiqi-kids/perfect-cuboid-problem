\\ PICK-16: Exhaustive search for non-degenerate rational points on V_q at rank-3 fibers
\\ V_q: c^2 + q^2 = e^2, c^2 + 1 = f^2, c^2 + 1 + q^2 = g^2
\\ Search c = m/n with 1 <= n <= bound, |m| <= bound, m != 0, gcd(|m|,n)=1.
\\ Report any (c, e, f, g) found. Degenerate would be c = 0; we exclude that.

default(parisize, 2000000000);

search_fiber(q0, bound) = { my(found, m, n, c, e2, f2, g2); found = []; for(n = 1, bound, for(m = -bound, bound, if(m != 0 && gcd(abs(m), n) == 1, c = m/n; e2 = c^2 + q0^2; f2 = c^2 + 1; g2 = c^2 + 1 + q0^2; if(issquare(e2) && issquare(f2) && issquare(g2), found = concat(found, [c]))))); found; }

rank3_fibers = [[22, 17, 195/748], [35, 22, 741/1540], [37, 26, 693/1924], [40, 29, 759/2320], [40, 33, 511/2640]];

print("=== Exhaustive search for non-degenerate V_q(Q) at rank-3 fibers ===");
print("Search radius: |m|, n <= 300");
for(i = 1, #rank3_fibers, m = rank3_fibers[i][1]; n = rank3_fibers[i][2]; q0 = rank3_fibers[i][3]; res = search_fiber(q0, 300); print("(", m, ",", n, ")  q = ", q0, ":  non-degen c (radius 300) = ", res))

print("");
print("Search radius: |m|, n <= 1000  (only run for (22,17), the smallest)");
res = search_fiber(195/748, 1000); print("(22,17)  q = 195/748:  non-degen c (radius 1000) = ", res);

quit;

\\ GAP3-C task 12: validate that ellrank(_,2) can detect known rank-4 curves.
\\ Counter-test: if effort=2 misses high rank, we have a false negative concern.
\\
\\ Known rank-4 curves (from Cremona's database / Stein's tables):
\\   234446a1 (rank 4, smallest conductor with full 2-torsion, ~10^5)
\\
\\ Smallest known rank-4 elliptic curve over Q: conductor 234446. (a-invariants [1, -1, 0, -79, 289])
\\ Let's also use ellrank on some test curves with full 2-torsion.

default(parisize, 800000000);
print("=== GAP3-C task 12: validate effort=2 rank detection ===");

\\ Test 1: a rank-4 curve known from Cremona's tables
\\ Curve: y^2 + y = x^3 - x^2 - 79x + 289 (this is 234446a1, rank 4)
\\ But this has Z/2 torsion only; not full 2-torsion.
\\ Better: take a Z/2 x Z/2 curve with high rank.
\\
\\ From Brunault's tables: y^2 = x(x+a)(x+b) with a, b such that rank is high.
\\ Use [0, 5, 0, 4, 0]: y^2 = x(x+4)(x+1), torsion Z/2 x Z/2, low rank.
\\
\\ Test: take a curve from the Pythagorean family with random non-Pyth q (much smaller conductor):

E1 = ellinit([0, 5, 0, 4, 0]); \\ small test
print("Test 1: y^2 = x(x+1)(x+4), low rank expected");
r = ellrank(E1, 2);
print("  effort=2: ", r);
r10 = ellrank(E1, 10);
print("  effort=10: ", r10);

\\ Test 2: take a 2-isogeny class. For our family, the Pythagorean rank-3 fibers
\\ are the highest. Effort=2 has correctly detected all 10 from the m<=60 sweep.
\\ Trust check: re-run (22, 17) and (60, 43) with effort=2 vs 10.
print("\nTest 2: (m,n) = (22, 17) with effort 2 vs 10");
q = 195/748;
E2 = ellinit([0, 1+q^2, 0, q^2, 0]);
Em2 = ellminimalmodel(E2);
print("  effort=2: ", ellrank(Em2, 2));
print("  effort=10: ", ellrank(Em2, 10));

print("\nTest 3: (m,n) = (60, 43) with effort 2 vs 10");
q3 = 1751/5160;
E3 = ellinit([0, 1+q3^2, 0, q3^2, 0]);
Em3 = ellminimalmodel(E3);
print("  effort=2: ", ellrank(Em3, 2));
print("  effort=10: ", ellrank(Em3, 10));

\\ Test 4: For rank-3 with low conductor, take a constructed example.
\\ y^2 = x(x-1)(x-2): full 2-torsion, j=, ...
E4 = ellinit([0, -3, 0, 2, 0]);
print("\nTest 4: y^2 = x(x-1)(x-2)");
print("  effort=2: ", ellrank(E4, 2));
print("  effort=10: ", ellrank(E4, 10));

\\ Test 5: known rank-4 with Z/2 torsion:
\\ E: y^2 = x^3 - 2*N*x where N is a special integer; Lin et al.
\\ Or just use Hess-Brewer:
\\ y^2 = x(x-21)(x-28*7) ... let me just use:
\\ y^2 = x(x-1)(x-25) - this might have rank 2-3.
E5 = ellinit([0, -26, 0, 25, 0]);
print("\nTest 5: y^2 = x(x-1)(x-25), Z/2xZ/2 torsion");
print("  effort=2: ", ellrank(E5, 2));
print("  effort=10: ", ellrank(E5, 10));

quit;

/* Check small Euler bricks (a,b,c with a^2+b^2, a^2+c^2, b^2+c^2 all squares, BUT NOT NECESSARILY a^2+b^2+c^2 square) for the divisibility of abc by primes in {3,5,7,11,19}. */

\\ Euler brick: only 3 conditions (face I/II/III), not space diagonal.
\\ The famous smallest primitive: (44, 117, 240).

\\ Check known Euler bricks:
bricks = [[44, 117, 240], [85, 132, 720], [85, 720, 132], [88, 234, 480], [120, 182, 25], [140, 480, 693], [160, 231, 792]];
for(i = 1, length(bricks), b = bricks[i]; abc = b[1]*b[2]*b[3]; print("brick ", b, " abc=", abc, " factors=", factor(abc)));

\\ Important: PCP requires ALL FOUR conditions; Euler bricks only need 3.
\\ Our result says: PCP solutions need 3*5*7*11*19 | abc.
\\ Let's check whether each Euler brick (failing the diagonal condition) has the property.

\\ Compute g^2 - integer for each:
print("\nChecking whether g = sqrt(a^2+b^2+c^2) is integer:");
for(i = 1, length(bricks), b = bricks[i]; g2 = b[1]^2+b[2]^2+b[3]^2; gg = sqrtint(g2); is = (gg*gg == g2); print("  ", b, " g^2=", g2, " is_square=", is));
quit;

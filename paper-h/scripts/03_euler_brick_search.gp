/* 03_euler_brick_search.gp
   Exhaustive search for perfect cuboids among primitive Euler bricks with all
   edges bounded by EDGEMAX.

   An Euler brick is a triple (a,b,c) of positive integers with a^2+b^2,
   b^2+c^2, a^2+c^2 all perfect squares (the three face diagonals integral).
   It is PRIMITIVE if gcd(a,b,c)=1.  A perfect cuboid additionally has
   a^2+b^2+c^2 a perfect square (the space diagonal integral).

   Algorithm (face sieve).
     1. For each ordered pair a<=b with a^2+b^2 a perfect square (a primitive-
        or-imprimitive Pythagorean pair), and each c with b<=c<=EDGEMAX:
        test whether b^2+c^2 and a^2+c^2 are both perfect squares.
     2. If so, (a,b,c) (sorted) is an Euler brick; record it if primitive.
     3. For every Euler brick found, test whether a^2+b^2+c^2 is a perfect
        square; if it is, a perfect cuboid has been found.
   We loop a<=b<=c to enumerate each unordered brick once.

   issquare() over Z is exact (no floating point), so the search is rigorous.
   PARI/GP 2.15.4.
*/
default(parisize, 2000000000);

EDGEMAX = 30000;

bricks = List();
pcpcount = 0;

{
for(a = 1, EDGEMAX,
  for(b = a, EDGEMAX,
    if(issquare(a^2 + b^2),
      for(c = b, EDGEMAX,
        if(issquare(b^2 + c^2) && issquare(a^2 + c^2),
          if(gcd(gcd(a,b),c) == 1,
            listput(bricks, [a, b, c]);
            if(issquare(a^2 + b^2 + c^2),
              pcpcount = pcpcount + 1;
              print("!!! PERFECT CUBOID: (", a, ",", b, ",", c, ")")
            )
          )
        )
      )
    )
  )
);
}

print("");
print("=== Primitive Euler brick search, all edges <= ", EDGEMAX, " ===");
print("primitive Euler bricks found: ", #bricks);
print("perfect cuboids found:       ", pcpcount);
print("");
print("list of primitive Euler bricks (a<=b<=c):");
{
for(i = 1, #bricks,
  print("   ", i, ".  ", bricks[i])
);
}
quit;

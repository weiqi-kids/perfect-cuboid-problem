/* Test classes involving g: (g, g-a), (g-a, g-b), etc. */

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

\\ Test on the bricks (where g^2 is in Q_2 since g^2 = a^2+b^2+c^2 ≡ 1 mod 8)
\\ But g is irrational. Compute its square class in Q_2.

\\ Strategy: g^2 is known, find sqrt mod 2^k for various k. Use 2 sqrt choices.

bricks = [[44, 117, 240], [85, 132, 720], [140, 480, 693], [160, 231, 792], [187, 1020, 1584], [240, 252, 275], [1008, 1100, 1155]];

\\ Pick a square root of n in Z_2 mod 2^k. There are 2 sqrts up to sign (4 if we count negatives mod 2^k).
\\ The two SQUARE CLASSES correspond to s and -s — same class since (-s)^2 = s^2.
\\ Wait: -s ≡ M - s mod M. As a square class element, [s] and [-s] = [-1][s]. So if -1 is non-sq, different classes.
\\ -1 IS non-sq in Q_2 (since -1 ≡ 7 mod 8, not 1).
\\ So actually there are 2 distinct square classes for sqrt of g^2 in Q_2 (s and -s class).

\\ But wait: g^2 = X, and g is one specific element s with s^2 = X. Then -s is also a sqrt, but they represent the SAME 2-adic point on V (just negated). On V projectively, sign matters: (a, b, c, d, e, f, g) ~ (-a, -b, -c, -d, -e, -f, -g). So g and -g give different projective points UNLESS we negate everything.

\\ For BM, evaluating an algebraic class at a point doesn't depend on overall sign (since (g, g-a) and (-g, -g+a) = (-g, -(g-a)) -- hilbert(-g, -(g-a)) = hilbert(g, g-a) * (sign stuff)).
\\ Actually (-x, -y) = (-x, -y) and bilinearity: (-1, -1)*(-1, y)*(x, -1)*(x, y) = -1 stuff *.
\\ Hilbert symbols are multilinear in F_2: (-x, -y) = (-1, -1) + (-1, y) + (x, -1) + (x, y).
\\ This is generally not equal to (x, y).

\\ Anyway, for our BM-style check, we need to consider g and -g as 2-adic elements.

orient_test(a, b, c) = {
  my(g2 = a^2+b^2+c^2);
  if(!issquare(Mod(g2, 8)) || g2 % 8 != 1,
    print("  g^2 mod 8 = ", g2 % 8, ", g NOT in Q_2 -- skip");
    return);
  \\ Compute sqrt of g2 in Q_2 to high precision (mod 2^30 say)
  \\ Hensel lift starting from sqrt mod 8.
  my(M = 2^30, t = 1);  \\ start: g^2 ≡ 1 mod 8 → t = 1 satisfies t^2 ≡ 1 mod 8.
  \\ Hensel: while t^2 != g2 mod current modulus, increase mod.
  \\ Standard: tk = t + (g2 - t^2)/(2t) using current mod
  for(k=4, 30,
    my(curM = 2^k);
    my(diff = (g2 - t^2) % curM);
    if(diff != 0,
      \\ Lift: t' = t + (diff / 2) mod 2^k -- only works for t odd
      \\ Better: solve x^2 ≡ g2 mod 2^k starting from current t mod 2^(k-1)
      \\ Hensel: t_{k} = (t_{k-1} + g2/t_{k-1})/2 (Newton). But need exact.
      \\ Use: t' = t mod 2^(k-1); then t' or t' + 2^(k-1) is correct mod 2^k.
      if(((t + 2^(k-1))^2 - g2) % 2^k == 0, t = t + 2^(k-1))
    )
  );
  \\ Now t is sqrt of g2 mod 2^30, also t mod 2^30 in {1, 3, 5, 7 mod 8}.
  if((t^2 - g2) % (2^30) != 0, print("  Hensel failed!"); return);
  my(g_rep = t);
  print("  g (mod 2^30) = ", g_rep, ", mod 8 = ", g_rep % 8);

  \\ For each Hilbert symbol involving g, use g_rep as a 2-adic representative.
  my(d2 = a^2+b^2);
  my(d = sqrtint(d2));
  my(f = sqrtint(a^2+c^2));
  my(e = sqrtint(b^2+c^2));

  \\ Class C = (g, g-a)(g-a, g-b)
  print("  Class C = (g, g-a)(g-a, g-b) at p=2:");
  print("    g-a (mod 2^30) = ", (g_rep - a) % 2^30);
  print("    g-b (mod 2^30) = ", (g_rep - b) % 2^30);
  my(inv = inv2(g_rep, g_rep - a) + inv2(g_rep - a, g_rep - b));
  print("    inv = ", inv % 2);

  \\ Try class C2 = (g, g-c)(g-c, g-a)
  my(inv2_v = inv2(g_rep, g_rep - c) + inv2(g_rep - c, g_rep - a));
  print("  Class (g,g-c)(g-c,g-a) = ", inv2_v % 2);
}

{
for(i=1, #bricks,
  my(B = bricks[i]);
  print("Brick (", B[1], ", ", B[2], ", ", B[3], "):");
  my(odd_idx = 0);
  for(j=1, 3, if(B[j]%2==1, odd_idx = j));
  my(odd_v = B[odd_idx], evens = vector(2), k=0);
  for(j=1, 3, if(j!=odd_idx, k=k+1; evens[k] = B[j]));
  for(swap=0,1,
    my(a, b, c);
    a = odd_v;
    if(swap == 0, b = evens[1]; c = evens[2], b = evens[2]; c = evens[1]);
    \\ Need d, e, f to be integer faces in this ordering
    if(issquare(a^2+b^2) && issquare(b^2+c^2) && issquare(a^2+c^2),
      print(" oriented (a=",a,", b=",b,", c=",c,") v2(b)=",valuation(b,2)," v2(c)=",valuation(c,2));
      orient_test(a, b, c)
    )
  );
  print()
)
}

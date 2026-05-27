/* Test g-classes using proper Hensel via padicappr. */

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

\\ Square root of n in Z_2 to precision 2^prec
sqrt2adic(n, prec) = {
  \\ n must be ≡ 1 mod 8 for sqrt to exist in Q_2
  if(n % 8 != 1, error("not a square in Q_2"));
  my(t = 1);  \\ start at t with t^2 ≡ 1 mod 8
  \\ Newton: t' = (t + n/t)/2 -- in integers, using mod 2^k
  for(k=4, prec,
    my(curM = 2^k, t1, t2);
    \\ Either t or t + 2^(k-1) is correct mod 2^k
    t1 = t; t2 = t + 2^(k-1);
    if((t1^2 - n) % curM == 0, t = t1, t = t2)
  );
  t;
}

orient_test(a, b, c, prec) = {
  my(g2 = a^2+b^2+c^2);
  if(g2 % 8 != 1,
    print("    g^2 mod 8 = ", g2 % 8, ", g NOT in Q_2 -- skip"); return);
  my(g_rep = sqrt2adic(g2, prec));
  \\ Verify
  if((g_rep^2 - g2) % 2^prec != 0,
    print("    Hensel failed at prec ", prec); return);
  print("    g mod 2^",prec," = ", g_rep, "; mod 8 = ", g_rep % 8);

  my(invC = inv2(g_rep, g_rep - a) + inv2(g_rep - a, g_rep - b));
  print("    C = (g, g-a)(g-a, g-b): ", invC % 2);

  my(invD = inv2(g_rep, g_rep - c) + inv2(g_rep - c, g_rep - a));
  print("    D = (g, g-c)(g-c, g-a): ", invD % 2);

  my(invE = inv2(g_rep, g_rep - b) + inv2(g_rep - b, g_rep - c));
  print("    E = (g, g-b)(g-b, g-c): ", invE % 2);

  \\ Add classes A and B
  my(d = sqrtint(a^2+b^2));
  my(f = sqrtint(a^2+c^2));
  my(invA = inv2(d, d-a) + inv2(d-a, d-b));
  my(invB = inv2(f, f-a) + inv2(f-a, f-c));
  print("    A + B = (d,d-a)(d-a,d-b)(f,f-a)(f-a,f-c): ", (invA + invB) % 2);
  print("    A + B + C: ", (invA + invB + invC) % 2);
  print("    A + B + D: ", (invA + invB + invD) % 2);
  print("    A + B + C + D + E: ", (invA + invB + invC + invD + invE) % 2);
}

bricks = [[44, 117, 240], [85, 132, 720], [140, 480, 693], [160, 231, 792], [187, 1020, 1584], [240, 252, 275], [1008, 1100, 1155]];

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
    if(issquare(a^2+b^2) && issquare(b^2+c^2) && issquare(a^2+c^2),
      print(" oriented (a=",a,", b=",b,", c=",c,") v2(b)=",valuation(b,2)," v2(c)=",valuation(c,2));
      orient_test(a, b, c, 20)
    )
  );
  print()
)
}

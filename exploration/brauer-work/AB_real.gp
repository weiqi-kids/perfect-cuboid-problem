/* Verify A+B = 1/2 at p=2 on real Euler bricks (primitive ones, with both 2-adic cases). */

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

\\ Brick 1: a=117, b=44, c=240, d=125, e=267, f=244 (Case I: v2(b)=2, v2(c)=4)
print("=== Brick 1 (a=117, b=44, c=240): Case I (v2(b)=2) ===");
{
  my(a=117, b=44, c=240, d=125, e=267, f=244);
  print("  v2(a)=", valuation(a,2), " v2(b)=", valuation(b,2), " v2(c)=", valuation(c,2));
  my(A = inv2(d, d-a) + inv2(d-a, d-b));
  my(B = inv2(f, f-a) + inv2(f-a, f-c));
  print("  A = (d, d-a) + (d-a, d-b) = ", A);
  print("  B = (f, f-a) + (f-a, f-c) = ", B);
  print("  A + B mod 2 = ", (A + B) % 2);
}

\\ Brick 2: a=275, b=252, c=240 (need v2: 252=4*63, v2=2; 240=16*15, v2=4)
\\ So this is Case I (v2(b)=2): use (a=275, b=252, c=240), d^2 = 275^2+252^2 = 139129, d=373
\\                e^2 = 252^2+240^2 = 121104, e=348; f^2 = 275^2+240^2 = 133225, f=365.
print();
print("=== Brick 2 (a=275, b=252, c=240): Case I ===");
{
  my(a=275, b=252, c=240, d=373, e=348, f=365);
  print("  v2(a)=", valuation(a,2), " v2(b)=", valuation(b,2), " v2(c)=", valuation(c,2));
  my(A = inv2(d, d-a) + inv2(d-a, d-b));
  my(B = inv2(f, f-a) + inv2(f-a, f-c));
  print("  A = ", A);
  print("  B = ", B);
  print("  A + B mod 2 = ", (A + B) % 2);
}

\\ Same brick reoriented to Case II: a=275, b=240 (v2=4), c=252 (v2=2)
\\ This swaps b and c. Then d^2 = 275^2+240^2 = 133225, d=365.
\\ e^2 = 240^2+252^2 = 121104, e=348. f^2 = 275^2+252^2 = 139129, f=373.
print();
print("=== Brick 2 reoriented (a=275, b=240, c=252): Case II (v2(c)=2) ===");
{
  my(a=275, b=240, c=252, d=365, e=348, f=373);
  print("  v2(a)=", valuation(a,2), " v2(b)=", valuation(b,2), " v2(c)=", valuation(c,2));
  my(A = inv2(d, d-a) + inv2(d-a, d-b));
  my(B = inv2(f, f-a) + inv2(f-a, f-c));
  print("  A = ", A);
  print("  B = ", B);
  print("  A + B mod 2 = ", (A + B) % 2);
}

\\ Test more rich: 88, 234, 480 -- non-primitive (gcd=2), but useful for verification
print();
print("=== Brick (88, 234, 480) (gcd=2, not primitive) — a=117, b=44, c=240 already done — same class /2 ===");
\\ The brick (88, 234, 480) is 2*(44, 117, 240), so a=234 (odd?), no 234 is even.
\\ Let me reorient: 234 = 2*117 odd, oh 234 is even. 88 = 8*11. 480 = 32*15.
\\ Oddness: 117 odd, so 234 even, 88 even, 480 even. None odd. So gcd > 1, can divide by 2 to get back to (44, 117, 240).
\\ Done.

\\ Test (480, 504, 550): gcd? 480=2^5*15, 504=2^3*63, 550=2*5^2*11. gcd=2. Divide: (240, 252, 275). Done already.

\\ Generate larger primitives by inspecting more bricks
\\ E.g. (693, 480, 140), (140, 480, 693), etc.
print();
print("=== Brick (693, 480, 140): primitive? ===");
print("gcd(693,480,140) = ", gcd(gcd(693,480),140));
{
  my(a=693, b=480, c=140);
  print("  v2(a)=", valuation(a,2), " v2(b)=", valuation(b,2), " v2(c)=", valuation(c,2));
  \\ a is odd; b=480 = 2^5*15, v2=5; c=140 = 2^2*35, v2=2.
  \\ So Case II (v2(c)=2, v2(b)=5 >= 4).
  \\ Need d, e, f
  print("  d^2 = ", a^2+b^2, " is square? ", issquare(a^2+b^2), " d = ", sqrtint(a^2+b^2));
  print("  e^2 = ", b^2+c^2, " is square? ", issquare(b^2+c^2), " e = ", sqrtint(b^2+c^2));
  print("  f^2 = ", a^2+c^2, " is square? ", issquare(a^2+c^2), " f = ", sqrtint(a^2+c^2));
}

\\ Brick search: more primitive Euler bricks
print();
print("=== Searching for more primitive Euler bricks (max edge <= 2000) ===");
{
my(L = List());
for(a=1, 2000, for(b=a+1, 2000,
  if(issquare(a^2+b^2),
    for(c=b+1, 2000,
      if(issquare(b^2+c^2) && issquare(a^2+c^2) && gcd(gcd(a,b),c)==1,
        listput(L, [a,b,c])
      )
    )
  )
));
for(i=1, #L, print("  ", L[i]));
print("Total: ", #L);
}

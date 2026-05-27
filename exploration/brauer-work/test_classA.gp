/* Test the candidate Brauer class A = (d, d-a) * (d-a, d-b)
   on Euler bricks at all primes. */

inv_p(x,y,p) = if(hilbert(x,y,p)==1, 0, 1/2);
inv_infty(x,y) = if(x<0 && y<0, 1/2, 0);

\\ Brick 1: (a,b,c) = (117, 44, 240), d=125, e=267, f=244, g not integer
\\ For the "class A" evaluation we just need d, d-a, d-b
\\ At each p: inv = inv_p(d, d-a, p) + inv_p(d-a, d-b, p) - reduce mod 1
\\ Effective primes: d = 5^3, d-a = 8 = 2^3, d-b = 81 = 3^4
\\ So only p in {2,3,5} have potential non-trivial Hilbert symbol.

print("=== Brick 1: a=117, b=44, c=240, d=125, d-a=8, d-b=81 ===");
print("Sum of local invariants of class A = (d, d-a)*(d-a, d-b):");

{
  my(a=117, b=44, c=240, d=125, sum=0, x);
  for(i=1, 5,
    my(plist = [2,3,5,7,11]);
    my(p = plist[i]);
    x = inv_p(d, d-a, p) + inv_p(d-a, d-b, p);
    print("  p=", p, ": ", x);
    sum = sum + x;
  );
  print("  infinity: ", inv_infty(d, d-a) + inv_infty(d-a, d-b));
  print("  TOTAL: ", sum + inv_infty(d, d-a) + inv_infty(d-a, d-b));
}

print();
print("=== Brick 2: a=275, b=252, c=240, d=373, d-a=98, d-b=121 ===");
\\ d=373 (prime), d-a = 98 = 2 * 7^2, d-b = 121 = 11^2 (perfect square so trivial)
\\ Effective primes for non-zero contributions: p=2, p=7, p=11, p=373

{
  my(a=275, b=252, c=240, d=373, sum=0, x);
  for(i=1, 8,
    my(plist = [2,3,5,7,11,13,373,2*373]);
    my(p = plist[i]);
    if(p==2*373, p = nextprime(p));  \\ safety
    x = inv_p(d, d-a, p) + inv_p(d-a, d-b, p);
    print("  p=", p, ": ", x);
    sum = sum + x;
  );
  print("  TOTAL: ", sum);
}

print();
print("=== Full reciprocity check for class A on Brick 1 (sum mod 1) ===");
{
  my(a=117, b=44, c=240, d=125);
  my(P1 = d, P2 = d-a);
  my(Q1 = d-a, Q2 = d-b);
  \\ Class A = quaternion (P1, P2) + quaternion (Q1, Q2)
  \\ Compute Hilbert symbols at each prime up to 100, sum them.
  my(s = 0);
  forprime(p=2, 30, s = s + inv_p(P1,P2,p) + inv_p(Q1,Q2,p));
  s = s + inv_infty(P1,P2) + inv_infty(Q1,Q2);
  print("Sum of inv up to p=30 + infty: ", s);
  print("(Reciprocity says this should be 0 since both are in Br(Q))");
}

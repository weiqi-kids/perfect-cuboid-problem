/* Check A+B on all 7 primitive Euler bricks (max edge <= 2000) */

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

orient_and_test(edges) = {
  my(a0=edges[1], b0=edges[2], c0=edges[3]);
  my(idx_odd = 0);
  for(j=1, 3, if(edges[j]%2==1, idx_odd = j));
  if(idx_odd == 0, print("  no odd edge"); return);
  \\ Two orderings of even edges (since we want both Cases I and II)
  my(odd_val = edges[idx_odd], evens = vector(2), k=0);
  for(j=1, 3, if(j != idx_odd, k=k+1; evens[k] = edges[j]));
  \\ Try both orderings of evens
  for(swap=0, 1,
    my(a, b, c);
    a = odd_val;
    if(swap == 0,
      b = evens[1]; c = evens[2];
    ,
      b = evens[2]; c = evens[1];
    );
    \\ Need d^2 = a^2+b^2, etc. -- determine which is which based on which gives a perfect sq.
    my(d2 = a^2+b^2, e2 = b^2+c^2, f2 = a^2+c^2);
    if(issquare(d2) && issquare(e2) && issquare(f2),
      my(d = sqrtint(d2), e = sqrtint(e2), f = sqrtint(f2));
      my(A = inv2(d, d-a) + inv2(d-a, d-b));
      my(B = inv2(f, f-a) + inv2(f-a, f-c));
      print("  oriented (a=",a,", b=",b,", c=",c,"); v2(b)=",valuation(b,2)," v2(c)=",valuation(c,2),
        ";  A=",A,", B=",B,",  A+B mod 2 = ", (A+B) % 2)
    )
  )
}

bricks = [[44, 117, 240], [85, 132, 720], [140, 480, 693], [160, 231, 792], [187, 1020, 1584], [240, 252, 275], [1008, 1100, 1155]];

print("Class A+B = (d,d-a)(d-a,d-b)(f,f-a)(f-a,f-c) at p=2");
print("Orienting odd-edge as a, then trying both b/c orderings:");
print();
{
for(i=1, #bricks,
  print("Brick (", bricks[i][1], ", ", bricks[i][2], ", ", bricks[i][3], "):");
  orient_and_test(bricks[i]);
  print()
)
}

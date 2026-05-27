/* Listing Euler bricks up to bound, then checking parity */

list_eulerbricks(M) = {
  my(L = List());
  for(a=1,M,
    for(b=a,M,
      my(d2 = a^2+b^2);
      if(issquare(d2),
        for(c=b+1,M,
          if(issquare(b^2+c^2) && issquare(a^2+c^2),
            listput(L, [a,b,c])
          )
        )
      )
    )
  );
  L;
}

B = list_eulerbricks(600);
print("Number of Euler bricks (a<b<c, max <= 600): ", #B);
for(i=1, #B, print(B[i]));

print();
print("=== 2-adic valuations on edges ===");
{
for(i=1, #B,
  my(v = B[i], a, b, c);
  a=v[1]; b=v[2]; c=v[3];
  print("(",a,",",b,",",c,") v2=[",valuation(a,2),",",valuation(b,2),",",valuation(c,2),"]  parity=[",a%2,",",b%2,",",c%2,"]");
)
}

print();
print("=== Primitive Euler bricks, orienting odd-coord as a ===");
{
for(i=1, #B,
  my(v = B[i], a, b, c, g, pari, odd_idx, j, k, others, aa, bb, cc);
  a=v[1]; b=v[2]; c=v[3];
  g = gcd(gcd(a,b),c);
  if(g==1,
    pari = [a,b,c];
    odd_idx = 0;
    for(j=1,3, if(pari[j]%2==1, odd_idx=j));
    if(odd_idx > 0,
      others = vector(2); k=0;
      for(j=1,3, if(j != odd_idx, k=k+1; others[k] = pari[j]));
      aa = pari[odd_idx]; bb = others[1]; cc = others[2];
      print("a=",aa," (odd), b=",bb," c=",cc,"  v2(b)=",valuation(bb,2)," v2(c)=",valuation(cc,2));
    )
  )
)
}

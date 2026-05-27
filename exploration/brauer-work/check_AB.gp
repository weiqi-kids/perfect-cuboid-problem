/* Check A + B where
   A = (d, d-a)(d-a, d-b) [uses face I: a^2+b^2=d^2]
   B = (f, f-a)(f-a, f-c) [uses face III: a^2+c^2=f^2]
*/

default(parisize, "500M");
inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);
K = 6;  M = 2^K;
sqrt_all_mod(n, M) = { my(L = List()); for(t=0, M-1, if((t*t - n)%M == 0, listput(L, t))); Vec(L); }

print("=== A + B where A = (d, d-a)(d-a, d-b), B = (f, f-a)(f-a, f-c) ===");

\\ Need to iterate over both d and f sqrt choices

\\ Case I: v2(b)=2, v2(c)>=4
print();
print("Case I: v2(b)=2, v2(c)>=4");
values_I = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=16, M-1, if(c%16==0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(dsqs = sqrt_all_mod(d2, M), fsqs = sqrt_all_mod(f2, M));
          for(id=1, #dsqs, for(if_=1, #fsqs,
            my(d = dsqs[id], f = fsqs[if_]);
            if(d > 0 && f > 0 && (d-a)%M != 0 && (d-b)%M != 0 && (f-a)%M != 0 && (f-c)%M != 0,
              my(vA = inv2(d, d-a) + inv2(d-a, d-b));
              my(vB = inv2(f, f-a) + inv2(f-a, f-c));
              listput(values_I, (vA + vB) % 2)
            )
          ))
        )
      ))
    )
  ))
));
}
print("  A+B values: ", Set(values_I));

\\ Case II
print();
print("Case II: v2(c)=2, v2(b)>=4");
values_II = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=16, M-1, if(b%16==0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=4, M-1, if(c%4==0 && c%8!=0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(dsqs = sqrt_all_mod(d2, M), fsqs = sqrt_all_mod(f2, M));
          for(id=1, #dsqs, for(if_=1, #fsqs,
            my(d = dsqs[id], f = fsqs[if_]);
            if(d > 0 && f > 0 && (d-a)%M != 0 && (d-b)%M != 0 && (f-a)%M != 0 && (f-c)%M != 0,
              my(vA = inv2(d, d-a) + inv2(d-a, d-b));
              my(vB = inv2(f, f-a) + inv2(f-a, f-c));
              listput(values_II, (vA + vB) % 2)
            )
          ))
        )
      ))
    )
  ))
));
}
print("  A+B values: ", Set(values_II));

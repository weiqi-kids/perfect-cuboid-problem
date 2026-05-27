/* Check class A value on each case separately. */

default(parisize, "500M");
inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);
K = 6;  M = 2^K;
sqrt_all_mod(n, M) = { my(L = List()); for(t=0, M-1, if((t*t - n)%M == 0, listput(L, t))); Vec(L); }

print("=== Case I: v2(b)=2, v2(c)>=4 ===");
values_I = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=16, M-1, if(c%16==0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(dsqs = sqrt_all_mod(d2, M));
          for(id=1, #dsqs,
            my(d = dsqs[id]);
            if(d > 0 && (d-a) % M != 0 && (d-b) % M != 0,
              my(v = (inv2(d, d-a) + inv2(d-a, d-b)) % 2);
              listput(values_I, v)
            )
          )
        )
      ))
    )
  ))
));
}
print("  Values: ", Set(values_I));
print("  Count: ", #values_I, " (raw)");

print();
print("=== Case II: v2(c)=2, v2(b)>=4 ===");
values_II = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=16, M-1, if(b%16==0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=4, M-1, if(c%4==0 && c%8!=0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(dsqs = sqrt_all_mod(d2, M));
          for(id=1, #dsqs,
            my(d = dsqs[id]);
            if(d > 0 && (d-a) % M != 0 && (d-b) % M != 0,
              my(v = (inv2(d, d-a) + inv2(d-a, d-b)) % 2);
              listput(values_II, v)
            )
          )
        )
      ))
    )
  ))
));
}
print("  Values: ", Set(values_II));
print("  Count: ", #values_II);

\\ Also try the simpler class (d, d-a) alone
print();
print("=== Case I: just (d, d-a) ===");
values_simple_I = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=16, M-1, if(c%16==0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(dsqs = sqrt_all_mod(d2, M));
          for(id=1, #dsqs,
            my(d = dsqs[id]);
            if(d > 0 && (d-a) % M != 0,
              listput(values_simple_I, inv2(d, d-a))
            )
          )
        )
      ))
    )
  ))
));
}
print("  Values: ", Set(values_simple_I));

print();
print("=== Case II: just (d, d-a) ===");
values_simple_II = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=16, M-1, if(b%16==0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=4, M-1, if(c%4==0 && c%8!=0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(dsqs = sqrt_all_mod(d2, M));
          for(id=1, #dsqs,
            my(d = dsqs[id]);
            if(d > 0 && (d-a) % M != 0,
              listput(values_simple_II, inv2(d, d-a))
            )
          )
        )
      ))
    )
  ))
));
}
print("  Values: ", Set(values_simple_II));

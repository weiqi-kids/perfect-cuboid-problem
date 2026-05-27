/* Check whether (d, d-a)(d-a, d-b) is constant at p=2 on V(Q_2), considering
   BOTH normalizations: v2(b)=2 AND v2(c)=2 cases. */

default(parisize, "500M");

inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);

K = 6;  M = 2^K;

sqrt_all_mod(n, M) = {
  my(L = List(), t);
  for(t=0, M-1, if((t*t - n)%M == 0, listput(L, t)));
  Vec(L);
}

\\ Enumerate (a,b,c) mod M with:
\\   - a odd
\\   - {v2(b), v2(c)} = {2, k} for some k >= 4
\\   So two cases:
\\     Case I: v2(b) = 2, v2(c) >= 4
\\     Case II: v2(c) = 2, v2(b) >= 4

print("=== Class A = (d, d-a)*(d-a, d-b): values on V(Q_2), both 2-adic cases ===");

values = List();
{
\\ Case I: v2(b) = 2, v2(c) >= 4
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
              listput(values, v)
            )
          )
        )
      ))
    )
  ))
));

\\ Case II: v2(c) = 2, v2(b) >= 4 (i.e., b = 16*b', c = 4*c')
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
              listput(values, v)
            )
          )
        )
      ))
    )
  ))
));
}

vs = Set(values);
print("Values of class A taken on V(Q_2) (with parity constraint): ", vs);
\\ This should be {1} (always 1/2 in F_2 terms, i.e., 1) if the class is constant 1/2,
\\ or {0,1} (both 0 and 1/2) if not constant.

print();

\\ Now also check the "symmetric" class B = (f, f-a)*(f-a, f-c) (swapping b<->c)
print("=== Class B = (f, f-a)*(f-a, f-c): same test ===");
values2 = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=16, M-1, if(c%16==0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(fsqs = sqrt_all_mod(f2, M));
          for(if_=1, #fsqs,
            my(f = fsqs[if_]);
            if(f > 0 && (f-a) % M != 0 && (f-c) % M != 0,
              my(v = (inv2(f, f-a) + inv2(f-a, f-c)) % 2);
              listput(values2, v)
            )
          )
        )
      ))
    )
  ))
));

for(a=1, M-1, if(a%2==1,
  for(b=16, M-1, if(b%16==0,
    my(d2 = (a^2+b^2)%M);
    if(issquare(Mod(d2, M)),
      for(c=4, M-1, if(c%4==0 && c%8!=0,
        my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
        if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
          my(fsqs = sqrt_all_mod(f2, M));
          for(if_=1, #fsqs,
            my(f = fsqs[if_]);
            if(f > 0 && (f-a) % M != 0 && (f-c) % M != 0,
              my(v = (inv2(f, f-a) + inv2(f-a, f-c)) % 2);
              listput(values2, v)
            )
          )
        )
      ))
    )
  ))
));
}
vs2 = Set(values2);
print("Values of class B taken: ", vs2);

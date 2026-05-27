/* ==========================================================================
   Goal: Determine the 2-adic square classes of a,b,c,d,e,f,g on V(Q_2),
   subject to parity constraints. Then determine which Brauer classes
   give constant local invariant on V(Q_2).

   Q_2^* / (Q_2^*)^2 has 8 elements, parametrized by (v2 mod 2, u mod 8) for
   x = 2^{v2(x)} u with u odd.

   Constraint set on V(Q_2):
     a odd
     v2(b) >= 2, v2(c) >= 2
     |v2(b) - v2(c)| >= 2 (theorem 11)
     all 4 face/space equations hold
   ========================================================================== */

\\ Square class of a Q_2 element x: represented by (v2 mod 2, u mod 8)
sqcl2(x) = {
  my(v, u);
  v = valuation(x, 2);
  u = x / 2^v;
  my(uc = u % 8); if(uc < 0, uc += 8);
  [v % 2, uc];
}

\\ String representation
sqcl_str(s) = {
  my(parity = s[1], u = s[2]);
  Str(if(parity==0,"",2"*"),"[",u,"]");
}

\\ Find all 2-adic V-points (mod 2^K) with v2(a)=0, v2(b)=2, v2(c) >= 4
\\ Tabulate the (v2 mod 2, u mod 8) of each of a,b,c,d,e,f,g.

K = 8;  \\ work mod 2^8 = 256, sufficient to determine sq class
M = 2^K;

sqrt_mod(n, M) = {
  my(r=-1, t);
  for(t=0, M-1, if((t*t - n)%M == 0, r = t; break));
  r;
}

print("=== 2-adic V-points: (a odd, v2(b)=2, v2(c)>=4) mod ",M," ===");
print();
print("a   b   c   | (d,e,f,g) mod ",M, " | sqcl: a,b,c,d,e,f,g");

classes_seen = List();
{
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0 && b%8!=0,  \\ v2(b) = 2 exactly
    if(issquare(Mod(a^2+b^2, M)),
      my(d = sqrt_mod((a^2+b^2)%M, M));
      for(c=16, M-1, if(c%16==0,  \\ v2(c) >= 4
        if(issquare(Mod(b^2+c^2, M)) && issquare(Mod(a^2+c^2, M)) && issquare(Mod(a^2+b^2+c^2, M)),
          my(e = sqrt_mod((b^2+c^2)%M, M),
             f = sqrt_mod((a^2+c^2)%M, M),
             g = sqrt_mod((a^2+b^2+c^2)%M, M));
          if(d!=0 && e!=0 && f!=0 && g!=0,
            my(sa = sqcl2(a), sb = sqcl2(b), sc = sqcl2(c),
               sd = sqcl2(d), se = sqcl2(e), sf = sqcl2(f), sg = sqcl2(g));
            my(key = [sa,sb,sc,sd,se,sf,sg]);
            if(!setsearch(Set(classes_seen), key),
              listput(classes_seen, key);
              print(a,"  ",b,"  ",c,"  | d=",d," e=",e," f=",f," g=",g,
                "  | sqcl: a=",sa," b=",sb," c=",sc," d=",sd," e=",se," f=",sf," g=",sg)
            );
          )
        )
      ))
    )
  ))
))
}

print();
print("Total distinct square-class profiles: ", #classes_seen);

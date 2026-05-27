/* Check if (2, X) classes for various X give constant inv_2 on V(Q_2) */

default(parisize, "500M");
inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);
K = 6;  M = 2^K;
sqrt_all_mod(n, M) = { my(L = List()); for(t=0, M-1, if((t*t - n)%M == 0, listput(L, t))); Vec(L); }

\\ For each candidate X = polynomial in (a, b, c, d, e, f, g, signs and shifts),
\\ enumerate V(Q_2) points and check if (2, X)_2 is constant.

\\ Build the data: for each V-point, record (2, X) for several X candidates.

print("=== Candidate classes (2, X): which X give constant value on V(Q_2)? ===");
print();

\\ List of X candidates: a, b, c, d, e, f, g, a*b, a*c, b*c, d*e, d*f, e*f, etc.
\\ Also (a+b), (a-b), etc.

\\ For each X, enumerate and record values
test_X_constant = (X_func) -> {
  my(values = List());
  \\ Case I
  for(a=1, M-1, if(a%2==1,
    for(b=4, M-1, if(b%4==0 && b%8!=0,
      my(d2 = (a^2+b^2)%M);
      if(issquare(Mod(d2, M)),
        for(c=16, M-1, if(c%16==0,
          my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
          if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
            my(dsqs = sqrt_all_mod(d2, M), esqs = sqrt_all_mod(e2, M), fsqs = sqrt_all_mod(f2, M), gsqs = sqrt_all_mod(g2, M));
            for(id=1, #dsqs, for(ie=1, #esqs, for(if_=1, #fsqs, for(ig=1, #gsqs,
              my(d=dsqs[id], e=esqs[ie], f=fsqs[if_], g=gsqs[ig]);
              if(d>0 && e>0 && f>0 && g>0,
                my(X = X_func(a,b,c,d,e,f,g));
                if(X % M != 0,
                  listput(values, inv2(2, X))
                )
              )
            ))))
          )
        ))
      )
    ))
  ));
  \\ Case II
  for(a=1, M-1, if(a%2==1,
    for(b=16, M-1, if(b%16==0,
      my(d2 = (a^2+b^2)%M);
      if(issquare(Mod(d2, M)),
        for(c=4, M-1, if(c%4==0 && c%8!=0,
          my(e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
          if(issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
            my(dsqs = sqrt_all_mod(d2, M), esqs = sqrt_all_mod(e2, M), fsqs = sqrt_all_mod(f2, M), gsqs = sqrt_all_mod(g2, M));
            for(id=1, #dsqs, for(ie=1, #esqs, for(if_=1, #fsqs, for(ig=1, #gsqs,
              my(d=dsqs[id], e=esqs[ie], f=fsqs[if_], g=gsqs[ig]);
              if(d>0 && e>0 && f>0 && g>0,
                my(X = X_func(a,b,c,d,e,f,g));
                if(X % M != 0,
                  listput(values, inv2(2, X))
                )
              )
            ))))
          )
        ))
      )
    ))
  ));
  Set(values);
}

\\ Test X = a
print("(2, a): values = ", test_X_constant((a,b,c,d,e,f,g) -> a));
print("(2, d): values = ", test_X_constant((a,b,c,d,e,f,g) -> d));
print("(2, e): values = ", test_X_constant((a,b,c,d,e,f,g) -> e));
print("(2, f): values = ", test_X_constant((a,b,c,d,e,f,g) -> f));
print("(2, g): values = ", test_X_constant((a,b,c,d,e,f,g) -> g));
print("(2, a*d): values = ", test_X_constant((a,b,c,d,e,f,g) -> a*d));
print("(2, a*g): values = ", test_X_constant((a,b,c,d,e,f,g) -> a*g));
print("(2, d*f): values = ", test_X_constant((a,b,c,d,e,f,g) -> d*f));
print("(2, d*g): values = ", test_X_constant((a,b,c,d,e,f,g) -> d*g));
print("(2, f*g): values = ", test_X_constant((a,b,c,d,e,f,g) -> f*g));
print("(2, d*f*g): values = ", test_X_constant((a,b,c,d,e,f,g) -> d*f*g));
print("(2, a*d*f*g): values = ", test_X_constant((a,b,c,d,e,f,g) -> a*d*f*g));
print();
\\ Now combinations with -1
print("(2, -1) (constant): ", inv2(2, -1));
print("(-1, a): values = ", test_X_constant((a,b,c,d,e,f,g) -> -a));

\\ Exact-square locus F6 = k^2 of E_PCP(q).
\\ Parametrization (m,n) = (s^2-2st+2t^2, 2st), k=|s^2-2t^2|.
\\ For each (s,t): a=m^2-n^2, b=2mn, q=a/b. E_PCP: Y^2 = X(X+1)(X+q^2).
\\ Integral minimal-ish model EI: Y^2 = X(X+b^2)(X+a^2)  (b^2,a^2 integers).
\\ Recovery map (on EI, scaled): need to do it on the q-model so the Face-3 map matches Lemma 1.
\\ We work on the rational q-model E: y^2 = x(x+1)(x+q^2), q rational.
\\ Recovery: c(P) = 2*y*q/(q^2 - x^2);  F3 = c^2 + 1 + q^2;  PCP candidate iff issquare(F3) & non-torsion.

default(parisize,800000000);
default(parisizemax,1200000000);

\\ build the q-model curve and verify F6 = square along the locus
print("=== Exact-square locus F6=k^2 : structural + rank + Face3 ===");
print("(s,t) | (m,n) | q=a/b | F6=(m+n)^2-2n^2 | cond | torsion | rank_lo rank_hi | jflag");

scan(stmax, tmax) = {
  my(cnt=0);
  for(t=1,tmax,
    for(s=1,stmax,
      if(gcd(s,t)!=1, next);
      my(m = s^2-2*s*t+2*t^2, n = 2*s*t);
      if(gcd(m,n)!=1, next);          \\ primitivity of (m,n)
      if((m+n)%2==0, next);           \\ m+n odd
      if(m<=n || n<=0, next);
      my(a = m^2-n^2, b = 2*m*n);
      if(a<=0, next);
      my(F6 = (m+n)^2 - 2*n^2, F5=(m-n)^2-2*n^2);
      \\ verify F6 is a perfect square
      my(sqflag = issquare(F6));
      \\ build E_PCP over Q with q = a/b
      my(q = a/b);
      \\ rational model: y^2 = x^3 + (1+q^2)x^2 + q^2 x
      my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
      my(Em = ellminimalmodel(E));
      my(N = ellglobalred(Em)[1]);
      my(tor = elltors(Em)[1]);
      my(jq = E.j);
      \\ rank bounds (bounded effort to stay fast/safe)
      my(rk = [-1,-1]);
      iferr(rk = ellrank(Em, 1), e, rk=[-1,-1]);
      print(s," ",t," | (",m,",",n,") | ",a,"/",b," | F6=",F6," sq=",sqflag," F5=",F5,
            " | N=",N," | tor=",tor," | rk=[",rk[1],",",rk[2],"] | j-num-fac:");
      cnt++;
      if(cnt>=14, return(0));
    )
  );
}
scan(40, 3);

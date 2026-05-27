\\ Fast rank census on exact-square locus. ellrank only (bounded), no ellisomat/analytic.
\\ Structural facts already established (s=5,7,9,11,13): #iso class = 6, torsion = Z/4 x Z/2 (order 8).
\\ Here: rank distribution + 2-descent (ellrank) over more fibers, with iferr/SKIP for slow ones.

default(parisize,800000000);
default(parisizemax,1200000000);

print("=== Fast rank census on exact-square locus (ellrank bounded) ===");
print("(s,t) | q=a/b | rank_lo | rank_hi | torsion | 2-isog deg structure");

\\ E_PCP has full rational 2-torsion (roots 0,-1,-q^2) => guaranteed >=3 two-isogenies; iso class 6.
census(stmax,tmax) = {
  my(cnt=0, tally=vector(5,i,0), amb=0);
  for(t=1,tmax,
    for(s=t+1,stmax,
      if(gcd(s,t)!=1, next);
      my(m = s^2-2*s*t+2*t^2, n = 2*s*t);
      if(gcd(m,n)!=1, next);
      if((m+n)%2==0, next);
      if(m<=n, next);
      my(a = m^2-n^2, b = 2*m*n);
      if(a==0, next);
      my(q = a/b);
      my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
      my(Em = ellminimalmodel(E));
      my(tor = elltors(Em)[1]);
      my(rl=-1,ru=-1,rr);
      iferr(rr=ellrank(Em,2); rl=rr[1]; ru=rr[2], e, rl=-1;ru=-1);
      print("(",s,",",t,") | ",a,"/",b," | rk=[",rl,",",ru,"] | tor=",tor);
      if(rl==ru && rl>=0 && rl<=3, tally[rl+1]++, amb++);
      cnt++;
      if(cnt>=22, break(2));
    )
  );
  print("--- determined-rank tally over ",cnt," fibers: ");
  print("    r=0:",tally[1]," r=1:",tally[2]," r=2:",tally[3]," r=3:",tally[4]," ambiguous:",amb);
}
census(50, 4);

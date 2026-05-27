default(parisize,1000000000);
\\ Examine the extreme-pole fibers to understand sigma. Why does sigma stay <4.3 even when one
\\ prime has pole order 20-24?
examine(m,n)={
  my(q,E,Dmin,N,sig,fa,s);
  q=(m^2-n^2)/(2*m*n);
  E=ellminimalmodel(ellinit([0,1+q^2,0,q^2,0]));
  Dmin=abs(E.disc); N=ellglobalred(E)[1];
  sig=log(Dmin*1.0)/log(N*1.0);
  print("(m,n)=(",m,",",n,")  q=",q);
  print("  log|Dmin|=",log(Dmin*1.0),"  log N=",log(N*1.0),"  sigma=",sig);
  fa=factor(N);
  s="  bad primes (p: n_p=v_p(Dmin), contributes n_p*log p to numer, log p to denom): ";
  for(i=1,matsize(fa)[1], my(p=fa[i,1]); s=concat(s,Strprintf("[%d:n_p=%d] ",p,valuation(Dmin,p))));
  print(s);
};
examine(122,121);
examine(128,1);
examine(56,25);   \\ the worst-sigma fiber
\\ Now: SEARCH specifically for fibers designed to maximize sigma: those where N has FEW primes
\\ but Delta has high power. The worst case for sigma is when ONE prime dominates: q with
\\ u,v,(u-v),(u+v) being prime powers. Test "extreme" families: n=1, m=2^k (so q=(m^2-1)/(2m)).
print("=== n=1, m=2^k family (concentrate at p=2) ===");
for(k=1,12, my(m=2^k,n=1); if((m+n)%2==1, examine(m,n)));
print("=== try to push sigma high: search m<=400 for max sigma ===");
worst=0.0; mnw=[0,0];
{
for(m=2,400,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(q=(m^2-n^2)/(2*m*n), E, Dmin, N, sig);
      E=ellminimalmodel(ellinit([0,1+q^2,0,q^2,0]));
      Dmin=abs(E.disc); N=ellglobalred(E)[1];
      sig=log(Dmin*1.0)/log(N*1.0);
      if(sig>worst, worst=sig; mnw=[m,n]);
    );
  );
);
}
print("WORST sigma over m<=400: ", worst, " at (m,n)=", mnw);

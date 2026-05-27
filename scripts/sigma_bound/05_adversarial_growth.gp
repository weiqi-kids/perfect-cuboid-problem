default(parisize,600000000);
default(parisizemax,1000000000);
\\ Adversarial search for large sigma: fibers where a,b,(a^2-b^2) are smooth / prime-power-like,
\\ which minimizes rad(N) relative to Delta. Also examine the (256,121) outlier and 2-power families.
sigfib(m,n)={
  my(a=m^2-n^2, b=2*m*n);
  my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
  my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
  log(Dmin*1.0)/log(N*1.0);
};
examine(m,n)={
  my(a=m^2-n^2, b=2*m*n);
  my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
  my(Dmin=abs(E.disc), N=ellglobalred(E)[1], sig=log(Dmin*1.0)/log(N*1.0));
  print("(m,n)=(",m,",",n,") a=",a," b=",b," a^2-b^2=",a^2-b^2);
  print("  factor(a)=",factor(a)[,1]~,"  factor(b)=",factor(b)[,1]~,"  factor(|a^2-b^2|)=",factor(abs(a^2-b^2))[,1]~);
  print("  log|Dmin|=",log(Dmin*1.0)," logN=",log(N*1.0)," SIGMA=",sig);
  my(fa=factor(N)); my(s="  bad primes [p:n_p]: ");
  for(i=1,matsize(fa)[1], s=concat(s,Strprintf("[%d:%d] ",fa[i,1],valuation(Dmin,fa[i,1]))));
  print(s);
};
print("=== outlier (256,121) ===");
examine(256,121);
print("=== other top fibers ===");
examine(128,121); examine(56,25); examine(64,63);
print("");
print("=== 13-smooth adversarial search m<=3000 ===");
ws=0.0; mns=[0,0];
{
for(m=2,3000,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n, prod=abs(a*b*(a^2-b^2)), sm=1, ff=factor(prod)[,1]);
      for(i=1,#ff, if(ff[i]>13, sm=0; break));
      if(sm,
        my(sig=iferr(sigfib(m,n),ERR,-1.0));
        if(sig>ws, ws=sig; mns=[m,n]);
      );
    );
  );
);
}
print("WORST sigma among 13-smooth fibers (m<=3000): ", ws, " at ", mns);
if(mns[1]>0, examine(mns[1],mns[2]));
print("");
print("=== log-log growth fit: sigma_max(M) vs log M ===");
\\ Compute sigma_max for M = 2^k cumulative, fit sigma_max ~ A + B*log(log(M))? and ~ A+B*log M?
\\ We already have band data; recompute cumulative max at M=50,100,200,400,800 with finer detail.
cummax(M)={my(s=0.0); for(m=2,M, for(n=1,m-1, if(gcd(m,n)==1&&(m+n)%2==1, my(x=iferr(sigfib(m,n),ERR,-1.0)); if(x>s,s=x)))); s};
for(k=4,9, my(M=2^k); my(s=cummax(M)); print("  M=",M,"  sigma_max=",s,"  log M=",log(M*1.0),"  loglog M=",log(log(M*1.0))));

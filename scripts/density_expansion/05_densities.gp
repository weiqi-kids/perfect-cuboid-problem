default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 05_densities.gp -- EMPIRICAL DENSITIES of {sigma<=sigma_0} among Pythagorean (m,n).
\\ Also: density of {squarefree locus} for comparison (~0.43); density of {theta<=delta}
\\ (powerful-part-exponent locus). Confirm density({sigma<=sigma0}) -> 1 as sigma0 grows.
\\ ============================================================================
oddpart(x)= x >> valuation(x,2);
radn(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, r*=f[i,1]); r};
powpart(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, if(f[i,2]>=2, r*=f[i,1]^f[i,2])); r};

run(MMAX)=
{
  my(cnt=0, sfcnt=0);
  my(thr=[3.5,4.0,4.5,5.0], nthr=4);
  my(sigle=vector(nthr,i,0));
  \\ also: powerful-part exponent theta histogram and Pow(P)<=P^eps for small eps
  my(epslist=[0.05,0.10,0.15,0.20], neps=4);
  my(powle=vector(neps,i,0));
  my(thmax=0.0);
  for(m=2,MMAX,
    for(n=1,m-1,
      if(gcd(m,n)==1 && (m+n)%2==1,
        my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2),P=a*b*c);
        my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
        my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
        my(sig=log(Dmin*1.0)/log(N*1.0));
        cnt++;
        for(j=1,nthr, if(sig<=thr[j]+1e-12, sigle[j]++));
        \\ squarefree locus
        if(issquarefree(a)&&issquarefree(oddpart(b))&&issquarefree(c), sfcnt++);
        \\ powerful-part exponent
        my(pw=powpart(P), th=log(pw*1.0)/log(P*1.0));
        if(th>thmax,thmax=th);
        for(j=1,neps, if(th<=epslist[j]+1e-12, powle[j]++));
      )
    )
  );
  print("=== MMAX=",MMAX,"  Pythagorean fibers = ",cnt," ===");
  print("  squarefree-locus density = ",sfcnt*1.0/cnt);
  print("  density{sigma<=sigma0}:");
  for(j=1,nthr, print("     sigma0=",thr[j],"  density=",sigle[j]*1.0/cnt));
  print("  density{powerful exponent theta<=eps}  (theta=logPow(P)/logP, max theta=",thmax,"):");
  for(j=1,neps, print("     eps=",epslist[j],"  density=",powle[j]*1.0/cnt));
  print("");
}
run(150);
run(400);
run(700);
print("EXIT=ok");
quit;

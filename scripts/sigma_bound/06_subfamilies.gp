default(parisize,600000000);
default(parisizemax,1000000000);
\\ Step 5: sub-families. Look for sub-families with PROVABLY bounded sigma unconditionally.
sigfib(m,n)={
  my(a=m^2-n^2, b=2*m*n);
  my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
  my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
  log(Dmin*1.0)/log(N*1.0);
};
\\ The numerator of sigma = 4 log a + 4 log b + 2 log|a^2-b^2| (minus 2-adic corr 12 log2).
\\ Exactly: log|Delta_min| = 4 log a + 4 log b + 2 log|a^2-b^2| + log16 - 12 log2.
\\ Denominator = log N = log rad(a b (a^2-b^2)) [- log2 if 2 good].
\\
\\ A sub-family has BOUNDED sigma iff rad(a b (a^2-b^2)) >> (a b (a^2-b^2))^{1/C} unconditionally,
\\ i.e. the product is "powerful-free enough". This needs an elementary lower bound on the radical.
\\
\\ SUB-FAMILY 1: n=1 (a=m^2-1=(m-1)(m+1), b=2m, a^2-b^2=m^4-6m^2+1).
print("=== Sub-family n=1: a=m^2-1, b=2m ===");
s1=0.0; m1=0;
{for(m=2,3000, if((m+1)%2==1, my(sig=iferr(sigfib(m,1),ERR,-1.0)); if(sig>s1,s1=sig;m1=m)));}
print("  max sigma (n=1, m<=3000): ",s1," at m=",m1);
\\ SUB-FAMILY 2: m=n+1 (consecutive). a=2n+1, b=2n(n+1).
print("=== Sub-family m=n+1: a=2n+1, b=2n(n+1) ===");
s2=0.0; n2=0;
{for(n=1,3000, my(m=n+1); if(gcd(m,n)==1&&(m+n)%2==1, my(sig=iferr(sigfib(m,n),ERR,-1.0)); if(sig>s2,s2=sig;n2=n)));}
print("  max sigma (m=n+1, n<=3000): ",s2," at n=",n2);
\\ SUB-FAMILY 3: SQUAREFREE part. fibers where a,b,(a^2-b^2) are each SQUAREFREE.
\\ Then Delta_min = squarefree^small powers? n_p small. Test sigma.
print("=== Sub-family: a,b/2-power,(a^2-b^2) squarefree ===");
s3=0.0; mn3=[0,0]; cnt3=0;
{for(m=2,400, for(n=1,m-1, if(gcd(m,n)==1&&(m+n)%2==1,
   my(a=m^2-n^2, b=2*m*n, c=abs(a^2-b^2));
   if(issquarefree(a)&&issquarefree(c)&&issquarefree(b/2^valuation(b,2)),
     cnt3++; my(sig=iferr(sigfib(m,n),ERR,-1.0)); if(sig>s3,s3=sig;mn3=[m,n])))));}
print("  max sigma (a,c sqfree, odd-part b sqfree; m<=400): ",s3," at ",mn3," (",cnt3," fibers)");
print("  THEORY: if a,b,c=a^2-b^2 all squarefree (odd part), each n_p in {2,4} bounded.");
print("  Then log|Dmin| <= 4 log a+4 log b+2 log c, log N=log(abc/...)~log a+log b+log c roughly.");
print("  But ratio still ~ up to 4: NOT obviously <= small const without rad lower bound.");
print("");
\\ The 2-adic concentration: examine sigma as function of v_2(b). The worst fibers have large 2-power.
print("=== sigma vs v_2(b): does large 2-power drive sigma up? ===");
{for(k=1,9, my(bestsig=0.0,bestmn=[0,0]);
  for(m=2,500, for(n=1,m-1, if(gcd(m,n)==1&&(m+n)%2==1 && valuation(2*m*n,2)==k,
     my(sig=iferr(sigfib(m,n),ERR,-1.0)); if(sig>bestsig,bestsig=sig;bestmn=[m,n]))));
  if(bestmn[1]>0, print("  v_2(b)=",k,": max sigma=",bestsig," at ",bestmn)));}

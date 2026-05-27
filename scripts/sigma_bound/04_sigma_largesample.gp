default(parisize,600000000);
default(parisizemax,1000000000);
\\ Step 3: large-sample EXACT sigma over Pythagorean fibers.
\\ sigma = log|Delta_min| / log N. Track max, argmax, growth vs log m, distribution.
\\ Use integral model E: Y^2=X(X+b^2)(X+a^2), a=m^2-n^2,b=2mn. Catch OOM with iferr -> skip.

sigfib(m,n)={
  my(a=m^2-n^2, b=2*m*n);
  my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
  my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
  log(Dmin*1.0)/log(N*1.0);
};
MMAX = 800;          \\ push as high as budget allows; adjust if slow
smax=0.0; mn_smax=[0,0]; smin=100.0; mn_smin=[0,0];
sumsig=0.0; cnt=0; skipped=0;
\\ growth tracking: max sigma in each m-decade band
bandmax=vector(20);  \\ band index = floor(log2(m))
\\ distribution buckets of sigma (width 0.25)
dist=vector(40);
\\ also track sigma_max as function of m (record running max per m)
runmaxfile=List();
{
for(m=2,MMAX,
  my(localmax=0.0);
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(res=iferr(sigfib(m,n), ERR, -1.0));
      if(res<0, skipped++,
        my(sig=res);
        cnt++; sumsig+=sig;
        if(sig>smax, smax=sig; mn_smax=[m,n]);
        if(sig<smin, smin=sig; mn_smin=[m,n]);
        if(sig>localmax, localmax=sig);
        my(bi=floor(log(m)/log(2))); if(bi>=1&&bi<=20 && sig>bandmax[bi], bandmax[bi]=sig);
        my(di=floor(sig/0.25)+1); if(di>=1&&di<=40, dist[di]++);
      );
    );
  );
  if(m%100==0, listput(runmaxfile,[m,smax]));
);
}
print("MMAX=",MMAX,"  FIBERS=",cnt,"  SKIPPED=",skipped);
print("SIGMA_MAX = ", smax, " at (m,n)=", mn_smax);
print("SIGMA_MIN = ", smin, " at (m,n)=", mn_smin);
print("SIGMA_MEAN = ", sumsig/cnt);
print("");
print("Max sigma per dyadic band (m in [2^k,2^{k+1})):");
for(k=1,20, if(bandmax[k]>0, print("  m~2^",k," (",2^k,"-",2^(k+1)-1,"): sigma_max=",bandmax[k])));
print("");
print("Running sigma_max at m=100,200,...:");
for(i=1,#runmaxfile, print("  m<=",runmaxfile[i][1],": sigma_max=",runmaxfile[i][2]));
print("");
print("Sigma distribution (bucket width 0.25):");
for(k=1,40, if(dist[k]>0, print("  [",(k-1)*0.25,",",k*0.25,"): ",dist[k])));

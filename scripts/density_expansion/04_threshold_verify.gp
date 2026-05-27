default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 04_threshold_verify.gp -- VERIFY the powerful-part sufficient condition empirically.
\\ Claim (worst-case uniform): Pow(P) <= P^{(sigma0-4)/sigma0}  ==>  sigma <= sigma0.
\\ Also test the SHARPER per-fiber exact condition and the generic delta.
\\ For each fiber compute: sigma, Pow(P), P, the exponent log Pow / log P =: theta(fiber).
\\ Then: does {theta <= delta_w(sigma0)} imply {sigma<=sigma0}?  (one-directional sufficiency)
\\ ============================================================================
radn(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, r*=f[i,1]); r};
powpart(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, if(f[i,2]>=2, r*=f[i,1]^f[i,2])); r};

print("=== Sufficiency test: Pow(P)<=P^delta_w(sigma0) ==> sigma<=sigma0 ? ===");
print("    (count fibers where theta<=delta_w but sigma>sigma0 == FALSE POSITIVES; must be 0)");
{
my(MMAX=300);
\\ collect per-fiber (sigma, theta=logPow/logP)
my(data=List());
for(m=2,MMAX,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2),P=a*b*c);
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
      my(sig=log(Dmin*1.0)/log(N*1.0));
      my(pw=powpart(P), theta=log(pw*1.0)/log(P*1.0));
      listput(data,[sig,theta,m,n]);
    )
  )
);
print("  fibers = ",#data);
for(i=1,5,
  my(s0=[4.0,4.5,5.0,5.5,6.0][i]);
  my(dw=(s0-4)/s0, dg=(s0-3)/s0);
  my(fp_w=0, fp_g=0, n_w=0, n_g=0, maxsig_w=0.0, maxsig_g=0.0);
  for(j=1,#data,
    my(sig=data[j][1], th=data[j][2]);
    if(th<=dw+1e-12, n_w++; if(sig>maxsig_w,maxsig_w=sig); if(sig>s0+1e-9, fp_w++));
    if(th<=dg+1e-12, n_g++; if(sig>maxsig_g,maxsig_g=sig); if(sig>s0+1e-9, fp_g++));
  );
  print("  sigma0=",s0,":");
  print("     delta_w=",dw,"  #{theta<=dw}=",n_w,"  max sigma there=",maxsig_w,"  FALSE POS=",fp_w);
  print("     delta_g=",dg,"  #{theta<=dg}=",n_g,"  max sigma there=",maxsig_g,"  FALSE POS=",fp_g);
);
}
print("");
print("INTERPRETATION: delta_w is the RIGOROUS uniform threshold (0 false positives required).");
print("delta_g is the generic/optimistic one (may have rare false positives on thin c-small fibers).");
quit;

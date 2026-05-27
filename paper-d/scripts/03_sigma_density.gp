/* Paper P4 -- script 03  (PARI/GP 2.15.4)
   sigma large-sample statistics and the density of {sigma <= sigma0}.
   Uses the exact sigma formula sigma = (4loga+4logb+2log|c|-8log2)/log N,
   N = rad(a*b*c) up to the single factor 2 (good when v2(b)=2). */
default(parisize, 8*10^8);
default(parisizemax, 1200000000);

/* radical of n */
rad(n) = factorback(factor(n)[,1]);

/* exact conductor N: rad(a*b*(a^2-b^2)) but 2 is good when v2(b)=2.
   NB: a^2-b^2 may be negative; take abs before factoring (rad keeps no sign). */
condN(a,b,c) = { my(P=abs(a*b*c), R=rad(P)); if(valuation(b,2)==2, R/=2); R; }

sig(m,n) = {
  my(a=m^2-n^2, b=2*m*n, c=a^2-b^2);
  my(D=4*log(a*1.0)+4*log(b*1.0)+2*log(abs(c)*1.0)-8*log(2.0), N=condN(a,b,c));
  D/log(N*1.0);
}

print("=== large-sample sigma statistics ===");
{
  my(MM=800, cnt=0, smax=0.0, arg=[0,0], smin=10.0, ssum=0.0);
  for(m=2,MM,
    for(n=1,m-1,
      if(gcd(m,n)!=1 || (m+n)%2==0, next);
      my(s=sig(m,n));
      if(s>smax, smax=s; arg=[m,n]);
      if(s<smin, smin=s);
      ssum+=s; cnt++;
    );
  );
  print("fibers (m<=", MM, ") = ", cnt);
  print("sigma_max = ", smax, " at (m,n)=", arg);
  print("sigma_min = ", smin);
  print("sigma_mean = ", ssum/cnt);
}

print("");
print("=== density of {sigma <= sigma0} vs squarefree-locus density ===");
{
  my(sig0s=[3.5,4.0,4.5,5.0]);
  foreach([150,400,700], MM,
    my(cnt=0, le=vector(#sig0s), sf=0);
    for(m=2,MM,
      for(n=1,m-1,
        if(gcd(m,n)!=1 || (m+n)%2==0, next);
        my(a=m^2-n^2, b=2*m*n, c=a^2-b^2, s=sig(m,n));
        cnt++;
        for(i=1,#sig0s, if(s<=sig0s[i], le[i]++));
        /* squarefree locus: a, oddpart(b), |c| all squarefree */
        my(ob=b/2^valuation(b,2));
        if(issquarefree(a) && issquarefree(ob) && issquarefree(abs(c)), sf++);
      );
    );
    print("MMAX=", MM, "  fibers=", cnt);
    for(i=1,#sig0s, print("   density{sigma<=", sig0s[i], "} = ", le[i]*1.0/cnt));
    print("   squarefree-locus density = ", sf*1.0/cnt);
  );
}
print("EXIT=ok");

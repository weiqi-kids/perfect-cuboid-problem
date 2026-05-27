default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 08_smallest_sigma0.gp -- the SMALLEST sigma_0 for which the sieve gives density 1.
\\
\\ The sieve (Greaves/Browning/Ekedahl) gives: for any eta>0, Pow(P)<=P^eta on density 1,
\\ where P=ab(a^2-b^2) ~ H^8.  I.e. theta := logPow(P)/logP -> 0 on a density-1 set.
\\
\\ Threshold (script 02/03/04):  theta <= delta(sigma_0) ==> sigma<=sigma_0, where
\\   RIGOROUS worst-case:  delta_w(sigma_0) = (sigma_0-4)/sigma_0   (uses log(ab)<=L)
\\   GENERIC:              delta_g(sigma_0) = (sigma_0-3)/sigma_0   (uses log(ab)~L/2)
\\ As eta->0 the sieve forces theta->0, so ANY sigma_0 with delta_w(sigma_0)>0 works on density 1,
\\ i.e. sigma_0 > 4 (rigorous).  GENERIC: sigma_0 > 3.  The squarefree locus is theta=0 exactly
\\ (sigma<=4) but density only 0.43; the sieve relaxes theta=0 to theta->0 => density 1 at sigma_0=4+eps.
\\
\\ So the smallest PROVABLE sigma_0 (density 1, rigorous uniform threshold) is sigma_0 = 4 (open
\\ endpoint: sigma_0=4+ for any +). Empirically confirm: density{sigma<=4+small} -> 1 and the
\\ residual {sigma>4} fraction -> 0 at a polynomial rate (consistent with O(H^{-delta})).
\\ ============================================================================

\\ Confirm: residual fraction {sigma>sigma0} vanishes; fit decay vs H.
print("=== residual fraction {sigma>sigma0} vs H (rate of -> 0) ===");
run(H, sigma0)=
{
  my(cnt=0, big=0);
  for(m=2,H,
    for(n=1,m-1,
      if(gcd(m,n)==1 && (m+n)%2==1,
        my(a=m^2-n^2,b=2*m*n);
        my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
        my(sig=log(abs(E.disc)*1.0)/log(ellglobalred(E)[1]*1.0));
        cnt++; if(sig>sigma0+1e-12, big++);
      )
    )
  );
  [cnt, big, big*1.0/cnt];
}
{
my(s0v=[3.5,4.0,4.5], Hv=[100,200,400,700]);
for(si=1,#s0v,
  my(s0=s0v[si]);
  print("  sigma0=",s0,":");
  for(hi=1,#Hv,
    my(H=Hv[hi]);
    my(r=run(H,s0));
    print("     H=",H,"  frac{sigma>",s0,"}=",r[3],"  (count ",r[2],"/",r[1],")");
  );
);
}
print("");
print("CONCLUSION: rigorous-worst-case smallest sigma_0 for density-1 sieve closure = 4 (open).");
print("            generic threshold gives sigma_0 -> 3+, but rigorous uniform bound needs 4+.");
print("EXIT=ok");
quit;

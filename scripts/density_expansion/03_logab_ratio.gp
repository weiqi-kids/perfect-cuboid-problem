default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 03_logab_ratio.gp -- pin the supremum of log(ab)/L over the family, to make
\\ the threshold (*) into a UNIFORM powerful-part condition.
\\
\\ log(ab)=L - log c, so log(ab)/L = 1 - log c / L.  sup log(ab)/L = 1 - inf(log c/L).
\\ c = |a^2-b^2| = |(m^2-2mn-n^2)(m^2+2mn-n^2)|.  c is SMALL when a~b, i.e. m^2-n^2 ~ 2mn,
\\   i.e. n/m ~ sqrt(2)-1 ~ 0.4142 (then a^2-b^2 -> 0 relatively). Track where log c/L is min.
\\ ============================================================================
radn(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, r*=f[i,1]); r};

print("=== sup log(ab)/L and where; scan to large m near n/m=sqrt(2)-1 ===");
{
my(MMAX=2000);
my(rmax=0.0, mn=[0,0], rmin=9.9, mnmin=[0,0]);
for(m=2,MMAX,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2));
      if(c==0, next);
      my(L=log(a*b*c*1.0), r=log(a*b*1.0)/log(a*b*c*1.0));
      if(r>rmax,rmax=r;mn=[m,n]);
      if(r<rmin,rmin=r;mnmin=[m,n]);
    )
  )
);
print("  max log(ab)/L = ",rmax," at (m,n)=",mn,"  n/m=",mn[2]*1.0/mn[1]);
print("  min log(ab)/L = ",rmin," at (m,n)=",mnmin);
print("  sqrt(2)-1 = ",sqrt(2)-1);
}
print("");
\\ The max of log(ab)/L is when c is smallest relative to ab; c->0 makes log c -> -inf so
\\ ratio ->1, BUT c is an integer >=1 and the family is discrete. As m grows with n/m->sqrt2-1
\\ along a good rational approximation, c can be << ab, pushing log(ab)/L toward 1.
\\ So sup log(ab)/L = 1 (not attained, approached on a thin set). This means the WORST-CASE
\\ uniform threshold must use log(ab) <= L, i.e. the crude bound. BUT those thin c-small fibers
\\ have LARGER sigma anyway. The honest uniform statement: see derivation below.

\\ Let us directly compute: for each fiber, the EXACT condition's RHS coefficient on L:
\\  RHS/L = [(sigma0-2) - 2 log(ab)/L + 8log2/L]/sigma0. As L->inf, ->[(sigma0-2)-2*(log(ab)/L)]/sigma0.
\\ With log(ab)/L in [~0.43,~0.65,->1], the L-coefficient of RHS ranges. The SAFE (uniform over
\\ ALL fibers incl thin) sufficient condition uses log(ab)<=L:
\\   RHS >= [(sigma0-2)L - 2L + 8log2]/sigma0 = [(sigma0-4)L+8log2]/sigma0.
\\ So G <= ((sigma0-4)/sigma0) L  ==> sigma<=sigma0  UNIFORMLY (for sigma0>=4; trivial else).
\\ i.e. Pow(P) <= P^{(sigma0-4)/sigma0}.   <-- WORST-CASE uniform threshold delta_w=(s0-4)/s0.
\\ GENERIC (log(ab)/L=1/2): delta_g=(s0-3)/s0.
print("=== threshold deltas: Pow(P) <= P^delta ==> sigma<=sigma0 ===");
print("  WORST-CASE uniform (log ab<=L):  delta_w(sigma0) = (sigma0-4)/sigma0");
print("  GENERIC (log ab ~ L/2):          delta_g(sigma0) = (sigma0-3)/sigma0");
for(i=1,5,my(s=[4.0,4.5,5.0,5.5,6.0][i]); print("  sigma0=",s,"  delta_w=",(s-4)/s,"  delta_g=",(s-3)/s));
print("");
quit;

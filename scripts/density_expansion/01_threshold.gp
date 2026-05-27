default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 01_threshold.gp -- DERIVE & VERIFY the powerful-part sufficient condition for
\\ sigma <= sigma_0.  E_PCP(q): integral model Y^2=X(X+b^2)(X+a^2), a=m^2-n^2, b=2mn.
\\
\\ EXACT (proven, SIGMA-BOUND-FAMILY.md):
\\   log|Delta_min| = 4 log a + 4 log b + 2 log|a^2-b^2| - 8 log 2
\\   N = rad( a * b * (a^2-b^2) )  (up to a single factor 2 when v2(b)=2)
\\   sigma = log|Delta_min| / log N
\\
\\ Let P = a*b*(a^2-b^2),  L = log P,  R = log N = log rad(P).
\\ Define the RADICAL GAP  G := L - R = log( P / rad(P) ) = sum_p (v_p(P)-1) log p >= 0.
\\ Note rad(P)=rad(Pow(P))*<squarefree primes>, and G = log( Pow(P)/rad(Pow(P)) ),
\\ i.e. G depends ONLY on the powerful part of P. G <= log Pow(P).
\\
\\ Also let D := log|Delta_min|.  We have (exact):
\\   D = 4 log a + 4 log b + 2 log c - 8log2     (c=|a^2-b^2|)
\\     = 2 log P + 2 log(a b) - 8 log2           (since 4la+4lb+2lc = 2(la+lb+lc)+2(la+lb))
\\ where log P = la+lb+lc.
\\ So D = 2L + 2 log(ab) - 8log2.
\\ And R = L - G.
\\ Hence sigma = D/R = (2L + 2log(ab) - 8log2)/(L - G).
\\
\\ We want to find threshold on G (equiv on Pow part) giving sigma<=sigma_0.
\\ ============================================================================

\\ Verify the algebraic identities on a sample, and tabulate G, Pow(P), sigma.
oddpart(x)= x >> valuation(x,2);
powpart(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, if(f[i,2]>=2, r*=f[i,1]^f[i,2])); r};
radn(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, r*=f[i,1]); r};

print("=== Verify D = 2L + 2log(ab) - 8log2 and N=rad(P) (mod factor 2) ===");
maxerrD=0.0; maxerrN=0; bad2=0; cnt=0;
{
for(m=2,80,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2));
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
      my(L=log(a*b*c*1.0), Dlog=log(Dmin*1.0));
      my(Dpred=2*L+2*log(a*b*1.0)-8*log(2));
      my(eD=abs(Dlog-Dpred)); if(eD>maxerrD,maxerrD=eD);
      \\ N vs rad(P): allowed to differ by factor 2
      my(P=a*b*c, radP=radn(P));
      my(ratio=N/radP);  \\ should be 1 or 1/2 or 2
      if(!(ratio==1||ratio*2==1||ratio==2), maxerrN=1; if(bad2<5,print("  N!=radP mod2 at ",[m,n]," N=",N," radP=",radP)));
      cnt++;
    )
  )
);
}
print("  fibers checked = ",cnt);
print("  max |log Dmin - (2L+2log(ab)-8log2)| = ",maxerrD,"   (should be ~0; the -8log2 is exact 2-adic)");
print("  N differs from rad(P) by more than factor 2 anywhere? ",if(maxerrN,"YES (PROBLEM)","no (always 1 or 2)"));
print("");

\\ NOTE: the residual maxerrD is the 2-adic discrepancy. The EXACT statement uses
\\ D = 4log a + 4 log(b) + 2 log c - 8log2 with b the FULL b=2mn. Let's check that exact one:
print("=== Verify EXACT D = 4 log a + 4 log b + 2 log c - 8 log2 ===");
maxerrD2=0.0;
{
for(m=2,80,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2));
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc));
      my(Dpred=4*log(a*1.0)+4*log(b*1.0)+2*log(c*1.0)-8*log(2));
      my(eD=abs(log(Dmin*1.0)-Dpred)); if(eD>maxerrD2,maxerrD2=eD);
    )
  )
);
}
print("  max |log Dmin - (4loga+4logb+2logc-8log2)| = ",maxerrD2);
print("");
quit;

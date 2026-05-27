default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 02_threshold_derive.gp -- the EXACT threshold on the radical gap G.
\\
\\ sigma = D/R, D = 2L + 2log(ab) - 8log2, R = L - G,  G = log(P/rad P) = log(Pow/radPow).
\\ sigma <= sigma_0
\\   <=> D <= sigma_0 * R
\\   <=> 2L + 2log(ab) - 8log2 <= sigma_0 (L - G)
\\   <=> sigma_0 * G <= sigma_0 L - 2L - 2log(ab) + 8log2
\\   <=> sigma_0 * G <= (sigma_0 - 2) L - 2 log(ab) + 8 log2
\\   <=> G <= [ (sigma_0 - 2) L - 2 log(ab) + 8 log2 ] / sigma_0.    (*)
\\
\\ This is the EXACT sufficient (and necessary, given the exact formula) condition.
\\ Now make the RHS uniform. We need a lower bound on the RHS in terms of L (=log P).
\\ Sizes: a=m^2-n^2 < m^2, b=2mn <= m^2, so ab <= m^4 and (since a,b>=... ) log(ab) <= 4 log m.
\\ Also c=|a^2-b^2| <= max(a,b)^2 <= m^4, and P=abc, with P >= ... .  Key: log(ab) vs L.
\\ We have L = log a + log b + log c.  And the "trivial" sizes:
\\   c = |a^2-b^2| = |(a-b)(a+b)|; a+b<=2m^2, |a-b| can be small.
\\ Asymptotically (generic m,n with n ~ t*m): a~m^2(1-t^2), b~2tm^2, c~m^4*|(1-t^2)^2-4t^2|,
\\   so log a ~ 2 log m, log b ~ 2 log m, log c ~ 4 log m, L ~ 8 log m, log(ab) ~ 4 log m = L/2.
\\ Thus log(ab) ~ L/2 generically.  Plug into (*):
\\   RHS ~ [ (sigma_0-2) L - 2*(L/2) + 8log2 ] / sigma_0 = [ (sigma_0-3) L + 8log2 ]/sigma_0.
\\ So GENERICALLY  sigma<=sigma_0  <=>  G <= ((sigma_0-3)/sigma_0) * L + O(1).
\\ Since G = log Pow(P)/rad-stuff <= log Pow(P), a SUFFICIENT condition is:
\\   log Pow(P) <= ((sigma_0-3)/sigma_0) * L,  i.e. Pow(P) <= P^{(sigma_0-3)/sigma_0}. (**)
\\ Equivalently the powerful part is at most P^{delta}, delta(sigma_0) = (sigma_0-3)/sigma_0.
\\
\\ ROUGHEST uniform bound (no genericity): log(ab) <= L always? NO. But log(ab)<= (2/3)L? Check.
\\ Actually we want a LOWER bound on RHS, i.e. an UPPER bound on log(ab) relative to L.
\\ log(ab)=log a+log b, L=log a+log b+log c. So log(ab) = L - log c. Need lower bound on log c.
\\ ============================================================================

oddpart(x)= x >> valuation(x,2);
radn(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, r*=f[i,1]); r};
powpart(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, if(f[i,2]>=2, r*=f[i,1]^f[i,2])); r};

\\ Empirically check: (1) the exact condition (*) reproduces sigma<=sigma_0 exactly.
\\ (2) the ratios log(ab)/L and log c/L  -- to pin delta(sigma_0).
print("=== ratios log(ab)/L, log(c)/L over Pythagorean fibers (m<=200) ===");
{
my(MMAX=200);
my(abLmin=9.9,abLmax=0.0,cLmin=9.9,cLmax=0.0,abLsum=0.0,cnt=0);
for(m=2,MMAX,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2));
      my(L=log(a*b*c*1.0), lab=log(a*b*1.0), lc=log(c*1.0));
      my(rab=lab/L, rc=lc/L);
      if(rab<abLmin,abLmin=rab); if(rab>abLmax,abLmax=rab);
      if(rc<cLmin,cLmin=rc); if(rc>cLmax,cLmax=rc);
      abLsum+=rab; cnt++;
    )
  )
);
print("  log(ab)/L : min=",abLmin,"  max=",abLmax,"  mean=",abLsum/cnt);
print("  log(c)/L  : min=",cLmin,"  max=",cLmax);
print("  (generic ~ 1/2 each; max log(ab)/L approaches what bound?)");
}
print("");

\\ Verify the EXACT condition (*) reproduces sigma<=sigma_0 exactly (no false pos/neg).
print("=== exact-condition check: G<=RHS(sigma0) <=> sigma<=sigma0 ? ===");
{
my(MMAX=120);
for(s0i=1,4,
  my(sigma0=[3.5,4.0,4.5,5.0][s0i]);
  my(mism=0,cnt=0);
  for(m=2,MMAX,
    for(n=1,m-1,
      if(gcd(m,n)==1 && (m+n)%2==1,
        my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2),P=a*b*c);
        my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
        my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
        my(sig=log(Dmin*1.0)/log(N*1.0));
        my(L=log(P*1.0), G=log(P*1.0)-log(radn(P)*1.0));
        my(RHS=((sigma0-2)*L - 2*log(a*b*1.0) + 8*log(2))/sigma0);
        my(cond=(G<=RHS+1e-12));
        my(truth=(sig<=sigma0+1e-12));
        if(cond!=truth, mism++);
        cnt++;
      )
    )
  );
  print("  sigma0=",sigma0,"  mismatches=",mism," / ",cnt," fibers  (0 = exact identity holds)");
);
}
print("");
quit;

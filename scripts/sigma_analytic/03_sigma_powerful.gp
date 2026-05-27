default(parisize,700000000);
default(parisizemax,1000000000);
\\ Step 2. Reduce sigma-bound to the POWERFUL PART of the product.
\\
\\ Setup: a=m^2-n^2, b=2mn, gcd(m,n)=1, m+n odd. (a,b) is a primitive Pythagorean
\\ leg pair: gcd(a,b)=1. Minimal model E:Y^2=X(X+b^2)(X+a^2), all reduction
\\ multiplicative, Delta_min = 2^{4 v2(b)-8} a^4 (oddpart b)^4 (a^2-b^2)^2,
\\ N = rad(a b (a^2-b^2))  (factor 2 dropped iff v2(b)=2).
\\
\\ Let P = a*b*(a^2-b^2) = abs(product of 6 forms)*2 (the 2 from b=2mn).
\\ For an integer K, write K = sqfree(K) * pow(K) where pow(K) is the POWERFUL PART:
\\   factor K = prod p^{e_p}; pow(K) = prod_{e_p>=2} p^{e_p}, sqfreepart = prod_{e_p=1} p.
\\ Equivalently rad(K) = prod_{e_p>=1} p, and K/rad(K) measures the powerful excess.
\\
\\ KEY identity for sigma. With c = a^2-b^2:
\\   log|Delta_min| = 4 log a + 4 log b + 2 log|c| - 8 log 2
\\   log N          = log rad(a) + log rad(b) + log rad(|c|) - [v2(b)==2]*log2   (forms coprime)
\\ Define the "powerful-deficiency" exponent. We have, with full radical R=rad(a*b*c):
\\   sigma = log|Delta_min| / log R'      (R' = N).
\\
\\ Claim to verify: sigma <= sigma0  <==>  the powerful part of a*b*c is small, precisely:
\\   sigma = [4 log a + 4 log b + 2 log c - 8 log2] / log N.
\\ Write log a = log rad(a) + log(a/rad a), etc. Then numerator
\\   = 2(2 log rad a + log rad b... ) -- messy; instead define the EXCESS.
\\
\\ Cleanest statement (verify numerically): let
\\   D = log|Delta_min|,  L = log N.  sigma = D/L.
\\   Also Plain = 2 log a + 2 log b + 2 log|c| (= 2 log(abc), since each appears squared-ish).
\\   Actually D = 4 log a + 4 log b + 2 log c - 8log2.
\\ The "would-be sigma if everything squarefree" baseline: if a,b,c all squarefree,
\\   N ~ a*b*c and D = 4 log a + 4 log b + 2 log c. Then sigma_sqfree ~ (4 log a+4 log b+2 log c)/log(abc).
\\ Range: log c = log(a^2-b^2) ~ 2 log a (since c~a^2 when b<a... but here b can exceed a).
\\
\\ Operationally we VERIFY: sigma is LARGE exactly when rad(a*b*c) << a*b*c, i.e. when the
\\ product is POWERFUL. We compute kappa = log(abc)/log rad(abc) (the "powerfulness ratio")
\\ and show sigma tracks it. And we attribute the powerful part to the SIX forms.

powerfulpart(K) = {  \\ returns the powerful part: prod p^e over e>=2
  my(f=factor(abs(K)), res=1);
  for(i=1,#f~, if(f[i,2]>=2, res *= f[i,1]^f[i,2]));
  res;
};
radK(K) = factorback(factor(abs(K))[,1]);

sigmastats(m,n) = {
  my(a=m^2-n^2, b=2*m*n, c=a^2-b^2);
  my(v2b=valuation(b,2));
  my(D = 4*log(abs(a)) + 4*log(abs(b)) + 2*log(abs(c)) - 8*log(2));
  my(N = radK(a)*radK(b)*radK(c));   \\ forms coprime so rad multiplies
  if(v2b==2, N = N/2);               \\ 2 is good when v2(b)=2
  my(L = log(N));
  my(sig = D/L);
  my(P = abs(a*b*c));
  my(kappa = log(P)/log(radK(P)));   \\ powerfulness of the product
  [sig, kappa, v2b, P, powerfulpart(P)];
};

\\ Cross-check sig against PARI ellminimalmodel for a handful, incl (256,121).
check(m,n) = {
  my(a=m^2-n^2,b=2*m*n);
  my(E=ellminimalmodel(ellinit([0, a^2+b^2, 0, a^2*b^2, 0])));
  my(Dmin=abs(E.disc), Nc=ellglobalred(E)[1]);
  [log(Dmin)/log(Nc), Dmin, Nc];
};

print("=== Verify analytic sigma formula vs PARI ellminimalmodel ===");
testfibers = [[4,3],[11,2],[16,3],[18,7],[256,121],[2,1],[64,9],[32,9]];
for(i=1,#testfibers,
  my(mn=testfibers[i], s=sigmastats(mn[1],mn[2]), ch=check(mn[1],mn[2]));
  printf("(m,n)=(%d,%d): sigma_formula=%.6f  sigma_PARI=%.6f  diff=%.2e  kappa(powerfulness)=%.4f  v2(b)=%d\n",
    mn[1],mn[2], s[1], ch[1], abs(s[1]-ch[1]), s[2], s[3]);
);
print();

\\ Now the reduction: sigma vs kappa scatter over a range; the powerful part attributed to forms.
print("=== sigma vs powerfulness kappa=log(abc)/log rad(abc) ; high-sigma fibers ===");
print("(showing fibers with sigma>3.8, m<=400)");
{
for(m=2,400,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(s=sigmastats(m,n));
      if(s[1]>3.8,
        my(a=m^2-n^2,b=2*m*n,c=a^2-b^2);
        \\ which forms carry the powerful part?
        my(F=[m,n,m-n,m+n,m^2-2*m*n-n^2,m^2+2*m*n-n^2]);
        my(pw = vector(6, i, powerfulpart(F[i])));
        printf("(%d,%d) sigma=%.4f kappa=%.4f v2b=%d | powerful parts of [m,n,m-n,m+n,F5,F6]=%s\n",
          m,n,s[1],s[2],s[3], Str(pw));
      );
    );
  );
);
}

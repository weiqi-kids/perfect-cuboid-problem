/* Paper P4 -- script 04  (PARI/GP 2.15.4)
   (a) Separability of the degree-8 form F = ab(a^2-b^2) = m n (m-n)(m+n)(m^4-6m^2n^2+n^4),
       its factorization over Q and splitting over Q(sqrt2).
   (b) The sigma-large locus lies in the six-factor powerful union: empirical check that
       sigma>4 forces a powerful value of one of m, n, m-n, m+n,
       F5=(m-n)^2-2n^2, F6=(m+n)^2-2n^2 (or a high-v2(b) layer).
   (c) Empirical powerful-part exponent theta=logPow(P)/logP -> 0 (density-1 sieve signal),
       and residual {sigma>4} decay ~ H^{-1}. */
default(parisize, 8*10^8);
default(parisizemax, 1200000000);

print("=== (a) form structure: F = m*n*(m-n)*(m+n)*(m^4-6m^2n^2+n^4) ===");
{
  my(t='t);
  /* dehomogenise n=1: F(t,1) up to the constant 2 */
  my(F = t*(t^2-1)*(t^4-6*t^2+1));   /* = m(m-n)(m+n)(quartic) with n=1, drop n factor */
  my(Ffull = 't*F);                   /* include the n=t? we test the 5 irreducible pieces directly */
  print("  factor of m^4-6m^2n^2+n^4 over Q (n=1): ", factor(t^4-6*t^2+1));
  /* separability: the full binary form has 5 distinct irreducible factors */
  my(G = (t^4-6*t^2+1));
  print("  gcd(quartic, quartic') = ", gcd(G, G'), "  (const => squarefree)");
  /* splits over Q(sqrt2): adjoin w=sqrt2 */
  my(nf = nfinit(w^2-2));
  print("  m^4-6m^2n^2+n^4 over Q(sqrt2): ", nffactor(nf, t^4-6*t^2+1));
  print("  => quartic is REDUCIBLE over Q as (t^2-2t-1)(t^2+2t-1) = F5*F6;");
  print("     its further splitting into LINEAR factors needs Q(sqrt2).");
  print("  Six distinct factors m, n, m-n, m+n, F5, F6 => F separable of degree 8.");
}

print("");
print("=== (b) sigma-large locus is contained in the SIX-factor powerful union ===");
rad(n) = factorback(factor(abs(n))[,1]);
condN(a,b,c) = { my(R=rad(a*b*c)); if(valuation(b,2)==2, R/=2); R; }
sig(m,n) = { my(a=m^2-n^2,b=2*m*n,c=a^2-b^2);
  (4*log(a*1.0)+4*log(b*1.0)+2*log(abs(c)*1.0)-8*log(2.0))/log(condN(a,b,c)*1.0); }
sqfull(x) = abs(x)/rad(x) > 1;   /* nontrivial powerful (squarefull) part */
{
  my(MM=700, big=0, hasPowAny=0, byQuad=0, byLin=0, byV2=0);
  for(m=2,MM,
    for(n=1,m-1,
      if(gcd(m,n)!=1 || (m+n)%2==0, next);
      if(sig(m,n) <= 4.0, next);
      big++;
      my(F5=(m-n)^2-2*n^2, F6=(m+n)^2-2*n^2, b=2*m*n);
      my(q = (sqfull(F5) || sqfull(F6)));            /* quadratic factor powerful */
      my(l = (sqfull(m) || sqfull(n) || sqfull(m-n) || sqfull(m+n))); /* linear powerful */
      my(v = (valuation(b,2) >= 4));                 /* high 2-adic layer */
      if(q, byQuad++);
      if(l, byLin++);
      if(v, byV2++);
      if(q || l || v, hasPowAny++);
    );
  );
  print("  fibers with sigma>4 (m<=", MM, ") = ", big);
  print("  ... in six-factor powerful union (incl. v2) = ", hasPowAny, " / ", big);
  print("  ... with a quadratic (F5/F6) powerful value  = ", byQuad);
  print("  ... with a linear (m,n,m-n,m+n) powerful value = ", byLin);
  print("  ... with high v2(b)>=4                        = ", byV2);
  /* witness: (125,44) is driven by LINEAR factors, F5,F6 both squarefree */
  my(m=125,n=44,F5=(m-n)^2-2*n^2,F6=(m+n)^2-2*n^2);
  print("  witness (125,44): sigma=", sig(m,n), "  m-n=", m-n, "=3^4  m+n=", m+n, "=13^2");
  print("    F5=", F5, " squarefree? ", !sqfull(F5), "   F6=", F6, " squarefree? ", !sqfull(F6));
}

print("");
print("=== (c) powerful-part exponent theta and {sigma>4} decay ===");
{
  foreach([100,200,400,700], MM,
    my(cnt=0, gt4=0, thetale=0);
    for(m=2,MM,
      for(n=1,m-1,
        if(gcd(m,n)!=1 || (m+n)%2==0, next);
        cnt++;
        if(sig(m,n)>4.0, gt4++);
        my(a=m^2-n^2,b=2*m*n,c=a^2-b^2,P=abs(a*b*c));
        my(Pow=P/rad(P));   /* squarefull part (>=1); log ratio */
        my(theta = if(Pow<=1,0.0, log(Pow*1.0)/log(P*1.0)));
        if(theta<=0.10, thetale++);
      );
    );
    print("  MMAX=", MM, "  frac{sigma>4}=", gt4*1.0/cnt, "   density{theta<=0.10}=", thetale*1.0/cnt);
  );
}
print("EXIT=ok");

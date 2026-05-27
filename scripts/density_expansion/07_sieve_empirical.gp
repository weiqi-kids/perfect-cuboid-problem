default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 07_sieve_empirical.gp -- EMPIRICAL confirmation of the sieve bound on powerful values.
\\ The 6 coprime forms: 2, mn, (m-n)(m+n)[=a up to sign factors], and the two quartic factors
\\   F1=m^2-2mn-n^2,  F2=m^2+2mn-n^2  (whose product is a^2-b^2 up to ...).
\\ Actually P = a*b*(a^2-b^2) = (m^2-n^2)*(2mn)*(m^4-6m^2n^2+n^4)
\\           = 2 * mn * (m-n)(m+n) * (m^2-2mn-n^2)(m^2+2mn-n^2).
\\ This is a product of binary forms of total degree 1+1+1+1+2+2 = 8 (the deg-8 form ab(a^2-b^2)).
\\
\\ SIEVE CLAIM: #{(m,n) in [1,H]^2 coprime, m+n odd : Pow(P(m,n)) > H^eta } = o(H^2) for any eta>0,
\\   in fact O(H^{2-delta(eta)}).  Equivalently the powerful-part EXPONENT theta=logPow/logP -> 0
\\   on a density-1 set.  Verify: tail count of large-theta fibers as H grows.
\\ ============================================================================
powpart(x)={my(f=factor(abs(x)),r=1); for(i=1,#f~, if(f[i,2]>=2, r*=f[i,1]^f[i,2])); r};

\\ For each H, count fibers with Pow(P) > H^eta, for several eta. Track FRACTION (-> 0).
print("=== Fraction of fibers with Pow(P) > H^eta  (should -> 0 as H grows) ===");
print("    P = ab(a^2-b^2), deg-8 form.  eta in {0.5, 1.0, 2.0}.");
run(H)=
{
  my(cnt=0);
  my(etas=[0.5,1.0,2.0], ne=3);
  my(big=vector(ne,i,0));
  my(logH=log(H*1.0));
  for(m=2,H,
    for(n=1,m-1,
      if(gcd(m,n)==1 && (m+n)%2==1,
        my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2),P=a*b*c);
        cnt++;
        my(pw=powpart(P), lpw=log(pw*1.0));
        for(j=1,ne, if(lpw > etas[j]*logH, big[j]++));
      )
    )
  );
  print("  H=",H,"  fibers=",cnt,":");
  for(j=1,ne, print("     frac{Pow(P)>H^",etas[j],"} = ",big[j]*1.0/cnt,"   (count ",big[j],")"));
}
run(100);
run(200);
run(400);
run(700);
print("");
\\ Also: the per-form powerful parts. The deg-8 form factors into coprime pieces; each
\\ contributes O(H^{2-delta}) large-powerful exceptions. Confirm the dominant form is the
\\ deg-2 factors (m^2 +- 2mn - n^2), whose square-divisibility is the binding constraint.
print("=== which factor carries the powerful part most often? (m<=400) ===");
{
  my(MMAX=400, cnt=0);
  my(win=vector(6,i,0)); \\ which of [2, mn-form? , (m-n), (m+n), F1, F2] dominates Pow
  my(names=["2","mn","m-n","m+n","m^2-2mn-n^2","m^2+2mn-n^2"]);
  for(m=2,MMAX,
    for(n=1,m-1,
      if(gcd(m,n)==1 && (m+n)%2==1,
        cnt++;
        my(facs=[2, m*n, abs(m-n), m+n, abs(m^2-2*m*n-n^2), abs(m^2+2*m*n-n^2)]);
        my(pws=vector(6,k,powpart(facs[k])));
        my(mx=0,mi=0); for(k=1,6, if(pws[k]>mx, mx=pws[k]; mi=k));
        if(mx>1, win[mi]++);
      )
    )
  );
  print("  fibers=",cnt,"  (count where each factor carries the LARGEST powerful part, when >1):");
  for(k=1,6, print("     ",names[k]," : ",win[k]," (",win[k]*1.0/cnt,")"));
}
print("EXIT=ok");
quit;

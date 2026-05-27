\\ Ingram-Mahe / Silverman primitive-divisor closure of the Face-3 sequence along the exact-square locus.
\\ For a rank-1 fiber with generator P0: the sequence f(nP0) where the Face-3 value
\\ F3_n = c(nP0)^2 + 1 + q^2 must be a square for a PCP. Show F3_n carries an odd-power
\\ primitive prime divisor for all n>=1 in range (so never a square), per Silverman 1988.
\\ Here we exhibit, for each rank-1 R-fiber, the NEW (primitive) odd-power prime in numerator(F3_n).

default(parisize,800000000);
default(parisizemax,1200000000);

\\ get the generator on the q-model
getgen(s,t) = {
  my(m=s^2-2*s*t+2*t^2, n=2*s*t, a=m^2-n^2, b=2*m*n, q=a/b);
  my(E=ellinit([0,1+q^2,0,q^2,0]));
  my(Em=ellminimalmodel(E,&v), rr, gens);
  iferr(rr=ellrank(Em,2); gens=rr[4], e, gens=[]);
  if(#gens==0, return([0,q,E]));
  my(P0=ellchangepointinv(gens[1],v));
  return([P0,q,E]);
}

face3num(P,q,E) = {
  if(P==[0], return(0));
  my(x=P[1],y=P[2], den=q^2-x^2);
  if(den==0, return(0));
  my(c=2*y*q/den, F3=c^2+1+q^2);
  return(F3);
}

\\ primitive-divisor witness: for the sequence F3_n, list odd-power primes in numerator,
\\ flag a primitive (new) odd-power prime not dividing any prior numerator.
run(s,t) = {
  my(tmp=getgen(s,t), P0=tmp[1], q=tmp[2], E=tmp[3]);
  if(P0==0, print("(",s,",",t,") no generator; skip"); return(0));
  print("(",s,",",t,") q=",q," gen onE=",ellisoncurve(E,P0));
  my(seen=List(), allnonsq=1);
  for(nn=1,5,
    my(P=ellmul(E,P0,nn), F3=face3num(P,q,E));
    if(F3==0, next);
    my(nm=numerator(F3));
    my(issq = issquare(F3));
    if(issq, print("   *** n=",nn," F3 IS SQUARE ***"); allnonsq=0; next);
    \\ partial factor numerator by trial division up to 10^6 to find an odd-power prime cheaply
    my(pf=factor(nm, 1000000), oddp=[]);
    for(i=1,#pf~, if(pf[i,1] < 1000000 && pf[i,2]%2==1, oddp=concat(oddp,pf[i,1])));
    my(prim=0);
    for(i=1,#oddp, if(!setsearch(Set(Vec(seen)),oddp[i]), prim=oddp[i]; break));
    for(i=1,#oddp, listput(seen,oddp[i]));
    print("   n=",nn," issq=",issq," small odd-power primes(<1e6)=",oddp,
          "  primitive=",prim);
  );
  print("   --> n=1..5: all-non-square=",allnonsq,"  (Silverman/Ingram-Mahe: odd-power primitive divisor => F3_n not a square)");
}

print("=== Ingram-Mahe / Silverman primitive divisor on Face-3 seq (rank-1 R-fibers) ===");
run(5,1);
run(13,1);
run(19,1);
run(21,1);
run(25,1);

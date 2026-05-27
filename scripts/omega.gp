default(parisize,1000000000);
\\ Number of distinct bad primes R = omega(N) over the family. Is it bounded? (relevant to Silverman R-places result)
maxR=0; mnR=[0,0]; sumR=0; cnt=0;
{
for(m=2,80,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(q=(m^2-n^2)/(2*m*n));
      my(E=ellminimalmodel(ellinit([0,1+q^2,0,q^2,0])));
      my(N=ellglobalred(E)[1], R=omega(N));
      cnt++; sumR+=R;
      if(R>maxR, maxR=R; mnR=[m,n]);
    );
  );
);
}
print("omega(N) = # distinct bad primes (= # non-integral-j places R):");
print("  max R = ", maxR, " at (m,n)=", mnR, "   mean R = ", sumR*1.0/cnt, "   (m<=80)");
print("=> R grows with m (NOT bounded over family). Silverman R-places result gives unconditional");
print("   closure only on the SUB-LOCUS with omega(N) <= R0 (bounded # bad primes).");

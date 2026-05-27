default(parisize,700000000);
default(parisizemax,1000000000);
\\ Step 4 (refine). Local log-log slope of N(H,sigma0) between consecutive H,
\\ pushed to H=1500. Also decompose: of the sigma>sigma0 fibers, how many have a
\\ quadratic form F5/F6 with powerful part >= F^{1/2} (i.e. 'near-square' Pell layer)?
\\ This ties the sparse set to the quadratic-form-square locus.

radK(K) = factorback(factor(abs(K))[,1]);
powerfulpart(K) = {my(f=factor(abs(K)),r=1);for(i=1,#f~,if(f[i,2]>=2,r*=f[i,1]^f[i,2]));r;};
sigformula(mm,nn) = {
  my(a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2, v2b=valuation(b,2));
  my(D = 4*log(abs(a)) + 4*log(abs(b)) + 2*log(abs(c)) - 8*log(2));
  my(N = radK(a)*radK(b)*radK(c)); if(v2b==2, N=N/2);
  D/log(N);
};

Hladder = [100,200,400,800,1500];
s0 = 3.5;       \\ primary threshold with enough data for a slope
Hmax = Hladder[#Hladder];
counts = vector(#Hladder);
\\ also count, among sigma>s0 fibers, those whose quadratic form is 'near-square'
\\ (powerfulpart(F5) >= sqrt|F5| OR powerfulpart(F6) >= sqrt|F6|)
nearsq = vector(#Hladder);
counts4 = vector(#Hladder);  \\ sigma>4

{
for(m=2,Hmax,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(hs=0); for(h=1,#Hladder, if(Hladder[h]>=m, hs=h; break));
      if(hs>0,
        my(sg=sigformula(m,n));
        if(sg>s0,
          for(h=hs,#Hladder, counts[h]++);
          my(F5=m^2-2*m*n-n^2, F6=m^2+2*m*n-n^2);
          my(near = (powerfulpart(F5) >= sqrt(abs(F5))) || (powerfulpart(F6) >= sqrt(abs(F6))));
          if(near, for(h=hs,#Hladder, nearsq[h]++));
        );
        if(sg>4.0, for(h=hs,#Hladder, counts4[h]++));
      );
    );
  );
);
}
print("=== N(H, 3.5) ladder + local log-log slope ===");
print("H       N(s>3.5)   slope[log N/log H, local]   N(s>4.0)   near-square-form frac (of s>3.5)");
{
for(h=1,#Hladder,
  my(sl = if(h>1, (log(counts[h])-log(counts[h-1]))/(log(Hladder[h])-log(Hladder[h-1])), 0.0));
  printf("%-7d %-9d  %.4f                      %-8d   %.4f\n",
    Hladder[h], counts[h], sl, counts4[h], nearsq[h]*1.0/counts[h]);
);
}
print();
print("Local slope = exponent theta in N ~ H^theta over [H_{i-1}, H_i].");
print("near-square-form frac = fraction of sigma>3.5 fibers where F5 or F6 has");
print("  powerful part >= sqrt(|form|)  (i.e. on a high layer of the Pell conic X^2-2n^2=k).");

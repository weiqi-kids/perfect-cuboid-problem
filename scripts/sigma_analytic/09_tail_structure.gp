default(parisize,700000000);
default(parisizemax,1000000000);
\\ Step 4 (tail). At the EXTREME thresholds (sigma>4, >4.25, >4.5), what fraction of
\\ fibers have a quadratic form F5/F6 that is near-square (powerful part >= sqrt|F|)?
\\ Hypothesis: the extreme tail is DOMINATED by the quadratic-form-square Pell locus.
\\ Also: among sigma>4 fibers, tabulate the MAX form-powerfulness and the 2-power v2(b).

radK(K) = factorback(factor(abs(K))[,1]);
powerfulpart(K) = {my(f=factor(abs(K)),r=1);for(i=1,#f~,if(f[i,2]>=2,r*=f[i,1]^f[i,2]));r;};
sigformula(mm,nn) = {
  my(a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2, v2b=valuation(b,2));
  my(D = 4*log(abs(a)) + 4*log(abs(b)) + 2*log(abs(c)) - 8*log(2));
  my(N = radK(a)*radK(b)*radK(c)); if(v2b==2, N=N/2);
  D/log(N);
};

Hmax = 1200;
\\ For each threshold, collect fibers and classify.
thrs = [4.0, 4.25, 4.5];
\\ counts: total per threshold; nearsq: F5/F6 near-square; sqexact: F5 or F6 exact square
tot=vector(3); nearq=vector(3); sqex=vector(3); hi2=vector(3);
recs=List();
{
for(m=2,Hmax,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(sg=sigformula(m,n));
      if(sg>4.0,
        my(F5=m^2-2*m*n-n^2, F6=m^2+2*m*n-n^2, b=2*m*n, v2b=valuation(b,2));
        my(p5=powerfulpart(F5), p6=powerfulpart(F6));
        my(near = (p5>=sqrt(abs(F5))) || (p6>=sqrt(abs(F6))));
        my(exq = issquare(abs(F5)) || issquare(abs(F6)));
        for(k=1,3,
          if(sg>thrs[k],
            tot[k]++;
            if(near, nearq[k]++);
            if(exq, sqex[k]++);
          );
        );
        if(sg>4.3, listput(recs, [sg, m, n, F5, F6, v2b, max(p5,p6)]));
      );
    );
  );
);
}
print("=== Extreme tail structure (m<=", Hmax, ") ===");
print("threshold   #fibers   near-square-form%   exact-square-form%");
{
for(k=1,3,
  if(tot[k]>0,
    printf("sigma>%.2f    %-7d   %.1f%%               %.1f%%\n",
      thrs[k], tot[k], 100.0*nearq[k]/tot[k], 100.0*sqex[k]/tot[k]);
  , printf("sigma>%.2f    0\n", thrs[k]));
);
}
print();
print("=== All fibers sigma>4.3 (m<=", Hmax, ") with form anatomy ===");
recs=vecsort(Vec(recs),1,4);
{
for(i=1,#recs,
  my(e=recs[i]);
  printf("sigma=%.4f (%d,%d) v2b=%d  F5=%s  F6=%s  maxformpw=%d\n",
    e[1], e[2], e[3], e[6], Str(factor(e[4])), Str(factor(e[5])), e[7]);
);
}

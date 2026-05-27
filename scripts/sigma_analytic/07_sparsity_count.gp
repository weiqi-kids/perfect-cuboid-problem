default(parisize,700000000);
default(parisizemax,1000000000);
\\ Step 4. Sparsity count N(H, sigma0) = #{(m,n): gcd(m,n)=1, m+n odd, 2<=m<=H, 1<=n<m,
\\         sigma(E_q) > sigma0}.  Total Pythagorean fibers up to H ~ (3/pi^2) H^2.
\\ We compute N(H,sigma0) for sigma0 in {3.5, 4, 4.5} at a ladder of H and fit the
\\ growth exponent: log N(H) / log H -> exponent.

radK(K) = factorback(factor(abs(K))[,1]);
sigformula(mm,nn) = {
  my(a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2, v2b=valuation(b,2));
  my(D = 4*log(abs(a)) + 4*log(abs(b)) + 2*log(abs(c)) - 8*log(2));
  my(N = radK(a)*radK(b)*radK(c)); if(v2b==2, N=N/2);
  D/log(N);
};

Hladder = [50,100,150,200,300,400,500,700,1000];
s0list = [3.5, 4.0, 4.5];
\\ cumulative counts: counts[h][k] = N(H=Hladder[h], sigma0=s0list[k])
nH = #Hladder; nS = #s0list;
\\ We do a single pass to Hmax, tallying into the smallest H-bucket that contains m,
\\ then cumulate. Actually cumulative over H means N(H) counts all m<=H. So tally per m,
\\ accumulate.
counts = matrix(nH, nS);   \\ counts[h,k]
total  = vector(nH);       \\ total primitive fibers up to Hladder[h]
Hmax = Hladder[nH];

\\ running tallies indexed by sigma threshold; we add a fiber to all H>=m and all s0<sigma.
\\ Implementation: for each fiber (m,n), find its sigma; for each k with s0list[k]<sigma,
\\ increment counts[h,k] for all h with Hladder[h]>=m. Same for total.
{
for(m=2,Hmax,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      \\ which H-buckets include this m?
      my(hstart=0);
      for(h=1,nH, if(Hladder[h]>=m, hstart=h; break));
      if(hstart>0,
        for(h=hstart,nH, total[h]++);
        my(sg=sigformula(m,n));
        for(k=1,nS,
          if(sg>s0list[k],
            for(h=hstart,nH, counts[h,k]++);
          );
        );
      );
    );
  );
);
}

print("=== Sparsity count N(H, sigma0) ===");
print("H      total_fibers   N(s>3.5)  N(s>4.0)  N(s>4.5)");
{
for(h=1,nH,
  printf("%-6d %-13d  %-8d  %-8d  %-8d\n", Hladder[h], total[h],
    counts[h,1], counts[h,2], counts[h,3]);
);
}
print();
print("=== Growth exponent  log N(H,s0)/log H  (and log N / log(H^2) = fraction-of-density exponent) ===");
print("sigma0   H        N        log N/log H    N/total      log(N)/log(total)");
{
for(k=1,nS,
  for(h=1,nH,
    my(N=counts[h,k], H=Hladder[h], T=total[h]);
    if(N>0,
      printf("%.1f      %-6d   %-6d   %.4f          %.5f      %.4f\n",
        s0list[k], H, N, log(N)/log(H), N*1.0/T, log(N)/log(T));
    );
  );
  print();
);
}
print("NOTE: total ~ (3/pi^2) H^2 = ", 3.0/Pi^2, " * H^2  (primitive, m+n odd density).");
print("If N(H,s0) ~ H^theta then log N/log H -> theta. theta<2 => sparse (density 0).");
print("Compare theta against 1 (=O(H^{1+eps}), the Pell/powerful-values prediction).");

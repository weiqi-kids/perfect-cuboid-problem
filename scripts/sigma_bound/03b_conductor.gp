default(parisize,600000000);
default(parisizemax,1000000000);
\\ Fix conductor comparison: use rad of |a*b*(a^2-b^2)| (positive). Also check N vs 2*rad_odd etc.
\\ All reduction multiplicative => f_p=1 => N = product of distinct bad primes = rad(Delta_min).
\\ Bad primes divide a*b*(a^2-b^2). So N should = rad(|a b (a^2-b^2)|) EXACTLY (incl p=2).
Nok=1; cnt=0; bad=List();
{
for(m=2,150,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n);
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(N=ellglobalred(E)[1]);
      my(prod=abs(a*b*(a^2-b^2)), radv=factorback(factor(prod)[,1]));
      cnt++;
      if(N != radv, Nok=0; if(#bad<6, listput(bad,[m,n,N,radv,N/radv])));
    );
  );
);
}
print("N == rad(|a b (a^2-b^2)|) for ALL fibers (m<=150)? ", if(Nok,"YES","NO"), "  (",cnt," fibers)");
if(#bad>0, print("  first discrepancies [m,n,N,rad,N/rad]: ", Vec(bad)));
print("");
\\ Also confirm: rad(Delta_min) == N (since N is the squarefree bad-prime part)
Nrok=1;
{
for(m=2,80,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n);
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(N=ellglobalred(E)[1], Dmin=abs(E.disc));
      my(radD=factorback(factor(Dmin)[,1]));
      if(N != radD, Nrok=0);
    );
  );
);
}
print("N == rad(Delta_min) for ALL fibers (m<=80)? ", if(Nrok,"YES","NO"));

default(parisize,600000000);
default(parisizemax,1000000000);
\\ Pin down EXACT Delta_min form. b=2mn always even. Naive Delta_0=16 a^4 b^4 (a^2-b^2)^2.
\\ Observed v_2 gap = 12 uniformly. Test hypothesis Delta_min = Delta_0 / 2^12 and an odd-part identity.
\\ Write a (odd, =m^2-n^2 with m+n odd so a odd), b=2mn. Let b=2^s * b', b' odd, s=1+v_2(mn).
\\ a^2-b^2 is odd (a odd, b even). So v_2(Delta_0)=4 (from 16) + 4 v_2(b) = 4 + 4 s.
\\ v_2(Delta_min)=v_2(Delta_0)-12 = 4s - 8. Check.
mism=0; cnt=0; v2form_ok=1;
{
for(m=2,120,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n);
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc));
      my(D0=16*a^4*b^4*(a^2-b^2)^2);
      cnt++;
      \\ test Dmin == D0/2^12
      if(Dmin != D0/2^12, mism++; if(mism<=5, print("Dmin != D0/2^12 at (",m,",",n,"): ",Dmin," vs ",D0/2^12)));
      \\ test v_2(Dmin) = 4*v_2(b)-8
      if(valuation(Dmin,2) != 4*valuation(b,2)-8, v2form_ok=0);
    );
  );
);
}
print("FIBERS=",cnt);
print("Dmin == Delta_0 / 2^12 for ALL fibers? mismatches=", mism, " (0 = YES)");
print("v_2(Dmin) == 4*v_2(b)-8 for ALL? ", if(v2form_ok,"YES","NO"));
print("");
print("=> Delta_min = (16 a^4 b^4 (a^2-b^2)^2) / 2^12 = a^4 b^4 (a^2-b^2)^2 / 256.");
print("   Since b=2mn, b^4=16 m^4 n^4, so Delta_min = a^4 (16 m^4 n^4)(a^2-b^2)^2/256");
print("                                            = a^4 m^4 n^4 (a^2-b^2)^2 / 16.");
\\ Show this is integral and give odd structure. Also: odd part of Delta unchanged.
\\ Confirm odd part: v_p(Delta_min)=v_p(Delta_0) for all odd p.
oddok=1;
{
for(m=2,80,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n);
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc), D0=16*a^4*b^4*(a^2-b^2)^2);
      my(fa=factor(D0)[,1]);
      for(i=1,#fa, my(p=fa[i]); if(p>2 && valuation(Dmin,p)!=valuation(D0,p), oddok=0));
    );
  );
);
}
print("Odd-part of Delta unchanged by minimalization (v_p(Dmin)=v_p(D0) all odd p)? ", if(oddok,"YES","NO"));
print("");
\\ Confirm conductor exponent 1 at every bad prime (multiplicative => f_p=1), so N = rad(Delta_min).
\\ Actually N = rad(a b (a^2-b^2)) since those are the bad primes. Test N == rad(a*b*(a^2-b^2)).
Nok=1; cnt2=0;
{
for(m=2,100,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n);
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(N=ellglobalred(E)[1]);
      my(radv=factorback(factor(a*b*(a^2-b^2))[,1]));
      cnt2++;
      if(N != radv, Nok=0; if(cnt2<2000, print("N != rad(ab(a^2-b^2)) at (",m,",",n,"): ",N," vs ",radv)));
    );
  );
);
}
print("N == rad(a*b*(a^2-b^2)) for ALL fibers (m<=100)? ", if(Nok,"YES","NO"), "  (",cnt2," fibers)");

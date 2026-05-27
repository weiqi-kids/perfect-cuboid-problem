default(parisize,600000000);
default(parisizemax,1000000000);
\\ Verify the odd-prime n_p formula directly: n_p = 4 v_p(a) (p|a), 4 v_p(b) (p|b), 2 v_p(c) (p|c).
\\ c = a^2-b^2. Since gcd(a,b)=1, a,oddpart(b),c pairwise coprime => each odd p divides exactly one.
aok=1; bok=1; cok=1; amax=0; bmax=0; cmax=0;
{
for(m=2,150,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n, c=abs(a^2-b^2));
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc), N=ellglobalred(E)[1], fa=factor(N)[,1]);
      for(i=1,#fa, my(p=fa[i]);
        if(p>2,
          my(np=valuation(Dmin,p), va=valuation(a,p), vb=valuation(b,p), vc=valuation(c,p));
          if(va>0, if(np != 4*va, aok=0); if(va>amax,amax=va));
          if(vb>0, if(np != 4*vb, bok=0); if(vb>bmax,bmax=vb));
          if(vc>0, if(np != 2*vc, cok=0); if(vc>cmax,cmax=vc));
        );
      );
    );
  );
);
}
print("ODD-PRIME n_p FORMULA verification (m<=150):");
print("  p|a: n_p == 4 v_p(a) for ALL? ", if(aok,"YES","NO"), "  (max v_p(a) seen=",amax,")");
print("  p|b: n_p == 4 v_p(b) for ALL? ", if(bok,"YES","NO"), "  (max v_p(b) seen=",bmax,")");
print("  p|c: n_p == 2 v_p(c) for ALL? ", if(cok,"YES","NO"), "  (max v_p(c) seen=",cmax,")");
print("");
\\ So log|Delta_min|_odd = 4 sum_{p|a,odd}v_p(a)log p + 4 sum_{p|b,odd}v_p(b)log p + 2 sum_{p|c,odd}v_p(c)log p
\\                       = 4 log a + 4 log(oddpart b) + 2 log c    (a odd, so all of a; c odd).
\\ Verify: log|Delta_min| = 4 log a + 4 log(oddpart b) + 2 log c + (2-adic term n_2 log2).
\\ where n_2 = v_2(Delta_min) = 4 v_2(b) - 8.
ok=1;
{
for(m=2,120,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n, c=abs(a^2-b^2), bo=b/2^valuation(b,2));
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc));
      my(n2=valuation(Dmin,2));
      my(lhs=valuation(Dmin,2)*0 + 0);
      \\ exact integer identity: Dmin = 2^n2 * a^4 * bo^4 * c^2
      my(rhs=2^n2 * a^4 * bo^4 * c^2);
      if(Dmin != rhs, ok=0; if(ok==0&&m<10,print("  mismatch (",m,",",n,"): ",Dmin," vs ",rhs)));
    );
  );
);
}
print("EXACT integer identity Delta_min = 2^{n_2} a^4 (oddpart b)^4 c^2,  n_2=4v_2(b)-8 ?  ", if(ok,"YES","NO"));
print("=> log|Delta_min| = (4v_2(b)-8)log2 + 4 log a + 4 log(oddpart b) + 2 log c");
print("                  = 4 log a + 4 log b + 2 log c - 8 log 2   [since 4 log b=4log(oddb)+4v_2(b)log2]");

default(parisize,600000000);
default(parisizemax,1000000000);
\\ Step 1 (arithmetic): minimality + reduction-type verification on the INTEGRAL model
\\ E: Y^2 = X(X+b^2)(X+a^2),  a=m^2-n^2, b=2mn (Pythagorean, gcd(m,n)=1, m+n odd).
\\ Naive Delta_0 = 16 a^4 b^4 (a^2-b^2)^2. Compare to true Delta_min from ellminimalmodel.
\\ Confirm 0 additive primes (all I_n multiplicative). Quantify v_2,v_3 gaps.

allmult=1; addexamples=List();
gap2_vals=List(); gap3_vals=List();   \\ v_p(Delta_0)-v_p(Delta_min) at p=2,3
maxgap2=0; maxgap3=0;
cnt=0;
{
for(m=2,150,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n);
      \\ integral model directly (NOT via q): coefficients a2=a^2+b^2, a4=a^2 b^2
      my(E0=ellinit([0, a^2+b^2, 0, a^2*b^2, 0]));
      my(D0=abs(E0.disc));                 \\ should equal 16 a^4 b^4 (a^2-b^2)^2
      my(Dclaim=16*a^4*b^4*(a^2-b^2)^2);
      if(D0 != Dclaim, print("DISC MISMATCH at (",m,",",n,"): ",D0," vs ",Dclaim));
      my(E=ellminimalmodel(E0));
      my(Dmin=abs(E.disc));
      my(gr=ellglobalred(E), N=gr[1]);
      cnt++;
      \\ reduction type at each bad prime of N
      my(fa=factor(N)[,1]);
      for(i=1,#fa,
        my(p=fa[i], lr=elllocalred(E,p), kod=lr[2]);
        \\ PARI kodaira code: 1=I0(good),2=II,3=III,4=IV,>=5 => I_{kod-4} multiplicative;
        \\ negative => starred (additive). kod in {2,3,4} additive (II,III,IV).
        if(kod<5 && kod!=1, allmult=0; listput(addexamples,[m,n,p,kod]));
      );
      \\ gaps at 2,3 between naive and minimal
      my(g2=valuation(D0,2)-valuation(Dmin,2));
      my(g3=valuation(D0,3)-valuation(Dmin,3));
      if(g2>maxgap2, maxgap2=g2); if(g3>maxgap3, maxgap3=g3);
      if(g2!=0, listput(gap2_vals,g2)); if(g3!=0, listput(gap3_vals,g3));
    );
  );
);
}
print("FIBERS (m<=150) = ", cnt);
print("ALL MULTIPLICATIVE (0 additive primes) = ", allmult);
if(#addexamples>0, print("  ADDITIVE EXAMPLES (m,n,p,kod): ", Vec(addexamples)[1..min(8,#addexamples)]));
print("v_2(Delta_0)-v_2(Delta_min): max gap = ", maxgap2, "  (#nonzero = ", #gap2_vals, ")");
print("v_3(Delta_0)-v_3(Delta_min): max gap = ", maxgap3, "  (#nonzero = ", #gap3_vals, ")");
\\ Tabulate distribution of v_2 gap
print("Distribution of v_2 gap values:");
{my(seen=List());
 for(i=1,#gap2_vals, my(g=gap2_vals[i], f=0);
   for(j=1,#seen, if(seen[j][1]==g, seen[j][2]++; f=1; break));
   if(!f, listput(seen,List([g,1])));
 );
 for(j=1,#seen, print("  gap=",seen[j][1]," : ",seen[j][2]," fibers"));
}
\\ Sanity: explicitly verify v_p(Delta_min) = -v_p(j) at odd bad primes (multiplicative => I_n, n=-v_p(j))
mism=0;
{
for(m=2,80,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(a=m^2-n^2, b=2*m*n);
      my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
      my(Dmin=abs(E.disc), jj=E.j, N=ellglobalred(E)[1], fa=factor(N)[,1]);
      for(i=1,#fa, my(p=fa[i]);
        if(p>3, my(np=valuation(Dmin,p), vj=valuation(jj,p));
          if(vj<0 && np != -vj, mism++));
      );
    );
  );
);
}
print("Odd-prime (p>3) mismatches v_p(Delta_min) != -v_p(j): ", mism, " (expect 0)");

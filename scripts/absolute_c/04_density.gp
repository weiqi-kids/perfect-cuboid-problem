\\ ============================================================================
\\ 04_density.gp -- UNCONDITIONAL-SUBLOCUS DENSITY (§6).
\\ Over Pythagorean fibers q=(m^2-n^2)/(2mn), gcd(m,n)=1, m+n odd, m<=MMAX:
\\   SQUAREFREE locus SF: a, oddpart(b), a^2-b^2 ALL squarefree (=> sigma<=4+o(1)).
\\   omega(N)<=R0 (Gross-Silverman unconditional sub-locus).
\\   UNION SF \cup {omega(N)<=R0}.
\\ ============================================================================
default(parisize,700000000);
default(parisizemax,1200000000);

oddpart(x)= x >> valuation(x,2);

dens(MMAX)=
{
  my(cnt,sfcnt,omegahist,sigmaSFmax,R0list,unioncnt,omleR0,a,b,c,Em,N,om,issf,sig,logD,le,cum);
  cnt=0; sfcnt=0; omegahist=vector(40,i,0); sigmaSFmax=0.0;
  R0list=[6,8,10,12,14]; unioncnt=vector(#R0list,i,0); omleR0=vector(#R0list,i,0);
  for(m=2,MMAX,
    for(n=1,m-1,
      if(gcd(m,n)==1 && (m+n)%2==1,
        a=m^2-n^2; b=2*m*n; c=abs(a^2-b^2);
        Em=ellminimalmodel(ellinit([0,1+(a/b)^2,0,(a/b)^2,0]));
        N=ellglobalred(Em)[1]; om=omega(N); cnt++;
        if(om<=39, omegahist[om+1]++);
        issf = issquarefree(a) && issquarefree(oddpart(b)) && issquarefree(c);
        if(issf, sfcnt++; logD=log(abs(Em.disc)); sig=logD/log(N); if(sig>sigmaSFmax, sigmaSFmax=sig));
        for(j=1,#R0list,
          le = (om<=R0list[j]);
          if(le, omleR0[j]++);
          if(issf || le, unioncnt[j]++)
        )
      )
    )
  );
  print("=== MMAX=",MMAX,"  total Pythagorean fibers = ",cnt," ===");
  print("squarefree-locus count = ",sfcnt,"   density = ",sfcnt*1.0/cnt,"   sup sigma(SF) = ",sigmaSFmax);
  print("omega(N) histogram (R : count : cumfrac<=R):");
  cum=0;
  for(R=0,22, cum+=omegahist[R+1]; print("  ",R," : ",omegahist[R+1]," : ",cum*1.0/cnt));
  print("R0 : frac(omega<=R0) : frac(SF union omega<=R0):");
  for(j=1,#R0list, print("  ",R0list[j]," : ",omleR0[j]*1.0/cnt," : ",unioncnt[j]*1.0/cnt));
  print("");
}

dens(150);
dens(400);
print("EXIT=ok");
quit;
